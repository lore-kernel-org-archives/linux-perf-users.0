From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/3] perf events: add timehist option to record and report
Date: Fri, 18 Feb 2011 08:06:57 +0100
Message-ID: <20110218070657.GA11404@elte.hu>
References: <1298008433-22911-1-git-send-email-daahern@cisco.com>
 <1298008433-22911-4-git-send-email-daahern@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:45576 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477Ab1BRHHT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 18 Feb 2011 02:07:19 -0500
Content-Disposition: inline
In-Reply-To: <1298008433-22911-4-git-send-email-daahern@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, acme@ghostprotocols.net, paulus@samba.org, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>


* David Ahern <daahern@cisco.com> wrote:

> +--timehist::
> +        Generate time history output. This shows each sample with a wall-clock
> +        timestamp and address to symbol conversions. The samples are output in
> +        the same order they exist in the perf.data file. The --timehist option
> +        must be used with the record to get wall-clock timestamps.

Displaying samples this way is very useful, but how is this different from trace 
output - i.e. 'perf script' output?

There's a 'live logging mode' feature:

    perf record ./myworkload | perf inject -v -b | perf script -i -

( There's also some work going on to have a separate 'perf trace' utility that will
  output a linear trace of whatever events in perf.data are. )

So unless i'm missing something it would be more useful to extend 'perf script' (or 
the upcoming 'perf trace') to list regular samples in a perf.data (i.e. not rely on 
-R raw trace data alone), and of course allow a straightforward utilization of real 
timestamps, when available.

Thanks,

	Ingo
