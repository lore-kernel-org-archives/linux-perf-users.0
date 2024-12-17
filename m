Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86213D600;
	Tue, 17 Dec 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457562; cv=none; b=Q7QouH/sFaIHW8RzzfJy1O1oeLRn25gsnl4w0kGSWPRh8FII1wf3qcsBGMTELAH+fnRNfCC6vbAmRk+rTxIfmapqWQid6dDMNGT/jIvVGkd+ySfHqUVN9ptck97Ln9BMFU2CGVV30F9S3U6P8c91zmGe1KawQO5N4VvDdgUWDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457562; c=relaxed/simple;
	bh=Md7GxI0cD9vdv3XHml5zC+HhT+kf8mG+8VjRzYgHKiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9gtuNR77+liKtgQ470b9BgMBhntUFSHR8jcqV7I36RsLsoGdaeqLkdpfEOdlByn24qxwcipkVCiB6QmWFVkx+oESkl4ezuskx03htNgMCa8Uxv0IQ63ew4fBQp11MWxoocndz1rFhXO7GwDxpMabJuPzvETw/mRk+upUB0NJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRvKc2sh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRvKc2sh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734457560; x=1765993560;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Md7GxI0cD9vdv3XHml5zC+HhT+kf8mG+8VjRzYgHKiY=;
  b=JRvKc2shBHVwjZtT29g7i1AjtrAOLB5IJJiF+CvoopUxxjFsAVH6eaqz
   Un4F/l2NRt5nzyyZ2hUQjLnM+xrkCl/TV3LJmZFa3iZ8E5CrSyDibSifO
   yj7+/c6z1FA9xFRs3fnUy/kLnPUA/Z2oqihgNKDw8UX+FeNQI1BteqDH/
   Iwq5Ir0X8C8CUqDI3arHFkj+mrRO6Egs5w4GTrEPA8LrQ512W7V7KaDRg
   fizHKnQ7SERlFbUAfd6EDAvlDNMW53mVuFjWX6/K9OZjQw3Fp9hY792Xe
   wiq7x2wE40KL1S50YmArdC2HqOTdpkQLr+eUjwUVqY/FlKzIQJ0lbknWt
   A==;
X-CSE-ConnectionGUID: 8pUKhi2CREafK3ZjleZp2A==
X-CSE-MsgGUID: b+9CtP3kSz+v00RvRW+2QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="46306548"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="46306548"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 09:45:59 -0800
X-CSE-ConnectionGUID: ps0/AC+YTf++vAZFdFPLpQ==
X-CSE-MsgGUID: Au0S1/2ORb2gdCwcIIyHbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="97472168"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 09:45:59 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C2B1420B5713;
	Tue, 17 Dec 2024 09:45:57 -0800 (PST)
Message-ID: <96cb859f-8265-4f5a-99bb-44cfdcd25b9e@linux.intel.com>
Date: Tue, 17 Dec 2024 12:45:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/4] perf/x86/intel: Support PEBS counters snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com
References: <20241216204505.748363-1-kan.liang@linux.intel.com>
 <20241216204505.748363-4-kan.liang@linux.intel.com>
 <20241217133707.GB2354@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241217133707.GB2354@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-17 8:37 a.m., Peter Zijlstra wrote:
> On Mon, Dec 16, 2024 at 12:45:05PM -0800, kan.liang@linux.intel.com wrote:
> 
>> @@ -2049,6 +2102,40 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>>  		}
>>  	}
>>  
>> +	if (format_group & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
>> +		struct pebs_cntr_header *cntr = next_record;
>> +		int bit;
>> +
>> +		next_record += sizeof(struct pebs_cntr_header);
>> +
>> +		for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
>> +			x86_perf_event_update(cpuc->events[bit], (u64 *)next_record);
>> +			next_record += sizeof(u64);
>> +		}
> 
> I still don't much like any of this -- the next_record value might be in
> the past relative to what is already in the event.
>

I forgot to handle the read case. With the below patch, the next_record
value should not contain a previous value, unless there is a HW bug.
Because no matter it's read/pmi/context switch, perf always stop the
PMU, drains the buffer, and the value is always from the PEBS record.

