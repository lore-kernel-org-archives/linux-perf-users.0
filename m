From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: How to check perf commands are producing proper output or not?
Date: Sat, 29 Jan 2011 11:07:34 -0200
Message-ID: <20110129130734.GG6345@ghostprotocols.net>
References: <AANLkTikZc4L=-xzmOvqLC00qNHLuqCBOdcD3hofBNfFN@mail.gmail.com>
 <20110128134811.GB6345@ghostprotocols.net>
 <alpine.DEB.2.00.1101280929240.10620@cl320.eecs.utk.edu>
 <20110128154314.GC6345@ghostprotocols.net>
 <alpine.DEB.2.00.1101281650230.10620@cl320.eecs.utk.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53777 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab1A2NHl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 29 Jan 2011 08:07:41 -0500
Received: by yib18 with SMTP id 18so1403745yib.19
        for <linux-perf-users@vger.kernel.org>; Sat, 29 Jan 2011 05:07:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101281650230.10620@cl320.eecs.utk.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vweaver1@eecs.utk.edu>
Cc: nelakurthi koteswararao <koteswararao18@gmail.com>, Han Pingtian <phan@redhat.com>, linux-perf-users@vger.kernel.org

Em Fri, Jan 28, 2011 at 05:03:06PM -0500, Vince Weaver escreveu:
> On Fri, 28 Jan 2011, Arnaldo Carvalho de Melo wrote:
> > My expectation so far, for basic tests, is not to precisely detect each
> > and every event, but to make sure that if a big number of cache misses
> > is being provoked, a big number of cache misses is being detected, to
> > test the basic working of the system.
> 
> So do you want to just check for a non-zero number for the various counts?
> That can be easily done.

Yeah, to check the basic functioning of the infrastructure.
 
> If you want something closer, such as if something like branches match
> to within 10% you end up needing assembly-coded benchmarks, as compiler
> variation can make it hard to tell if the results you are getting are 
> right or just coincidence.
 
> > After basic tests are in place, we go on trying to make them more
> > precise as is practical.
 
> You do have to be careful in situations like this.  The in-kernel AMD 
> branches count was wrong for a few kernel releases.  The count returned
> a roughly plausible number of branches, but it turns out it was only 
> counting retired-taken not retired-total branches.  Only a fairly exact 
> assembly-language test I was working on showed this problem.

And we want to avoid it from happening again for this specific case,
thus regression tests need to be in place, total agreement here :-)
 
> Another problem is with cache results.  This is why I wrote these tests to 
> begin with.  I had users of PAPI/perf_events tell me that our tool was 
> "broken" because they got implausibly low results for L2 cache misses (on 
> the order of maybe 20 misses for walking an array the size of L2 cache).
> It turns out that the HW prefetchers on modern machines are so good that
> unless you do random walks of the cache it will look like the counter is 
> broken.

:-)
 
> > > Even things you might think are simple, like retired-instructions can vary 
> > > wildly.  There are enough differences caused by Linux and processor errata 
> > > with retired-instructions that I wrote a whole 10 page paper about the 
> > > differences you see.
> > 
> > Cool, can I get the paper URL? I'd love to read it
> 
> Sure, it's:
>    http://web.eecs.utk.edu/~vweaver1/projects/deterministic/fhpm2010_weaver.pdf

Thanks!
 
> > > I have started writing some validation tests, though they use the PAPI 
> > > library which runs on top of perf-events.  You can see that and other 
> > > validation work linked to here:
> > >    http://web.eecs.utk.edu/~vweaver1/projects/validation-tests/
> > 
> > Will look at it, thanks for the pointer, thanks for working on it!
> 
> I'd be glad to help a bit with this, as I think it's an important topic.
> I should check out the current perf regression tests to see what's there.
> I've been working at higher levels with libpfm4 and PAPI because a lot of 
> the events I have problems with aren't necessarily the ones exposed by 
> perf (without using raw events).

The tests there are rather simple, basically testing the infrastructure
to create counters that I factored out of the tools and into
tools/perf/util/{evsel,evlist}.[ch] and that I'm exposing thru a python
binding.

They create syscall tracepoint events, that we can then trigger by using
the syscalls (I used open, pid getting routines), making them happen in
specific cpus (using sched_setaffinity), and then checking if the number
of syscalls generated on a particular CPU were correctly counted.

No tests for hardware counters are in there now, this discussion should
provide insights to people interested in writing them :-)

- Arnaldo
