# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\0
33[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dirco
lors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update && apt install nginx php php-fpm -y

# Buat folder jarkom
mkdir /var/www/jarkom

# echo ke file /var/www/jarkom/index.php
echo '<?php
echo "Hello World from abimanyu";
?>' > /var/www/jarkom/index.php


echo '
 server {

        listen 8002;

        root /var/www/jarkom;

        index index.php index.html index.htm;
        server_name _;

        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }

    location ~ /\.ht {
                        deny all;
        }

        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom


ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom
rm /etc/nginx/sites-enabled/default

service nginx restart
service php7.0-fpm stop
service php7.0-fpm start



# No. 11 & 12 (Alias Home)
apt-get install apache2 -y
apt-get install wget -y
apt-get install unzip -y
apt-get install php -y
apt-get install libapache2-mod-php7.0 -y

cd /var/www
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1a4V2
3hwK9S7hQEDEcv9FL14UkkrHc-Zc' -O abi
unzip abi -d abimanyu.a07
rm abi
mv abimanyu.a07/abimanyu.yyy.com/* abimanyu.a07
rmdir abimanyu.a07/abimanyu.yyy.com

echo "<VirtualHost *:80>
        ServerName abimanyu.a07.com
        ServerAlias www.abimanyu.a07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/abimanyu.a07

                                <Directory /var/www/abimanyu.a07>
                                                Options +Indexes
                                </Directory>

                                Alias "/home" "/var/www/abimanyu.a07/index.php/h
ome"

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet" > /etc/apache2/sites-available/abi
manyu.a07.conf

# No. 13, 14 (Dir Listing), 15 (Error Page), 16 (Alias)
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1LdbY
ntiYVF_NVNgJis1GLCLPEGyIOreS' -O pari
unzip pari -d parikesit.abimanyu.a07
rm pari
mv parikesit.abimanyu.a07/parikesit.abimanyu.yyy.com/* parikesit.abimanyu.a07
rmdir parikesit.abimanyu.a07/parikesit.abimanyu.yyy.com
mkdir parikesit.abimanyu.a07/secret
cd parikesit.abimanyu.a07/secret
echo '# Ini halaman html bebas, disuruh bikin sama mba2 taiwan' > bebas.html

echo '<VirtualHost *:80>
        ServerName parikesit.abimanyu.a07.com
        ServerAlias www.parikesit.abimanyu.a07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/parikesit.abimanyu.a07

        RewriteEngine On
        RewriteCond %{REQUEST_URI} abimanyu
        RewriteRule ^(.+)\.(png|jpg|jpeg|webp)$ /abimanyu.png [L,R=301]

                                <Directory /var/www/parikesit.abimanyu.a07/publi
c>
                                                Options +Indexes
                                </Directory>

                                <Directory /var/www/parikesit.abimanyu.a07/secre
t>
                                                Options -Indexes
                                </Directory>

                                Alias "/js" "/var/www/parikesit.abimanyu.a07/pub
lic/js"

                                ErrorDocument 404 /error/404.html
                                ErrorDocument 403 /error/403.html

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/sites-available/par
ikesit.abimanyu.a07.conf

# No. 17
echo 'Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>' > /etc/apache2/ports.conf

cd /var/www
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1pPSP
7yIR05JhSFG67RVzgkb-VcW9vQO6' -O rjp
unzip rjp -d rjp.baratayuda.abimanyu.a07
rm rjp
mv rjp.baratayuda.abimanyu.a07/rjp.baratayuda.abimanyu.yyy.com/* rjp.baratayuda.
abimanyu.a07
rmdir rjp.baratayuda.abimanyu.a07/rjp.baratayuda.abimanyu.yyy.com

# No. 18
htpasswd -cb /etc/apache2/passwords Wayang baratayudaa07

echo '<VirtualHost *:14000>
        ServerName rjp.baratayuda.abimanyu.a07.com
        ServerAlias www.rjp.baratayuda.abimanyu.a07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.a07

        <Directory /var/www/rjp.baratayuda.abimanyu.a07>
            AuthType Basic
            AuthName "Authentication Required"
            AuthUserFile /etc/apache2/passwords
            Require user Wayang
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<VirtualHost *:14400>
        ServerName rjp.baratayuda.abimanyu.a07.com
        ServerAlias www.rjp.baratayuda.abimanyu.a07.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.a07

        <Directory /var/www/rjp.baratayuda.abimanyu.a07>
            AuthType Basic
            AuthName "Authentication Required"
            AuthUserFile /etc/apache2/passwords
            Require user Wayang
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/sites-available/rjp
.baratayuda.abimanyu.a07.conf

# No. 19
echo '<VirtualHost *:80>
        ServerName 192.172.1.4
        Redirect permanent / http://www.abimanyu.a07.com/
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' > /etc/apache2/sites-available/000
-default.conf

# No. 20

a2enmod rewrite

cd /etc/apache2/sites-available

a2ensite abimanyu.a07.conf
a2ensite parikesit.abimanyu.a07.conf
a2ensite rjp.baratayuda.abimanyu.a07
service apache2 restart