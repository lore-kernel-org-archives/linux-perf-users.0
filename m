Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0F2D3ECA;
	Fri, 22 Aug 2025 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840594; cv=none; b=Im6bJqyTuxE+5Ki8/vCyKrP7o7hZ+hNBu6tzjUe+jAKfYoS+4GUgAk4xMx47PZL+W+mYswJvDs/cAVhZA2Tos8jtEubG6JS2AjusIWnXJKiOzbTFh+lGTXY5mGtAx2ZmHxG5g01zEaApsqe7BgDK51oRg1FxI4PB3d9FbEgHOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840594; c=relaxed/simple;
	bh=/nXu4w0k897yAOJJIe2N1Qn1CS/A7dJnTaBLKSnh+wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yuhvs27IhxTS+1ipkytbgvMlnHHrU17Zz7SrIz1CgaNRby04QUs1wtcakLcSgvH4P2fQsfs71SyVpGcyvLPOVJqOaYqzW6r4kNPjxdteodNyWdfP2hyU1bDf5y+DKI/h7jw7VFzah4ncfapf/SJMZGka8wdOfN1u6p0OhbR8Ajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1RDQZ8l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1RDQZ8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755840593; x=1787376593;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/nXu4w0k897yAOJJIe2N1Qn1CS/A7dJnTaBLKSnh+wc=;
  b=Z1RDQZ8lGpZCoCb+TP0N+KubvuCRwianF/OJQB/1KbiIedS2cTkn8BcN
   5l9kEYoUkF/vqHcl0W78QFk1bPyp80UZypqJpPCdbdhEk2OkE2vDRHusj
   rxGs0Bha/rbwpWJpNrXuU5xMsTBVJGIKgGfNwqAPwgRBusjtR2mpg8gfc
   Xh8nhd3NHEkSUrSiYzsBmpTAcgg9Ed4Rhr+I4ilNYAWiXHTNCUxdrRoVq
   gJ7KnUwAK75wmdASI9aqX19uQutnjPKGKJzVdzhCXofwC3VazKJhWU49L
   ziQR/RJhJXrMKWut89wOKcNdfgK3B9j4p3puXljdG27yrec6ABppq8SuM
   w==;
X-CSE-ConnectionGUID: jMySDED3Q9uwx2g9MAF/7A==
X-CSE-MsgGUID: pjGEJlcDQ1e8co8OzGycIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="75600627"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="75600627"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 22:29:52 -0700
X-CSE-ConnectionGUID: LgIeqKrzQX+bhXwMHTWsyg==
X-CSE-MsgGUID: 5bynulpPS0S9ZePpWB94Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199496143"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.233.125]) ([10.124.233.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 22:29:48 -0700
Message-ID: <64ef97eb-018d-4948-8544-87150f47ab38@linux.intel.com>
Date: Fri, 22 Aug 2025 13:29:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 0/7] x86 perf bug fixes and optimization
To: Peter Zijlstra <peterz@infradead.org>,
 "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
 <75fbe025-214f-4b2c-8077-a8dbfa34a5c2@linux.intel.com>
 <20250821133915.GQ4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250821133915.GQ4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/21/2025 9:39 PM, Peter Zijlstra wrote:
> On Wed, Aug 20, 2025 at 08:55:24AM -0700, Liang, Kan wrote:
>
>>> Dapeng Mi (7):
>>>   perf/x86/intel: Use early_initcall() to hook bts_init()
>>>   perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
>>>   perf/x86: Check if cpuc->events[*] pointer exists before accessing it
>>>   perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
>>>   perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to
>>>     BIT_ULL(48)
>>>   perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into
>>>     INTEL_FIXED_BITS_MASK
>>>   perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()
>>>
>> The series looks good to me.
>>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> I've picked up all but patch 3 -- I really don't think that does the
> right thing.

Thanks. I would rewrite the patch 3 and aggregate it into the arch-PEBS
enabling series.


