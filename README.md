bro-scripts
===========







Installation

git clone git://github.com/3vi1john/bro-scripts.git 
cd bro-scripts
mv black_list <prefix>/share/bro/site
cd <prefix>/share/bro/site
echo "@load black_list" >> local.bro

I have had to run "<prefix>/bin/broctl stop","<prefix>/bin/broctl install","<prefix>/bin/broctl start"

Output will generate

BLACK_LIST::Domain_Hit


