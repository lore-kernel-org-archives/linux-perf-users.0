Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2612F8EA5
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418354; cv=none; b=onXEB/gNAYO1JvkoHz4oCepLLkhner+IXsI3008VxNkMDBheMXb0wa9jcx8NjbkMLcmEoVDUfE6KczayK4rM1Ky2rPTgBfht0kmF5bVbNq0QDfGkCqDD70wbMTvT2RSQGbF7WRZbLIspbYKGvfDLfdr8Vx7xxCitQv8BYkpuYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418354; c=relaxed/simple;
	bh=nQWFq7rH1aVwuZIqn10ouaFoCWt1uuSJ+C/eKMmqlQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ud8NMGd9nYrviea4dbscplBSTo+FqDkI7UJiXaMxLQLFXvmFZg50T8JDBVNeSnx7piDE+vY1fDv3ajAqdH66ft7PbvQx789FV5hgG2yVFURg/+g4bzzvKVlSc5WwDE6qL+T0mNZgnJME8enoI5pGXnXFtV/SGx3lROJPNzjCejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnk5TeWh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnk5TeWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783418353; x=1814954353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nQWFq7rH1aVwuZIqn10ouaFoCWt1uuSJ+C/eKMmqlQA=;
  b=jnk5TeWhbIpwF9YZYF5S3dsc/JByVZGmw8ajxW4zys0twzGmrjyBqA/V
   sS8cVRzTlTXpd9rEEZPEYw5IZQtFFOgBQ9Pu5XRdEa51uq7LpEc3J+Q5K
   IvM/oH2DiLvhJ7ElmjpeEO5+51jClFQ7XB5sfvohataBxeaznaDnacCvb
   LGCbOz4fw5/N4E20G2RGanC9TBwqU20J9yUJwqf0kVC87Lh8vvLHTZijZ
   FXxAZF70mUeFWV+BzhYYQKkw5wia+zgXde9Q4sRsOkv30bR/JMH1gJmjG
   miOhRuQ2vAZhuvvoCbb7O/LyZITAGMOQCoNrXz2J/smqR7moRU7A/Hhpr
   A==;
X-CSE-ConnectionGUID: sXG99+z4QG+ze3as78C0/w==
X-CSE-MsgGUID: mCJAL8NJTLK6CpSIVA9K+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83833750"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83833750"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:59:12 -0700
X-CSE-ConnectionGUID: uReAeWIdQ66+0MB1gC3Oww==
X-CSE-MsgGUID: acuDIdmrTKacQIVxv0Qolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258860816"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 02:59:10 -0700
Message-ID: <4ec47e8a-83e5-4884-a863-94f4352c9e70@linux.intel.com>
Date: Tue, 7 Jul 2026 17:59:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 12/24] perf/x86: Enable XMM register sampling for
 REGS_USER case
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-13-dapeng1.mi@linux.intel.com>
 <20260706023550.939A71F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706023550.939A71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/6/2026 10:35 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] For PEBS events, a delayed PMI NMI hitting in kernel mode causes REGS_INTR to overwrite REGS_USER's XMM registers with the current hardware FPU state, leaking kernel FPU data.
