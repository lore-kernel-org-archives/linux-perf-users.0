Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084620B81D;
	Thu, 23 Jan 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620059; cv=none; b=Lszm19vx9+Gil6o/fst6dGO7jvb1/+n+dJKlC9wOBrN1/8mcQom2o9MN7n0MWZI5LKQMmNU9wGjsJDNpgnb2vbGVJn2OorpYsIOpnBQy1LOBleEf9TR92fGDi87yHFHGlE3Dk1CpqhBbvZw93971MpFZKGWrCUR7nz5qVwiTidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620059; c=relaxed/simple;
	bh=vROsj2hp1Pfaf7r/gMvV4hEAqBJjRE0M26bZWw1HSdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMQNrYcQsw6OP/OT1dXoSKqeleUsV8r1bJe/0+9WZQt4lEK8PP7Ea1AGW5BsBLn8xsoYNNOv6i/ha1xgTzM7Scp817bT+mFm44ZCY1k3ioaWWNwroD/pB/ap3pYqLZedt/u2TJbxFw0kD85LE7DhQ3jZGKT4StNPSMw9k3qyMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kGds9UZ/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kGds9UZ/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DnDI6vNdsy+vgx9C523oD+xSrdWFQ2X4GKCb+SBDNJ4=; b=kGds9UZ/qx7dZ4wCLtzZbZykfo
	xIkebEmyQr9lx36Rq7HXYS3Mu6BzMDqk2tY3n9r3BLs+91t7fdeToLu2VJJvZ3MSq2vLl8KgYvC3m
	HI+MpR/AmTXHXw+Ey0ZmdQHU1PMHAi+AhUS5I9X1tkYRrcZOAXmbplE6RZShdJiT4v47JbzMpWs0b
	sBjYPPOpdopYrnMJ3NSENHwce1oHL8GiHFQQjd4vV8h1Tu/6WDGVksdA7ElE4p3MJPT8Rec9ns7ot
	EwXtABzJzVKeUcIiMJa5rRqFIUJJfR0qUSsq7dIeCM9dru1VPRCaCdMBV+imqZJPd7FGqS/VDmeJd
	yaloNPeg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tasLk-0000000Dkr2-0S5M;
	Thu, 23 Jan 2025 08:14:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 59C4C300717; Thu, 23 Jan 2025 09:14:03 +0100 (CET)
Date: Thu, 23 Jan 2025 09:14:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 01/39] task_work: Fix TWA_NMI_CURRENT error handling
Message-ID: <20250123081403.GA3808@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <b46cca62b5ebd131d0a744572e57f5ebc53d5ef4.1737511963.git.jpoimboe@kernel.org>
 <20250122122821.GN7145@noisy.programming.kicks-ass.net>
 <20250122204720.t42a4em5endxox3y@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122204720.t42a4em5endxox3y@jpoimboe>

On Wed, Jan 22, 2025 at 12:47:20PM -0800, Josh Poimboeuf wrote:
> On Wed, Jan 22, 2025 at 01:28:21PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 21, 2025 at 06:30:53PM -0800, Josh Poimboeuf wrote:
> > > It's possible for irq_work_queue() to fail if the work has already been
> > > claimed.  That can happen if a TWA_NMI_CURRENT task work is requested
> > > before a previous TWA_NMI_CURRENT IRQ work on the same CPU has gotten a
> > > chance to run.
> > 
> > I'm confused, if it fails then it's already pending, and we'll get the
> > notification already. You can still add the work.
> 
> Yeah, I suppose that makes sense.  If the pending irq_work is already
> going to set TIF_NOTIFY_RESUME anyway, there's no need to do that again.
> 
> > > The error has to be checked before the write to task->task_works.  Also
> > > the try_cmpxchg() loop isn't needed in NMI context.  The TWA_NMI_CURRENT
> > > case really is special, keep things simple by keeping its code all
> > > together in one place.
> > 
> > NMIs can nest,
> 
> Just for my understanding: for nested NMIs, the entry code basically
> queues up the next NMI, so the C handler (exc_nmi) can't nest.  Right?
> 
> > consider #DB (which is NMI like)
> 
> What exactly do you mean by "NMI like"?  Is it because a #DB might be
> basically running in NMI context, if the NMI hit a breakpoint?

No, #DB, #BP and such are considered NMI (and will have in_nmi() true)
because they can trigger anywhere, including sections where IRQs are
disabled.

> > doing task_work_add() and getting interrupted with NMI doing the same.
> 
> How exactly would that work?  At least with my patch the #DB wouldn't be
> able to use TWA_NMI_CURRENT unless in_nmi() were true

It is, see exc_debug_kernel() doing irqentry_nmi_enter().

