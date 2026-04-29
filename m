Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBF15539A
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777440993; cv=none; b=TY/9eFb58XlZsBWG4krbsWuAZUssfkqlWDVq+iuKJo66Af5FFNLtvQeV4hOwPhh7xHoOWTTmhCZolsMXPoPqtmTq/GkeeEKyVYGLQz/jqvzZpW3SNJJWVQrhgoiKM5EmWGU7I6hoDmU9H7R5wDNCr7LoD1/dz2Gy2BOjPhsL1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777440993; c=relaxed/simple;
	bh=SqyMeX9JV/ofwBMaurcldICAgiiO8yha7Tj3V8wI91Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPuVmRL3Tw2cxW+S1EzrsbBFzfKR8QDjCEFQEzhOFk/wfwJqoQ7yyXco9UL7t+QxzvmbgW3vfOjFVIg2HcrLHJdTybPYlnfjDIyBz63pf9Jj7RGTWyrqv/oh43MOgEeoes5PYjEdvRFXICiBpTizMKF9cdNN7G6vAuC7CShlq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nlFgFxgS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nlFgFxgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777440992; x=1808976992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SqyMeX9JV/ofwBMaurcldICAgiiO8yha7Tj3V8wI91Y=;
  b=nlFgFxgS+P2sVKsdwa4FWcfeU2Xs1WTbDPZXGram+oXmsSVBSsqHcbgm
   kBOtRK2mn45F3H0vV9vViZ1bx1EOFCnn/dRzVlvv4ODaNWCkPEWBvqXF4
   cV9sOCfoQbnHoIB4UUaBUIpfn1aiERZLrdg1UHCnf+pqsdRsBPUlAGKTx
   /SPblrU8zsioLyhT3WeN3J7RFHlXvzpPrNUlj2IGiB+JolYYmr/SqX5xG
   vTRUYNJn5WoKec3Me/8fR8maiTEiISJmYwt3/VRgy9IfJPW994NYa/Aq7
   m3XHq16gHYby6BTl4jklu6IgsfqQqVZ/yL6l1J8BKweYIkuS52t4V9kUP
   A==;
X-CSE-ConnectionGUID: FyfT9g3IQCa+d7Foi3Wp8w==
X-CSE-MsgGUID: ErfoTxJ7RdeRynWCFQZnbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="65892522"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="65892522"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 22:36:31 -0700
X-CSE-ConnectionGUID: 7I8cyHf1QCSTMIyPhZtMtg==
X-CSE-MsgGUID: YN9cSXD3SUKOKa1SruofBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="234144458"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 22:36:30 -0700
Message-ID: <9bd99db1-9761-4b15-9f6d-d7bd45723255@linux.intel.com>
Date: Wed, 29 Apr 2026 13:36:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 22/24] perf/x86/intel: Enable arch-PEBS based
 SIMD/eGPRs/SSP sampling
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260324004118.3772171-23-dapeng1.mi@linux.intel.com>
 <20260425030814.0A75EC19425@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260425030814.0A75EC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/25/2026 11:08 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [Critical] Leaking stale per-CPU FPU/extended register state to user space when a PEBS event triggers in kernel mode and requests PERF_SAMPLE_REGS_USER.
