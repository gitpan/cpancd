# Makefile.PL -- Makefile for PostScript::Fonts
# Author          : Johan Vromans
# Created On      : Mon Feb  8 11:46:56 1999
# Last Modified By: Johan Vromans
# Last Modified On: Wed Apr 11 19:55:28 2001
# Update Count    : 86
# Status          : Stable

# Verify perl version.
require 5.000;
use Config;

use ExtUtils::MakeMaker;

my @scripts = qw(cpancd);
my $usrbin = "/usr/bin";
my $installscript = $Config{installscript};

print STDERR <<EOD unless $installscript eq $usrbin;

WARNING: This Makefile will install user accessible scripts.
The location for these scripts is $installscript.
You may consider to pass INSTALLSCRIPT=$usrbin (or some other
convenient location) to "make install".

EOD

my $ok = 0;
foreach ( split(/[:;]/, $ENV{PATH}) ) {
    if ( -f "$_/mkisofs" && -x ) {
	$ok++;
	last;
    }
}
unless ( $ok ) {
    print STDERR <<EOD;

WARNING: cpancd requires the mkisofs program. This program could
not be found in your current PATH. Make sure that it is available
when you run cpancd.

EOD
}

WriteMakefile
  (
   NAME         => 'cpancd',
   ($] >= 5.005) ?
   ( AUTHOR	=> 'Johan Vromans (jvromans@squirrel.nl)',
     ABSTRACT	=> 'Create a CD-able CPAN subset' ) : (),
   VERSION      => "1.00",
   PREREQ_PM	=> { 'Getopt::Long' => 2.00 },
   EXE_FILES    => [ map { "script/$_" } @scripts ],
   # *.pm files will be picked up automatically from ./lib
 );
