Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE68617A2E8;
	Fri,  7 Nov 2025 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762495879; cv=none; b=A6iAVuxfAPBY2QZ+kHRSP4xe0nAKYTsKiq35VXoL9Kc29w18RkLaITMx1WjMLqkHLc6MpfhPnOPpT7bIdQIWgMWkP8IrE0YpsKjfYwP8OFgZ8PBXWb418J9mbT/H7XthLkjwqsD1zCMv+y/dGlt1okKrDPFdjYr5oPpyENdpnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762495879; c=relaxed/simple;
	bh=l5tph7wcgt5aBnQKOXSjkNg80MMPbjG+hYLFf0ASMlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8CUzJVvKiTBiIa0xOyIgwC5ij+fAELa22JO7R4uPkVtMw8QvzUcYXAN/6Cvuh8E26OpAhccWUU4W/jbVkihtvUWYmvhg/uB+slVNE6KaN+K0wykkSlo5ELY8Qh30+zxmj16kYsRJ4rI4gul72Z3+aYSsOIl5HDTwUsudWadzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1MuBIhi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1MuBIhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762495877; x=1794031877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l5tph7wcgt5aBnQKOXSjkNg80MMPbjG+hYLFf0ASMlM=;
  b=F1MuBIhi4cVjTQwdTz5DKe2gT8mmtiI8DtzTAX7w0d/SHuVO6a6jTZWx
   JQhasAlfvNYpWl6aYQ9JZQPQyjesVDzab+Nu75N2zh0lsskyZ/Lubtx3F
   G3wz+YQHhEHHsqMYpInZI7RZSsOolkiN5usfnkFr4f5N8/ufQ+c4SWM4w
   ySAiIp4ebcj7mp2BBUX97ieVN14Fsz9QlXc6BLnFwAYI0cLCQipCwpIXJ
   KlscLGGnDWPyb4D3NNjI5AqNOgcHNDqgfSb0W4mWydlMMZRLo5bgrnAij
   mpeHc4XFSrZsC2BM+Yq5FO9XyjZ5uel3oAZVnvi/VQc2TmrYaXmnmDVwu
   A==;
X-CSE-ConnectionGUID: Aox04W3eSiyCKzqRMFrTxQ==
X-CSE-MsgGUID: 9PzhqyleSWarhNcQFD6yVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="63655380"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="63655380"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 22:11:17 -0800
X-CSE-ConnectionGUID: 0pWOSzl5Q0OO5jEFJRVJxw==
X-CSE-MsgGUID: rrRN/hZERfuj2u9uwvLrrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192055918"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 22:11:12 -0800
Message-ID: <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
Date: Fri, 7 Nov 2025 14:11:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/6/2025 10:52 PM, Peter Zijlstra wrote:
> On Wed, Oct 29, 2025 at 06:21:34PM +0800, Dapeng Mi wrote:
>> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
>> sampling and precise distribution PEBS sampling. Thus PEBS constraints
>> should be dynamically configured base on these counter and precise
>> distribution bitmap instead of defining them statically.
>>
>> Update event dyn_constraint base on PEBS event precise level.
> What happened to this:
>
>   https://lore.kernel.org/all/e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com/

About the issue, Kan ever posted a patch to mitigate the risk, but it seems
the patch is not merged yet.

https://lore.kernel.org/all/20250512175542.2000708-1-kan.liang@linux.intel.com/


>
>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 11 +++++++++++
>>  arch/x86/events/intel/ds.c   |  1 +
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 6e04d73dfae5..40ccfd80d554 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4252,6 +4252,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  	}
>>  
>>  	if (event->attr.precise_ip) {
>> +		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
>> +
>>  		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
>>  			return -EINVAL;
>>  
>> @@ -4265,6 +4267,15 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		}
>>  		if (x86_pmu.pebs_aliases)
>>  			x86_pmu.pebs_aliases(event);
>> +
>> +		if (x86_pmu.arch_pebs) {
>> +			u64 cntr_mask = hybrid(event->pmu, intel_ctrl) &
>> +						~GLOBAL_CTRL_EN_PERF_METRICS;
>> +			u64 pebs_mask = event->attr.precise_ip >= 3 ?
>> +						pebs_cap.pdists : pebs_cap.counters;
>> +			if (cntr_mask != pebs_mask)
>> +				event->hw.dyn_constraint &= pebs_mask;
>> +		}
>>  	}
>>  
>>  	if (needs_branch_stack(event)) {
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 5c26a5235f94..1179980f795b 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -3005,6 +3005,7 @@ static void __init intel_arch_pebs_init(void)
>>  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>>  	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
>>  	x86_pmu.pebs_capable = ~0ULL;
>> +	x86_pmu.flags |= PMU_FL_PEBS_ALL;
>>  
>>  	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
>>  	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
>> -- 
>> 2.34.1
>>
