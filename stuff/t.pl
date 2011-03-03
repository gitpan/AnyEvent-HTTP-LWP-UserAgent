#!/usr/bin/perl

use strict;
use warnings;

use lib qw(lib);
use Coro;
use Data::Dumper;
use AnyEvent::HTTP::LWP::UserAgent;
use LWP::UserAgent;

#my @urls = ('http://yandex.ru', 'http://google.ru', 'http://ya.ru');
my @urls;
for (1..3) {
    push @urls, "http://localhost:5000/$_";
}
my @ua;
push @ua, LWP::UserAgent->new(agent => "asdf$_", timeout => 1) for (0..scalar(@urls)-1);



my @coro = map { my $i = $_; async {
    print "coro $i started\n";
    my $u = $ua[$i];
    my $resp = $u->get($urls[$i]);
    my $content = $resp->content;
    $content = substr($content, 0, 300);
    $content =~ s/\n/ /g;
#    print "coro $i content: [$content]\n";
    print Dumper($resp);
    print "coro $i finished, " . $resp->code . ", " . $resp->content . "\n";
} } 0..scalar(@urls)-1;
$_->join for @coro;
