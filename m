Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA73DF016
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370389; cv=none; b=dlJAYAy5M/Ja0JC/IGWdPBho4B4tjjb5/mAE3cM1wwETJpFUNFu416HcK0lbJuI8v14oV7U75cql5JmS44G5gkxnkoMYjy515QjDImIr07pPoWrof+s0KktPcvbfM4TwqRZyrECe4s4CZJKbeux2YAXTMzLQZlaLGmBt28YDlXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370389; c=relaxed/simple;
	bh=uUV177gRglXRyRHCd/6nQL11RRiWwxP5fb4GkOvd+8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGorLWPqbY15DLmg5Zj0Jh6d2qGPwTaIBwvCHJ7bAfovwFrX63o3+5nMcEUq94bnkrLVFPV8/Uclby0UqnyoIjjPhpJRvUPFYvdkD35kSKrPxv5bh1pUtm1h41Hq8zk66V+utZewonOVVtjIKVo+9Dwn1g2bPbXZVTER4xOwPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REwxk/wW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REwxk/wW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777370382; x=1808906382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uUV177gRglXRyRHCd/6nQL11RRiWwxP5fb4GkOvd+8Y=;
  b=REwxk/wWXI+oRU8qyLmeEW7FCyaJj4dsSlfaDHgynpD3Dcu6kfPH/FXW
   vTL5c9dwX+O3s85CnPh4P5K2U9ilRmw1IdVO7vDjgplIMAXuLrr9shjpk
   ld4MWWfHy3II5fFF6bszq/q5OSLsIDoDfKL4DxxWEQiWhl432gYZdf557
   6FZwF8U9dMLBPnzx4UoWSaQ/la+EinBqfWwLd6065UwPwpxFuVk4AKl6M
   OgT34YyqNAO72BZCBH61ILaJvsmAHFPbjeMgfMIWldt/pJ3+bpjYxunKA
   ll6DI2rYqRdizZR7h1D6RXuG9mVnBoAGacQohxa7Ka3BciwULgiZkh7dM
   A==;
X-CSE-ConnectionGUID: PPFDyfNjR5qor76/wEoiGA==
X-CSE-MsgGUID: Vjk+voBhSrW+uKsmY+OLfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77304527"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77304527"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:59:37 -0700
X-CSE-ConnectionGUID: H1iDpdgiSk6h4DXYwInLmQ==
X-CSE-MsgGUID: 9hBRFRqTSm6i9fo1KVYdTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238940328"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:59:37 -0700
Message-ID: <ccc276e5-660c-476a-89dc-864c99e762d0@linux.intel.com>
Date: Tue, 28 Apr 2026 17:59:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 4/4] perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C
 tracking
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260427085513.3728672-5-dapeng1.mi@linux.intel.com>
 <20260427121230.C7567C19425@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260427121230.C7567C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/27/2026 8:12 PM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] intel_pmu_config_acr() clobbers upper Architectural PEBS configuration bits in cfg_c_val and the PERF_CFG_C MSR.
> --
>
> commit 5ded8e15814c1efc4e7b5c766abdd782de4d360c
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C tracking
>
> This commit consolidates the tracking of the PERF_CFG_C MSR into a single
> variable, cfg_c_val, to maintain a unified view of the MSR state for both
> Auto Counter Reload (ACR) and Architectural PEBS configurations.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>> @@ -3169,10 +3169,10 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
>>  		wrmsrl(msr_b + msr_offset, mask);
>>  		cpuc->acr_cfg_b[idx] = mask;
>>  	}
>> -	/* Only need to update the reload value when there is a valid config value. */
>> -	if (mask && cpuc->acr_cfg_c[idx] != reload) {
>> +	/* Only update CFG_C reload when ACR is actively enabled (mask != 0) */
>> +	if (mask && ((cpuc->cfg_c_val[idx] & ARCH_PEBS_RELOAD) != reload)) {
>>  		wrmsrl(msr_c + msr_offset, reload);
>> -		cpuc->acr_cfg_c[idx] = reload;
>> +		cpuc->cfg_c_val[idx] = reload;
>>  	}
>>  }
> Can this assignment wipe out the upper Architectural PEBS configuration bits?
>
> Since reload is passed as a u32 and cfg_c_val is a 64-bit value, assigning 
> reload directly zero-extends the value. This will clear the upper 32 bits, 
> unintentionally removing any existing Architectural PEBS configurations 
> like ARCH_PEBS_EN from the software cache, and writing zeroes to the 
> upper bits of the physical MSR.
>
> Although intel_pmu_enable_event_ext() recalculates the full MSR state shortly
> after and detects the mismatch, resulting in a second wrmsrq() to restore the
> missing PEBS bits, this causes an inefficient double MSR write and seems to 
> defeat the goal of maintaining a consistent MSR view.
>
> Would it be better to use a read-modify-write pattern here instead? 
> For example:
>
> cpuc->cfg_c_val[idx] = (cpuc->cfg_c_val[idx] & ~ARCH_PEBS_RELOAD) | reload;

No, it's intended.  The aim is to avoid introducing any coupling between
ACR and arch-PEBS. We hope the cfg_c_val[] caches the real value of HW MSR
at any time and we don't want to write an mixture of ACR reload and 
arch-PEBS configuration into CFG_C MSR. We can't prove the mixture would be
always correct. Thanks.


>
