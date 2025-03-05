Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A376C61;
	Wed,  5 Mar 2025 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138480; cv=none; b=riaHgrRZa29nONfqBkkDYwrVDR/TYUcUyIPCEQtRYkBczCPAnxzCaFqLkjEy+ZdiIx5JvsB+HDE//7Hp3tqFxms0/pjrNuyHQGRdvmkvCL69KBDncfI2AS/+ZMSdyNAO7P2Sm6C2ePz+ZDnF1oSwRQaVYq4ZfCqTsVAcLgQkB14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138480; c=relaxed/simple;
	bh=QEkYWgfOIZeAnwEbvb6x2ycUqywZv40z+RHU25+RgfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QL/vuCMZEGJLmsd0FOSIWgtZv/YDUYtfyxbr+vIKyLmaM/12kBwjfwS1PjhX2rzD68IGeB3v2tyRTbXttI3IRHOjFM9XhKAwnSZp9o95+CSaA8Se8bBmLDKxN+CSwdP59poeRSje5UBuE0f7L956dnvT6U7gMTPG81/9hUTKeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ce5bhsG6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ce5bhsG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741138479; x=1772674479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QEkYWgfOIZeAnwEbvb6x2ycUqywZv40z+RHU25+RgfA=;
  b=Ce5bhsG6RNiX7cliamL6zoio8gcOB5nAxbWAAiAQJGv2KRTUxb6lI9gi
   q0+SgmfbOGDBLokZnnCggjE7Lw2x89n8N5ZuAGBa1OcHRan+6uLopDEfi
   fzvw9T460cgdCkNtYSaRT/NjsziQujVEu8o2v9FGPMzpM0iTAIrR+nivi
   jwI/1KrXovYYdSiOPzT80/o2KNF7+quJyvUqIbaaqVsVWM6n58Tiqjch1
   W3rdm4uqjDMxzK9lshyEh4Cnhel2S4SLk26MkOqjrAh0pttZZYew/cfEi
   Ok/TdO9+ObqMgfAAvrQ7LmBdtuOEK4ZCfdHW+URqHcJ/9+S/+ZiZ1lXSy
   Q==;
X-CSE-ConnectionGUID: tCZR6oxFTHOP6TdG7YHbzw==
X-CSE-MsgGUID: wkzv9hlzTrm1rnVBT5qgZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42210781"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="42210781"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 17:34:38 -0800
X-CSE-ConnectionGUID: 00hoMbhzRTCTioddx3ts4Q==
X-CSE-MsgGUID: +Ggfx1jwS3uJGIogwBCa7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="123650516"
Received: from unknown (HELO [10.238.2.135]) ([10.238.2.135])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 17:34:35 -0800
Message-ID: <d5b0e6ab-aff0-48be-b0a3-5a04bf328ab8@linux.intel.com>
Date: Wed, 5 Mar 2025 09:34:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 18/24] perf/x86/intel: Support arch-PEBS vector
 registers group capturing
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-19-dapeng1.mi@linux.intel.com>
 <20250225153257.GQ11590@noisy.programming.kicks-ass.net>
 <bda04ccd-fa90-4f14-89cc-9835de36bcfb@linux.intel.com>
 <a62bfd22-0469-46cc-954d-8331aa2922e9@linux.intel.com>
 <71c0f66a-9ee8-4c01-8a29-2c6faf015b4d@linux.intel.com>
 <987b099a-2add-486e-a7bd-ffa5ebfc2426@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <987b099a-2add-486e-a7bd-ffa5ebfc2426@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/5/2025 12:26 AM, Liang, Kan wrote:
