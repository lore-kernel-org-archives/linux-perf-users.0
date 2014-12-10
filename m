From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Wed, 10 Dec 2014 19:09:11 +0100
Message-ID: <20141210180911.GC6759@two.firstfloor.org>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
 <20141209203419.GI4189@kernel.org>
 <87ppbs4h5k.fsf@tassilo.jf.intel.com>
 <20141209222203.GD8788@kernel.org>
 <87h9x449vd.fsf@tassilo.jf.intel.com>
 <1418233295.4953.33.camel@oc0276584878.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:40866 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbaLJSJM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 10 Dec 2014 13:09:12 -0500
Content-Disposition: inline
In-Reply-To: <1418233295.4953.33.camel@oc0276584878.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Carl Love <cel@us.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <andi@firstfloor.org>, Brendan Gregg <brendan.d.gregg@gmail.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

> This may be more complex then needed.  We really just need to track the
> symbol.  From talking with the Java experts, they say the reused memory
> is almost always from methods that are loaded/used early when
> initializing the program.  Then the memory gets reused by a method that
> runs for the bulk of the time.  So by getting a timestamp for when the
> symbol was loaded you can then determine the length of time each symbol
> was in the anonymous memory.  Then just associate the sample with the
> symbol that was present in the anonymous memory the longest.  You can
> also tag the symbol names to say that they reside in the same memory,
> ie, the memory was reused. To warn the user that there maybe some
> ambiguity in the sample to symbol association.  

We need a way to transfer the code too. Just symbols is not enough.
This needs exact tracking.

> The source file and line number information is optionally available from
> the jvm via the jvmti complied method load callback.  With this
> information on the symbol, line number and source file, perf could then
> persist the data in an ELF formatted file. 

I'm not sure ELF/dwarf is the right way to go there. That would be very
complex. 

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
