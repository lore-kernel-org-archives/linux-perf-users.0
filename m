Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228C3A63FB
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783472172; cv=none; b=R0Uaq8aOGsarteaH5v1ga2fl2a5/2LfoDIw/PaJn4CdlxVrp6ARZXEDaa/8LT0Ttmv79gePpRlKRn+2DFVBi0y8DULUnC6F5fkQUQiDF+QxSLArr3vld1qm7K30TzLFn3mj2L9pnSWwzSVv7Zus7ZveY4wX1FeG8Li7dZKrZP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783472172; c=relaxed/simple;
	bh=I1B+f+RAmPI9Tinl2GT3c5RP/bwgdeooDu0jpzAAeZM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D5AobzLmoif3VaZEZHD+Xt9dv2d/DlZY++Od8Wj7R9g42FW3Gc6soxnWbtg2G8bOdDz9WKg0q5gdu+YKgWcazhkAJZFmj2ii7iX/Ynr1iIcE6SHC0wkfo4Cp79jr3o0KLYowCfAEJ8ynxeUlYzR/60fdHeLbBvPGpv2bR3vcLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuGztYs1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuGztYs1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783472170; x=1815008170;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=I1B+f+RAmPI9Tinl2GT3c5RP/bwgdeooDu0jpzAAeZM=;
  b=NuGztYs15aYSKxuwX9gI6JmJn4M2fZ+ewW0fuIaEuSrBl3gygihe3BRI
   QezHsFp8EHUn89ikFb9HWESQAaUTfiF9IZfvSZolfhljjITIEYRE4vZ87
   GwjyyYX6pCJfWAEqO1vhpSC8kH/1cb0lY0ns0dZZfNkmFhn/VEdfPCf4E
   TXR6xeRQpS1VW63C1ky4qGjTUqmkGUtHDD8+5HpSg0EYI/jEquMGtSUK/
   zAkYiVeW2Vpf7tbIRmOTVZQZipGYoGEMb8mB2yvj6Yb8mL7mCGZzuZCJm
   n6j/eW93TzMZ8SbBMA0VIo5zTJBaqBKkRKM48fvAyPPZFRWn+p5IfwxMt
   g==;
X-CSE-ConnectionGUID: hiR9d6AWQPyWlrqTjgE53A==
X-CSE-MsgGUID: 2V8bdVD7Q3akY4Nv1yqW9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84004690"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84004690"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 17:56:09 -0700
X-CSE-ConnectionGUID: tbaGs7oIT0W5rkNLbWmjlQ==
X-CSE-MsgGUID: NlXhesNTS6etp9RDszA4Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250157111"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 17:56:08 -0700
Message-ID: <7b272283-94cd-47fb-8449-a768825b907f@linux.intel.com>
Date: Wed, 8 Jul 2026 08:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 12/24] perf/x86: Enable XMM register sampling for
 REGS_USER case
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-13-dapeng1.mi@linux.intel.com>
 <20260706023550.939A71F000E9@smtp.kernel.org>
 <4ec47e8a-83e5-4884-a863-94f4352c9e70@linux.intel.com>
