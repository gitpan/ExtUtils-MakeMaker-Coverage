use warnings;
use strict;

use Test::More tests => 3;

BEGIN { use_ok('ExtUtils::MakeMaker::Coverage'); }

my $hasTestDiff;
eval { use Test::Differences; };
$hasTestDiff = ! $@; 
    
my $postamble = <<'END';
COVER = cover

coverclean:
	$(COVER) -delete

testcover: coverclean
	HARNESS_PERL_SWITCHES=-MDevel::Cover PERL_DL_NONLAZY=1 $(FULLPERLRUN) "-MExtUtils::Command::MM" "-e" "test_harness($(TEST_VERBOSE), '$(INST_LIB)', '$(INST_ARCHLIB)')" $(TEST_FILES)
	$(COVER)
END

if ($hasTestDiff) {
    eq_or_diff(MY::postamble, $postamble, "Check MY::postamble output");
    eq_or_diff(testcover, $postamble, "Check testcover output");
} else {
    diag "Test::Differences is suggested for testing this module";
    is(MY::postamble, $postamble, "Check MY::postamble output") || 
        diag "Please consider installing Test::Differences to help determine this bug";
    is(testcover, $postamble, "Check testcover output");
}


