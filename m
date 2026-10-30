Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352961;
	b=TZf2GCa0h6c9vlhDqloJbn4VLfbs0A1qYqWrvW1tR3z3jA4/eRERiDZ+BGyGVibJmFgy
	 PgaM/S6aiFcdc49kKLi/0A+SL21Ek2W1O8rGQ2c4CrheSRj5Wv5XMbKS1GS43Ws5Gg4JL
	 QFt/BL6YGYuaCmbTU7dFMb32WmosiWi1T0GgU4WXLVPRGXpFLAGxEedX4lo/C+CXMxEJg
	 0IyeTcJJ0B2k53CAGVNd0aPeOdwVhjszHNEXaIA430+k5jNGMJWVkPPM49nBKD+nUMcCu
	 VzC6DRVsVTZDr4HhIFQx0tELM65K7Ih5Gz+4O8cG+gv/mWY9QESH/0AyzqruHGqReog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352961;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=x9o6r/VsoGsntfex3KicOVDnW65DNVFPWdkUdpe3PZg=;
	b=VuS6UjqXNd+8XyvRbRFXkGgNCcxFDMhznzZAW9hYzzUDQTt0DGGyT10ypEhhlLVA4QF0
	 2y0XapyLtMwTLmFI2Ut9xT6IOnbbzmSobVy28w+4ldW31bVeRDOxhulA2utBbPWYhFGTL
	 Gc/IgaubnqQNxBBVRuEQgSxEvuYog6QaWg0Uiwov1m/cAiYPGpFZHk8UqUUuP87vGM2Qn
	 nfPAKSPyYIA0Llp3bDeNJixkCZPGsGvbVnw74fjYd/Lx3rUyQJ/r7kdos/JDqafffn5Vm
	 UatDmzd9kSIlZiQCZLZ/HS14C/PZNlIbJ0rziG9YzlZ4Zr2d1fGos729Bn6fMOyJPBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FSV+dO0c;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298B606A31A;
	Fri, 30 Oct 2026 09:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2298B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FSV+dO0c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793352961; x=1824888961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/92EWe3BozL40M6VpTJfDONY6Wy/Ak5Aoin2cokXLR0=;
  b=FSV+dO0cWPfMUJxEc+NgZ6r5K+5cI1VZfF73Fosh5HwmAqgzl9MtPVS4
   3+pBZImEI/ROVvmCV+9RLVo9QxiK7Jgo88tDK6bLrEmXwP/mzhJLW2A4b
   0WcN0RMJzb3E8wFgEFzDDqh7hvW4s+l8E7p28Krcqf8gk3mhl2ufUq34e
   dJM1To0qu2twY/ZyzllfrGvN+j/vivEIWDQJx4XAoFXqnU5+toVgdE/FW
   n9+KCss52kLWCKfhD9ECwEchvWG7Pear4R0qnnqSFjG4RLd0bByveGR2z
   4UMHlRk9UQQ1yD8RQ62GFLNEZ81GjNWr8oUHCSyvs1piphOtd0hkowQyG
   A==;
X-CSE-ConnectionGUID: 42+IS8ZnQ+6XfJ250pHQYA==
X-CSE-MsgGUID: dA9DdEVDR6GxOG5TGTTapQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1995495"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1995495"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:36:00 -0700
X-CSE-ConnectionGUID: gQBm39ynTqaN7z7Ja/QPJQ==
X-CSE-MsgGUID: X/E1FP1jTjuROeIqVhzzgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7206726"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:35:55 -0700
Message-ID: <bfe3c581-0ddb-4c3c-b3d9-6e01799c8077@linux.intel.com>
Date: Fri, 30 Oct 2026 17:35:52 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 10/18] perf/x86/intel: Allow LBR read helpers to
 operate on explicit stacks
To: Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-11-dapeng1.mi@linux.intel.com>
 <20261029103857.GL1779021@noisy.programming.kicks-ass.net>
 <e7bb28e7-cf1a-44b3-9ce9-3e6ab228d34f@linux.intel.com>
 <20261030092600.GL2668804@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261030092600.GL2668804@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/30/2026 5:26 PM, Peter Zijlstra wrote:
