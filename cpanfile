requires 'IO::Socket';
requires 'Locale::Country';
requires 'Path::Tiny';
requires 'SOAP::Lite';
requires 'WWW::Mechanize';
requires 'XML::Simple';
requires 'XML::Twig';
requires 'File::MimeInfo::Magic';
requires 'Try::Tiny';
requires 'perl', '5.006';

on configure => sub {
    requires 'ExtUtils::MakeMaker';
};

on build => sub {
    requires 'Test::MockModule';
    requires 'Test::More';
    requires 'Test::Most';
    requires 'Test::Warnings';
    requires 'Path::Tiny';
};
