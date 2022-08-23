<?php

$vendorDir = dirname(__DIR__);
$rootDir = dirname(dirname(__DIR__));

return array (
  'supercool/tablemaker' => 
  array (
    'class' => 'supercool\\tablemaker\\TableMaker',
    'basePath' => $vendorDir . '/supercool/tablemaker/src',
    'handle' => 'tablemaker',
    'aliases' => 
    array (
      '@supercool/tablemaker' => $vendorDir . '/supercool/tablemaker/src',
    ),
    'name' => 'Table Maker',
    'version' => '2.0.1',
    'schemaVersion' => '1.0.0',
    'description' => 'A user-definable table field type for Craft CMS',
    'developer' => 'Supercool Ltd',
    'developerUrl' => 'http://www.supercooldesign.co.uk/',
    'documentationUrl' => 'https://github.com/supercool/tablemaker/blob/master/README.md',
    'changelogUrl' => 'https://raw.githubusercontent.com/supercool/tablemaker/master/CHANGELOG.md',
    'hasCpSettings' => false,
    'hasCpSection' => false,
  ),
  'craftcms/redactor' => 
  array (
    'class' => 'craft\\redactor\\Plugin',
    'basePath' => $vendorDir . '/craftcms/redactor/src',
    'handle' => 'redactor',
    'aliases' => 
    array (
      '@craft/redactor' => $vendorDir . '/craftcms/redactor/src',
    ),
    'name' => 'Redactor',
    'version' => '2.8.8',
    'description' => 'Edit rich text content in Craft CMS using Redactor by Imperavi.',
    'developer' => 'Pixel & Tonic',
    'developerUrl' => 'https://pixelandtonic.com/',
    'developerEmail' => 'support@craftcms.com',
    'documentationUrl' => 'https://github.com/craftcms/redactor/blob/v2/README.md',
  ),
  'verbb/field-manager' => 
  array (
    'class' => 'verbb\\fieldmanager\\FieldManager',
    'basePath' => $vendorDir . '/verbb/field-manager/src',
    'handle' => 'field-manager',
    'aliases' => 
    array (
      '@verbb/fieldmanager' => $vendorDir . '/verbb/field-manager/src',
    ),
    'name' => 'Field Manager',
    'version' => '2.2.4',
    'description' => 'Manage your fields and field groups with ease with simple field or group cloning and quicker overall management.',
    'developer' => 'Verbb',
    'developerUrl' => 'https://verbb.io',
    'developerEmail' => 'support@verbb.io',
    'documentationUrl' => 'https://github.com/verbb/field-manager',
    'changelogUrl' => 'https://raw.githubusercontent.com/verbb/field-manager/craft-3/CHANGELOG.md',
  ),
  'nystudio107/craft-cookies' => 
  array (
    'class' => 'nystudio107\\cookies\\Cookies',
    'basePath' => $vendorDir . '/nystudio107/craft-cookies/src',
    'handle' => 'cookies',
    'aliases' => 
    array (
      '@nystudio107/cookies' => $vendorDir . '/nystudio107/craft-cookies/src',
    ),
    'name' => 'Cookies',
    'version' => '1.1.15',
    'description' => 'A simple plugin for setting and getting cookies from within Craft CMS templates.',
    'developer' => 'nystudio107',
    'developerUrl' => 'https://nystudio107.com/',
    'documentationUrl' => 'https://nystudio107.com/plugins/cookies/documentation',
    'changelogUrl' => 'https://raw.githubusercontent.com/nystudio107/craft-cookies/v1/CHANGELOG.md',
  ),
  'mildlygeeky/craft-kint' => 
  array (
    'class' => 'mildlygeeky\\kint\\Plugin',
    'basePath' => $vendorDir . '/mildlygeeky/craft-kint/src',
    'handle' => 'kint',
    'aliases' => 
    array (
      '@mildlygeeky/kint' => $vendorDir . '/mildlygeeky/craft-kint/src',
    ),
    'name' => 'Kint',
    'version' => '1.0.0',
    'description' => 'Adds Kint, an in-app PHP debugger, to Craft CMS 3.x for use in Twig and PHP.',
    'developer' => 'Mildly Geeky, Inc.',
    'developerUrl' => 'https://mildlygeeky.com',
    'documentationUrl' => 'https://github.com/mildlygeeky/craft-kint/blob/master/README.md',
    'changelogUrl' => 'https://raw.githubusercontent.com/mildlygeeky/craft-kint/master/CHANGELOG.md',
    'hasCpSettings' => true,
    'hasCpSection' => false,
  ),
);
