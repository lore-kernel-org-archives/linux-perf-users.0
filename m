From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: timing information with perf
Date: Mon, 16 Nov 2015 22:31:44 -0300
Message-ID: <20151117013144.GB22729@kernel.org>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com>
 <y0my4dxx1f4.fsf@fche.csb>
 <20151117001233.GC11993@kernel.org>
 <20151117003020.GD25870@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59590 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbbKQBbs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Nov 2015 20:31:48 -0500
Content-Disposition: inline
In-Reply-To: <20151117003020.GD25870@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>, linux-perf-users@vger.kernel.org

Em Mon, Nov 16, 2015 at 07:30:20PM -0500, Frank Ch. Eigler escreveu:
> acme wrote:
 
> > [...]
> > > For completeness, a complete systemtap implementation of this could look like:
> >  
> > > # stap -e '
> > >    global s, t%
> > >    probe kernel.trace("foobar_enter") {
> > >        t[tid()]=gettimeofday_us() 
> > >    } [...]
> > > '

> > Is that done syncronously?

> Meaning - calculated live as the tracepoints hit?  Yes, right during
> the respective callbacks.  No trace files nor postprocessing.

Right, 'perf trace' is in between those extremes, i.e. no synchronous
processing, no trace file for postprocessing. Just the ring buffer, that
is continuously processed.

- Arnaldo
