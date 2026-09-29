Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2A41834B
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663691; cv=none; b=rP5gK3i8WZ7P3Yv4Hebf7qkvsbzqs6g2OD+L0fWClcqGYquhPG7yFv+u31a5cjihEsicjhsSqC9fvXCiryLZ/8SvnuNJt7njWDZuzTpRJH0fXtln+lwBBkVNJBbBTuArODxXWJzaxA5PO4sr3p9EYKCuYW7izwf3k/H1MzWVsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663691; c=relaxed/simple;
	bh=Moxs0ukw5y1LSHaGkscooTx2ugOE4K9XkzJo/X4VZSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNT/ZB5j/7QK9y9AjpsukxioDFku5AHFkdGF5/U5zRe6f8ImLxj/RDvOFXp0Gg/iZyTpdu4TdDdz1te0PwZm4icHhVse1Hp827kCp4bpRc+a5R6GL6BcVDLs+JlHWyI28GFwR80+pvHNPwK+XZCczozWcl/xEb9FLZRCtliTtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEEDPUOu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEEDPUOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790663689; x=1822199689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Moxs0ukw5y1LSHaGkscooTx2ugOE4K9XkzJo/X4VZSU=;
  b=cEEDPUOu7kn0s4Ge3o6L4yUlSWN48Hl3ej4hXy33OD/yAHocVIdnjnbL
   os6fgQ8Np1/WhJeou+rCWKfKSE5+X1BkKgXPLT0vkbjGyNBY08bKRyyMd
   kDkJkz3ORrIW10w1HCBR6BXt1KD3hwz6ftDj7g+nzbCDljk9M2iksGMRY
   RjdeobrAkJJC28V4fGFrtA4MU7bqPdf6pIhvDtxqUQZ4snLSFeyeishiz
   DjTZe9wtD3EZS8vYj4tNYzZFvPp2mxgRYsuQTXJJwiTX02mXWwi/US2Q5
   HMVvz89w4at99vLbTzODgM9TCYEY8UbggOpwaCIYHoY1sXijfboYKfmyR
   A==;
X-CSE-ConnectionGUID: FPA3a3npRSS/MUJrJNNEXg==
X-CSE-MsgGUID: hIGL8UqcR/aggqzk5v6tRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="93864301"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="93864301"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 23:34:48 -0700
X-CSE-ConnectionGUID: n2Bd7n80TBCFF0qVK5yt0A==
X-CSE-MsgGUID: nx1NFhmJTrWjvJJPZiAt9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="304783022"
Received: from unknown (HELO [10.238.1.105]) ([10.238.1.105])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 23:34:47 -0700
Message-ID: <b0d68c0e-3787-4a98-be13-408d84daafb7@linux.intel.com>
Date: Tue, 29 Sep 2026 14:34:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] perf/core: Add event_caps dependency flags
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-15-dapeng1.mi@linux.intel.com>
 <20260928080537.5212D1F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260928080537.5212D1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/28/2026 4:05 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] perf/core: Userspace-triggerable WARN_ON_ONCE via retained event_caps in promoted group leader
> --
>
> commit ee7032954fb61d16c3b9fceb7931ce04cf4b8852
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>     
> perf/core: Add event_caps dependency flags
>     
> This commit adds two new event capability flags, PERF_EV_CAP_RELIED_ON and
> PERF_EV_CAP_RELIANT, to track dependencies between perf events in a group.
> When a relied-on event is detached, all reliant events are scheduled out
> and transitioned to an ERROR state.
>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index de05df65ab3d0..55db0ad8b93a0 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2349,13 +2349,12 @@ static void perf_promote_sibling_to_leader(struct perf_event *sibling,
>>  					   int group_caps)
>>  {
>>  	/*
>> -	 * Events that have PERF_EV_CAP_SIBLING require being part of
>> -	 * a group and cannot exist on their own, schedule them out
>> -	 * and move them into the ERROR state. Also see
>> -	 * _perf_event_enable(), it will not be able to recover this
>> -	 * ERROR state.
>> +	 * Events with PERF_EV_CAP_SIBLING or PERF_EV_CAP_RELIANT
>> +	 * must stay in a group or depend on another event in the
>> +	 * group; otherwise schedule them out and move them to ERROR.
>> +	 * _perf_event_enable() cannot recover from this state.
>>  	 */
>> -	if (sibling->event_caps & PERF_EV_CAP_SIBLING)
>> +	if (sibling->event_caps & (PERF_EV_CAP_SIBLING | PERF_EV_CAP_RELIANT))
>>  		__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
>>  
>>  	sibling->group_leader = sibling;
>>  	sibling->group_caps = group_caps;
> [Severity: High]
> Does this code need to clear PERF_EV_CAP_RELIED_ON and PERF_EV_CAP_RELIANT
> from sibling->event_caps when promoting the sibling to a singleton group
> leader?
>
> Since the flags are retained, a newly promoted leader can still carry
> PERF_EV_CAP_RELIANT.

Per my understanding, the event->event_caps should only be initialized at
the event creation and can't be modified from then. The event->event_caps
carries the specific capabilities of the event, it should not be changed or
cleared.

Besides, if PERF_EV_CAP_RELIANT is cleared for the metric events, the
metric events could be incorrectly enabled in _perf_event_enable().



>
>> @@ -2371,6 +2370,43 @@ static void perf_promote_sibling_to_leader(struct perf_event *sibling,
>>  	perf_event__header_size(sibling);
>>  }
>>  
>> +static void perf_group_disable_reliants(struct perf_event *event)
>> +{
>> +	struct perf_event *leader = event->group_leader;
>> +	struct perf_event *sibling, *tmp;
>> +	struct perf_event_context *ctx = event->ctx;
>> +	u32 mask = PERF_EV_CAP_RELIED_ON | PERF_EV_CAP_RELIANT;
>> +
>> +	if (!(event->event_caps & PERF_EV_CAP_RELIED_ON))
>> +		return;
>> +
>> +	/* Group leader should not carry PERF_EV_CAP_RELIED_ON. */
>> +	WARN_ON_ONCE(leader->event_caps & PERF_EV_CAP_RELIED_ON);
>> +	/* Group leader should not carry PERF_EV_CAP_RELIANT. */
>> +	WARN_ON_ONCE(leader->event_caps & PERF_EV_CAP_RELIANT);
> [Severity: High]
> Can userspace trigger this WARN_ON_ONCE because of the retained caps when
> siblings are promoted to leaders?
>
> If a user creates a perf event group with a non-slots leader, a slots
> sibling, and a metric sibling, the metric sibling can acquire
> PERF_EV_CAP_RELIANT.
>
> When the user closes the leader, the metric sibling is promoted to its
> own group leader, retaining PERF_EV_CAP_RELIANT and entering
> PERF_EVENT_STATE_ERROR.
>
> If the user then opens a new slots sibling and a new metric sibling under
> this promoted leader, and finally closes the new slots sibling, won't
> perf_group_disable_reliants() hit this WARN_ON_ONCE because the leader
> still holds the reliant flag? On systems with panic_on_warn enabled,
> this could cause a kernel panic.

It's a possible case, but won't it justify why the WARN_ON_ONCE() is
needed? Once such incorrect cases occur, users would be warned.

Thanks.


>
