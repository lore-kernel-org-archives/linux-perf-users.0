Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1418A6BA;
	Thu, 29 Aug 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939225; cv=none; b=OoQKqijokh6Qx/8G2gWOkpjIg3O+5t3+vT4mG5ap5OCJTRG8tEReYBdn6UF2KzI1HWfbS/WSSHVypm5RKa+hpTSjvsZf5XmmvkwD7BLqgL0A4qyVrC9pfb8ci+D8BafvXXJKTnnL++OMql+WSq400mRlXZDZj/8ikPfbM1SZc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939225; c=relaxed/simple;
	bh=Bi/lW4Ecqq4cpwZ+t/li6EsGj0eXZy8hS7cLSuWw3lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVRJN3YE6tKXmb4xiUWrG37dXTNEkZzVAzgdZ6R0sU76wwjU9gAqprUJP8vsQIkVvnVHv7C8I25thErIn7hK7Z8piZinoZ0wQCr7Raszo1o7hfW90th/MhJU5BYt7PqtNVMMJva/2MAmAGnoq3iukvMVxWoHKnI28ucgbFLFIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvRnv6g1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvRnv6g1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724939224; x=1756475224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bi/lW4Ecqq4cpwZ+t/li6EsGj0eXZy8hS7cLSuWw3lk=;
  b=RvRnv6g1snlltWvFEpE3ftaeJPv4HpSxx6ns/iNdTHVExp+PLaVZy3QM
   UcIGgHJzgBFfBPfXt4ooCwELgM4ynMDIpc93fhFk2peIBZRhNXaAeGKUD
   jxcaVCv49Q2+XoP+nEIK4C8oDzYjnKXn5oLF5Qwv0xf4w4z2EN/qhcz4h
   9h2ROER+enB7mDzreIS4eM5OPPnmIoDh5MudzMzy/JhWI0KGXsnJxGK1d
   KYjBsGvMEqNlrE4ftC0IoIGPofXBF8yT9MqLOjQ4hIwvBPSg4V6UwvUum
   Ljmx2q3cqsDXq2r7GJs5aP8PdgC2g8tl9oUP9GmDvrGtkebav41saQaIt
   Q==;
