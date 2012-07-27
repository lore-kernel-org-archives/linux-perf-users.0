From: Ingo Molnar <mingo@kernel.org>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Fri, 27 Jul 2012 13:53:51 +0200
Message-ID: <20120727115351.GA4514@gmail.com>
References: <501121D3.3060700@mentor.com>
 <20120727072647.GA3965@gmail.com>
 <1343376002.32120.22.camel@twins>
 <20120727081830.GA4258@gmail.com>
 <1343377764.32120.29.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35427 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab2G0Lx5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jul 2012 07:53:57 -0400
Received: by wibhm11 with SMTP id hm11so7402632wib.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jul 2012 04:53:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343377764.32120.29.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> > It also allows system-wide profiling after you've modified a 
> > library to self-profile, while your suggestion does not 
> > allow that.
> 
> But its no long self-profiling when some other process is 
> involved. And system wide is definitely not self.

If I'm a library developer and want to self-profile my 
modifications, then it's entirely appropriate to do a 
system-wide profile to see the system-wide use of this library!

System-wide and self-profiling is not exclusive. Think of it as 
a narrow, precise filter applied to a given area of 
functionality only.

AFAICS the alternative, under your method, would be to recompile 
every single app in the system - that's cumbersome beyond 
imagination, I wouldn't even call it a solution, let alone a 
quality implementation.

> > > It really isn't that hard to make userspace do what is 
> > > needed, it just takes a bit of work.
> > 
> > Even if your suggested solution was available (it isn't), my 
> > suggested approach is easier to use and covers more 
> > usecases.
> > 
> > User-space expecting the kernel to provide usable and 
> > minimal interfaces is not 'being silly'. It's the 
> > fundamental task of a kernel to provide them.
> 
> Bloating the interface for something that is already well 
> possible is.

There's no 'bloat' worth speaking off: a single bit out of an 
already allocated bitmap, plus a single check in an already 
existing loop, plus a single new command-line flag to the 
tooling side and minimal glue.

There's no runtime overhead to any other perf functionality, at 
all.

Thanks,

	Ingo
