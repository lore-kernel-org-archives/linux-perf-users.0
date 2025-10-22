Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D92E9EAA;
	Wed, 22 Oct 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111166; cv=none; b=oPKo56+yfvhTSMlFq4r8bE0n4r++awwYfTgkdMs59OHM1Q9jCbic0dBKoO78caiuwBTHFvE64k4GV9UTUejh/4Z+ROil59UOVDQ8bQuDlWlvsThJUae4R3o1XNMncAH+bv8fEg77s2n2PEUrb/N4o/kSOb18BaHJ+a6ndiIP0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111166; c=relaxed/simple;
	bh=8zSEiF36ipnnOp5Cl4mjwp2hGY2pohj//TJmI3JvvNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUFOpsbH15qY/9rHIiKmnW5+x9FxDfIZBm4hBKmbCgmb8s7z5+cQHuizBk9W5A0oWgdlYhsZxO1UWImC6wtc9VkLaPHUlQxOPKMTmPCxOTMNzKFKfJtQQOuHd8jzwJgQM7cQng2VMgTEcsWPDQI/8GgkpJg+fs03oKk+HgJuwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ga1MtAOY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ga1MtAOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761111165; x=1792647165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8zSEiF36ipnnOp5Cl4mjwp2hGY2pohj//TJmI3JvvNM=;
  b=Ga1MtAOYeCL/9epI9xWzXG4pDak035IFKkn3EQgNKpXcyv/NAqwlSBI/
   00+4flagT5Uc7PrArHrwhMmz/zEwEKOR1hk+tZHVqwef91bdADeV+UBFB
   R8I2NcAXszfstD0NKOpIhh2sTE6EnvjfUMdFj05kF1IIFxqcxikvd5ln/
   D7npgbc/ICVV9+sGb6TeTbU7IQxs9gGCfkM0RCFlIadT7oCe2T7GXYAYk
   ZeI+esT1YsdMP23YNyzIh5ci/Fla339MRvcqZ/JYI7YjWzENB89ZZDV0o
   W38Vtj5nEzETyHKI42GwbESMwDK+I9RoloJtiBmWgvMhfEs5OMpETbKNK
   Q==;
X-CSE-ConnectionGUID: J5McSP8CRzixBtyuBphIRA==
X-CSE-MsgGUID: RUYs++9qQ0uDT8yP6tftAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65865062"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="65865062"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:32:44 -0700
X-CSE-ConnectionGUID: uor9ZTk5RDCnlN9/zYMa6w==
X-CSE-MsgGUID: t6m8ZgC3RryEIq4AloOdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="182945794"
Received: from unknown (HELO [10.238.3.234]) ([10.238.3.234])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:32:41 -0700
Message-ID: <da62c4ed-ce15-45cc-94f6-3689b8f46d14@linux.intel.com>
Date: Wed, 22 Oct 2025 13:32:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 06/12] perf/x86/intel/ds: Factor out PEBS record
 processing code to functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-7-dapeng1.mi@linux.intel.com>
 <20251021154930.GS3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251021154930.GS3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/21/2025 11:49 PM, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 02:44:16PM +0800, Dapeng Mi wrote:
>
>> +static inline void __intel_pmu_handle_pebs_record(struct pt_regs *iregs,
>> +						  struct pt_regs *regs,
>> +						  struct perf_sample_data *data,
>> +						  void *at, u64 pebs_status,
>> +						  struct perf_event *events[],
>> +						  short *counts, void **last,
>> +						  setup_fn setup_sample)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct perf_event *event;
>> +	int bit;
>> +
>> +	for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
>> +		event = cpuc->events[bit];
>> +
>> +		if (WARN_ON_ONCE(!event) ||
>> +		    WARN_ON_ONCE(!event->attr.precise_ip))
>> +			continue;
>> +
>> +		if (counts[bit]++)
>> +			__intel_pmu_pebs_event(event, iregs, regs, data,
>> +					       last[bit], setup_sample);
> No brackets, while coding style requires.

Sure. Not sure why checkpatch.pl doesn't found it. Thanks.


>
>> +
>> +		last[bit] = at;
>> +		/*
>> +		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
>> +		 * could trigger interrupt throttle and clear all event pointers of
>> +		 * the group in cpuc->events[] to NULL. So snapshot the event[] before
>> +		 * it could be cleared. This avoids the possible NULL event pointer
>> +		 * access and PEBS record loss.
>> +		 */
>> +		if (counts[bit] && !events[bit])
>> +			events[bit] = cpuc->events[bit];
>> +	}
>> +}
>
>> @@ -2671,41 +2728,15 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>>  		if (basic->format_size != cpuc->pebs_record_size)
>>  			continue;
>>  
>> -		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
>> -		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
>> -			event = cpuc->events[bit];
>> -
>> -			if (WARN_ON_ONCE(!event) ||
>> -			    WARN_ON_ONCE(!event->attr.precise_ip))
>> -				continue;
>> -
>> -			if (counts[bit]++) {
>> -				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
>> -						       setup_pebs_adaptive_sample_data);
>> -			}
> Brackets. Which suggests you took effort to remove them, since cut-paste
> code movement would've preserved them.
>
> I've re-instated them.
>
>> -			last[bit] = at;
>> -
>> -			/*
>> -			 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
>> -			 * could trigger interrupt throttle and clear all event pointers of
>> -			 * the group in cpuc->events[] to NULL. So snapshot the event[] before
>> -			 * it could be cleared. This avoids the possible NULL event pointer
>> -			 * access and PEBS record loss.
>> -			 */
>> -			if (counts[bit] && !events[bit])
>> -				events[bit] = cpuc->events[bit];
>> -		}
>> +		pebs_status = mask & basic->applicable_counters;
>> +		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
>> +					       pebs_status, events, counts, last,
>> +					       setup_pebs_adaptive_sample_data);
