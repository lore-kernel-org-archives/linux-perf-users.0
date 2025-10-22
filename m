Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8322E3E7;
	Wed, 22 Oct 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120743; cv=none; b=hwcwK4jVO46olLcpdUXCIx5d7d8yyA9Z03l//SUmFsxMnaz9Rw11nl4JpgYE/tyNgM2hfNi0eNM25sKvLmg18/zd4uTeQA53yiPBl2gyxTRFvwSG8j4LM5VfDpej589LTacOW4uMOdTV6AnhtqWHh2dZcTleqxFbYSnnHZG5Irg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120743; c=relaxed/simple;
	bh=CNvvmt4aRLhR3EA7iQudj9Uqz/0H0TOBiKxZ+P65Xgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3tDPwTskI9XUvmDjZceHYD6AsjZ1iZi4XTqopTkwOQsC8BVAMMmtmmUTi6IvaZZD0Z8Z9gEIIN26NkdgcfZD8q7mO5QpFiwwEQsCCdyPqJ8/Ybq89juo3E5G/Q25Nb4mgU2Yra8P5K3LXO5UPx8+X2UWhs7eqz0KiV8YeiH5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXRpRpAu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXRpRpAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761120741; x=1792656741;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CNvvmt4aRLhR3EA7iQudj9Uqz/0H0TOBiKxZ+P65Xgg=;
  b=WXRpRpAuBfU99f6uDb0UEU8jhxz4i9CfXJsb+F+taiPRMzCrqqnYjHBh
   uMJvlec9TYIx5Ejyr/ZWxVD88QeqrZLUlTNsYEBWWeip2oyWSzqqz/8DO
   MGuyMwm/vJX+vpBz5SQOIGZI34CmdbC+HHGVyzAqxR5gSfZsv8QQycXsv
   //CQvXlYTjLS7nN84Td/rPzvRahc+cY5PympcfAjPqnvHCCaY8JkVth17
   e0m4Jr2FOZAF7PwK7v+vDTfDCYgo/d57Zr8LeC3N3tgu7HEYN7Yl6h7Eg
   w9Zl9PWIlBpW1qxEEqTjvciR+TPQFWkK1rC90jwty15ikXucUH+6gVkLv
   g==;
