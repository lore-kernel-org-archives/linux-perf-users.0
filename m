Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E8312836;
	Fri, 13 Mar 2026 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362940; cv=none; b=NLc8n81VV+knaWF1g5cEanxip4nvd1H+VlSh8EO14EEsT0JoYtb9hHNg1G8rPE0e1hS6NioohITZkFpFknA3LEJoQ4gZ+SGMNM/vGCZR/2a0pAD+PGXpKqGzJzW514RAdN9CsWH8Pv27yIGZZ86cW3PtdgRvZadN041sJFlHfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362940; c=relaxed/simple;
	bh=+KZ/MvhGPN7sayIEjhkLfuzePPmHWymwHe/zAICfnmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RB6QrMJArsW+NpOyh63NaE6R62Ouky7iTly5jy99CtD3sHXIydpzTElFAunx5qZI+TYFybra7bu4A41icbYXlPm2zEj1oI0THwxtyJXzEe7//QSgFITsFgCs1mG9EezdavhvEPsjcrvKVKePH/cyTdv90ZE5XqqIlop3/G2m1sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxXpgMVm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxXpgMVm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773362936; x=1804898936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+KZ/MvhGPN7sayIEjhkLfuzePPmHWymwHe/zAICfnmA=;
  b=hxXpgMVm6nAtMzGAmcBHVBUg4OAUevZYunAIEp6poe4NrJLJy/Z4dmQ/
   OD5zNqw/fZ3x6T29wm/BfFc3ysLLKDONkoLi3iFvnHIdjx+mAJWtgJOfr
   Qyf7xWJp2IOWJPOuW8R+ng2n52/hH5gK5k6dYtnQLn1JA8GpvaNi03lgm
   ZxMhoXDqe/CalM0jg3gsqPaFAVXCp0WZP0H+jK9ixZ0IjfwcqsmfLDKwh
   dudr80THcO83en7lOc7h5r6+O2vgZHwVSlLMINBiaQCFeoy2RoiT0b+Jk
   WDhSTBarOIbA07wk+JnIb8dCbqZZQ2R7WGxWIgSAGqabxUaFx57V88PYB
   w==;
X-CSE-ConnectionGUID: tx8A2/w/TcWLSbu8rxjwmQ==
X-CSE-MsgGUID: hxCN6vfNTh2e+JMFmcPSyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="84788530"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="84788530"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 17:48:55 -0700
X-CSE-ConnectionGUID: wWRRrHYHSEqS9YLTEcdkSQ==
X-CSE-MsgGUID: FXY7qw8XQz+BTsY+ojmCzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="220252969"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 17:48:52 -0700
Message-ID: <f7de21c8-8035-4151-93b7-0c0656fc2b5e@linux.intel.com>
Date: Fri, 13 Mar 2026 08:48:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf/x86: Avoid inadvertent casts to
 x86_hybrid_pmu
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, dapeng1.mi@intel.com,
 acme@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
 alexander.shishkin@linux.intel.com, eranian@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mingo@redhat.com, namhyung@kernel.org, thomas.falcon@intel.com,
 xudong.hao@intel.com, zide.chen@intel.com
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com>
 <20260312083159.GD606826@noisy.programming.kicks-ass.net>
 <1627ec0d-50d3-4caa-a75a-a952a29cc664@linux.intel.com>
 <CAP-5=fV6ZDY-wvjfMHFPTpbXsR+3a0-HiBVr-Nxv+dsr7kXzhg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fV6ZDY-wvjfMHFPTpbXsR+3a0-HiBVr-Nxv+dsr7kXzhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/12/2026 11:16 PM, Ian Rogers wrote:
