Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC42F0682;
	Tue, 12 Aug 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042702; cv=none; b=kLDnmm2bYerKWqSH0PxuEnN+Tc2Top2Gr5gKWkV2UBG3kdpFFNqynOuC5DjKFeHRyy2VP7Y02Z98qihY4KPC6v0c4239kkyJfqYJGuQ1S7IjtvKflfGYDiRwqvDdxf/LNw4gmKAAAc1KNeQUC3YQmqCBkhySNQLKUBbqbwgNv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042702; c=relaxed/simple;
	bh=TY/UNLEZcNr8XTP7+W7T8G0WnkVyOrUfbEJm1Kdh1nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVjN3+MhogMYwR8AU45MyKZT/l4HRU8tp1w5XvEOZ+pA+j8G6wLldbnZYFBKJfpYnNqnFQgIeLUsiFttW2HuGmhEf6Jp0pfUTrWfE6m4G1njTM6c+Q1INnb8hXwr1Om6B9YhBn31U4av1W7IidJg20OoXdsqn5guhwJLKytEyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1Cboved; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1Cboved"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755042701; x=1786578701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TY/UNLEZcNr8XTP7+W7T8G0WnkVyOrUfbEJm1Kdh1nk=;
  b=d1CbovedC6sNqX1UVtr4TFy5t3S/wtxYcCILPkhQh7z1rrZyrvIt4+/i
   vxijctH9p0l2WBzqKEh2pHhEsDKjNph1NgeUWxykcbsn4kBslncDwBqVv
   Oon62p0v+AEEyP1L2KMzaKN9IpEtEgveHB0f7lxDPG4GC4k6cDxhZaGZN
   uYU7r18c3ohNcOIPiM24azP3kAWtTIfVmfnLn0pKnEOTO6f1RXZo2rkyJ
   nJl0RF+jB7yAl5fEwNdSDPrrKxmwqwx72xsq6c4/zf4m+IvKVM4/uTHmw
   pOJU+DUsJ1TwGFpqnlvhYslYp0zKu+kwdIqVylYqTchPHdekMfq2fCP4f
   A==;
X-CSE-ConnectionGUID: OZmjcZ96ScuoFDBool5EKA==
X-CSE-MsgGUID: 4S7yJewWRRucWoBmK+w+MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56355031"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56355031"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 16:51:37 -0700
X-CSE-ConnectionGUID: 2iBUw5OvS5KTbmo+SKW8mw==
X-CSE-MsgGUID: Hz2jtjzeTESLxIAz7EgT3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166695571"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 16:51:32 -0700
Received: from [10.246.163.36] (kliang2-mobl1.ccr.corp.intel.com [10.246.163.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id C02A220B571C;
	Tue, 12 Aug 2025 16:51:29 -0700 (PDT)
Message-ID: <922f69f6-e290-46f6-af6f-5a71e4508cf0@linux.intel.com>
Date: Tue, 12 Aug 2025 16:51:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: Avoid undefined behavior from stopping/starting
 inactive events
To: Yunseong Kim <ysk@kzalloc.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Austin Kim <austindh.kim@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <20250812181046.292382-2-ysk@kzalloc.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250812181046.292382-2-ysk@kzalloc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-08-12 11:10 a.m., Yunseong Kim wrote:
> Calling pmu->start()/stop() on perf events in PERF_EVENT_STATE_OFF can
> leave event->hw.idx at -1. When PMU drivers later attempt to use this
> negative index as a shift exponent in bitwise operations, it leads to UBSAN
> shift-out-of-bounds reports.
> 
> The issue is a logical flaw in how event groups handle throttling when some
> members are intentionally disabled. Based on the analysis and the
> reproducer provided by Mark Rutland (this issue on both arm64 and x86-64).
> 
> The scenario unfolds as follows:
> 
>  1. A group leader event is configured with a very aggressive sampling
>     period (e.g., sample_period = 1). This causes frequent interrupts and
>     triggers the throttling mechanism.
>  2. A child event in the same group is created in a disabled state
>     (.disabled = 1). This event remains in PERF_EVENT_STATE_OFF.
>     Since it hasn't been scheduled onto the PMU, its event->hw.idx remains
>     initialized at -1.
>  3. When throttling occurs, perf_event_throttle_group() and later
>     perf_event_unthrottle_group() iterate through all siblings, including
>     the disabled child event.
>  4. perf_event_throttle()/unthrottle() are called on this inactive child
>     event, which then call event->pmu->start()/stop().
>  5. The PMU driver receives the event with hw.idx == -1 and attempts to
>     use it as a shift exponent. e.g., in macros like PMCNTENSET(idx),
>     leading to the UBSAN report.
> 
> The throttling mechanism attempts to start/stop events that are not
> actively scheduled on the hardware.
> 
> Move the state check into perf_event_throttle()/perf_event_unthrottle() so
> that inactive events are skipped entirely. This ensures only active events
> with a valid hw.idx are processed, preventing undefined behavior and
> silencing UBSAN warnings. The corrected check ensures true before
> proceeding with PMU operations.
> 
> The problem can be reproduced with the syzkaller reproducer:
> Link: https://lore.kernel.org/lkml/714b7ba2-693e-42e4-bce4-feef2a5e7613@kzalloc.com/
> 
> Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>

Thanks for the fix.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  kernel/events/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8060c2857bb2..872122e074e5 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2665,6 +2665,9 @@ static void perf_log_itrace_start(struct perf_event *event);
>  
>  static void perf_event_unthrottle(struct perf_event *event, bool start)
>  {
> +	if (event->state != PERF_EVENT_STATE_ACTIVE)
> +		return;
> +
>  	event->hw.interrupts = 0;
>  	if (start)
>  		event->pmu->start(event, 0);
> @@ -2674,6 +2677,9 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>  
>  static void perf_event_throttle(struct perf_event *event)
>  {
> +	if (event->state != PERF_EVENT_STATE_ACTIVE)
> +		return;
> +
>  	event->hw.interrupts = MAX_INTERRUPTS;
>  	event->pmu->stop(event, 0);
>  	if (event == event->group_leader)

