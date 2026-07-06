Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14448A2D4
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329340; cv=none; b=ZoHWjAKU+thtuuaj0xd3jsUiwgc/riEi/r0JPD4t7ix7tdZf1RAnAQOJTvn9DjhGY9FfpU8RTArEGC5hRkD5ZZfkTtKnJ4uaT6YkQScs1uzSQu8pO2kpqsZosYuDZeAEh0h6DXrap2ldJpQJzegOanMnbapiglfnqLFWeq2Ts7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329340; c=relaxed/simple;
	bh=9/X14tQGf3zNA7Ckz8fvg3U+4q83y3x0pkyRCiBj9xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpmRlmyU2WRUNABNAw5A8fpJQMadp46i5Lgpnec4KakDla7oqCZNZqetJwCYNu8Sq/9ibMgsjtwQp368bvu6H6UIIUfom1tpU1RfeVTI3rxhj4EJQdcctCUsAgL8jJbWKrRRigabeLD5OzdIs2D4+esB8JZsdeni92gy/+fnIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwIBNPxn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwIBNPxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783329334; x=1814865334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9/X14tQGf3zNA7Ckz8fvg3U+4q83y3x0pkyRCiBj9xw=;
  b=nwIBNPxnhl/g/z2oxbNLxwj+n5emxHfwO2adFU+lTPma5hvbu5oakRt/
   6bfWVtcrcL8mrrclyd4Nwba48tTNQiGJrvnAZF1wGskHP/jkIWD8j1av/
   2ZqSM1B/JcyMJ2dRVMCLukL3be3/iM8N+mlFFV7TMmKk0SVloTM3tgofC
   q+IWLhl/f3wtI9rdHngfu0LeMreAVb+VzbA7hucWaYLXTTgBPxSR51Yog
   Ch/xqOb1u4XiN3lSX1R+UTgCanmsDZUa51MfnRpJBR+cXb5f+MYrI5S1V
   6Qi+LYJFuX5LxGMx+69zuQMajxQxbNE6B0Tcz7rZkhGdPc1Vvy/5FX4fL
   A==;
X-CSE-ConnectionGUID: YdgTgcHPSOaCt7j+f8LnRA==
X-CSE-MsgGUID: qtRxd0TURwS6WHd0MGdP6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="109502009"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="109502009"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:15:29 -0700
X-CSE-ConnectionGUID: gAocSpFoQRCCoheSYcQuZA==
X-CSE-MsgGUID: oOwqtLBCSJ2ZqGdh+8JoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253776175"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:15:29 -0700
Message-ID: <242e2ce9-6f77-46ee-b2b4-fa356c1854ec@linux.intel.com>
Date: Mon, 6 Jul 2026 17:15:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 08/24] x86/fpu: Add update_fpu_state_and_flag() helper
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-9-dapeng1.mi@linux.intel.com>
 <20260706022254.214481F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706022254.214481F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 10:22 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Guest FPU state leaks to host perf samples because the NMI handler incorrectly bypasses the `__task_fpstate` check when `TIF_NEED_FPU_LOAD` is 0.
> --
>
> commit a7b6e478b8260eaf627518f9d19e511212779fab
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> x86/fpu: Add update_fpu_state_and_flag() helper
>
> This commit introduces the update_fpu_state_and_flag() helper to save user
> FPU state and set TIF_NEED_FPU_LOAD. It also adds memory barriers in the
> host/guest FPU state switch path to ensure fpu->__task_fpstate is observed
> correctly when non-NULL.
>
> Link: https://lore.kernel.org/all/20251204154721.GB2619703@noisy.programming.kicks-ass.net/
>
>> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
>> index 584fb9913be42..fb78e0ecd5fa8 100644
>> --- a/arch/x86/kernel/fpu/core.c
>> +++ b/arch/x86/kernel/fpu/core.c
> [ ... ]
>> @@ -383,13 +396,15 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
>>  
>>  	/* Swap fpstate */
>>  	if (enter_guest) {
>> -		fpu->__task_fpstate = cur_fps;
>> +		WRITE_ONCE(fpu->__task_fpstate, cur_fps);
>> +		barrier();
>>  		fpu->fpstate = guest_fps;
>>  		guest_fps->in_use = true;
>>  	} else {
>>  		guest_fps->in_use = false;
>>  		fpu->fpstate = fpu->__task_fpstate;
>> -		fpu->__task_fpstate = NULL;
>> +		barrier();
>> +		WRITE_ONCE(fpu->__task_fpstate, NULL);
> [Severity: High]
> Can guest FPU state leak into host perf samples during this window?
>
> The commit message mentions that subsequent patches will use this guarantee
> in NMI context by checking TIF_NEED_FPU_LOAD before retrieving user FPU
> state from the saved task FPU state.
>
> However, during KVM guest execution and within the VM-exit path here,
> TIF_NEED_FPU_LOAD is 0 because it was cleared on guest entry and is not set
> by KVM.
>
> If an NMI hits here before restore_fpregs_from_fpstate() restores the host
> state, would the NMI handler bypass the fpu->__task_fpstate check because
> TIF_NEED_FPU_LOAD is 0?
>
> arch/x86/events/core.c:x86_pmu_update_user_xregs() {
> 	...
> 	if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {
> 		perf_regs = container_of(data->regs_user.regs,
> 				 struct x86_perf_regs, regs);
> 		fpu = x86_task_fpu(current);
> 		/*
> 		 * If __task_fpstate is set, it holds the right pointer,
> 		 * otherwise fpstate will.
> 		 */
> 		fps = READ_ONCE(fpu->__task_fpstate);
> 	...
> }
>
> If this memory check is skipped, wouldn't the NMI handler fall back to
> reading directly from the hardware registers, which still contain the guest
> FPU state at this point in fpu_swap_kvm_fpstate()?

Yes, this is intended. Currently host perf has been granted the right to
sample the guest except exclude_guest attribute is set.

Thanks.


>
>>  	}
>>  
>>  	cur_fps = fpu->fpstate;
