use inc::Module::Install;

name     'Google-Music';
all_from 'lib/Google/Music.pm';
author   'chunzi <chunzi@gmail.com>';
license  'perl';

requires 'HTML::Entities';
requires 'LWP::UserAgent';
requires 'Class::Accessor::Fast';

build_requires 'Test::More';

install_script 'bin/gma';
auto_install;

WriteAll;

