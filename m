From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Mon, 30 Jul 2012 13:04:15 -0700
Message-ID: <m2pq7d9fsw.fsf@firstfloor.org>
References: <501121D3.3060700@mentor.com> <20120727072647.GA3965@gmail.com>
	<1343376002.32120.22.camel@twins> <20120727081830.GA4258@gmail.com>
	<1343377764.32120.29.camel@twins> <20120727115351.GA4514@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53370 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab2G3VfN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 30 Jul 2012 17:35:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SvxcN-00007q-9k
	for linux-perf-users@vger.kernel.org; Mon, 30 Jul 2012 23:35:11 +0200
Received: from jfdmzpr03-ext.jf.intel.com ([134.134.139.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jul 2012 23:35:11 +0200
Received: from andi by jfdmzpr03-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jul 2012 23:35:11 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:

> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
>> > It also allows system-wide profiling after you've modified a 
>> > library to self-profile, while your suggestion does not 
>> > allow that.
>> 
>> But its no long self-profiling when some other process is 
>> involved. And system wide is definitely not self.
>
> If I'm a library developer and want to self-profile my 
> modifications, then it's entirely appropriate to do a 
> system-wide profile to see the system-wide use of this library!
>
> System-wide and self-profiling is not exclusive. Think of it as 
> a narrow, precise filter applied to a given area of 
> functionality only.
>
> AFAICS the alternative, under your method, would be to recompile 
> every single app in the system - that's cumbersome beyond 
> imagination, I wouldn't even call it a solution, let alone a 
> quality implementation.
>
>> > > It really isn't that hard to make userspace do what is 
>> > > needed, it just takes a bit of work.
>> > 
>> > Even if your suggested solution was available (it isn't), my 
>> > suggested approach is easier to use and covers more 
>> > usecases.
>> > 
>> > User-space expecting the kernel to provide usable and 
>> > minimal interfaces is not 'being silly'. It's the 
>> > fundamental task of a kernel to provide them.
>> 
>> Bloating the interface for something that is already well 
>> possible is.
>
> There's no 'bloat' worth speaking off: a single bit out of an 
> already allocated bitmap, plus a single check in an already 
> existing loop, plus a single new command-line flag to the 
> tooling side and minimal glue.

I tried it some time ago because I had a user who was very interested in
getting rid of initialization overhead in measurements.
I have a little library too to self instrument, but it's 
still a lot more work than adding a ioctl or two.

The patch is actually broken (causes occasional crashes)
and does not implement the opt in bit (but that would be easy 
to add). And it's against a quite old kernel.

Also had to do the disabling only after exec to avoid some issues.

But it worked well enough for some tests.

There are likely better ways to implement this
(or least ways that don't crash :-)
Frederic's generic contexts also sound nice.

The nice thing is that combined with some LD_PRELOAD 
tricks you can even use it with unmodified binaries.

(not a submission or anything, just FYI)

-Andi

http://firstfloor.org/~andi/perf-disabled-1


-- 
ak@linux.intel.com -- Speaking for myself only
