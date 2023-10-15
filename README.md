# Jarkom-Modul-2-A07-2023

**Praktikum Jaringan Komputer Modul 2 Tahun 2023**

## Author

| Nama                  | NRP        | Github                      |
| --------------------- | ---------- | --------------------------- |
| Dimas Fadilah Akbar   | 5025211010 | https://github.com/dimss113 |
| Kevin Nathanael Halim | 5025211140 | https://github.com/zetsux   |

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

> (Buat juga reverse domain untuk domain utama)

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

> (Untuk informasi yang lebih spesifik mengenai Ranjapan Baratayuda, buatlah subdomain melalui Werkudara dengan akses rjp.baratayuda.abimanyu.yyy.com dengan alias www.rjp.baratayuda.abimanyu.yyy.com yang mengarah ke Abimanyu.)

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

## Soal 11

> Selain menggunakan Nginx, lakukan konfigurasi Apache Web Server pada worker Abimanyu dengan web server www.abimanyu.yyy.com. Pertama dibutuhkan web server dengan DocumentRoot pada /var/www/abimanyu.yyy

### Penyelesaian

1. Lakukan instalasi terhadap semua hal yang diperlukan,

```bash
apt-get install apache2
apt-get install wget
apt-get install unzip
```

2. Import file dari google drive yang disediakan untuk mengisi `/var/www` dari abimanyu.a07.com,

```bash
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc' -O abi
```

3. Lakukan unzip dan sesuaikan struktur folder untuk tepat berada di dalam `/var/www/abimanyu.a07`

```bash
unzip abi -d abimanyu.a07
rm abi
mv abimanyu.a07/abimanyu.yyy.com/* abimanyu.a07
rmdir abimanyu.a07/abimanyu.yyy.com
```

4. Buat file `abimanyu.a07.conf` pada `/etc/apache2/sites-available` dan copy isi dari file `000-default.conf` ke dalamnya

```bash
cp 000-default.conf abimanyu.a07.conf
```

