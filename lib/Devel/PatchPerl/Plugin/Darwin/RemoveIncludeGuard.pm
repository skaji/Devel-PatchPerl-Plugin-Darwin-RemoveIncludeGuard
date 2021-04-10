package Devel::PatchPerl::Plugin::Darwin::RemoveIncludeGuard;
use strict;
use warnings;

our $VERSION = '0.001';

use Devel::PatchPerl;
use version ();

sub patchperl {
    my ($class, %argv) = @_;
    my $version = version->parse($argv{version});
    my $need_patch = $^O eq 'darwin' && (v5.8.1 <= $version && $version <= v5.8.2);
    return if !$need_patch;
    $class->_patch_remove_include_guard;
}

sub _patch_remove_include_guard {
    my $class = shift;
    Devel::PatchPerl::_patch(<<'EOF');
diff --git doio.c doio.c
index af4d17d487..dc192d4717 100644
--- doio.c
+++ doio.c
@@ -48,9 +48,7 @@
 #  define OPEN_EXCL 0
 #endif
 
-#if !defined(NSIG) || defined(M_UNIX) || defined(M_XENIX)
 #include <signal.h>
-#endif
 
 bool
 Perl_do_open(pTHX_ GV *gv, register char *name, I32 len, int as_raw,
diff --git doop.c doop.c
index 546d33d14c..0318578b6d 100644
--- doop.c
+++ doop.c
@@ -17,10 +17,8 @@
 #include "perl.h"
 
 #ifndef PERL_MICRO
-#if !defined(NSIG) || defined(M_UNIX) || defined(M_XENIX)
 #include <signal.h>
 #endif
-#endif
 
 STATIC I32
 S_do_trans_simple(pTHX_ SV *sv)
diff --git mg.c mg.c
index 16d7c4343e..6ee5f57179 100644
--- mg.c
+++ mg.c
@@ -392,10 +392,7 @@ Perl_mg_free(pTHX_ SV *sv)
     return 0;
 }
 
-
-#if !defined(NSIG) || defined(M_UNIX) || defined(M_XENIX)
 #include <signal.h>
-#endif
 
 U32
 Perl_magic_regdata_cnt(pTHX_ SV *sv, MAGIC *mg)
diff --git mpeix/mpeixish.h mpeix/mpeixish.h
index 658e72ef87..49ef4355fe 100644
--- mpeix/mpeixish.h
+++ mpeix/mpeixish.h
@@ -87,9 +87,7 @@
  */
 /* #define ALTERNATE_SHEBANG "#!" / **/
 
-#if !defined(NSIG) || defined(M_UNIX) || defined(M_XENIX)
-# include <signal.h>
-#endif
+#include <signal.h>
 
 #ifndef SIGABRT
 #    define SIGABRT SIGILL
diff --git plan9/plan9ish.h plan9/plan9ish.h
index 5c922cf0ba..c3ae06790a 100644
--- plan9/plan9ish.h
+++ plan9/plan9ish.h
@@ -93,9 +93,7 @@
  */
 /* #define ALTERNATE_SHEBANG "#!" / **/
 
-#if !defined(NSIG) || defined(M_UNIX) || defined(M_XENIX)
-# include <signal.h>
-#endif
+#include <signal.h>
 
 #ifndef SIGABRT
 #    define SIGABRT SIGILL
diff --git unixish.h unixish.h
index 4bf37095a0..23b3cadf12 100644
--- unixish.h
+++ unixish.h
@@ -103,9 +103,7 @@
  */
 /* #define ALTERNATE_SHEBANG "#!" / **/
 
-#if !defined(NSIG) || defined(M_UNIX) || defined(M_XENIX) || defined(__NetBSD__) || defined(__FreeBSD__) || defined(__OpenBSD__)
 # include <signal.h>
-#endif
 
 #ifndef SIGABRT
 #    define SIGABRT SIGILL
diff --git util.c util.c
index 4f18a3060f..856ef93bd7 100644
--- util.c
+++ util.c
@@ -18,10 +18,7 @@
 #include "perl.h"
 
 #ifndef PERL_MICRO
-#if !defined(NSIG) || defined(M_UNIX) || defined(M_XENIX)
 #include <signal.h>
-#endif
-
 #ifndef SIG_ERR
 # define SIG_ERR ((Sighandler_t) -1)
 #endif
EOF
}

1;
__END__

=encoding utf-8

=head1 NAME

Devel::PatchPerl::Plugin::Darwin::RemoveIncludeGuard - remove some include guards for perl 5.8.1 and 5.8.2 on macOS

=head1 SYNOPSIS

  wget https://www.cpan.org/src/5.0/perl-5.8.1.tar.gz
  tar xf perl-5.8.1.tar.gz
  cd perl-5.8.1
  env PERL5_PATCHPERL_PLUGIN=Darwin::RemoveIncludeGuard patchperl
  ./Configure -des -Dprefix=$HOME/perl
  make install

=head1 DESCRIPTION

To build perl 5.8.1 and 5.8.2 on macOS, we need to remove some include guards.
Devel::PatchPerl::Plugin::Darwin::RemoveIncludeGuard will handle it.

=head1 INSTALL

  cpm install -g https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-RemoveIncludeGuard.git

or

  cpanm -nq https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-RemoveIncludeGuard.git

=head1 AUTHOR

Shoichi Kaji <skaji@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright 2021 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
