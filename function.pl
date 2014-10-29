#!perl

use strict;
use warnings;

my $config = {
    local_locations => [
        '~/.vimrc',         
        '~/.vim',
        '~/.oh-my-zsh',
    ],
};

my $sshrc_string = '[-z "$PS1"] && return\nexec zsh;';
my $port = $1 if join(' ', @ARGV) =~ /p\s*(\d*)/;
my $at_symbol_index = index($ARGV[-1], '@') ;
my $userhost = $ARGV[-1];

sub scp {
    my $files_string = '';
    foreach my $item (@{$config->{'local_locations'}}) {
        print $item;
        $files_string .= $item . ' ';
    }
    print "files - $files_string\n";

    my $port_string;
    $port_string = ($port) ? "-P $port" : "";
    print "scp -r$port_string $files_string ${userhost}:~/";
    `scp -r $port_string $files_string ${userhost}:~/`;
}

scp();

#return @ARGV; Need to ssh in perl if perl allows me to continue on in ssh without the perl script anymore
# put together an ssh string; 
## first ssh
## with perliminary arguments
## user@hostNAME;
        #$hostname = substr($userhost, $at_symbol_index + 1); 
        #$username = $1 if $userhost =~ /(\w*)@/;
