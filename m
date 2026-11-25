Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623236;
	b=BU5eLgrKY9C17Wl/w+qUHpX74yMSG4Jttay3Op73cHimyjj31/Y3a7k+RADLkMIP50T+
	 +s47E9SRwr07xQiAlAa3zb4TknnaDDEXa7Y52p8pHFvjY2TUzVqSN2BZc5cQeQLngeu5o
	 MZjqX5/hURp4zgOqlFvyAFrFsLzSPIxPKffIfl4qkdknIJwc6uE6DLiUAXw4TtoeaqNq5
	 fYPPODn4Dp+nEs5laRU8RLcc6xUyMzD6wTOFRwUVA60WSY0r9Ykmxo01S+HRqMby+8GaH
	 JEYkn94j8oOpj1mBphDlaM6vDmeIZj1d5y8KB70HAhwrx1iepuC0/VhdjOxecyWzxWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623236;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5qOmkXmsHsTBu6Rq8XKMQEDqKT3TuEpd8aaHF0KI42Y=;
	b=owO/pnSjVWuyD6SUL5TIMFEk8thrnxQxNNTm3m3+XOHRX7IbTvoszg10nQAFut+uz9rL
	 gYXOnZlIAvVxDrwySbRHtKG31yB8zqACb1oO8UyHtnXYK7hI+Fk1Pt5YbqRr1rE5jLoY6
	 PPrxk1/gZuny9/tielkcyjnPn49TLVERHud+cnwxeed8W4b1J6aCJWFOm/8bt0M5YL+C7
	 /3VH1fpW0V6XJ7jXulEBgbN+hHCr27HZFnK/Ru78FvxVsmabqmDMAdWIF5B48a0DyEd3/
	 lRnQy42N9FemGXxHZpyHlIijeaJsKLkCeQLEl5KL1b777KVGrufxetCY/AOFVmYA7uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JC03b3+N;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61244606A329;
	Wed, 25 Nov 2026 16:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61244606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=JC03b3+N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5qOmkXmsHsTBu6Rq8XKMQEDqKT3TuEpd8aaHF0KI42Y=; b=JC03b3+NYzhOLtIaTA9GOklkcg
	Qoq0pn9cihDklRrvmEjX0QRSnF9tZUYTJx58/jCUhDQudUrm2HR6KeRQAfxDujjrtqQ7JOg7APY2o
	d/bFWWPGapcoFeq6PqvrIhT2c5Qcuwn4ASrWN6ygn5kFTCLjcGuj+6sRCWV6zk9ISw2l6BTHbNFL+
	gD8eZJzUKlj6mydW+2HDk4oZUndmm+euCDrW+R9+mD/CBFsU0rQ/yHt5MkuCQI04lRfMEimQBp7Lv
	oYEpiuwrLwHvB9F1d6uHX1BC3rG888KeBveTjEf7CYKRENfbKlvKs++ith0+qwR0F31LEkJgl29Or
	umb2jZHA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFct-00000000EHg-2q1m;
	Wed, 25 Nov 2026 16:13:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72DCB302186; Wed, 25 Nov 2026 17:13:42 +0100 (CET)
Date: Wed, 25 Nov 2026 17:13:42 +0100
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
Message-ID: <20261125161342.GP2669272@noisy.programming.kicks-ass.net>
References: <20261120173706.GC2668564@noisy.programming.kicks-ass.net>
 <20261120174606.GM2669272@noisy.programming.kicks-ass.net>
 <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
 <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>
 <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
 <4d17dd3b-df73-45c0-8113-f4ca259d549b@huaweicloud.com>
 <20261125093836.GX2668804@noisy.programming.kicks-ass.net>
 <c9c2c4df-a748-4787-b686-1fe6bc6564db@huaweicloud.com>
 <6493eae2-9b36-4574-83ca-a139f4fbfb25@huaweicloud.com>
 <20261125133601.GC2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261125133601.GC2668804@noisy.programming.kicks-ass.net>

On Wed, Nov 25, 2026 at 02:36:01PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 25, 2026 at 06:09:04PM +0800, Tengda Wu wrote:
> 
> > >> Ah, I'm currently running it on an SPR Xeon; do I need to use
> > >> non-default arguments or just run the thing in a loop and drink tea
> > >> until it goes pop?
> > > 
> > > No need to pass any other arguments; running it as follows should be enough:
> > > 
> > >   for i {1..100}; do ./fast_swap ; done
> > > 
> > 
> > Correction: for i in {1..100}
> 
> I used: while :; do ./perf-sigtrap-switch-poc; done
> 
> > One more detail: I also specified a boot parameter (which might make it
> > easier to reproduce?):
> >   
> >   preempt=none
> 
> That option is no longer available.
> 
> Anyway, I've had it running for a few hours now; but no joy :-( -- this
> is an unmodified tip/master kernel since I wanted to make sure I could
> reproduce before trying to fix.
> 
> I'll just leave it running ...

7 hours and nothing :-(

I'm going to have to ask you to try and reproduce I'm afraid. 

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
@@ -10955,7 +10961,7 @@ static int __perf_event_overflow(struct
 		 * claim the pending_work before task_work_add() recurses.
 		 */
 		if (cmpxchg_local(&event->pending_work, 0, 1) == 0) {
-			if (!task_work_add(current, &event->pending_task, notify_mode)) {
+			if (!task_work_add(event->ctx->task, &event->pending_task, notify_mode)) {
 				event->pending_work = pending_id;
 				local_inc(&event->ctx->nr_no_switch_fast);
 				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
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
