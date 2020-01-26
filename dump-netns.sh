#!/bin/bash
NS=$(ip netns list)
FL=99
if [[ $1 != "" ]]; then
        FL=0
        echo "Looking..."
fi
for N in $NS; do
        if [[ $FL != 0 ]]; then
                echo $N
        fi
        LS=$(ip netns exec $N ip a | grep ^[0-9] | cut -f2 -d' ')
        for L in $LS; do
                l=${L::-1}
                if [[ $l == "lo" ]]; then
                        continue
                fi
                if [[ $FL != 0 ]]; then
                        echo "    $l"
                fi
                AS=$(ip netns exec $N ip -f inet -o a show $l | cut -d' ' -f7)
                for A in $AS; do
                        if [[ $FL == 0 ]]; then
                                ANS=$(php -f ipRangeCheck.php $1 $A)
                                if [[ $ANS == "Yes" ]]; then
                                        echo "$1 >>> $N : $l : $A"
                                fi
                        else
                                echo "        $A"
                        fi
                done
        done
done


