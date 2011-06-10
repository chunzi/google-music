package Google::Music;
use strict;
use warnings;

use LWP::UserAgent;
use LWP::Curl;

our $VERSION = '0.02';

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}

sub fetch {
    my $self = shift;
    my $url = shift;

    unless ( $self->{'_ua'} ){
        my $ua = new LWP::UserAgent;
        $ua->timeout(10);
        $ua->agent('perl Google::Music');
        $self->{'_ua'} = $ua;
    }
    my $res = $self->{'_ua'}->get( $url );
    unless ( $res->is_success ){
        die sprintf "failed fetch url %s: %s\n", $url, $res->status_line;
    }
    return $res->decoded_content;
}

sub download_file {
    my $self = shift;
    my $url = shift;
    my $path = shift;
    return unless defined $url and defined $path;

    my $curl = LWP::Curl->new();
    $curl->agent_alias('Mac Safari');
    $curl->timeout(86400); # one day, no timeout

    my $data = $curl->get( $url ); 

    open ( F, '>', $path ) or die $!;
    binmode F;
    print F $data;
    close F;

    return -f $path && -B _;
}

=head1 NAME

Google::Music - The great new Google::Music!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Google::Music;

    my $foo = Google::Music->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 AUTHOR

chunzi, C<< <chunzi at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-google-music at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Google-Music>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Google::Music


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Google-Music>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Google-Music>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Google-Music>

=item * Search CPAN

L<http://search.cpan.org/dist/Google-Music/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 chunzi, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Google::Music
