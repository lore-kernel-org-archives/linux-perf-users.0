Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0A37E2F5;
	Tue, 24 Feb 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936156; cv=none; b=tetEw/JemOQ0AuzifdtrZ6nnQ3RPw/+tKv/jYMezKDyOZhqjAllQOh/+hGX8a3x0i03WYKohO2oH+Ye/NLhUDKZ4JueY+CdjaoPmcpy+LP5yoQiv0uUSUGLcET/HQOwrGTqN2sRTtXHxjD+EKZV+8RqlBFKMYmX4Qv2im6Rlo2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936156; c=relaxed/simple;
	bh=mwrcAwuysdEY+zaWGoGn3fb7fN8i7bOG4Bt9OSogH7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT76eGWSYgPBq/OBgMgP8FxS/wHJbfqIkBlJAhysmxicifyQJ+iWzrAycOzV84TQDlGTHrF6wLpLe798oYmQhmJ9+evzUFRDVQ3K+LGnMVsyKwWrwTtizghkzyuQL318YUF2mvnteAAfCwpI0xMEnKkSb5Tgf676c1VyWQKsR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WZEvUQC7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WZEvUQC7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xSZyONV2HDRdA68UjtbzZkjZWctnaWdjbGwh+MHOoXU=; b=WZEvUQC70i8+FxNRcwLQCh6WT8
	Ad0W3ZVA47Qkh8k/cL+xvkd9Pu+7tjTY2F6Oc0c7t5h6ViNIw1hsZoCd1clHaWIHVVQijk9f6LtsO
	BMvyZ0PJE4tALb6DCEqgSUl4h0UWIC5fBHUeaHHKUWKLbFDOFo93/iXdo4ytxBf6WWxkNhR12gQgf
	7lvjcf1JRJP+Fk0UJp9+UIIO34WvoHB1snTUA8gTZ2SmCVZLha9l93S8Tc7psw6RmBJMBkff9bzKx
	dSl4pjUzNxJtJ2QSfQvBkUWvfRyiuakRWGEl6P8Phr0OpsTk4OWrbu0BwxOQZy4DXobWxfj+wWBzb
	ShFaeZaw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vurXL-000000075b6-0cDx;
	Tue, 24 Feb 2026 12:29:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E1BBD300BDE; Tue, 24 Feb 2026 13:29:09 +0100 (CET)
Date: Tue, 24 Feb 2026 13:29:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qing Wang <wangqing7171@gmail.com>
Cc: henryzhangjcle@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, zeri@umich.edu
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
Message-ID: <20260224122909.GV1395416@noisy.programming.kicks-ass.net>
References: <20260127023618.1469937-1-zeri@umich.edu>
 <20260127083719.1347209-1-wangqing7171@gmail.com>
 <20260130100733.GZ171111@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130100733.GZ171111@noisy.programming.kicks-ass.net>

On Fri, Jan 30, 2026 at 11:07:33AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 27, 2026 at 04:37:19PM +0800, Qing Wang wrote:
> > On Tue, 27 Jan 2026 at 10:36, Henry Zhang <henryzhangjcle@gmail.com> wrote:
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index a0fa488bce84..1f3ed9e87507 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
> > >  		return -EPROTO;
> > >  	}
> > >  
> > > -	event->prog = prog;
> > > +	WRITE_ONCE(event->prog, prog);
> > >  	event->bpf_cookie = bpf_cookie;
> > >  	return 0;
> > >  }
> > > @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_event *event,
> > >  	if (event->attr.aux_pause)
> > >  		perf_event_aux_pause(event->aux_event, true);
> > >  
> > > -	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > > +	struct bpf_prog *prog = READ_ONCE(event->prog);
> > > +
> > > +	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > >  	    !bpf_overflow_handler(event, data, regs))
> > >  		goto out;
> > 
> > Looking at this code, I guess there may be an serious issue: a potential
> > use-after-free (UAF) risk when accessing event->prog in __perf_event_overflow.
> > 
> > CPU 0 (interrupt context)               CPU 1 (process context)
> > read event->prog
> >                                         perf_event_free_bpf_handler()
> >                                             put(prog)
> >                                                 free(prog)
> > access memory pointed to by prog
> > 
> > This scenario need to be more analysis.
> 
> This can only happen if the event can overlap with removal, which it
> typically cannot -- but I'll have to audit the software events.
> 
> Specifically, events happen in IRQ/NMI context, and event removal
> involves an IPI to that very CPU, which by necessity will then have to
> wait for event completion.

