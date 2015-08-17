From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Announcing simple-pt -- a simple Processor Trace implementation
 for Linux
Date: Mon, 17 Aug 2015 20:21:04 +0200
Message-ID: <20150817182104.GJ1747@two.firstfloor.org>
References: <20150817043130.GI1747@two.firstfloor.org>
 <CAFTL4hwfk4ezi=MVpvURmW=hKdXX6mJQYabwisHejd77CW3Sjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:49470 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbHQSVG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Aug 2015 14:21:06 -0400
Content-Disposition: inline
In-Reply-To: <CAFTL4hwfk4ezi=MVpvURmW=hKdXX6mJQYabwisHejd77CW3Sjg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, perf group <linux-perf-users@vger.kernel.org>

> >         % sptdecode --sideband ptout.sideband --pt ptout.0 | less
> >         TIME      DELTA  INSNs   OPERATION
> >         frequency 32
> >         0        [+0]     [+   1] _dl_aux_init+436
> >                           [+   6] __libc_start_main+455 -> _dl_discover_osversion
> >         ...
> >                           [+  13] __libc_start_main+446 -> main
> >                           [+   9]     main+22 -> f1
> >                           [+   4]             f1+9 -> f2
> >                           [+   2]             f1+19 -> f2
> >                           [+   5]     main+22 -> f1
> >                           [+   4]             f1+9 -> f2
> >                           [+   2]             f1+19 -> f2
> >                           [+   5]     main+22 -> f1
> 
> Nice. So I guess +x is the address offset. How hard would it be to
> translate to file lines?

Yes it's the address offset. Translating to lines wouldn't be too hard,
just needs to be implemented with a dwarf reader.

BTW the PT trace has all branches, just not the calls, but it's more
difficult to display them all in a nice way.

-Andi
