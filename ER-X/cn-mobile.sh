#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
pppoe_config="/config/pppoe.conf"

function set_pppoe_user1(){
    while true
        do
        echo -e "请输入eth1端口PPPoE帐号"
        read -e -p user1
        echo && echo "================"
        ehco -e " PPPoE1帐号： ${user1}"
        done
}

function set_pppoe_pass1(){
    while true
        do
        echo -e "请输入eth1端口PPPoE帐号"
        read -e -p pass1
        echo && echo "================"
        ehco -e " PPPoE1帐号： ${pass1}"
        done
}

function set_pppoe_user2(){
    while true
        do
        echo -e "请输入eth1端口PPPoE帐号"
        read -e -p user2
        echo && echo "================"
        ehco -e " PPPoE1帐号： ${user2}"
        done
}

function set_pppoe_pass2(){
    while true
        do
        echo -e "请输入eth1端口PPPoE帐号"
        read -e -p pass2
        echo && echo "================"
        ehco -e " PPPoE1帐号： ${pass2}"
        done
}

function system_service(){
    set system time-zone Asia/Shanghai
    set system name-server 119.29.29.29
    set system name-server 223.5.5.5
}

function dhcp_server(){
    set interfaces ethernet eth0 address 192.168.1.1/24
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 start 192.168.1.200 stop 192.168.1.250
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 default-router 192.168.1.1
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 dns-server 223.5.5.5
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 dns-server 119.29.29.29
    set service dhcp-server shared-network-name LAN subnet 192.168.1.0/24 lease 600
}

function enable_pppoe(){
    set interfaces ethernet eth1 pppoe 1 user-id ${user1}
    set interfaces ethernet eth1 pppoe 1 password ${pass1}
    set interfaces ethernet eth1 pppoe 1 default-route none
    set interfaces ethernet eth1 pppoe 1 name-server none
    set interfaces ethernet eth2 pppoe 2 user-id ${user2}
    set interfaces ethernet eth2 pppoe 2 password ${pass2}
    set interfaces ethernet eth2 pppoe 2 default-route none
    set interfaces ethernet eth2 pppoe 2 name-server none
}

function enable_nat(){
    set service nat rule 5001 outbound-interface pppoe1
    set service nat rule 5001 type masquerade
    set service nat rule 5002 outbound-interface pppoe2
    set service nat rule 5002 type masquerade
}

function set_static_route(){
    set protocols static interface-route 0.0.0.0/0 next-hop-interface pppoe1 distance 4
    set protocols static interface-route 0.0.0.0/0 next-hop-interface pppoe2 distance 16
    set protocols static table 2 interface-route 0.0.0.0/0 next-hop-interface pppoe2

}

