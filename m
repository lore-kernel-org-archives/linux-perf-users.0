Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40634174A;
	Thu, 27 Feb 2025 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621859; cv=none; b=TWVGy1EJ7Jh4vqLPbD0AE/VewirWhK3d0te7hJPGG8VPuRH/jt2RRF7aXRsWohP0iKnF8w+955YJetT8nvM0eYRjVCPEfI4sqRmJ27IEPHM+u6N3liojNMthsDHIP5ETnmGCZ+px98AX7y2yJJexO63YSd02kwQ+G4gmV88Qk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621859; c=relaxed/simple;
	bh=WBTzOSlk9/Z04a8Ue9QXvkbbEPlD9D+SG/a81qVvzUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqQEjvHDCM+TGT1fHimrddteidvCjbh5NIYb8iGOeIgutYdKVM/5nAJYxcYsY9Hnweq9lQjCQKfSAWpRYWwATsPfHaCkIpudnhbmZ3t1Q0Ffm85uKlrJoOpW0d6lozdbhjt+tQ9+8ASvmJyawvKXN9u8rhcoNQfnisFk7ojx8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl5LUt5p; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl5LUt5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740621858; x=1772157858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WBTzOSlk9/Z04a8Ue9QXvkbbEPlD9D+SG/a81qVvzUA=;
  b=Wl5LUt5pNS0Ul+dFWjHeoHmFfZPWB3wG5znJMgJP3PQY7Q6PippSdGr7
   7OSY2LkJh6AWtzF+YNjJIx8TmH+/LcrIY5GW7Eup10HemVqN/PgHSqyCt
   4vF4ABhtATTweB4r0mWjqf0G2HtHPVduMHtaB8m2Ad/QNAWsOBn6xFaOy
   jP7mY2Qy5ElAlRZHVouA0GmSrmFuQ/tNzgIOQfWz7sqOl51FrsgW7Ja2x
   AOoqPrXsGMBWbM05O18qrCx2VzsHI5LL9uxcSrd+h0yRciGr1KCTY1jJd
   Ay23LOSguijMY5cvicU9zW/OI0YCNOcyHRuI0DBSt0/3jmO5NApMASsXs
   w==;
X-CSE-ConnectionGUID: gohqrIe5RRCEhVRSPci1Fg==
X-CSE-MsgGUID: zQdzrWBDQKm+kYRI9v+fFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41627785"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="41627785"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 18:04:17 -0800
X-CSE-ConnectionGUID: DFyAwIAfSJeIfjxrGk9vJA==
X-CSE-MsgGUID: quHqoJ8OQle7146QuQOgew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="147706492"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 18:04:13 -0800
Message-ID: <59321f8a-c804-4c0d-8941-3805c078d2c6@linux.intel.com>
Date: Thu, 27 Feb 2025 10:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or
 record fragments
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
 <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
 <20250225110012.GK31462@noisy.programming.kicks-ass.net>
 <c1450cf4-f367-4675-9f5e-90416a996af1@linux.intel.com>
 <20250226093558.GR11590@noisy.programming.kicks-ass.net>
 <98112b48-5ca6-4077-a842-83d1407f1860@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <98112b48-5ca6-4077-a842-83d1407f1860@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/26/2025 11:45 PM, Liang, Kan wrote:
>
> On 2025-02-26 4:35 a.m., Peter Zijlstra wrote:
>> On Wed, Feb 26, 2025 at 01:20:37PM +0800, Mi, Dapeng wrote:
>>
>>>> Also, should that workaround have been extended to also include
>>>> GLOBAL_STATUS_PERF_METRICS_OVF in that mask, or was that defect fixed
>>>> for every chip capable of metrics stuff?
>>> hmm,  per my understanding, GLOBAL_STATUS_PERF_METRICS_OVF handling should
>>> only be skipped when fixed counter 3 or perf metrics are included in PEBS
>>> counter group. In this case, the slots and topdown metrics have been
>>> updated by PEBS handler. It should not be processed again.
>>>
>>> @Kan Liang, is it correct?
>> Right, so the thing is, *any* PEBS event pending will clear METRICS_OVF
>> per:
>>
>>                 status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
>>
> Yes, we have to add it for both legacy PEBS and ARCH PEBS.
>
> An alternative way may change the order of handling the overflow bit.
>
> The commit daa864b8f8e3 ("perf/x86/pebs: Fix handling of PEBS buffer
> overflows") has moved the "status &= ~cpuc->pebs_enabled;" out of PEBS
> overflow code.
>
> As long as the PEBS overflow is handled after PT, I don't think the
> above is required anymore.
>
> It should be similar to METRICS_OVF. But the PEBS counters snapshotting
> should be specially handled, since the PEBS will handle the metrics
> counter as well.
>
> @@ -3211,7 +3211,8 @@ static int handle_pmi_common(struct pt_regs *regs,
> u64 status)
>  	/*
>  	 * Intel Perf metrics
>  	 */
> -	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned
> long *)&status)) {
> +	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned
> long *)&status) &&
> +	
> !is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS])) {
>  		handled++;
>  		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
>  	}

Yes, we still need to handle METRICS_OVF if fixed counter 3 and metrics are
not included into counter group. It ensure the metrics count can be updated
timely once PERF_METRICS MSR overflows.

Since there were more and more bits added into  GLOBAL_CTRL_STAT MSR in
past several years, it becomes not correct to execute the below code in
BUFFER_OVF_BIT handling code.

    status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;

It unconditionally clears METRICS_OVF and other bits which could be added
in the future. This is incorrect and could introduce potential issues.

Combining Kan's change, I think we can change the code like this.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8ef5b9a05fcc..0cf0f95b1af4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3192,7 +3192,6 @@ static int handle_pmi_common(struct pt_regs *regs,
u64 status)
        struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
        int bit;
        int handled = 0;
-       u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);

        inc_irq_stat(apic_perf_irqs);

@@ -3236,7 +3235,6 @@ static int handle_pmi_common(struct pt_regs *regs,
u64 status)
                handled++;
                x86_pmu_handle_guest_pebs(regs, &data);
                static_call(x86_pmu_drain_pebs)(regs, &data);
-               status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;

                /*
                 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3269,12 +3267,17 @@ static int handle_pmi_common(struct pt_regs *regs,
u64 status)

        /*
         * Intel Perf metrics
+        * If PEBS counter group includes fix counter 3, PEBS handler would
update
+        * topdown events which is more accurate, it's unnecessary to
update again.
         */
-       if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT,
(unsigned long *)&status)) {
+       if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT,
(unsigned long *)&status) &&
+          
!is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS])) {
                handled++;
                static_call(intel_pmu_update_topdown_event)(NULL, NULL);
        }

+       status &= hybrid(cpuc->pmu, intel_ctrl);
+
        /*
         * Checkpointed counters can lead to 'spurious' PMIs because the
         * rollback caused by the PMI will have cleared the overflow status


>
> Thanks,
> Kan
>
>
