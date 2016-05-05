From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [DONE] Re: Reordering the thread output in perf trace --summary
Date: Thu, 5 May 2016 13:04:02 -0300
Message-ID: <20160505160402.GG11069@kernel.org>
References: <91397949.qTd2kn5sDj@milian-kdab2>
 <52227896.H02DnUL2Ue@milian-kdab2>
 <20160504214123.GF11069@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42534 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756605AbcEEQEH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 5 May 2016 12:04:07 -0400
Content-Disposition: inline
In-Reply-To: <20160504214123.GF11069@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

Em Wed, May 04, 2016 at 06:41:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 04, 2016 at 11:51:04AM +0200, Milian Wolff escreveu:
> > On Wednesday, May 4, 2016 11:02:12 AM CEST Milian Wolff wrote:
> > > I would like to propose to reorder the output to sort the output in
> > > ascending total event order, such that the most interesting output is shown
> > > at the bottom of the output on the CLI. I.e. in the output above it should
> > > be something like
 
> > > perf trace --summary lab_mandelbrot_concurrent |& grep events
> > > ... continued for a total of 168 lines
> > >  QDBusConnection (19499), 132 events, 0.4%, 0.000 msec
> > >  QXcbEventReader (19498), 1094 events, 3.0%, 0.000 msec
> > >  Thread (pooled) (19500), 1982 events, 5.5%, 0.000 msec
> > >  lab_mandelbrot_ (19497), 9246 events, 25.7%, 0.000 msec
 
> > > If this is acceptable to you, can someone please tell me how to do such a
> > > seemingly simple task in C? In C++ I'd except to add a simple std::sort
> > > somewhere, but in perf's C...? My current idea would be to run
> > > machine__for_each_thread and store the even count + thread pointer in
> > > another temporary buffer, which I then qsort and finally iterate over. Does
> > > that sound OK, or how would you approach this task?
  
> > While at it, can we similarly reorder the output of the per-thread syscall 
> > list? At the moment it is e.g.:
 
> Take a look at my perf/core branch, I have it working there.
 
> I'm in the process of experimenting with creating some kinde of template
> for resorting rb_trees, that will reduce the boilerplace while keeping
> it following the principles described in Documentation/rbtree.txt.

Ok, done, got really small and easy to change the keys if we want to,
not dynamicly tho as-is now, but should be easy, with offsetof 8-)

Anyway, I'm satisfied and pushed to perf/core, now looking at why total
thread time is zeroed...

Please take a look and check if it works for you,

- Arnaldo
