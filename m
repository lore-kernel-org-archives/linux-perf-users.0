Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459D27FD43
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2026 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518151; cv=none; b=tpey3jDmojK/Ucf6HvCuOx9jnLb804tlCNpBDL4pFtf5LMKWMArvVufIvjk395YVqBDrDZYLvktUDqkYI0ekf7UBVMyYDJe8g11NLrx1zBJfbOkB0KLIQjDoMTpYyKKfgHgkMpcXrmx3Vml/ztj+IfdrvZsc8tCAK4t5JYD3voY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518151; c=relaxed/simple;
	bh=BYmwJD7zo2NtQ1WyZhGzr4eG9Y110Jdrf/bIfOutAIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/ecLd3J3B3oxum22Smg7X6GONCbMQBRAdhc9eMxuyiBvoP3lh+WIOPE/oAgv4x6Ocub4G/3oWQSRgsaUfzGY6xXxiU91TuxP14nhw9NCJ0/i6rX6FX7KzDvubGvprTuCPetDrll7hReViqc4XlG80tlMZteM8seKOM64HDpOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ubq8cul4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ubq8cul4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777518149; x=1809054149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BYmwJD7zo2NtQ1WyZhGzr4eG9Y110Jdrf/bIfOutAIM=;
  b=Ubq8cul4qBmdnCMJrRH29ackCjvMCsNO1TlYvXyU/JLeuCeDurpxuEGq
   GLrQrn6whB/69378XP1Ym0y5pAaoW7rPgvo6j1hj44m54DYJSnxcu4O3N
   RW8NtOwVzXvfTbZNj+MX+9PqWXwFZZUADidjmi1ZeK4WykB8ZQsMcG/xe
   q5OWP8eZo89zNFKnIhO5xn3OtPno/13r3JdURwiUD4GK9grhlmZX5xUHc
   YUjMbPW7tfrwUB3ieamFKfvtewWNysWF2S4xcH+Xt8RVKN4ZjwA8+rkil
   L3WFG9vVI5d9FF6D2NUYXMJcpRLjMgOXXbjcEP1WgNCHuqvULHHfi6iBI
   w==;
X-CSE-ConnectionGUID: H3HBTomdRGO6tpuUhsfPTA==
X-CSE-MsgGUID: fObfWTvQQXO1ZI22qGrqfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="103914526"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="103914526"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 20:02:28 -0700
X-CSE-ConnectionGUID: QTooCQFPTb65As+qb6ZO4Q==
X-CSE-MsgGUID: 3bogxQt6QwamZjLpaQyDnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="264831302"
Received: from unknown (HELO [10.238.2.250]) ([10.238.2.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 20:02:27 -0700
Message-ID: <b97fb2be-fa3a-42d9-9aa6-e87afc85a6a9@linux.intel.com>
Date: Thu, 30 Apr 2026 11:02:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 2/5] perf/x86/intel: Always reprogram ACR events to
 prevent stale masks
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260430002558.712334-3-dapeng1.mi@linux.intel.com>
 <20260430020402.60C32C19425@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260430020402.60C32C19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/30/2026 10:04 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unconditional hardware MSR reprogramming for ACR events introduces performance regression and increases measurement blind spots.
> --
>
> commit a8f30026401c4d7de00c3f1a7543204056d7235c
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> perf/x86/intel: Always reprogram ACR events to prevent stale masks
>
> This commit modifies PMU event scheduling to force reprogramming of all ACR
> events during rescheduling. It does this by making match_prev_assignment()
> always return false for ACR events.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 810ab21ffd99..4b9e105309c6 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -1294,13 +1294,16 @@ int x86_perf_rdpmc_index(struct perf_event *event)
>>  	return event->hw.event_base_rdpmc;
>>  }
>>  
>> -static inline int match_prev_assignment(struct hw_perf_event *hwc,
>> +static inline int match_prev_assignment(struct perf_event *event,
>>  					struct cpu_hw_events *cpuc,
>>  					int i)
>>  {
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>>  	return hwc->idx == cpuc->assign[i] &&
>> -		hwc->last_cpu == smp_processor_id() &&
>> -		hwc->last_tag == cpuc->tags[i];
>> +	       hwc->last_cpu == smp_processor_id() &&
>> +	       hwc->last_tag == cpuc->tags[i] &&
>> +	       !is_acr_event_group(event);
>>  }
> Does this unconditional hardware MSR reprogramming for ACR events introduce a
> performance regression and increase measurement blind spots?
>
> By unconditionally returning false for all ACR events, every active ACR event
> will undergo a full x86_pmu_stop() and x86_pmu_start() cycle during PMU
> re-enablement (e.g., in x86_pmu_enable() when cpuc->n_added > 0).
>
> These full stop/start cycles invoke multiple wrmsr and rdpmc instructions,
> adding significant cycle overhead to the hot scheduling path. Since this
> occurs while the PMU is globally disabled, the added latency extends the
> global PMU off-time, unnecessarily increasing the measurement blind spot
> where events are not counted across the CPU.
>
> Could this overhead be avoided by checking if the mask actually changed?
>
> x86_pmu_late_setup() calculates the new physical mask and stores it in
> event->hw.config1 before match_prev_assignment() is evaluated. Would it be
> better to compare event->hw.config1 against the previously programmed mask
> stored in cpuc->acr_cfg_b[hwc->idx] and only force a reprogram when they
> differ?

Nice idea. This can be further optimized. I'm not sure if it's worth to
post a new patchset for this single optimization.  If not, I would post a
single optimization patch for this.

Thanks.


>
> [ ... ]
>
