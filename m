Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DC823183F;
	Fri, 14 Aug 2026 00:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786666847; cv=none; b=VffIc/TTYyym4AmD/tB8CPmECpmEgzeoZMsK8scm1lAJvgc4C8jWtuFXyjIJERQGAFwO+FxoUxtKIt3RD/aFPfc2Dn8m/U9notj3iIDyBvM2xYhB3Ex8jmHwESkAunnSYXmeFRD9ujh0mtG6r3cLOAfimYDppItNxTZTTEImC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786666847; c=relaxed/simple;
	bh=vN2f2oWXYERczNxt97fHM8Y6YOSTAOZUAqLDwIeUdl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvHYQktjk44ppGXNtAh9WtbbzdavSB8ZmbO9Q4KnrndhLg62Q7MdsfpJIO7+tn+A073dAt28EsfF08tT2mrzklZv4SXMudqlJSivsWuqJjwTs59mLtsVbxi/Rji3y7mVBFAjXsu4t7egFmk6fJNeNBqZzw1lxQFvtLQDrxHEQxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ben54wi4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ben54wi4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786666843; x=1818202843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vN2f2oWXYERczNxt97fHM8Y6YOSTAOZUAqLDwIeUdl4=;
  b=Ben54wi4KDJLkIzLB2cX8VILQkzxTS7U/imaJI+t88auvQYXjs8MF6Ei
   al4FPJmQnMRMSPZi8OwwixyvKgMK7I7xoSAQz1/alB+3O88JB/bW1iFpe
   jG3hi9m57usIapL1JLvKFYFrO71I12Q4Cdzv8+ecIO0cgxAFNxfK7uNy/
   9Qlp5G9Gd8E5bK8AFBtsemDNhSy0tiYZ8W0lodoB0kJohqvvGkg+le92C
   JwKcPjJ/V1kpKrSZOvu4Fe1uxJmW5YI0GWnL3ot6zTOmg3lvYLqOuIknn
   EnknWFdqBATD3ysAJXME8Tq4DrqzHv5rJVJJPV/Wq34dd/nCR44XSlju1
   A==;
X-CSE-ConnectionGUID: n43EM5FrR76gtZhFc1zNvQ==
X-CSE-MsgGUID: z+en1MAeQLax/BKseKXysQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="104635418"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="104635418"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 17:20:41 -0700
X-CSE-ConnectionGUID: YmIUyZ0ATbCLZejQHyI6Qg==
X-CSE-MsgGUID: Ldby9IJ6RdqsUwFMcPiaqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260285408"
Received: from unknown (HELO [10.238.3.58]) ([10.238.3.58])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 17:20:37 -0700
Message-ID: <8dc153c7-b21b-4fe3-8d14-3bd13c1ee6b5@linux.intel.com>
Date: Fri, 14 Aug 2026 08:20:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf/x86: Add x86_pmu::print_debug
To: Petr Tesarik <ptesarik@suse.com>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <cover.1786010408.git.sandipan.das@amd.com>
 <fc6ff612d26c2f5b0f015d9fac309cc58e913c1f.1786010408.git.sandipan.das@amd.com>
 <7078a9e7-6493-42b0-b297-ce174effdfb3@linux.intel.com>
 <20260813145725.22f21719@mordecai>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260813145725.22f21719@mordecai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/13/2026 8:57 PM, Petr Tesarik wrote:
> On Wed, 12 Aug 2026 10:37:20 +0800
> "Mi, Dapeng" <dapeng1.mi@linux.intel.com> wrote:
>
>> On 8/6/2026 6:03 PM, Sandipan Das wrote:
>>> perf_event_print_debug() dumps the global control and status MSRs
>>> whenever x86_pmu.version >= 2, reading registers that exist only on
>>> Intel-compatible PMUs. This is not safe since x86_pmu.version is not
>>> Intel-specific and is now set by other vendors whose global registers
>>> use different addresses.
>>>
>>> As a first step, split perf_event_print_debug() in two. The register
>>> dump moves into a new common helper, x86_pmu_print_debug(), leaving
>>> perf_event_print_debug() to handle the preamble and dispatch to an
>>> optional x86_pmu::print_debug method. This lets each vendor-specific
>>> PMU dump its own global state before chaining into the common helper.
>>> PMUs that do not implement the method, such as those with
>>> x86_pmu.version < 2, get the common helper alone.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>> ---
>>>  arch/x86/events/core.c       | 29 ++++++++++++++++++++++-------
>>>  arch/x86/events/perf_event.h |  4 ++++
>>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index af0b67ffb43d..17dc53a62378 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>>> @@ -1557,7 +1557,7 @@ static void x86_pmu_start(struct perf_event *event, int flags)
>>>  	perf_event_update_userpage(event);
>>>  }
>>>  
>>> -void perf_event_print_debug(void)
>>> +void x86_pmu_print_debug(int cpu)
>>>  {
>>>  	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>>>  	unsigned long *cntr_mask, *fixed_cntr_mask;
>>> @@ -1566,17 +1566,11 @@ void perf_event_print_debug(void)
>>>  	u64 pebs, debugctl;
>>>  	int cpu, idx;
>>>  
>>> -	guard(irqsave)();
>>> -
>>> -	cpu = smp_processor_id();
>>>  	cpuc = &per_cpu(cpu_hw_events, cpu);
>>>  	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
>>>  	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
>>>  	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
>>>  
>>> -	if (!*(u64 *)cntr_mask)
>>> -		return;
>>> -
>>>  	if (x86_pmu.version >= 2) {
>>>  		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>>>  		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
>>> @@ -1622,6 +1616,27 @@ void perf_event_print_debug(void)
>>>  	}
>>>  }
>>>  
>>> +void perf_event_print_debug(void)
>>> +{
>>> +	struct cpu_hw_events *cpuc;
>>> +	unsigned long *cntr_mask;
>>> +	int cpu;
>>> +
>>> +	guard(irqsave)();
>>> +
>>> +	cpu = smp_processor_id();
>>> +	cpuc = &per_cpu(cpu_hw_events, cpu);
>>> +	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
>>> +
>>> +	if (!*(u64 *)cntr_mask)
>>> +		return;
>>> +
>>> +	if (x86_pmu.print_debug)
>>> +		x86_pmu.print_debug(cpu);
>>> +	else
>>> +		x86_pmu_print_debug(cpu);  
>> The logic looks good, but better change this to the static_call() just like
>> other x86_pmu callbacks. It eliminates the branch prediction cost. Thanks.
> Is it worth the extra complexity for code that is used only by SysRq
> debugging?

perf_event_print_debug() is not just called in sysrq debugging, it's also
called by intel_pmu_handle_irq() which is a NMI handler. Any code in NMI
handler should be as simple as possible. Thanks.


>
> Of course, if it's trivial, let's do it anyway.
>
> Petr T
