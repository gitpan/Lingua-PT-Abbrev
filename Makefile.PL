use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Lingua::PT::Abbrev',
    AUTHOR              => 'Alberto Simões <ambs@cpan.org>',
    VERSION_FROM        => 'lib/Lingua/PT/Abbrev.pm',
    ABSTRACT_FROM       => 'lib/Lingua/PT/Abbrev.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Lingua-PT-Abbrev-*' },
);
