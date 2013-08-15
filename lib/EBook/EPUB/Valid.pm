package EBook::EPUB::Valid;

use 5.008_001;
use strict;
use warnings;
use Carp ();
use Exporter qw/import/;
use File::ShareDir ();
use IPC::Run3;

our $VERSION   = '0.01';
our @EXPORT    = qw(validate_epub);
our @EXPORT_OK = qw();

sub validate_epub
{
    my ($jar, $epub);

    if (scalar @_ == 1)
    {
        $jar  = File::ShareDir::dist_file('EBook-EPUB-Valid', 'epubcheck-3.0.1/epubcheck-3.0.1.jar');
        $epub = shift;
    }
    else { ($jar, $epub) = @_; }

    return (0, 'jar file not found')  unless -e $jar;
    return (0, 'epub file not found') unless -e $epub;

    my ($in, $out, $err);
    my @cmd = ('java', '-jar', $jar, $epub);

    run3 \@cmd, \$in, \$out, \$err;

    $out .= $err;

    my $is_valid = ($out =~ /No errors or warnings detected/i) ? 1 : 0;

    return ($is_valid, $out);
}

1;

__END__

=head1 NAME

EBook::EPUB::Valid - perl wrapper for EpubCheck

=head1 SYNOPSIS

  use EBook::EPUB::Valid;
  my ($is_valid, $out) = validate_epub('/path/to/file.epub');

=head2 Command Line Interface

  epubcheck [epubcheck-x.x.x.jar] file.epub

=head1 DESCRIPTION

EBook::EPUB::Valid is a perl wrapper for EpubCheck.
EpubCheck is a tool to validate IDPF EPUB files.

=head1 SUBROUTINES

=head2 ($is_valid, $out) = validate_epub( [ $path_to_epubcheck_jar ], $path_to_epub_file )

Validates $path_to_epub_file by using $path_to_epubcheck_jar.
If $path_to_epubcheck_jar is omitted, bundled 'epubcheck-3.0.1.jar' is used.

=head1 AUTHOR

pawa E<lt>pawapawa@cpan.orgE<gt>

=head1 SEE ALSO

https://code.google.com/p/epubcheck/

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
