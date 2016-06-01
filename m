From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: spin_lock cause ?
Date: Wed, 1 Jun 2016 15:11:53 -0300
Message-ID: <20160601181153.GU2563@kernel.org>
References: <574F15E4.5070008@lexisnexis.com>
 <4716588.WReR5L1Wkn@milian-kdab2>
 <loom.20160601T194103-83@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44302 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbcFASL7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Jun 2016 14:11:59 -0400
Content-Disposition: inline
In-Reply-To: <loom.20160601T194103-83@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: M Kelly <mark.kelly@lexisnexis.com>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Jun 01, 2016 at 05:43:12PM +0000, M Kelly escreveu:
> Milian Wolff <milian.wolff <at> kdab.com> writes:
> > On Wednesday, June 1, 2016 1:05:40 PM CEST Kelly, Mark (RIS-BCT) wrote:
> > > Perf report for our application shows:
> > > 
> > >   34.27%  [kernel]                    [k] _spin_lock
> > >    8.19%  libjlib.so                  [.] CLZWExpander::expand(void*)
> > >    4.62%  libjhtree.so                [.] CMRUCacheOf<CKeyIdAndPos,
> > >    1.97%  [kernel]                    [k] futex_wait_setup

> > > Any suggestion for how to trace where/who is responsible for the 
> spin_lock ?

> > For both cases, you should collect backtraces which should allow you
> > to find culprits. Have you tried:

> > perf record --call-graph dwarf

> > or similar?
 
> ok, I will try it, thank you.  I will have to upgrade perf or move to a 
> newer kernel ? because dwarf does not seem to be supported on my current 
> system.  I will report back what it shows once I get it working.

No need for DWARF if you want to know what leads to the spinlock just up
to the syscall layer or if your userland components have frame pointers.
So first try with:

	perf record -g ./workload

Or:

	perf record -g -p `pidof workload`

- Arnaldo
