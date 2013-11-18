@load base/frameworks/notice

module BLACK_LIST;

export {
        redef enum Notice::Type += {
                BLACK_LIST::Domain_Hit,
                
        };
}




event dns_request(c: connection, msg: dns_msg, query: string, qtype: count, qclass: count)
        {
        if ( query in BLACK_LIST::domains )
                {
                NOTICE([$note=BLACK_LIST::Domain_Hit,
                 $conn=c,
                 $msg=fmt("A domain from the BLACK_LIST seen: %s", query),
                 $identifier=cat(query)]);
                }
        }
