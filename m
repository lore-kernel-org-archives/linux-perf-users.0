Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B351AC247;
	Mon, 17 Jun 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631760; cv=none; b=DGfJq+d0guYjm7qhz4oO9EHQQddLuj1qNHuBvXgJ9TORuMBMp0LyDe+WH+3bkgbzzQDW98wYr00gFPwSXoip/mQykqPl1ilae+VIeeMfmIkusOt4+n61+G4QBa8e2xVWBpclGao12Zya+fQsstPwyypwkYZU0sKYCfrrYShkl5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631760; c=relaxed/simple;
	bh=jAzokita4ObBVuqP6v9/pCm7QzuPOXyw106mBV/23Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEgBr0GvM21ptWZYwY28+L4heCZBmnryBUo6ID+8Tl/XkT+Y2KneyWCrAQrP1ZGJUVHtge3y6rNtnmCpdOD/7UgjlqPqLvRwVtDNVZqlskaZS7w1WZu8vsiR+SxGMkTodtXqeHiLijy7B4XcF0+W/SSYT1itD22Ftk+EnHMfm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpAyeIw3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpAyeIw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718631758; x=1750167758;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jAzokita4ObBVuqP6v9/pCm7QzuPOXyw106mBV/23Ck=;
  b=VpAyeIw3OdpLPXod5M+S96OkWityDjNtJVoQiMev3Pck472tNeqn2zQb
   zgAyV7rIRdBf6384tGiwX3PJRKPg2EHeNpGWv7JvFzFzg7urTZ0MF5a/3
   R9tpo6b8PTpH7G+ovu9u+blhRiSqnTi3zowcG6kFKh7GP1agLemCdmHZe
   y8MTdD3RmfEe8i9QQoAt9MtYaSzO3ndZ+eAtpYqMALtXQQ7c8C5KFZSwO
   97FsqRYw7hwag6ITSElDnA7/EY7UOtjEa0uLBhOdQ5CqNgYtURq4C6hlQ
   8Qk/7m38VM6PUM7rDPaKeO4aZq/fYJYkj/YleNYyGjEOCIOzVDXdzMNgi
   w==;
X-CSE-ConnectionGUID: bwpA3hfTRaSL+O0+WqlJ+Q==
X-CSE-MsgGUID: vY5bH/9vQJSOg6c74npNvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26140411"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="26140411"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 06:42:24 -0700
X-CSE-ConnectionGUID: cyDZ2+c4Q5yMw2iNvTNnbw==
X-CSE-MsgGUID: MEU7Mh7STxq2kwapeOkp4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41131257"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 06:42:21 -0700
Message-ID: <7c667516-b5a2-48e1-afd8-e45906e69053@intel.com>
Date: Mon, 17 Jun 2024 16:42:13 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/2] perf/core: Fix incorrected time diff in
 tick adjust period
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417115446.2908769-1-luogengkun@huaweicloud.com>
 <20240417115446.2908769-3-luogengkun@huaweicloud.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240417115446.2908769-3-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/24 14:54, Luo Gengkun wrote:
> Adrian found that there is a probability that the number of samples
> is small, which is caused by the unreasonable large sampling period.
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
> It seems that the Timer Interrupts is not coming every TICK_NSEC when

No, the period is not adjusted unless the event is active i.e. scheduled in.
So an event in a task context where the task sleeps a lot will
likely not be adjusted every tick.

> system is idle. For example, counter increase n during 2 * TICK_NSEC,
> and it call perf_adjust_period using n and TICK_NSEC, so the final period
> we calculated will be bigger than expected one. What's more, if the
> the overflow time is larger than 2 * TICK_NSEC we cannot tune the period
> using __perf_event_account_interrupt. To fix this problem, perf can
> calculate the tick interval by itself.

Yes, the period can get stuck being too big:

	perf_adjust_freq_unthr_events() calculates a value that is
	too big because it incorrectly assumes the count has
	accumulated only since the last tick, whereas it can have
	been much longer.

	__perf_event_account_interrupt() has an unexplained limit
	(2*TICK_NSEC) on the count delta, and won't adjust the
	period if that is exceeded.

> 
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 15 ++++++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
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
> index cad50d3439f1..0f2025d631aa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4112,7 +4112,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  {
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
> -	u64 now, period = TICK_NSEC;
> +	u64 now, period, tick_stamp;
>  	s64 delta;
>  
>  	/*
> @@ -4151,6 +4151,10 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  		 */
>  		event->pmu->stop(event, PERF_EF_UPDATE);
>  
> +		tick_stamp = perf_clock();

Perhaps jiffies would work just as well, but be
more efficient.

> +		period = tick_stamp - hwc->freq_tick_stamp;
> +		hwc->freq_tick_stamp = tick_stamp;
> +
>  		now = local64_read(&event->count);
>  		delta = now - hwc->freq_count_stamp;
>  		hwc->freq_count_stamp = now;
> @@ -4162,8 +4166,13 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
>  		 * to perf_adjust_period() to avoid stopping it
>  		 * twice.
>  		 */
> -		if (delta > 0)
> -			perf_adjust_period(event, period, delta, false);
> +		if (delta > 0) {
> +			/*
> +			 * we skip first tick adjust period
> +			 */
> +			if (likely(period != tick_stamp))
> +				perf_adjust_period(event, period, delta, false);
> +		}
>  
>  		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
>  	next:

