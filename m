Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534F2E11C7;
	Tue, 10 Mar 2026 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773107156; cv=none; b=nEsE2F0WZBPvjQv9ZBjdWzbsGde/Jno4FuoHYW6IQSHv8KNhzcsQgycl6otiR+AKNoVcTW/k51Jdhy8EtkFbEbrQXE9agUCN4butjmS+1gUyovhCZVpLLswqXG7EIfO3v/d0nIu1s/lvs20iybyq+Wq/M7ATmRjfIPriS+Go7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773107156; c=relaxed/simple;
	bh=V2CJpra3Tr2YPBdlX6Bu7qDZ2eBNjWwJ0AJ3te98+uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnFv+aabT4lQrdS+f+iZgZN1ggt8e17JnT2ITypu/QF9+4FeZTZbGub1mmpO+dMi5+9r4Ddg+iAskYqUcJclaUPhfHd9SAW8U81S4h3O0bPo/QrEC7kvTFJNWM89bxKdLvF90p9jB7zF9xDRj4p63FvKAsQA/ohh/X9xM0whwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgemVN7S; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgemVN7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773107153; x=1804643153;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V2CJpra3Tr2YPBdlX6Bu7qDZ2eBNjWwJ0AJ3te98+uU=;
  b=TgemVN7SyFrsS7mp0SemUENatTKMTLW6MK1iMFFrvH90AijfW4FsN+Ax
   1La8Vu/3/qdgF9wD/x57t7l1NwJeFYkrdY2ZtwVhQf/mnaY3TavmmK9jc
   w5IOFgO5sE7jI/Yc6wljBKjBrn16xTeklNCj59kDTVjVVfR61vv5JsmHv
   PyZLUfQz0RwyNUyH2wJDVxunVWDBr9SeLCQnXTzgpcU1jKx8r36F9s0hD
   Dg2b2+REssyd/O/+KVCV2JCu9W00mw8Z8F6YR1uaM/ZBn8qSLu3gw7iCf
   K5ZtwnCZduEvbavhEjidXBncE2isfK1cbRRJLEYitbd95lw0wWZvTMaDB
   w==;
X-CSE-ConnectionGUID: jFdSOXPnRqq4+sLoIONQoA==
X-CSE-MsgGUID: aoQcQVDBRam37lk/Jn7zwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="61715797"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="61715797"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 18:45:51 -0700
X-CSE-ConnectionGUID: s2ePKCTIQL+OW/FWLlXzXA==
X-CSE-MsgGUID: EFxPYyZRSYuS0It9d92Hxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224869704"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 18:45:46 -0700
Message-ID: <a2a81222-5c6e-4cbc-a086-2e58463d495c@linux.intel.com>
Date: Tue, 10 Mar 2026 09:45:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Restore event pointer setup in x86_pmu_start()
To: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260309-perf-v1-1-601ffb531893@debian.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260309-perf-v1-1-601ffb531893@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/9/2026 10:40 PM, Breno Leitao wrote:
> A production AMD EPYC system crashed with a NULL pointer dereference
> in the PMU NMI handler:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000198
>   RIP: x86_perf_event_update+0xc/0xa0
>   Call Trace:
>    <NMI>
>    amd_pmu_v2_handle_irq+0x1a6/0x390
>    perf_event_nmi_handler+0x24/0x40
>
> The faulting instruction is `cmpq $0x0, 0x198(%rdi)` with RDI=0,
> corresponding to the `if (unlikely(!hwc->event_base))` check in
> x86_perf_event_update() where hwc = &event->hw and event is NULL.
>
> drgn inspection of the vmcore on CPU 106 showed a mismatch between
> cpuc->active_mask and cpuc->events[]:
>
>   active_mask: 0x1e (bits 1, 2, 3, 4)
>   events[1]:   0xff1100136cbd4f38  (valid)
>   events[2]:   0x0                 (NULL, but active_mask bit 2 set)
>   events[3]:   0xff1100076fd2cf38  (valid)
>   events[4]:   0xff1100079e990a90  (valid)
>
> The event that should occupy events[2] was found in event_list[2]
> with hw.idx=2 and hw.state=0x0, confirming x86_pmu_start() had run
> (which clears hw.state and sets active_mask) but events[2] was
> never populated.
>
> Another event (event_list[0]) had hw.state=0x7 (STOPPED|UPTODATE|ARCH),
> showing it was stopped when the PMU rescheduled events, confirming the
> throttle-then-reschedule sequence occurred.
>
> The root cause is commit 7e772a93eb61 ("perf/x86: Fix NULL event access
> and potential PEBS record loss") which moved the cpuc->events[idx]
> assignment out of x86_pmu_start() and into x86_pmu_enable(). This
> broke any path that calls pmu->start() without going through
> x86_pmu_enable() -- specifically the unthrottle path:
>
>   perf_adjust_freq_unthr_events()
>     -> perf_event_unthrottle_group()
>       -> perf_event_unthrottle()
>         -> event->pmu->start(event, 0)
>           -> x86_pmu_start()     // sets active_mask but not events[]
>
> The race sequence is:
>
>   1. A group of perf events overflows, triggering group throttle via
>      perf_event_throttle_group(). All events are stopped: active_mask
>      bits cleared, events[] preserved (x86_pmu_stop no longer clears
>      events[] after commit 7e772a93eb61).
>
>   2. While still throttled (PERF_HES_STOPPED), x86_pmu_enable() runs
>      due to other scheduling activity. Stopped events that need to
>      move counters get PERF_HES_ARCH set and events[old_idx] cleared.
>      In step 2 of x86_pmu_enable(), PERF_HES_ARCH causes these events
>      to be skipped -- events[new_idx] is never set.
>
>   3. The timer tick unthrottles the group via pmu->start(). Since
>      commit 7e772a93eb61 removed the events[] assignment from
>      x86_pmu_start(), active_mask[new_idx] is set but events[new_idx]
>      remains NULL.
>
>   4. A PMC overflow NMI fires. The handler iterates active counters,
>      finds active_mask[2] set, reads events[2] which is NULL, and
>      crashes dereferencing it.

Thanks for fixing this issue. Better add an "Cc: stable@vger.kernel.org"
tag as well.


>
> Restore cpuc->events[idx] = event in x86_pmu_start() so that every
> caller of pmu->start() correctly populates events[] before setting
> active_mask. This does not reintroduce the PEBS issue that commit
> 7e772a93eb61 fixed, because that fix also moved the events[] = NULL
> clearing from x86_pmu_stop() to x86_pmu_del() -- throttle/unthrottle
> cycles no longer clear events[].
>
> Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS record loss")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/x86/events/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 03ce1bc7ef2ea..fd82d1427b335 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1546,6 +1546,11 @@ static void x86_pmu_start(struct perf_event *event, int flags)
>  
>  	event->hw.state = 0;
>  
> +	/*
> +	 * Ensure events[idx] is set before active_mask, so NMI handlers
> +	 * never see an active counter with a NULL event pointer.
> +	 */
> +	cpuc->events[idx] = event;
>  	__set_bit(idx, cpuc->active_mask);
>  	static_call(x86_pmu_enable)(event);
>  	perf_event_update_userpage(event);
>
> ---
> base-commit: 0bcac7b11262557c990da1ac564d45777eb6b005
> change-id: 20260309-perf-fd32da0317a8
>
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
>
>
