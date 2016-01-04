<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 - 2016 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Auth;

use System\DependencyInjection\Container;

class Authentication
{
    private $container;
    private $request;
    private $session;

    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    public function onBeforeController($route)
    {
        $this->request = $this->container->get('request');
        $this->session = $this->request->getSession();

        $this->setUserDefault();

        if($this->session->get('user.auth.logged') != 1)
        {
            $route->setModule('Auth')
                ->setController('Authentication')
                ->setAction('loginForm');
        }
        else
        {
            if($this->session->getOwner())
            {
                $this->setUserFromSessionOwner();
            }

            if($this->session->get('user.auth.locked') == 1)
            {
                $route->setModule('Auth')
                    ->setController('Authentication')
                    ->setAction('unlock');
            }
        }
    }

    public function onAfterController()
    {
        $this->setUserDefault();

        if($this->session->get('user.auth.logged') && $this->container->get('user')->getId() === 0)
        {
            $this->setUserFromSessionOwner();
        }
    }

    public function setUserFromSessionOwner()
    {
        $user = $this->container->get('orm')->repository()->get('User', 'User')->find($this->session->getOwner());

        if($user)
        {
            $this->container->set('user', $user);
        }
    }

    public function setUserDefault()
    {
        $user = $this->container->get('orm')->entity()->get('User', 'User');

        $this->container->set('user', $user);
    }
}
