use warnings;
use strict;

use Test::More tests => 3;

BEGIN { use_ok('ExtUtils::MakeMaker::Coverage'); }

my $postamble = <<'END';
COVER = cover

coverclean:
	$(COVER) -delete

testcover: coverclean pure_all
	$(COVER)
END

# following checks gently lifted from Devel::Cover's Makefile.PL :)

eval "use Test::Differences";
if (my $m = $INC{"Test/Differences.pm"}) {
    my $v = eval { no warnings; $Test::Differences::VERSION };
    diag "Using $m $v";
    eq_or_diff(MY::postamble, $postamble, "Check MY::postamble output");
    eq_or_diff(testcover, $postamble, "Check testcover output");
} else {
    diag "Test::Differences is suggested for testing this module";
    is(MY::postamble, $postamble, "Check MY::postamble output") || 
        diag "Please consider installing Test::Differences to help determine this bug";
    is(testcover, $postamble, "Check testcover output");
}


