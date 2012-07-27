From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Fri, 27 Jul 2012 10:29:24 +0200
Message-ID: <1343377764.32120.29.camel@twins>
References: <501121D3.3060700@mentor.com> <20120727072647.GA3965@gmail.com>
	 <1343376002.32120.22.camel@twins> <20120727081830.GA4258@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:46841 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab2G0I3j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jul 2012 04:29:39 -0400
In-Reply-To: <20120727081830.GA4258@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 2012-07-27 at 10:18 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > On Fri, 2012-07-27 at 09:26 +0200, Ingo Molnar wrote:
> > > 
> > > Maybe someone on Cc: would be interested in implementing this 
> > > new perf events feature? 
> > 
> > Why would we go build new kernel interfaces because userspace 
> > is silly?
> 
> Because it's (much) easier to use the existing perf tools almost 
> as-is instead of librarizing your own.
> 
> It would also allow other usecases, like self-profiling a 
> library and then profiling it within the context of a larger app 
> that you don't want to rebuild and which dynamically links this 
> library.

Uhm.. why not? For the first use proper self profiling, for the second
do a regular 3rd party profile.

> It also allows system-wide profiling after you've modified a 
> library to self-profile, while your suggestion does not allow 
> that.

But its no long self-profiling when some other process is involved. And
system wide is definitely not self.

> > It really isn't that hard to make userspace do what is needed, 
> > it just takes a bit of work.
> 
> Even if your suggested solution was available (it isn't), my 
> suggested approach is easier to use and covers more usecases.
> 
> User-space expecting the kernel to provide usable and minimal 
> interfaces is not 'being silly'. It's the fundamental task of a 
> kernel to provide them.

Bloating the interface for something that is already well possible is.

I really don't see the problem, other than that people simply don't want
to do work.
