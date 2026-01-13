Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0679482EB;
	Tue, 13 Jan 2026 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768267337; cv=none; b=L8SKNnMWPRJ8oyYqMKOUXCtmYtRJq0sNFrqHROj+w1IxqMt45ZSBmdw/x3AQaX9dsV9ystnwiDUG4flVo3TSorFUa48vi3J3ItUkGfEySNn9us5GZYtDTOSSkHHpc4om0EIka7hLxMYcaFvMIcJJqKMasj/5rsEH1Dmx/Ls5emo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768267337; c=relaxed/simple;
	bh=25liLf/wjWK5g6pPgXxZBzPS3ulsQkyRaAWl+SWjIIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YWbVmygHjlm+6QQ631Afpjq9ivFF8nMFuwkVVXZDZDJ4wtWYnorYY2aSB9drEcpK0QC6b/ndRYO1PuBd9jMpRO2KSgfQuAnrklOaPSZNepe/31G+OsH4D226MeQL6hpi8X6+NBHWZIcAWPCaY3G08OVEN1nNU9/B6Fv/R4GHDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUqLRw69; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUqLRw69"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768267336; x=1799803336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=25liLf/wjWK5g6pPgXxZBzPS3ulsQkyRaAWl+SWjIIk=;
  b=hUqLRw69NwzbkWa68JvvWmB3ZlOg2gHnUMYveSFvFy+Xpf5SAv86L513
   xbmYmr5fVy2LoG3os+0rLpSLsoMMeG9N3JHRx5XWSwRr6l7GdgVTElHIG
   vEHqy0giu5Sa3GpJzHC6Mmh8oL3o2RtBj2LsAgu0QAq67dEs+9TpvSZIs
   Kj8Ug48+7PsvyJ8paoq1bbmIUdsbsF+XyTk475SOaA3IixeKbfTuyhKjT
   3PIgKCtSBcjzpbPA/2MrrinkFDJxAJrRnBXIAjJZQWl5VHkt2ABdK0e8x
   HpI/UjnXc3LYF3PcnPMaiBYGhBw9hw8untCTZT3EaG72uVOtQ07LjuVsZ
   Q==;
X-CSE-ConnectionGUID: EbYydIhzQ/CRq+UnjGJtow==
X-CSE-MsgGUID: 5YFIrk4ySGyw4VQQEBkZcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="95025909"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="95025909"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 17:22:15 -0800
X-CSE-ConnectionGUID: 7BblMkUKQVKktPrcTE3RDA==
X-CSE-MsgGUID: 5chDozIURI+E5JosD6pcYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204054009"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 17:22:12 -0800
Message-ID: <f6c436e4-0d42-45d3-a183-749d9662993b@linux.intel.com>
Date: Tue, 13 Jan 2026 09:22:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/7] perf/x86/intel: Support the 4 new OMR MSRs
 introduced in DMR and NVL
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-2-dapeng1.mi@linux.intel.com>
 <20260112102710.GE830755@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260112102710.GE830755@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/12/2026 6:27 PM, Peter Zijlstra wrote:
> On Mon, Jan 12, 2026 at 01:16:43PM +0800, Dapeng Mi wrote:
>
>> ISE link: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html
> Does intel guarantee this link is stable? If not, it is not appropriate
> to stick in a changelog that will live 'forever'.

Maybe not. I suppose it's good enough to put the ISE link into cover
letter. I would remove the ISE link from the commit messages.


