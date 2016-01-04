<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 - 2016 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Auth\Controller;

use CRM\App\Controller\BaseController;
use CRM\Templating\PhpEngine;

class Authorisation extends BaseController
{
    public function notAllowedAction($request)
    {
        if($request->isAJAX())
        {
            return $this->responseAJAX([ 'status' => 'error', 'message' => $this->t('authAccessPageNotAllowed') ]);
        }
        else
        {
            return $this->render();
        }
    }
}
