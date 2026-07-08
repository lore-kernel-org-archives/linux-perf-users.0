Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454851F03DE
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476237; cv=none; b=FJMyKNdoJn5zZEJILKgdWM1Tc52+DB87LkpxzI2OJfZIGB9pLg4Z+G7eqY6DVxb44m0iNvncOUb/y3YgbUrmCSQ8kcF63cZrOoRBevxkbCa1grXnN81JQBN/fuTKj8r5+3SrUhLg81hthArcZNaiii7mbl+OjhUwEQlVCI+mCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476237; c=relaxed/simple;
	bh=s1F7iiYl+e2ehnWxft0m6Lu/ICgDcRvObJfE8gLOZdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgRE71o5q/M/DXhoD/yujZM8TH+KRjSxiss8qarvl/XgKgzLtGoROhY9pNrzQA5oCp2bpP6j1xkrMKi1h8hLQ5685WUdLacU0pq5T6qBxLngiXXbSfYo2fR9aERdQjobamgPMZgTwHrXa51Oo5TFVJjYPRuGRwMmV/UkAXOnwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFeHaGXa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFeHaGXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476236; x=1815012236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s1F7iiYl+e2ehnWxft0m6Lu/ICgDcRvObJfE8gLOZdU=;
  b=NFeHaGXaeubVz2t8gRVzFGC70GGn954zZJmtPqdd7AG+3s7iLNqaBaas
   dhY5GoxtyIImTSdYUVXqqiJId7lbPc7QRIAi0tgvUjJk1IMsPccnE4jjl
   L5UuMqpmJoWNWPo1Wni3MXrP5RY+UEe3R/d917VRrQIhwiYZYoqa8pcAx
   UP4bAG9WrBltcsKCay2jJ9Ez52CGgNA0Mscc/m1Vx9AKNq7RZX2WtrsDt
   UYSrd3rc37LRHrRybLBYgoWZ1cW4MmiFEZDnCkH5LK26zhC+V1i9TMOZG
   p9KuehBYJW97060IOU9kiFjxBmfkgiAhF6LAk0Fm/UsuUG8jOMhqiG2Mq
   A==;
X-CSE-ConnectionGUID: f7NBib+8SK+fc8A6e1Dccg==
X-CSE-MsgGUID: poHnQ3V0QbaG4QWaP0MJsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84191081"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84191081"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:03:56 -0700
X-CSE-ConnectionGUID: GLzOYxxHShSW3VAoTlOkwg==
X-CSE-MsgGUID: UUK2CVpZQf626xPl8O3VSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277361012"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:03:55 -0700
Message-ID: <516cf877-6d6f-4cc8-b4bf-fe8e616e8a47@linux.intel.com>
Date: Wed, 8 Jul 2026 10:03:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 24/24] perf/x86/intel: Add sanity check for PEBS
 fragment size
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-25-dapeng1.mi@linux.intel.com>
 <20260706050412.999B31F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706050412.999B31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 1:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Events without preceding valid records in a corrupted PEBS buffer are permanently stalled.
> --
>
> commit e2dd3df4b73a7bfac8a1332ea38906750253ef38
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Add sanity check for PEBS fragment size
>
> This patch adds a sanity check for corrupted PEBS fragment sizes to prevent
> potential infinite loops. If a corrupted fragment is detected, the entire
> PEBS record and all subsequent records are dropped to ensure data integrity.
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index b38aed4f62b4c..7a8e619055393 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
> [ ... ]
>
>> @@ -3244,7 +3261,8 @@ static __always_inline void
>>  __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
>>  				    struct pt_regs *regs,
>>  				    struct perf_sample_data *data,
>> -				    u64 mask, short *counts, void **last,
>> +				    u64 mask, short *counts,
>> +				    void **last, bool corrupted,
>>  				    setup_fn setup_sample)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> @@ -3258,7 +3276,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
>>  		event = cpuc->events[bit];
>>  
>>  		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
>> -					    counts[bit], setup_sample);
>> +					    counts[bit], corrupted, setup_sample);
>>  	}
>>  
>>  }
> [Severity: High]
> This is a pre-existing issue, but does this logic permanently stall PMU
> profiling for events without preceding valid records in a corrupted buffer?
>
> In arch/x86/events/intel/ds.c:__intel_pmu_handle_last_pebs_record(), we skip
> processing if the count is zero:
>
> 	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
> 		if (!counts[bit])
> 			continue;
> 		...
>
> If a corrupted PEBS record is detected (e.g., via the newly added at >= top
> bounds checks) and the code exits the drain loop early, events that had no
> valid records parsed prior to the corruption will have a count of zero.
>
> Because these events are skipped here, __intel_pmu_pebs_last_event() is never
> called, preventing intel_pmu_save_and_restart() from re-arming their hardware
> counters. Furthermore, since handle_pmi_common() explicitly masks PEBS events
> out of the global status, the generic NMI handler will also ignore them.
>
> Could this lead to the hardware counters remaining disabled, stopping
> profiling until the session is recreated?

The issue won't really happen on real hardware. Fixing it would introduce
large complexity and seems unworthy ...


>
