From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Wed, 10 Dec 2014 18:32:28 +0100
Message-ID: <20141210173228.GA6759@two.firstfloor.org>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
 <20141209203419.GI4189@kernel.org>
 <87ppbs4h5k.fsf@tassilo.jf.intel.com>
 <20141209222203.GD8788@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:40708 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbaLJRca (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 10 Dec 2014 12:32:30 -0500
Content-Disposition: inline
In-Reply-To: <20141209222203.GD8788@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, Brendan Gregg <brendan.d.gregg@gmail.com>, Carl Love <cel@us.ibm.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

> I understood that there is a way to ask for the current JITted code ->
> symtab, my question was specifically about how to get notifications when
> those mappings change.

JVMTI has a callback interface, so you can register call backs for
specific events:

http://docs.oracle.com/javase/7/docs/platform/jvmti/jvmti.html#EventSection

> When we use mmap(addr, len, PROT_EXEC) the kernel has a meta event
> called PERF_RECORD_MMAP that will record addr range, symtab DSO path,
> and we ask it to be timestamped, how to do that for the equivalent part
> in the JVM?

The CompiledMethodLoad callback would trigger that event.

> 
> My initial thought was to find that using perf probe and insert there a
> probe point, but I think that there may be already an existing
> tracepoint in the jvm for that, one that, from what I've read so far,
> is _not_ being used by this java perf agent, right?

It's not needed. Java already has all the needed hooks.

Maybe for some different JITs.

> 
> From what I understood, how would it insert that event into the
> perf.data event stream? Only if it necessarily involved a new mmap, via
> the kernel, etc.

That's the new interface to be defined.

Just write a perf.data?

-Andi


-- 
ak@linux.intel.com -- Speaking for myself only.
