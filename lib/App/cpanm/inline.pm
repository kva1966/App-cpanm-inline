package App::cpanm::inline;

use 5.008001;
use strict;
use warnings;

use File::Which;


our $VERSION = "0.01";

# Usage:
# use App::cpanm::inline [ 'Module::Name', 'OrURL', ... ], {}
# use App::cpanm::inline [ 'Module::Name', 'OrURL', ... ], { verbose => 1 }

my $verbose = 0;


sub import {
    my ($mod_name, $ref) = @_;
    my $mod = __PACKAGE__;

    die "$mod takes an ref with 2 elements: hashref of options, array ref of dependencies"
        unless scalar @{ $ref } == 2;

    my ($dependencies, $mod_opts) = ($ref->[0], $ref->[1]);

    die "$mod in use, but `cpanm` not in path. Be sure to install App::cpanm first."
        unless which 'cpanm';

    # use Data::Dumper::Concise; say STDERR Dumper($dependencies);
    $verbose = 1 if exists $mod_opts->{verbose};

    _log(sub { "--- BEGIN $mod verbose output ---" });

    my $capture = '2>&1';
    my $modules = join(' ', @{ $dependencies });
    my $cmd = "cpanm $modules $capture";

    _log(sub { "Executing command[$cmd]" });

    my $result = qx/$cmd/;

    _log(sub { "Result[$result]\n--- END $mod verbose output ---" });
}


sub _log {
    my $msg_fn = shift;
    say STDERR $msg_fn->() if $verbose;
}

1;


__END__

=encoding utf-8

=head1 NAME

App::cpanm::inline - It's new $module

=head1 SYNOPSIS

    use App::cpanm::inline;

=head1 DESCRIPTION

App::cpanm::inline is ...

=head1 LICENSE

Copyright (C) Kamal Advani.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Kamal Advani E<lt>kamal.advani@strategicdata.com.auE<gt>

=cut

