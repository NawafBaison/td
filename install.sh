echo "$(tput setaf 2)Keko source Install $(tput sgr 0)"
echo '┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│ m    m        #                                                             │
│ #  m"   mmm   #   m   mmm           mmm    mmm   m   m   m mm   mmm    mmm  │
│ #m#    #"  #  # m"   #" "#         #   "  #" "#  #   #   #"  " #"  "  #"  # │
│ #  #m  #""""  #"#    #   #          """m  #   #  #   #   #     #      #"""" │
│ #   "m "#mm"  #  "m  "#m#"         "mmm"  "#m#"  "mm"#   #     "#mm"  "#mm" │
│                                                                             │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘'
echo "$(tput setaf 2)By : t.me/ikeko $(tput sgr 0)"


sudo apt-get update 

sudo apt-get upgrade -y 

sudo apt-get install git redis-server lua5.2 liblua5.2-dev lua-lgi libnotify-dev unzip tmux -y 

add-apt-repository ppa:ubuntu-toolchain-r/test -y

sudo apt-get update 

sudo apt-get upgrade -y

sudo apt-get install libconfig++9v5 libstdc++6 -y

sudo apt autoremove -y

sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson* libpython-dev make unzip git redis-server g++ -y --force-yes

wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz

tar zxpf luarocks-2.2.2.tar.gz

cd luarocks-2.2.2

./configure; sudo make bootstrap

sudo luarocks install luasocket

sudo luarocks install luasec

sudo apt-get install shc

sudo luarocks install redis-lua

sudo luarocks install ansicolors

sudo luarocks install serpent

cd ..

sudo apt-get install curl -y

rm -fr luarocks-2.2.2.tar.gz

rm -fr install.sh

wget --progress=bar:force https://valtman.name/files/telegram-bot-170904-nightly-linux 2>&1 

mv telegram-bot-170904-nightly-linux telegram-bot; chmod +x telegram-bot

chmod +x run

echo "$(tput setaf 2)End install $(tput sgr 0)"

