From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Tue, 31 Jul 2012 07:47:25 +0200
Message-ID: <1343713645.20897.11.camel@twins>
References: <501121D3.3060700@mentor.com> <20120727072647.GA3965@gmail.com>
	 <1343376002.32120.22.camel@twins> <20120727081830.GA4258@gmail.com>
	 <1343377764.32120.29.camel@twins> <20120727115351.GA4514@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45871 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab2GaFrn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 31 Jul 2012 01:47:43 -0400
In-Reply-To: <20120727115351.GA4514@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 2012-07-27 at 13:53 +0200, Ingo Molnar wrote:
> > Bloating the interface for something that is already well 
> > possible is.
> 
> There's no 'bloat' worth speaking off: a single bit out of an 
> already allocated bitmap, plus a single check in an already 
> existing loop,

Uhm, no. The existing prctl() loop is over the fd's the task owns, you
want a loop over the fd's that monitor you. This needs new prctl()s at
the very least.
