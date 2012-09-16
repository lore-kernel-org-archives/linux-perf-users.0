From: Andi Kleen <andi@firstfloor.org>
Subject: Re: measuring offcore events on snb
Date: Sun, 16 Sep 2012 05:02:44 +0200
Message-ID: <20120916030244.GA16230@one.firstfloor.org>
References: <loom.20120915T194641-95@post.gmane.org> <m2txuyyk50.fsf@firstfloor.org> <alpine.DEB.2.02.1209152103400.576@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:55899 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab2IPDCu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 15 Sep 2012 23:02:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1209152103400.576@pianoman.cluster.toy>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vince@deater.net>
Cc: Andi Kleen <andi@firstfloor.org>, Yuanfang Chen <tabloid.adroit@gmail.com>, linux-perf-users@vger.kernel.org

> the kernel has had raw offcore response support since 3.3.  It works
> fine.  It's just not easy to get if you use the "perf" tool.  (PAPI and 

It is easy. Just write the MSR.

> as far as I know the only way to do it is to use the rediculous
>    -e cpu/cmask=1,event=2,umask=3,config1=3f80408fff
http://www.heise.de/netze/news/foren/S-Europaeischer-IPv4-Adresspool-erreicht-die-Reserve/forum-237910/list/e-22434521/hs-16/

Ah true. Good point. That thing always reminds me of JCL. Setting the MSR is 
probably easier though...

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
