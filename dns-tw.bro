export {
        redef enum Notice::Type += {
        Abnormal_DNS_Request::FOUND
        };
}


event dns_request(c: connection , msg: dns_msg , query: string , qtype: count , qclass: count )
{
local dns_pattern = /.*\.tw/;
if ( query == dns_pattern ) {
NOTICE([$note=Abnormal_DNS_Request::FOUND,
$conn=c,
$msg=fmt("Abnormal DNS Request for: %s", query),
$identifier=cat(query)]);
        }
}