Content-Language: en-US
In-Reply-To: <4ec47e8a-83e5-4884-a863-94f4352c9e70@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/7/2026 5:59 PM, Mi, Dapeng wrote:
> On 7/6/2026 10:35 AM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] For PEBS events, a delayed PMI NMI hitting in kernel mode causes REGS_INTR to overwrite REGS_USER's XMM registers with the current hardware FPU state, leaking kernel FPU data.
>> - [High] PERF_SAMPLE_REGS_USER incorrectly samples Guest XMM registers paired with Host GPRs when a PMI hits during KVM guest execution, leaking guest state to the host.
>> --
>>
>> commit 74494b0320a832fddee80ea2906067a8bc2b32e0
>> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> perf/x86: Enable XMM register sampling for REGS_USER case
>>
>> This commit introduces support for XMM register sampling in the REGS_USER
>> case. It adds a per-CPU x86_user_regs to store REGS_USER-specific XMM
>> registers and a helper x86_pmu_update_user_xregs() to retrieve them either
>> from cached task FPU state or hardware registers.
>>
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index 3e52610510cdc..0d42c51761f9d 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>> [ ... ]
>>
>>> @@ -1812,33 +1806,165 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
>> [ ... ]
>>
>>> +static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *data,
>>> +					    struct pt_regs *regs,
>>> +					    u64 mask, u64 ignore_mask)
>>> +{
>>> +	struct x86_perf_regs *perf_regs;
>>> +	struct xregs_state *xsave;
>>> +	unsigned int guest_state;
>>> +	struct fpu *fpu;
>>> +	struct fpstate *fps;
>>> +	u64 user_mask = mask;
>>> +
>>> +	if (data->regs_user.abi == PERF_SAMPLE_REGS_ABI_NONE)
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * If PEBS hits kernel space, need to re-sample extended
>>> +	 * registers for user space.
>>> +	 */
>>> +	if (user_mode(regs))
>>> +		user_mask &= ~ignore_mask;
>>> +
>>> +	if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {
>> [Severity: High]
>> Can this incorrectly sample Guest XMM registers paired with Host GPRs when
>> a PMI hits during KVM guest execution?
>>
>> Since TIF_NEED_FPU_LOAD is cleared when KVM actively runs a guest, this
>> condition evaluates to false, bypassing the fpu->__task_fpstate memory
>> load.
>>
>> If the guest is running in user mode, perf_guest_state() & PERF_GUEST_USER
>> will be true, causing this function to return user_mask. Consequently,
>> xsaves_nmi() will sample the live hardware FPU containing the guest's
>> registers instead of QEMU's.
> Hmm, it's true. Since currently guest fpu are lazily swapped, as long as
> PMI hits the guest, the FPU hardware would always contain the guest FPU
> states. It looks we need to do below change and ensure the FPU state of
> user space can be always retrieved when PMI hits guest.
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 323be08778d6..b78d4f261b76 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1978,7 +1978,8 @@ static inline u64 x86_pmu_update_user_xregs(struct
> perf_sample_data *data,
>         if (user_mode(regs))
>                 user_mask &= ~ignore_mask;
>
> -       if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +       if (user_mask &&
> +           (test_thread_flag(TIF_NEED_FPU_LOAD) || perf_guest_state())) {
>                 perf_regs = container_of(data->regs_user.regs,
>                                  struct x86_perf_regs, regs);
>                 fpu = x86_task_fpu(current);
> @@ -1995,15 +1996,6 @@ static inline u64 x86_pmu_update_user_xregs(struct
> perf_sample_data *data,
>                 return 0;
>         }
>
> -       guest_state = perf_guest_state();
> -       /*
> -        * Skip SIMD register sampling if a PMI hits while guest kernel
> -        * state is still active.
> -        */
> -       if (user_mask && (guest_state & PERF_GUEST_ACTIVE) &&
> -           !(guest_state & PERF_GUEST_USER))
> -               return 0;
> -
>
>
>>> +		perf_regs = container_of(data->regs_user.regs,
>>> +				 struct x86_perf_regs, regs);
>>> +		fpu = x86_task_fpu(current);
>>> +		/*
>>> +		 * If __task_fpstate is set, it holds the right pointer,
>>> +		 * otherwise fpstate will.
>>> +		 */
>>> +		fps = READ_ONCE(fpu->__task_fpstate);
>> [ ... ]
>>
>>>  static void x86_pmu_sample_xregs(struct perf_event *event,
>>>  				 struct perf_sample_data *data,
>>> +				 struct pt_regs *regs,
>>>  				 u64 ignore_mask)
>>>  {
>> [ ... ]
>>
>>> +	if (user_mask) {
>>> +		perf_regs = container_of(data->regs_user.regs,
>>> +					 struct x86_perf_regs, regs);
>>> +		update_perf_regs(perf_regs, xsave, user_mask);
>>> +	}
>>> +
>>>  	if (intr_mask) {
>>>  		perf_regs = container_of(data->regs_intr.regs,
>>>  					 struct x86_perf_regs, regs);
>>> -		xsave->header.xfeatures = 0;
>>> -		xsaves_nmi(xsave, mask);
>>>  		update_perf_regs(perf_regs, xsave, intr_mask);
>> [Severity: High]
>> For PEBS events, if a delayed PMI NMI hits in kernel mode, can REGS_INTR
>> overwrite REGS_USER's XMM registers and leak kernel FPU data?
>>
>> If a PEBS event requests both PERF_SAMPLE_REGS_USER and
>> PERF_SAMPLE_REGS_INTR, and a PEBS record is generated in user space but
>> the PMI is delivered while the CPU is in kernel mode (after the kernel has
>> set TIF_NEED_FPU_LOAD):
>>
>> x86_pmu_update_regs_user() sets:
>>     data->regs_user.regs = regs;
>>     
>> x86_pmu_update_regs_intr() sets:
>>     data->regs_intr.regs = regs;
>>     
>> Both now share the same x86_perf_regs container. In x86_pmu_sample_xregs(),
>> the container is first updated with the user's FPU state, but then it is
>> unconditionally overwritten with the kernel's live FPU state from
>> xsaves_nmi() here because intr_mask is non-zero.
> Yeah, the risk is always possible. To mitigate the risk, we may need to use
> an independent x86_perf_regs at any time, like this,
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 323be08778d6..9f8f436e6518 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1912,10 +1912,7 @@ static void x86_pmu_update_regs_user(struct
> perf_event *event,
>         struct perf_event_attr *attr = &event->attr;
>         struct x86_perf_regs *perf_regs;
>
> -       if (user_mode(regs)) {
> -               data->regs_user.abi = perf_reg_abi(current);
> -               data->regs_user.regs = regs;
> -       } else if (is_user_task(current)) {
> +       if (user_mode(regs)) || is_user_task(current)) {
>                 /*
>                  * It cannot guarantee that the kernel will never
>                  * touch the registers outside of the pt_regs,

Correct this change. If user_mode(regs) is true, then regs can be directly
assigned to x86_regs_user->regs instead of getting it from user task.

@@ -1910,11 +1908,13 @@ static void x86_pmu_update_regs_user(struct
perf_event *event,
                                     struct pt_regs *regs)
 {
        struct perf_event_attr *attr = &event->attr;
-       struct x86_perf_regs *perf_regs;
+       struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);

        if (user_mode(regs)) {
+               x86_pmu_clear_perf_regs(&x86_regs_user->regs);
+               x86_regs_user->regs = *regs;
+               data->regs_user.regs = &x86_regs_user->regs;
                data->regs_user.abi = perf_reg_abi(current);
-               data->regs_user.regs = regs;
        } else if (is_user_task(current)) {
                /*
                 * It cannot guarantee that the kernel will never


>
>
>>>  	}
>>>  }
