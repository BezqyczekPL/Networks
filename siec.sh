#!bin/bash

#zatrzymaj kontenery T1 T2 i D1 jesli dzialaja
docker container stop T1 T2 D1
#usun kontenery T1 T2 i D1 jesli istnieja
docker container rm T1 T2 D1
#usun siec bridge1 jesli istnieje
docker network rm bridge1
#uruchom kontener T1 oparty na obrazie alpine
docker run -itd --name T1 --network-alias T1_alias alpine sh

#
#docker run -itd --name T2 -p 80:80 nginx sh
#

#utworz siec bridge1 ktorej zakres ip wynosi od 10.0.10.0-10.0.10.255
docker network create -d bridge --subnet 10.0.10.0/24 bridge1
#uruchom kontener T2 na porcie 80 i na podstawie sieci bridge1 na porcie 8000 na obrazie nginx
docker run -itd --name T2 -p 80:80 --network-alias T2_80_alias --net bridge1 -p 10.0.10.0:8000:8000 --network-alias T2_8000_alias nginx sh

#
#docker run -itd --name T2 --net bridge1 -p 80:8000 nginx sh
#

#uruchom kontener D1 w sieci bridge1 przypisujac IP 10.0.10.254 na obrazie alpine
docker run -itd --name D1 --net bridge1 --ip 10.0.10.254 --network-alias D1_alias alpine sh
