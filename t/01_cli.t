use strict;
use warnings;
use Test::More;

{
    my $out = qx(script/epubcheck share/epubcheck-3.0.1/epubcheck-3.0.1.jar epub/valid.epub);
    like($out, qr/No errors or warnings detected/i, 'valid1');
}

{
    my $out = qx(script/epubcheck epub/valid.epub);
    like($out, qr/No errors or warnings detected/i, 'valid2');
}

{
    my $out = qx(script/epubcheck share/epubcheck-3.0.1/epubcheck-3.0.1.jar epub/invalid.epub 2>&1);
    like($out, qr/Check finished with warnings or errors/i, 'invalid1');
}

{
    my $out = qx(script/epubcheck epub/invalid.epub 2>&1);
    like($out, qr/Check finished with warnings or errors/i, 'invalid2');
}

{
    my $out = qx(script/epubcheck epub/invalid.epubbb);
    like($out, qr/epub file not found/i, 'epub file not found1');
}

{
    my $out = qx(script/epubcheck share/epubcheck-3.0.1/epubcheck-3.0.1.jar epub/invalid.epubbbb);
    like($out, qr/epub file not found/i, 'epub file not found2');
}

{
    my $out = qx(script/epubcheck share/epubcheck-3.0.1/epubcheck-3.0.1.jarrrr epub/invalid.epub);
    like($out, qr/jar file not found/i, 'jar file not found');
}

done_testing;
