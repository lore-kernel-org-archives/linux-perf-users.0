From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: timing information with perf
Date: Tue, 17 Nov 2015 10:39:59 -0300
Message-ID: <20151117133959.GN22729@kernel.org>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <y0my4dxx1f4.fsf@fche.csb>
 <20151117001233.GC11993@kernel.org>
 <564AA5AE.1020303@gmail.com>
 <20151117133111.GF25870@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50432 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752535AbbKQNkD (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Nov 2015 08:40:03 -0500
Content-Disposition: inline
In-Reply-To: <20151117133111.GF25870@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: David Ahern <dsahern@gmail.com>, "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Tue, Nov 17, 2015 at 08:31:11AM -0500, Frank Ch. Eigler escreveu:
> Hi -
> 
> > >>    global s, t%
> > >>    probe kernel.trace("foobar_enter") {
> > >>        t[tid()]=gettimeofday_us()
> > >>    }
> > >>    probe kernel.trace("foobar_exit") {
> > >>        if (tid() in t) { s <<< gettimeofday_us() - t[tid()] }
> > >>    }
> > >>    probe timer.s(5),end {
> > >>        printf("cumulative average us: %d\n", @avg(s))
> > >>    }
> > > [...]
> > 
> > Interesting solution. How does it scale with CPUs and tasks?
> 
> It's not a simple question, as there are several factors, but
> generally fine.
> 
> systemtap compiles down to native code, so execution is very fast and
> CPU consumption is not a problem (better than streaming to userspace &
> processing there).

That "better' is also not a simple answer, as there are several factors
:-)

Anyway, those are different methods, applicable to different scenarios
and sets of constraints, sometimes only one of these tools can be used,
due to these constraints, sometimes one can try several and see how they
fare.

- Arnaldo
 
> Depending on actual runtime behavior, there may be contention over the
> t[] array that tracks start-time.  systemtap automagically safely
> locks these for correctness.  If contention is high, trylock/timeouts
> can fail and some probes will be missed.  Fail too many and the script
> will self-terminate.  (See [man stap] for some of the related
> configurables.)
> 
> There is no contention over the s scalar value tracks elapsed time,
> since it is implicitly aggregated on a per-cpu basis.  That scales
> without problem.
> 
> - FChE
