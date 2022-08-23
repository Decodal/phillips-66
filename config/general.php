<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see craft\config\GeneralConfig
 */

return [
    // Global settings
    '*' => [

        // Base site URL
        'siteUrl' => 'https://' . $_SERVER['SERVER_NAME'] . '/',
        
        // Default Week Start Day (0 = Sunday, 1 = Monday...)
        'defaultWeekStartDay' => 0,

        // Enable CSRF Protection (recommended)
        'enableCsrfProtection' => true,

        // Whether generated URLs should omit "index.php"
        'omitScriptNameInUrls' => true,

        // Control Panel trigger word
        'cpTrigger' => 'admin',

        // Send powerd by header
        'sendPoweredByHeader' => false,

        // Auto updates
        'allowUpdates' => false,

        // The secure key Craft will use for hashing and encrypting data
        'securityKey' => getenv('SECURITY_KEY'),

        'devMode' => false,

        'aliases' => [
            '@web' => 'https://' . $_SERVER['SERVER_NAME'] . '/',
        ]

    ],

    // Dev environment settings
    'dev' => [
        // Base site URL
        'siteUrl' => 'https://' . $_SERVER['SERVER_NAME'] . '/',

        // Dev Mode (see https://craftcms.com/support/dev-mode)
        'devMode' => true,

        // Auto updates
        'allowUpdates' => true,

        'aliases' => [
            '@web' => 'https://' . $_SERVER['SERVER_NAME'] . '/',
        ]
    ],

    // Staging environment settings
    'staging' => [
        // Base site URL
        'siteUrl' => 'https://' . $_SERVER['SERVER_NAME'] . '/',

        'aliases' => [
            '@web' => 'https://' . $_SERVER['SERVER_NAME'] . '/',
        ]
    ]

];