There may be two places where perf directly reads the counter and update
the event->count. One is the x86_pmu_stop(). The other is to handle the
non-PEBS event's PMI. The PMU is stopped for both cases. The PEBS buffer
is also drained in advance. The next "next_record" must be a newer value.


diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 32b28d674641..13ab7fca72dd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2797,7 +2797,8 @@ static void intel_pmu_read_topdown_event(struct
perf_event *event)

 static void intel_pmu_read_event(struct perf_event *event)
 {
-	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+	if ((event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD) ||
+	    is_pebs_counter_event(event))
 		intel_pmu_auto_reload_read(event);
 	else if (is_topdown_count(event))
 		intel_pmu_read_topdown_event(event);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e06ac9a3cdf8..5e11b38427c7 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2181,10 +2181,8 @@ get_next_pebs_record_by_bit(void *base, void
*top, int bit)
 	return NULL;
 }

-void intel_pmu_auto_reload_read(struct perf_event *event)
+void intel_pmu_pebs_read(struct perf_event *event)
 {
-	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
-
 	perf_pmu_disable(event->pmu);
 	intel_pmu_drain_pebs_buffer();
 	perf_pmu_enable(event->pmu);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e88dd0fcc4d4..22b0c3e565a6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1650,7 +1650,7 @@ void intel_pmu_pebs_sched_task(struct
perf_event_pmu_context *pmu_ctx, bool sche

 void intel_pmu_pebs_update_cfg(struct cpu_hw_events *cpuc, int n, int
*assign);

-void intel_pmu_auto_reload_read(struct perf_event *event);
+void intel_pmu_pebs_read(struct perf_event *event);

 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);



> Why can't you use something like the below -- that gives you a count
> value matching the pmc value you put in, as long as it is 'near' the
> current value.
> 
> ---
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 8f218ac0d445..3cf8b4f2b2c1 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -154,6 +154,26 @@ u64 x86_perf_event_update(struct perf_event *event)
>  	return new_raw_count;
>  }
>  
> +u64 x86_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	int shift = 64 - x86_pmu.cntval_bits;
> +	u64 prev_pmc, prev_count;
> +	u64 delta;
> +
> +	do {
> +		prev_pmc = local64_read(&hwc->prev_count);
> +		barrier();
> +		prev_count = local64_read(&event->count);
> +		barrier();
> +	} while (prev_pmc != local64_read(&hwc->prev_count));

Is the "while()" to handle PMI? But there should be no PMI, since the
PMU has been disabled when draining the PEBS buffer.

I'm thinking to introduce a dedicated function to update the count from
pmc. It will only be used in the drain_pebs(). So we can avoid extending
the x86_perf_event_update() in patch 2. (Will do more tests.)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e06ac9a3cdf8..7f0b850f7277 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1969,6 +1969,23 @@ static void adaptive_pebs_save_regs(struct
pt_regs *regs,

 #define PEBS_LATENCY_MASK			0xffff

+void intel_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int shift = 64 - x86_pmu.cntval_bits;
+	u64 prev_pmc;
+	u64 delta;
+
+	prev_pmc = local64_read(&hwc->prev_count);
+
+	delta = (pmc << shift) - (prev_pmc << shift);
+	delta >>= shift;
+
+	local64_add(delta, &event->count);
+	local64_sub(delta, &hwc->period_left);
+	local64_set(&hwc->prev_count, pmc);
+}
+
 /*
  * With adaptive PEBS the layout depends on what fields are configured.
  */
@@ -2109,7 +2126,7 @@ static void setup_pebs_adaptive_sample_data(struct
perf_event *event,
 		next_record += sizeof(struct pebs_cntr_header);

 		for_each_set_bit(bit, (unsigned long *)&cntr->cntr,
INTEL_PMC_MAX_GENERIC) {
-			x86_perf_event_update(cpuc->events[bit], (u64 *)next_record);
+			intel_perf_event_pmc_to_count(cpuc->events[bit], (u64 *)next_record);
 			next_record += sizeof(u64);
 		}


Thanks,
Kan

> +
> +	delta = (pmc << shift) - (prev_pmc << shift);
> +	delta >>= shift;
> +
> +	return prev_count + delta;
> +}
> +
>  /*
>   * Find and validate any extra registers to set up.
>   */
> 

