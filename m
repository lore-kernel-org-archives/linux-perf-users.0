From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: Issue perf attaching to processes creating many short-live
 threads
Date: Tue, 27 Oct 2015 09:33:48 -0300
Message-ID: <20151027123348.GV27006@kernel.org>
References: <562A81ED.70900@redhat.com>
 <562A82F5.8090306@gmail.com>
 <562A8A08.9010101@redhat.com>
 <562A8C0F.4090607@gmail.com>
 <20151026194933.GS27006@kernel.org>
 <562E9E29.1080003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49542 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbbJ0Mdx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 27 Oct 2015 08:33:53 -0400
Content-Disposition: inline
In-Reply-To: <562E9E29.1080003@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, William Cohen <wcohen@redhat.com>, =?utf-8?B?5aSn5bmz5oCc?= <rei.odaira@gmail.com>, oprofile-list <oprofile-list@lists.sourceforge.net>

Em Mon, Oct 26, 2015 at 03:42:01PM -0600, David Ahern escreveu:
> On 10/26/15 1:49 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 23, 2015 at 01:35:43PM -0600, David Ahern escreveu:
> >> I was referring to something like 'make -j 1024' on a large system (e.g.,
> >> 512 or 1024 cpus) and then starting perf. This is the same problem you are
> >> describing -- lot of short lived processes. I am fairly certain I described
> >> the problem on lkml or perf mailing list. Not even the task_diag proposal
> >> (task_diag uses netlink to push task data to perf versus walking /proc) has
> >> a chance to keep up.

> > Yeah, to get info about existing threads (its maps, comm, etc) you would
> > pretty much have to stop the world, collect the info, then let
> > everything go back running because then new threads would insert the
> > PERF_RECORD_{FORK,COMM,MMAP,etc} records in the ring buffer.

> > I think we need an option to say: don't try to find info about existing
> > threads, i.e. don't look at /proc at all, we would end up with samples
> > being attributed to a pid/tid and that would be it, should be useful for
> > some use cases, no?

> Seems to me it would just be a lot of random numbers on a screen. 

For the existing threads? Yes, one would know that there were N threads,
the relationship among those threads, and then, the usual output for the
new threads.

> Correlating data to user readable information is a key part of perf.

Indeed, as best as it can.
 
> One option that might be able to solve this problem is to have perf 
> kernel side walk the task list and generate the task events into the 
> ring buffer (task diag code could be leveraged). This would be a lot 

It would have to do this over multiple iterations, locklessly wrt the
task list, in a non-intrusive way, which, in this case, could take
forever, no? :-)

> faster than reading proc or using netlink but would have other 
> throughput problems to deal with.

Indeed.

- Arnaldo
