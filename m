From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Perf support for interpreted and Just-In-Time translated olanguages
Date: Tue, 09 Dec 2014 16:38:30 -0800
Message-ID: <87h9x449vd.fsf@tassilo.jf.intel.com>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
	<CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
	<20141209203419.GI4189@kernel.org>
	<87ppbs4h5k.fsf@tassilo.jf.intel.com>
	<20141209222203.GD8788@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50715 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaLJAia (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 9 Dec 2014 19:38:30 -0500
In-Reply-To: <20141209222203.GD8788@kernel.org> (Arnaldo Carvalho de Melo's
	message of "Tue, 9 Dec 2014 19:22:03 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, Carl Love <cel@us.ibm.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> When we use mmap(addr, len, PROT_EXEC) the kernel has a meta event
> called PERF_RECORD_MMAP that will record addr range, symtab DSO path,
> and we ask it to be timestamped, how to do that for the equivalent part
> in the JVM?

http://docs.oracle.com/javase/7/docs/platform/jvmti/jvmti.html

You just need a way to push it from the agent to perf.

>
> My initial thought was to find that using perf probe and insert there a
> probe point, but I think that there may be already an existing
> tracepoint in the jvm for that, one that, from what I've read so far,
> is _not_ being used by this java perf agent, right?

The agent interface works by linking an agent with a special library
I believe. So the agent can do whatever it wants.

> From what I understood, how would it insert that event into the
> perf.data event stream? Only if it necessarily involved a new mmap, via
> the kernel, etc.

You basically need a way to trigger a perf event from user space.
One simple way would be to just write a perf.data too into /tmp,
and let perf collect that.

But it's more than that. You also need to transfer the executable
code somewhere, and the line numbers.

>  
>> It just needs a better interface from the agent to perf, to pass all
>> needed information, including symbols, line numbers, executable code
>> (for PT decoding and for showing diassembler), and ordering it by time
>> so that no hacks are needed.
>> 
>> BTW other JITs (LLVM, Mono, V8, ...) have similar interfaces.
>> 
>> Longer term as the kernel gets more JITed (eBPF etc.) it likely needs 
>> some kind of JIT interface too.
>
> Right, this is something we need to have, no questions about it, its
> just a matter of cooking up some prototype implementation...
>
> If, for instance, the java agent would put on some file those events,
> timestamped, then when in perf report we would just insert them into the
> event stream as synthesized PERF_RECORD_MMAPs, probably that would be
> enough.

Really to be useful you need at least line numbers, better code.

In theory the agent could write ELF files with dwarf, but that may get
really ugly.  Probably better to have something more light weight.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
