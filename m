Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708CA1D12F9;
	Wed, 21 Aug 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239970; cv=none; b=YCCrXRT//TS9FpNmhNsB9oj0uFzpnGhRNalkzwsoeLqhWRK7erl7hwBiCEzQaBoCE3cMjXIrr6s/nuSxhE8WNzQM/aY5/AawkBiQQpqk0qnVyxhSn2jb6Gc/fCYNG4tvtRULEgVCraTOJxMi8qZyIoESWca8uTMGJ//McQ6cYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239970; c=relaxed/simple;
	bh=GAYO2SzL67TGDwj3OAWiFes7R4j2AvIw/Z/lL7qAvqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KofpiraT543cuDhSnikeiwZN0CK5orqg7ESCuexiWCpZuvMr/Bi9nXgf3VB6AVg8FqpjDBAZb/Y/IN9f7f6kdCTJd+/ew1RlzXS4d6Ha1/suwZHyNg+v1qPb3cOvJzlNOEzclXH3P4iJA5uz6tTYbrePyBMTugy/A2ECv2Ns0nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PATGGonF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PATGGonF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724239968; x=1755775968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GAYO2SzL67TGDwj3OAWiFes7R4j2AvIw/Z/lL7qAvqg=;
  b=PATGGonF0ArQO7iLctt28+bty2FUUI2yevX69n6IhhwDdu4EIha6xAG+
   chg+pNQ/P/+7BX4uSwEMBW6icuntHmnGoCHJ3k37tUoi+Q3TzAKRhRQPy
   +UJfYxXa2fnDKyI00aFPnjG0zSRxvTlhnPggT8WxC7sepfxffqPbAe7o4
   GO9RlCOkr5+nCRSI9QllHobm2RZHF5fHAUbZzdDoIgWr3tdW0+SUNynvM
   p/qqn0ZRgjMjqtqYSmgsOqtaAIA8OVfX01XjNuhqif4xst2DFgREsVhg+
   bzV6XwdIWXbvgtCi6eLSQ9SOPIhpKDxf5udlxyTkLnLb5b0JHOgFfgDLY
   Q==;
X-CSE-ConnectionGUID: SZ+/anhTRZu6S/Xnf4LDTQ==
X-CSE-MsgGUID: 5/mmafvxS/Opa3HPdy+XRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22779421"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22779421"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 04:32:48 -0700
X-CSE-ConnectionGUID: exVbdZs0TJe5XcNoG+Sk2Q==
X-CSE-MsgGUID: Og1arBsVQmKlr+HNU1f3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60918344"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.0.178])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 04:32:44 -0700
Message-ID: <f9442d81-d92d-4b91-87cf-4beb4a41de22@intel.com>
Date: Wed, 21 Aug 2024 14:32:40 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] perf/core: Fix incorrected time diff in tick
 adjust period
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240810102406.1190402-1-luogengkun@huaweicloud.com>
 <20240810102406.1190402-3-luogengkun@huaweicloud.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240810102406.1190402-3-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/08/24 13:24, Luo Gengkun wrote:
> Adrian found that there is a probability that the number of samples
> is small, which is caused by the unreasonable large sampling period.

Subject: incorrected -> incorrect

Note, the patch now needs to be re-based.

Also maybe tidy up the commit message e.g.

perf events has the notion of sampling frequency which is implemented in
software by dynamically adjusting the counter period so that samples occur
at approximately the target frequency.  Period adjustment is done in 2
places:
 - when the counter overflows (and a sample is recorded)
 - each timer tick, when the event is active
The later case is slightly flawed because it assumes that the time since
the last timer-tick period adjustment is 1 tick, whereas the event may not
have been active (e.g. for a task that is sleeping).

Fix by using jiffies to determine the elapsed time in that case.

> 
>  # taskset --cpu 0 perf record -F 1000 -e cs -- taskset --cpu 1 ./test
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.010 MB perf.data (204 samples) ]
>  # perf script
>  ...
>  test   865   265.377846:         16 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.378900:         15 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.379845:         14 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.380770:         14 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.381647:         15 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.382638:         16 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.383647:         16 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.384704:         15 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.385649:         14 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.386578:        152 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.396383:        154 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.406183:        154 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.415839:        154 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.425445:        154 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.435052:        154 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.444708:        154 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.454314:        154 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.463970:        154 cs:  ffffffff832e927b schedule+0x2b
>  test   865   265.473577:        154 cs:  ffffffff832e927b schedule+0x2b
>  ...
> 
> And the reason is perf_adjust_freq_unthr_events() calculates a value that is too
> big because it incorrectly assumes the count has accumulated only since the last
> tick, whereas it can have been much longer. To fix this problem, perf can calculate
> the tick interval by itself. For perf_adjust_freq_unthr_events we can use jiffies
> to calculate the tick interval more efficiently, as sugguested by Adrian.
> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index afb028c54f33..2708f1d0692c 100644
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
> index cad50d3439f1..309af5520f52 100644
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
> @@ -4112,7 +4113,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  {
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
> -	u64 now, period = TICK_NSEC;
> +	u64 now, period, tick_stamp;
>  	s64 delta;
>  
>  	/*
> @@ -4151,6 +4152,10 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
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
> @@ -4162,8 +4167,13 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  		 * to perf_adjust_period() to avoid stopping it
>  		 * twice.
>  		 */
> -		if (delta > 0)
> -			perf_adjust_period(event, period, delta, false);
> +		if (delta > 0) {
> +			/*
> +			 * we skip first tick adjust period
> +			 */

Could be a single line comment.

> +			if (likely(period != tick_stamp))

Kernel style is to combine if-statements if possible i.e.

		/* Skip if no delta or it is the first tick adjust period */
		if (delta > 0 && likely(period != tick_stamp))

> +				perf_adjust_period(event, period, delta, false);
> +		}
>  
>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>  	next:

