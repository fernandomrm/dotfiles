dotfiles
========

A ideia deste repositório é simplesmente servir como ponto central para o gerenciamento dos arquivos básicos de configuração utilizados para facilitar o uso corriqueiro do terminal. Para utilizá-los, basta clonar o repositório e linkar os arquivos desejados.

## Exemplo de utilização:

    git clone https://github.com/myhro/dotfiles.git .dotfiles
    ln -s .dotfiles/bashrc ~/.bashrc
    ln -s ~/.bashrc ~/.profile
    ln -s .dotfiles/screenrc ~/.screenrc
    ln -s .dotfiles/vimrc ~/.vimrc
