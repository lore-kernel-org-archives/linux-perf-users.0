Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B2A31F99A;
	Thu, 12 Mar 2026 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308698; cv=none; b=L58uJ3Pq4hrbeFsHXuTOFPDy2+awbXvVYW/DisN5J50IppyHpkjhFpcjrsKIP4G5mniiD3MthbhXxJQz7ubDNJBeEr97o4RJV2++OHiINcv874j2jZYO4aBjhAR7HHkYQGIAGC+s2ARZ+Cj1tc4zjL7FsfnrSDbNC1iRTZMHxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308698; c=relaxed/simple;
	bh=FabBPLQd+5Cvs+pxmmnCydWaP/jmHUgOgJnEqlWDC00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcuNQ4y3R2ufHXv9ydU1cmID/x3FskU76bVd80lYhscCvpc21LJyDlyLt8ApOHxfZKzeY8gJD0m8D9VM8NtQvth2JAU4ZdVKiy+ndpBvKpeyIvtz02Ck7XZu7qsXQAdP39+5a9mp+hY3daTzaPq/Iu41s91KqqxDiGbJ1571d90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJ/23lGt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJ/23lGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773308696; x=1804844696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FabBPLQd+5Cvs+pxmmnCydWaP/jmHUgOgJnEqlWDC00=;
  b=FJ/23lGtUvQacghOPnoFhYcWQNrkLD9vZ+LPLEolqzES2S/fa9YpFaP/
   VfvVyRgf5zyx+ZpC22oxQC2A1ov+H6bxeIKIGhJTjhw/0mN706msHo003
   kj7M0H929blsVaoJBrgA0MyzuxbrTxz4FMk2k9Lirn6XpFGBo8ZyzgHcu
   cXWjlJBOUyeLMylajSj5QoQ4Nzx/Di1y9s9Tf2IhpTYsGFKqfMByqxYMZ
   9dF53o+BnjkXS3/vURowi6kvhwEZ0IuKB8kYUmKocaAIA9iN3R1auL1MU
   HJE97u/xNi0sikLOQakpMvIdnpOi/Q8hX1zbs+r/7/xYjUkrtLq31vhNq
   w==;
X-CSE-ConnectionGUID: L5PafGuGTEKc3fn0Dldz3w==
X-CSE-MsgGUID: dEKy/mjdQtuJpK7VtzbTQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74583890"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74583890"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:44:56 -0700
X-CSE-ConnectionGUID: VLUIJcbYTleKpJnzG7FTHw==
X-CSE-MsgGUID: Cmq2FGEPRVSLjJ6iJm+ZDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220717074"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:44:52 -0700
Message-ID: <1627ec0d-50d3-4caa-a75a-a952a29cc664@linux.intel.com>
Date: Thu, 12 Mar 2026 17:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf/x86: Avoid inadvertent casts to
 x86_hybrid_pmu
To: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>
Cc: dapeng1.mi@intel.com, acme@kernel.org, adrian.hunter@intel.com,
 ak@linux.intel.com, alexander.shishkin@linux.intel.com, eranian@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mingo@redhat.com, namhyung@kernel.org, thomas.falcon@intel.com,
 xudong.hao@intel.com, zide.chen@intel.com
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com>
 <20260312083159.GD606826@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260312083159.GD606826@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/12/2026 4:31 PM, Peter Zijlstra wrote:
