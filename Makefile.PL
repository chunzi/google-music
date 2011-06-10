use inc::Module::Install;

name     'Google-Music';
all_from 'lib/Google/Music.pm';
author   'chunzi <chunzi@gmail.com>';
license  'perl';

requires 'Class::Accessor::Fast';
requires 'HTML::Entities';
requires 'IPC::Cmd';
requires 'LWP::Curl';
requires 'LWP::UserAgent';
requires 'Path::Class';
requires 'YAML::Syck';

build_requires 'Test::More';

auto_install;
install_script 'bin/gma';
resources repository => 'http://github.com/chunzi/google-music';
WriteAll;

