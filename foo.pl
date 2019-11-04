#!/usr/bin/env perl

use App::cpanm::inline [
    [
        'File::Which',
        'ojo'
    ],
    { verbose => true },
];

print "Script: All done\n";
