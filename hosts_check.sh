#!/bin/bash

cat /etc/hosts | while read -r ip names
do
    [[ -z "$ip" || "$ip" == \#* ]] && continue

    names=${names%%#*}

    for name in $names
    do
        dns_ip=$(nslookup "$name" 2>/dev/null |
                 awk '/^Name:/{found=1} found && /^Address:/{print $2}')

        if [[ -n "$dns_ip" ]]; then
            if ! echo "$dns_ip" | grep -Fxq "$ip"; then
                echo "Bogus IP for $name in /etc/hosts!"
            fi
        else
            echo "Bogus IP for $name in /etc/hosts!"
        fi
    done
done

