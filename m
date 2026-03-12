Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA62303CA0;
	Thu, 12 Mar 2026 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296645; cv=none; b=dqHjyTqhhoQaqYgAlPghd/P17iNJT7Fi+5SZeO7Id6t6MpVYtQJauxLBmJ12TFrwSB/1CaonJ2p0EnIBsFTMB9C7f5Ihsz2bkO5gGxfoaK4c9KZY6B4McWAwX7HbCDSV/ocUJYwsrtShrVIo++3gtHKN7oOmguAjyziBcIrYQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296645; c=relaxed/simple;
	bh=VTOSKqYu9h1ZKslfQv/fGfX6CRxc45rFzlJMQXq0gos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSIYYdniH3ts1BqZ7OJJZvZamz3Pc/KslbkQUZ7zkVwHGZEoPdxiyZgGklX/stMgsqXc/ucPn+Nw1eMVoS9NsLRmcAoD1Dq0vlLHR6g4PaWZWFIzQK0PtOuYLoo3RQ5Y+IViyiFnbzbxZzbmCPK7BPoST/isiCinqbu6C2AEt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQ/R7TTR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQ/R7TTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773296645; x=1804832645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VTOSKqYu9h1ZKslfQv/fGfX6CRxc45rFzlJMQXq0gos=;
  b=dQ/R7TTR/s9KOoOQPRjqIaHTMVKF9T6hBoPHQDnEU7nwL+9dSYFThj8K
   QdYH+dqk+mOGj8QszE1pVgt9BHMFX6NJhIa8qZeeuw68VCYWF9SQkXvI0
   L2Vr+Tj7G+JoX7ezVCKPNATc24OYEpN7i2EyGsWSnEWYBShpdpSnrUnKJ
   61bopJPtsYRkdtkdMUtwyzR/MknnyinE7ZZiwNoBkAmcAXVV/ppFtHOGk
   /TGUeDKC5AdzuoRXKw6bmlkKRHlFuvH19iP8BryFz4tsk/G7uludKfHR0
   V/tAwuz5Dalej5OqGxEd4Bg5wJ5UMBHzkIT6sL8XAzFRLPUkQDPFUFnN+
   A==;
X-CSE-ConnectionGUID: OftMwXkUQLCBc7zDuc8Ivw==
X-CSE-MsgGUID: WUJbP2+5TWyoRngBRFUN3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74568398"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74568398"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:24:04 -0700
X-CSE-ConnectionGUID: NGHtxoBVSrC6koGabLS9Yw==
X-CSE-MsgGUID: 5wpz4xDPRL+l9Bmle8vBsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="224858820"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:24:00 -0700
Message-ID: <0ecc2007-95dd-490f-b1ca-89a2d52cfabf@linux.intel.com>
Date: Thu, 12 Mar 2026 14:23:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Update cap_user_rdpmc base on rdpmc user
 disable state
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260311075201.2951073-1-dapeng1.mi@linux.intel.com>
 <20260311075201.2951073-2-dapeng1.mi@linux.intel.com>
 <CAP-5=fWr2L6miiFZ6Km3HYEdmqp3T0NBL=WY3buKdKztW+HvmA@mail.gmail.com>
 <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/12/2026 1:04 PM, Ian Rogers wrote:
> On Wed, Mar 11, 2026 at 9:44 PM Ian Rogers <irogers@google.com> wrote:
>> On Wed, Mar 11, 2026 at 12:56 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>>> After introducing the RDPMC user disable feature, user-space RDPMC may
>>> return 0 instead of the actual event count. This creates an inconsistency
>>> with cap_user_rdpmc, where cap_user_rdpmc is set, but user-space RDPMC
>>> only returns 0.
>>>
>>> To accurately represent the user-space RDPMC capability, update
>>> cap_user_rdpmc based on the RDPMC user disable state. If RDPMC user
>>> disable is enabled, cap_user_rdpmc is set to false, allowing user-space
>>> programs to fall back to the read() syscall to obtain the real event
>>> count.
>>>
>>> Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disable feature")
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>  arch/x86/events/core.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index 03ce1bc7ef2e..0266a11d7ec9 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>>> @@ -2807,6 +2807,9 @@ void arch_perf_update_userpage(struct perf_event *event,
>>>         userpg->cap_user_time_zero = 0;
>>>         userpg->cap_user_rdpmc =
>>>                 !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
>>> +       if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
>> With the AI's help the following bug was spotted:
>>
>> Places like cpu_clock_event_add call perf_event_update_userpage with a
>> software event:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n12314
>> This then calls arch_perf_update_userpage:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n6870
>> In x86_pmu_has_rdpmc_user_disable:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/perf_event.h#n1336
>> ```
>> static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
>> {
>> return !!(hybrid(pmu, config_mask) &
>> ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
>> }
>> ```
>> The hybrid call does a call to hybrid_pmu:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/perf_event.h#n793
>> and that does a container_of:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/perf_event.h#n782
>> ```
>> static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
>> {
>> return container_of(pmu, struct x86_hybrid_pmu, pmu);
>> }
>> ```
>> In the case that the event's pmu is a software PMU the container_of
>> should be invalid and this will lead to an out-of-bounds read of the
>> config_mask on hybrid systems.
>>
>> Unfortunately checking the event is x86 doesn't cover the hybrid case:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/core.c#n780
>> and it seems this bug may exist elsewhere. It'd be nice if in the
>> hybrid_pmu function there were a `BUG_ON(!is_x86_pmu(pmu))`, but
>> unfortunately that'd only get exposed on hybrid systems.
> Actually  is_x86_event does work for hybrid, so making this:
> ```
> if (is_x86_event(event) && x86_pmu_has_rdpmc_user_disable(event->pmu) && ...
> ```
> Should fix the issue.

Yes, I'd like move the check is_x86_event(event) into
x86_pmu_has_rdpmc_user_disable(), then the check "is_x86_event(event)"
won't be missed in next call for x86_pmu_has_rdpmc_user_disable(). Thanks.


>
> Thanks,
> Ian
>
>> Thanks,
>> Ian
>>
>>> +           event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
>>> +               userpg->cap_user_rdpmc = 0;
>>>         userpg->pmc_width = x86_pmu.cntval_bits;
>>>
>>>         if (!using_native_sched_clock() || !sched_clock_stable())
>>> --
>>> 2.34.1
>>>