>
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 1840ca1918d1..6ea3260f6422 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3532,17 +3532,28 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
>>  	struct extra_reg *extra_regs = hybrid(cpuc->pmu, extra_regs);
>>  	int alt_idx = idx;
>>  
>> -	if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
>> -		return idx;
>> -
>> -	if (idx == EXTRA_REG_RSP_0)
>> -		alt_idx = EXTRA_REG_RSP_1;
>> -
>> -	if (idx == EXTRA_REG_RSP_1)
>> -		alt_idx = EXTRA_REG_RSP_0;
>> +	if (idx == EXTRA_REG_RSP_0 || idx == EXTRA_REG_RSP_1) {
>> +		if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
>> +			return idx;
>> +		if (++alt_idx > EXTRA_REG_RSP_1)
>> +			alt_idx = EXTRA_REG_RSP_0;
>> +		if (config & ~extra_regs[alt_idx].valid_mask)
>> +			return idx;
>> +	}
>>  
>> -	if (config & ~extra_regs[alt_idx].valid_mask)
>> -		return idx;
>> +	if (idx >= EXTRA_REG_OMR_0 && idx <= EXTRA_REG_OMR_3) {
>> +		if (!(x86_pmu.flags & PMU_FL_HAS_OMR))
>> +			return idx;
>> +		if (++alt_idx > EXTRA_REG_OMR_3)
>> +			alt_idx = EXTRA_REG_OMR_0;
>> +		/*
>> +		 * Subtracting EXTRA_REG_OMR_0 ensures to get correct
>> +		 * OMR extra_reg entries which start from 0.
>> +		 */
>> +		if (config &
>> +		    ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
>> +			return idx;
>> +	}
>>  
>>  	return alt_idx;
>>  }
>> @@ -3550,16 +3561,24 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
>>  static void intel_fixup_er(struct perf_event *event, int idx)
>>  {
>>  	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
>> -	event->hw.extra_reg.idx = idx;
>> +	int er_idx;
>>  
>> -	if (idx == EXTRA_REG_RSP_0) {
>> -		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
>> -		event->hw.config |= extra_regs[EXTRA_REG_RSP_0].event;
>> -		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0;
>> -	} else if (idx == EXTRA_REG_RSP_1) {
>> +	event->hw.extra_reg.idx = idx;
>> +	switch (idx) {
>> +	case EXTRA_REG_RSP_0 ... EXTRA_REG_RSP_1:
>> +		er_idx = idx - EXTRA_REG_RSP_0;
>>  		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
>> -		event->hw.config |= extra_regs[EXTRA_REG_RSP_1].event;
>> -		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_1;
>> +		event->hw.config |= extra_regs[er_idx].event;
>> +		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0 + er_idx;
>> +		break;
>> +	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
>> +		er_idx = idx - EXTRA_REG_OMR_0;
>> +		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_UMASK;
>> +		event->hw.config |= 1ULL << (8 + er_idx);
>> +		event->hw.extra_reg.reg = MSR_OMR_0 + er_idx;
>> +		break;
>> +	default:
>> +		pr_warn("The extra reg idx %d is not supported.\n", idx);
>>  	}
>>  }
> I found it jarring to have these two functions so dissimilar; I've
> changed both to be a switch statement.
>
> ---
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3532,16 +3532,17 @@ static int intel_alt_er(struct cpu_hw_ev
>  	struct extra_reg *extra_regs = hybrid(cpuc->pmu, extra_regs);
>  	int alt_idx = idx;
>  
> -	if (idx == EXTRA_REG_RSP_0 || idx == EXTRA_REG_RSP_1) {
> +	switch (idx) {
> +	case EXTRA_REG_RSP_0 ... EXTRA_REG_RSP_1:
>  		if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
>  			return idx;
>  		if (++alt_idx > EXTRA_REG_RSP_1)
>  			alt_idx = EXTRA_REG_RSP_0;
>  		if (config & ~extra_regs[alt_idx].valid_mask)
>  			return idx;
> -	}
> +		break;
>  
> -	if (idx >= EXTRA_REG_OMR_0 && idx <= EXTRA_REG_OMR_3) {
> +	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
>  		if (!(x86_pmu.flags & PMU_FL_HAS_OMR))
>  			return idx;
>  		if (++alt_idx > EXTRA_REG_OMR_3)
> @@ -3550,9 +3551,12 @@ static int intel_alt_er(struct cpu_hw_ev
>  		 * Subtracting EXTRA_REG_OMR_0 ensures to get correct
>  		 * OMR extra_reg entries which start from 0.
>  		 */
> -		if (config &
> -		    ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
> +		if (config & ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
>  			return idx;
> +		break;
> +
> +	default:
> +		break;
>  	}
>  
>  	return alt_idx;
> @@ -3571,12 +3575,14 @@ static void intel_fixup_er(struct perf_e
>  		event->hw.config |= extra_regs[er_idx].event;
>  		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0 + er_idx;
>  		break;
> +
>  	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
>  		er_idx = idx - EXTRA_REG_OMR_0;
>  		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_UMASK;
>  		event->hw.config |= 1ULL << (8 + er_idx);
>  		event->hw.extra_reg.reg = MSR_OMR_0 + er_idx;
>  		break;
> +
>  	default:
>  		pr_warn("The extra reg idx %d is not supported.\n", idx);
>  	}

Yeah, this looks prettier. Would change it.


