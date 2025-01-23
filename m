Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063847A7E;
	Thu, 23 Jan 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737670422; cv=none; b=CiqvwdnbZ9DMoyjM9ou71TWvIhM4vLgZtWIc7iNoXOzduvRW6ZiecMVk249XKJInl05+8Svqf7RVT4zYNEuAzelP5tTOxblKNvXcR2KDJGIqwFAxSxLcI95ughPyoktfXBTcF6PRvbnhLbECQqrop2HnvjJindb9HE323pNJYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737670422; c=relaxed/simple;
	bh=kzGyPgKrFjnjQyg0N5nFvb8yJub1kWJwJosvcHs7e44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgyV527hlEAY/m++Oc1oYa4vY9g8s+Cgh3nPLkhsHeewRsydIL9ELzUs0F5R9p7L9thE5Wk9PApBOhmpkzBIUIpXVZsDlJz0r0oY7N5QWOleTU+LVy4LrGqbsGi0U28h5SFBbOU1tQ64xvk1v7PrMryEW8/iSov8GRPl488gTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AHoOS5TA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AHoOS5TA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1XmXBwJOUuAbSPzd09IvhjTDlfWRZ1IlZO1Vb4f4Azc=; b=AHoOS5TAkbaLIjRPDeuePJR0TJ
	IeikVEEMq2rVTEthrfUUERQ7bJuf1lNu7xc3Gzc46kLyoLR4CVE8+IiGCJjNEccX9n+L1J8jGiTMC
	HtYh7O3bAiIDcHOCXX6TgEvx1we2eTx+ivmc7TLwdfZJAY81DwW1pAwKWtUdgisn5uiDo0oLyXnc/
	zleatk3qKg/yiOFmgiY6UGJVYqCGzE54dzXwl4RHgvQHKXAxSAM4+1PgERVdFszCxmATOeSarSw8Q
	JcP08psVScO5GatWyF/AWE9qzqFldzP3BjgoM+eY2d88Gam22V+/NFCQNAtfUHx3azLBm4BGCxqib
	QXzyK8lw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tb5S3-0000000B9Lt-1HA4;
	Thu, 23 Jan 2025 22:13:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E33533006E6; Thu, 23 Jan 2025 23:13:26 +0100 (CET)
Date: Thu, 23 Jan 2025 23:13:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250123221326.GD969@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
 <20250123040533.e7guez5drz7mk6es@jpoimboe>
 <20250123082534.GD3808@noisy.programming.kicks-ass.net>
 <20250123184305.rjuxj7hs3ond3e7c@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123184305.rjuxj7hs3ond3e7c@jpoimboe>

On Thu, Jan 23, 2025 at 10:43:05AM -0800, Josh Poimboeuf wrote:
> On Thu, Jan 23, 2025 at 09:25:34AM +0100, Peter Zijlstra wrote:
> > On Wed, Jan 22, 2025 at 08:05:33PM -0800, Josh Poimboeuf wrote:
> > 
> > > However... would it be a horrible idea for 'next' to unwind 'prev' after
> > > the context switch???
> > 
> > The idea isn't terrible, but it will be all sorta of tricky.
> > 
> > The big immediate problem is that the CPU doing the context switch
> > looses control over prev at:
> > 
> >   __schedule()
> >     context_switch()
> >       finish_task_switch()
> >         finish_task()
> > 	  smp_store_release(&prev->on_cpu, 0);
> > 
> > And this is before we drop rq->lock.
> > 
> > The instruction after that store another CPU is free to claim the task
> > and run with it. Notably, another CPU might already be spin waiting on
> > that state, trying to wake the task back up.
> > 
> > By the time we get to a schedulable context, @prev is completely out of
> > bounds.
> 
> Could unwind_deferred_request() call migrate_disable() or so?

That's pretty vile... and might cause performance issues. You realy
don't want things to magically start behaving differently just because
you're tracing.

> How bad would it be to set some bit in @prev to prevent it from getting
> rescheduled until the unwind from @next has been done?  Unfortunately
> two tasks would be blocked on the unwind instead of one.

Yeah, not going to happen. Those paths are complicated enough as is.

> BTW, this might be useful for another reason.  In Steve's sframe meeting
> yesterday there was some talk of BPF needing to unwind from
> sched-switch, without having to wait indefinitely for @prev to get
> rescheduled and return to user.

-EPONIES, you cannot take faults from the middle of schedule(). They can
always use the best effort FP unwind we have today.
