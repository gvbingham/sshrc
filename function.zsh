function sshrc {
    perl_response=`/usr/bin/perl ~/.oh-my-zsh/custom/function.pl $@`;
    #`perl_response`;
    echo $perl_response;
}
