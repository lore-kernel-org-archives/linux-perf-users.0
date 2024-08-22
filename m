Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBBA1CFECF;
	Thu, 22 Aug 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351042; cv=none; b=bJ3nx8GJOeM/xRdFLwtkBOG667Qd9alSO+PrVEwdc8p24OozKHFLPSgOCWgM4A0ds4FyhsV41pwJGXo6M3cO2Kk7QSOArn4hKTVwJhC5WMvkYQ40TLC3jxscV6oNVaB23g4EDuo4SSZKULxEkgH2X6/+RU923QFlqrYvkjqkOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351042; c=relaxed/simple;
	bh=26023cvbuvY65m/DCPXCvwiUvr4ZctAqH8tU/OdXUxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMJeAF+4WXwaLx/uD1m7PmGTVyrKgQGzU64o17DUo1hH4GqSEknZtAAGkcxKT3/bAFjds23OC6TMYip8vgPQ1ujTvmg2fi8iof2+TkoHnRyapX3AMLp9rJLBtBnaHnxVPkgkx7EtiLn2xLMlJebeTaAtc4+0NYzObapy5R4k8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k59Iucmm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k59Iucmm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724351041; x=1755887041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=26023cvbuvY65m/DCPXCvwiUvr4ZctAqH8tU/OdXUxY=;
  b=k59IucmmI92lMLGh7bu7ZPN+zIuJO/wYxViPOVVr4plv7f0rDHewWieq
   N1WIwd99X11g7ygHLIHxBEZJ0HOfmnq8Gmt6qu1ve3M5G3HZgNwqSbA63
   uep3/5iWhLE9WRqoQfHlZ6KWyr1c+lyCIJIhHBsbvFBGpWpACFN6Ku/te
   1IwwIGmTRgDqOQodYRRWi7nhUOWRJuFA7ZQIWZciVDUNvxsJx8W3nzbYn
   fgYBynOA9w9y7oOgGT/hugho+zxAXzGQGFoj57gbpnhn3c48jO/k34psr
   KUAbsM13NwQVH3mkSpA/Z4Bw/zHY8MXF6oYEwbI7lHwDrieBOPpzf6oCO
   A==;
X-CSE-ConnectionGUID: u/cUA4rqS7e7t0PXD8Hp9w==
X-CSE-MsgGUID: EK32mRmJQkKNcF0dQtAcWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33948297"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="33948297"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 11:24:00 -0700
X-CSE-ConnectionGUID: YnezqHWITqiS5OfTYfA2Vw==
X-CSE-MsgGUID: srfiwqCUTT6XvafazEm8mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61552240"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.26.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 11:23:55 -0700
Message-ID: <ec8302c0-517f-418a-a00d-20022335dda7@intel.com>
Date: Thu, 22 Aug 2024 21:23:50 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf/core: Fix incorrect time diff in tick adjust
 period
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240821134227.577544-1-luogengkun@huaweicloud.com>
 <20240821134227.577544-3-luogengkun@huaweicloud.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240821134227.577544-3-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/24 16:42, Luo Gengkun wrote:
> Perf events has the notion of sampling frequency which is implemented in
> software by dynamically adjusting the counter period so that samples occur
> at approximately the target frequency.  Period adjustment is done in 2
> places:
>  - when the counter overflows (and a sample is recorded)
>  - each timer tick, when the event is active
> The later case is slightly flawed because it assumes that the time since
> the last timer-tick period adjustment is 1 tick, whereas the event may not
> have been active (e.g. for a task that is sleeping).
> 
> Fix by using jiffies to determine the elapsed time in that case.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 11 ++++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1a8942277dda..d29b7cf971a1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -265,6 +265,7 @@ struct hw_perf_event {
>  	 * State for freq target events, see __perf_event_overflow() and
>  	 * perf_adjust_freq_unthr_context().
>  	 */
> +	u64				freq_tick_stamp;
>  	u64				freq_time_stamp;
>  	u64				freq_count_stamp;
>  #endif
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a9395bbfd4aa..86e80e3ef6ac 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -55,6 +55,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/buildid.h>
>  #include <linux/task_work.h>
> +#include <linux/jiffies.h>
>  
>  #include "internal.h"
>  
> @@ -4120,7 +4121,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  {
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
> -	u64 now, period = TICK_NSEC;
> +	u64 now, period, tick_stamp;
>  	s64 delta;
>  
>  	list_for_each_entry(event, event_list, active_list) {
> @@ -4148,6 +4149,10 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  		 */
>  		event->pmu->stop(event, PERF_EF_UPDATE);
>  
> +		tick_stamp = jiffies64_to_nsecs(get_jiffies_64());
> +		period = tick_stamp - hwc->freq_tick_stamp;
> +		hwc->freq_tick_stamp = tick_stamp;
> +
>  		now = local64_read(&event->count);
>  		delta = now - hwc->freq_count_stamp;
>  		hwc->freq_count_stamp = now;
> @@ -4157,9 +4162,9 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  		 * reload only if value has changed
>  		 * we have stopped the event so tell that
>  		 * to perf_adjust_period() to avoid stopping it
> -		 * twice.
> +		 * twice. And skip if it is the first tick adjust period.
>  		 */
> -		if (delta > 0)
> +		if (delta > 0 && likely(period != tick_stamp))
>  			perf_adjust_period(event, period, delta, false);
>  
>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);

