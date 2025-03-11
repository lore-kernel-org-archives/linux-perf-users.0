Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3EF1DE2C7;
	Tue, 11 Mar 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692703; cv=none; b=o1OILGXxBnHdl0QTsVY4qsa38/50U2F8qES3mwI9L8qnbJqVWOutd+JyP5iQw6e/4XsSPuKEAJTJ8sBWTfh4ZfMKDv65jE7owC9VgkQe4Wkzb0emmC2t3jAuibGDSCqen2PxapuRgZYGHsgA/CltkvbKI7e0DD3dMzP6E2c9gvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692703; c=relaxed/simple;
	bh=kR3S0ccEOGKeFCsyABB5MUnsrQuat3HAhn9co3wXCDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv24xtvLoX6jlSyxi5eZN1e0zZ4YAS8mWQC+FML60bANzhvnOJtCZXIWu3ouYsb1CrakUpr4oITs8WFUZ4ENm0L/5jJ3nP6k6ObKs75ztGcDenSJhDdF4BhwbkvgkBJvARrqFCiQV4E6xDOVTAMLZoL95KS6VlbGEWog621Cu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=htGXWelU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="htGXWelU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gX0oE5lGbaC5HsJCFKke83AgOfwt5rZen3WV1FTI52U=; b=htGXWelUYXNZaSh86SY5odeA4h
	+hzDM+1lNmmW74wWnw1hs7oziGmHIJLF+j9p7Y6OteiCHzsWt8CpEJikE6bqhPvZNzR+NU0A+beOr
	J33E4vcskzuOEmJPBPSshmJBs2HOMKE0SKelqkb/8ho2sJNKXz1Qotnsl7iws0cjX0RmRoUQzfelJ
	T79SWp7aU2WD2+KIH56Jeb5R/YdnNhrZzSYdeRfdgnxtbfjbjxSETZa21zZ8YKKaHhmS1BtnnZns9
	PlTnHqLbVy/fmKSKRl5vQ6Y0BRX7p8HPm/nThEsehD4QZtGNJwHrT6pQvxlYgR9+y6XaHEQ2Ymzc8
	rGTKSjFw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trxpb-000000028S9-28Wv;
	Tue, 11 Mar 2025 11:31:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2734B3006C0; Tue, 11 Mar 2025 12:31:29 +0100 (CET)
Date: Tue, 11 Mar 2025 12:31:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mark.barnett@arm.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] perf: Allow adding fixed random jitter to the
 alternate sampling period
Message-ID: <20250311113128.GD19424@noisy.programming.kicks-ass.net>
References: <20250307202247.648633-1-mark.barnett@arm.com>
 <20250307202247.648633-4-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307202247.648633-4-mark.barnett@arm.com>

