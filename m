Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F9352921;
	Thu, 12 Mar 2026 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296285; cv=none; b=DXw0vZIhvW5bGFBRD+Q1CrWrXijmxFK5KBIb1dH4mkeAxg5XtlIpeIBh5V6PNlur0gdmhpt9UwvXIkpy8jVSiNOxqXajefexQozISB8sL4AR2RC3I3wBtI5Ut0tnfRs4hggpx4ZlNCFLq2JiFGlBHqNFIL0/raCV81HnYrKwd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296285; c=relaxed/simple;
	bh=e1cyQyfc+sGyMFfPNcCRYPzawL6/1/Zogn2+oUzZ8gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsqOzXxdosqyynNMUdNU2zVgkdgyEYkqPkpo599jl4aav4+5bCDIDgbDA1Se7ykFd8v4vCUEtVvuCNJwk+p1LfvZ1Tb8FHMbc9nScSumwD8FjkkzZAneyj+TGUetAONBgkz+eFlOQGssLBpuIhSA6DqPLuz8k9EswyEKivncwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsP0WQ7n; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsP0WQ7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773296284; x=1804832284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1cyQyfc+sGyMFfPNcCRYPzawL6/1/Zogn2+oUzZ8gs=;
  b=WsP0WQ7niKjVbVW2tOTTykaYDYEJ1S1G4GYT8lTHMOB663tOu/HZC1gJ
   p6Q31DB7/9u2yAy1R8Qd7k/nQh65UeTIiFc2Bx3GJSFL9jXlMY630whJs
   JIab+dGPni6gFMpE5pi9B2tYiDlhhzBssZURcBMCBfuirvfemYlxiHQEC
   jq1ZFaaXF96k7jB6bqYQHg0qt2MxgpLvHZ4FcwKEDE6CAK9zJrIJ8RJV5
   +2aLY8JkoaOSFFBuuRXn9Bpp9Z6RoAuj2AU9yBMU5znlNMFIKYFSq1F2t
   xQKQRBoDWCKuZfv09PJhSCnJx+VIy9Pefkomg76Y7HcGdwf8GvbRKng/m
   w==;
X-CSE-ConnectionGUID: tUTvCWyfTIqZ7B+GsKRrjw==
X-CSE-MsgGUID: MY9njqOMROaoiG6FOUtx2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74494580"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74494580"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:18:03 -0700
X-CSE-ConnectionGUID: CiVWJr+gRmORnm8JuLeTAQ==
X-CSE-MsgGUID: OX7bDDnRTZeGvSqnZ5yakA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="224857458"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:17:59 -0700
Message-ID: <e32800cd-9b2d-49db-8bdd-fc7ef0ae6041@linux.intel.com>
Date: Thu, 12 Mar 2026 14:17:56 +0800
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWr2L6miiFZ6Km3HYEdmqp3T0NBL=WY3buKdKztW+HvmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/12/2026 12:44 PM, Ian Rogers wrote:
> On Wed, Mar 11, 2026 at 12:56 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> After introducing the RDPMC user disable feature, user-space RDPMC may
>> return 0 instead of the actual event count. This creates an inconsistency
>> with cap_user_rdpmc, where cap_user_rdpmc is set, but user-space RDPMC
>> only returns 0.
>>
>> To accurately represent the user-space RDPMC capability, update
>> cap_user_rdpmc based on the RDPMC user disable state. If RDPMC user
>> disable is enabled, cap_user_rdpmc is set to false, allowing user-space
>> programs to fall back to the read() syscall to obtain the real event
>> count.
>>
>> Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disable feature")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/core.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 03ce1bc7ef2e..0266a11d7ec9 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2807,6 +2807,9 @@ void arch_perf_update_userpage(struct perf_event *event,
>>         userpg->cap_user_time_zero = 0;
>>         userpg->cap_user_rdpmc =
>>                 !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
>> +       if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
> With the AI's help the following bug was spotted:
>
> Places like cpu_clock_event_add call perf_event_update_userpage with a
> software event:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n12314
> This then calls arch_perf_update_userpage:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/events/core.c#n6870
> In x86_pmu_has_rdpmc_user_disable:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/perf_event.h#n1336
> ```
> static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
> {
> return !!(hybrid(pmu, config_mask) &
> ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
> }
> ```
> The hybrid call does a call to hybrid_pmu:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/perf_event.h#n793
> and that does a container_of:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/perf_event.h#n782
> ```
> static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
> {
> return container_of(pmu, struct x86_hybrid_pmu, pmu);
> }
> ```
> In the case that the event's pmu is a software PMU the container_of
> should be invalid and this will lead to an out-of-bounds read of the
> config_mask on hybrid systems.
>
> Unfortunately checking the event is x86 doesn't cover the hybrid case:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/core.c#n780
> and it seems this bug may exist elsewhere. It'd be nice if in the
> hybrid_pmu function there were a `BUG_ON(!is_x86_pmu(pmu))`, but
> unfortunately that'd only get exposed on hybrid systems.

Good catch. I seems I put too much time on x86 PMU and always ignored there
were other event types. Thanks a lot.


>
> Thanks,
> Ian
>
>> +           event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
>> +               userpg->cap_user_rdpmc = 0;
>>         userpg->pmc_width = x86_pmu.cntval_bits;
>>
>>         if (!using_native_sched_clock() || !sched_clock_stable())
>> --
>> 2.34.1
>>
