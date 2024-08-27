Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083151BFE02;
	Tue, 27 Aug 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778998; cv=none; b=GI428mb1zhqriCeWoGGHDvz3eZPCYoScaJ+X3So8fj74E/BudE93cPkuRRJoxBhxFjUmByFe1cdVmyGizijVlCe8xvc+B0O2DyThEWPhTABC2+AkgTr9NbGYnVt+keDdjgcN4BPdQp9BEkjfHSU6gBiQ1vg6Hyij8U66VrF3RJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778998; c=relaxed/simple;
	bh=ybyaaJN8Ezc3BZXgTQNSL2uEfvM1Dlv3ok1IWbwNnAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocCPlgENCAxLbKg39oWqnoWnt9aLFe12pe0cHFwMt05KXbqNqTriJNwBqGx0wGJTxLYeuVVIHh/DxPn6HR8pmNjiHmozRSyB/p+iUL7X/up38CNdHgi26YOZbc4JSM4soZ3d21GI78hKfRSZdQnTQ8aWkpcNqndk7troYsP/drU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkXWF0kI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkXWF0kI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724778996; x=1756314996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ybyaaJN8Ezc3BZXgTQNSL2uEfvM1Dlv3ok1IWbwNnAo=;
  b=dkXWF0kIsaYKAHWRCxr0xI7As+O60De7VnhLVbvbD7MbIBo31v+xHAPT
   dIJoqKToZm3x3vZpkWq0TzuTSzjN2lnFt+9MdJh3k+Mrt3ycD/1I02wuD
   YufvS+k0I170ZHBNcy/sQn4HSzmk1DJ2ao5SaqXboYcmgX/tCsCtyBCcf
   8pcZTKOWYt8ExgDMu4yH86/4wpdRPhoEbH/pgZhPLbjuQCktzKp/k/PTB
   a3ueNyRbU0Uik/uv5d6oIm4KAoUR94AfuIiItUmVl92SdbGIFDiprQzq0
   UEw3bca5OrP2vHas7S8/1Z3vcsgKRR6C3VvfGCFfDUSfZgzRoty0ya/3U
   A==;
X-CSE-ConnectionGUID: FPD1qXPQQLqM/TpyF1SfFw==
X-CSE-MsgGUID: wRmC/k4JQnWWZ2L4An3syA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27066794"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27066794"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 10:16:35 -0700
X-CSE-ConnectionGUID: qQHn9pcERfacMrj4jS9CZQ==
X-CSE-MsgGUID: 4ru+uKheT/uUQ6n0+5MB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67823787"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 10:16:31 -0700
Message-ID: <c1b2a1b6-8b6d-40b4-84d4-d007c024fc84@intel.com>
Date: Tue, 27 Aug 2024 20:16:15 +0300
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
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <c5b73b4f-b257-4847-a213-741889d89159@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/08/24 19:42, Liang, Kan wrote:
> 
> 
> On 2024-08-21 9:42 a.m., Luo Gengkun wrote:
>> Perf events has the notion of sampling frequency which is implemented in
>> software by dynamically adjusting the counter period so that samples occur
>> at approximately the target frequency.  Period adjustment is done in 2
>> places:
>>  - when the counter overflows (and a sample is recorded)
>>  - each timer tick, when the event is active
>> The later case is slightly flawed because it assumes that the time since
>> the last timer-tick period adjustment is 1 tick, whereas the event may not
>> have been active (e.g. for a task that is sleeping).
>>
> 
> Do you have a real-world example to demonstrate how bad it is if the
> algorithm doesn't take sleep into account?
> 
> I'm not sure if introducing such complexity in the critical path is
> worth it.
> 
>> Fix by using jiffies to determine the elapsed time in that case.
>>
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>> ---
>>  include/linux/perf_event.h |  1 +
>>  kernel/events/core.c       | 11 ++++++++---
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 1a8942277dda..d29b7cf971a1 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -265,6 +265,7 @@ struct hw_perf_event {
>>  	 * State for freq target events, see __perf_event_overflow() and
>>  	 * perf_adjust_freq_unthr_context().
>>  	 */
>> +	u64				freq_tick_stamp;
>>  	u64				freq_time_stamp;
>>  	u64				freq_count_stamp;
>>  #endif
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index a9395bbfd4aa..86e80e3ef6ac 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -55,6 +55,7 @@
>>  #include <linux/pgtable.h>
>>  #include <linux/buildid.h>
>>  #include <linux/task_work.h>
>> +#include <linux/jiffies.h>
>>  
>>  #include "internal.h"
>>  
>> @@ -4120,7 +4121,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>  {
>>  	struct perf_event *event;
>>  	struct hw_perf_event *hwc;
>> -	u64 now, period = TICK_NSEC;
>> +	u64 now, period, tick_stamp;
>>  	s64 delta;
>>  
>>  	list_for_each_entry(event, event_list, active_list) {
>> @@ -4148,6 +4149,10 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>  		 */
>>  		event->pmu->stop(event, PERF_EF_UPDATE);
>>  
>> +		tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
> 
> Seems it only needs to retrieve the time once at the beginning, not for
> each event.
> 
> There is a perf_clock(). It's better to use it for the consistency.

perf_clock() is much slower, and for statistical sampling it doesn't
have to be perfect.

> 
> Thanks,
> Kan
>> +		period = tick_stamp - hwc->freq_tick_stamp;
>> +		hwc->freq_tick_stamp = tick_stamp;
>> +
>>  		now = local64_read(&event->count);
>>  		delta = now - hwc->freq_count_stamp;
>>  		hwc->freq_count_stamp = now;
>> @@ -4157,9 +4162,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>>  		 * reload only if value has changed
>>  		 * we have stopped the event so tell that
>>  		 * to perf_adjust_period() to avoid stopping it
>> -		 * twice.
>> +		 * twice. And skip if it is the first tick adjust period.
>>  		 */
>> -		if (delta > 0)
>> +		if (delta > 0 && likely(period != tick_stamp))
>>  			perf_adjust_period(event, period, delta, false);>
>>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);

