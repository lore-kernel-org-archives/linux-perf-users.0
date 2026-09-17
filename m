Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFD1448E0;
	Thu, 17 Sep 2026 01:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607005; cv=none; b=NSqvHV18upWnpObFGw0Ka3m9KK4vA0Z4ug1bkA2sRPgbTb8ZLHkBrVGTpt1xqqP6Nu2zvNy9NOXW1A97282/GH+I8+P85Uu93GOQXGT5E0+EScqKakAFNN648VA9UAFw9LitcsVsPragnGOShepr3ogmkvLWtI3t6Y9IHMD2Kb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607005; c=relaxed/simple;
	bh=inNyvSkcLBnS5k/OiUY6yUYECw1VW2i6mv/AgsAoLVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf139ctWsFKvLz9HuG2SG1bosxemlvYEp0JYRBeQvy6puKCPR9rgMTgq6xf+b8ZI/K6XBdmmVEODbcsW7QGVpdC25QlXlm2TBj/jDDlaC7Rv3fL9YvM8/TCZe8LysLQp5ixBFuc3J7RlcBLPJhM14BJRQ9q3pBt2MP6M2cWgb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6xxV9o0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6xxV9o0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789607004; x=1821143004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=inNyvSkcLBnS5k/OiUY6yUYECw1VW2i6mv/AgsAoLVg=;
  b=P6xxV9o0klTEPoE76dicjPYzxq/IsV4dOU+xkHjTCid2GoxaQHBQWVvg
   l4jglI9PIhdtin5QkCfGRcf8xR90H6NQhxHkBP73sAsULdFjvmONuLJTA
   fNLHdCd4B8iQMmY7xVJVwxNuyn6C4o5mXk/KIx/kjDRyjPh3b7gZsunUH
   6zUCPLDy2iwfMxs518a8mdbIuH7siOv+FNetXc3vIgBRE/chjmV9FKuJZ
   VeZS4zWOZnD+Pp0e81e1UXdc7fRaoQpc/fP7lh/GOsBkaK41tlGFQ2PtV
   3+wPvr4SV4npI8Mf1B7klZ3Yn436kS9oY8uHznkq4FxE2WiuGLKwOSul3
   g==;
X-CSE-ConnectionGUID: gJBmHJAiSZC8hGwfxVF+MA==
X-CSE-MsgGUID: EfOfovyTTEu22jhAL/h6Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92500778"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92500778"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:03:23 -0700
X-CSE-ConnectionGUID: xTMPxkNlRLyAAUGaj09X5A==
X-CSE-MsgGUID: 3VpWgHoIRHuSCFef8fYZ8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277638019"
Received: from unknown (HELO [10.238.2.103]) ([10.238.2.103])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 18:03:20 -0700
Message-ID: <169f9a48-425d-4e58-b05d-bed05c4c6971@linux.intel.com>
Date: Thu, 17 Sep 2026 09:03:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: Add checks to prevent null ptr access
To: "Belgaumkar, Vinay" <vinay.belgaumkar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260904181625.1394082-1-vinay.belgaumkar@intel.com>
 <20260904181625.1394082-2-vinay.belgaumkar@intel.com>
 <f2b62bcb-b5a1-48e9-93c8-644ab3ac4439@linux.intel.com>
 <1d6c8cd5-76e9-421c-9e36-3de7c2816d27@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <1d6c8cd5-76e9-421c-9e36-3de7c2816d27@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/17/2026 5:48 AM, Belgaumkar, Vinay wrote:
> On 9/15/2026 6:40 PM, Mi, Dapeng wrote:
>> On 9/5/2026 2:16 AM, Vinay Belgaumkar wrote:
>>> Sashiko recommended some additional checks to prevent null pointer
>>> access. Check for revoked states inside perf_event_read_local(), as
>>> the pmu event may have already been freed at this point. Add a null
>> Could you please show where perf_event_read_local() could be called after
>> the event is revoked?
> perf_event_read_local() is only available to be called in the kernel 
> context. So, BPF helpers can call it. This was the scenario outlined by 
> Sashiko:
>
> If CPU A calls perf_event_read_local(), disables interrupts, and locklessly
> checks event->state, it can pass if the event state is
> PERF_EVENT_STATE_INACTIVE.
>
> Concurrently, if CPU B calls perf_pmu_unregister() which leads to
> __pmu_detach_event(), it will not send an IPI to synchronize with CPU A
> since the event is inactive. CPU B then sets event->state to
> PERF_EVENT_STATE_REVOKED and clears event->pmu to NULL.
>
> When CPU A continues and calls __perf_event_read_cpu(event, event->cpu),
> if the event has PERF_EV_CAP_READ_SCOPE, it will dereference
> event->pmu->scope, which was just set to NULL by CPU B, causing a panic.

Ok, better add this into the change log, so the reviewers know why we need
this change. Thanks.


>
> So, I think the scenario is- we have a regular perf session ongoing and 
> a parallel session (through BPF) that tries to access the same counter.
>
>> BTW, the prefix should be "perf/core:" instead of "perf:" by following
>> current naming convention.
> Sure.
>
> Thanks,
>
> Vinay.
>
>> Thanks.
>>
>>
>>> check inside __perf_event_read_cpu() as well before accessing the pmu
>>> ptr.
>>>
>>> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>>> ---
>>>   kernel/events/core.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 7777e82aad5e..059f82f0cadd 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -4788,14 +4788,19 @@ static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int
>>>   
>>>   static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
>>>   {
>>> +	struct pmu *pmu = READ_ONCE(event->pmu);
>>>   	int local_cpu = smp_processor_id();
>>>   	u16 local_pkg, event_pkg;
>>>   
>>>   	if ((unsigned)event_cpu >= nr_cpu_ids)
>>>   		return event_cpu;
>>>   
>>> +	if (!pmu)
>>> +		return -ENODEV;
>>> +
>>>   	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
>>> -		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
>>> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope,
>>> +										event_cpu);
>>>   
>>>   		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
>>>   			return local_cpu;
>>> @@ -4917,6 +4922,11 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
>>>   		goto out;
>>>   	}
>>>   
>>> +	if (READ_ONCE(event->state) <= PERF_EVENT_STATE_REVOKED) {
>>> +		ret = -ENODEV;
>>> +		goto out;
>>> +	}
>>> +
>>>   	/*
>>>   	 * Get the event CPU numbers, and adjust them to local if the event is
>>>   	 * a per-package event that can be read locally
