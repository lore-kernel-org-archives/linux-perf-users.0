Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1573911DF
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665454; cv=none; b=jCDFAYplh1KVWZ/js/k9COsPZSOxg744ay8uS/+We2c8F9vCpzTXsszGl3bBC5YXHkXQmybyeh4gVIjNWw49yjv4sOFfseDq371T/Ho7gTVF6ygSbPaIc0M6+3F2blbm462+N1A3ufSLoO53iZBVm4Dlz+tEYQHWt//Xu5lt/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665454; c=relaxed/simple;
	bh=x0OdSZf4GBSNPG1Ne0YPfBWU+Gty8EDrFcBQfTu5NBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoGuCVF+LGSW8WXCzN3H0giuldY71gv4q6er71LJvxcvGsU3s3Gg4HWTBijOBPwNGQXGHK11CWact1kNGRsSiACvEPeNmAu08MQS9lZ+s/EvnRz/2DaPGSSJb6EdgDr8Ed8qJJZ7/hFNW5AzFd8GPz1LCDBI8+Znw0DPpLl7B8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a21jOGzC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a21jOGzC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790665451; x=1822201451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x0OdSZf4GBSNPG1Ne0YPfBWU+Gty8EDrFcBQfTu5NBI=;
  b=a21jOGzCoUC3G31n91YtTB6MA8eEB1+QGSVcgXhSeQVhqxB0V5XRD624
   0k481jahkU+4KPqEXsipZKcrupoBmLzkzCe5vFSwLw5POFMxJEJWABj0K
   fvhSwqGhyNrFuP4Nh9exL+PnJvCYV39A1sydL+mb4UcKqJANISeRZqKzZ
   8kqZ9M3QLs7PpCD6HQLglyTtN2mvyd/7DS1nZY2QGhxeF357WaCcVNmgC
   kRRyiJO3yWe/shLtNjBS/zxzeTJcwrgieGzz9ETflBu+ddTpppJ2qdhDi
   LgScZyzhamAEAoeNZ5oG8rHhmq8+l1I/wAsqAZgigFyd+qyGJMHoR/cFM
   Q==;
X-CSE-ConnectionGUID: 8bXaAm8nQtuzNRNmsCv2OA==
X-CSE-MsgGUID: HSNDYCxtQbigFIxa4amW6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94258090"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="94258090"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:04:10 -0700
X-CSE-ConnectionGUID: l0pvNaKFTzaq3fpfoSaoYQ==
X-CSE-MsgGUID: zDcZfHHFRjKBWgyCQC0yLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="301570536"
Received: from unknown (HELO [10.238.1.105]) ([10.238.1.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:04:09 -0700
Message-ID: <863010a8-1f71-4b87-8ae9-1c271b7e139e@linux.intel.com>
Date: Tue, 29 Sep 2026 15:04:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] perf/x86/intel: Allow Topdown metrics with a
 non-leader slots event
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-16-dapeng1.mi@linux.intel.com>
 <20260928081227.314C71F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260928081227.314C71F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/28/2026 4:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] perf: lockless sibling traversal and modification in intel_pmu_hw_config()
> - [Medium] perf: state leak on active slots event if metric event allocation fails
> --
>
> commit 35318b4bb32158e6a24c6de2f1ef286a1ed4b438
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Subject: perf/x86/intel: Allow Topdown metrics with a non-leader slots event
>
> This commit relaxes the requirement for the slots event to be the group leader
> for Topdown metrics, allowing metric events to validate constraints against a
> valid slots sibling instead. It incrementally validates groups and sets
> reliance capabilities so detaching a non-leader slots event triggers dependent
> metric events into an error state.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 6cc1462c9c82d..9025f29f625d4 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>> @@ -5300,30 +5300,53 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  
>>  		if (is_available_metric_event(event)) {
>>  			struct perf_event *leader = event->group_leader;
>> +			struct perf_event *slots = NULL;
>> +			struct perf_event *sibling;
>>  
>>  			/* The metric events don't support sampling. */
>>  			if (is_sampling_event(event))
>>  				return -EINVAL;
>>  
>> -			/* The metric events require a slots group leader. */
>> -			if (!is_slots_event(leader))
>> +			/*
>> +			 * intel_pmu_hw_config() cannot tell whether the current
>> +			 * event is the last one in the group. Require the slots
>> +			 * event to appear before all metric events.
>> +			 */
>> +			if (is_slots_event(leader)) {
>> +				slots = leader;
>> +			} else if (leader->nr_siblings) {
>> +				for_each_sibling_event(sibling, leader) {
> [Severity: High]
> When a user calls perf_event_open() to add a metric event to an already
> active hardware group, this is executed without holding the group leader's
> ctx->mutex.
>
> Does traversing the sibling_list without the context lock here cause a data
> race? A concurrent thread closing a sibling file descriptor triggers
> perf_group_detach(), which mutates the list and could lead to list
> corruption or a use-after-free.
>
> Additionally, since for_each_sibling_event() invokes
> lockdep_assert_event_ctx(), will this trigger a WARN_ON_ONCE because the
> required lock is not held?

No, the ctx->mutex is held for sibling events. perf_event_ctx_lock_nested()
would acquire ctx->mutex before calling pmu->event_init().


>
>> +					if (is_slots_event(sibling)) {
>> +						slots = sibling;
>> +						break;
>> +					}
>> +				}
>> +			}
> [ ... ]
>> +			if (slots == leader) {
>> +				event->event_caps |= PERF_EV_CAP_SIBLING;
>> +			} else {
>> +				slots->event_caps |= PERF_EV_CAP_RELIED_ON;
>> +				event->event_caps |= PERF_EV_CAP_RELIANT;
>> +			}
>>  			/*
>>  			 * Only once we have a METRICs sibling do we
>>  			 * need TopDown magic.
>>  			 */
>> -			leader->hw.flags |= PERF_X86_EVENT_TOPDOWN;
>> -			event->hw.flags  |= PERF_X86_EVENT_TOPDOWN;
>> +			slots->hw.flags |= PERF_X86_EVENT_TOPDOWN;
> [Severity: High]
> Does locklessly modifying the active slots event's event_caps and hw.flags
> cause issues for running events? Setting PERF_X86_EVENT_TOPDOWN on a
> running event changes its NMI read path to intel_update_topdown_event.
> Because its saved_slots was uninitialized (0), this could subtract 0 from
> the raw MSR value, resulting in double-counting the event.

It's just a risk in theory, it should never really happen. slots event and
topdown metric events must be in a group and all events should be enabled
and scheduled at the same time, so it's impossible that we see a slots is
running but the topdown metric events in same group are still in creation.


>
> [Severity: Medium]
> What happens to these modifications if the new metric event allocation
> fails later on (for instance, in perf_allow_cpu(),
> security_perf_event_alloc(), or perf_cgroup_connect())?
>
> Since there is no rollback mechanism in the error path to restore the slots
> event, it appears to permanently leak state. Being incorrectly flagged with
> PERF_EV_CAP_RELIED_ON and PERF_X86_EVENT_TOPDOWN permanently alters its
> NMI read path and breaks its sampling capabilities, even though the
> dependent metric event was never successfully created.

If an event member fails to pass the validation, but the other members in
the group still could success, we should not roll back the setting if a
member fails to pass the validation. 

Thanks.


>
