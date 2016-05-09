From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [DONE] Re: Reordering the thread output in perf trace --summary
Date: Mon, 9 May 2016 17:12:55 -0300
Message-ID: <20160509201255.GD13209@kernel.org>
References: <91397949.qTd2kn5sDj@milian-kdab2>
 <36570524.2BCkYtH2gR@milian-kdab2>
 <20160509162516.GB5101@kernel.org>
 <3442884.78Cb9YQhj3@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59408 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbcEIUNA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 May 2016 16:13:00 -0400
Content-Disposition: inline
In-Reply-To: <3442884.78Cb9YQhj3@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

Em Mon, May 09, 2016 at 08:03:30PM +0200, Milian Wolff escreveu:
> On Monday, May 9, 2016 1:25:16 PM CEST Arnaldo Carvalho de Melo wrote:
> > I'll probably make it use the sched:sched_stat_runtime data as the sort
> > key for threads if --stat is used, what do you think?
 
> You mean if `--sched` was used? I'm undecided on this. On one hand, the user 
> explicitly requests `--sched` so he probably is interested in it. On the other 
> hand, the total number of syscalls or wait time per thread may be more 
> interesting... If you use this to find contention issues e.g. then the threads 
> suffering most from contention issues will have a low runtime.
 
> Personally, I think this is yet another situation where a proper GUI could 
> solve this problem nicely. A trivial tree view with the option to adapt the 
> sorting and aggregation as needed and a way to filter out certain syscalls 
> post-collection would be really nice to have. I'm very much looking forward to 
> having more time at hands again to finally tackle this.

Yeah, we could make that dynamic, the trace case is basically 'perf
top/report' working on two events at a a time (enter/exit).

In the end I think the best way would be to get 'perf trace' to use the
hists browser like top and report :-)

I.e. we would be showing that 'perf trace --summary' in "real time", to
abuse that term a bit more :-)

We would be producing it and refreshing it over time.

A generic mechanism for matching up pairs (or more) events and present
them together with things like callchains, like we do now specifically
for sys_enter/sys_exit syscall tracepoints would be handy indeed.

But feel encouraged to try a GUI to exercise your ideas, hopefully the
existing infrastructure can get readily used for that, let us know about
any change that you think would help with that.

- Arnaldo
