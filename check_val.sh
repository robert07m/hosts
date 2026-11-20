#!/bin/bash

verifica_ip() {
    local name="$1"
    local ip="$2"
    local dns_server="$3"

    dns_ip=$(nslookup "$name" "$dns_server" 2>/dev/null |
             awk '/^Address: / {print $2}' |
             tail -n 1)

    if [[ "$dns_ip" == "$ip" ]]; then
        echo "$name -> $ip : VALID"
    else
        echo "$name -> $ip : INVALID"
    fi
}

if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <hostname> <IP> <DNS_server>"
    exit 1
fi

verifica_ip "$1" "$2" "$3"