> On Thu, Mar 12, 2026 at 2:44 AM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 3/12/2026 4:31 PM, Peter Zijlstra wrote:
>>> On Wed, Mar 11, 2026 at 10:48:09PM -0700, Ian Rogers wrote:
>>>> The patch:
>>>> https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux.intel.com/
>>>> showed it was pretty easy to accidentally cast non-x86 PMUs to
>>>> x86_hybrid_pmus. Add a BUG_ON for that case. Restructure is_x86_event
>>>> and add an is_x86_pmu to facilitate this.
>>>>
>>>> @@ -779,6 +795,7 @@ struct x86_hybrid_pmu {
>>>>
>>>>  static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
>>>>  {
>>>> +    BUG_ON(!is_x86_pmu(pmu));
>>>>      return container_of(pmu, struct x86_hybrid_pmu, pmu);
>>>>  }
>>> Given that hybrid_pmu will have PERF_PMU_CAP_EXTENDED_HW_TYPE, and we
>>> should really only use hyrid_pmu() on one of those, would not the
>>> simpler patch be so?
>>>
>>>
>>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>>> index fad87d3c8b2c..13ec623617a9 100644
>>> --- a/arch/x86/events/perf_event.h
>>> +++ b/arch/x86/events/perf_event.h
>>> @@ -779,6 +779,7 @@ struct x86_hybrid_pmu {
>>>
>>>  static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
>>>  {
>>> +     BUG_ON(!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE));
>> It looks we can't add either !is_x86_pmu(pmu) or !(pmu->capabilities &
>> PERF_PMU_CAP_EXTENDED_HW_TYPE) here. hybrid_pmu() is called by the hybrid()
>> marco or other variants, and hybrid() macro is called in many places of the
>> intel_pmu_init(), like the update_pmu_cap() , but the flag
>> PERF_PMU_CAP_EXTENDED_HW_TYPE is still not set for the hybrid
>> pmu->capabilities until intel_pmu_init() ends and the hybrid pmus are
>> registered. Then it would cause the unexpected kernel crash.
>>
>> [    1.945128] kernel BUG at arch/x86/events/intel/../perf_event.h:798!
>> [    1.946131] Oops: invalid opcode: 0000 [#1] SMP NOPTI
>> [    1.947127] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
>> 7.0.0-rc3-perf-urgent-gc8b4b538960c #460 PREEMPT(full)
>> [    1.947127] Hardware name: Intel Corporation Panther Lake Client
>> Platform/PTL-UH LP5 T3 RVP1, BIOS PTLPFWI1.R00.3171.D00.2504220409 04/22/2025
>> [    1.947127] RIP: 0010:intel_pmu_init+0x25c9/0x5fd0
>> [    1.947127] Code: db 44 ff 4c 89 35 c7 da 44 ff 48 89 2d 80 da 44 ff e9
>> 49 df ff ff 83 7a 68 04 0f 84 1b f9 ff ff f6 42 6d 01 0f 85 11 f9 ff ff
>> <0f> 0b 31 d2 48 89 df
>> [    1.947127] RSP: 0000:ffffd5dc800f7db8 EFLAGS: 00010246
>> [    1.947127] RAX: 0000000000000001 RBX: 00000000000abfff RCX:
>> 0000000000000000
>> [    1.947127] RDX: ffff8f40856bc000 RSI: 0000000000000001 RDI:
>> 00000000000000ff
>> [    1.947127] RBP: 0000000000000001 R08: ffffffffffffffff R09:
>> 0000000000000004
>> [    1.947127] R10: ffffffffbd4e2500 R11: 0000000000000006 R12:
>> ffffffffbc26438b
>> [    1.947127] R13: 0000000000000000 R14: 0000000000000000 R15:
>> 0000000000000000
>> [    1.947127] FS:  0000000000000000(0000) GS:ffff8f482214f000(0000)
>> knlGS:0000000000000000
>> [    1.947127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    1.947127] CR2: ffff8f47ff7ff000 CR3: 00000004c1434001 CR4:
>> 0000000000f70ef0
>> [    1.947127] PKRU: 55555554
>> [    1.947127] Call Trace:
>> [    1.947127]  <TASK>
>> [    1.947127]  ? __pfx_init_hw_perf_events+0x10/0x10
>> [    1.947127]  init_hw_perf_events+0x2af/0x4b0
>> [    1.947127]  ? __pfx_init_hw_perf_events+0x10/0x10
>> [    1.947127]  do_one_initcall+0x52/0x250
>> [    1.947127]  ? _raw_spin_unlock+0x18/0x40
>> [    1.947127]  ? __register_sysctl_table+0x143/0x1a0
>> [    1.947127]  kernel_init_freeable+0x21d/0x340
>> [    1.947127]  ? __pfx_kernel_init+0x10/0x10
>> [    1.947127]  kernel_init+0x1a/0x1c0
>> [    1.947127]  ret_from_fork+0xcb/0x1c0
>> [    1.947127]  ? __pfx_kernel_init+0x10/0x10
>> [    1.947127]  ret_from_fork_asm+0x1a/0x30
>> [    1.947127]  </TASK>
>> [    1.947127] Modules linked in:
>> [    1.947127] ---[ end trace 0000000000000000 ]---
>> [    1.948128] RIP: 0010:intel_pmu_init+0x25c9/0x5fd0
>> [    1.949128] Code: db 44 ff 4c 89 35 c7 da 44 ff 48 89 2d 80 da 44 ff e9
>> 49 df ff ff 83 7a 68 04 0f 84 1b f9 ff ff f6 42 6d 01 0f 85 11 f9 ff ff
>> <0f> 0b 31 d2 48 89 df
>> [    1.950129] RSP: 0000:ffffd5dc800f7db8 EFLAGS: 00010246
>> [    1.951128] RAX: 0000000000000001 RBX: 00000000000abfff RCX:
>> 0000000000000000
>> [    1.952128] RDX: ffff8f40856bc000 RSI: 0000000000000001 RDI:
>> 00000000000000ff
>> [    1.953128] RBP: 0000000000000001 R08: ffffffffffffffff R09:
>> 0000000000000004
>> [    1.954129] R10: ffffffffbd4e2500 R11: 0000000000000006 R12:
>> ffffffffbc26438b
>> [    1.955128] R13: 0000000000000000 R14: 0000000000000000 R15:
>> 0000000000000000
>> [    1.956128] FS:  0000000000000000(0000) GS:ffff8f482214f000(0000)
>> knlGS:0000000000000000
>> [    1.957128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    1.958128] CR2: ffff8f47ff7ff000 CR3: 00000004c1434001 CR4:
>> 0000000000f70ef0
>> [    1.959128] PKRU: 55555554
>> [    1.960128] Kernel panic - not syncing: Attempted to kill init!
>> exitcode=0x0000000b
>>
>> I'm not sure if we can move the flag PERF_PMU_CAP_EXTENDED_HW_TYPE setting
>> earlier and eventually find a good place to set the flag. Even it's
>> possible, but could be risky ...
>>
>> Ian, if you don't object, I would suggest to drop the bug_on(). I would
>> adopt other changes and add the is_x86_pmu() check in the
>> x86_pmu_has_rdpmc_user_disable() to fix the issue.
> No objections from me, these patches aim to improve the code's typing
> and were intended more as a suggestion easily expressed in code than
> by email :-)

Got it. 


>
> I feel that the x86_pmu and x86_hybrid_pmu are something of a mess,
> making features like counter partitioning harder than necessary if the
> code were structured better - ie 1 partition per PMU, which means
> multiple PMUs even without hybrid. It'd be nice if we could implement
> something like the BUG_ON to at least ensure correctness in the
> current code. I'll try to find other broken casts/container_ofs in the
> code by visual inspection.

Agree. The intel_pmu_init() indeed becomes over large and complicated along
with supporting more and more platforms. I ever wanted to do some
optimization for it, but always interrupted by other higher priority tasks.
Anyway, I would put it into my todo list and think how could we reconstruct it.

Thanks.


>
> Thanks,
> Ian
>
>> Thanks.
>>
>>>       return container_of(pmu, struct x86_hybrid_pmu, pmu);
>>>  }
>>>
