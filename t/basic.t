#! perl -w
#
# $Id: basic.t,v 1.1 2001-04-13 13:12:50+02 jv Exp $

# Verifications cript for cpancd.pl

print "1..1\n";

# Verify that it compiles and load.
eval { require "script/cpancd"; };
print STDOUT "$@" if $@;
print STDOUT defined $VERSION ? "Version $VERSION\n" : "not ";
print "ok 1\n";
