Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793322367;
	b=KDb2h6CA0Nx3BiiWpY4AYjkYgp1FwMsUGXI94uTiEsnWTSrI53kLBKNaVLYpI8zPKERQ
	 t4YLR0lf82lm+OL9x/4sKUNBgeZ6qGJMKHWZT4TpPD2MV1MGjPvlNrcfLl93HBzYVQe9R
	 +kus3hwgwxr3uLAiYO08CKSKh/xV3jzk507H5NhaEQXYc4I7nNgPOoX9fColcTYVce8Ek
	 iVxGRPHOM2tCYiP4HqNjddWYYh0hcSWoA6hVA9C6ghtH8uxQXXkCTk1BB7KhRBXqmgkSg
	 o34sOzyoZOi1WfEj+c26lf37emDTOiKZlTuYKgmZKD92CD6KqAbiHQOb05Yj84bxpBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793322367;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WjLLvZsvJSmOAXslKS2VzMGjNZ8oozHSunMfy2WQMho=;
	b=Z82DZWs+QF4i2GVeeE5CsG/oO++iHCt91Q35+H50Umkgb69Osyl8x9zpHL9aOWv4xQaU
	 pumkv/1y9Ie5Hx50JXgSdKbxgKX1BGq3c9HkwPVr6A6HC0+TCs1kNcYUtfALfO2FntkDR
	 bIkBnB4mT/YtXhman0spYeBmaiVNkOzO5w6+l6NP6Wx+zeidVR1E5vVsxdDx8Bqd+WsPA
	 DkohPdx/GtLdzwEi69SBAN5UXetGq34qiJhzLQIeOi5YY1gKSM6X9gEMdHsmdnCneNdJH
	 Fj9XpkErtC51uDjp9d4JhSFwhDScWNjBY9DYf5xo1o+08/uGPnlKdgevi/snn6/E9sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="i6fcjN/m";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92B606A321;
	Fri, 30 Oct 2026 01:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC92B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6fcjN/m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793322367; x=1824858367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TsVZXIJYeSiAkgf1waONsW2VWPzUS6CUknNpUA3kUxo=;
  b=i6fcjN/mGHxDRE0GJxymHM8DRQp2RNBRhKlFQuTk0Z5z1G10ZuKF76Ir
   B891NsgXbNF9qVMBiMpdB2phHu+JOFI+kdl1W6HYsYBHPtQENaCI+uENK
   eNkwB0b5eZkUa/QbDgzfUlUQ24b2DjfOfi81beqaXfkyDaNiG0MeJXZmD
   Xwk9hafvCGyT5TY/QDCwDAZByWWT1ooAN+d6k/NzkXbtMUuKe3uwOjpMd
   /RwQHuSTPRgo61Au8zv6JBB8JUPXindEEPw1AkR9F2x34OaOk8ST2SdRc
   qUBN/iHx4yEFr/zS3xceSyt37pXJPQ/qNzEhcocVbJJA5cuecvGM48b06
   g==;
X-CSE-ConnectionGUID: 0FS55+/qS9GNxF4dQo9ijg==
X-CSE-MsgGUID: ZX5+loSYTDGszjZeGUpc1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1959288"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1959288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:06:06 -0700
X-CSE-ConnectionGUID: jS8f0Es1Q++CCTFH2k3MvQ==
X-CSE-MsgGUID: urQzugNAT/yIaoAkD4Uu0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5421084"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:06:01 -0700
Message-ID: <e7bb28e7-cf1a-44b3-9ce9-3e6ab228d34f@linux.intel.com>
Date: Fri, 30 Oct 2026 09:05:59 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 10/18] perf/x86/intel: Allow LBR read helpers to
 operate on explicit stacks
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-11-dapeng1.mi@linux.intel.com>
 <20261029103857.GL1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261029103857.GL1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/29/2026 6:38 PM, Peter Zijlstra wrote:
> On Thu, Oct 29, 2026 at 12:39:06PM +0800, Dapeng Mi wrote:
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index ee724b28d90c..63f0504f9d2a 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -105,7 +105,10 @@
>>  
>>  #define ARCH_LBR_CTL_MASK			0x7f000e
>>  
>> -static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
>> +static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
>> +				 struct perf_branch_stack *lbr_stack,
>> +				 struct perf_branch_entry *lbr_entries,
>> +				 u64 *lbr_counters);
>>  
>>  static __always_inline bool is_lbr_call_stack_bit_set(u64 config)
>>  {
>> @@ -741,10 +744,12 @@ void intel_pmu_lbr_disable_all(void)
>>  	}
>>  }
>>  
>> -void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>> +void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc,
>> +			   struct perf_branch_stack *lbr_stack,
>> +			   struct perf_branch_entry *lbr_entries)
>>  {
>>  	unsigned long mask = x86_pmu.lbr_nr - 1;
>> -	struct perf_branch_entry *br = cpuc->lbr_entries;
>> +	struct perf_branch_entry *br = lbr_entries;
>>  	u64 tos = intel_pmu_lbr_tos();
>>  	int i;
>>  
>> @@ -775,11 +780,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>>   * is the same as the linear address, allowing us to merge the LIP and EIP
>>   * LBR formats.
>>   */
>> -void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
>> +void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc,
>> +			   struct perf_branch_stack *lbr_stack,
>> +			   struct perf_branch_entry *lbr_entries)
>>  {
>>  	bool need_info = false, call_stack = false;
>>  	unsigned long mask = x86_pmu.lbr_nr - 1;
>> -	struct perf_branch_entry *br = cpuc->lbr_entries;
>> +	struct perf_branch_entry *br = lbr_entries;
>>  	u64 tos = intel_pmu_lbr_tos();
>>  	int i;
>>  	int out = 0;
> This makes no sense; why do you keep passing lbr_entries around when we
> have lbr_stack.entries[] ?

Yeah, that's actually what I did at the beginning. But sashiko raised the
warning below. :(

"

Does this trigger a CONFIG_UBSAN_BOUNDS panic when intel_pmu_store_lbr()
is inlined?
The lbr_stack pointer points to a struct
perf_branch_stack embedded directly in struct cpu_hw_events. Because it
is an embedded value-type struct, the compiler considers its size to be
fixed (16 bytes), treating the trailing flexible array member entries[]
as having 0 elements.
Accessing lbr_stack->entries[i] where i >= 0 can trigger strict array
bounds violations under -fstrict-flex-arrays=3 and CONFIG_UBSAN_BOUNDS.

"