>
> On 2025-03-03 10:08 p.m., Mi, Dapeng wrote:
>> On 2/27/2025 2:40 PM, Mi, Dapeng wrote:
>>> On 2/26/2025 4:08 PM, Mi, Dapeng wrote:
>>>> On 2/25/2025 11:32 PM, Peter Zijlstra wrote:
>>>>> On Tue, Feb 18, 2025 at 03:28:12PM +0000, Dapeng Mi wrote:
>>>>>> Add x86/intel specific vector register (VECR) group capturing for
>>>>>> arch-PEBS. Enable corresponding VECR group bits in
>>>>>> GPx_CFG_C/FX0_CFG_C MSRs if users configures these vector registers
>>>>>> bitmap in perf_event_attr and parse VECR group in arch-PEBS record.
>>>>>>
>>>>>> Currently vector registers capturing is only supported by PEBS based
>>>>>> sampling, PMU driver would return error if PMI based sampling tries to
>>>>>> capture these vector registers.
>>>>>> @@ -676,6 +709,32 @@ int x86_pmu_hw_config(struct perf_event *event)
>>>>>>  			return -EINVAL;
>>>>>>  	}
>>>>>>  
>>>>>> +	/*
>>>>>> +	 * Architectural PEBS supports to capture more vector registers besides
>>>>>> +	 * XMM registers, like YMM, OPMASK and ZMM registers.
>>>>>> +	 */
>>>>>> +	if (unlikely(has_more_extended_regs(event))) {
>>>>>> +		u64 caps = hybrid(event->pmu, arch_pebs_cap).caps;
>>>>>> +
>>>>>> +		if (!(event->pmu->capabilities & PERF_PMU_CAP_MORE_EXT_REGS))
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		if (has_opmask_regs(event) && !(caps & ARCH_PEBS_VECR_OPMASK))
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		if (has_ymmh_regs(event) && !(caps & ARCH_PEBS_VECR_YMM))
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		if (has_zmmh_regs(event) && !(caps & ARCH_PEBS_VECR_ZMMH))
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		if (has_h16zmm_regs(event) && !(caps & ARCH_PEBS_VECR_H16ZMM))
>>>>>> +			return -EINVAL;
>>>>>> +
>>>>>> +		if (!event->attr.precise_ip)
>>>>>> +			return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>>  	return x86_setup_perfctr(event);
>>>>>>  }
>>>>>>  
>>>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>>>> index f21d9f283445..8ef5b9a05fcc 100644
>>>>>> --- a/arch/x86/events/intel/core.c
>>>>>> +++ b/arch/x86/events/intel/core.c
>>>>>> @@ -2963,6 +2963,18 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
>>>>>>  			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
>>>>>>  				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
>>>>>>  
>>>>>> +			if (pebs_data_cfg & PEBS_DATACFG_YMMS)
>>>>>> +				ext |= ARCH_PEBS_VECR_YMM & cap.caps;
>>>>>> +
>>>>>> +			if (pebs_data_cfg & PEBS_DATACFG_OPMASKS)
>>>>>> +				ext |= ARCH_PEBS_VECR_OPMASK & cap.caps;
>>>>>> +
>>>>>> +			if (pebs_data_cfg & PEBS_DATACFG_ZMMHS)
>>>>>> +				ext |= ARCH_PEBS_VECR_ZMMH & cap.caps;
>>>>>> +
>>>>>> +			if (pebs_data_cfg & PEBS_DATACFG_H16ZMMS)
>>>>>> +				ext |= ARCH_PEBS_VECR_H16ZMM & cap.caps;
>>>>>> +
>>>>>>  			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
>>>>>>  				ext |= ARCH_PEBS_LBR & cap.caps;
>>>>>>  
>>>>>> @@ -5115,6 +5127,9 @@ static inline void __intel_update_pmu_caps(struct pmu *pmu)
>>>>>>  
>>>>>>  	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
>>>>>>  		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
>>>>>> +
>>>>>> +	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_EXT)
>>>>>> +		dest_pmu->capabilities |= PERF_PMU_CAP_MORE_EXT_REGS;
>>>>>>  }
>>>>> There is no technical reason for it to error out, right? We can use
>>>>> FPU/XSAVE interface to read the CPU state just fine.
>>>> I think it's not because of technical reason. Let me confirm if we can add
>>>> it for non-PEBS sampling.
>>> Hi Peter,
>>>
>>> Just double confirm, you want only PEBS sampling supports to capture SSP
>>> and these vector registers for both *interrupt* and *user space*? or
>>> further, you want PMI based sampling can also support to capture SSP and
>>> these vector registers? Thanks.
> I think one of the main reasons to add the vector registers into PEBS
> records is because of the large PEBS. So perf can get all the interested
> registers and avoid a PMI for each sample.
> Technically, I don't think there is a problem supporting them in
> non-PEBS PMI sampling. But I'm not sure if it's useful in practice.
>
> The REGS_USER should be more useful. The large PEBS is also available as
> long as exclude_kernel.
>
> In my opinion, we may only support the new vector registers for both
> REGS_USER and REGS_INTR with PEBS events for now. We can add the support
> for non-PEBS events later if there is a requirement.

