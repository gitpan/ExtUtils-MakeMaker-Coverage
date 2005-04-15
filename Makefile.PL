use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'ExtUtils::MakeMaker::Coverage',
    AUTHOR              => 'Steve Peters <steve@fisharerojo.org>',
    VERSION_FROM        => 'lib/ExtUtils/MakeMaker/Coverage.pm',
    ABSTRACT_FROM       => 'lib/ExtUtils/MakeMaker/Coverage.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Devel::Cover' => 0,
        'Object::Accessor' => 0,
    },
    EXE_FILES           => [ "testcover", ],
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'ExtUtils-MakeMaker-Coverage-*' },
);
