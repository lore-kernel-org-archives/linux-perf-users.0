From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC] perf top and deleted binaries
Date: Mon, 9 May 2011 17:58:49 -0300
Message-ID: <20110509205849.GA26156@ghostprotocols.net>
References: <20110509182822.GA23798@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:59024 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab1EIU6y (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 May 2011 16:58:54 -0400
Content-Disposition: inline
In-Reply-To: <20110509182822.GA23798@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, May 09, 2011 at 11:28:23AM -0700, Arun Sharma escreveu:
> 
> For long running binaries which may have been replaced or deleted, today 
> perf top spits out a warning and doesn't show anything. For eg:
> 
> test.c:
> 
> main()
> {
> 	while(1);
> }
> 
> gcc -O2 test.c -o test
> ./test &
> gcc -O2 test.c -o test	# overwrite the binary
> perf top -p <pid>
> 
> shows nothing. It could instead show:
> 
> 100% <unresolved>	test
> 
> like perf record/report would show for the same test case. Comments?

Agreed :-)

When/if we get build-id as first class citizen, stashing it in some
kernel data structure at DSO load time, we'll be able to use it for
content based DSO lookup in the cache.

- Arnaldo
