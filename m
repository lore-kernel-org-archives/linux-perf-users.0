From: Arun Sharma <asharma@fb.com>
Subject: Re: perf for analyzing userspace contention
Date: Mon, 17 Oct 2011 16:43:32 -0700
Message-ID: <20111017234332.GA9745@dev1756.snc6.facebook.com>
References: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from intmgw002.ash2.facebook.com ([66.220.155.179]:61523 "EHLO
	intmgw002.ash2.facebook.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751407Ab1JRADe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 17 Oct 2011 20:03:34 -0400
Content-Disposition: inline
In-Reply-To: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Roland Dreier <roland@kernel.org>
Cc: linux-perf-users@vger.kernel.org

On Thu, Oct 13, 2011 at 11:36:23PM -0700, Roland Dreier wrote:
> Hi everyone,
> 
> Hope this question from a kernel hacker about profiling userspace
> isn't too dumb...
> 
> Anyway, suppose I have a multithreaded userspace app that uses a bunch of
> pthread_mutexes, and I want to figure out which locks are hot and/or heavily
> contended.  What's the best way to do that?  Is perf the right, or is there
> something better?  (This seems like such an obvious thing to want that there
> must be some good way to get this data, I hope)

Sampling on sys_futex entry/exit is a good start. But it doesn't tell
you if the thread spent 1us or 1ms waiting on the futex. We really need
to add weights to the profile based on sleep times (or other criteria).

You might want to follow further discussion in the thread with the
subject "Profiling sleep times?".

perf record -ag -e cs -- sleep 1

is a more general version of this. It helps in understanding what's
causing the thread to give up CPU voluntarily (you might have to filter
the output a bit).

 -Arun
