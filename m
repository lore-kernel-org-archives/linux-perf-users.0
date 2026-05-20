Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A63002D8;
	Wed, 20 May 2026 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779243120; cv=none; b=I5PCVbWykLkgJ3UqJJjjh2nplrmvPGWzFxPctrwXUcM+geyqTHasQ/Pxjh9/0ms20o9SJxoBfWqkLaGDVDekTMSJPhCDeoYrb5nyraRwyw/lVvfPkX2kOHqejs2cJKTMNPEEUk0F8OevcyqkyBRrfB8WJxUAwRsvoRf7Ajlt+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779243120; c=relaxed/simple;
	bh=gQwKS7zjacmfeJ1JBTfanSf2V9FIzPnj8wn0LuJkVZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXU3eiKZIdSOye0wXFsU6xgq0J+nkMsTi25oHYmunCiN5As2zwQTWe0acEgbhE1bj2S2Hwfor68Hga46jwA3fHqwlvK+UzkR5QMgnjABlzSFkClXttP6fetyEDkace5yn3r2YPM+5oqRHoiPHYwJXlSNtF46ZfVDmwBgFAEh9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKZ4mV8t; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKZ4mV8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779243118; x=1810779118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gQwKS7zjacmfeJ1JBTfanSf2V9FIzPnj8wn0LuJkVZo=;
  b=RKZ4mV8tjv4tFQXuIiKOphIqy5ziDMLn1fQbjExXisAq7/g6MQLtuJJ3
   fRKCsUn2EHHumLeMOyh3jYVb3FPBBvrrM6/e+usvlnTLwUOWMLzm2DIkg
   Dh9LyrhP3UwIGkIP8Eqb71K/E3UKCTigK52jDr5/jwbc3IGDGXYFN6MxL
   ItKxlfRkPL8ABC2LTOmvNRLM6nvBjaZZM5dL7z+OUA0BwmSY+7/ynzthV
   TVI2yxOkSp/gK0NF+MG795j/0tgmGeQWKWNcp2cMcl/ep55812fUtkmYj
   wIM5HthJyMbNzHJyV9ESWzYJwweMFNo4TEjroKcdKj+kw4WjPNYavFBKv
   w==;
X-CSE-ConnectionGUID: 4OtEdVTfTeiia4Tb7+Uh1w==
X-CSE-MsgGUID: NTXODPJbR2Oxt9D8RAKVIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79983441"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79983441"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:11:58 -0700
X-CSE-ConnectionGUID: WIiuKIF7SquQVylcCWz/ag==
X-CSE-MsgGUID: pDICvfG6TryxO5hIJtXPYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239840504"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:11:54 -0700
Message-ID: <33873753-e44a-47a6-8a54-1975d62df7ed@linux.intel.com>
Date: Wed, 20 May 2026 10:11:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for SRF
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
 <20260515061143.338553-11-dapeng1.mi@linux.intel.com>
 <a2ad411c-e844-493e-8c50-d5821588170d@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <a2ad411c-e844-493e-8c50-d5821588170d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/20/2026 6:23 AM, Chen, Zide wrote:
>
> On 5/15/2026 11:11 PM, Dapeng Mi wrote:
>> Update perf hard-coded event constraints and cache_extra_regs[] for
>> Sierra Forest according to the latest SRF perfmon events (V1.17).
>>
>> SRF has same uarch (crestmont) as MTL E-core and shares same perf
>> events, so directly apply the crestmont perf events.
> Nit: Crestmont.

Sure. Thanks.


>> SRF perfmon events:
>> https://github.com/intel/perfmon/blob/main/SRF/events/sierraforest_core.json
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
> Reviewed-by: zide.chen@intel.com
>
>>  arch/x86/events/intel/core.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 587167dbb98f..e1c6fb127f10 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -8101,8 +8101,7 @@ __init int intel_pmu_init(void)
>>  
>>  	case INTEL_ATOM_CRESTMONT:
>>  	case INTEL_ATOM_CRESTMONT_X:
>> -		intel_pmu_init_grt(NULL);
>> -		x86_pmu.extra_regs = intel_cmt_extra_regs;
>> +		intel_pmu_init_cmt(NULL);
>>  		intel_pmu_pebs_data_source_cmt();
>>  		x86_pmu.pebs_latency_data = cmt_latency_data;
>>  		x86_pmu.get_event_constraints = cmt_get_event_constraints;
