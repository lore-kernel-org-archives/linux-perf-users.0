Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9A15B102;
	Mon,  9 Jun 2025 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499189; cv=none; b=C7DzeqsOa/+Gk0z+/O49caJ6UqN2vTHJpXh2A1qfiZOCKh/ogmDdu5jdrWaScKaCp6FNEOGfeTQD6OgqKa02GfX1AWi/TA4QYIctip254dUm+KwKQv8uaXdix+SF2vP6ysyPNpcoBW5uo5FUFLhdt+Sj1515pVSHP4E2C7FTgbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499189; c=relaxed/simple;
	bh=RJE799Ft03ClK4adAwxIWQwP7iwTuDdoo89VxoewfsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1BdzWodtF+0pWNG5Fzsp9J+7IdIWGoA15nT66vAMUxjV6LP6W3X0XCzPvAmtNxljJVfD/I4Kdsy7WSpJjMtxlbNzCigJ2hn+VjlbhghCTNTjLgetZ41tFA/mwDmnCYw4rWsii6Ifc0z5f0eHiDTS9Bw/1/RCIrtidQoAq3ndvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lp2l++tX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lp2l++tX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749499187; x=1781035187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RJE799Ft03ClK4adAwxIWQwP7iwTuDdoo89VxoewfsY=;
  b=Lp2l++tXp0Qu5S4yHlcoJOJ6w8EH6zZg3cRWoXL7QvX8b+teNLyCqPTU
   ZRD0MFjAbhBvUd9MmXpyfuPuzCrolIhVcmj+MBXwVYWZJHAXm91DSBUVe
   cyrXICwebHdRO8j5yHiehz52YAnQUaeaub0T063a6t1h6My5D5Di6GDu+
   z5jMQ8I+EQQZlBeYIYfWQivtYysx5/pAzPLcJPIqBHW/dD7XUXgceUiuZ
   p6zlQjd7C9EI1f589wBRX/oqBbsNHcq3GQx8Riv41ZS87k/CkD/AwXPM2
   ZfT9wkwz25uebIo0P6vWLbKG+Al0RDoJQ7xQbmqJaF7Fz9/ie8er/2wBE
   A==;
X-CSE-ConnectionGUID: lXxMtTlTTdmapz4HNzSKbA==
X-CSE-MsgGUID: jddR7sneSXu9h013vTRVcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55395124"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55395124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 12:59:47 -0700
X-CSE-ConnectionGUID: tiphKLsTT8atzQy90eGRbA==
X-CSE-MsgGUID: oSXBgkYMTbOlrKTM1DKuZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="146521201"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 12:59:45 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 684D920B5736;
	Mon,  9 Jun 2025 12:59:43 -0700 (PDT)
Message-ID: <34917979-92dd-4921-be07-f456f84b6ee1@linux.intel.com>
Date: Mon, 9 Jun 2025 15:59:41 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] perf: Fix the throttle error of some clock events
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, Aishwarya TCV <aishwarya.tcv@arm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20250606192546.915765-1-kan.liang@linux.intel.com>
 <20250609123415.GJ8020@e132581.arm.com>
 <e763b0bd-cb51-4a76-816d-e12e59b02214@linux.intel.com>
 <20250609183604.GP8020@e132581.arm.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250609183604.GP8020@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-09 2:36 p.m., Leo Yan wrote:
> On Mon, Jun 09, 2025 at 09:48:12AM -0400, Liang, Kan wrote:
> 
> [...]
> 
>>>> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
>>>> the order the same as perf_event_unthrottle(). Except the patch, no one
>>>> checks the hw.interrupts in the stop(). There is no impact from the
>>>> order change.
>>>>
>>>> When stops in the throttle, the event should not be updated,
>>>> stop(event, 0).
>>>
>>> I am confused for this conclusion. When a CPU or task clock event is
>>> stopped by throttling, should it also be updated? Otherwise, we will
>>> lose accouting for the period prior to the throttling.
>>>
>>> I saw you exchanged with Alexei for a soft lockup issue, the reply [1]
>>> shows that skipping event update on throttling does not help to
>>> resolve the lockup issue.
>>>
>>> Could you elaberate why we don't need to update clock events when
>>> throttling?
>>>
>>
>> This is to follow the existing behavior before the throttling fix*.
>>
>> When throttling is triggered, the stop(event, 0); will be invoked.
>> As my understanding, it's because the period is not changed with
>> throttling. So we don't need to update the period.
> 
>> But if the period is changed, the update is required. You may find an
>> example in the perf_adjust_freq_unthr_events(). In the freq mode,
>> stop(event, PERF_EF_UPDATE) is actually invoked for the triggered event.
> 
>> For the clock event, the existing behavior before the throttling fix* is
>> not to invoke the stop() in throttling. It relies on the
>> HRTIMER_NORESTART instead. My previous throttling fix changes the
>> behavior. It invokes both stop() and HRTIMER_NORESTART. Now, this patch
>> change the behavior back.
> 
> Actually, the "event->count" has been updated in perf_swevent_hrtimer(),
> this is why this patch does not cause big deviation if skip updating
> count in the ->stop() callback:
> >   perf_swevent_hrtimer()
>    ` event->pmu->read(event);               => Update count
>    ` __perf_event_overflow()
>       ` perf_event_throttle()
>          ` event->pmu->stop(event, 0) / cpu_clock_event_stop()
>             ` perf_swevent_cancel_hrtimer() => Skip to cancel timer
>             ` task_clock_event_update()     => Skip to update count
>    ` return HRTIMER_NORESTART;              => Stop timer
> 
> It is a bit urgly that we check the throttling separately in two
> places: one is in perf_swevent_cancel_hrtime() for skipping cancel
> timer, and then we skip updating event count in
> cpu_clock_event_stop().

The second check before cpu_clock_event_stop() is not a throttling
check. It's to implement the missed flag check.
Usually, the stop() should check PERF_EF_UPDATE before updating an
event. I think most of the ARCHs do so.
Some cases may ignore the flag. For the clock event, I think it's
because the stop(event, 0) is never invoked. So it doesn't matter if the
flag is checked. But now, there is a case which the flag matters.
So I think we should add the flag check.

> 
> One solution is it would be fine to update count in ->stop() callback
> for the throttling. This should not cause any issue (though it is a bit
> redundant that the count is updated twice).

The clock event relies on local_clock(), which never stops.
So it still counts between read() and stop().
It's not just redundant. The behavior is changed if the event is updated
in the stop() again.

> 
> Or even more clear, we can define a flag PERF_EF_THROTTLING:
> 
>     #define PERF_EF_THROTTLING  0x20
> 
>     event->pmu->stop(event, PERF_EF_THROTTLING);
> 

The if (hwc->interrupts != MAX_INTERRUPTS) should be good enough to
check the throttling case. I don't think we need a new flag here.

>     cpu_clock_event_stop(struct perf_event *event, int flags)
>     {
>         if (flags == PERF_EF_THROTTLING)
>             return;
> 
>         ....
>     }
> 
> This might need to do a wider checking to ensure this new flags will not
> cause any issues.

Right, it may brings more troubles.

I think we should properly utilize the existing flag rather than
introducing a new one.

Thanks,
Kan
