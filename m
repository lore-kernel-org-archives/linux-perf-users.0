Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D438D3EC
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304921; cv=none; b=MJbbEbR3/4fjWmtJF+fnPqnvWRFTThqD8ezcaO0tXK9sHSznSGl85g/Sje5wz/z2EOAsj3GQclNPK//ltfEK+cg8+iYtT2kiwrnI1cG1Yslh7ctn2fTC/4puwvN9/C1NfDO9erYeBQ8dVFOZp/hmGwLnFaptrqKilksKCMWFIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304921; c=relaxed/simple;
	bh=TdW5yechDMCn6D+5IR3Ax4hPX4SbKRAR7SncK2dGYzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjDqk+8m80TB7zGL5C/oJmZBGtXm0HtsILVbsx/XSfgWrSuFHhhFyydzWi1lNmlJHiq1Mt2S0pj2WsE1P9Xr25l/htAqOzKUK8khgsfxwyCUcBaixSxhTkEQf2uvFe6yfs5EdBvZSaHsuEGk/LIVejxgwNGmU0TsYpdOXFHNGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyb4MuTQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyb4MuTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780304919; x=1811840919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TdW5yechDMCn6D+5IR3Ax4hPX4SbKRAR7SncK2dGYzY=;
  b=cyb4MuTQLfhtMAM8g/671UXgfgBCQHf09FelA2LTECLrGsrHN4FhhEFM
   7pPrG7YeYSBYhKlm0XrixmyP7oX4b4oywtH0zYP5BOxzJ18ssQZyR97ik
   BoQQ+5sC27U7D6wQQeYyk+jioAurS+NY9fx4cOXY/7W2JrtQi+VmOZ7Gf
   gLdNd/q1oQBGK0FPQDb1nzfG4Op97UtZSVfVcLhGharJVp2yIRvOFX+tU
   au6CNwl9CxZAcB0nAD3cnP18eIwH5Co/MCY2/SeKN4/fZLZa+upCUNsMM
   y/+onaqkXsDLG0OKrsZ1EGu76HiC/I15YK7ViLQBd1FFuVD+Zhn1CVfPy
   g==;
X-CSE-ConnectionGUID: XJenuupMRC+rjuOTejobyQ==
X-CSE-MsgGUID: wrIRmGfJQZ2x1JcpWFwawg==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="103729984"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="103729984"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:08:38 -0700
X-CSE-ConnectionGUID: udRkzdS4SpiRQlebN6Hy6w==
X-CSE-MsgGUID: P20tDGZCRnyp7zBghfFgEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="239338036"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:08:37 -0700
Message-ID: <822ca505-9dd9-48f9-9461-75da241bde28@linux.intel.com>
Date: Mon, 1 Jun 2026 17:08:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 20/23] perf/x86/intel: Support arch-PEBS based
 SIMD/eGPRs/SSP sampling
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-21-dapeng1.mi@linux.intel.com>
 <20260529094559.5337D1F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529094559.5337D1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 5:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Requesting the SSP (Shadow Stack Pointer) register improperly allows large PEBS to be enabled on legacy PEBS hardware, resulting in stale and identical SSP values across all samples in the buffer.
> --
>
> commit 2a27d3f31fac15c7d594a6588f8dacfa2939bc9f
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Support arch-PEBS based SIMD/eGPRs/SSP sampling
>
> This commit adds support for sampling SIMD, eGPRs, and SSP registers using
> arch-PEBS. It defines the layout for these extended registers and manages
> their sampling via MSRs and the XSTATE_BV bitmap.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -4695,21 +4710,113 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
> [ ... ]
>
>> +static bool __regs_support_large_pebs(struct perf_event *event, bool intr)
>> +{
>> +	u64 regs = intr ? event->attr.sample_regs_intr :
>> +			  event->attr.sample_regs_user;
>> +	u64 vec_regs = intr ? event->attr.sample_simd_vec_reg_intr :
>> +			      event->attr.sample_simd_vec_reg_user;
>> +	u64 pred_regs = intr ? event->attr.sample_simd_pred_reg_intr :
>> +			       event->attr.sample_simd_pred_reg_user;
>> +	u64 xregs_mask = PEBS_GP_REGS | PERF_X86_EGPRS_MASK |
>> +			 BIT_ULL(PERF_REG_X86_SSP);
>> +
>> +	if (regs & ~xregs_mask)
>> +		return false;
>> +
>> +	if ((regs & (PEBS_GP_REGS | BIT_ULL(PERF_REG_X86_SSP))) &&
>> +	    !intel_pebs_support_regs(event, PEBS_DATACFG_GP))
>> +		return false;
> [Severity: High]
> Does this logic unintentionally allow large PEBS to be enabled on legacy PEBS
> hardware when the SSP register is requested?
>
> Looking at intel_pebs_support_regs(), it returns true for PEBS_DATACFG_GP
> unconditionally on legacy PEBS hardware. If a user requests SSP on legacy
> PEBS, __regs_support_large_pebs() will return true and allow large PEBS.
>
> Since legacy PEBS hardware records do not contain the SSP, the perf core
> fetches it from the thread's XSAVE buffer during the PMU interrupt via
> x86_pmu_update_perf_regs(). 
>
> Because large PEBS batches multiple samples and delays the interrupt, won't
> every sample in the batch end up with the exact same stale SSP value from
> the time of the interrupt?
>
> Should large PEBS be explicitly disabled on legacy PEBS when SSP is
> requested, perhaps similarly to how eGPRs are handled?

Yes, this is a bug, need to check if arch-PEBS is supported for SSP, like this,

```

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4546b20429ba..b37ee3e481bb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4764,7 +4764,7 @@ static bool __regs_support_large_pebs(struct
perf_event *event, bool intr)
        if (regs & ~xregs_mask)
                return false;

-       if ((regs & (PEBS_GP_REGS | BIT_ULL(PERF_REG_X86_SSP))) &&
+       if ((regs & PEBS_GP_REGS) &&
            !intel_pebs_support_regs(event, PEBS_DATACFG_GP))
                return false;

@@ -4772,6 +4772,11 @@ static bool __regs_support_large_pebs(struct
perf_event *event, bool intr)
            !intel_pebs_support_regs(event, PEBS_DATACFG_EGPRS))
                return false;

+       if ((regs & BIT_ULL(PERF_REG_X86_SSP)) &&
+           (!x86_pmu.arch_pebs ||
+            !intel_pebs_support_regs(event, PEBS_DATACFG_GP)))
+               return false;
+
        if (event_needs_opmask(event) && pred_regs &&
            !intel_pebs_support_regs(event, PEBS_DATACFG_OPMASKS))
                return false;

```


>
> [ ... ]
>
