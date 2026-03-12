Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EB37B3EF;
	Thu, 12 Mar 2026 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282696; cv=none; b=jbKmxyabG0Fz9jjLbbOdRes+jwk3PXk4XdSAD0lppESQkFI0u+0OPZlWmmhlDJd0++e4TWRSVacvJ68ASjLJQS2b7clsXlCZivggietiTKKSi+B5XpmU9tu9iXCH21oX/Q+5qum+0Uk9tvlddL1ztMmtPRS2A5aS9GfOXHmZLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282696; c=relaxed/simple;
	bh=BH0BfbtEayS2qwyJivYzLS+tdTpV+Bg/Yk1xARQ+QVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R10IqWoYb63W46SocW5BQrVHQRjhvUWKVxsJnjjNmz+KVYjcaORcZyvz15Ak8TWtam8rsHiz+YupOOozZY4xyP3v1+ABI/PtfhuExXz/WBui2XJiLtaI9wUbjn239cVgwdKamF8GggYmqQAWChfgsByxMk2oNcqmhhTqU7+87UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMW8UVtA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMW8UVtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773282695; x=1804818695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BH0BfbtEayS2qwyJivYzLS+tdTpV+Bg/Yk1xARQ+QVw=;
  b=WMW8UVtA+E+Mg6TnPK/bIyBeeRshhz73NuiVJ1lWfSTGV0kp+7CKV+NA
   psDm/oIHA9A1v5jQhrzAQkjo7WmkUYWwVdEID5+6jK2FiRJ7Tky2E8aTX
   acuaNRa13yMGTPCI/k8W42yV3GbAxG6Uo2f7yt9nD8lk+wuoeIW2zn8P5
   vZwfyt4boskiNikAmPYmlRaLhGTEdtO4497O0ShvIcdmtcCJIAor+ZOZi
   01j3Z7aiDwSDVbO/7gohCyXIrlIDStVehmsVt89Ov1CnpEfbLv7NAAfSp
   7xO27J9yWao5UTl1Yl9r/Dmqzj6tmdT98vcj9bfhtVOPGcL06sWoE6cko
   w==;
X-CSE-ConnectionGUID: LbbzYRMrQ6+zsXX8CcRy3g==
X-CSE-MsgGUID: YJu2nrbnRTKNjsBxTA12sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74243964"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74243964"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:31:34 -0700
X-CSE-ConnectionGUID: Rsi25q53S0m6lWzPN2efEw==
X-CSE-MsgGUID: 2itRWNZCRmK9cotUwazeWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="215796144"
Received: from unknown (HELO [10.238.3.214]) ([10.238.3.214])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 19:31:30 -0700
Message-ID: <0a720411-0b24-42eb-9897-856b1175aa82@linux.intel.com>
Date: Thu, 12 Mar 2026 10:31:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch 2/2] perf/x86/intel: Add missing branch counters
 constraint apply
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 stable@vger.kernel.org
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
 <20260228053320.140406-2-dapeng1.mi@linux.intel.com>
 <20260311201625.GW606826@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260311201625.GW606826@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/12/2026 4:16 AM, Peter Zijlstra wrote:
> On Sat, Feb 28, 2026 at 01:33:20PM +0800, Dapeng Mi wrote:
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 4768236c054b..4b042d71104f 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4628,6 +4628,19 @@ static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
>>  		event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
>>  }
>>  
>> +static inline int intel_set_branch_counter_constr(struct perf_event *event,
>> +						  int *num)
>> +{
>> +	if (branch_sample_call_stack(event))
>> +		return -EINVAL;
>> +	if (branch_sample_counters(event)) {
>> +		(*num)++;
>> +		event->hw.dyn_constraint &= x86_pmu.lbr_counters;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int intel_pmu_hw_config(struct perf_event *event)
>>  {
>>  	int ret = x86_pmu_hw_config(event);
>> @@ -4698,21 +4711,18 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		 * group, which requires the extra space to store the counters.
>>  		 */
>>  		leader = event->group_leader;
>> +		if (intel_set_branch_counter_constr(leader, &num))
>>  			return -EINVAL;
>>  		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
>>  
>>  		for_each_sibling_event(sibling, leader) {
>> +			if (intel_set_branch_counter_constr(sibling, &num))
>> +				return -EINVAL;
>> +		}
>> +
> Do the new bit is this, right?

Actually not, the key change is the below one. The last event in the group
is not applied the branch counter constraint.

Assume we have a event group {cycles,instructions,branches}. When the 3rd
event "branches" is created and the function intel_pmu_hw_config() is
called for the "branches" event to check the config.  The event leader is
"cycles" and the sibling event has only the "instructions" event at that
time since the 3rd event "branches" is in creation and still not added into
the sibling_list. So for_each_sibling_event() can't really iterate the
"branches" event.


>
>> +		if (event != leader) {
>> +			if (intel_set_branch_counter_constr(event, &num))
>>  				return -EINVAL;
>>  		}
> The point being that for_each_sibling_event() will not have iterated the
> event because its not on the list yet?

Yes. 


>
> That wasn't really clear from the changelog and I think that deserves a
> comment as well.

Sure. I would add comment and enhance the changelog to make it clearer. Thanks.


>
> Let me go fix that.
