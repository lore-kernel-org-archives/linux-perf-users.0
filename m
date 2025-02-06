Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBFBD529;
	Thu,  6 Feb 2025 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738807810; cv=none; b=Nh1DsJJOExgxywvDI5W3dMR/9Wdx5zTHkewggmA88fkhrjX/3f+vxetZyhRYwNf9awYlKOro9i9QcZutO5345gg8AxOQmT2EtUo31vneNhqzw36nmHzdvOc/crPmzzl4/d0LFkyw546hFE5SqxU3ZQ0cjpH46lnJ2J9kJMh1fkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738807810; c=relaxed/simple;
	bh=TYvtC+W5mN7cCLPG6BLgPSWaXZOFmBGSrrIwDYv2SsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLOm0SsvHIRm+U3k1biAyV0yr3985cxg+aNpfcnp2ceSJSv25Tf2t6z27qj4D9iIuXqbLUmzVOigiyM2lyIe6VlK+JeyMRzIxDzMtJe3pLJv2zZfDCkfuYLpz+PdYlnV05/nre8pkGzZo5zEx2y9OSy0RzlmZE5jOj3spxxcq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GrVw4DXN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GrVw4DXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738807809; x=1770343809;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TYvtC+W5mN7cCLPG6BLgPSWaXZOFmBGSrrIwDYv2SsU=;
  b=GrVw4DXNMh7GhN0iJLDqI1+WH2dq7Kul/4MlNnHIPTsvm4RnJUMmpJuu
   omRUSeFKsTLYzJBCN69JdSqYLd1RWNbf9mHGfs+FLqEETA6w4DHE/3/cw
   6FZCyW8A9D+Nbh/DDP/AnsTZ+BAy+J9xNATgk/SQXL/piMyO9eSg72XBT
   oqZIXkyRotkfbAcRbD0kGA51u4MqqnibdU53/gpSEmErhRhYC/YZuGmcA
   R1GwtQhJCyCzEH0/7gU7pL6ii3s+EjfiUqgyUOdvB/cXZQ68k+lFlYLB+
   bunJrzTyocFUndK+7TU7fNz6ljoXY2zupU1Yfec5PYOyfl4qdFzuJCLgH
   w==;
X-CSE-ConnectionGUID: FLs9GT5ORSuZTnDjCEf0Zw==
X-CSE-MsgGUID: s6mvjepvRqCrT4LvY1ptpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43151030"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="43151030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:10:08 -0800
X-CSE-ConnectionGUID: Uclb2hTASz2j9ZdZrSajHg==
X-CSE-MsgGUID: axTy98l/TUqXoU2HLE6gew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115150872"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:09:45 -0800
Message-ID: <bc002854-85b8-4f55-a253-791d5f222620@linux.intel.com>
Date: Thu, 6 Feb 2025 10:09:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] perf/x86/intel: Parse CPUID archPerfmonExt leaves
 for non-hybrid CPUs
To: Peter Zijlstra <peterz@infradead.org>,
 "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-4-dapeng1.mi@linux.intel.com>
 <Z5KRT-F7MbTs6g6y@tassilo>
 <85588439-ec0e-4824-8193-f0737880ecb9@linux.intel.com>
 <20250127164406.GN16742@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250127164406.GN16742@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/28/2025 12:44 AM, Peter Zijlstra wrote:
> On Mon, Jan 27, 2025 at 10:19:34AM -0500, Liang, Kan wrote:
>>
>> On 2025-01-23 1:58 p.m., Andi Kleen wrote:
>>>> +	/*
>>>> +	 * The archPerfmonExt (0x23) includes an enhanced enumeration of
>>>> +	 * PMU architectural features with a per-core view. For non-hybrid,
>>>> +	 * each core has the same PMU capabilities. It's good enough to
>>>> +	 * update the x86_pmu from the booting CPU. For hybrid, the x86_pmu
>>>> +	 * is used to keep the common capabilities. Still keep the values
>>>> +	 * from the leaf 0xa. The core specific update will be done later
>>>> +	 * when a new type is online.
>>>> +	 */
>>>> +	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
>>>> +		update_pmu_cap(NULL);
>>> It seems ugly to have these different code paths. Couldn't non hybrid
>>> use x86_pmu in the same way? I assume it would be a larger patch.
>> The current non-hybrid is initialized in the intel_pmu_init(). But some
>> of the initialization code for the hybrid is in the
>> intel_pmu_cpu_starting(). Yes, it's better to move it together. It
>> should be a larger patch. Since it's impacted other features, a separate
>> patch set should be required.
> IIRC the problem was that there were SKUs with the same FMS that were
> both hybrid and non-hybrid and we wouldn't know until we brought up the
> CPUs.
>
> Thomas rewrote the topology bits since, so maybe we can do beter these
> days.

This optimization would be a fundamental and large change. As Kan said,
we'd better put it as a separate patch series, then it won't block this
arch-PEBS enabling patches.


