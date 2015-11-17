From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: timing information with perf
Date: Mon, 16 Nov 2015 21:12:33 -0300
Message-ID: <20151117001233.GC11993@kernel.org>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <y0my4dxx1f4.fsf@fche.csb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56603 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbbKQAMg (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Nov 2015 19:12:36 -0500
Content-Disposition: inline
In-Reply-To: <y0my4dxx1f4.fsf@fche.csb>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Mon, Nov 16, 2015 at 01:08:15PM -0500, Frank Ch. Eigler escreveu:
> Olga.Kornievskaia wrote:
 
> > [...] say there are two tracepoints ?foobar_enter? and
> > ?foobar_exit?. Each tracepoint logs a timestamp. I?d like to be able
> > to say that on average it takes that many time-units between ?enter?
> > and ?exit? tracepoints. [...]
 
> For completeness, a complete systemtap implementation of this could look like:
 
> # stap -e '
>    global s, t%
>    probe kernel.trace("foobar_enter") {
>        t[tid()]=gettimeofday_us() 
>    }
>    probe kernel.trace("foobar_exit") {
>        if (tid() in t) { s <<< gettimeofday_us() - t[tid()] } 
>    }
>    probe timer.s(5),end {
>        printf("cumulative average us: %d\n", @avg(s)) 
>    } 
> '

Is that done syncronously?

- Arnaldo
