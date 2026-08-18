Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3B4B04AC;
	Tue, 18 Aug 2026 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016944; cv=none; b=STysYM0SOotCKT7SHmvDSyIL59dzaLNIM1LSmi/lmej+S0VFVe3Cd4ojs6CZ9fW8N5md672lcb0rsRxanSTuTXkg0nHzPYV2eRpW+4I89d0bV9PFN/3k+SXMok3bc8IXmnuffcirceLc9E3+2E/hrBtTKjN6w7ePEGHj4tAQaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016944; c=relaxed/simple;
	bh=rbbV1g3t36RtHpC46x8E69U4mGJUS/Wx5RAs/Hzz0TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cguOQvMZ240u2f/q2Z89Ab7s0Mo9GiF628Sd0x2Y3zljI7NBmhKUnj8s5fuzg+/fjCnkGFjVI7AMWQk9MQ2fez3/A6HRDBywBY68lHeAraowEmH4bWNQ8OGYQcUdTXb5pnYHpV8QfPM1NzW5YVj4aRaklur5BumIKKsoQRp3ULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOvKKC3H; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOvKKC3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787016943; x=1818552943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rbbV1g3t36RtHpC46x8E69U4mGJUS/Wx5RAs/Hzz0TI=;
  b=dOvKKC3HmIoMVeaG11B1O+vV96/y8xZ0AkUW7OaXHAlv6PsKjKkOM31R
   YsItMxxQc0BFUVMNscFHcFocEG2ieeE4EYqztUNzkoJVT+RGpaEjQ5ThY
   WACVMB/oo9sJJaazJqhNESPKHHJuMiKPqAdibE8ZwS7YpKqH0b+LyMfn8
   0Doh21b3+kADocQwV6ClVVKGH3sRqaNILwLyeOEdV5RTNLVLguYL91iSh
   oWr6hcECF6fyBnIjcXy+fslRWqNgEYi7RPdQgvPLR/qbaQ+X5glzoKXCZ
   QMr9yHdF0Bk+S8EYhObC7Pzo4+7dNawcRqAc4JGOd3RRCpskwClWzRhuu
   A==;
X-CSE-ConnectionGUID: tYbg3THhSpi3lMKzq3IKwA==
X-CSE-MsgGUID: H67h4yATQI+nWohUVDN1kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98862451"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98862451"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 18:35:42 -0700
X-CSE-ConnectionGUID: NvKBHyQ5Tl+INdKwRTXZtA==
X-CSE-MsgGUID: 1YNtyilQQgOKq163mPrR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="289884702"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 18:35:37 -0700
Message-ID: <67f69a50-6643-4bcd-9ba3-a6d137e10791@linux.intel.com>
Date: Tue, 18 Aug 2026 09:35:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] perf/x86/intel: Prevent drain_pebs() reentry
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fWqqAFLwdRKeTN8q_GiCdvUx81bQT+=6KpWitV7uECM9w@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWqqAFLwdRKeTN8q_GiCdvUx81bQT+=6KpWitV7uECM9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/18/2026 3:28 AM, Ian Rogers wrote:
> On Wed, Aug 12, 2026 at 11:50 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
>> not be reentered. If so, one instance may observe stale buffer state and
>> potentially access out-of-bound memory.
>>
>> Most invocations happen in NMI context, which naturally prevents reentry.
>> However, drain_pebs() is also reachable from process context via
>> intel_pmu_drain_pebs_buffer().
>>
>> In those paths, the PMU is often already disabled, but not guaranteed.
>> For example, __intel_pmu_pebs_disable() only disables the target counter,
>> so other active counters can still raise a PMI and interrupt an in-flight
>> drain_pebs(). Here is an example,
>>
>> __perf_addr_filters_adjust()
>>   perf_event_stop()
>>     __perf_event_stop()
>>       x86_pmu_stop() (event->pmu->stop)
>>         intel_pmu_disable_event()
>>           intel_pmu_pebs_disable()
>>             __intel_pmu_pebs_disable()
>>               intel_pmu_drain_large_pebs()
>>                 intel_pmu_drain_pebs_buffer()
>>
>> Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
>> use them in intel_pmu_drain_large_pebs() to disable the full PMU
>> around the intel_pmu_drain_pebs_buffer() call, preventing reentry.
>>
>> Also add a warning in intel_pmu_drain_pebs_buffer() when the full PMU is
>> not disabled.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>
>> v2: Move __intel_pmu_quiesce()/__intel_pmu_resume() pair into
>> intel_pmu_drain_large_pebs() instead of guarding all drain_pebs()
>> callbacks. (Peter)
>>
>> v1: https://lore.kernel.org/all/20260717080342.1879573-9-dapeng1.mi@linux.intel.com/
>>
>>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++---------
>>  arch/x86/events/intel/ds.c   |  8 +++++++-
>>  arch/x86/events/perf_event.h |  3 +++
>>  3 files changed, 34 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index f6ee1819864e..1cdb52c0aad5 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3125,6 +3125,27 @@ static void intel_pmu_del_event(struct perf_event *event)
>>                 this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
>>  }
>>
>> +int __intel_pmu_quiesce(void)
> Thanks Dapeng. Rather than quiesce would
> __intel_pmu_disable_if_enabled be a more intention revealing name?

