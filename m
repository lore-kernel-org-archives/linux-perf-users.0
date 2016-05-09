From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [DONE] Re: Reordering the thread output in perf trace --summary
Date: Mon, 9 May 2016 13:25:16 -0300
Message-ID: <20160509162516.GB5101@kernel.org>
References: <91397949.qTd2kn5sDj@milian-kdab2>
 <20160504214123.GF11069@kernel.org>
 <20160505160402.GG11069@kernel.org>
 <36570524.2BCkYtH2gR@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43317 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbcEIQZ2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 9 May 2016 12:25:28 -0400
Content-Disposition: inline
In-Reply-To: <36570524.2BCkYtH2gR@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: David Ahern <dsahern@gmail.com>, linux-perf-users@vger.kernel.org

Em Mon, May 09, 2016 at 10:28:01AM +0200, Milian Wolff escreveu:
> On Thursday, May 5, 2016 1:04:02 PM CEST Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 04, 2016 at 06:41:23PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, May 04, 2016 at 11:51:04AM +0200, Milian Wolff escreveu:
> > > > On Wednesday, May 4, 2016 11:02:12 AM CEST Milian Wolff wrote:
> > > > While at it, can we similarly reorder the output of the per-thread
> > > > syscall

> > > > list? At the moment it is e.g.:
> > > Take a look at my perf/core branch, I have it working there.

> > > I'm in the process of experimenting with creating some kinde of template
> > > for resorting rb_trees, that will reduce the boilerplace while keeping
> > > it following the principles described in Documentation/rbtree.txt.

> > Ok, done, got really small and easy to change the keys if we want to,
> > not dynamicly tho as-is now, but should be easy, with offsetof 8-)

> > Anyway, I'm satisfied and pushed to perf/core, now looking at why total
> > thread time is zeroed...

> > Please take a look and check if it works for you,
 
> Great Arnaldo, thanks a lot! A pleasant surprise to come home from a sunny 
> weekend and see this gem waiting for me :)
> 
> I played around with it, and it does work as advertised. Great work!

Glad you liked it :-)

I'll probably make it use the sched:sched_stat_runtime data as the sort
key for threads if --stat is used, what do you think?

- Arnaldo
