use inc::Module::Install;

name     'Google-Music';
all_from 'lib/Google/Music.pm';
author   'chunzi <chunzi@gmail.com>';
license  'perl';

requires 'HTML::Entities';
requires 'LWP::UserAgent';
requires 'LWP::Curl';
requires 'Class::Accessor::Fast';

build_requires 'Test::More';

auto_install;
install_script 'bin/gma';
resources repository => 'http://github.com/chunzi/google-music';
WriteAll;