Thanks Ian for reviewing this patch. 

Yeah, I was hesitated about the name for a while. Currently I still prefer
the name __intel_pmu_quiesce() which is simplified enough than other names. 


>
>> +{
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +       int pmu_enabled = cpuc->enabled;
>> +
>> +       cpuc->enabled = 0;
> Presumably the line above could also be inside the if.

Yes. I'm not sure if it's worthy to post a new version for this minor
change. But If there is a new version, I would change it.


>
>> +       if (pmu_enabled)
>> +               intel_pmu_disable_all();
>> +
>> +       return pmu_enabled;
>> +}
>> +
>> +void __intel_pmu_resume(int pmu_enabled)
>> +{
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +
>> +       cpuc->enabled = pmu_enabled;
>> +       if (pmu_enabled)
>> +               intel_pmu_enable_all(0);
>> +}
>> +
>>  static int icl_set_topdown_event_period(struct perf_event *event)
>>  {
>>         struct hw_perf_event *hwc = &event->hw;
>> @@ -3316,16 +3337,13 @@ static void intel_pmu_read_event(struct perf_event *event)
>>         if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN) ||
>>             is_pebs_counter_event_group(event)) {
>>                 struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> -               bool pmu_enabled = cpuc->enabled;
>> +               int pmu_enabled;
> nit: Maybe pmu_enabled would be better as pmu_was_enabled or pmu_reenable?

pmu_enabled seems better for me. pmu_enabled is simplified enough comparing
with other names. 

Thanks.


>
>>                 /* Only need to call update_topdown_event() once for group read. */
>>                 if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU_TXN_READ))
>>                         return;
>>
>> -               cpuc->enabled = 0;
>> -               if (pmu_enabled)
>> -                       intel_pmu_disable_all();
>> -
>> +               pmu_enabled = __intel_pmu_quiesce();
>>                 /*
>>                  * If the PEBS counters snapshotting is enabled,
>>                  * the topdown event is available in PEBS records.
>> @@ -3334,10 +3352,7 @@ static void intel_pmu_read_event(struct perf_event *event)
>>                         static_call(intel_pmu_update_topdown_event)(event, NULL);
>>                 else
>>                         intel_pmu_drain_pebs_buffer();
>> -
>> -               cpuc->enabled = pmu_enabled;
>> -               if (pmu_enabled)
>> -                       intel_pmu_enable_all(0);
>> +               __intel_pmu_resume(pmu_enabled);
>>
>>                 return;
>>         }
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index e86e4ba91e1b..54890dda0589 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1242,8 +1242,11 @@ int intel_pmu_drain_bts_buffer(void)
>>
>>  void intel_pmu_drain_pebs_buffer(void)
>>  {
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>         struct perf_sample_data data;
>>
>> +       WARN_ON_ONCE(cpuc->enabled);
>> +
>>         static_call(x86_pmu_drain_pebs)(NULL, &data);
>>  }
>>
>> @@ -1864,8 +1867,11 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
>>  static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
>>  {
>>         if (cpuc->n_pebs == cpuc->n_large_pebs &&
>> -           cpuc->n_pebs != cpuc->n_pebs_via_pt)
>> +           cpuc->n_pebs != cpuc->n_pebs_via_pt) {
>> +               int enabled = __intel_pmu_quiesce();
> Similarly, may be was_enabled rather than enabled.
>
> Thanks,
> Ian
>
>>                 intel_pmu_drain_pebs_buffer();
>> +               __intel_pmu_resume(enabled);
>> +       }
>>  }
>>
>>  static void __intel_pmu_pebs_enable(struct perf_event *event)
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index fa381110f7a7..84495279079a 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -1638,6 +1638,9 @@ static __always_inline void __intel_pmu_lbr_disable(void)
>>         wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
>>  }
>>
>> +extern int __intel_pmu_quiesce(void);
>> +extern void __intel_pmu_resume(int pmu_enabled);
>> +
>>  int intel_pmu_save_and_restart(struct perf_event *event);
>>
>>  struct event_constraint *
>>
>> base-commit: 917d558b151cad5b05991e5eaee22efab33525ca
>> --
>> 2.34.1
>>
