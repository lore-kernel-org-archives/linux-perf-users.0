Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065633263E
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777440356; cv=none; b=ojN3WFjGiz8BZ0cE0iVrFm41cZDPG7xLPQFgzOCrWmlSG+Fv2ljoAQejYoPd6vac9R8INH2p94EQaR4B7LVSHccGWHR0YELMTYVy5Yx4sLYsbw8HdR3ZEYy7/Y1NPA+LxVmznCsml2piVqzXdQRxVM5F6HZC7h5fDKoRhKQkvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777440356; c=relaxed/simple;
	bh=1o0JwCg3VlQuXtNmwiWKwyGa2eX851s/FY4QRp8UnUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCgGtN6pTsCPxoIFZh8sL72cjcBEQiylxeBhS+7SHzspEdF+/YFyQusqIKG73FXNr1qE4Meftol9RTyoF7CDeHOQQvDfxWkWTSBfUuUMS9obtq2j0oDhD3ROYzrZaFDmyPFgRnEzBexVpKImAIqqmNzNoRiRZ2anLc6dZn3/xVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cm1j3Wi7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cm1j3Wi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777440353; x=1808976353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1o0JwCg3VlQuXtNmwiWKwyGa2eX851s/FY4QRp8UnUo=;
  b=cm1j3Wi7ya71OojgYjmfuer51/BucceSoVgnNawwRIQPrOzmdcxfGB2X
   eP4UlBgquTxo38Oi85/cIUlKtsyh4AqD4RzrMpJQUtRWDYWtPvuWUkCqU
   +wos+QcyNLXfl6AwnBw4vrr15/oacKUVmj7tb2ktghppUd1TrX3Xx5/xD
   7PUeHPDWbZ215iOzaM8rXnojFsAA4J6w+4q1sjeVEdUZUTiPx+lP+ShWJ
   R9hJJMvsdFpUvNznMmnTyx5S5FyHbL1nxwxRmwW5NN/bXrUFjCJ6C5peq
   XKeOTEqSygFoGOSu5EBOl2S4JVFElUu1TBagQcg70Qyz2swlcroxBVqcw
   w==;
X-CSE-ConnectionGUID: Qok02G05SY+lCF+NqYwIUA==
X-CSE-MsgGUID: QK10zla7Tcm3SHEYIF/NmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78239290"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78239290"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 22:25:52 -0700
X-CSE-ConnectionGUID: WdT/NmQqQke5Vrj2T2ClxQ==
X-CSE-MsgGUID: dbNWl7TuTpi9QI3+CoFn0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="229566202"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 22:25:52 -0700
Message-ID: <50ba62b0-8c43-43d9-940c-ca4ac3f40fbe@linux.intel.com>
Date: Wed, 29 Apr 2026 13:25:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 21/24] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
 capability
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260324004118.3772171-22-dapeng1.mi@linux.intel.com>
 <20260425020129.77518C19425@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260425020129.77518C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/25/2026 10:01 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] When sample_simd_regs_enabled is true, large PEBS incorrectly remains enabled if unsupported legacy standard registers (such as segment registers) are requested.
> --
>
> commit add2d25bc2536ced31489740914a43c7ed8e02eb
> Author: Kan Liang <kan.liang@linux.intel.com>
>
> perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
>
> This commit enables the PERF_PMU_CAP_SIMD_REGS capability when XSAVES
> support is available. It also temporarily disables large PEBS sampling
> for these new registers until arch-PEBS sampling support is added.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4424,11 +4424,33 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
>>  		flags &= ~PERF_SAMPLE_TIME;
>>  	if (!event->attr.exclude_kernel)
>>  		flags &= ~PERF_SAMPLE_REGS_USER;
>> -	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
>> -		flags &= ~PERF_SAMPLE_REGS_USER;
>> -	if (event->attr.sample_regs_intr &
>> -	    ~(PEBS_GP_REGS | PERF_REG_EXTENDED_MASK))
>> -		flags &= ~PERF_SAMPLE_REGS_INTR;
>> +	if (event->attr.sample_simd_regs_enabled) {
>> +		u64 nolarge = PERF_X86_EGPRS_MASK | BIT_ULL(PERF_REG_X86_SSP);
>> +
>> +		/*
>> +		 * PEBS HW can only collect the XMM0-XMM15 for now.
>> +		 * Disable large PEBS for other vector registers, predicate
>> +		 * registers, eGPRs, and SSP.
>> +		 */
>> +		if (event->attr.sample_regs_user & nolarge ||
>> +		    fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE ||
>> +		    event->attr.sample_simd_pred_reg_user)
>> +			flags &= ~PERF_SAMPLE_REGS_USER;
>> +
>> +		if (event->attr.sample_regs_intr & nolarge ||
>> +		    fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE ||
>> +		    event->attr.sample_simd_pred_reg_intr)
>> +			flags &= ~PERF_SAMPLE_REGS_INTR;
> When sample_simd_regs_enabled is true, nolarge is used to disable large PEBS
> if eGPRs or SSP are requested. However, it looks like the pre-existing
> ~PEBS_GP_REGS check was dropped in this branch.
>
> If unsupported legacy registers like segment registers (e.g. PERF_REG_X86_CS)
> are requested alongside SIMD sampling, will this bypass the check and
> incorrectly leave PERF_SAMPLE_REGS_USER or PERF_SAMPLE_REGS_INTR enabled?
>
> Since PEBS hardware batches samples and does not natively capture segment
> registers, wouldn't the delayed PMI overflow populate these missing segment
> registers using the interrupt context?
>
> Could this result in stale or delayed segment register values being provided
> for the entire batch instead of precise per-sample values?

That's right. We needs to check the bitmask of all supported registers
including eGPRs when sample_simd_regs_enabled is set. 

Besides, I would swap this patch with the next patch, then we don't need to
introduce the code and then delete them.

Thanks.


>
