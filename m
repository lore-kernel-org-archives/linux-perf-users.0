Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929B1F9ABF;
	Tue, 17 Dec 2024 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469204; cv=none; b=QIzWwvCk/vWi+alm8VwuVfryS0ZWPjcgVsdjLEIpL3gtxmxqU0dQIVo+2Rw3xpIEvz6I4QlofE42iE3vSD+zry6x9RW+c3mKzyRY17LUWhk52a3sjPaVDGyhDnzOuqb8c/gJ6sy8RI6bBHndID7+oh6BfBYmag/H+FeV7luuspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469204; c=relaxed/simple;
	bh=zKNEFVGOxuGdzP+F9oyV1PntBC5pgGexL0iNLZB7VXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eANnN+ep1U1j1MZVQp8FYTQ3kL8rNjZATe6+TZD+E8vww3jGIbmt64swJ2142L29UHWtJyGlVkU6yZCthfRKNb9WjSD8QoldpO+mVLQ2UAPOUxaEPu71bfqMmo6YWMfeY6h0KaVHNEoLd1H6cHMHRqAG3i9vv//MDVl64HeP1BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9dobPAP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9dobPAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734469202; x=1766005202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zKNEFVGOxuGdzP+F9oyV1PntBC5pgGexL0iNLZB7VXI=;
  b=U9dobPAPLXSZWGGtCbzQx8X17tubEZFWt1wRyVsuVO5N8q4K5Y8pF2q+
   GR09+B5QtV+D6/4ux0sodg3BZeCccE2KPUfn0sEkoIAB4xbFbZy9TmYMh
   UXKHAA3cseCKNtR8Iahwf+U1844Akidah8GdPYDllYA6BlO7c4OEfSTme
   idU8YPvP18nxCiWXjxeH0xdGHGImL2XH/MIvx+YChByiUXHVeIV2hgR1Y
   W6GwoTlpbz37yCGI/5qFSPhhZA04JYjlUfLsNU+0vln3H8goZ6wCYZOo+
   2VJT9yER2EdlnHhQAAJJiOouWo/w5ZeBoz3W7xRD5US9SRphyvLVLRQHj
   A==;
X-CSE-ConnectionGUID: eIHyZI4sT1u26wS5PcfpVw==
X-CSE-MsgGUID: qBTlmVmdRbOf8LGh1sDVnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34819615"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34819615"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 13:00:02 -0800
X-CSE-ConnectionGUID: iyXHe+NeQqyHsJPGLTDKwA==
X-CSE-MsgGUID: FmHlH7NYTVGFIkTcHYMYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="102650610"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 13:00:02 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6CF3920B5713;
	Tue, 17 Dec 2024 13:00:00 -0800 (PST)
Message-ID: <6467b30e-26a5-444c-bc20-5be7690e1e4c@linux.intel.com>
Date: Tue, 17 Dec 2024 15:59:59 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/4] perf/x86/intel: Support PEBS counters snapshotting
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com
References: <20241216204505.748363-1-kan.liang@linux.intel.com>
 <20241216204505.748363-4-kan.liang@linux.intel.com>
 <20241217133707.GB2354@noisy.programming.kicks-ass.net>
 <96cb859f-8265-4f5a-99bb-44cfdcd25b9e@linux.intel.com>
 <20241217202919.GG11133@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241217202919.GG11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-17 3:29 p.m., Peter Zijlstra wrote:
> On Tue, Dec 17, 2024 at 12:45:56PM -0500, Liang, Kan wrote:
> 
> 
>>> Why can't you use something like the below -- that gives you a count
>>> value matching the pmc value you put in, as long as it is 'near' the
>>> current value.
>>>
>>> ---
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index 8f218ac0d445..3cf8b4f2b2c1 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>>> @@ -154,6 +154,26 @@ u64 x86_perf_event_update(struct perf_event *event)
>>>  	return new_raw_count;
>>>  }
>>>  
>>> +u64 x86_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
>>> +{
>>> +	struct hw_perf_event *hwc = &event->hw;
>>> +	int shift = 64 - x86_pmu.cntval_bits;
>>> +	u64 prev_pmc, prev_count;
>>> +	u64 delta;
>>> +
>>> +	do {
>>> +		prev_pmc = local64_read(&hwc->prev_count);
>>> +		barrier();
>>> +		prev_count = local64_read(&event->count);
>>> +		barrier();
>>> +	} while (prev_pmc != local64_read(&hwc->prev_count));
>>
>> Is the "while()" to handle PMI? But there should be no PMI, since the
>> PMU has been disabled when draining the PEBS buffer.
> 
> Perhaps not in your case, but this way the function is more widely
> usable.
> 
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index e06ac9a3cdf8..7f0b850f7277 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1969,6 +1969,23 @@ static void adaptive_pebs_save_regs(struct
>> pt_regs *regs,
>>
>>  #define PEBS_LATENCY_MASK			0xffff
>>
>> +void intel_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int shift = 64 - x86_pmu.cntval_bits;
>> +	u64 prev_pmc;
>> +	u64 delta;
>> +
>> +	prev_pmc = local64_read(&hwc->prev_count);
>> +
>> +	delta = (pmc << shift) - (prev_pmc << shift);
>> +	delta >>= shift;
>> +
>> +	local64_add(delta, &event->count);
>> +	local64_sub(delta, &hwc->period_left);
>> +	local64_set(&hwc->prev_count, pmc);
>> +}
> 
> This seems very fragile, at least keep the same store order and assert
> you're in NMI/PMI context.

Sure, I will keep the store order.
You mean assert when there may be an unexpected NMI for the normal drain
case, right? I think we can check if the PMU is disabled as below.

@@ -1974,12 +1974,15 @@ static void intel_perf_event_pmc_to_count(struct
perf_event *event, u64 pmc)
 	int shift = 64 - x86_pmu.cntval_bits;
 	u64 delta;

+	/* Only read update the count when the PMU is disabled */
+	WARN_ON(this_cpu_read(cpu_hw_events.enabled));
+	local64_set(&hwc->prev_count, pmc);
+
 	delta = (pmc << shift) - (prev_pmc << shift);
 	delta >>= shift;

 	local64_add(delta, &event->count);
 	local64_sub(delta, &hwc->period_left);
-	local64_set(&hwc->prev_count, pmc);
 }

Thanks,
Kan


