package Google::Music::Song;
use strict;
use HTML::Entities;
use base qw/ Google::Music Class::Accessor::Fast /;
__PACKAGE__->mk_accessors(qw/ id track title /);

sub new {
    my $class = shift;
    my $id = shift;
    return unless $id =~ /^[a-f0-9]{16}$/;

    my $self = bless {}, $class;
    $self->id( $id );
    return $self;
}

sub url {
    my $self = shift;
    sprintf 'http://www.google.cn/music/top100/musicdownload?id=S%s', $self->id;
}

sub download_url {
    my $self = shift;
    my $html = $self->fetch( $self->url );

    my ( $url ) = ( $html =~ m{<a href="(/music/.*?)"}s );
    sprintf 'http://www.google.cn%s', $url; 
}

sub psp_url {
    my $self = shift;
    sprintf 'http://psp-music.appspot.com/gmusic/mp3?id=S%s', $self->id;
}

sub filename {
    my $self = shift;
    my $name = sprintf "%02d %s.mp3", $self->track, $self->title;
    $name =~ s/\/\*\?/_/g;
    $name =~ s/\[/\(/g;
    $name =~ s/\]/\)/g;
    return $name;
}
1;
