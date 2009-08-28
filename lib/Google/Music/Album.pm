package Google::Music::Album;
use strict;
use HTML::Entities;
use Google::Music::Song;

use base qw/Google::Music Class::Accessor::Fast/;
__PACKAGE__->mk_accessors(qw/ id cover name artist year songs /);

sub new_from_url {
    my $class = shift;
    my $url = shift;
    return unless $url =~ m{^http://www\.google\.cn/music/album\?id=B([a-f0-9]{16})$};
    return $class->new( $1 );
}

sub new {
    my $class = shift;
    my $id = shift;
    $id =~ s/^B//;
    return unless $id =~ /^[a-f0-9]{16}$/;

    my $self = bless {}, $class;
    $self->id( $id );
    return $self;
}

sub url {
    my $self = shift;
    sprintf 'http://www.google.cn/music/album?id=B%s', $self->id;
}

sub parse {
    my $self = shift;
    my $html = $self->fetch( $self->url );
    my ( $table ) = ( $html =~ m{<table id="album_item"(?:.*?)>(.*?)</table>}s );  

    my ( $cover ) = ( $table =~ m{<img(?:.*?)class="thumb-img"(?:.*?)src="http://music\.googleusercontent\.cn/base_media\?q=(.*?)\&amp;}s );
    $self->cover( $cover );

    my ( $name ) = ( $table =~ m{<span class="Title">(.*?)</span>}s );
    $name =~ s/^\W|\W$//g;
    $name = decode_entities( $name );
    $self->name( $name );

    my ( $singer, $date, $company ) = ( $table =~ m{class="Description">(.*?)<br>(.*?)<br>(.*?)</td>}s );
    my ( $artist ) = ( $singer =~ m{<(?:.*?)>(.*?)</(?:.*?)>} );
    $artist = decode_entities( $artist );
    $self->artist( $artist );

    my ( $year, $month, $day ) = ( $date =~ m{(\d+?)\&#24180;(\d+?)\&#26376;(\d+?)\&#26085;} );
    $self->year( $year );


    my @songs;
    my @song_rows = ( $html =~ m{(<tr(?:.*?)class="SongItem\s+(?:.*?)>(?:.*?)</tr>)}gs );
    foreach ( @song_rows ){
        my ( $id ) = ( m{<tr\s+id="rowS(.*?)"} );
        my $song = Google::Music::Song->new( $id );

        my ( $track ) = ( m{<td class="number(?:.*?)>(\d+)(?:.*?)</td>}s );
        $song->track( $track );

        my ( $title ) = ( m{<td class="Title\s+(?:.*?)"><a(?:.*?)>(.*?)</a>}s );
        $title = decode_entities( $title );
        $title =~ s/<b>\.\.\.<\/b>$//; # remove the tailing ...
        $song->title( $title );

        push @songs, $song;
    }

    $self->songs(\@songs);
    return $self;
}

sub dirname {
    my $self = shift;
    sprintf '%s - %s - %s', substr($self->id, 0,3 ), $self->artist, $self->name;
}


1;
