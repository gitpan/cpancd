# Makefile.PL -- Makefile for cpancd
# $Id: Makefile.PL,v 1.2 2001-04-13 13:17:38+02 jv Exp $
# Author          : Johan Vromans
# Created On      : Tue Apr 12 12:18:38 2001
# Last Modified By: Johan Vromans
# Last Modified On: Fri Apr 13 13:17:33 2001
# Update Count    : 12
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

# Look for the mkisofs program.
unless ( findexec ("mkisofs") ) {
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
   VERSION_FROM => "script/cpancd",
   PREREQ_PM	=> { 'Getopt::Long' => 2.00 },
   EXE_FILES    => [ map { "script/$_" } @scripts ],
   # *.pm files will be picked up automatically from ./lib
 );

sub findexec {
    my $exec = shift;
    foreach ( split(/[:;]/, $ENV{PATH}) ) {
	return 1 if -f "$_/$exec" && -x _;
    }
    return;
}
