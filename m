Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196775;
	b=3U7WfZbAaU1HrmBFix8ae3RU8gJ0++fkyQFUHuDIi7DyF1X4GDihoW2Jf+TNbTdAdHst
	 vhGcQ3y3Llmmbo9IS6FXpkGwkrYo/olc5NifCLl5QvfwQFTOdSmunlBj4VJwuuF7LI/ak
	 gIGmznZogSgG+k/ia6R6HMk7F9t7rtXHiIObHRM8SHs16sy3RYtcCtOIDNf+IFclBsoCA
	 HE891mtSgtWgH7lQmCJxTQCapJsG7S0LNh2QYJY5/GL2lAmGGdOynr7TOc/73QeUSsYcH
	 I4TW1/61lDlm5Xj4r6XKUXtF18RH1A5Z044ZGqXIX0fFxUx/ylec7TwNoK6ap1+ZOaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196775;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sVY7MWQIvz+sf0B1y0osvF1uH0bUv57RDrGklku2fyM=;
	b=MWWk8Xe0mGymUSSaw2wPW9NWBvN2meGmTkqeHsemBT+ScwyzAMsJnI9Rdinnwba+5Z5O
	 7C8cu/bvCInpLzqqNberK7o9ezkyHUqQ/z9jT676YvthVuuGIPaqSQhpoSSfbluuaZyTR
	 RKgpG+B/OeedirH9I6gsM/HOF7ENLH6ZrWLEwt8UVFg8lcw4VYEVwx1m4dfEslMwO72o7
	 lWSyPiWHk5WeotfjHzo+1eR+lqE5wR78K9w4YY/fc8p18kvBC2kvvujsGsDAAxOdMYxWW
	 sKOGI1iNWpSREtqN5kz+af3qCkOA7ORTslUBqx8rCw0aph6loJgnYI5C8H91jEdKEJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=eFaiL06i;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8A606A330;
	Fri, 20 Nov 2026 17:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C8A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=eFaiL06i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sVY7MWQIvz+sf0B1y0osvF1uH0bUv57RDrGklku2fyM=; b=eFaiL06iZu7gluWZisskCzVADd
	83j/QHhO/xXvvoZ0wus7BAhk/nR8us/PjPCkq+BJPU3MvRBidwbOvDkMHh015NZgpr7pEz7H4LF/K
	zkpcww5q4F4BcOI7iHem+y0C+VeScFQSrAC/4ueblmwcOB3rYsmJl4ZxgtXEdJHBISfBzlHUm797h
	QXCLzsuHBsM7xIIf0uWW4ArrFtzcSnowSUCenKqnc/QZ5XsW/7Tgw4jSJG49eHE9xK/jAXA9XX0po
	jDo1qeb5SYQLkBj8UzzG7MAF2aehK05eisS5jwMNZcXwPNFS1leJqf2Cp0D+scYixltDINCojw2UU
	+/io72PQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSgZ-000000011e2-3rXn;
	Fri, 20 Nov 2026 17:46:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 756753008D6; Fri, 20 Nov 2026 18:46:06 +0100 (CET)
Date: Fri, 20 Nov 2026 18:46:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120173706.GC2668564@noisy.programming.kicks-ass.net>

On Fri, Nov 20, 2026 at 06:37:06PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 19, 2026 at 09:51:01AM +0000, Tengda Wu wrote:
> > perf_sigtrap() contains:
> > 
> > 	WARN_ON_ONCE(event->ctx->task != current)
> > 
> > The warning assumes that an event's ctx->task always matches the task
> > that ends up running the pending task_work. That assumption can be
> > broken by the context fast-swap path.
> > 
> > The failure sequence is:
> > 
> >   1. A -> B switch, perf_event_context_sched_out() takes the fast path
> >      and does WRITE_ONCE(ctx->task, next) / WRITE_ONCE(next_ctx->task, task).
> >      An NMI then hits while the context is swapped, and
> >      __perf_event_overflow() queues pending task_work on the *current*
> >      task (A), even though the event now belongs to B's swapped-in
> >      context view.
> > 
> >   2. B -> A switch. Because A now has pending task_work,
> >      nr_no_switch_fast is non-zero, so the slow path is taken and
> >      ctx->task is *not* swapped back.
> > 
> >   3. A returns to user mode, task_work runs perf_pending_task() ->
> >      perf_sigtrap(), and event->ctx->task no longer equals current,
> >      tripping the WARN_ON_ONCE().
> > 
> > The context fast-swap path was already excluded for events that need
> > stable task association (inherit + sample read). sigtrap events have
> > the same requirement: the SIGTRAP is targeted at ctx->task and must not
> > be delivered after ctx->task has been swapped to another task.
> 
> Oh gawd, let me guess, another one of those tracepoint events, right?
> 
> Must be someone that doesn't respect perf_ctx_disable(). Fixing that
> will close this hole.

Here, does this work?

The clue is right in perf_event_context_sched_out():

                          perf_ctx_disable(ctx, 0);

                          /* PMIs are disabled; ctx->nr_no_switch_fast is stable. */
                          if (local_read(&ctx->nr_no_switch_fast) ||
                              local_read(&next_ctx->nr_no_switch_fast)) {

There must be no overflow after perf_ctx_disable().


--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1236,6 +1236,7 @@ extern const struct perf_event_attr *per
 extern void perf_event_print_debug(void);
 extern void perf_pmu_disable(struct pmu *pmu);
 extern void perf_pmu_enable(struct pmu *pmu);
+extern bool perf_pmu_enabled(struct pmu *pmu);
 extern void perf_sched_cb_dec(struct pmu *pmu);
 extern void perf_sched_cb_inc(struct pmu *pmu);
 extern int perf_event_task_disable(void);
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1366,6 +1366,12 @@ void perf_pmu_enable(struct pmu *pmu)
 		pmu->pmu_enable(pmu);
 }
 
+bool perf_pmu_enabled(struct pmu *pmu)
+{
+	int *count = &this_cpc(pmu)->pmu_disable_count;
+	return *count == 0;
+}
+
 static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
 	int *count = &this_cpc(pmu)->pmu_disable_count;
@@ -11151,6 +11157,9 @@ static int perf_swevent_match(struct per
 				struct perf_sample_data *data,
 				struct pt_regs *regs)
 {
+	if (!perf_pmu_enabled(event->pmu))
+		return 0;
+
 	if (event->attr.type != type)
 		return 0;
 
@@ -11531,6 +11540,9 @@ static int perf_tp_event_match(struct pe
 				struct perf_raw_record *raw,
 				struct pt_regs *regs)
 {
+	if (!perf_pmu_enabled(event->pmu))
+		return 0;
+
 	if (event->hw.state & PERF_HES_STOPPED)
 		return 0;
 	/*
