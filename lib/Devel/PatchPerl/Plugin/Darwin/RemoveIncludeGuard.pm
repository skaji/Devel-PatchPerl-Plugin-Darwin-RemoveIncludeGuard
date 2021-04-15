package Devel::PatchPerl::Plugin::Darwin::RemoveIncludeGuard;
use strict;
use warnings;

our $VERSION = '0.001';

use Devel::PatchPerl::Plugin::Darwin::RemoveIncludeGuard::Share;
use Devel::PatchPerl;
use version ();

sub patchperl {
    my ($class, %argv) = @_;
    my $version = version->parse($argv{version});
    my $need_patch = $^O eq 'darwin' && (v5.8.1 <= $version && $version <= v5.8.2);
    return if !$need_patch;
    my $patch = Devel::PatchPerl::Plugin::Darwin::RemoveIncludeGuard::Share->file("patch");
    Devel::PatchPerl::_patch($patch);
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