> On Wed, Mar 11, 2026 at 10:48:09PM -0700, Ian Rogers wrote:
>> The patch:
>> https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux.intel.com/
>> showed it was pretty easy to accidentally cast non-x86 PMUs to
>> x86_hybrid_pmus. Add a BUG_ON for that case. Restructure is_x86_event
>> and add an is_x86_pmu to facilitate this.
>>
>> @@ -779,6 +795,7 @@ struct x86_hybrid_pmu {
>>  
>>  static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
>>  {
>> +	BUG_ON(!is_x86_pmu(pmu));
>>  	return container_of(pmu, struct x86_hybrid_pmu, pmu);
>>  }
> Given that hybrid_pmu will have PERF_PMU_CAP_EXTENDED_HW_TYPE, and we
> should really only use hyrid_pmu() on one of those, would not the
> simpler patch be so?
>
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..13ec623617a9 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -779,6 +779,7 @@ struct x86_hybrid_pmu {
>  
>  static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
>  {
> +	BUG_ON(!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE));

It looks we can't add either !is_x86_pmu(pmu) or !(pmu->capabilities &
PERF_PMU_CAP_EXTENDED_HW_TYPE) here. hybrid_pmu() is called by the hybrid()
marco or other variants, and hybrid() macro is called in many places of the
intel_pmu_init(), like the update_pmu_cap() , but the flag
PERF_PMU_CAP_EXTENDED_HW_TYPE is still not set for the hybrid
pmu->capabilities until intel_pmu_init() ends and the hybrid pmus are
registered. Then it would cause the unexpected kernel crash.

[    1.945128] kernel BUG at arch/x86/events/intel/../perf_event.h:798!
[    1.946131] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[    1.947127] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
7.0.0-rc3-perf-urgent-gc8b4b538960c #460 PREEMPT(full)
[    1.947127] Hardware name: Intel Corporation Panther Lake Client
Platform/PTL-UH LP5 T3 RVP1, BIOS PTLPFWI1.R00.3171.D00.2504220409 04/22/2025
[    1.947127] RIP: 0010:intel_pmu_init+0x25c9/0x5fd0
[    1.947127] Code: db 44 ff 4c 89 35 c7 da 44 ff 48 89 2d 80 da 44 ff e9
49 df ff ff 83 7a 68 04 0f 84 1b f9 ff ff f6 42 6d 01 0f 85 11 f9 ff ff
<0f> 0b 31 d2 48 89 df
[    1.947127] RSP: 0000:ffffd5dc800f7db8 EFLAGS: 00010246
[    1.947127] RAX: 0000000000000001 RBX: 00000000000abfff RCX:
0000000000000000
[    1.947127] RDX: ffff8f40856bc000 RSI: 0000000000000001 RDI:
00000000000000ff
[    1.947127] RBP: 0000000000000001 R08: ffffffffffffffff R09:
0000000000000004
[    1.947127] R10: ffffffffbd4e2500 R11: 0000000000000006 R12:
ffffffffbc26438b
[    1.947127] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
[    1.947127] FS:  0000000000000000(0000) GS:ffff8f482214f000(0000)
knlGS:0000000000000000
[    1.947127] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.947127] CR2: ffff8f47ff7ff000 CR3: 00000004c1434001 CR4:
0000000000f70ef0
[    1.947127] PKRU: 55555554
[    1.947127] Call Trace:
[    1.947127]  <TASK>
[    1.947127]  ? __pfx_init_hw_perf_events+0x10/0x10
[    1.947127]  init_hw_perf_events+0x2af/0x4b0
[    1.947127]  ? __pfx_init_hw_perf_events+0x10/0x10
[    1.947127]  do_one_initcall+0x52/0x250
[    1.947127]  ? _raw_spin_unlock+0x18/0x40
[    1.947127]  ? __register_sysctl_table+0x143/0x1a0
[    1.947127]  kernel_init_freeable+0x21d/0x340
[    1.947127]  ? __pfx_kernel_init+0x10/0x10
[    1.947127]  kernel_init+0x1a/0x1c0
[    1.947127]  ret_from_fork+0xcb/0x1c0
[    1.947127]  ? __pfx_kernel_init+0x10/0x10
[    1.947127]  ret_from_fork_asm+0x1a/0x30
[    1.947127]  </TASK>
[    1.947127] Modules linked in:
[    1.947127] ---[ end trace 0000000000000000 ]---
[    1.948128] RIP: 0010:intel_pmu_init+0x25c9/0x5fd0
[    1.949128] Code: db 44 ff 4c 89 35 c7 da 44 ff 48 89 2d 80 da 44 ff e9
49 df ff ff 83 7a 68 04 0f 84 1b f9 ff ff f6 42 6d 01 0f 85 11 f9 ff ff
<0f> 0b 31 d2 48 89 df
[    1.950129] RSP: 0000:ffffd5dc800f7db8 EFLAGS: 00010246
[    1.951128] RAX: 0000000000000001 RBX: 00000000000abfff RCX:
0000000000000000
[    1.952128] RDX: ffff8f40856bc000 RSI: 0000000000000001 RDI:
00000000000000ff
[    1.953128] RBP: 0000000000000001 R08: ffffffffffffffff R09:
0000000000000004
[    1.954129] R10: ffffffffbd4e2500 R11: 0000000000000006 R12:
ffffffffbc26438b
[    1.955128] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000000000000
[    1.956128] FS:  0000000000000000(0000) GS:ffff8f482214f000(0000)
knlGS:0000000000000000
[    1.957128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.958128] CR2: ffff8f47ff7ff000 CR3: 00000004c1434001 CR4:
0000000000f70ef0
[    1.959128] PKRU: 55555554
[    1.960128] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b

I'm not sure if we can move the flag PERF_PMU_CAP_EXTENDED_HW_TYPE setting
earlier and eventually find a good place to set the flag. Even it's
possible, but could be risky ... 

Ian, if you don't object, I would suggest to drop the bug_on(). I would
adopt other changes and add the is_x86_pmu() check in the
x86_pmu_has_rdpmc_user_disable() to fix the issue.

Thanks.

>  	return container_of(pmu, struct x86_hybrid_pmu, pmu);
>  }
>  
