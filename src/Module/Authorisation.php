<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 - 2016 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Auth;

use System\DependencyInjection\Container;

class Authorisation
{
    private $container;

    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    public function onBeforeController($route)
    {
        $annotation = new \CRM\Permission\Controller\Annotation($route->getModule(), $route->getController());

        $details = $annotation->collectDetails($route->getAction());

        $acl = $this->container->get('permission.acl')->open($details['section'], 'mod.'.$route->getModule());

        foreach($details['access'] as $access)
        {
            if($acl->isAllowed($access) === false)
            {
                $route->setModule('Auth')
                    ->setController('Authorisation')
                    ->setAction('notAllowed');

                return false;
            }
        }
    }
}