---
Subject: perf: Fix __perf_event_overflow() vs perf_remove_from_context() race

Make sure that __perf_event_overflow() runs with IRQs disabled for all
possible callchains. Specifically the software events can end up running
it with only preemption disabled.

This opens up a race vs perf_event_exit_event() and friends that will go
and free various things the overflow path expects to be present, like
the BPF program.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22a0f405585b..1f5699b339ec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10777,6 +10777,13 @@ int perf_event_overflow(struct perf_event *event,
 			struct perf_sample_data *data,
 			struct pt_regs *regs)
 {
+	/*
+	 * Entry point from hardware PMI, interrupts should be disabled here.
+	 * This serializes us against perf_event_remove_from_context() in
+	 * things like perf_event_release_kernel().
+	 */
+	lockdep_assert_irqs_disabled();
+
 	return __perf_event_overflow(event, 1, data, regs);
 }
 
@@ -10853,6 +10860,19 @@ static void perf_swevent_event(struct perf_event *event, u64 nr,
 {
 	struct hw_perf_event *hwc = &event->hw;
 
+	/*
+	 * This is:
+	 *   - software		preempt
+	 *   - tracepoint	preempt
+	 *   -   tp_target_task	irq (ctx->lock)
+	 *   - uprobes		preempt/irq
+	 *   - kprobes		preempt/irq
+	 *   - hw_breakpoint	irq
+	 *
+	 * Any of these are sufficient to hold off RCU and thus ensure @event
+	 * exists.
+	 */
+	lockdep_assert_preemption_disabled();
 	local64_add(nr, &event->count);
 
 	if (!regs)
@@ -10861,6 +10881,16 @@ static void perf_swevent_event(struct perf_event *event, u64 nr,
 	if (!is_sampling_event(event))
 		return;
 
+	/*
+	 * Serialize against event_function_call() IPIs like normal overflow
+	 * event handling. Specifically, must not allow
+	 * perf_event_release_kernel() -> perf_remove_from_context() to make
+	 * progress and 'release' the event from under us.
+	 */
+	guard(irqsave)();
+	if (event->state != PERF_EVENT_STATE_ACTIVE)
+		return;
+
 	if ((event->attr.sample_type & PERF_SAMPLE_PERIOD) && !event->attr.freq) {
 		data->period = nr;
 		return perf_swevent_overflow(event, 1, data, regs);
@@ -11359,6 +11389,11 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 	struct perf_sample_data data;
 	struct perf_event *event;
 
+	/*
+	 * Per being a tracepoint, this runs with preemption disabled.
+	 */
+	lockdep_assert_preemption_disabled();
+
 	struct perf_raw_record raw = {
 		.frag = {
 			.size = entry_size,
@@ -11691,6 +11726,11 @@ void perf_bp_event(struct perf_event *bp, void *data)
 	struct perf_sample_data sample;
 	struct pt_regs *regs = data;
 
+	/*
+	 * Exception context, will have interrupts disabled.
+	 */
+	lockdep_assert_irqs_disabled();
+
 	perf_sample_data_init(&sample, bp->attr.bp_addr, 0);
 
 	if (!bp->hw.state && !perf_exclude_event(bp, regs))
@@ -12155,7 +12195,7 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 	if (regs && !perf_exclude_event(event, regs)) {
 		if (!(event->attr.exclude_idle && is_idle_task(current)))
-			if (__perf_event_overflow(event, 1, &data, regs))
+			if (perf_event_overflow(event, &data, regs))
 				ret = HRTIMER_NORESTART;
 	}
 
