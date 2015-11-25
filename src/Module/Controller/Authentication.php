<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Auth\Controller;

use CRM\App\Controller\BaseController;
use CRM\Templating\PhpEngine;

class Authentication extends BaseController
{
    public function loginFormAction($request)
    {
        if($request->isAJAX())
        {
            return $this->responseAJAX([
                'status' => 'error',
                'type'   => 'session-exipre'
            ]);
        }

        if($request->getMethod() === 'POST')
        {
            $result = $this->repo('User', 'User')->findForLogin($request->get('username'), $request->get('password'));

            if($result)
            {
                $request->getSession()
                    ->setOwner($result[0]->getId())
                    ->set('user.auth.logged', 1)
                    ->set('user.auth.locked', 0);

                /**
                 * If user login, we remove old sessions whith his User ID and call
                 * plugins that this Event has occured.
                 */
                $sessions = $this->db()->query("SELECT * FROM #__session WHERE owner = '".$result[0]->getId()."' AND id != '".$request->getSession()->getId()."'");
                $ids = [];

                $this->callPlugins('User', 'sessionsRemovedByOverwrite', [ $sessions ]);

                foreach($sessions as $item)
                {
                    $this->db()->exec("DELETE FROM #__session WHERE id = '{$item['id']}'");
                }


                $this->callPlugins('User', 'login', [ $result[0]->getId() ]);

                if($result[0]->getForcePasswordChange())
                {
                    $this->flash('info', $this->t('userForcePasswordChangeInfo'));
                    return $this->redirect('User', 'User', 'selfEdit', [ 'forcePasswordChange' => 1 ]);
                }
                else
                {
                    $this->flash('success', sprintf($this->t('userWelcome'), $result[0]->getFirstName()));
                }
            }
            else
            {
                $this->flash('danger', $this->t('userBadLoginCredentials'));
            }

            return $this->redirectToUrl($request->getUriForPath('/'));
        }

        return $this->render();
    }

    public function logoutAction($request)
    {
        $this->callPlugins('User', 'logout', [
            $this->user()->getId()
        ]);

        $request->getSession()
            ->setOwner(0)
            ->set('user.auth.logged', 0);

        return $this->redirectToUrl($request->getUriForPath('/'));
    }

    public function lockAction($request)
    {
        $request->getSession()->set('user.auth.locked', 1);

        return $this->redirectToUrl($request->getUriForPath('/'));
    }

    public function unlockAction($request)
    {
        if($request->getMethod() === 'POST')
        {
            $result = $this->repo('User', 'User')->findForLogin($this->user()->getUsername(), $request->get('password'));

            if($result)
            {
                $request->getSession()->set('user.auth.locked', 0);

                $this->flash('success', sprintf($this->t('userWelcomeAgain'), $result[0]->getFirstName()));
            }
            else
            {
                $this->flash('danger', $this->t('userBadPassword'));
            }

            return $this->redirectToUrl($request->getUriForPath('/'));
        }

        if($request->get('logout'))
        {
            $request->getSession()
                ->setOwner(0)
                ->set('user.auth.logged', 0);

            return $this->redirectToUrl($request->getUriForPath('/'));
        }

        return $this->render();
    }
}
