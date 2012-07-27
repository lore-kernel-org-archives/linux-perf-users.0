From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Fri, 27 Jul 2012 10:00:02 +0200
Message-ID: <1343376002.32120.22.camel@twins>
References: <501121D3.3060700@mentor.com> <20120727072647.GA3965@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50550 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135Ab2G0Il4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 27 Jul 2012 04:41:56 -0400
In-Reply-To: <20120727072647.GA3965@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Iegorov Oleg <oleg_iegorov@mentor.com>, linux-perf-users@vger.kernel.org, mingo@elte.hu, acme@ghostprotocols.net, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, 2012-07-27 at 09:26 +0200, Ingo Molnar wrote:
> 
> Maybe someone on Cc: would be interested in implementing this 
> new perf events feature? 

Why would we go build new kernel interfaces because userspace is silly?

It really isn't that hard to make userspace do what is needed, it just
takes a bit of work.