> - [High] Incorrect bitwise AND with a raw u64 bitmask in `intel_pebs_support_regs` permanently disables large PEBS for XMM registers on arch-PEBS platforms.
> --
>
> commit 7ad07fe08e2e0b394952e6f0ccf5f040f99870e3
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Enable arch-PEBS based SIMD/eGPRs/SSP sampling
>
> This patch enables arch-PEBS based SIMD/eGPRs/SSP registers sampling
> using the XSAVE-Enabled Registers (XER) group.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 3d64f28b7e9ac..b280a39f68bca 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -4416,6 +4431,34 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
>>  	return intel_pebs_aliases_precdist(event);
>>  }
>>  
>> +static inline bool intel_pebs_support_regs(struct perf_event *event, u64 regs)
>> +{
>> +	struct arch_pebs_cap cap = hybrid(event->pmu, arch_pebs_cap);
>> +	int pebs_format = x86_pmu.intel_cap.pebs_format;
>> +	bool supported = true;
>> +
>> +	/* SSP */
>> +	if (regs & PEBS_DATACFG_GP)
>> +		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_GPR & cap.caps);
>> +	if (regs & PEBS_DATACFG_XMMS) {
>> +		supported &= x86_pmu.arch_pebs ?
>> +			     ARCH_PEBS_VECR_XMM & cap.caps :
>> +			     pebs_format > 3 && x86_pmu.intel_cap.pebs_baseline;
>> +	}
> Will this permanently disable large PEBS for XMM registers?
>
> Because supported is a boolean (initially 1), ARCH_PEBS_VECR_XMM & cap.caps
> evaluates to BIT_ULL(49). The bitwise AND operation 1 &= 0x2000000000000ULL
> strictly yields 0.
>
> Should this bitmask be normalized to a boolean value, perhaps using
> !!(ARCH_PEBS_VECR_XMM & cap.caps) inside the ternary operator?

Yes, it's a bug. would fix it in next version.


>
> [ ... ]
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 560f178d7ac92..61d72c58f9a25 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
> [ ... ]
>
>> @@ -2708,15 +2719,69 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
>>  					   meminfo->tsx_tuning, ax);
>>  	}
>>  
>> -	if (header->xmm) {
>> +	if (header->xmm || header->ymmh || header->egpr ||
>> +	    header->opmask || header->zmmh || header->h16zmm) {
>> +		struct arch_pebs_xer_header *xer_header = next_record;
>>  		struct pebs_xmm *xmm;
>> +		struct ymmh_struct *ymmh;
>> +		struct avx_512_zmm_uppers_state *zmmh;
>> +		struct avx_512_hi16_state *h16zmm;
>> +		struct avx_512_opmask_state *opmask;
>> +		struct apx_state *egpr;
>>  
>>  		next_record += sizeof(struct arch_pebs_xer_header);
>>  
>> -		ignore_mask |= XFEATURE_MASK_SSE;
>> -		xmm = next_record;
>> -		perf_regs->xmm_regs = xmm->xmm;
>> -		next_record = xmm + 1;
>> +		if (header->xmm) {
>> +			ignore_mask |= XFEATURE_MASK_SSE;
>> +			xmm = next_record;
>> +			/*
>> +			 * Only output XMM regs to user space when arch-PEBS
>> +			 * really writes data into xstate area.
>> +			 */
>> +			if (xer_header->xstate & XFEATURE_MASK_SSE)
>> +				perf_regs->xmm_regs = xmm->xmm;
>> +			next_record = xmm + 1;
>> +		}
> Is it possible for this code to leak stale per-CPU FPU/extended register
> state to user space?
>
> When a PEBS event triggers in kernel mode and requests PERF_SAMPLE_REGS_USER,
> this code processes the PEBS data and sets the corresponding bits
> (e.g., XFEATURE_MASK_SSE) in ignore_mask. It then calls
> x86_pmu_setup_regs_data(), which assigns data->regs_user.regs to the
> static per-CPU x86_user_regs.
>
> If x86_user_regs is never fully cleared, its extended register pointers
> (like xmm_regs) still point to the per-CPU ext_regs_buf from prior samples.
> Because XFEATURE_MASK_SSE is excluded via ignore_mask, xsaves_nmi() and
> x86_pmu_update_xregs() skip updating x86_user_regs.xmm_regs.
>
> Consequently, the xmm_regs pointer remains pointing to the stale data in
> ext_regs_buf. When the perf core outputs the user registers, could it
> read the stale FPU state from ext_regs_buf and leak it across processes?

Yes, it's a known issue. Would be fixed in next version.

Thanks.


>
