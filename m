Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29B44C94;
	Thu,  6 Feb 2025 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808774; cv=none; b=a4q7SO+9JQFVCY1BT24/CtNAqpx/JGvkZ90dF3zaNSk8Llgzsn7yV2ekNq1HFZhmubarTXQzp5zRS2HtxDvG69Tz56ebu9S+as9pu7yuODMEiNbFxkHp46OyJjX4uR/5jiEsQqwE1k0i2z9fyLdJwkItt8pps65aUx25Ur37vlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808774; c=relaxed/simple;
	bh=Ce/LAj70TOZue3UX1FV2yx0zOjmbrJlrGqVBFBMr7wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPMBLHORloKIInrlkJwW+T010jMvuukGQXUWr+Hnh2M2QVq/KUVmHfL0oVnbCn3iwpCJ24/o5bI2OQAoCegzGChObsvUqKWSfEIKXDdMf1qvaiuqu/ghJrt3wWVgCudhWn3+EJVJy0So7Ts7jJVqxIeDN3vo9L1O1xFTLyn1PUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HltVj3Eb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HltVj3Eb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738808773; x=1770344773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ce/LAj70TOZue3UX1FV2yx0zOjmbrJlrGqVBFBMr7wE=;
  b=HltVj3EbNZ24l9vcfAfZ4nvEHbMi9gq75hsS2x4QPAB9/9rC41TNmU0E
   sJo1D3Axy/IS6013r6gx61wO0fbAL9cLQ7HMAJ+GM+wIXs3/imdH32scE
   HKVt3hLq0d2ncomXqvTzqp8Bdg5JwXeF7KcLy514CqITuyHMDzRFjpHoY
   8ldQtxrEaBHFCu+xMBFqct5M6NJ+F82iAAF5TPe22aQTNbi1L2xhls0vu
   V0v9IVNuAU0g9f7sXeQ1fPd+T0UZdbZrovygmi8a+oF8fAMeB8r7cVEnm
   XwRU1PasT2j/RwcxCLxmDr23SnThqmdsy4C+jhm9tzU8aDupfqzn/Q9WZ
   A==;
X-CSE-ConnectionGUID: T4A9ibPHSlasJN8aVk03Ag==
X-CSE-MsgGUID: dYA07eNsS6enzt21zDNsag==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56815412"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="56815412"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:26:12 -0800
X-CSE-ConnectionGUID: WIiYFZmXSxS00ld9/ptZCg==
X-CSE-MsgGUID: pVMeW+KrR6i9EDcRi5JvcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115154167"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:26:02 -0800
Message-ID: <7a03fdf5-f080-4580-8850-20dc88003d14@linux.intel.com>
Date: Thu, 6 Feb 2025 10:25:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] perf/x86/intel: Initialize architectural PEBS
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-7-dapeng1.mi@linux.intel.com>
 <20250128112202.GA7145@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250128112202.GA7145@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/28/2025 7:22 PM, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 02:07:07PM +0000, Dapeng Mi wrote:
>
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index e8a06c8486af..1b33a6a60584 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1537,6 +1537,9 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>>  
>>  	cpuc->pebs_enabled |= 1ULL << hwc->idx;
>>  
>> +	if (x86_pmu.arch_pebs)
>> +		return;
>> +
>>  	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
>>  		cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
>>  	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
>> @@ -1606,6 +1609,11 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>>  
>>  	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
>>  
>> +	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
>> +
>> +	if (x86_pmu.arch_pebs)
>> +		return;
>> +
>>  	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
>>  	    (x86_pmu.version < 5))
>>  		cpuc->pebs_enabled &= ~(1ULL << (hwc->idx + 32));
>> @@ -1616,15 +1624,13 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>>  
>>  	if (cpuc->enabled)
>>  		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>> -
>> -	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
>>  }
>>  
>>  void intel_pmu_pebs_enable_all(void)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>> -	if (cpuc->pebs_enabled)
>> +	if (!x86_pmu.arch_pebs && cpuc->pebs_enabled)
>>  		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>>  }
>>  
>> @@ -1632,7 +1638,7 @@ void intel_pmu_pebs_disable_all(void)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>> -	if (cpuc->pebs_enabled)
>> +	if (!x86_pmu.arch_pebs && cpuc->pebs_enabled)
>>  		__intel_pmu_pebs_disable_all();
>>  }
> So there's a ton of if (arch_pebs) sprinkled around. Can't we avoid that
> by using a few static_call()s ?

Sure. Let me try it.


