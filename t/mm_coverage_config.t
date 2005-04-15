use warnings;
use strict;

### 2 + 1 * keys %$href + scalar @{$href->{KEY}{patterns}
use Test::More tests => 18;

my $pkg = 'ExtUtils::MakeMaker::Coverage';
use_ok( $pkg );

my $conf = $pkg->config;
isa_ok( $conf, $pkg );

my $map = {
    ignore  => { 
        value       => ['SCCS'],
        patterns    => [qr|\+ignore,SCCS|],
    },
    binary  => {
        value       => '/my/path/to/cover',
        patterns    => [qr|COVER = /my/path/to/cover|],
    },        
    format  => {
        value       => 'foo',
        patterns    => [qr|\$\(COVER\) -report foo|],
    },
    cover_statement => {
        value       => 0,
        patterns    => [qr|(?!-coverage,statement)|],
    },        
    cover_branch => {
        value       => 0,
        patterns    => [qr|(?!-coverage,branch)|],
    },        
    cover_subroutine => {
        value       => 0,
        patterns    => [qr|(?!-coverage,subroutine)|],
    },        
    cover_condition => {
        value       => 0,
        patterns    => [qr|(?!-coverage,condition)|],
    },        
    cover_pod => {
        value       => 0,
        patterns    => [qr|(?!-coverage,pod)|],
    },        
};                        


while ( my($method,$href) = each %$map ) {

    ### save original value to restore
    my $old = $conf->$method;
    
    ### set test value
    $conf->$method( $href->{value} );
    
    ### get target text
    my $target = $pkg->testcover;
    
    ok( $target,                "Testcover target written for '$method'" );
    
    ### check if it matches the patterns;
    for my $pat ( @{$href->{patterns}} ) {
        like( $target, $pat,    "   Matches $pat" );
    }

    ### restore config
    $conf->$method( $old );

};
