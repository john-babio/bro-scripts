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
/usr/bin/mal-dnssearch -M mandiant -p | mal-dns2bro -T dns -s mandiant -n true > baddns
/usr/bin/mal-dnssearch -M mayhemic -p | mal-dns2bro -T dns -s mayhemic -n true >> baddns
/usr/bin/mal-dnssearch -M malhosts -p | mal-dns2bro -T dns -s malwaredomainlist -n true >> baddns

#This removes the duplicate #field header section of intel files 
/usr/bin/awk ' !x[$0]++' baddns > baddns.intel
rm baddns

#This creates the ip intel files
/usr/bin/mal-dnssearch -M snort -p | mal-dns2bro -T ip -s snort -n true > badips
/usr/bin/mal-dnssearch -M et_ips -p | mal-dns2bro -T ip -s emergingthreats -n true >> badips
/usr/bin/mal-dnssearch -M botcc -p | mal-dns2bro -T ip -s emergingthreats -n true >> badips
/usr/bin/mal-dnssearch -M tor -p | mal-dns2bro -T ip -s emergingthreats -n true >> badips
/usr/bin/mal-dnssearch -M rbn -p | mal-dns2bro -T ip -s emergingthreats -n true >> badips
/usr/bin/mal-dnssearch -M malips -p | mal-dns2bro -T ip -s malwaredomainlist -n true >> badips
/usr/bin/mal-dnssearch -M ciarmy -p | mal-dns2bro -T ip -s ciarmy -n true >> badips
/usr/bin/awk ' !x[$0]++' badips > badips.intel
rm badips

mv baddns.intel /usr/local/bro/share/bro/inteldata
mv badips.intel /usr/local/bro/share/bro/inteldata

#This is a script I created to restart bro
/etc/start-bro.sh
