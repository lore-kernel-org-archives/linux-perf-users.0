From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Tue, 9 Dec 2014 19:22:03 -0300
Message-ID: <20141209222203.GD8788@kernel.org>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com>
 <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com>
 <20141209203419.GI4189@kernel.org>
 <87ppbs4h5k.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:60235 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbaLIWWL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 9 Dec 2014 17:22:11 -0500
Content-Disposition: inline
In-Reply-To: <87ppbs4h5k.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>, Carl Love <cel@us.ibm.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Tue, Dec 09, 2014 at 02:01:11PM -0800, Andi Kleen escreveu:
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> >
> > Humm, I wonder if we could try to attach a 'perf probe' (uprobes) to
> > some JVM method that is known to invalidate JITted code -> symtab
> > mappings so that we would use it as a PERF_RECORD_MMAP equivalent...
> > I.e. we would know that that map overlaps the previous one and that the
> > symtab is a new one for that addr range, etc, just like we do for
> > executable mmaps coming from the kernel (PERF_RECORD_MMAP).
> 
> JAVA already has a API to get all these information. That is
> what oprofile, Vtune and Brendan's agent uses.

I understood that there is a way to ask for the current JITted code ->
symtab, my question was specifically about how to get notifications when
those mappings change.

The described solutions states that those maps can get stale, i.e. they
will change and we don't get a notification for that.

When we use mmap(addr, len, PROT_EXEC) the kernel has a meta event
called PERF_RECORD_MMAP that will record addr range, symtab DSO path,
and we ask it to be timestamped, how to do that for the equivalent part
in the JVM?

My initial thought was to find that using perf probe and insert there a
probe point, but I think that there may be already an existing
tracepoint in the jvm for that, one that, from what I've read so far,
is _not_ being used by this java perf agent, right?

From what I understood, how would it insert that event into the
perf.data event stream? Only if it necessarily involved a new mmap, via
the kernel, etc.
 
> It just needs a better interface from the agent to perf, to pass all
> needed information, including symbols, line numbers, executable code
> (for PT decoding and for showing diassembler), and ordering it by time
> so that no hacks are needed.
> 
> BTW other JITs (LLVM, Mono, V8, ...) have similar interfaces.
> 
> Longer term as the kernel gets more JITed (eBPF etc.) it likely needs 
> some kind of JIT interface too.

Right, this is something we need to have, no questions about it, its
just a matter of cooking up some prototype implementation...

If, for instance, the java agent would put on some file those events,
timestamped, then when in perf report we would just insert them into the
event stream as synthesized PERF_RECORD_MMAPs, probably that would be
enough.
 
> -Andi
> 
> -- 
> ak@linux.intel.com -- Speaking for myself only
