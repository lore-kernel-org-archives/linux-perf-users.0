Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058603D5227;
	Mon, 19 Oct 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399653; cv=none; b=EaCzZKTIObn17a2hyCMckBQrsVDZ4m8T0lZqz8Mj2KWjTwius1o7OcAKHlUgAR/Wm0FSWuvnpCYRtuABMooligU1cMHFxRo+i2hDKiecPTCXvA0wtrXYUhfzBTzR2HjXl5xJAsAhTnoNvxaEXFXf0TZ2szYjrEewOWVgr33zgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399653; c=relaxed/simple;
	bh=EBXnRKOOKywWEX6wwW3cXCJJXY0cru77eaJLRFZkSWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9nSUniqOWiPy1+2CWl8EyZY38FvPOHJznu0BlJ9P43RJq01Nbckqg6yQqXt/wADx/GVoq4vb8LQsZyO1TfabijS3gqeZ7NEJ2m7easYThoBbXJHOd8RZA2eNxNZPpx7yBj3H1pJ2rHAMGqZ6EWob4Eb3EopQ3Ev5zYI0ZnoB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KG+JJkxF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KG+JJkxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792399652; x=1823935652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EBXnRKOOKywWEX6wwW3cXCJJXY0cru77eaJLRFZkSWw=;
  b=KG+JJkxF287CzqBKsOOIeWGRJ96j5UhGWLQYe7ukgBNtlTsVcR/WhAOP
   fUkw9M7Xf/D2whw/bL1unUZmTaJH7eG3TszEynPuN7zYwwIaI0ZitZvF8
   uGeZQ75atrSuBaHKALrBXJ2x5rURxqtYHMeInRjHmzYZDnGXEAAvAr4ER
   XFtKKuMZxvKnQnes5wvbOCstR4nmg7h+47YkuOyA4z1URei/xH4cYGkVt
   v9v+aAjjRoPge4HbdZ4R93ZTh1e6GUzGXdXWjfxM1UuY2EhDBY+L3GjkB
   18h6c3J+eqvDrHmHjgu7krnGuaOXo88vWdS0+9RzIn6jK7zuQJopK6w1C
   g==;
X-CSE-ConnectionGUID: 2mFIpBPkRh+7+Og9PJngFA==
X-CSE-MsgGUID: 19j7liXiQtKEmRj94aRfkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="975783"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="975783"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:47:32 -0700
X-CSE-ConnectionGUID: mOc5mlooQd6oknFuSxs4wA==
X-CSE-MsgGUID: YZRRxk/XRzeozGgoHk45sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4263383"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:47:31 -0700
Message-ID: <b3308c42-e0f0-4377-b75f-5b4d318f14fb@linux.intel.com>
Date: Mon, 19 Oct 2026 16:47:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/4] perf/x86/intel/lbr: Reset the cached LBR stack in
 intel_pmu_lbr_reset()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
 <20261019070836.2972403-4-dapeng1.mi@linux.intel.com>
 <sashiko-outbox-176747@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <sashiko-outbox-176747@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/19/2026 3:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf/x86/intel/lbr: stale lbr_stack.nr in intel_pmu_arch_lbr_read_xsave()
> --
>
> commit 93eb502f5c2972255761d542db115fed920f52bd
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel/lbr: Reset the cached LBR stack in intel_pmu_lbr_reset()
>
> This commit resets cpuc->lbr_stack.nr in intel_pmu_lbr_reset() and skips
> calling intel_pmu_store_lbr() in intel_pmu_arch_lbr_read_xsave() when
> XFEATURE_MASK_LBR is not set in xsave->header.xfeatures.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 0b446d8912e4e..249db12e927ed 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -193,6 +193,8 @@ void intel_pmu_lbr_reset(void)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>> +	cpuc->lbr_stack.nr = 0;
>> +
>>  	if (!x86_pmu.lbr_nr)
>>  		return;
>>  
>> @@ -1012,7 +1014,8 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
>>  	}
>>  	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
>>  
>> -	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>> +	if (xsave->header.xfeatures & XFEATURE_MASK_LBR)
>> +		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>>  }
>>  
>>  void intel_pmu_lbr_read(void)
> [Severity: High]
> When xsaves() sees the hardware LBR state in its INIT configuration, the
> XSAVE init optimization clears XFEATURE_MASK_LBR in
> xsave->header.xfeatures without writing to xsave->lbr.entries.
>
> If intel_pmu_store_lbr() is skipped here without resetting
> cpuc->lbr_stack.nr = 0, can cpuc->lbr_stack.nr and cpuc->lbr_entries[]
> retain stale branch entries whenever the hardware LBR state enters the
> INIT configuration without going through intel_pmu_lbr_reset()?
>
> For example, during a context switch in LBR call-stack mode,
> __intel_pmu_lbr_restore() restores the incoming task's LBR state without
> calling intel_pmu_lbr_reset():
>
> arch/x86/events/intel/lbr.c:__intel_pmu_lbr_restore() {
> 	if (!has_lbr_callstack_users(ctx) ||
> 	    task_context_opt(ctx)->lbr_stack_state == LBR_NONE) {
> 		intel_pmu_lbr_reset();
> 		return;
> 	}
> 	...
> 	x86_pmu.lbr_restore(ctx);
>
> 	task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
> }
>
> If the previous task populated cpuc->lbr_stack.nr > 0 and the incoming
> task had 0 branches when scheduled out (so xrstors() restores the hardware
> LBR state to the INIT state), a PMI or branch snapshot in the new task
> before new branches are recorded will see !(xsave->header.xfeatures &
> XFEATURE_MASK_LBR) and leave the previous task's cpuc->lbr_stack.nr and
> cpuc->lbr_entries[] in place.
>
> The same situation can also occur within a single task when:
> - RET instructions in call-stack mode pop all hardware LBR entries back to
>   the INIT state after an earlier PMI populated cpuc->lbr_stack.nr,
> - a deep C-state resets the hardware Arch LBR registers to the INIT state
>   (x86_pmu.lbr_deep_c_reset) without calling intel_pmu_lbr_reset(), or
> - intel_pmu_store_pebs_lbrs() populates cpuc->lbr_stack.nr from a PEBS
>   record while the hardware LBR registers are in the INIT state.
>
> In addition to leaking or repeating stale branch entries,
> intel_pmu_lbr_read() then runs intel_pmu_lbr_filter(cpuc) a second time on
> the stale cpuc->lbr_entries[], where e->type already holds a converted
> PERF_BR_* value rather than a raw ARCH_LBR_BR_TYPE_* value, indexing
> arch_lbr_br_type_map[] with the wrong value.
>
> Should intel_pmu_arch_lbr_read_xsave() clear cpuc->lbr_stack.nr = 0 when
> !(xsave->header.xfeatures & XFEATURE_MASK_LBR)?
>
> 	if (xsave->header.xfeatures & XFEATURE_MASK_LBR)
> 		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
> 	else
> 		cpuc->lbr_stack.nr = 0;

Good catch. Would follow the suggestion. Thanks.


>
