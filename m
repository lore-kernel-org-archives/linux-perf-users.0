From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 21:39:03 +0100
Message-ID: <1295901543.28776.475.camel@laptop>
References: <201101241704.01021.trenn@suse.de>
	 <20110124203449.GC2318@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50775 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1AXUio convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 24 Jan 2011 15:38:44 -0500
In-Reply-To: <20110124203449.GC2318@nowhere>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Renninger <trenn@suse.de>, tardyp@gmail.com, jean.pihet@newoldbits.com, acme@ghostprotocols.net, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

On Mon, 2011-01-24 at 21:34 +0100, Frederic Weisbecker wrote:
> 
> But instead of a global tracing ABI number, I would rather suggest
> one number per tracepoint subsystem (sched, power, etc...).
> 
> Ideally it would be per event, but sometimes those events tend to be
> renamed or a whole tracepoint subsystem refactored (see workqueue
> lately). Hence it might be better per subsystem. 

What's wrong with what we have? the /format file is pretty unique to
function as a version number of you use a hash over it.
