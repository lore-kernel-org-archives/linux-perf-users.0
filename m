Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C7241665;
	Wed, 22 Oct 2025 05:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111257; cv=none; b=H6q6gTJ3KoZn43OOXSFu+6efiz/iwSih2TEfotk9QdTPynLgsDOvSbuVjXmwKLsO0SmnbB0v+xMOdNRbqj3uJgf8SExE1vVWzOFCA8NjM+oYuRVnFpo2vJ0bo5k5Qb7JGmWENh8hbSF+ptg7NRiJHYXREX0sYHn4tOuzpdkTI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111257; c=relaxed/simple;
	bh=Q+2L31TAAXSUvlTuut2rydHBadxA1eJyvA7IN+1hKVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW1P4nidQayuIMz7iQi3pn9y/xbif5hokcFWu+jU/U0qVOQvuA34/w40ShAOPfJ2mSrLzgfroshg33jvpFX0AEZXDUxTxipNKw8MEERNNqi2ZgF/1kMAuN90obMUCIYd/b+y4qIObrdsSRz4vhTrjb3HAuXA/OOi2yxbokKuQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZZ0xpPc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZZ0xpPc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761111255; x=1792647255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q+2L31TAAXSUvlTuut2rydHBadxA1eJyvA7IN+1hKVs=;
  b=dZZ0xpPcNqRdCCIgI8OjEQRc45FvIDdXMMcD+RzwYyG8EoDFWtS/MOFx
   N3z7QObQj8m8xfrSquCp3lD6WtFeFkqsU5VvNmzfu8smEqZu1nrQ6NuGA
   RfnjPMatBQNPjF8VLHYYxc9of6qhXHSV3xFMUFRl/etivTmQiTR4OD9Ic
   a6DDoie/8ubw1yaNo5h/adhe/ELUwvt0A7S7js2YM+CkO28Uv9/f9lSqT
   VTrcdrnhxoeemcTPf32aEG78F9aYftX3Ne4ZsQQOtptbSa75FParUI5Fm
   2BdLQSA4BrSiuc3MNASDj9k6XoA0Q4UhjnLlZ9mpVjCP1tnMk6RWwvGsf
   A==;
X-CSE-ConnectionGUID: m3HpiIPvR/mi1fwrwZfSOg==
X-CSE-MsgGUID: YhVfUAJVQw+43gHoiDWBaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85872768"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="85872768"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:34:14 -0700
X-CSE-ConnectionGUID: H9l9op39R6+mz8g14PYjpQ==
X-CSE-MsgGUID: M4LgcRvxTLeqP9rZ2R+iEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="182946007"
Received: from unknown (HELO [10.238.3.234]) ([10.238.3.234])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:34:12 -0700
Message-ID: <9f45329d-e49b-4055-bfb0-458db6ae319d@linux.intel.com>
Date: Wed, 22 Oct 2025 13:34:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: Fix system hang caused by cpu-clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Octavia Togami <octavia.togami@gmail.com>
References: <20251015051828.12809-1-dapeng1.mi@linux.intel.com>
 <20251021144751.GQ3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251021144751.GQ3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/21/2025 10:47 PM, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 01:18:28PM +0800, Dapeng Mi wrote:
>> A system hang issue caused by cpu-clock is reported and bisection
>> indicates the commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery
>>  breakage") causes this issue.
>>
>> The root cause of the hang issue is that cpu-clock is a specific SW
>> event which relies on the hrtimer. The __perf_event_overflow()
>> is invoked from the hrtimer handler for cpu-clock event, and
>> __perf_event_overflow() tries to call event stop callback
>> (cpu_clock_event_stop()) to stop the event, and cpu_clock_event_stop()
>> calls htimer_cancel() to cancel the hrtimer. But unfortunately the
>> hrtimer callback is currently executing and then traps into deadlock.
>>
>> To avoid this deadlock, use hrtimer_try_to_cancel() instead of
>> hrtimer_cancel() to cancel the hrtimer, and set PERF_HES_STOPPED flag
>> for the stopping events. perf_swevent_hrtimer() would stop the event
>> hrtimer once it detects the PERF_HES_STOPPED flag.
>>
>> Reported-by: Octavia Togami <octavia.togami@gmail.com>
>> Closes: https://lore.kernel.org/all/CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com/
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
>> Tested-by: Octavia Togami <octavia.togami@gmail.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  kernel/events/core.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7541f6f85fcb..f90105d5f26a 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11773,7 +11773,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
>>  
>>  	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
>>  
>> -	if (event->state != PERF_EVENT_STATE_ACTIVE)
>> +	if (event->state != PERF_EVENT_STATE_ACTIVE ||
>> +	    event->hw.state & PERF_HES_STOPPED)
>>  		return HRTIMER_NORESTART;
>>  
>>  	event->pmu->read(event);
> I was wondering if we need a HES_STOPPED check after calling
> __perf_event_overflow(), but typically that will return 1 when it does
> the stop itself, which then already does NORESTART.

Yes.


>
> So yeah, I suppose this works. Let me go queue this up.

Thanks for reviewing this patch.


>
> Thanks!
>
