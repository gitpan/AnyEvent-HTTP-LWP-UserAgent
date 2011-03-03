#!/usr/bin/perl

use strict;
use warnings;

use Plack::Request;
my $app = sub {
    my $env = shift;
    my $req = Plack::Request->new($env);
    my $h = $req->headers;
    my $ua = $h->header('User-Agent');
    sleep(2);
    return [200, [], []];
};

return $app;
