From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf support for interpreted and Just-In-Time translated
 olanguages
Date: Wed, 10 Dec 2014 16:21:23 -0300
Message-ID: <20141210192123.GG8788@kernel.org>
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
Received: from mail.kernel.org ([198.145.19.201]:36454 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674AbaLJTV2 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 10 Dec 2014 14:21:28 -0500
Content-Disposition: inline
In-Reply-To: <1418233295.4953.33.camel@oc0276584878.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Carl Love <cel@us.ibm.com>
Cc: Andi Kleen <andi@firstfloor.org>, Brendan Gregg <brendan.d.gregg@gmail.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Wed, Dec 10, 2014 at 09:41:35AM -0800, Carl Love escreveu:
> On Tue, 2014-12-09 at 16:38 -0800, Andi Kleen wrote:
> > Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> > 
> > > When we use mmap(addr, len, PROT_EXEC) the kernel has a meta event
> > > called PERF_RECORD_MMAP that will record addr range, symtab DSO path,
> > > and we ask it to be timestamped, how to do that for the equivalent part
> > > in the JVM?
> > 
> > http://docs.oracle.com/javase/7/docs/platform/jvmti/jvmti.html
> > 
> > You just need a way to push it from the agent to perf.
> > 
> 
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
> 
> 
> > >
> > > My initial thought was to find that using perf probe and insert there a
> > > probe point, but I think that there may be already an existing
> > > tracepoint in the jvm for that, one that, from what I've read so far,
> > > is _not_ being used by this java perf agent, right?
> > 
> > The agent interface works by linking an agent with a special library
> > I believe. So the agent can do whatever it wants.
> 
> > > From what I understood, how would it insert that event into the
> > > perf.data event stream? Only if it necessarily involved a new mmap, via
> > > the kernel, etc.
> > 
> > You basically need a way to trigger a perf event from user space.
> > One simple way would be to just write a perf.data too into /tmp,
> > and let perf collect that.
> > 
> > But it's more than that. You also need to transfer the executable
> > code somewhere, and the line numbers.
> > 
> 
> The source file and line number information is optionally available from
> the jvm via the jvmti complied method load callback.  With this

Right, this could be used to synthesize DWARF for that, as described in
the message I just sent.

> information on the symbol, line number and source file, perf could then
> persist the data in an ELF formatted file. 
> 
> 
> > >  
> > >> It just needs a better interface from the agent to perf, to pass all
> > >> needed information, including symbols, line numbers, executable code
> > >> (for PT decoding and for showing diassembler), and ordering it by time
> > >> so that no hacks are needed.
> > >> 
> > >> BTW other JITs (LLVM, Mono, V8, ...) have similar interfaces.
> > >> 
> > >> Longer term as the kernel gets more JITed (eBPF etc.) it likely needs 
> > >> some kind of JIT interface too.
> > >
> > > Right, this is something we need to have, no questions about it, its
> > > just a matter of cooking up some prototype implementation...
> > >
> > > If, for instance, the java agent would put on some file those events,
> > > timestamped, then when in perf report we would just insert them into the
> > > event stream as synthesized PERF_RECORD_MMAPs, probably that would be
> > > enough.
> > 
> > Really to be useful you need at least line numbers, better code.
> > 
> > In theory the agent could write ELF files with dwarf, but that may get
> > really ugly.  Probably better to have something more light weight.
> 
> Perf would need to do this so the data collection and ELF file
> conversion will be done only when pref is doing the profiling of the
> JITed code. Specifically, if perf is passed the pid of a running JVM the
> agent library would not know when profiling starts and stops.
