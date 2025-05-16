Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2A1519AC;
	Fri, 16 May 2025 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405067; cv=none; b=m3HdM55u62gBKVUVLjVDnAI0Yu063s3IamMtYUhJwlYP28FSPAsYriHXcFpufiF8E5PNgc91bqhhSfTF2Dq0KduBpyaASmmrddp134e4+YNvOOGarSX47YrF7gHj/k0s6Jp4siAkfDkckfkbfoVkqPXklrwy1Ug70vOTH1sjpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405067; c=relaxed/simple;
	bh=OBQ87NQ92PyH+abCzIQ6vkFUgeV3C1Skp1kurt7pTxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzOcce4HvTm//U0Cf+MTg//tvYbnzWJCVWh0b8jIXQ1gvdthacAvREt8aCvYwQJmcFi4j26WnwwqPE6kO4g3OrLzTVP7idvZQNxjeMHSgpbjacpSZFWkFGgZ2z99e/SsaZNtsmrwGo0QJBFux3IQxQhKxdldatEO1zKTDQpa9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B1EF169C;
	Fri, 16 May 2025 07:17:32 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2ADD3F63F;
	Fri, 16 May 2025 07:17:43 -0700 (PDT)
Date: Fri, 16 May 2025 15:17:39 +0100
From: Leo Yan <leo.yan@arm.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com
Subject: Re: [PATCH V2 01/15] perf: Fix the throttle logic for a group
Message-ID: <20250516141739.GG412060@e132581.arm.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
 <20250514151401.2547932-2-kan.liang@linux.intel.com>
 <20250515094300.GC412060@e132581.arm.com>
 <4a44b8cb-7c73-4926-8b9f-1f63929ea48f@linux.intel.com>
 <20250516125146.GE412060@e132581.arm.com>
 <b0d1b369-3d1a-47a5-befe-9c723ed5bb79@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d1b369-3d1a-47a5-befe-9c723ed5bb79@linux.intel.com>

On Fri, May 16, 2025 at 09:28:07AM -0400, Liang, Kan wrote:

[...]

> > Just a minor suggestion. Seems to me, the parameter "start" actually
> > means "only_enable_sibling". For more readable, the function can be
> > refine as:
> > 
> > static void perf_event_unthrottle_group(struct perf_event *event,
> >                                         bool only_enable_sibling)
> > {
> > 	struct perf_event *sibling, *leader = event->group_leader;
> > 
> > 	perf_event_unthrottle(leader,
> >                 only_enable_sibling ? leader != event : true);
> >         ...
> > }
> > 
> 
> It should work for the perf_adjust_freq_unthr_events(), which only start
> the leader.

> But it's possible that the __perf_event_period() update a
> sibling, not leader.

Should not perf_event_unthrottle_group() always enable sibling events?

The only difference is how the leader event to be enabled.  It can be
enabled in perf_event_unthrottle_group() in period mode, or in
frequency mode due to a new period value is generated, the leader
event is enabled in perf_adjust_freq_unthr_events() or in
__perf_event_period().

This is why I suggested to rename the flag to only_enable_sibling:

  true: only enable sibling events
  false: enable all events (leader event and sibling events)

Or, we can rename the flag as "skip_start_event", means to skip
enabling the event specified in the argument.

> I think I can check the name to bool event_has_start.
> Is the name OK?

I am still confused for the naming "event_has_start" :)

What exactly does it mean?

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a270fcda766d..b1cb07fa9c18 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2749,13 +2749,13 @@ static void perf_event_throttle(struct
> perf_event *event)
>  	perf_log_throttle(event, 0);
>  }
> 
> -static void perf_event_unthrottle_group(struct perf_event *event, bool
> start)
> +static void perf_event_unthrottle_group(struct perf_event *event, bool
> event_has_start)
>  {
>  	struct perf_event *sibling, *leader = event->group_leader;
> 
> -	perf_event_unthrottle(leader, leader != event || start);
> +	perf_event_unthrottle(leader, event_has_start ? leader != event : true);
>  	for_each_sibling_event(sibling, leader)
> -		perf_event_unthrottle(sibling, sibling != event || start);
> +		perf_event_unthrottle(sibling, event_has_start ? sibling != event :
> true);
>  }
> 
>  static void perf_event_throttle_group(struct perf_event *event)
> @@ -4423,7 +4423,7 @@ static void perf_adjust_freq_unthr_events(struct
> list_head *event_list)
> 
>  		if (hwc->interrupts == MAX_INTERRUPTS) {
>  			perf_event_unthrottle_group(event,
> -				!event->attr.freq || !event->attr.sample_freq);
> +				(event->attr.freq && event->attr.sample_freq));
>  		}
> 
>  		if (!event->attr.freq || !event->attr.sample_freq)
> @@ -6466,7 +6466,7 @@ static void __perf_event_period(struct perf_event
> *event,
>  		 * while we already re-started the event/group.
>  		 */
>  		if (event->hw.interrupts == MAX_INTERRUPTS)
> -			perf_event_unthrottle_group(event, false);
> +			perf_event_unthrottle_group(event, true);
>  		perf_pmu_enable(event->pmu);

The logic in the updated code is correct for me.

Thanks,
Leo
