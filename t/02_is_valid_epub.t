use strict;
use warnings;
use EBook::EPUB::Valid;
use Test::More;

{
    my ($is_valid, $out) = validate_epub('epub/valid.epub');
    ok($is_valid, 'valid1 is valid');
    like($out, qr/No errors or warnings detected/i, 'valid1 returns valid output');
}

{
    my ($is_valid, $out)
        = validate_epub('share/epubcheck-3.0.1/epubcheck-3.0.1.jar', 'epub/valid.epub');

    ok($is_valid, 'valid2 is valid');
    like($out, qr/No errors or warnings detected/i, 'valid2 returns valid output');
}

{
    my ($is_valid, $out) = validate_epub('epub/invalid.epub');
    ok(! $is_valid, 'invalid1 is invalid');
    like($out, qr/Check finished with warnings or errors/i, 'invalid1 returns invalid output');
}

{
    my ($is_valid, $out)
        = validate_epub('share/epubcheck-3.0.1/epubcheck-3.0.1.jar', 'epub/invalid.epub');

    ok(! $is_valid, 'invalid2 is invalid');
    like($out, qr/Check finished with warnings or errors/i, 'invalid2 returns invalid output');
}

{
    my ($is_valid, $out) = validate_epub('epub/valid.epubbb');
    ok(! $is_valid, 'epub file not found');
    like($out, qr/epub file not found/i, 'epub file not found');
}

{
    my ($is_valid, $out)
        = validate_epub('share/epubcheck-3.0.1/epubcheck-3.0.1.jar', 'epub/valid.epubbb');

    ok(! $is_valid, 'epub file not found2');
    like($out, qr/epub file not found/i, 'epub file not found2');
}

{
    my ($is_valid, $out)
        = validate_epub('share/epubcheck-3.0.1/epubcheck-3.0.1.jarrr', 'epub/valid.epub');

    ok(! $is_valid, 'jar file not found');
    like($out, qr/jar file not found/i, 'jar file not found');
}

done_testing;