> On Fri, Oct 30, 2026 at 09:05:59AM +0800, Mi, Dapeng wrote:
>> On 10/29/2026 6:38 PM, Peter Zijlstra wrote:
>>> On Thu, Oct 29, 2026 at 12:39:06PM +0800, Dapeng Mi wrote:
>>>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>>>> index ee724b28d90c..63f0504f9d2a 100644
>>>> --- a/arch/x86/events/intel/lbr.c
>>>> +++ b/arch/x86/events/intel/lbr.c
>>>> @@ -105,7 +105,10 @@
>>>>  
>>>>  #define ARCH_LBR_CTL_MASK			0x7f000e
>>>>  
>>>> -static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
>>>> +static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
>>>> +				 struct perf_branch_stack *lbr_stack,
>>>> +				 struct perf_branch_entry *lbr_entries,
>>>> +				 u64 *lbr_counters);
>>>>  
>>>>  static __always_inline bool is_lbr_call_stack_bit_set(u64 config)
>>>>  {
>>>> @@ -741,10 +744,12 @@ void intel_pmu_lbr_disable_all(void)
>>>>  	}
>>>>  }
>>>>  
>>>> -void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>>>> +void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc,
>>>> +			   struct perf_branch_stack *lbr_stack,
>>>> +			   struct perf_branch_entry *lbr_entries)
>>>>  {
>>>>  	unsigned long mask = x86_pmu.lbr_nr - 1;
>>>> -	struct perf_branch_entry *br = cpuc->lbr_entries;
>>>> +	struct perf_branch_entry *br = lbr_entries;
>>>>  	u64 tos = intel_pmu_lbr_tos();
>>>>  	int i;
>>>>  
>>>> @@ -775,11 +780,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>>>>   * is the same as the linear address, allowing us to merge the LIP and EIP
>>>>   * LBR formats.
>>>>   */
>>>> -void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
>>>> +void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc,
>>>> +			   struct perf_branch_stack *lbr_stack,
>>>> +			   struct perf_branch_entry *lbr_entries)
>>>>  {
>>>>  	bool need_info = false, call_stack = false;
>>>>  	unsigned long mask = x86_pmu.lbr_nr - 1;
>>>> -	struct perf_branch_entry *br = cpuc->lbr_entries;
>>>> +	struct perf_branch_entry *br = lbr_entries;
>>>>  	u64 tos = intel_pmu_lbr_tos();
>>>>  	int i;
>>>>  	int out = 0;
>>> This makes no sense; why do you keep passing lbr_entries around when we
>>> have lbr_stack.entries[] ?
>> Yeah, that's actually what I did at the beginning. But sashiko raised the
>> warning below. :(
>>
>> "
>>
>> Does this trigger a CONFIG_UBSAN_BOUNDS panic when intel_pmu_store_lbr()
>> is inlined?
>> The lbr_stack pointer points to a struct
>> perf_branch_stack embedded directly in struct cpu_hw_events. Because it
>> is an embedded value-type struct, the compiler considers its size to be
>> fixed (16 bytes), treating the trailing flexible array member entries[]
>> as having 0 elements.
>> Accessing lbr_stack->entries[i] where i >= 0 can trigger strict array
>> bounds violations under -fstrict-flex-arrays=3 and CONFIG_UBSAN_BOUNDS.
>>
>> "
> So I'm generally in favour bounds checking; but:
>
>  - it really should get removed from UBSAN;
>  - this flex array nonsense is absolutely insane.
>
> There is this TRAILING_OVERLAP thing, which is complete and utter
> batshit insane crazy and I will refuse to use it.
>
> So one, we already violate this, and two, if we want to fix it something
> like so will probably do.
>
> ---
>
> diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
> index 54b13faba116..8a103ff631e5 100644
> --- a/arch/x86/events/amd/brs.c
> +++ b/arch/x86/events/amd/brs.c
> @@ -282,7 +282,6 @@ void amd_brs_drain(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct perf_event *event = cpuc->events[0];
> -	struct perf_branch_entry *br = cpuc->lbr_entries;
>  	union amd_debug_extn_cfg cfg;
>  	u32 i, nr = 0, num, tos, start;
>  	u32 shift = 64 - boot_cpu_data.x86_virt_bits;
> @@ -343,7 +342,7 @@ void amd_brs_drain(void)
>  		if (!amd_brs_match_plm(event, from, to))
>  			continue;
>  
> -		br[nr] = (struct perf_branch_entry){
> +		cpu_lbr_stack(cpuc)->entries[nr] = (struct perf_branch_entry){
>  			.from	= from,
>  			.to	= to,
>  		};
> @@ -351,7 +350,7 @@ void amd_brs_drain(void)
>  	}
>  empty:
>  	/* Record number of sampled branches */
> -	cpuc->lbr_stack.nr = nr;
> +	cpu_lbr_stack(cpuc)->nr = nr;
>  }
>  
>  /*
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce566..1115457c12f4 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -945,7 +945,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>  
>  	amd_pmu_lbr_read();
>  	cnt = min(cnt, x86_pmu.lbr_nr);
> -	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> +	memcpy(entries, cpu_lbr_stack(cpuc)->entries, sizeof(struct perf_branch_entry) * cnt);
>  
>  	amd_pmu_v2_enable_all(0);
>  	local_irq_restore(flags);
> @@ -1014,7 +1014,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  		if (!x86_perf_event_set_period(event))
>  			continue;
>  
> -		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
> +		perf_sample_save_brstack(&data, event, cpu_lbr_stack(cpuc), NULL);
>  
>  		perf_event_overflow(event, &data, regs);
>  	}
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index a55646fcb846..faa6d4893375 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -110,9 +110,9 @@ static void amd_pmu_lbr_filter(void)
>  	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
>  		fused_only = true;
>  
> -	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
> -		from = cpuc->lbr_entries[i].from;
> -		to = cpuc->lbr_entries[i].to;
> +	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
> +		from = cpu_lbr_stack(cpuc)->entries[i].from;
> +		to = cpu_lbr_stack(cpuc)->entries[i].to;
>  		type = branch_type_fused(from, to, 0, &offset);
>  
>  		/*
> @@ -121,33 +121,33 @@ static void amd_pmu_lbr_filter(void)
>  		 * actual branch
>  		 */
>  		if (offset) {
> -			cpuc->lbr_entries[i].from += offset;
> +			cpu_lbr_stack(cpuc)->entries[i].from += offset;
>  			if (fused_only)
>  				continue;
>  		}
>  
>  		/* If type does not correspond, then discard */
>  		if (type == X86_BR_NONE || (br_sel & type) != type ||
> -		    (!(br_sel & X86_BR_KERNEL) && kernel_ip(cpuc->lbr_entries[i].from))) {
> -			cpuc->lbr_entries[i].from = 0;	/* mark invalid */
> +		    (!(br_sel & X86_BR_KERNEL) && kernel_ip(cpu_lbr_stack(cpuc)->entries[i].from))) {
> +			cpu_lbr_stack(cpuc)->entries[i].from = 0;	/* mark invalid */
>  			compress = true;
>  		}
>  
>  		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
> -			cpuc->lbr_entries[i].type = common_branch_type(type);
> +			cpu_lbr_stack(cpuc)->entries[i].type = common_branch_type(type);
>  	}
>  
>  	if (!compress)
>  		return;
>  
>  	/* Remove all invalid entries */
> -	for (i = 0; i < cpuc->lbr_stack.nr; ) {
> -		if (!cpuc->lbr_entries[i].from) {
> +	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; ) {
> +		if (!cpu_lbr_stack(cpuc)->entries[i].from) {
>  			j = i;
> -			while (++j < cpuc->lbr_stack.nr)
> -				cpuc->lbr_entries[j - 1] = cpuc->lbr_entries[j];
> -			cpuc->lbr_stack.nr--;
> -			if (!cpuc->lbr_entries[i].from)
> +			while (++j < cpu_lbr_stack(cpuc)->nr)
> +				cpu_lbr_stack(cpuc)->entries[j - 1] = cpu_lbr_stack(cpuc)->entries[j];
> +			cpu_lbr_stack(cpuc)->nr--;
> +			if (!cpu_lbr_stack(cpuc)->entries[i].from)
>  				continue;
>  		}
>  		i++;
> @@ -164,7 +164,6 @@ static const int lbr_spec_map[PERF_BR_SPEC_MAX] = {
>  void amd_pmu_lbr_read(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct perf_branch_entry *br = cpuc->lbr_entries;
>  	struct branch_entry entry;
>  	int out = 0, idx, i;
>  
> @@ -202,7 +201,7 @@ void amd_pmu_lbr_read(void)
>  		 */
>  		idx = (entry.to.split.valid << 1) | entry.to.split.spec;
>  
> -		br[out] = (struct perf_branch_entry){
> +		cpu_lbr_stack(cpuc)->entries[out] = (struct perf_branch_entry){
>  			.from		= sign_ext_branch_ip(entry.from.split.ip),
>  			.to		= sign_ext_branch_ip(entry.to.split.ip),
>  			.mispred	= entry.from.split.mispredict,
> @@ -212,13 +211,13 @@ void amd_pmu_lbr_read(void)
>  		out++;
>  	}
>  
> -	cpuc->lbr_stack.nr = out;
> +	cpu_lbr_stack(cpuc)->nr = out;
>  
>  	/*
>  	 * Internal register renaming always ensures that LBR From[0] and
>  	 * LBR To[0] always represent the TOS
>  	 */
> -	cpuc->lbr_stack.hw_idx = 0;
> +	cpu_lbr_stack(cpuc)->hw_idx = 0;
>  
>  	/* Perform further software filtering */
>  	amd_pmu_lbr_filter();
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 4e344fb1ae3e..edfcc28dbe00 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2197,7 +2197,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>  
>  		perf_sample_data_init(&data, 0, last_period);
>  
> -		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
> +		perf_sample_save_brstack(&data, event, cpu_lbr_stack(cpuc), NULL);
>  
>  		perf_event_overflow(event, &data, regs);
>  	}
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 8444670cee4a..b2a4b4e87f5f 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2010,8 +2010,8 @@ void intel_pmu_pebs_disable_all(void)
>  static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	unsigned long from = cpuc->lbr_entries[0].from;
> -	unsigned long old_to, to = cpuc->lbr_entries[0].to;
> +	unsigned long from = cpu_lbr_stack(cpuc)->entries[0].from;
> +	unsigned long old_to, to = cpu_lbr_stack(cpuc)->entries[0].to;
>  	unsigned long ip = regs->ip;
>  	int is_64bit = 0;
>  	void *kaddr;
> @@ -2026,7 +2026,7 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
>  	/*
>  	 * No LBR entry, no basic block, no rewinding
>  	 */
> -	if (!cpuc->lbr_stack.nr || !from || !to)
> +	if (!cpu_lbr_stack(cpuc)->nr || !from || !to)
>  		return 0;
>  
>  	/*
> @@ -2318,7 +2318,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>  	if (x86_pmu.intel_cap.pebs_format >= 3)
>  		setup_pebs_time(event, data, pebs->tsc);
>  
> -	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
> +	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
>  }
>  
>  static void adaptive_pebs_save_regs(struct pt_regs *regs,
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 0b446d8912e4..c0058ee7f30f 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -740,7 +740,6 @@ void intel_pmu_lbr_disable_all(void)
>  void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>  {
>  	unsigned long mask = x86_pmu.lbr_nr - 1;
> -	struct perf_branch_entry *br = cpuc->lbr_entries;
>  	u64 tos = intel_pmu_lbr_tos();
>  	int i;
>  
> @@ -756,14 +755,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>  
>  		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
>  
> -		*br = (struct perf_branch_entry){
> +		cpu_lbr_stack(cpuc)->entries[i] = (struct perf_branch_entry){
>  			.from	= msr_lastbranch.from,
>  			.to	= msr_lastbranch.to,
>  		};
> -		br++;
>  	}
> -	cpuc->lbr_stack.nr = i;
> -	cpuc->lbr_stack.hw_idx = tos;
> +	cpu_lbr_stack(cpuc)->nr = i;
> +	cpu_lbr_stack(cpuc)->hw_idx = tos;
>  }
>  
>  /*
> @@ -775,7 +773,6 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
>  {
>  	bool need_info = false, call_stack = false;
>  	unsigned long mask = x86_pmu.lbr_nr - 1;
> -	struct perf_branch_entry *br = cpuc->lbr_entries;
>  	u64 tos = intel_pmu_lbr_tos();
>  	int i;
>  	int out = 0;
> @@ -847,7 +844,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
>  		if (abort && x86_pmu.lbr_double_abort && out > 0)
>  			out--;
>  
> -		br[out] = (struct perf_branch_entry){
> +		cpu_lbr_stack(cpuc)->entries[out] = (struct perf_branch_entry){
>  			.from		= from,
>  			.to		= to,
>  			.mispred	= mis,
> @@ -858,8 +855,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
>  		};
>  		out++;
>  	}
> -	cpuc->lbr_stack.nr = out;
> -	cpuc->lbr_stack.hw_idx = tos;
> +	cpu_lbr_stack(cpuc)->nr = out;
> +	cpu_lbr_stack(cpuc)->hw_idx = tos;
>  }
>  
>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
> @@ -903,7 +900,6 @@ static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LB
>  static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>  				struct lbr_entry *entries)
>  {
> -	struct perf_branch_entry *e;
>  	struct lbr_entry *lbr;
>  	u64 from, to, info;
>  	bool mispred;
> @@ -911,7 +907,6 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>  
>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>  		lbr = entries ? &entries[i] : NULL;
> -		e = &cpuc->lbr_entries[i];
>  
>  		from = rdlbr_from(i, lbr);
>  		/*
> @@ -925,7 +920,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>  
>  		mispred = get_lbr_mispred(info);
>  
> -		*e = (struct perf_branch_entry){
> +		cpu_lbr_stack(cpuc)->entries[i] = (struct perf_branch_entry){
>  			.from		= from,
>  			.to		= to,
>  			.mispred	= mispred,
> @@ -946,7 +941,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>  		};
>  	}
>  
> -	cpuc->lbr_stack.nr = i;
> +	cpu_lbr_stack(cpuc)->nr = i;
>  }
>  
>  /*
> @@ -972,15 +967,15 @@ static void intel_pmu_lbr_counters_reorder(struct cpu_hw_events *cpuc,
>  
>  	WARN_ON_ONCE(!pos);
>  
> -	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
> -		src = cpuc->lbr_entries[i].reserved;
> +	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
> +		src = cpu_lbr_stack(cpuc)->entries[i].reserved;
>  		dst = 0;
>  		for (j = 0; j < pos; j++) {
>  			cnt = (src >> (order[j] * LBR_INFO_BR_CNTR_BITS)) & LBR_INFO_BR_CNTR_MASK;
>  			dst |= cnt << j * LBR_INFO_BR_CNTR_BITS;
>  		}
>  		cpuc->lbr_counters[i] = dst;
> -		cpuc->lbr_entries[i].reserved = 0;
> +		cpu_lbr_stack(cpuc)->entries[i].reserved = 0;
>  	}
>  }
>  
> @@ -990,11 +985,11 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
>  {
>  	if (is_branch_counters_group(event)) {
>  		intel_pmu_lbr_counters_reorder(cpuc, event);
> -		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, cpuc->lbr_counters);
> +		perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), cpuc->lbr_counters);
>  		return;
>  	}
>  
> -	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
> +	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
>  }
>  
>  static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
> @@ -1216,21 +1211,22 @@ static const int arch_lbr_br_type_map[ARCH_LBR_BR_TYPE_MAP_MAX] = {
>  static void
>  intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  {
> -	u64 from, to;
>  	int br_sel = cpuc->br_sel;
>  	int i, j, type, from_plm, to_plm;
>  	bool compress = false;
> +	u64 from, to;
>  
>  	/* if sampling all branches, then nothing to filter */
>  	if (((br_sel & X86_BR_ALL) == X86_BR_ALL) &&
>  	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
>  		return;
>  
> -	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
> +	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
> +		struct perf_branch_entry *be = &cpu_lbr_stack(cpuc)->entries[i];
>  
> -		from = cpuc->lbr_entries[i].from;
> -		to = cpuc->lbr_entries[i].to;
> -		type = cpuc->lbr_entries[i].type;
> +		from = be->from;
> +		to = be->to;
> +		type = be->type;
>  
>  		/*
>  		 * Parse the branch type recorded in LBR_x_INFO MSR.
> @@ -1242,9 +1238,9 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>  			type = arch_lbr_br_type_map[type] | to_plm;
>  		} else
> -			type = branch_type(from, to, cpuc->lbr_entries[i].abort);
> +			type = branch_type(from, to, be->abort);
>  		if (type != X86_BR_NONE && (br_sel & X86_BR_ANYTX)) {
> -			if (cpuc->lbr_entries[i].in_tx)
> +			if (be->in_tx)
>  				type |= X86_BR_IN_TX;
>  			else
>  				type |= X86_BR_NO_TX;
> @@ -1258,27 +1254,27 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  		 */
>  		if (type == X86_BR_NONE || (br_sel & type) != type ||
>  		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {
> -			cpuc->lbr_entries[i].from = 0;
> +			be->from = 0;
>  			compress = true;
>  		}
>  
>  		if ((br_sel & X86_BR_TYPE_SAVE) == X86_BR_TYPE_SAVE)
> -			cpuc->lbr_entries[i].type = common_branch_type(type);
> +			be->type = common_branch_type(type);
>  	}
>  
>  	if (!compress)
>  		return;
>  
>  	/* remove all entries with from=0 */
> -	for (i = 0; i < cpuc->lbr_stack.nr; ) {
> -		if (!cpuc->lbr_entries[i].from) {
> +	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; ) {
> +		if (!cpu_lbr_stack(cpuc)->entries[i].from) {
>  			j = i;
> -			while (++j < cpuc->lbr_stack.nr) {
> -				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
> +			while (++j < cpu_lbr_stack(cpuc)->nr) {
> +				cpu_lbr_stack(cpuc)->entries[j-1] = cpu_lbr_stack(cpuc)->entries[j];
>  				cpuc->lbr_counters[j-1] = cpuc->lbr_counters[j];
>  			}
> -			cpuc->lbr_stack.nr--;
> -			if (!cpuc->lbr_entries[i].from)
> +			cpu_lbr_stack(cpuc)->nr--;
> +			if (!cpu_lbr_stack(cpuc)->entries[i].from)
>  				continue;
>  		}
>  		i++;
> @@ -1292,9 +1288,9 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
>  	/* Cannot get TOS for large PEBS and Arch LBR */
>  	if (cpu_feature_enabled(X86_FEATURE_ARCH_LBR) ||
>  	    (cpuc->n_pebs == cpuc->n_large_pebs))
> -		cpuc->lbr_stack.hw_idx = -1ULL;
> +		cpu_lbr_stack(cpuc)->hw_idx = -1ULL;
>  	else
> -		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
> +		cpu_lbr_stack(cpuc)->hw_idx = intel_pmu_lbr_tos();
>  
>  	intel_pmu_store_lbr(cpuc, lbr);
>  	intel_pmu_lbr_filter(cpuc);
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index e274802ef062..29a43a04fcd8 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -447,6 +447,8 @@ struct intel_excl_cntrs {
>  struct x86_perf_task_context;
>  #define MAX_LBR_ENTRIES		32
>  
> +#define LBR_STACK_SIZE		struct_size_t(struct perf_branch_stack, entries, MAX_LBR_ENTRIES)
> +
>  enum {
>  	LBR_FORMAT_32		= 0x00,
>  	LBR_FORMAT_LIP		= 0x01,
> @@ -524,8 +526,7 @@ struct cpu_hw_events {
>  	 */
>  	int				lbr_users;
>  	int				lbr_pebs_users;
> -	struct perf_branch_stack	lbr_stack;
> -	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
> +	u64				__lbr_stack[LBR_STACK_SIZE / sizeof(u64)];
>  	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
>  	union {
>  		struct er_account		*lbr_sel;
> @@ -587,6 +588,11 @@ struct cpu_hw_events {
>  	struct pmu			*pmu;
>  };
>  
> +static __always_inline struct perf_branch_stack *cpu_lbr_stack(struct cpu_hw_events *cpuc)
> +{
> +	return (struct perf_branch_stack *)cpuc->__lbr_stack;
> +}
> +
>  #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
>  	{ .idxmsk64 = (n) },		\
>  	.code = (c),			\
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index eb3f7bab498c..19de3f1cbd6e 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -115,7 +115,7 @@ static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
>  struct perf_branch_stack {
>  	u64				nr;
>  	u64				hw_idx;
> -	struct perf_branch_entry	entries[];
> +	struct perf_branch_entry	entries[] __counted_by(nr);
>  };
>  
>  struct task_struct;

This looks great. I would adopt this in next version. Thanks.