Yes, agree. I plan to support these new added registers for both REGS_USER
and REGS_INTR in v3 version. If someone has different opinion, please let
me know. Thanks.


>
> Thanks,
> Kan
>
>> Hi Peter,
>>
>> May I know your opinion on this? Thanks.
>>
>>
>>>>>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>>>>>> index 4b01beee15f4..7e5a4202de37 100644
>>>>>> --- a/arch/x86/events/intel/ds.c
>>>>>> +++ b/arch/x86/events/intel/ds.c
>>>>>> @@ -1437,9 +1438,37 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
>>>>>>  	if (gprs || (attr->precise_ip < 2) || tsx_weight)
>>>>>>  		pebs_data_cfg |= PEBS_DATACFG_GP;
>>>>>>  
>>>>>> -	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
>>>>>> -	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
>>>>>> -		pebs_data_cfg |= PEBS_DATACFG_XMMS;
>>>>>> +	if (sample_type & PERF_SAMPLE_REGS_INTR) {
>>>>>> +		if (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK)
>>>>>> +			pebs_data_cfg |= PEBS_DATACFG_XMMS;
>>>>>> +
>>>>>> +		for_each_set_bit_from(bit,
>>>>>> +			(unsigned long *)event->attr.sample_regs_intr_ext,
>>>>>> +			PERF_NUM_EXT_REGS) {
>>>>> This is indented wrong; please use cino=(0:0
>>>>> if you worry about indentation depth, break out in helper function.
>>>> Sure. would modify it.
>>>>
>>>>
>>>>>> +			switch (bit + PERF_REG_EXTENDED_OFFSET) {
>>>>>> +			case PERF_REG_X86_OPMASK0 ... PERF_REG_X86_OPMASK7:
>>>>>> +				pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
>>>>>> +				bit = PERF_REG_X86_YMMH0 -
>>>>>> +				      PERF_REG_EXTENDED_OFFSET - 1;
>>>>>> +				break;
>>>>>> +			case PERF_REG_X86_YMMH0 ... PERF_REG_X86_ZMMH0 - 1:
>>>>>> +				pebs_data_cfg |= PEBS_DATACFG_YMMS;
>>>>>> +				bit = PERF_REG_X86_ZMMH0 -
>>>>>> +				      PERF_REG_EXTENDED_OFFSET - 1;
>>>>>> +				break;
>>>>>> +			case PERF_REG_X86_ZMMH0 ... PERF_REG_X86_ZMM16 - 1:
>>>>>> +				pebs_data_cfg |= PEBS_DATACFG_ZMMHS;
>>>>>> +				bit = PERF_REG_X86_ZMM16 -
>>>>>> +				      PERF_REG_EXTENDED_OFFSET - 1;
>>>>>> +				break;
>>>>>> +			case PERF_REG_X86_ZMM16 ... PERF_REG_X86_ZMM_MAX - 1:
>>>>>> +				pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
>>>>>> +				bit = PERF_REG_X86_ZMM_MAX -
>>>>>> +				      PERF_REG_EXTENDED_OFFSET - 1;
>>>>>> +				break;
>>>>>> +			}
>>>>>> +		}
>>>>>> +	}
>>>>>>  
>>>>>>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
>>>>>>  		/*
>
