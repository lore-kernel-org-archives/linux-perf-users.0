Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5598B258CC1;
	Wed, 26 Feb 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557329; cv=none; b=gmFpD/vKKajzhHg1LGT0o7s+uTDkAp7LI7t3s9WRPyNpc4mTDlg/CQp2G432Ktjcm4rBG7NYTOJqE2hAnPV0OZ+Yy99aELeFwHUQEkleP0+J/fInxgpjiX8P9gsmJv1Ij41qnmscXH9PcwQrILXECbQhOTiSG/LqxLn+IixI+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557329; c=relaxed/simple;
	bh=B/hiPmKEz5qpr2mvnHDi1IQ26fNUocCZtx+QMWwB4rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNOt+jiPfUpPm5kv0cZ9OGuQ1TX7fgsyCLBbMZYRIWBNXL41lJfo6jiMTExx+M/qhZRN9t6klYYbKSuHobZuG+PUTfE7IkdxuFjkAMDaH+VC4m1h1A6PmOvcJz/FkpsLbmw2aHH8J1V+Mzz/p0DxSVJ+UUqFHLg/9s2lWrC6now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekT/Y/m6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekT/Y/m6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740557328; x=1772093328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B/hiPmKEz5qpr2mvnHDi1IQ26fNUocCZtx+QMWwB4rI=;
  b=ekT/Y/m6Dn+EQ6CK6s8Sm7V0epWkI5WfGtAfOj9cg29jD7d9jioP3aUW
   X/zPreQJdDXR7cTMXwfOa33rupLhyYBACbzKy2J/cmQJ1O8fI6m7dGJWn
   2xjnu2WCroY/rDtGjFl6z71xP2wJ7rVypArmVumpr1Zl9xBYTvStufGiG
   qA8Hha+XLLBBWN0QZf4oXb71/8m+rI8UPptWo9G/TcUu66+SZLs6w73NX
   GBQzNJhzKX2+4Q5QW0mT6xyHNSRPdP6zUrxqxvZiXULUHTvZN7Vg+WB6f
   2NdNFKTwTo3bT2/obXP43BgsXxZXZ0m6rQIuVMh5QsNdEedgd4v8xzk4B
   A==;
X-CSE-ConnectionGUID: I1b4K35jTMy/cVoDjNh9zg==
X-CSE-MsgGUID: QOyMIkIbTA6Xh4iXvmfrIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="44216303"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="44216303"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:08:47 -0800
X-CSE-ConnectionGUID: lQd4AGeYQUy4dKroRqU2LQ==
X-CSE-MsgGUID: 2v0xwVowQA+m/4oUaSYCWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153808112"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:08:42 -0800
Message-ID: <bda04ccd-fa90-4f14-89cc-9835de36bcfb@linux.intel.com>
Date: Wed, 26 Feb 2025 16:08:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 18/24] perf/x86/intel: Support arch-PEBS vector
 registers group capturing
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-19-dapeng1.mi@linux.intel.com>
 <20250225153257.GQ11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250225153257.GQ11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/25/2025 11:32 PM, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:12PM +0000, Dapeng Mi wrote:
