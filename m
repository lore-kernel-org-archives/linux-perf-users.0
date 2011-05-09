From: Arun Sharma <asharma@fb.com>
Subject: [RFC] perf top and deleted binaries
Date: Mon, 9 May 2011 11:28:23 -0700
Message-ID: <20110509182822.GA23798@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from outmail014.snc4.facebook.com ([66.220.144.146]:42276 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753171Ab1EISdu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 May 2011 14:33:50 -0400
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, acme@ghostprotocols.net


For long running binaries which may have been replaced or deleted, today 
perf top spits out a warning and doesn't show anything. For eg:

test.c:

main()
{
	while(1);
}

gcc -O2 test.c -o test
./test &
gcc -O2 test.c -o test	# overwrite the binary
perf top -p <pid>

shows nothing. It could instead show:

100% <unresolved>	test

like perf record/report would show for the same test case. Comments?

 -Arun
