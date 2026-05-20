Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C32798F8;
	Wed, 20 May 2026 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239420; cv=none; b=LJIEMNKDFfdsl1Xaaj1YBVwwF7yoxfCn8AK2EXj7QPkmMmdGK4Ef9jGPHQu/6xGKFOH673qXs+mNt9ASwRkNRQ7SdGLbH7hzDLOl4sY5kkE1NIj4Zr+VP+G8A2K1WOVRcoLSovZT7cx9goeIshRaHM6gJCxED7e6MyE6eal9DCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239420; c=relaxed/simple;
	bh=XloCQ5Nm/BNV1DIsDcF0/8jsi20gfhdLIcS4dt431gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZJqd8jVYLcx+noAbfNm3kSU3azw3wH7UfHa8zS73mMTvhksb1s8zW3aw8MblZXn25ACpSVBmU8K5RJ4zB9z0NpiXDdc/aFMjG5CeN7gpFys6ked0ARThXjfotgM0SM6IXu6rS+knrw9XZYgxPVBqKAX1Nx1/cD1FmzpMohjcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThAkldPT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThAkldPT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779239419; x=1810775419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XloCQ5Nm/BNV1DIsDcF0/8jsi20gfhdLIcS4dt431gY=;
  b=ThAkldPTj4/tkOuk23h8yjIFgJ+OjbBTWlimKePApjiU6OKXc/brJw4S
   4atXJLbGmu5LPCTXHx/CkZvgcwMCnm1+ocXEQDruNnrZ9ZNITtLiH42TL
   5V4IGNApOQ89R3UKFJv+ZAEMsTYasG8/lbEGR2kvTJ97IbOCjleV/GULy
   1SWSe/npATfNPg6B8t2agKU62lUvUCSKoBrVhONNQko4vtbOK37vQeXkD
   I+6hy+s8nLm0HKJ5IRBtXNHh3wrawLnYrEcAJT1K4z5gk+CceQ8N1Vkc4
   WqjvA8P1b0beFWNiltVIsGLekhfPsLFp5Ukh5isduyPbviFQ1ogalt5Uq
   Q==;
X-CSE-ConnectionGUID: fNIAwAweQJCc/Oi2ahQhPw==
X-CSE-MsgGUID: Qsj3UIEPRDatFspSe4VBHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="105589423"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="105589423"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 18:10:18 -0700
X-CSE-ConnectionGUID: NT6JcOHARZiZA6GkT79Vqw==
X-CSE-MsgGUID: ljmjfM3VTCS66nxXi25aow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244937779"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 18:10:13 -0700
Message-ID: <4425022a-b23a-4424-97fc-caead3a626e2@linux.intel.com>
Date: Wed, 20 May 2026 09:10:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for ICX
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
 <20260515061143.338553-2-dapeng1.mi@linux.intel.com>
 <895bfd3c-c8fc-423b-abd1-42553b74706c@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <895bfd3c-c8fc-423b-abd1-42553b74706c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/20/2026 6:19 AM, Chen, Zide wrote:
>
> On 5/15/2026 11:11 PM, Dapeng Mi wrote:
>> Update perf hard-coded event constraints and cache_extra_regs[] for
>> Icelake server according to the latest ICX perfmon events (v1.30).
> Nit: Ice Lake>

Sure. Thanks.


>> Since the value of cache extra registers differs with previous
>> generations, introduce new snc_hw_cache_extra_regs[] to represent the
>> value of extra registers on ICX.
>>
>> ICX perfmon events:
>> https://github.com/intel/perfmon/blob/main/ICX/events/icelakex_core.json
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
> Reviewed-by: zide.chen@intel.com
>
>>  arch/x86/events/intel/core.c | 48 ++++++++++++++++++++++++++++++++----
>>  1 file changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 793335c3ce78..1390d1da985b 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -310,10 +310,11 @@ static struct extra_reg intel_skl_extra_regs[] __read_mostly = {
>>  static struct event_constraint intel_icl_event_constraints[] = {
>>  	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
>>  	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* old INST_RETIRED.PREC_DIST */
>> -	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
>> +	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* pseudo INST_RETIRED.ANY */
>>  	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
>> -	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
>> -	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
>> +	FIXED_EVENT_CONSTRAINT(0x0200, 1),	/* pseudo CPU_CLK_UNHALTED.THREAD */
>> +	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* pseudo CPU_CLK_UNHALTED.REF_TSC */
>> +	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* pseudo TOPDOWN.SLOTS */
>>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
>>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
>>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
>> @@ -1019,6 +1020,41 @@ static __initconst const u64 skl_hw_cache_extra_regs
>>   },
>>  };
>>  
>> +static __initconst const u64 snc_hw_cache_extra_regs
>> +				[PERF_COUNT_HW_CACHE_MAX]
>> +				[PERF_COUNT_HW_CACHE_OP_MAX]
>> +				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
>> +{
>> + [ C(LL  ) ] = {
>> +	[ C(OP_READ) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
>> +		[ C(RESULT_MISS)   ] = 0x3FBFC00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
>> +	},
>> +	[ C(OP_WRITE) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x3F3FFC0002,	/* OCR.DEMAND_RFO.ANY_RESPONSE */
>> +		[ C(RESULT_MISS)   ] = 0x3F3FC00002,	/* OCR.DEMAND_RFO.L3_MISS */
>> +	},
>> +	[ C(OP_PREFETCH) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x0,
>> +		[ C(RESULT_MISS)   ] = 0x0,
>> +	},
>> + },
>> + [ C(NODE) ] = {
>> +	[ C(OP_READ) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x104000001,	/* OCR.DEMAND_DATA_RD.LOCAL_DRAM */
>> +		[ C(RESULT_MISS)   ] = 0x730000001,	/* OCR.DEMAND_DATA_RD.REMOTE_DRAM */
>> +	},
>> +	[ C(OP_WRITE) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x104000002,	/* OCR.DEMAND_RFO.LOCAL_DRAM */
>> +		[ C(RESULT_MISS)   ] = 0x730000002,	/* OCR.DEMAND_RFO.REMOTE_DRAM */
>> +	},
>> +	[ C(OP_PREFETCH) ] = {
>> +		[ C(RESULT_ACCESS) ] = 0x0,
>> +		[ C(RESULT_MISS)   ] = 0x0,
>> +	},
>> + },
>> +};
>> +
>>  #define SNB_DMND_DATA_RD	(1ULL << 0)
>>  #define SNB_DMND_RFO		(1ULL << 1)
>>  #define SNB_DMND_IFETCH		(1ULL << 2)
>> @@ -8119,17 +8155,19 @@ __init int intel_pmu_init(void)
>>  
>>  	case INTEL_ICELAKE_X:
>>  	case INTEL_ICELAKE_D:
>> +		memcpy(hw_cache_extra_regs, snc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
>>  		x86_pmu.pebs_ept = 1;
>>  		pmem = true;
>> -		fallthrough;
>> +		goto snc_common;
>>  	case INTEL_ICELAKE_L:
>>  	case INTEL_ICELAKE:
>>  	case INTEL_TIGERLAKE_L:
>>  	case INTEL_TIGERLAKE:
>>  	case INTEL_ROCKETLAKE:
>> +		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
>> +	snc_common:
>>  		x86_pmu.late_ack = true;
>>  		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
>> -		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
>>  		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
>>  		intel_pmu_lbr_init_skl();
>>  
