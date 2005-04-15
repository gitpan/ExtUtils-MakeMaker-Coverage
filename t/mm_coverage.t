use warnings;
use strict;

### 3 + scalar @Pat
use Test::More tests => 17;

my $Pkg = 'ExtUtils::MakeMaker::Coverage';
my @Pat = ( 
    qr/COVER = cover/,
    qr/coverclean:/,
    qr/\t\$\(COVER\) -delete/,
    qr/testcover: coverclean pure_all/,
    qr/HARNESS_PERL_SWITCHES='-MDevel::Cover=/,
    qr/-coverage,branch/,
    qr/-coverage,condition/, 
    qr/-coverage,pod/,
    qr/-coverage,statement/,
    qr/-coverage,subroutine/,
    qr/\$\(FULLPERLRUN\) "-MExtUtils::Command::MM"/,
    qr/test_harness\(\$\(TEST_VERBOSE\)/,
    qr/\$\(TEST_FILES\)/,
    qr/\t\$\(COVER\)/
);

use_ok( $Pkg );
can_ok( $Pkg, 'testcover' );

my $Target = $Pkg->testcover;

is( $Target, MY::postamble(),     "Target installed as 'MY::postamble'" );

for my $pat ( @Pat ) {
    like( $Target, $pat,        "   Target matches $pat" );
}

__END__

The target looks something like this:


COVER = cover

coverclean:
	$(COVER) -delete

testcover: coverclean pure_all
	HARNESS_PERL_SWITCHES='-MDevel::Cover=-coverage,branch,-coverage,condition,-coverage,pod,-coverage,statement,-coverage,subroutine' PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)','$(INST_ARCHLIB)')" $(TEST_FILES)

	$(COVER)


END
