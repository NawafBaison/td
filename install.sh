sudo apt-get update 

sudo apt-get upgrade -y 

sudo apt-get install git redis-server lua5.2 liblua5.2-dev lua-lgi libnotify-dev unzip tmux -y 

add-apt-repository ppa:ubuntu-toolchain-r/test -y

sudo apt-get update 

sudo apt-get upgrade -y

sudo apt-get install libconfig++9v5 libstdc++6 -y

sudo apt autoremove -y

wget http://luarocks.org/releases/luarocks-2.4.2.tar.gz &>/dev/null

tar zxpf luarocks-2.4.2.tar.gz &>/dev/null

cd luarocks-2.4.2

./configure --prefix=$PWD/.luarocks --sysconfdir=$PWD/.luarocks/luarocks --force-config &>/dev/null 
  
make bootstrap &>/dev/null

cd .. 

rm -rf luarocks*

wget --progress=bar:force https://valtman.name/files/telegram-bot-170904-nightly-linux 2>&1 

mv telegram-bot-170904-nightly-linux telegram-bot; chmod +x telegram-bot

mkdir $HOME/.telegram-bot; cat <<EOF > $HOME/.telegram-bot/config
default_profile = "main";
main = {
  lua_script = "$HOME/td/keko.lua";
};
EOF
