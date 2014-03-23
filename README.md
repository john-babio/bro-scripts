bro-scripts
===========







<H1>Installation</H1>

git clone git://github.com/3vi1john/bro-scripts.git <BR>
cd bro-scripts <BR>
mv black_list /usr/local/bro/share/bro/site <BR>
cd /usr/local/bro/share/bro/site </BR>
echo "@load black_list" >> local.bro <BR>
I have had to run "/usr/local/bro/bin/broctl stop","/usr/local/bro/bin/broctl install","/usr/local/bro/bin/broctl start" <BR>

You can cron the malwaredomains.sh to pull down the updated list of domains. Just make sure it is in the black_list folder <BR>






<h1>Output will generate</h1>



