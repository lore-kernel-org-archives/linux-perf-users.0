Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D317BA6;
	Mon,  1 Jun 2026 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275770; cv=none; b=CKfMuvttRHlD3LeyLGjt7s4VYf5jA4QI16HAPRPVpHOYO2mv3awc8AlXY0wdi6yudDQ6j1TPIEUk8MxKo2pofOM9FgR6ZFQ/W9SK1U0seCHA9AcAMTiyaqoVllEpGRsNfyweLITJUbmzXJwVYydH3j+c7PGb3bYS+wr/adxGynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275770; c=relaxed/simple;
	bh=W6F6sE68JnMsJaaX8e/GD/BnoKb24fhn7Hh3V0IYdQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+o7yvP6RELYPDj3DtLbSrhWAy9g8mQkc6xcePoFPA2gSei0XJR86HdOOz40ZVqjn3bs6uA3lPlmm47pr0hYr/ceXetzHwWdhjyhTvf1pQ9NeE9YaGrL8BiUhnNxwFu7RTXO4o3o88p5+O9n3924ve6nv4zBV0KyIkcAM69+vRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIkZQwbB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIkZQwbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780275767; x=1811811767;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W6F6sE68JnMsJaaX8e/GD/BnoKb24fhn7Hh3V0IYdQw=;
  b=NIkZQwbB6cI73zEYGjq+yGpBvpPEaFr9s7Xcf4NEfLm+GI20G8iDUtuK
   J8aJxY62YLK0mBtBjqfi4SfL2sD6CsHjEigXH9/bYjpLOOKNwZ5tHueu5
   ETsTP2mmYktBBm0qBglaeLzLK04lBakeWqUiy61npOelcCYbJCsPk4DpU
   SxIRg2uMpXKAfFEmOcTPoMgwY7W8d0GAXDyGYGR8rLX3izcWMG/aNmWjc
   wd0npJ0uD9+vhGzvOJ8UceRFAyYzJQjerFNZC1wRsEu+c52b1rj7zVxPd
   ZuGPVAGRiK6sy56zwNT6AaADneQI/vCzpbaAWg7cijwR5B82TOQlVKRPF
   A==;
X-CSE-ConnectionGUID: O5KkppCyQninsDX5zAKdXA==
X-CSE-MsgGUID: 6DmAPTgRSYaMBuzXN2S2mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="106478664"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="106478664"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 18:02:47 -0700
X-CSE-ConnectionGUID: 2BQUelDJSfSrvEMs2da4gw==
X-CSE-MsgGUID: fZv7GCywQkO4M8L/SxeVhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="267297539"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 18:02:42 -0700
Message-ID: <5fccdf7d-f9a0-408e-8615-85eacc0c160e@linux.intel.com>
Date: Mon, 1 Jun 2026 09:02:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 01/23] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-2-dapeng1.mi@linux.intel.com>
 <20260529111147.GI3493090@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529111147.GI3493090@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/29/2026 7:11 PM, Peter Zijlstra wrote:
> On Fri, May 29, 2026 at 03:56:23PM +0800, Dapeng Mi wrote:
>> The memory allocation for the x86_pmu.hybrid_pmu[] array in
>> intel_pmu_init_hybrid() can theoretically fail due to memory shortages.
>> If this occurs, the initialization of the x86 hybrid PMU would fail.
>>
>> Currently, the code does not check the return value of the
>> intel_pmu_init_hybrid() function, which could lead to attempts to access
>> the uninitialized x86_pmu.hybrid_pmu[] array, potentially causing a
>> system panic.
>>
>> So, adds a check for the return value of intel_pmu_init_hybrid() to
>> prevent invalid memory access in such scenarios.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>
>> V8: New patch.
>>
>>  arch/x86/events/intel/core.c | 29 ++++++++++++++++++++++-------
>>  1 file changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 0217e701aeeb..85c329bd52be 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -7870,6 +7870,7 @@ __init int intel_pmu_init(void)
>>  	int version, i;
>>  	char *name;
>>  	struct x86_hybrid_pmu *pmu;
>> +	int ret;
>>  
>>  	/* Architectural Perfmon was introduced starting with Core "Yonah" */
>>  	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
>> @@ -8545,7 +8546,9 @@ __init int intel_pmu_init(void)
>>  		 *
>>  		 * Initialize the common PerfMon capabilities here.
>>  		 */
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			return ret;
> Sashiko notes this will leak the intel_pmu_arch_lbt_init() kmemcache.
>
> I'm not entirely sure we care much about that, but its not really nice.

Sashiko did a good job!

Yes, it's a bug and would be fixed in next version. Thanks.


