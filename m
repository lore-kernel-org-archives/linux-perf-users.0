From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: timing information with perf
Date: Mon, 16 Nov 2015 19:30:20 -0500
Message-ID: <20151117003020.GD25870@redhat.com>
References: <94D0C06D-C3A7-4BD1-9898-124EE0AA923D@netapp.com> <y0my4dxx1f4.fsf@fche.csb> <20151117001233.GC11993@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbbKQAaV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 16 Nov 2015 19:30:21 -0500
Content-Disposition: inline
In-Reply-To: <20151117001233.GC11993@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi -


acme wrote:

> [...]
> > For completeness, a complete systemtap implementation of this could look like:
>  
> > # stap -e '
> >    global s, t%
> >    probe kernel.trace("foobar_enter") {
> >        t[tid()]=gettimeofday_us() 
> >    } [...]
> > '
> 
> Is that done syncronously?

Meaning - calculated live as the tracepoints hit?  Yes, right during
the respective callbacks.  No trace files nor postprocessing.


- FChE
