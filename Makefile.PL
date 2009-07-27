use inc::Module::Install;

name     'Google-Music';
all_from 'lib/Google/Music.pm';
author   'chunzi <chunzi@gmail.com>';
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