> - [High] PERF_SAMPLE_REGS_USER incorrectly samples Guest XMM registers paired with Host GPRs when a PMI hits during KVM guest execution, leaking guest state to the host.
> --
>
> commit 74494b0320a832fddee80ea2906067a8bc2b32e0
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Enable XMM register sampling for REGS_USER case
>
> This commit introduces support for XMM register sampling in the REGS_USER
> case. It adds a per-CPU x86_user_regs to store REGS_USER-specific XMM
> registers and a helper x86_pmu_update_user_xregs() to retrieve them either
> from cached task FPU state or hardware registers.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 3e52610510cdc..0d42c51761f9d 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>
>> @@ -1812,33 +1806,165 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
> [ ... ]
>
>> +static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *data,
>> +					    struct pt_regs *regs,
>> +					    u64 mask, u64 ignore_mask)
>> +{
>> +	struct x86_perf_regs *perf_regs;
>> +	struct xregs_state *xsave;
>> +	unsigned int guest_state;
>> +	struct fpu *fpu;
>> +	struct fpstate *fps;
>> +	u64 user_mask = mask;
>> +
>> +	if (data->regs_user.abi == PERF_SAMPLE_REGS_ABI_NONE)
>> +		return 0;
>> +
>> +	/*
>> +	 * If PEBS hits kernel space, need to re-sample extended
>> +	 * registers for user space.
>> +	 */
>> +	if (user_mode(regs))
>> +		user_mask &= ~ignore_mask;
>> +
>> +	if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {
> [Severity: High]
> Can this incorrectly sample Guest XMM registers paired with Host GPRs when
> a PMI hits during KVM guest execution?
>
> Since TIF_NEED_FPU_LOAD is cleared when KVM actively runs a guest, this
> condition evaluates to false, bypassing the fpu->__task_fpstate memory
> load.
>
> If the guest is running in user mode, perf_guest_state() & PERF_GUEST_USER
> will be true, causing this function to return user_mask. Consequently,
> xsaves_nmi() will sample the live hardware FPU containing the guest's
> registers instead of QEMU's.

Hmm, it's true. Since currently guest fpu are lazily swapped, as long as
PMI hits the guest, the FPU hardware would always contain the guest FPU
states. It looks we need to do below change and ensure the FPU state of
user space can be always retrieved when PMI hits guest.

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 323be08778d6..b78d4f261b76 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1978,7 +1978,8 @@ static inline u64 x86_pmu_update_user_xregs(struct
perf_sample_data *data,
        if (user_mode(regs))
                user_mask &= ~ignore_mask;

-       if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {
+       if (user_mask &&
+           (test_thread_flag(TIF_NEED_FPU_LOAD) || perf_guest_state())) {
                perf_regs = container_of(data->regs_user.regs,
                                 struct x86_perf_regs, regs);
                fpu = x86_task_fpu(current);
@@ -1995,15 +1996,6 @@ static inline u64 x86_pmu_update_user_xregs(struct
perf_sample_data *data,
                return 0;
        }

-       guest_state = perf_guest_state();
-       /*
-        * Skip SIMD register sampling if a PMI hits while guest kernel
-        * state is still active.
-        */
-       if (user_mask && (guest_state & PERF_GUEST_ACTIVE) &&
-           !(guest_state & PERF_GUEST_USER))
-               return 0;
-


>
>> +		perf_regs = container_of(data->regs_user.regs,
>> +				 struct x86_perf_regs, regs);
>> +		fpu = x86_task_fpu(current);
>> +		/*
>> +		 * If __task_fpstate is set, it holds the right pointer,
>> +		 * otherwise fpstate will.
>> +		 */
>> +		fps = READ_ONCE(fpu->__task_fpstate);
> [ ... ]
>
>>  static void x86_pmu_sample_xregs(struct perf_event *event,
>>  				 struct perf_sample_data *data,
>> +				 struct pt_regs *regs,
>>  				 u64 ignore_mask)
>>  {
> [ ... ]
>
>> +	if (user_mask) {
>> +		perf_regs = container_of(data->regs_user.regs,
>> +					 struct x86_perf_regs, regs);
>> +		update_perf_regs(perf_regs, xsave, user_mask);
>> +	}
>> +
>>  	if (intr_mask) {
>>  		perf_regs = container_of(data->regs_intr.regs,
>>  					 struct x86_perf_regs, regs);
>> -		xsave->header.xfeatures = 0;
>> -		xsaves_nmi(xsave, mask);
>>  		update_perf_regs(perf_regs, xsave, intr_mask);
> [Severity: High]
> For PEBS events, if a delayed PMI NMI hits in kernel mode, can REGS_INTR
> overwrite REGS_USER's XMM registers and leak kernel FPU data?
>
> If a PEBS event requests both PERF_SAMPLE_REGS_USER and
> PERF_SAMPLE_REGS_INTR, and a PEBS record is generated in user space but
> the PMI is delivered while the CPU is in kernel mode (after the kernel has
> set TIF_NEED_FPU_LOAD):
>
> x86_pmu_update_regs_user() sets:
>     data->regs_user.regs = regs;
>     
> x86_pmu_update_regs_intr() sets:
>     data->regs_intr.regs = regs;
>     
> Both now share the same x86_perf_regs container. In x86_pmu_sample_xregs(),
> the container is first updated with the user's FPU state, but then it is
> unconditionally overwritten with the kernel's live FPU state from
> xsaves_nmi() here because intr_mask is non-zero.

Yeah, the risk is always possible. To mitigate the risk, we may need to use
an independent x86_perf_regs at any time, like this,

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 323be08778d6..9f8f436e6518 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1912,10 +1912,7 @@ static void x86_pmu_update_regs_user(struct
perf_event *event,
        struct perf_event_attr *attr = &event->attr;
        struct x86_perf_regs *perf_regs;

-       if (user_mode(regs)) {
-               data->regs_user.abi = perf_reg_abi(current);
-               data->regs_user.regs = regs;
-       } else if (is_user_task(current)) {
+       if (user_mode(regs)) || is_user_task(current)) {
                /*
                 * It cannot guarantee that the kernel will never
                 * touch the registers outside of the pt_regs,


>
>>  	}
>>  }
