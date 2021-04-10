[![Actions Status](https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-RemoveIncludeGuard/workflows/linux/badge.svg)](https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-RemoveIncludeGuard/actions)

# NAME

Devel::PatchPerl::Plugin::Darwin::RemoveIncludeGuard - remove some include guards for perl 5.8.1 and 5.8.2 on macOS

# SYNOPSIS

    wget https://www.cpan.org/src/5.0/perl-5.8.1.tar.gz
    tar xf perl-5.8.1.tar.gz
    cd perl-5.8.1
    env PERL5_PATCHPERL_PLUGIN=Darwin::RemoveIncludeGuard patchperl
    ./Configure -des -Dprefix=$HOME/perl
    make install

# DESCRIPTION

To build perl 5.8.1 and 5.8.2 on macOS, we need to remove some include guards.
Devel::PatchPerl::Plugin::Darwin::RemoveIncludeGuard will handle it.

# INSTALL

    cpm install -g https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-RemoveIncludeGuard.git

or

    cpanm -nq https://github.com/skaji/Devel-PatchPerl-Plugin-Darwin-RemoveIncludeGuard.git

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2021 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
