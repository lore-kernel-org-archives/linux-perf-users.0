From: Ingo Molnar <mingo@kernel.org>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Fri, 27 Jul 2012 10:18:30 +0200
Message-ID: <20120727081830.GA4258@gmail.com>
References: <501121D3.3060700@mentor.com>
 <20120727072647.GA3965@gmail.com>
 <1343376002.32120.22.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45270 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab2G0ISg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jul 2012 04:18:36 -0400
Received: by bkwj10 with SMTP id j10so1751291bkw.19
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jul 2012 01:18:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343376002.32120.22.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Fri, 2012-07-27 at 09:26 +0200, Ingo Molnar wrote:
> > 
> > Maybe someone on Cc: would be interested in implementing this 
> > new perf events feature? 
> 
> Why would we go build new kernel interfaces because userspace 
> is silly?

Because it's (much) easier to use the existing perf tools almost 
as-is instead of librarizing your own.

It would also allow other usecases, like self-profiling a 
library and then profiling it within the context of a larger app 
that you don't want to rebuild and which dynamically links this 
library.

It also allows system-wide profiling after you've modified a 
library to self-profile, while your suggestion does not allow 
that.

> It really isn't that hard to make userspace do what is needed, 
> it just takes a bit of work.

Even if your suggested solution was available (it isn't), my 
suggested approach is easier to use and covers more usecases.

User-space expecting the kernel to provide usable and minimal 
interfaces is not 'being silly'. It's the fundamental task of a 
kernel to provide them.

Thanks,

	Ingo
