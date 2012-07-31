From: Ingo Molnar <mingo@kernel.org>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Tue, 31 Jul 2012 09:16:00 +0200
Message-ID: <20120731071600.GB2950@gmail.com>
References: <501121D3.3060700@mentor.com>
 <20120727072647.GA3965@gmail.com>
 <1343376002.32120.22.camel@twins>
 <20120727081830.GA4258@gmail.com>
 <1343377764.32120.29.camel@twins>
 <20120727115351.GA4514@gmail.com>
 <1343713645.20897.11.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58974 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2GaHQJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 31 Jul 2012 03:16:09 -0400
Received: by weyx8 with SMTP id x8so4123535wey.19
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Jul 2012 00:16:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343713645.20897.11.camel@twins>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Fri, 2012-07-27 at 13:53 +0200, Ingo Molnar wrote:
> > > Bloating the interface for something that is already well 
> > > possible is.
> > 
> > There's no 'bloat' worth speaking off: a single bit out of 
> > an already allocated bitmap, plus a single check in an 
> > already existing loop,
> 
> Uhm, no. The existing prctl() loop is over the fd's the task 
> owns, you want a loop over the fd's that monitor you. This 
> needs new prctl()s at the very least.

We could add a new prctl if you think, but I thought to not 
complicate it and offer it as a simple extension of the 
semantics to loop over active events. No existing binary's 
behavior will change.

Thanks,

	Ingo
