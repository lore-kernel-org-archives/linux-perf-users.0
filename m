From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: Issue perf attaching to processes creating many short-live
 threads
Date: Tue, 27 Oct 2015 11:47:46 -0300
Message-ID: <20151027144746.GF9405@kernel.org>
References: <562A81ED.70900@redhat.com>
 <562A82F5.8090306@gmail.com>
 <562A8A08.9010101@redhat.com>
 <562A8C0F.4090607@gmail.com>
 <20151026194933.GS27006@kernel.org>
 <562E9E29.1080003@gmail.com>
 <20151027123348.GV27006@kernel.org>
 <562F8703.7090103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50016 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345AbbJ0Orv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 27 Oct 2015 10:47:51 -0400
Content-Disposition: inline
In-Reply-To: <562F8703.7090103@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, William Cohen <wcohen@redhat.com>, =?utf-8?B?5aSn5bmz5oCc?= <rei.odaira@gmail.com>, oprofile-list <oprofile-list@lists.sourceforge.net>

Em Tue, Oct 27, 2015 at 08:15:31AM -0600, David Ahern escreveu:
> On 10/27/15 6:33 AM, Arnaldo Carvalho de Melo wrote:
> >>Correlating data to user readable information is a key part of perf.

> >Indeed, as best as it can.

> >>One option that might be able to solve this problem is to have perf
> >>kernel side walk the task list and generate the task events into the
> >>ring buffer (task diag code could be leveraged). This would be a lot
> >
> >It would have to do this over multiple iterations, locklessly wrt the
> >task list, in a non-intrusive way, which, in this case, could take
> >forever, no? :-)
> 
> taskdiag struggles to keep up because netlink messages have a limited size,
> the skb's have to be pushed to userspace and ack'ed and then the walk
> proceeds to the next task.
> 
> Filenames for the maps are the biggest killer on throughput wrt kernel side
> processing.
> 
> With a multi-MB ring buffer you have a much larger buffer to fill. In
> addition perf userspace can be kicked at a low watermark so it is draining
> that buffer as fast as it can:
> 
>    kernel   --->   ring buffer  --->  perf  -->  what?
> 
> The limiter here is perf userspace draining the buffer such that the kernel
> side does not have to take much if any break.
> 
> If the "What" is a file (e.g., perf record) then file I/O becomes a limiter.
> If the "What" is processing the data (e.g., perf top) we should be able to
> come up with some design that at least pulls the data into memory so the
> buffer never fills.
> 
> Sure there would need to be some progress limiters put to keep the kernel
> side from killing a cpu but I think this kind of design has the best chance
> of getting the most information for this class of problem.
> 
> And then for all of the much smaller more typical perf use cases this kind
> of data collection is much less expensive than walking proc. taskdiag shows
> that and this design is faster and more efficient than taskdiag.

Definetely, if we can avoid looking at /proc for what we need, that
would be better. Hope you can continue working on that or that someone
else picks the baton and get that to a mergeable form.

But in extreme cases, not even that would work.

- Arnaldo
