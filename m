Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F261B2EEC;
	Fri, 30 Aug 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029406; cv=none; b=ucczDtGRHAoSpCuXLeEd/jOHvOAZ03/HkF88kajbFiPDY43VrKo/HDe3XOTxtJHYpl1c+w9GsEtooLoVD2xc2Zxe+tthfqDxqaVD1wAN7Hu9wKh1NIwWfA8Ae7UMrJPivc6tJFEZMAJSzIUHidWy7pq82TsLdGdETMTMdorn9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029406; c=relaxed/simple;
	bh=GMKWqy+23t/PgauYTx3o6OwLYO6mZgl00Ayx50aRrWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ugCGn8FmDW0zzMiPqj49bLoWtfMIMMnuCz/0wwj6u3yweHplz/xXwQ3N9WeuhdRXNBoVHV3a1+KccAHDZw4jycIv9IayI3wpsv4Sl7/VNOwN6C/euP9IHz26xNcJzBIRv35b4vkH9Mpvld7cCQa5XAcD6XxBiLA5cOB6TVetY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmzMG31T; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmzMG31T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725029404; x=1756565404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GMKWqy+23t/PgauYTx3o6OwLYO6mZgl00Ayx50aRrWg=;
  b=GmzMG31TJhqpm4H2IByxytv/1yhjR5DkzR1x0iowx1ON5gwH/jyOMzvR
   BKNaR8xc/ylYjacjGCeZ2p6iV63OlIdsg2kuZRs1egOzqnoPdr3153Y25
   +PGUV3zA45npBT0Qs2GfzK9RVJrUIA43w3C4f6uhQp0M58H9uDo+VJJgR
   OtjilKM1Lnfk4yesw9s/hbEWp+HWGJdC+W2eWEUc5HxWGQLyRI8qQh+WF
   ggnjp+/+dQWebaNb55kqRLQcJGVt3RKM75LI/YMoQhXT5mSl27z11fTcy
   U7sQ77Gj8tCop3PVvoOh61pz8RoKXZXqN8DWeFRoZsDiYoiq6pNyQCL/O
   Q==;
X-CSE-ConnectionGUID: 0gQSI4OUR2iiSOocgzVyIg==
X-CSE-MsgGUID: kteBZ52PT9uB+7WIIwpQsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="35079926"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="35079926"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:50:03 -0700
X-CSE-ConnectionGUID: lb0IOgGYTkG2v7TgTLbc6g==
X-CSE-MsgGUID: EzjL6GTZQnqnKnEeJcgNTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="64107782"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 07:50:03 -0700
Received: from [10.212.19.12] (kliang2-mobl1.ccr.corp.intel.com [10.212.19.12])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id EAEE920CFEE2;
	Fri, 30 Aug 2024 07:50:00 -0700 (PDT)
Message-ID: <54dafedb-a96b-4e10-8a89-24e843962c24@linux.intel.com>
Date: Fri, 30 Aug 2024 10:49:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] perf: New start period for the freq mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
 acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 ravi.bangoria@amd.com, sandipan.das@amd.com, atrajeev@linux.vnet.ibm.com,
 luogengkun@huaweicloud.com, ak@linux.intel.com
References: <20240829152036.3923842-1-kan.liang@linux.intel.com>
 <ZtFjFpg0MCcLbgnq@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZtFjFpg0MCcLbgnq@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-30 2:13 a.m., Namhyung Kim wrote:
> Hi Kan,
> 
> On Thu, Aug 29, 2024 at 08:20:36AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The freq mode is the current default mode of Linux perf. 1 period is
>> used as a start period. The period is auto-adjusted in each tick or an
>> overflow to meet the frequency target.
>>
>> The start period 1 is too low and may trigger some issues.
>> - Many HWs do not support period 1 well.
>>   https://lore.kernel.org/lkml/875xs2oh69.ffs@tglx/
>> - For an event that occurs frequently, period 1 is too far away from the
>>   real period. Lots of the samples are generated at the beginning.
>>   The distribution of samples may not be even.
>>
>> It's hard to find a universal start period for all events. The idea is
>> only to give an estimate for the popular HW and HW cache events. For the
>> rest of the events, start from the lowest possible recommended value.
>>
>> Only the Intel event list JSON file provides the recommended SAV
>> (sample after value) for each event. The estimation is based on the
>> Intel's SAV.
>>
>> This patch implements a generic perf_freq_start_period() which impacts
>> all ARCHs.
>> If the other ARCHs don't like the start period, a per-pmu
>> (*freq_start_period) may be introduced instead. Or make it a __weak
>> function.
>> The other option would be exposing a start_period knob in the sysfs or a
>> per-event config. So the end users can set their preferred start period.
>> Please let me know your thoughts.
>>
>> SW events may need to be specially handled, which is not implemented in
>> the patch.
> 
> Sounds like a per-pmu callback is fine.  PMUs don't have the callback
> (including SW) can use 1 same as of now.

