# Jarkom-Modul-2-A07-2023
**Praktikum Jaringan Komputer Modul 2 Tahun 2023**

## Author
| Nama | NRP |Github |
|---------------------------|------------|--------|
|Dimas Fadilah Akbar | 5025211010 | https://github.com/dimss113 |
|Kevin Nathanael Halim | 5025211140 | https://github.com/zetsux |

# Laporan Resmi
## Daftar Isi
- [Laporan Resmi](#laporan-resmi)
  - [Daftar Isi](#daftar-isi)
  - [Topologi](#topologi)
  - [Network Configuration](#network-configuration)
- [Soal 1](#soal-1)
- [Soal 2](#soal-2)
- [Soal 3](#soal-3)
- [Soal 4](#soal-4)
- [Soal 5](#soal-5)
- [Soal 6](#soal-6)
- [Soal 7](#soal-7)
- [Soal 8](#soal-8)
- [Soal 9](#soal-9)
- [Soal 10](#soal-10)
- [Soal 11](#soal-11)
- [Soal 12](#soal-12)
- [Soal 13](#soal-13)
- [Soal 14](#soal-14)
- [Soal 15](#soal-15)
- [Soal 16](#soal-16)
- [Soal 17](#soal-17)
- [Soal 18](#soal-18)
- [Soal 19](#soal-19)
- [Soal 20](#soal-20)


## Topologi

![topologi](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/7b3f50b8-1df3-485b-90fc-b780b3e90cb5)

## Network Configuration

- **Router**

```
auto eth0
 iface eth0 inet dhcp

 auto eth1
 iface eth1 inet static
 	address 192.172.1.1
 	netmask 255.255.255.0

 auto eth2
 iface eth2 inet static
 	address 192.172.2.1
 	netmask 255.255.255.0

```

- **ArjunaLoadBalancer**

```
auto eth0
 iface eth0 inet static
 	address 192.172.2.2
 	netmask 255.255.255.0
 	gateway 192.172.2.1

```

- **YudhitiraDNSMaster**

```
auto eth0
 iface eth0 inet static
 	address 192.172.2.4
 	netmask 255.255.255.0
 	gateway 192.172.2.1

```

- **WerkudaraDNSSlave**

```
auto eth0
 iface eth0 inet static
 	address 192.172.2.3
 	netmask 255.255.255.0
 	gateway 192.172.2.1

```

- **NakulaClient**

```
auto eth0
 iface eth0 inet static
 	address 192.172.1.2
 	netmask 255.255.255.0
 	gateway 192.172.1.1

```

- **SadewaClient**

```
auto eth0
 iface eth0 inet static
 	address 192.172.1.3
 	netmask 255.255.255.0
 	gateway 192.172.1.1

```

- **AbimanyuWebServer**

```
auto eth0
 iface eth0 inet static
 	address 192.172.1.4
 	netmask 255.255.255.0
 	gateway 192.172.1.1

```

- **PrabukusumaWebServer**

```
auto eth0
 iface eth0 inet static
 	address 192.172.1.5
 	netmask 255.255.255.0
 	gateway 192.172.1.1

```

- **WisanggeniWebServer**

```
auto eth0
 iface eth0 inet static
 	address 192.172.1.6
 	netmask 255.255.255.0
 	gateway 192.172.1.1

```

## Soal 2 
> Buatlah website utama dengan akses ke arjuna.yyy.com dengan alias www.arjuna.yyy.com dengan yyy merupakan kode kelompok


### Scripts

1. jalankan script berikut pada node **router** untuk memfilter IP apa saja yang dapat melakukan komunikasi melalui **router**.

```
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.172.0.0/16

```

2. jalankan script berikut pada node **YudhistiraDNSMaster** untuk instalasi bind9.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf
apt-get update
apt-get install bind9 -y


```

3. Masukkan konfigurasi zone berikut pada file `/etc/bind/named.conf.local` untuk mendaftarkan domain arjuna.a07.com pada node **YudhistiraDNSMaster**.

```
zone "arjuna.a07.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.a07.com";
};

```

4. Masukkan konfigurasi berikut ke dalam file `/etc/bind/jarkom/arjuna.a07.com`

```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.a07.com. root.arjuna.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arjuna.a07.com.
@       IN      A       192.172.2.2 ; IP arjuna
www     IN      CNAME   arjuna.a07.com.
@       IN      AAAA    ::1

```

5. Masukkan konfigurasi IP **YudhistiraDNSMaster** ke file `/etc/resolv.conf` pada client **(SadewaClient dan NakulaClient)**.

```
echo nameserver 192.172.2.4 > /etc/resolv.conf

```

### Bukti

1. Lakukan `ping` **arjuna.a07.com** pada client **(SadewaClient dan NakulaClient)**

![soal2-1](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/9cf4e6c7-413d-4541-9c8d-cb54ca594b1e)

![soal2-2](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/1d7f2b6e-4ca3-4ea5-83df-efdda812079c)


## Soal 3

> (Dengan cara yang sama seperti soal nomor 2, buatlah website utama dengan akses ke abimanyu.yyy.com dan alias www.abimanyu.yyy.com.)

### Scripts

1. Dengan cara yang sama seperti [soal-2](#soal-2), masukkan konfigurasi berikut pada file `/etc/bind/named.conf.local` di node **YudhistiraDNSMaster**.

```
zone "arjuna.a07.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.a07.com";
};

zone "abimanyu.a07.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.a07.com";
};


```

2. Masukkan konfigurasi berikut pada `/etc/bind/jarkom/abimanyu.a07.com` di node **YudhistiraDNSMaster**.

```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.a07.com. root.abimanyu.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      abimanyu.a07.com.
@       IN      A       192.172.1.4 ; IP Abimanyu
www     IN      CNAME   abimanyu.a07.com.
@       IN      AAAA    ::1


```

3. lakukan restart bind9 dengan command:

```
service bind9 restart

```

### Bukti

1. lakukan `ping abimanyu.a07.com*` dan `ping www.abimanyu.a07.com` pada salah satu client sebagai contoh adalah **SadewaClient**.

![soal3-1](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/4bc90194-175e-4e11-a082-b24d7aa91c7c)

![soal3-2](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/7f146434-9050-4ba1-aedb-340197cf27e9)


# Soal 4

> (Kemudian, karena terdapat beberapa web yang harus di-deploy, buatlah subdomain parikesit.abimanyu.yyy.com yang diatur DNS-nya di Yudhistira dan mengarah ke Abimanyu.)

### Scripts

1. Masukkan konfigurasi berikut pada file `/etc/bind/jarkom/abimanyu.a07.com` sebagai berikut pada **YudhistiraDNSMaster**.

```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.a07.com. root.abimanyu.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@              IN      NS      abimanyu.a07.com.
@              IN      A       192.172.1.4
www            IN      CNAME   abimanyu.a07.com.
parikesit      IN      A       192.172.1.4
www.parikesit  IN      CNAME   parikesit.abimanyu.a07.com.
@       IN      AAAA    ::1


```

### Bukti

1. Lakukan `ping parikesit.abimanyu.a07.com` dan `ping ww.parikesit.abimanyu.a07.com` pada client:

![soal4-1](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/8cc0ce9a-adc4-4520-93ae-ec0e32203d98)

![soal4-2](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/c681adb0-6940-4a0a-ae07-c0abc466f401)


# Soal 5

>  (Buat juga reverse domain untuk domain utama)

### Scripts

1. Membuat reverse DNS untuk **arjuna.a07.com** yang terhubung ke node **ArjunaLoadBalancer** dengan mengkonfigurasikan zone di **YudhistiraDNSMaster** `/etc/bind/named.conf.local` sebagai berikut:

```
zone "arjuna.a07.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.a07.com";
};

zone "abimanyu.a07.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.a07.com";
};

zone "2.172.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/2.172.192.in-addr.arpa";
};


```

2. Konfigurasikan pada file `/etc/bind/jarkom/2.172.192.in-addr.arpa` pada **YudhistiraDNSMaster**.

```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     arjuna.a07.com. root.arjuna.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
2.172.192.in-addr.arpa.   IN      NS      arjuna.a07.com.
2                         IN      PTR     arjuna.a07.com.


```

3. Jalankan command berikut untuk instalasi **dnsutils**:

```
echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install dnsutils

echo nameserver 192.172.2.4 > /etc/resolv.conf

```

4. Membuat reverse DNS untuk **abimanyu.a07.com** yang terhubung ke node AbimanyuWebServer dengan mengkonfigurasikan zone di **YudhistiraDNSMaster** pada file `/etc/bind/named.conf.local` sebagai berikut:

```
zone "arjuna.a07.com" {
        type master;
        file "/etc/bind/jarkom/arjuna.a07.com";
};

zone "abimanyu.a07.com" {
        type master;
        file "/etc/bind/jarkom/abimanyu.a07.com";
};

zone "2.172.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/2.172.192.in-addr.arpa";
};

zone "1.172.192.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/1.172.192.in-addr.arpa";
};


```

5. Konfigurasi pada file `/etc/bind/jarkom/1.172.192.in-addr.arpa` sebagai berikut:

```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.a07.com. root.abimanyu.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
1.172.192.in-addr.arpa.   IN      NS      abimanyu.a07.com.
4                         IN      PTR     abimanyu.a07.com.

```

### Bukti

1. gunakan command berikut untuk melihat pointer reverse dns dari **arjuna.a07.com**

```
host -t PTR 192.172.2.2

```

![soal5-1](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/5d85e41c-85a0-4b1d-9d47-a60366eca45a)

2. gunakan command berikut untuk melihat pinter reverse dns dari **abimanyu.a07.com**

```
host -t PTR 192.172.1.4

```

![soal5-2](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/027b35dd-cfcb-402a-a084-73d28e6b48a2)


## Soal 6

> (Agar dapat tetap dihubungi ketika DNS Server Yudhistira bermasalah, buat juga Werkudara sebagai DNS Slave untuk domain utama.)

### Scripts

1. Tambahkan konfigurasi berikut pada `/etc/bind/named.conf.local` pada **YudhistiraDNSMaster**

```
zone "arjuna.a07.com" {
        type master;
        notify yes;
        also-notify { 192.172.2.3; }; // IP Werkudara
        allow-transfer { 192.172.2.3; }; // IP Werkudara
        file "/etc/bind/jarkom/arjuna.a07.com";
};

zone "abimanyu.a07.com" {
        type master;
        notify yes;
        also-notify { 192.172.2.3; }; // IP Werkudara
        allow-transfer { 192.172.2.3; }; // IP Werkudara
        file "/etc/bind/jarkom/abimanyu.a07.com";
};

zone "2.172.192.in-addr.arpa" {
    type master;
    file "/etc/bind/jarkom/2.172.192.in-addr.arpa";
};

zone "1.172.192.in-addr.arpa" {
        type master;
        file "/etc/bind/jarkom/1.172.192.in-addr.arpa";
};


```

2. Instalasi bind9 pada **WerkudaraDNSSlave** dan konfigurasi file `/etc/bind/named.conf.local` sebagai berikut:

```
zone "arjuna.a07.com" {
    type slave;
    masters { 192.172.2.4; }; // IP Yudhistira
    file "/var/lib/bind/arjuna.a07.com";
};

zone "abimanyu.a07.com" {
    type slave;
    masters { 192.172.2.4; }; // IP Yudhistira
    file "/var/lib/bind/abimanyu.a07.com";
};


```

3. lakukan restart bind9

```
service bind9 restart
```

4. lakukan stop bind9 pada **YudhistiraDNSMaster**

```
service bind9 stop
```

## Bukti

1. Lakukan `ping abimanyu.a07.com`.

![soal6-1](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/24ba4edb-a1bc-43be-ac09-c555fd36e098)


2. Lakukan `ping arjuna.a07.com`.

![soal6-2](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/3481208d-2be9-4277-8cd9-239f4e1e034b)


## Soal 7 

> (Seperti yang kita tahu karena banyak sekali informasi yang harus diterima, buatlah subdomain khusus untuk perang yaitu baratayuda.abimanyu.yyy.com dengan alias www.baratayuda.abimanyu.yyy.com yang didelegasikan dari Yudhistira ke Werkudara dengan IP menuju ke Abimanyu dalam folder Baratayuda.)

### Scripts

1. Konfigurasi file `/etc/bind/jarkom/abimanyu.a07.com` pada **YudhistiraDNSMaster**

```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     abimanyu.a07.com. root.abimanyu.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@              IN      NS      abimanyu.a07.com.
@              IN      A       192.172.1.4
www            IN      CNAME   abimanyu.a07.com.
parikesit      IN      A       192.172.1.4
www.parikesit  IN      CNAME   parikesit.abimanyu.a07.com.
baratayuda     IN      NS      ns1.abimanyu.a07.com.
ns1            IN      A       192.172.2.3      ; IP Werkudara
@       IN      AAAA    ::1


```

2. Konfigurasi file `/etc/bind/named.conf.options` pada node **YudhistiraDNSMaster**.

```
options {
        directory "/var/cache/bind";
        allow-query{any;};

        listen-on-v6 { any; };
};


```

3. Lakukan restart bind9.

```
service bind9 restart

```



4. Konfigurasi file `/etc/bind/named.conf.local` pada **WerkudaraDNSSlave**.

```
zone "arjuna.a07.com" {
    type slave;
    masters { 192.172.2.4; }; // IP Yudhistira
    file "/var/lib/bind/arjuna.a07.com";
};

zone "abimanyu.a07.com" {
    type slave;
    masters { 192.172.2.4; }; // IP Yudhistira
    file "/var/lib/bind/abimanyu.a07.com";
};

zone "baratayuda.abimanyu.a07.com" {
    type master;
    file "/etc/bind/baratayuda/baratayuda.abimanyu.a07.com";
};


```

5. Konfigurasi file `/etc/bind/baratayuda/baratayuda.abimanyu.a07.com`.

```
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.a07.com. root.baratayuda.abimanyu.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                       IN      NS      baratayuda.abimanyu.a07.com.
@                       IN      A       192.172.1.4 ; IP Abimanyu
www                     IN      CNAME   baratayuda.abimanyu.a07.com.
@                       IN      AAAA    ::1


```

6. Konfigurasi file `/etc/bind/named.conf.options` pada node **WerkudaraDNSSlave**.

```
options {
        directory "/var/cache/bind";

        allow-query{any;};

        listen-on-v6 { any; };
};

```

7. Lakukan restart bind9 pada **WerkudaraDNSSlave**.

```
service bind9 restart
```

8. Lakukan stop bind9 pada **YudhistiraDNSMaster**.

```
service bind9 stop

```

### Bukti

1. Lakukan `ping baratayuda.abimanyu.a07.com` pada client:

![soal7-1](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/f234738c-72a5-4fd7-8bcd-2b30a4803ae2)

2. Lakukan `ping www.baratayuda.abimanyu.a07.com` pada client:

![soal7-1](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/f234738c-72a5-4fd7-8bcd-2b30a4803ae2)


## Soal 8 

>  (Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.)

### Scripts

1. Tambahkan konfigurasi berikut pada file `/etc/bind/named.conf.local` pada node **WerkudaraDNSSlave**.

```
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     baratayuda.abimanyu.a07.com. root.baratayuda.abimanyu.a07.com. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@                       IN      NS      baratayuda.abimanyu.a07.com.
@                       IN      A       192.172.1.4 ; IP Abimanyu
www                     IN      CNAME   baratayuda.abimanyu.a07.com.
rjp                     IN      A       192.172.1.4 ; IP Abimanyu
www.rjp                 IN      CNAME   rjp.baratayuda.abimanyu.a07.com.
@                       IN      AAAA    ::1


```

2. Lakukan restart bind9 pada **WerkudaraDNSSlave**.

```
service bind9 restart
```

### Bukti

1. Lakukan `ping www.rjp.baratayuda.abimanyu.a07.com`.

![soal8](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/3b8f6e8b-4f97-445c-bc23-012f1e84f3d5)


## Soal 9

> (Arjuna merupakan suatu Load Balancer Nginx dengan tiga worker yaitu Prabakusuma, Abimanyu, dan Wisanggeni. Lakukan deployment pada masing-masing worker.)

### Scripts

1. Jalankan command berikut pada node **PrabukusumaWebService**

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update && apt install nginx php php-fpm -y


# Buat folder jarkom
mkdir /var/www/jarkom


# echo ke file /var/www/jarkom/index.php
echo '<?php
echo "Hello World from prabukusuma";
?>' > /var/www/jarkom/index.php


echo '
 server {


        listen 80;


        root /var/www/jarkom;


        index index.php index.html index.htm;
        server_name _;


        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }


        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
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

```

2. Jalankan command berikut pada node **AbimanyuWebServer**.

```
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


  listen 80;


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

```

3. Jalankan command berikut pada node **WisanggeniWebServer**.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update && apt install nginx php php-fpm -y


# Buat folder jarkom
mkdir /var/www/jarkom


# echo ke file /var/www/jarkom/index.php
echo '<?php
echo "Hello World from wisanggeni";
?>' > /var/www/jarkom/index.php


echo '
 server {


        listen 80;


        root /var/www/jarkom;


        index index.php index.html index.htm;
        server_name _;


        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }


        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
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

```

4. Jalankan command berikut pada node **ArjunaLoadBalancer**.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update


# Install bind9
apt-get install bind9 nginx -y


echo ' # Default menggunakan Round Robin
 upstream myweb  {
  server 192.172.1.5 #IP Prabukusuma
  server 192.172.1.4 #IP Abimanyu
    server 192.172.1.6#IP Wisanggeni
 }


 server {
  listen 80;
  server_name arjuna.a07.com www.arjuna.a07.com;


  location / {
  proxy_pass http://myweb;
  }
 }' > /etc/nginx/sites-available/lb-jarkom


ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled/lb-jarkom




service nginx restart

```


## Soal 10

1. Ubah konfigurasi file `/etc/nginx/sites-available/jarkom` pada node **PrabukusumaWebServer**.

```
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
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }


 location ~ /\.ht {
                        deny all;
        }


        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom

```

2. Ubah konfigurasi file `/etc/nginx/sites-available/jarkom` pada node **AbimanyuWebServer**.

```
echo '
 server {


  listen 8001;


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
```

3. Ubah konfigurasi file `/etc/nginx/sites-available/jarkom` pada node **WisanggeniWebServer**.

```
echo '
 server {


        listen 8003;


        root /var/www/jarkom;


        index index.php index.html index.htm;
        server_name _;


        location / {
                        try_files $uri $uri/ /index.php?$query_string;
        }


        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }


 location ~ /\.ht {
                        deny all;
        }


        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
 }
' > /etc/nginx/sites-available/jarkom

```

4. Jalankan command berikut pada node **ArjunaLoadBalancer**.

```
echo nameserver 192.168.122.1 > /etc/resolv.conf


apt-get update


# Install bind9
apt-get install bind9 nginx -y


echo ' # Default menggunakan Round Robin
 upstream myweb  {
  server 192.172.1.5:8001; #IP Prabukusuma
  server 192.172.1.4:8002; #IP Abimanyu
  server 192.172.1.6:8003; #IP Wisanggeni
 }


 server {
  listen 80;
  server_name arjuna.a07.com www.arjuna.a07.com;


  location / {
  proxy_pass http://myweb;
  }
 }' > /etc/nginx/sites-available/lb-jarkom


ln -s /etc/nginx/sites-available/lb-jarkom /etc/nginx/sites-enabled/lb-jarkom




service nginx restart


```

### Bukti

1. lakukan `lynx arjuna.a07.com`.

![soal10-1](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/7639443f-a5ee-4ad3-b48c-6ecf2f6e52f8)

![soal10-2](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/0d925a60-1126-443b-909e-e661c24812b2)

![soal10-3](https://github.com/dimss113/Jarkom-Modul-2-A07-2023/assets/89715780/5b535fb0-c817-4228-9184-86fa84e4599b)
