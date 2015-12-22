export {
	redef enum Notice::Type += {
	Interesting_DNS_Request::FOUND
	};
}


event dns_request(c: connection , msg: dns_msg , query: string , qtype: count , qclass: count )
{
local dns_pattern = /.*\.tw|.*\.cn|.*\.kr|.*\.kp|.*\.jp|.*\.sg|.*\.asia/;
if ( query == dns_pattern ) {
NOTICE([$note=Interesting_DNS_Request::FOUND,
$conn=c,
$msg=fmt("Interesting DNS Request for: %s", query),
$identifier=cat(query)]);
	}
} 
