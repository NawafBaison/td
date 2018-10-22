#!/bin/sh 

reset

echo "$(tput setaf 2)Keko source Install $(tput sgr 0)"
echo '┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│ m    m        #                                                             │
│ #  m"   mmm   #   m   mmm           mmm    mmm   m   m   m mm   mmm    mmm  │
│ #m#    #"  #  # m"   #" "#         #   "  #" "#  #   #   #"  " #"  "  #"  # │
│ #  #m  #""""  #"#    #   #          """m  #   #  #   #   #     #      #"""" │
│ #   "m "#mm"  #  "m  "#m#"         "mmm"  "#m#"  "mm"#   #     "#mm"  "#mm" │
│                                                                             │
│                         By : t.me/ikeko                                     │
└─────────────────────────────────────────────────────────────────────────────┘'
printf "$(tput setaf 2)="

sudo apt-get update > /dev/null 2>&1 | printf "="

sudo apt-get upgrade -y > /dev/null 2>&1 | printf "="

sudo apt-get install git redis-server lua5.2 liblua5.2-dev lua-lgi libnotify-dev unzip tmux -y > /dev/null 2>&1 

add-apt-repository ppa:ubuntu-toolchain-r/test -y > /dev/null 2>&1 | printf "="

sudo apt-get update -y > /dev/null 2>&1 | printf "="

sudo apt-get upgrade -y > /dev/null 2>&1 | printf "="

sudo apt-get install libconfig++9v5 libstdc++6 -y > /dev/null 2>&1 | printf "="

sudo apt autoremove -y > /dev/null 2>&1 | printf "="

sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson* libpython-dev make unzip git redis-server g++ -y --force-yes > /dev/null 2>&1 | printf "="

wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz > /dev/null 2>&1 | printf "="

tar zxpf luarocks-2.2.2.tar.gz 

cd luarocks-2.2.2

./configure; sudo make bootstrap 

reset
echo "$(tput setaf 2)Keko source Install $(tput sgr 0)"
echo '┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│ m    m        #                                                             │
│ #  m"   mmm   #   m   mmm           mmm    mmm   m   m   m mm   mmm    mmm  │
│ #m#    #"  #  # m"   #" "#         #   "  #" "#  #   #   #"  " #"  "  #"  # │
│ #  #m  #""""  #"#    #   #          """m  #   #  #   #   #     #      #"""" │
│ #   "m "#mm"  #  "m  "#m#"         "mmm"  "#m#"  "mm"#   #     "#mm"  "#mm" │
│                                                                             │
│                By : t.me/ikeko  |  channel : t.me/BotLua                    │
└─────────────────────────────────────────────────────────────────────────────┘'
printf "$(tput setaf 2)==========="

sudo luarocks install luasocket > /dev/null 2>&1 | printf "="

sudo luarocks install luasec > /dev/null 2>&1 | printf "="

sudo apt-get install shc > /dev/null 2>&1 | printf "="

sudo luarocks install redis-lua > /dev/null 2>&1 | printf "="

sudo luarocks install ansicolors > /dev/null 2>&1 | printf "="

sudo luarocks install serpent > /dev/null 2>&1 | printf "="

cd ..

sudo apt-get install curl -y > /dev/null 2>&1 | printf "="

rm -fr luarocks-2.2.2.tar.gz 

rm -fr luarocks-2.2.2

rm -fr install.sh

rm -fr README.md

wget "https://valtman.name/files/telegram-bot-181022-nightly-linux" > /dev/null 2>&1 | printf "="

mv telegram-bot-181022-nightly-linux telegram-bot; chmod +x telegram-bot 

wget "http://tshake.team/keko.sh.x" > /dev/null 2>&1 | printf "="

chmod +x run

echo "$(tput setaf 2)End install $(tput sgr 0)"

screen -s keko -S keko ./run

