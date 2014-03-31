#!/bin/bash
# This is the inteldata.bro file to be placed inside folder /usr/local/bro/share/bro/inteldata
#
# @load policy/frameworks/intel/seen
# @load frameworks/intel/do_notice
#
# redef Notice::type_suppression_intervals += {
#        [Intel::Notice] = 1day,
# };
#
# redef Intel::read_files += {
#        @DIR + "/baddns.intel",
#        @DIR + "/badips.intel",
# };
# #
# This to be places in local.bro 
# @load inteldata/inteldata
##
# It is also assumed you have the mal-dnssearch script install from "https://github.com/jonschipp/mal-dnssearch"
##

#This creates the dns intel files
/usr/bin/mal-dnssearch -M mandiant 
/usr/bin/mal-dnssearch -M mayhemic 
/usr/bin/mal-dnssearch -M malhosts
cat mandiant_apt1.dns > dnsnames.txt
cat malhosts.txt >> dnsnames.txt
cat hosts.txt >> dnsnames.txt
/usr/bin/awk ' !x[$0]++' dnsnames.txt > baddns

cat baddns | mal-dns2bro -T dns -s malware-domain-names -n true > baddns.intel
mv baddns.intel /usr/local/bro/share/bro/inteldata
rm mandiant_apt1.dns
rm malhosts.txt
rm hosts.txt
rm baddns
rm dnsnames.txt


#This creates the ip intel files
/usr/bin/mal-dnssearch -M snort
/usr/bin/mal-dnssearch -M et_ips
/usr/bin/mal-dnssearch -M botcc
/usr/bin/mal-dnssearch -M tor
/usr/bin/mal-dnssearch -M malips
/usr/bin/mal-dnssearch -M ciarmy
cat ip.txt > ipaddr.txt
cat compromised-ips.txt >> ipaddr.txt
cat ci-badguys.txt >> ipaddr.txt
cat botcc.rules >> ipaddr.txt
cat tor.rules >> ipaddr.txt
cat ip-filter.blf >> ipaddr.txt
/usr/bin/awk ' !x[$0]++' ipaddr.txt > badips
cat badips | mal-dns2bro -T ip -s malware-ips -n true > badips.intel
mv badips.intel /usr/local/bro/share/bro/inteldata
rm ipaddr.txt
rm badips
rm ip.txt
rm compromised-ips.txt
rm ci-badguys.txt
rm botcc.rules
rm tor.rules
rm ip-filter.blf

mv baddns.intel /usr/local/bro/share/bro/inteldata
mv badips.intel /usr/local/bro/share/bro/inteldata

#This is a script I created to restart bro
/etc/start-bro.sh