>> Add x86/intel specific vector register (VECR) group capturing for
>> arch-PEBS. Enable corresponding VECR group bits in
>> GPx_CFG_C/FX0_CFG_C MSRs if users configures these vector registers
>> bitmap in perf_event_attr and parse VECR group in arch-PEBS record.
>>
>> Currently vector registers capturing is only supported by PEBS based
>> sampling, PMU driver would return error if PMI based sampling tries to
>> capture these vector registers.
>
>> @@ -676,6 +709,32 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  			return -EINVAL;
>>  	}
>>  
>> +	/*
>> +	 * Architectural PEBS supports to capture more vector registers besides
>> +	 * XMM registers, like YMM, OPMASK and ZMM registers.
>> +	 */
>> +	if (unlikely(has_more_extended_regs(event))) {
>> +		u64 caps = hybrid(event->pmu, arch_pebs_cap).caps;
>> +
>> +		if (!(event->pmu->capabilities & PERF_PMU_CAP_MORE_EXT_REGS))
>> +			return -EINVAL;
>> +
>> +		if (has_opmask_regs(event) && !(caps & ARCH_PEBS_VECR_OPMASK))
>> +			return -EINVAL;
>> +
>> +		if (has_ymmh_regs(event) && !(caps & ARCH_PEBS_VECR_YMM))
>> +			return -EINVAL;
>> +
>> +		if (has_zmmh_regs(event) && !(caps & ARCH_PEBS_VECR_ZMMH))
>> +			return -EINVAL;
>> +
>> +		if (has_h16zmm_regs(event) && !(caps & ARCH_PEBS_VECR_H16ZMM))
>> +			return -EINVAL;
>> +
>> +		if (!event->attr.precise_ip)
>> +			return -EINVAL;
>> +	}
>> +
>>  	return x86_setup_perfctr(event);
>>  }
>>  
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index f21d9f283445..8ef5b9a05fcc 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2963,6 +2963,18 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
>>  			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
>>  				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
>>  
>> +			if (pebs_data_cfg & PEBS_DATACFG_YMMS)
>> +				ext |= ARCH_PEBS_VECR_YMM & cap.caps;
>> +
>> +			if (pebs_data_cfg & PEBS_DATACFG_OPMASKS)
>> +				ext |= ARCH_PEBS_VECR_OPMASK & cap.caps;
>> +
>> +			if (pebs_data_cfg & PEBS_DATACFG_ZMMHS)
>> +				ext |= ARCH_PEBS_VECR_ZMMH & cap.caps;
>> +
>> +			if (pebs_data_cfg & PEBS_DATACFG_H16ZMMS)
>> +				ext |= ARCH_PEBS_VECR_H16ZMM & cap.caps;
>> +
>>  			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
>>  				ext |= ARCH_PEBS_LBR & cap.caps;
>>  
>> @@ -5115,6 +5127,9 @@ static inline void __intel_update_pmu_caps(struct pmu *pmu)
>>  
>>  	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
>>  		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
>> +
>> +	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_EXT)
>> +		dest_pmu->capabilities |= PERF_PMU_CAP_MORE_EXT_REGS;
>>  }
> There is no technical reason for it to error out, right? We can use
> FPU/XSAVE interface to read the CPU state just fine.

I think it's not because of technical reason. Let me confirm if we can add
it for non-PEBS sampling.


>
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 4b01beee15f4..7e5a4202de37 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1437,9 +1438,37 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
>>  	if (gprs || (attr->precise_ip < 2) || tsx_weight)
>>  		pebs_data_cfg |= PEBS_DATACFG_GP;
>>  
>> -	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
>> -	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
>> -		pebs_data_cfg |= PEBS_DATACFG_XMMS;
>> +	if (sample_type & PERF_SAMPLE_REGS_INTR) {
>> +		if (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK)
>> +			pebs_data_cfg |= PEBS_DATACFG_XMMS;
>> +
>> +		for_each_set_bit_from(bit,
>> +			(unsigned long *)event->attr.sample_regs_intr_ext,
>> +			PERF_NUM_EXT_REGS) {
> This is indented wrong; please use cino=(0:0
> if you worry about indentation depth, break out in helper function.

Sure. would modify it.


>
>> +			switch (bit + PERF_REG_EXTENDED_OFFSET) {
>> +			case PERF_REG_X86_OPMASK0 ... PERF_REG_X86_OPMASK7:
>> +				pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
>> +				bit = PERF_REG_X86_YMMH0 -
>> +				      PERF_REG_EXTENDED_OFFSET - 1;
>> +				break;
>> +			case PERF_REG_X86_YMMH0 ... PERF_REG_X86_ZMMH0 - 1:
>> +				pebs_data_cfg |= PEBS_DATACFG_YMMS;
>> +				bit = PERF_REG_X86_ZMMH0 -
>> +				      PERF_REG_EXTENDED_OFFSET - 1;
>> +				break;
>> +			case PERF_REG_X86_ZMMH0 ... PERF_REG_X86_ZMM16 - 1:
>> +				pebs_data_cfg |= PEBS_DATACFG_ZMMHS;
>> +				bit = PERF_REG_X86_ZMM16 -
>> +				      PERF_REG_EXTENDED_OFFSET - 1;
>> +				break;
>> +			case PERF_REG_X86_ZMM16 ... PERF_REG_X86_ZMM_MAX - 1:
>> +				pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
>> +				bit = PERF_REG_X86_ZMM_MAX -
>> +				      PERF_REG_EXTENDED_OFFSET - 1;
>> +				break;
>> +			}
>> +		}
>> +	}
>>  
>>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
>>  		/*
