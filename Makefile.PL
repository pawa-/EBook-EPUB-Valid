use inc::Module::Install;

name     'EBook-EPUB-Valid';
all_from 'lib/EBook/EPUB/Valid.pm';

requires      'Carp';
requires      'File::ShareDir';
test_requires 'Test::More' => 0.88; # done_testing

readme_from 'lib/EBook/EPUB/Valid.pm';

install_share;
install_script 'epubcheck';

tests 't/*.t';
author_tests 'xt';

resources(
    license    => 'http://dev.perl.org/licenses',
    repository => 'https://github.com/pawa-/EBook-EPUB-Valid',
    bugtracker => 'https://github.com/pawa-/EBook-EPUB-Valid/issues',
); 

WriteAll;