I once hope the new start period can benefit more ARCHs. But yes, a
per-pmu setting should be more practical.

Thanks,
Kan
> 
> Thanks,
> Namhyung
> 
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  kernel/events/core.c | 65 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 64 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4b855b018a79..7a028474caef 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -12017,6 +12017,69 @@ static void account_event(struct perf_event *event)
>>  	account_pmu_sb_event(event);
>>  }
>>  
>> +static u64 perf_freq_start_period(struct perf_event *event)
>> +{
>> +	int type = event->attr.type;
>> +	u64 config, factor;
>> +
>> +	/*
>> +	 * The 127 is the lowest possible recommended SAV (sample after value)
>> +	 * for a 4000 freq (default freq), according to Intel event list JSON
>> +	 * file, which is the only JSON file that provides a recommended value.
>> +	 */
>> +	factor = 127 * 4000;
>> +	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
>> +		goto end;
>> +
>> +	/*
>> +	 * The estimation of the start period in the freq mode is
>> +	 * based on the below assumption.
>> +	 *
>> +	 * For a cycles or an instructions event, 1GHZ of the
>> +	 * underlying platform, 1 IPC. The workload is idle 50% time.
>> +	 * The start period = 1,000,000,000 * 1 / freq / 2.
>> +	 *		    = 500,000,000 / freq
>> +	 *
>> +	 * Usually, the branch-related events occur less than the
>> +	 * instructions event. According to the Intel event list JSON
>> +	 * file, the SAV (sample after value) of a branch-related event
>> +	 * is usually 1/4 of an instruction event.
>> +	 * The start period of branch-related events = 125,000,000 / freq.
>> +	 *
>> +	 * The cache-related events occurs even less. The SAV is usually
>> +	 * 1/20 of an instruction event.
>> +	 * The start period of cache-related events = 25,000,000 / freq.
>> +	 */
>> +	config = event->attr.config & PERF_HW_EVENT_MASK;
>> +	if (type == PERF_TYPE_HARDWARE) {
>> +		switch (config) {
>> +		case PERF_COUNT_HW_CPU_CYCLES:
>> +		case PERF_COUNT_HW_INSTRUCTIONS:
>> +		case PERF_COUNT_HW_BUS_CYCLES:
>> +		case PERF_COUNT_HW_STALLED_CYCLES_FRONTEND:
>> +		case PERF_COUNT_HW_STALLED_CYCLES_BACKEND:
>> +		case PERF_COUNT_HW_REF_CPU_CYCLES:
>> +			factor = 500000000;
>> +			break;
>> +		case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
>> +		case PERF_COUNT_HW_BRANCH_MISSES:
>> +			factor = 125000000;
>> +			break;
>> +		case PERF_COUNT_HW_CACHE_REFERENCES:
>> +		case PERF_COUNT_HW_CACHE_MISSES:
>> +			factor = 25000000;
>> +			break;
>> +		default:
>> +			goto end;
>> +		}
>> +	}
>> +
>> +	if (type == PERF_TYPE_HW_CACHE)
>> +		factor = 25000000;
>> +end:
>> +	return DIV_ROUND_UP_ULL(factor, event->attr.sample_freq);
>> +}
>> +
>>  /*
>>   * Allocate and initialize an event structure
>>   */
>> @@ -12140,7 +12203,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>>  	hwc = &event->hw;
>>  	hwc->sample_period = attr->sample_period;
>>  	if (attr->freq && attr->sample_freq)
>> -		hwc->sample_period = 1;
>> +		hwc->sample_period = perf_freq_start_period(event);
>>  	hwc->last_period = hwc->sample_period;
>>  
>>  	local64_set(&hwc->period_left, hwc->sample_period);
>> -- 
>> 2.38.1
>>
> 