X-CSE-ConnectionGUID: 4/xC6Uk0QC+V9HxiEDG1yg==
X-CSE-MsgGUID: j3FyLzUJRpaQydqkhHPufw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63170251"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="63170251"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:12:20 -0700
X-CSE-ConnectionGUID: +zmsoEzPS3yvWh5vfsTU3w==
X-CSE-MsgGUID: 1hh5zkdOTIyJTtIMl8D5Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="188935438"
Received: from unknown (HELO [10.238.3.234]) ([10.238.3.234])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:12:14 -0700
Message-ID: <fcb09e14-970c-4ebd-82f2-a12150fe3708@linux.intel.com>
Date: Wed, 22 Oct 2025 16:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, kernel test robot <oliver.sang@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-3-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251015064422.47437-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/15/2025 2:44 PM, Dapeng Mi wrote:
> When intel_pmu_drain_pebs_icl() is called to drain PEBS records, the
> perf_event_overflow() could be called to process the last PEBS record.
>
> While perf_event_overflow() could trigger the interrupt throttle and
> stop all events of the group, like what the below call-chain shows.
>
> perf_event_overflow()
>   -> __perf_event_overflow()
>     ->__perf_event_account_interrupt()
>       -> perf_event_throttle_group()
>         -> perf_event_throttle()
>           -> event->pmu->stop()
>             -> x86_pmu_stop()
>
> The side effect of stopping the events is that all corresponding event
> pointers in cpuc->events[] array are cleared to NULL.
>
> Assume there are two PEBS events (event a and event b) in a group. When
> intel_pmu_drain_pebs_icl() calls perf_event_overflow() to process the
> last PEBS record of PEBS event a, interrupt throttle is triggered and
> all pointers of event a and event b are cleared to NULL. Then
> intel_pmu_drain_pebs_icl() tries to process the last PEBS record of
> event b and encounters NULL pointer access.
>
> To avoid this NULL event access and potential PEBS record loss, snapshot
> cpuc->events[] into a local events[] before drian_pebs() helper calling
> perf_event_overflow() and then use the local events[] to process the
> left PEBS records.
>
> Besides intel_pmu_drain_pebs_nhm() has similar issue and fix it as well.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Suggested-by: Kan Liang <kan.liang@linux.intel.com>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/ds.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index c0b7ac1c7594..259a0ff807eb 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2487,6 +2487,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
>  
>  static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
>  {
> +	struct perf_event *events[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {NULL};
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct debug_store *ds = cpuc->ds;
>  	struct perf_event *event;
> @@ -2526,9 +2527,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  
>  		/* PEBS v3 has more accurate status bits */
>  		if (x86_pmu.intel_cap.pebs_format >= 3) {
> -			for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
> +			for_each_set_bit(bit, (unsigned long *)&pebs_status, size) {
>  				counts[bit]++;
> -
> +				if (counts[bit] && !events[bit])
> +					events[bit] = cpuc->events[bit];
> +			}
>  			continue;
>  		}
>  
> @@ -2566,19 +2569,31 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  		 * If collision happened, the record will be dropped.
>  		 */
>  		if (pebs_status != (1ULL << bit)) {
> -			for_each_set_bit(i, (unsigned long *)&pebs_status, size)
> +			for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
>  				error[i]++;
> +				if (error[i] && !events[i])
> +					events[i] = cpuc->events[i];
> +			}
>  			continue;
>  		}
>  
>  		counts[bit]++;
> +		/*
> +		 * perf_event_overflow() called by below __intel_pmu_pebs_events()
> +		 * could trigger interrupt throttle and clear all event pointers of
> +		 * the group in cpuc->events[] to NULL. So snapshot the event[] before
> +		 * it could be cleared. This avoids the possible NULL event pointer
> +		 * access and PEBS record loss.
> +		 */
> +		if (counts[bit] && !events[bit])
> +			events[bit] = cpuc->events[bit];
>  	}
>  
>  	for_each_set_bit(bit, (unsigned long *)&mask, size) {
>  		if ((counts[bit] == 0) && (error[bit] == 0))
>  			continue;
>  
> -		event = cpuc->events[bit];
> +		event = events[bit];
>  		if (WARN_ON_ONCE(!event))
>  			continue;
>  
> @@ -2603,6 +2618,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  
>  static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
>  {
> +	struct perf_event *events[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {NULL};
>  	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
>  	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> @@ -2655,6 +2671,16 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  						       setup_pebs_adaptive_sample_data);
>  			}
>  			last[bit] = at;
> +
> +			/*
> +			 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
> +			 * could trigger interrupt throttle and clear all event pointers of
> +			 * the group in cpuc->events[] to NULL. So snapshot the event[] before
> +			 * it could be cleared. This avoids the possible NULL event pointer
> +			 * access and PEBS record loss.
> +			 */
> +			if (counts[bit] && !events[bit])
> +				events[bit] = cpuc->events[bit];
>  		}
>  	}
>  
> @@ -2662,7 +2688,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  		if (!counts[bit])
>  			continue;
>  
> -		event = cpuc->events[bit];
> +		event = events[bit];
>  
>  		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
>  					    counts[bit], setup_pebs_adaptive_sample_data);

Hi Peter,

Just think twice about this fix, it seems current fix is incomplete.
Besides the PEBS handler, the basic PMI handler could encounter same issue,
like the below code in handle_pmi_common(),

    for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
        struct perf_event *event = cpuc->events[bit];
        u64 last_period;

        handled++;

        if (!test_bit(bit, cpuc->active_mask))
            continue;

Although the NULL event would not be accessed by checking
the cpuc->active_mask, the potential overflow process of these NULL events
is skipped as well, it may cause data loss.

Moreover, current approach defines temporary variables to snapshot the
active events, the temporary variables may consume too much stack memory
(384 bytes).

So I enhance the fix as below. Do you have any comment on this? Thanks.


diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 745caa6c15a3..7dc82ca87c11 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1738,6 +1738,25 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
        return handled;
 }