5. Di dalam tag `VirtualHost`, isi dengan konfigurasi nama server, alias server, admin server dan pasang DocumentRoot pada `/var/www/abimanyu.a07` yang tadi sudah diisi

   ![soal11-1](https://cdn.discordapp.com/attachments/997158382429548574/1163121180111278130/image.png?ex=653e6c03&is=652bf703&hm=445f653212963365d9a8b03f106a376c3da6231b57970ef4c2ce49aa42a8399c&)

### Bukti

Hasil dari `lynx abimanyu.a07.com` :

![bukti11](https://cdn.discordapp.com/attachments/997158382429548574/1163121923786547371/image.png?ex=653e6cb4&is=652bf7b4&hm=dd0a7bb64854a3df3db17c0824b0481f079e447151bf9d6326fe2fc550dc1b52&)

## Soal 12

> Setelah itu ubahlah agar url www.abimanyu.yyy.com/index.php/home menjadi www.abimanyu.yyy.com/home.

### Penyelesaian

1. Buka file `/etc/apache2/sites-available/abimanyu.a07.conf`

2. Tambahkan konfigurasi di dalam tag VirtualHost untuk membuat directory `/var/www/abimanyu.a07` dapat melakukan directory listing dengan memberikan "Options +Indexes" dan berikan alias untuk `/var/www/abimanyu.a07/index.php/home` menjadi `/home`

   ![soal12-1](https://cdn.discordapp.com/attachments/997158382429548574/1163122531562168510/image.png?ex=653e6d45&is=652bf845&hm=83d9be21bffdf06a97276d77fb01d699f7345825c7e27f20e3debbb6174280d2&)

### Bukti

Hasil dari `lynx abimanyu.a07.com/home` :

![bukti12](https://cdn.discordapp.com/attachments/997158382429548574/1163123745267912785/image.png?ex=653e6e66&is=652bf966&hm=8e7d3205c4ccc6003cc639647e8138516cfca26cdfc3ce49a5a5c3f43c0106f9&)

## Soal 13

> Selain itu, pada subdomain www.parikesit.abimanyu.yyy.com, DocumentRoot disimpan pada /var/www/parikesit.abimanyu.yyy

### Penyelesaian

1. Import file dari google drive yang disediakan untuk mengisi `/var/www` dari parikesit.abimanyu.a07.com,

```bash
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS' -O pari
```

2. Lakukan unzip dan sesuaikan struktur folder untuk tepat berada di dalam `/var/www/parikesit.abimanyu.a07/abimanyu.a07`

```bash
unzip pari -d parikesit.abimanyu.a07
rm pari
mv parikesit.abimanyu.a07/parikesit.abimanyu.yyy.com/* parikesit.abimanyu.a07
rmdir parikesit.abimanyu.a07/parikesit.abimanyu.yyy.com
```

3. Buat directory `secret` di dalam directory `/var/www/parikesit.abimanyu.a07/abimanyu.a07` dan isi dengan sebuah file html bebas

```bash
mkdir parikesit.abimanyu.a07/secret
cd parikesit.abimanyu.a07/secret
echo '# Ini halaman html bebas, disuruh bikin sama mba2 taiwan' > bebas.html
```

4. Buat file `parikesit.abimanyu.a07.conf` pada `/etc/apache2/sites-available` dan copy isi dari file `000-default.conf` ke dalamnya

```bash
cp 000-default.conf parikesit.abimanyu.a07.conf
```

5. Di dalam tag `VirtualHost`, isi dengan konfigurasi nama server, alias server, admin server dan pasang DocumentRoot pada `/var/www/parikesit.abimanyu.a07` yang tadi sudah diisi

   ![soal13-1](https://cdn.discordapp.com/attachments/997158382429548574/1163125121138053120/image.png?ex=653e6fae&is=652bfaae&hm=60d456eb85aa4a10183417aa7309901f364111c344cb6b3abad8a2637f95fbfa&)

### Bukti

Hasil dari `lynx parikesit.abimanyu.a07.com` :

![bukti13](https://cdn.discordapp.com/attachments/997158382429548574/1163125839207071844/image.png?ex=653e7059&is=652bfb59&hm=59ee871555f2c6bbe9e773f405d8633f1c760cadc90cb2f12318cb85bdb65965&)

## Soal 14

> Pada subdomain tersebut folder /public hanya dapat melakukan directory listing sedangkan pada folder /secret tidak dapat diakses (403 Forbidden).

### Penyelesaian

1. Buka file `/etc/apache2/sites-available/parikesit.abimanyu.a07.conf`

2. Tambahkan konfigurasi di dalam tag VirtualHost untuk membuat directory `/var/www/abimanyu.a07/public` dapat melakukan directory listing dengan memberikan "Options +Indexes" dan buat directory `/var/www/abimanyu.a07/secret` tidak dapat diakses dengan memberikan "Options -Indexes"

   ![soal14-1](https://cdn.discordapp.com/attachments/997158382429548574/1163131615908741140/image.png?ex=653e75bb&is=652c00bb&hm=af5832b71d6d614a8023ef3d92104ba5242a3c706e5d888a7756d2d5f59865a2&)

### Bukti

- Hasil dari `lynx parikesit.abimanyu.a07.com/public` :

  ![bukti14-1](https://cdn.discordapp.com/attachments/997158382429548574/1163131886290354297/image.png?ex=653e75fb&is=652c00fb&hm=9470af6412d831a69f7b908e87aa3c6ba483d8c2789691ea578bc639aec15614&)

- Hasil dari `lynx parikesit.abimanyu.a07.com/secret` :

  ![bukti14-2](https://cdn.discordapp.com/attachments/997158382429548574/1163131940598190180/image.png?ex=653e7608&is=652c0108&hm=2726ba9cdd387d60268944c3c937fe94f1507e6eaa09d5095b84641050794add&)

## Soal 15

> Buatlah kustomisasi halaman error pada folder /error untuk mengganti error kode pada Apache. Error kode yang perlu diganti adalah 404 Not Found dan 403 Forbidden.

### Penyelesaian

1. Buka file `/etc/apache2/sites-available/parikesit.abimanyu.a07.conf`

2. Tambahkan konfigurasi di dalam tag VirtualHost untuk membuat halaman error dengan kode 404 agar diarahkan ke `/error/404.html` dan kode 403 diarahkan ke `/error/403.html

   ![soal15-1](https://cdn.discordapp.com/attachments/997158382429548574/1163132356824141954/image.png?ex=653e766b&is=652c016b&hm=8871d8b944e0ca297900f5e6129c3b1683667dc787ee39489caa644206098bfd&)

### Bukti

- Hasil dari `lynx parikesit.abimanyu.a07.com/a` (404 Not Found) :

  ![bukti15-1](https://cdn.discordapp.com/attachments/997158382429548574/1163132608008437830/image.png?ex=653e76a7&is=652c01a7&hm=009d9e5f433a36fa587a5210ad61a973109451c89dbaadec1d1f564ec7ce7b58&)

- Hasil dari `lynx parikesit.abimanyu.a07.com/secret` (403 Forbidden) :

  ![bukti15-2](https://cdn.discordapp.com/attachments/997158382429548574/1163132657945821204/image.png?ex=653e76b3&is=652c01b3&hm=fb588da8f22ba5de20ca1e4d6eb92009d6dcb87ccf8ca562c678d458d3e3a758&)

## Soal 16

> Buatlah suatu konfigurasi virtual host agar file asset www.parikesit.abimanyu.yyy.com/public/js menjadi www.parikesit.abimanyu.yyy.com/js

### Penyelesaian

1. Buka file `/etc/apache2/sites-available/parikesit.abimanyu.a07.conf`

2. Tambahkan konfigurasi di dalam tag VirtualHost untuk membuat alias terhadap `/var/www/parikesit.abimanyu.a07/public/js` menjadi `/js`

   ![soal16-1](https://cdn.discordapp.com/attachments/997158382429548574/1163133351796949033/image.png?ex=653e7759&is=652c0259&hm=f570ced454dc8d6d914a5ca0e70c8f4b8c43f5ad527dbcb5ce0113690997c837&)

### Bukti

Hasil dari `lynx parikesit.abimanyu.a07.com/js` :

![bukti16](https://cdn.discordapp.com/attachments/997158382429548574/1163133495003070464/image.png?ex=653e777b&is=652c027b&hm=7415402a8bf44c9a32c2bd15868f5d608a52ce48775577e060ccefcb22b912f8&)

## Soal 17

> Agar aman, buatlah konfigurasi agar www.rjp.baratayuda.abimanyu.yyy.com hanya dapat diakses melalui port 14000 dan 14400.

### Penyelesaian

1. Buka file `/etc/apache2/ports.conf` dan tambahkan 2 baris konfigurasi untuk melakukan Listen terhadap port 14000 dan 14400

```bash
Listen 14000
Listen 14400
```

2. Import file dari google drive yang disediakan untuk mengisi `/var/www` dari rjp.baratayuda.abimanyu.a07.com,

```bash
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6' -O rjp
```

3. Lakukan unzip dan sesuaikan struktur folder untuk tepat berada di dalam `/var/www/rjp.baratayuda.abimanyu.a07/abimanyu.a07`

```bash
unzip rjp -d rjp.baratayuda.abimanyu.a07
rm rjp
mv rjp.baratayuda.abimanyu.a07/rjp.baratayuda.abimanyu.yyy.com/* rjp.baratayuda.abimanyu.a07
rmdir rjp.baratayuda.abimanyu.a07/rjp.baratayuda.abimanyu.yyy.com
```

4. Buat file `rjp.baratayuda.abimanyu.a07.conf` pada `/etc/apache2/sites-available`

```bash
nano rjp.baratayuda.abimanyu.a07.conf
```

5. Isi file tersebut dengan konfigurasi untuk port 14000 dan 14400 dengan masing-masing tag VirtualHost memiliki properti nama server, alias server, admin server, dan DocumentRoot yang diarahken pada `/var/www/rjp.baratayuda.abimanyu.a07`

   ![soal17-1](https://cdn.discordapp.com/attachments/997158382429548574/1163134775687663798/image.png?ex=653e78ac&is=652c03ac&hm=e601caa19f5b4f5773b604ddfae5f5263f52509ba5079324108035327803e9a5&)

### Bukti

- Hasil dari curl terhadap port 14000 dan 14400 :

  ![bukti17-1](https://cdn.discordapp.com/attachments/997158382429548574/1163135218555830477/image.png?ex=653e7916&is=652c0416&hm=5e6f58c57fed2292fc042c0589993414768265de107c3b17fdb74c1190d1e69d&)

  ![bukti17-2](https://cdn.discordapp.com/attachments/997158382429548574/1163135273190838322/image.png?ex=653e7923&is=652c0423&hm=3c00123570a8558890d2ee199d63f12509b0baa3b685669ca29d0fb5f872d5d5&)

- Hasil dari curl terhadap port selain dua yang diperbolehkan :

  ![bukti17-3](https://cdn.discordapp.com/attachments/997158382429548574/1163135456431587328/image.png?ex=653e794e&is=652c044e&hm=041ae36c8e5f0a154bc1b5f0d0d5aff05a7ff318eb7930308ea791c1a08a74eb&)

## Soal 18

> Untuk mengaksesnya buatlah autentikasi username berupa “Wayang” dan password “baratayudayyy” dengan yyy merupakan kode kelompok. Letakkan DocumentRoot pada /var/www/rjp.baratayuda.abimanyu.yyy.

### Penyelesaian

1. Daftarkan "Wayang" sebagai username dan "baratayuda07" sebagai password untuk kredensial autentikasi ke dalam `/etc/apache2/passwords`

   ![soal18-1](https://cdn.discordapp.com/attachments/997158382429548574/1163142789333270528/image.png?ex=653e8023&is=652c0b23&hm=e88fc03768eefafc7800ed5eea4ba2fbe5775dd34ceee530cd36810e283fe599&)

2. Buka file `/etc/apache2/sites-available/rjp.baratayuda.abimanyu.a07.conf`

3. Tambahkan konfigurasi di dalam setiap tag VirtualHost untuk mengaktifkan autentikasi dengan tipe auth basic, nama auth "Authentication Required", AuthUserFile yang diarahkan pada `/etc/apache2/passwords`

   ![soal18-2](https://cdn.discordapp.com/attachments/997158382429548574/1163144072148557885/image.png?ex=653e8154&is=652c0c54&hm=1e51dadfa11fa973f4af724139d61a96a32ba87be3098e83432f5c6a6f499a78&)

### Bukti

- Hasil dari curl terhadap port 14000 dan 14400 dengan Authentication :

  ![bukti18-1](https://cdn.discordapp.com/attachments/997158382429548574/1163145296977612800/image.png?ex=653e8278&is=652c0d78&hm=a8985d88bad78963354d85628d38a93f8f96a552116e876a56c9f7840255c260&)

- Hasil dari curl terhadap port 14000 dan 14400 tanpa Authentication :

  ![bukti18-3](https://cdn.discordapp.com/attachments/997158382429548574/1163145347799994428/image.png?ex=653e8285&is=652c0d85&hm=6a6fde1c39e71ad6b3b5fe44e05c8cd2ed7577aa499174319e808bc7a59f1177&)

## Soal 19

> Buatlah agar setiap kali mengakses IP dari Abimanyu akan secara otomatis dialihkan ke www.abimanyu.yyy.com (alias)

### Penyelesaian

1. Buka file `/etc/apache2/sites-available/000-default.conf`

2. Tambahkan konfigurasi di dalam tag VirtualHost untuk melakukan redirect dari IP Abimanyu ke `abimanyu.a07.com` dan ubah nama server menjadi IP Abimanyu yakni 192.172.1.4

   ![soal19-1](https://cdn.discordapp.com/attachments/997158382429548574/1163146374414602351/image.png?ex=653e8379&is=652c0e79&hm=f95bb1bcba2960a12a3b43e030e982086a345a507810b11c2f1f14341af7ea87&)

### Bukti

Hasil dari `lynx 192.172.1.4` :

![bukti19-1](https://cdn.discordapp.com/attachments/997158382429548574/1163147227699613807/image.png?ex=653e8445&is=652c0f45&hm=c95231192e4ab71259d04b9707351a7fcab164a50e6bc214b83e6438c1c7fe8b&)

![bukti19-2](https://cdn.discordapp.com/attachments/997158382429548574/1163147377125904394/image.png?ex=653e8468&is=652c0f68&hm=77668555b641d187b0e85c8379b0591ca2147d4b92b6cfe71a7dc140a66bfe60&)

## Soal 20

> Karena website www.parikesit.abimanyu.yyy.com semakin banyak pengunjung dan banyak gambar gambar random, maka ubahlah request gambar yang memiliki substring “abimanyu” akan diarahkan menuju abimanyu.png.

### Penyelesaian

1. Aktifkan module rewrite

```bash
a2enmod rewrite
```

2. Buka file `/etc/apache2/sites-available/parikesit.abimanyu.a07.conf`

3. Tambahkan konfigurasi di dalam tag VirtualHost untuk melakukan redirect ketika mengakses file dengan ekstensi gambar yang mengandung nama "abimanyu" ke `abimanyu.png`

   ![soal20-1](https://cdn.discordapp.com/attachments/997158382429548574/1163148084671434793/image.png?ex=653e8511&is=652c1011&hm=77c1dae08ccb71ecc2254bde1b07c3ff9067762d3982d6d6d9e2cca6a8aeef07&)

### Bukti

Hasil dari `lynx parikesit.abimanyu.a07.com/public/images/not-abimanyu.png` :

![bukti20](https://cdn.discordapp.com/attachments/997158382429548574/1163148584187859065/image.png?ex=653e8588&is=652c1088&hm=5841d7f3aa740894852adf5c94f46204b904d60dedff697f5d688b515ae40908&)
