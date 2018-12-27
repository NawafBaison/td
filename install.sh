#!/bin/bash
cd td 
sudo apt-get -f install -y
echo "wit ...."
sudo apt-get update -y 
clear
echo " ──────────────────────────────────────────────────────────────────────────────"
echo "            Devloper : t.me/HHHHD | My Channel : t.me/botlua                   "
echo "                                                                               "
echo "┌─────────────────────────────────────────────────────────────────────────────┐"
echo "│                                                                                   │"
echo '│ m    m        #                                                                   │'
echo '│ #  m"   mmm   #   m   mmm           mmm    mmm   m   m   m mm   mmm    mmm        │'
echo '│ #m#    #"  #  # m"   #" "#         #   "  #" "#  #   #   #"  " #"  "  #"  #       │'
echo '│ #  #m  #""""  #"#    #   #          """m  #   #  #   #   #     #      #""""       │'
echo '│ #   "m "#mm"  #  "m  "#m#"         "mmm"  "#m#"  "mm"#   #     "#mm"  "#mm"       │'
echo "│                                                                                   │"
echo "│                        Channel : t.me/botlua                                      │"
echo "└─────────────────────────────────────────────────────────────────────────────┘"
sudo apt-get install git screen redis-server shc lua5.2 liblua5.2-dev lua-lgi libnotify-dev unzip tmux -y
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev lua-socket lua-sec lua-expat libevent-dev make unzip git redis-server autoconf g++ libjansson-dev libpython-dev expat libexpat1-dev -y


sudo add-apt-repository ppa:ubuntu-toolchain-r/test  


sudo apt-get update -y
apt-get upgrade -y
sudo apt-get install libconfig++9v5 libstdc++6 -y
sudo apt autoremove -y
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz 
tar zxpf luarocks-2.2.2.tar.gz
rm luarocks-2.2.2.tar.gz
cd luarocks-2.2.2
./configure
sudo make bootstrap
cd ..
rm -rf luarocks-2*
wget https://valtman.name/files/telegram-bot-170904-nightly-linux
mv telegram-bot-170904-nightly-linux telegram-bot
chmod +x telegram-bot
rm -fr telegram-bot-170904-nightly-linux
sudo luarocks install luasocket
sudo luarocks install luasec
sudo luarocks install redis-lua
sudo luarocks install lua-term
sudo luarocks install serpent
sudo luarocks install dkjson
sudo luarocks install lanes
sudo luarocks install Lua-cURL
sudo service redis-server start
wget http://botlua.tk/keko.sh
wget http://botlua.tk/fix.sh
sudo chmod +x fix.sh
sudo chmod go-r fix.sh
sudo chmod +x keko.sh
sudo chmod 777 keko.sh
sudo chmod 777 fix.sh
sudo chmod go-r keko.sh
sudo chmod 777 run
sudo chmod 777 runAU

sudo ./fix.sh 

clear
echo " ──────────────────────────────────────────────────────────────────────────────"
echo "            Devloper : t.me/HHHHD | My Channel : t.me/botlua                   "
echo "                                                                               "
echo "┌─────────────────────────────────────────────────────────────────────────────┐"
echo "│                                                                                   │"
echo '│ m    m        #                                                                   │'
echo '│ #  m"   mmm   #   m   mmm           mmm    mmm   m   m   m mm   mmm    mmm        │'
echo '│ #m#    #"  #  # m"   #" "#         #   "  #" "#  #   #   #"  " #"  "  #"  #       │'
echo '│ #  #m  #""""  #"#    #   #          """m  #   #  #   #   #     #      #""""       │'
echo '│ #   "m "#mm"  #  "m  "#m#"         "mmm"  "#m#"  "mm"#   #     "#mm"  "#mm"       │'
echo "│                                                                                   │"
echo "│                        Channel : t.me/botlua                                      │"
echo "└─────────────────────────────────────────────────────────────────────────────┘"

echo "Done install"

./runAU