On Fri, Mar 07, 2025 at 08:22:45PM +0000, mark.barnett@arm.com wrote:
> From: Ben Gainey <ben.gainey@arm.com>
> 
> This change modifies the core perf overflow handler, adding some small
> random jitter to each sample period whenever an event switches between the
> two alternate sample periods. A new flag is added to perf_event_attr to
> opt into this behaviour.
> 
> This change follows the discussion in [1], where it is recognized that it
> may be possible for certain patterns of execution to end up with biased
> results.
> 
> [1] https://lore.kernel.org/linux-perf-users/Zc24eLqZycmIg3d2@tassilo/
> 
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>
> Signed-off-by: Mark Barnett <mark.barnett@arm.com>
> ---
>  include/uapi/linux/perf_event.h | 7 ++++++-
>  kernel/events/core.c            | 9 ++++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 499a8673df8e..c0076ce8f80a 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -461,7 +461,12 @@ struct perf_event_attr {
>  				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
>  				remove_on_exec :  1, /* event is removed from task on exec */
>  				sigtrap        :  1, /* send synchronous SIGTRAP on event */
> -				__reserved_1   : 26;
> +				/*
> +				 * Add a limited amount of jitter on each alternate period, where
> +				 * the jitter is between [0, (2<<jitter_alt_period) - 1]
> +				 */
> +				jitter_alt_period : 3,
> +				__reserved_1   : 23;

So; I've been thinking about this interface.

I think I prefer you keep the existing sample_period/sample_freq working
as is and simply modulate with random and high-freq components.

A very little like so..

I've made the hf_sample_period 32bit since I figured that ought to be
enough -- you're aiming at very short periods after all. But there's
enough unused bits left.

So this has sample_period or sample_freq compute hwc->sample_period_base
which is first modified with random such that the average is exactly
sample_period_base (assuming a flat distribution).

This means that sample_period_base is still the right number to use for
computing freq based things. Additionally, have the 'extra' interrupt
ignored for adaptive period crud.

Also, someone needs to consider the eBPF hook and what to do with it.
I've kept the ordering as per this series, but I suspect it's wrong and
we want this before the BPF hook. Please think about this and explicitly
mention this in the next series.

Anyway, very much a sketch of things, incomplete and not been near a
compiler.



---
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 76f4265efee9..c5dd6442e96f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -229,6 +229,10 @@ struct hw_perf_event {
 #define PERF_HES_UPTODATE	0x02 /* event->count up-to-date */
 #define PERF_HES_ARCH		0x04
 
+#define PERF_HES_HF_ON		0x10 /* using high-fred sampling */
+#define PERF_HES_HF_SAMPLE	0x20
+#define PERF_HES_HF_RAND	0x40
+
 	int				state;
 
 	/*
@@ -241,6 +245,7 @@ struct hw_perf_event {
 	 * The period to start the next sample with.
 	 */
 	u64				sample_period;
+	u64				sample_period_base;
 
 	union {
 		struct { /* Sampling */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0524d541d4e3..8dbe027f93f1 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -379,6 +379,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	144	/* add: hf_sample */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -531,6 +532,14 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	union {
+		__u64 hf_sample;
+		struct {
+			__u64 hf_sample_period : 32,
+			      hf_sample_rand   :  4,
+			      __reserved_4     : 28;
+		};
+	};
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b87a5ac42ce2..e5a93edf3b5f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8,6 +8,7 @@
  *  Copyright  ©  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
  */
 
+#include "linux/random.h"
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/cpu.h>
@@ -55,6 +56,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/prandom.h>
 
 #include "internal.h"
 
@@ -443,6 +445,8 @@ static cpumask_var_t perf_online_pkg_mask;
 static cpumask_var_t perf_online_sys_mask;
 static struct kmem_cache *perf_event_cache;
 
+static struct rnd_state perf_rand;
+
 /*
  * perf event paranoia level:
  *  -1 - not paranoid at all
@@ -4233,19 +4237,19 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 
 	period = perf_calculate_period(event, nsec, count);
 
-	delta = (s64)(period - hwc->sample_period);
+	delta = (s64)(period - hwc->sample_period_base);
 	if (delta >= 0)
 		delta += 7;
 	else
 		delta -= 7;
 	delta /= 8; /* low pass filter */
 
-	sample_period = hwc->sample_period + delta;
+	sample_period = hwc->sample_period_base + delta;
 
 	if (!sample_period)
 		sample_period = 1;
 
-	hwc->sample_period = sample_period;
+	hwc->sample_period_base = sample_period;
 
 	if (local64_read(&hwc->period_left) > 8*sample_period) {
 		if (disable)
@@ -4490,6 +4494,8 @@ void perf_event_task_tick(void)
 	if (ctx)
 		perf_adjust_freq_unthr_context(ctx, !!throttled);
 	rcu_read_unlock();
+
+	prandom_seed_state(&perf_rand, get_random_u64());
 }
 
 static int event_enable_on_exec(struct perf_event *event,
@@ -9979,6 +9985,8 @@ static int __perf_event_overflow(struct perf_event *event,
 				 int throttle, struct perf_sample_data *data,
 				 struct pt_regs *regs)
 {
+	struct hw_perf_event *hwc = &event->hw;
+	u64 sample_period;
 	int events = atomic_read(&event->event_limit);
 	int ret = 0;
 
@@ -9989,15 +9997,50 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (unlikely(!is_sampling_event(event)))
 		return 0;
 
-	ret = __perf_event_account_interrupt(event, throttle);
+	/*
+	 * High Freq samples are injected inside the larger period:
+	 *
+	 *   |------------|-|------------|-|
+	 *   P0          HF P1          HF
+	 *
+	 * By ignoring the HF samples, we measure the actual period.
+	 */
+	if (!(hwc->state & PERF_HES_HF_SAMPLE))
+		ret = __perf_event_account_interrupt(event, throttle);
 
 	if (event->attr.aux_pause)
 		perf_event_aux_pause(event->aux_event, true);
 
+	/* XXX interaction between HF samples and BPF */
 	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
 	    !bpf_overflow_handler(event, data, regs))
 		goto out;
 
+	sample_period = hwc->sample_period_base;
+	if (hwc->state & PERF_HES_HF_RAND) {
+		u64 rand = 1 << event->attr.hf_sample_rand;
+		sample_period -= rand / 2;
+		sample_period += prandom_u32_state(&perf_rand) & (rand - 1);
+	}
+	if (hwc->state & PERF_HES_HF_ON) {
+		u64 hf_sample_period = event->attr.hf_sample_period;
+
+		if (sample_period < hf_sample_period) {
+			hwc->state &= ~PERF_HES_HF_ON;
+			goto set_period;
+		}
+
+		if (!(hwc->state & PERF_HES_HF_SAMPLE)) {
+			hwc->sample_period -= hf_sample_period;
+			hwc->state |= PERF_HES_HF_SAMPLE;
+		} else {
+			hwc->sample_period = hf_sample_period;
+			hwc->state &= ~PERF_HES_HF_SAMPLE;
+		}
+	}
+set_period:
+	hwc->sample_period = sample_period;
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -12458,8 +12501,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	hwc = &event->hw;
 	hwc->sample_period = attr->sample_period;
-	if (attr->freq && attr->sample_freq)
+	hwc->sample_period_base = attr->sample_period;
+	if (attr->freq && attr->sample_freq) {
 		hwc->sample_period = 1;
+		hwc->sample_period_base = 1;
+	}
 	hwc->last_period = hwc->sample_period;
 
 	local64_set(&hwc->period_left, hwc->sample_period);
@@ -13824,6 +13870,7 @@ inherit_event(struct perf_event *parent_event,
 		struct hw_perf_event *hwc = &child_event->hw;
 
 		hwc->sample_period = sample_period;
+		hwc->sample_period_base = sample_period;
 		hwc->last_period   = sample_period;
 
 		local64_set(&hwc->period_left, sample_period);
@@ -14279,6 +14326,8 @@ void __init perf_event_init(void)
 {
 	int ret;
 
+	prandom_seed_state(&perf_rand, get_random_u64());
+
 	idr_init(&pmu_idr);
 
 	perf_event_init_all_cpus();

