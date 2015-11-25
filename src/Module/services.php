<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

return [
    'mod.auth.authentication' => [
        'class' => 'App\Module\Auth\Authentication',
        'arguments' => [
            'container'
        ],
        'listen' => [
            'onBeforeController',
            'onAfterController',
        ]
    ],
    'mod.auth.authorisation' => [
        'class' => 'App\Module\Auth\Authorisation',
        'arguments' => [
            'container'
        ],
        'listen' => [
            'onBeforeController'
        ]
    ]
];
