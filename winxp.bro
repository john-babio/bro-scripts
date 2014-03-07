export {
	redef enum Notice::Type += {	
		Windows_XP::FOUND
		};

}

event new_connection(c: connection)
        {
        if ( c$id$orig_p >= 1025/tcp && c$id$orig_p <= 5000/tcp ) {
       		NOTICE([$note=Windows_XP::FOUND,
       		$msg=fmt("Windows XP found"), 
       		$identifier=cat(c$id$resp_h),
       		$conn=c
       		]);
		}
}                
