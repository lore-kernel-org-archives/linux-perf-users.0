Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690887;
	b=sag7Ykw24TdGFWoLMJVEPa72scXAgcliAf02uzGsYSWnhohpbj1Fx9YA3kZJOOGkxSmI
	 5wFYz2N7ClbdzbT791BdAJcxVGywrF2uBc9LpABbDJEFoWqikDaGjLy1tku8lSAB1DJcQ
	 uwJGPlEbL1W0Ypvc5nhPtnW0axOdhP3ay8PnCiXehZWBmVebwGiAffi206QmDqLi0QTB9
	 QoGVDTTDp4Onmy2BZniNbiPA2ffa9ebxXB1LLE2H9JXzREz6u8jGAPNPmm3RMLdOI8/B1
	 wdHD/sk1vskaLPAiwgmXpRUacRYmts3Myz7wbEO4JJk5MJ5RUoX+Et9oYH0zNf37jJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690887;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=AjkCmVg9boAhx5Bo6HTIMk6d7GO9e3ihiIAWw/O7vls=;
	b=4tbMMbnKdPt1MNtCBg9kA0xLqhQkrvK3NjDdu8+mo9neGuPL8GVcEUO115cAwnSrs3Zr
	 CdQh9G/lL0GwfwKQhPHaIFJpPVXkMFH/Nr5OYpiMA2EvTlmTz72w42A86ZeZKLh5kUfoK
	 KRzfja5uUCQn3tmywWmaeta5UH5tQFzFHAB1uWTPANIORKoxOlrtSxLPEndgBISHXTR+8
	 cCtdWUWgTgekEDhWkYjIxxUWHepaug8lcD0Y2QxseKB6aOnKo+avh7929HwnKzDzM81jF
	 7reYoKNOBVkG5I/PWwIuAeMR8qztT2rHunMDHRvYCihfVR86XDQY86rsJtzQOGGaW2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mWXL1qew;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED4606A31E;
	Thu, 26 Nov 2026 11:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0ED4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mWXL1qew
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AjkCmVg9boAhx5Bo6HTIMk6d7GO9e3ihiIAWw/O7vls=; b=mWXL1qeweA2P2EHpiEfPtKLXGu
	szMsRxl5JknvxEMVn7aR0PdYdUclI/KygNP9c7aEMHVzLcOPtSTBwv41ieAAPP1N+2k0I0AH7tuBJ
	/wGcyCfT2pmDrM/CmRQDRNjuF3vxlkG4VGq+M5K2KN1F18VDJk2mdOK7ewc3tjOQ75NYE1XbXQIJH
	w9F6EXaXkCIpyGaNajRl72hUVTBKJr5XJunXM42WWT+/z+eeCI7KUGWzSj+Q8N0tWkuYTpuPf/Yej
	hcJVOQsI3/lLlwl6dMP6tpgI4OicCyS4ypjVp8S4+l5PmdGA94XXKhfQFlu0lMp3AAejg2xApUJ8x
	XwaI8HAQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXDx-00000006Lvh-3AvI;
	Thu, 26 Nov 2026 11:01:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A8B37303082; Thu, 26 Nov 2026 12:01:08 +0100 (CET)
Date: Thu, 26 Nov 2026 12:01:08 +0100
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
Message-ID: <20261126110108.GD49833@noisy.programming.kicks-ass.net>
References: <5507e48c-4e98-4e76-8d3f-4630a2655085@huaweicloud.com>
 <c9ff579b-a7eb-481f-bb8d-489a4469c397@huaweicloud.com>
 <20261125090809.GW2668804@noisy.programming.kicks-ass.net>
 <4d17dd3b-df73-45c0-8113-f4ca259d549b@huaweicloud.com>
 <20261125093836.GX2668804@noisy.programming.kicks-ass.net>
 <c9c2c4df-a748-4787-b686-1fe6bc6564db@huaweicloud.com>
 <6493eae2-9b36-4574-83ca-a139f4fbfb25@huaweicloud.com>
 <20261125133601.GC2668804@noisy.programming.kicks-ass.net>
 <20261125161342.GP2669272@noisy.programming.kicks-ass.net>
 <ea0a0fcf-0d96-416c-ba85-e98a8841cfb1@huaweicloud.com>
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
In-Reply-To: <ea0a0fcf-0d96-416c-ba85-e98a8841cfb1@huaweicloud.com>

On Thu, Nov 26, 2026 at 09:59:59AM +0800, Tengda Wu wrote:

> >>>   preempt=none
> >>
> >> That option is no longer available.
> >>
> 
> Uh, I tested on linux-next, base commit: 84abb955b101 (tag: next-20261113).
> That option is still present at that commit.

d3d16750693b ("sched: dynamic: Make PREEMPT_DYNAMIC depend on ARCH_HAS_PREEMPT_LAZY")


> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1236,6 +1236,7 @@ extern const struct perf_event_attr *per
> >  extern void perf_event_print_debug(void);
> >  extern void perf_pmu_disable(struct pmu *pmu);
> >  extern void perf_pmu_enable(struct pmu *pmu);
> > +extern bool perf_pmu_enabled(struct pmu *pmu);
> >  extern void perf_sched_cb_dec(struct pmu *pmu);
> >  extern void perf_sched_cb_inc(struct pmu *pmu);
> >  extern int perf_event_task_disable(void);
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1366,6 +1366,12 @@ void perf_pmu_enable(struct pmu *pmu)
> >  		pmu->pmu_enable(pmu);
> >  }
> >  
> > +bool perf_pmu_enabled(struct pmu *pmu)
> > +{
> > +	int *count = &this_cpc(pmu)->pmu_disable_count;
> > +	return *count == 0;
> > +}
> > +
> >  static void perf_assert_pmu_disabled(struct pmu *pmu)
> >  {
> >  	int *count = &this_cpc(pmu)->pmu_disable_count;
> > @@ -10955,7 +10961,7 @@ static int __perf_event_overflow(struct
> >  		 * claim the pending_work before task_work_add() recurses.
> >  		 */
> >  		if (cmpxchg_local(&event->pending_work, 0, 1) == 0) {
> > -			if (!task_work_add(current, &event->pending_task, notify_mode)) {
> > +			if (!task_work_add(event->ctx->task, &event->pending_task, notify_mode)) {
> >  				event->pending_work = pending_id;
> >  				local_inc(&event->ctx->nr_no_switch_fast);
> >  				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> > @@ -11151,6 +11157,9 @@ static int perf_swevent_match(struct per
> >  				struct perf_sample_data *data,
> >  				struct pt_regs *regs)
> >  {
> > +	if (!perf_pmu_enabled(event->pmu))
> > +		return 0;
> > +
> >  	if (event->attr.type != type)
> >  		return 0;
> >  
> > @@ -11531,6 +11540,9 @@ static int perf_tp_event_match(struct pe
> >  				struct perf_raw_record *raw,
> >  				struct pt_regs *regs)
> >  {
> > +	if (!perf_pmu_enabled(event->pmu))
> > +		return 0;
> > +
> >  	if (event->hw.state & PERF_HES_STOPPED)
> >  		return 0;
> >  	/*
> 
> 
> Hmm, I applied that patch to my local environment and tested it, and
> I no longer see the warning. The issue should be resolved.
> 
> Tested-by: Tengda Wu <wutengda@huaweicloud.com>

Excellent, thank you. Let me write up this one and land them in
perf/urgent.