function set_mobile_modify(){
    set firewall group network-group cn-mobile network 36.128.0.0/10
    set firewall group network-group cn-mobile network 36.192.0.0/11
    set firewall group network-group cn-mobile network 39.128.0.0/10
    ##set firewall group network-group cn-mobile network 43.239.172.0/22
    set firewall group network-group cn-mobile network 43.247.240.0/22
    set firewall group network-group cn-mobile network 43.251.244.0/22
    ##set firewall group network-group cn-mobile network 45.121.68.0/22
    ##set firewall group network-group cn-mobile network 45.121.72.0/22
    ##set firewall group network-group cn-mobile network 45.121.172.0/22
    ##set firewall group network-group cn-mobile network 45.121.176.0/22
    ##set firewall group network-group cn-mobile network 45.122.100.0/22
    ##set firewall group network-group cn-mobile network 45.122.96.0/21
    ##set firewall group network-group cn-mobile network 45.123.152.0/22
    ##set firewall group network-group cn-mobile network 45.124.36.0/22
    ##set firewall group network-group cn-mobile network 45.125.24.0/22
    set firewall group network-group cn-mobile network 61.236.0.0/15
    set firewall group network-group cn-mobile network 101.144.0.0/12
    set firewall group network-group cn-mobile network 103.3.128.0/22
    set firewall group network-group cn-mobile network 103.20.112.0/22
    set firewall group network-group cn-mobile network 103.21.176.0/22
    ##set firewall group network-group cn-mobile network 103.61.156.0/22
    ##set firewall group network-group cn-mobile network 103.61.160.0/22
    ##set firewall group network-group cn-mobile network 103.62.24.0/22
    ##set firewall group network-group cn-mobile network 103.62.208.0/22
    ##set firewall group network-group cn-mobile network 103.62.204.0/22
    ##set firewall group network-group cn-mobile network 103.192.0.0/22
    ##set firewall group network-group cn-mobile network 103.192.144.0/22
    ##set firewall group network-group cn-mobile network 103.193.140.0/22
    ##set firewall group network-group cn-mobile network 103.35.104.0/22
    set firewall group network-group cn-mobile network 110.96.0.0/11
    set firewall group network-group cn-mobile network 110.192.0.0/11
    set firewall group network-group cn-mobile network 111.0.0.0/10
    set firewall group network-group cn-mobile network 112.0.0.0/10
    set firewall group network-group cn-mobile network 114.208.0.0/14
    set firewall group network-group cn-mobile network 115.104.0.0/14
    set firewall group network-group cn-mobile network 115.180.0.0/14
    set firewall group network-group cn-mobile network 117.128.0.0/10
    set firewall group network-group cn-mobile network 118.204.0.0/14
    set firewall group network-group cn-mobile network 120.90.0.0/15
    set firewall group network-group cn-mobile network 120.192.0.0/10
    set firewall group network-group cn-mobile network 183.192.0.0/10
    set firewall group network-group cn-mobile network 211.103.0.0/17
    set firewall group network-group cn-mobile network 211.140.0.0/15
    set firewall group network-group cn-mobile network 211.136.0.0/14
    set firewall group network-group cn-mobile network 211.142.0.0/17
    set firewall group network-group cn-mobile network 211.143.0.0/16
    set firewall group network-group cn-mobile network 211.142.128.0/17
    set firewall group network-group cn-mobile network 218.204.0.0/15
    set firewall group network-group cn-mobile network 218.200.0.0/14
    set firewall group network-group cn-mobile network 218.206.0.0/15
    set firewall group network-group cn-mobile network 221.130.0.0/15
    set firewall group network-group cn-mobile network 221.172.0.0/14
    set firewall group network-group cn-mobile network 221.176.0.0/13
    set firewall group network-group cn-mobile network 222.32.0.0/11
    set firewall group network-group cn-mobile network 223.112.0.0/14
    set firewall group network-group cn-mobile network 223.116.0.0/15
    set firewall group network-group cn-mobile network 223.120.0.0/13
    set firewall group network-group cn-mobile network 223.96.0.0/12
    ## Amazon HK
    set firewall group network-group cn-mobile network 16.162.0.0/15
    set firewall group network-group cn-mobile network 18.162.0.0/15
    set firewall group network-group cn-mobile network 18.166.0.0/16
    ## Amazon SG
    set firewall group network-group cn-mobile network 3.0.0.0/15
    set firewall group network-group cn-mobile network 13.212.0.0/15
    set firewall group network-group cn-mobile network 13.214.0.0/15
    set firewall group network-group cn-mobile network 13.228.0.0/15
    set firewall group network-group cn-mobile network 13.250.0.0/15
    set firewall group network-group cn-mobile network 18.136.0.0/16
    set firewall group network-group cn-mobile network 18.138.0.0/15
    set firewall group network-group cn-mobile network 18.140.0.0/14
    set firewall group network-group cn-mobile network 46.51.216.0/21
    set firewall group network-group cn-mobile network 46.137.192.0/18
    set firewall group network-group cn-mobile network 52.74.0.0/16
    set firewall group network-group cn-mobile network 52.76.0.0/15
    set firewall group network-group cn-mobile network 52.220.0.0/15
    set firewall group network-group cn-mobile network 54.151.128.0/17
    set firewall group network-group cn-mobile network 54.169.0.0/16
    set firewall group network-group cn-mobile network 54.179.0.0/16
    set firewall group network-group cn-mobile network 54.251.0.0/16
    set firewall group network-group cn-mobile network 54.254.0.0/16
    set firewall group network-group cn-mobile network 54.255.0.0/16
    set firewall group network-group cn-mobile network 122.248.192.0/18
    set firewall group network-group cn-mobile network 175.41.128.0/18
    ## Amazon Global
    set firewall group network-group cn-mobile network 13.248.132.0/24
    set firewall group network-group cn-mobile network 76.223.4.0/24
    ## Cloudflare
    set firewall group network-group cn-mobile network 104.16.0.0/12
    set firewall group network-group cn-mobile network 172.64.0.0/14
}

function set_inteface_modify(){
    set firewall modify M rule 20 destination group network-group cn-mobile
    set firewall modify M rule 20 action modify
    set firewall modify M rule 20 modify table 2
    set interfaces ethernet eth0 firewall in modify M
}

function run_config(){
    configure
    set_pppoe_user1
    set_pppoe_user2
    set_pppoe_pass1
    set_pppoe_pass2
    system_service
    dhcp_server
    enable_pppoe
    enable_nat
    set_static_route
    set_mobile_modify
    set_inteface_modify
    commit
    save
}

run_config