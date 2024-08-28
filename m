Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B918030;
	Wed, 28 Aug 2024 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819014; cv=none; b=VgCC9t+Mb8bzMtsSiqAP+1Dj3wwOL5nrOXqXF3LLeErXG5bDtWlsf9NDdWe3InhsZtaNuC7ibnEBcixSeBjw4kFTGHOwxBj5dvBNSzii61YyP9W43o8hekT0gludOo7+m+uNIJV2rbl7u230RitOZSelTt3awg/426quVudRN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819014; c=relaxed/simple;
	bh=oZXMHY0Ir9bJW6K50Ayc29AepgtJXxT2ZRal/4ALC0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQ7ZaDiSybVpOzcpjeknanX9fRKE2xREh5Wuva8MBkKakAdYjUQwtrnEPofpyGG7YE+QJ/vTd9d+MzJO9FQM0OJf1nSjDWh1Ru7GBSDcn9Vm++kuh4qn9tSs/JDsfbfSZPZ9iW9ROf/jii0Uy3LXoIIoOTRf6zsevtOfIna53uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTVgW4my; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTVgW4my"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724819012; x=1756355012;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oZXMHY0Ir9bJW6K50Ayc29AepgtJXxT2ZRal/4ALC0M=;
  b=kTVgW4myztR4omxDjGo7kWq0UdStIdV57liMJaIGOZ4xPAtOf+bzpHhd
   y/9nlICxgrdmPZZKfl+z9HSf7KYHDq4FTHW+1qhfzk1iRpUEOe+fTiISo
   JkMTABF+d4rAyLix1YaD4YKUZiBrVJcN7vGrMiHMwz2zNK2NPTC/BfMPw
   CSotaPDVFlWxYU+QTpx1e7VY7G+1A/rbOGIcQKttOE1tb9HffznCXGgJT
   aO/lmogzeB+4owsAIVP+4D/HqqWgov6O+voOFof3LgM04RR57ybFxZ2oq
   P8CFsdIZ+nlb/0Esok519bdJe5NhUVpgh6NpJD1BUOK+7C4mBPNIYZvSp
   g==;
X-CSE-ConnectionGUID: 1ZMeUToCTdiRZQnn0LpgUw==
X-CSE-MsgGUID: fRUMHisVRo6MF+PaRA1Mvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="13252924"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="13252924"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 21:23:31 -0700
X-CSE-ConnectionGUID: VPguRP2aSCOhcFocL94WEQ==
X-CSE-MsgGUID: XYZeB3RlRs+/SLgnJFXKHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63796480"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 21:23:28 -0700
Message-ID: <30884874-848a-40ef-9e02-7cdb7b1a029a@intel.com>
Date: Wed, 28 Aug 2024 04:10:14 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf/core: Fix incorrect time diff in tick adjust
 period
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240821134227.577544-1-luogengkun@huaweicloud.com>
 <20240821134227.577544-3-luogengkun@huaweicloud.com>
 <c5b73b4f-b257-4847-a213-741889d89159@linux.intel.com>
 <c1b2a1b6-8b6d-40b4-84d4-d007c024fc84@intel.com>
 <e15110af-c2f2-47ff-99fd-649cf5b46e46@linux.intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <e15110af-c2f2-47ff-99fd-649cf5b46e46@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/24 23:06, Liang, Kan wrote:
> 
> 
> On 2024-08-27 1:16 p.m., Adrian Hunter wrote:
>> On 27/08/24 19:42, Liang, Kan wrote:
>>>
>>>
>>> On 2024-08-21 9:42 a.m., Luo Gengkun wrote:
>>>> Perf events has the notion of sampling frequency which is implemented in
>>>> software by dynamically adjusting the counter period so that samples occur
>>>> at approximately the target frequency.  Period adjustment is done in 2
>>>> places:
>>>>  - when the counter overflows (and a sample is recorded)
>>>>  - each timer tick, when the event is active
>>>> The later case is slightly flawed because it assumes that the time since
>>>> the last timer-tick period adjustment is 1 tick, whereas the event may not
>>>> have been active (e.g. for a task that is sleeping).
>>>>
>>>
>>> Do you have a real-world example to demonstrate how bad it is if the
>>> algorithm doesn't take sleep into account?
>>>
>>> I'm not sure if introducing such complexity in the critical path is
>>> worth it.
>>>
>>>> Fix by using jiffies to determine the elapsed time in that case.
>>>>
>>>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>>>> ---
>>>>  include/linux/perf_event.h |  1 +
>>>>  kernel/events/core.c       | 11 ++++++++---
>>>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>> index 1a8942277dda..d29b7cf971a1 100644
>>>> --- a/include/linux/perf_event.h
>>>> +++ b/include/linux/perf_event.h
>>>> @@ -265,6 +265,7 @@ struct hw_perf_event {
>>>>  	 * State for freq target events, see __perf_event_overflow() and
>>>>  	 * perf_adjust_freq_unthr_context().
>>>>  	 */
>>>> +	u64				freq_tick_stamp;
>>>>  	u64				freq_time_stamp;
>>>>  	u64				freq_count_stamp;
>>>>  #endif
>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>> index a9395bbfd4aa..86e80e3ef6ac 100644
>>>> --- a/kernel/events/core.c
>>>> +++ b/kernel/events/core.c
>>>> @@ -55,6 +55,7 @@
>>>>  #include <linux/pgtable.h>
>>>>  #include <linux/buildid.h>
>>>>  #include <linux/task_work.h>
>>>> +#include <linux/jiffies.h>
>>>>  
>>>>  #include "internal.h"
>>>>  
>>>> @@ -4120,7 +4121,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>  {
>>>>  	struct perf_event *event;
>>>>  	struct hw_perf_event *hwc;
>>>> -	u64 now, period = TICK_NSEC;
>>>> +	u64 now, period, tick_stamp;
>>>>  	s64 delta;
>>>>  
>>>>  	list_for_each_entry(event, event_list, active_list) {
>>>> @@ -4148,6 +4149,10 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>  		 */
>>>>  		event->pmu->stop(event, PERF_EF_UPDATE);
>>>>  
>>>> +		tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
>>>
>>> Seems it only needs to retrieve the time once at the beginning, not for
>>> each event.
>>>
>>> There is a perf_clock(). It's better to use it for the consistency.
>>
>> perf_clock() is much slower, and for statistical sampling it doesn't
>> have to be perfect.
> 
> Because of rdtsc?

Yes

> 
> If it is only used here, it should be fine. What I'm worried about is
> that someone may use it with other timestamp in perf later. Anyway, it's
> not a big deal.
> 
> The main concern I have is that do we really need the patch?

The current code is wrong.

> It seems can only bring us a better guess of the period for the sleep
> test. Then we have to do all the calculate for each tick.

Or any workload that sleeps periodically.

Another option is to remove the period adjust on tick entirely.
Although arguably the calculation at a tick is better because
it probably covers a longer period.

> 
> Thanks,
> Kan
>>
>>>
>>> Thanks,
>>> Kan
>>>> +		period = tick_stamp - hwc->freq_tick_stamp;
>>>> +		hwc->freq_tick_stamp = tick_stamp;
>>>> +
>>>>  		now = local64_read(&event->count);
>>>>  		delta = now - hwc->freq_count_stamp;
>>>>  		hwc->freq_count_stamp = now;
>>>> @@ -4157,9 +4162,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>  		 * reload only if value has changed
>>>>  		 * we have stopped the event so tell that
>>>>  		 * to perf_adjust_period() to avoid stopping it
>>>> -		 * twice.
>>>> +		 * twice. And skip if it is the first tick adjust period.
>>>>  		 */
>>>> -		if (delta > 0)
>>>> +		if (delta > 0 && likely(period != tick_stamp))
>>>>  			perf_adjust_period(event, period, delta, false);>
>>>>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>>
>>