+inline void x86_pmu_snapshot_overflow_events(struct cpu_hw_events *cpuc)
+{
+       /*
+        * The perf_event_overflow() could call perf_event_throttle_group()
+        * to throttle all the events of group and clear all the corresponding
+        * cpuc->events[] pointers in PMI handler. This leads to PMI handler
+        * could get a NULL event pointer from cpuc->events[] when trying to
+        * process the overflow of the group member events. Even PMI handler
+        * checks if the event is NULL before acessing it and won't trigger
+        * a page fault, but PMI handler has to skip to overflow processing of
+        * these group member events and leads to data loss.
+        *
+        * To avoid this issue, snapshot the active events. Please notice this
+        * function should be called before the perf_event_overflow() calling
+        * loop in PMI handler. See handle_pmi_common().
+        */
+       memcpy(cpuc->overflow_events, cpuc->events, sizeof(cpuc->events));
+}
+
 void perf_events_lapic_init(void)
 {
        if (!x86_pmu.apic || !x86_pmu_initialized())
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468a6ea3..1d86600e3e6d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3241,13 +3241,14 @@ static int handle_pmi_common(struct pt_regs *regs,
u64 status)
         */
        status |= cpuc->intel_cp_status;

+       x86_pmu_snapshot_overflow_events(cpuc);
        for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
-               struct perf_event *event = cpuc->events[bit];
+               struct perf_event *event = cpuc->overflow_events[bit];
                u64 last_period;

                handled++;

-               if (!test_bit(bit, cpuc->active_mask))
+               if (WARN_ON_ONCE(!event))
                        continue;

                /*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..45b5be3643d4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2574,11 +2574,13 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
*iregs, struct perf_sample_d
                counts[bit]++;
        }

+       x86_pmu_snapshot_overflow_events(cpuc);
+
        for_each_set_bit(bit, (unsigned long *)&mask, size) {
                if ((counts[bit] == 0) && (error[bit] == 0))
                        continue;

-               event = cpuc->events[bit];
+               event = cpuc->overflow_events[bit];
                if (WARN_ON_ONCE(!event))
                        continue;

@@ -2634,6 +2636,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs
*iregs, struct perf_sample_d
        if (!iregs)
                iregs = &dummy_iregs;

+       x86_pmu_snapshot_overflow_events(cpuc);
+
        /* Process all but the last event for each counter. */
        for (at = base; at < top; at += basic->format_size) {
                u64 pebs_status;
@@ -2644,7 +2648,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs
*iregs, struct perf_sample_d

                pebs_status = basic->applicable_counters &
cpuc->pebs_enabled & mask;
                for_each_set_bit(bit, (unsigned long *)&pebs_status,
X86_PMC_IDX_MAX) {
-                       event = cpuc->events[bit];
+                       event = cpuc->overflow_events[bit];

                        if (WARN_ON_ONCE(!event) ||
                            WARN_ON_ONCE(!event->attr.precise_ip))
@@ -2662,7 +2666,9 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs
*iregs, struct perf_sample_d
                if (!counts[bit])
                        continue;

-               event = cpuc->events[bit];
+               event = cpuc->overflow_events[bit];
+               if (WARN_ON_ONCE(!event))
+                       continue;

                __intel_pmu_pebs_last_event(event, iregs, regs, data,
last[bit],
                                            counts[bit],
setup_pebs_adaptive_sample_data);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 285779c73479..32c6c3377621 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -256,6 +256,7 @@ struct cpu_hw_events {
         * Generic x86 PMC bits
         */
        struct perf_event       *events[X86_PMC_IDX_MAX]; /* in counter
order */
+       struct perf_event       *overflow_events[X86_PMC_IDX_MAX]; /* in
counter order */
        unsigned long           active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
        unsigned long           dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
        int                     enabled;
@@ -1277,6 +1278,8 @@ void x86_pmu_enable_event(struct perf_event *event);

 int x86_pmu_handle_irq(struct pt_regs *regs);

+void x86_pmu_snapshot_overflow_events(struct cpu_hw_events *cpuc);
+
 void x86_pmu_show_pmu_cap(struct pmu *pmu);

 static inline int x86_pmu_num_counters(struct pmu *pmu)