X-CSE-ConnectionGUID: 860Lo7jTRhO6pJ2fNDtGsg==
X-CSE-MsgGUID: nRLNNj7lSq2eC5e1OeC3Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23671400"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23671400"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:47:03 -0700
X-CSE-ConnectionGUID: kxSeRpicQAq8q0FFRvr5nA==
X-CSE-MsgGUID: yqcSlPc3QyeW+4XHwW+ifQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="86812426"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:47:03 -0700
Received: from [10.212.67.83] (kliang2-mobl1.ccr.corp.intel.com [10.212.67.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 10EC220CFED7;
	Thu, 29 Aug 2024 06:47:00 -0700 (PDT)
Message-ID: <63bcac23-e650-41c8-9c9e-93e258355777@linux.intel.com>
Date: Thu, 29 Aug 2024 09:46:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf/core: Fix incorrect time diff in tick adjust
 period
To: Adrian Hunter <adrian.hunter@intel.com>,
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
 <30884874-848a-40ef-9e02-7cdb7b1a029a@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <30884874-848a-40ef-9e02-7cdb7b1a029a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-27 9:10 p.m., Adrian Hunter wrote:
> On 27/08/24 23:06, Liang, Kan wrote:
>>
>>
>> On 2024-08-27 1:16 p.m., Adrian Hunter wrote:
>>> On 27/08/24 19:42, Liang, Kan wrote:
>>>>
>>>>
>>>> On 2024-08-21 9:42 a.m., Luo Gengkun wrote:
>>>>> Perf events has the notion of sampling frequency which is implemented in
>>>>> software by dynamically adjusting the counter period so that samples occur
>>>>> at approximately the target frequency.  Period adjustment is done in 2
>>>>> places:
>>>>>  - when the counter overflows (and a sample is recorded)
>>>>>  - each timer tick, when the event is active
>>>>> The later case is slightly flawed because it assumes that the time since
>>>>> the last timer-tick period adjustment is 1 tick, whereas the event may not
>>>>> have been active (e.g. for a task that is sleeping).
>>>>>
>>>>
>>>> Do you have a real-world example to demonstrate how bad it is if the
>>>> algorithm doesn't take sleep into account?
>>>>
>>>> I'm not sure if introducing such complexity in the critical path is
>>>> worth it.
>>>>
>>>>> Fix by using jiffies to determine the elapsed time in that case.
>>>>>
>>>>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>>>>> ---
>>>>>  include/linux/perf_event.h |  1 +
>>>>>  kernel/events/core.c       | 11 ++++++++---
>>>>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>>> index 1a8942277dda..d29b7cf971a1 100644
>>>>> --- a/include/linux/perf_event.h
>>>>> +++ b/include/linux/perf_event.h
>>>>> @@ -265,6 +265,7 @@ struct hw_perf_event {
>>>>>  	 * State for freq target events, see __perf_event_overflow() and
>>>>>  	 * perf_adjust_freq_unthr_context().
>>>>>  	 */
>>>>> +	u64				freq_tick_stamp;
>>>>>  	u64				freq_time_stamp;
>>>>>  	u64				freq_count_stamp;
>>>>>  #endif
>>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>>> index a9395bbfd4aa..86e80e3ef6ac 100644
>>>>> --- a/kernel/events/core.c
>>>>> +++ b/kernel/events/core.c
>>>>> @@ -55,6 +55,7 @@
>>>>>  #include <linux/pgtable.h>
>>>>>  #include <linux/buildid.h>
>>>>>  #include <linux/task_work.h>
>>>>> +#include <linux/jiffies.h>
>>>>>  
>>>>>  #include "internal.h"
>>>>>  
>>>>> @@ -4120,7 +4121,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>  {
>>>>>  	struct perf_event *event;
>>>>>  	struct hw_perf_event *hwc;
>>>>> -	u64 now, period = TICK_NSEC;
>>>>> +	u64 now, period, tick_stamp;
>>>>>  	s64 delta;
>>>>>  
>>>>>  	list_for_each_entry(event, event_list, active_list) {
>>>>> @@ -4148,6 +4149,10 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>  		 */
>>>>>  		event->pmu->stop(event, PERF_EF_UPDATE);
>>>>>  
>>>>> +		tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
>>>>
>>>> Seems it only needs to retrieve the time once at the beginning, not for
>>>> each event.
>>>>
>>>> There is a perf_clock(). It's better to use it for the consistency.
>>>
>>> perf_clock() is much slower, and for statistical sampling it doesn't
>>> have to be perfect.
>>
>> Because of rdtsc?
> 
> Yes

OK. I'm not worry about it too much as long as it's only invoked once in
each tick.

> 
>>
>> If it is only used here, it should be fine. What I'm worried about is
>> that someone may use it with other timestamp in perf later. Anyway, it's
>> not a big deal.
>>
>> The main concern I have is that do we really need the patch?
> 
> The current code is wrong.
> 
>> It seems can only bring us a better guess of the period for the sleep
>> test. Then we have to do all the calculate for each tick.
> 
> Or any workload that sleeps periodically.
> 
> Another option is to remove the period adjust on tick entirely.
> Although arguably the calculation at a tick is better because
> it probably covers a longer period.

Or we may remove the period adjust on overflow.

As my understanding, the period adjust on overflow is to handle the case
while the overflow happens very frequently (< 2 ticks). It is mainly
caused by the very low start period (1).
I'm working on a patch to set a larger start period, which should
minimize the usage of the period adjust on overflow.

Anyway, based on the current code, I agree that adding a new
freq_tick_stamp should be required. But it doesn't need to read the time
for each event. I think reading the time once at the beginning should be
good enough for the period adjust/estimate algorithm.

Thanks,
Kan

> 
>>
>> Thanks,
>> Kan
>>>
>>>>
>>>> Thanks,
>>>> Kan
>>>>> +		period = tick_stamp - hwc->freq_tick_stamp;
>>>>> +		hwc->freq_tick_stamp = tick_stamp;
>>>>> +
>>>>>  		now = local64_read(&event->count);
>>>>>  		delta = now - hwc->freq_count_stamp;
>>>>>  		hwc->freq_count_stamp = now;
>>>>> @@ -4157,9 +4162,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>>>>  		 * reload only if value has changed
>>>>>  		 * we have stopped the event so tell that
>>>>>  		 * to perf_adjust_period() to avoid stopping it
>>>>> -		 * twice.
>>>>> +		 * twice. And skip if it is the first tick adjust period.
>>>>>  		 */
>>>>> -		if (delta > 0)
>>>>> +		if (delta > 0 && likely(period != tick_stamp))
>>>>>  			perf_adjust_period(event, period, delta, false);>
>>>>>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>>>
>>>
> 
> 
