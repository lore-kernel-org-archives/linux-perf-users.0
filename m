Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948953;
	b=4zvETRqevUKwJ+u7r5iISxhkG+HIYBXMZwKSB39wzxQ7Y2FNGGtLptUsQWPBWnVkA0gX
	 unJlWgUUUvxJSaDIqgaltB1GSw3ALrjt63N+8rV/adzUwZd8bq6MhDkw/mM4pHdLZhSlY
	 602c3aLyEqG/VPTlDLDM66CM05zDsd+7qZ9J3o8gWHLNpAtLVQYKUzlNNMc3JN5BDYVzf
	 kscKWnDzz2leBqaNjZjF0FylzIISZumyqZi8zS0l/nOqY3cq14oKZo/Rl1OL6QZrX1j0b
	 WRcqRWs1t52AWqoL0fVwMXC/8n7AKqDyxkAoYJDU111Ktmsku/iSPzUon9a24AHgfDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948953;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/9XPprvHUD9hqbMWjP3gxOUQp3kcvVz3rGEGCvJMU2M=;
	b=DKDKX6vcNKGdAHhAv/kR+j8TkFM1pej6/9D+FzW+S80Cevzfe6g5sa6CKoe8l1z18JYd
	 vDwjhLhF4G+KeuBZH4Icla8NqUwPFSOuQqXnItRf2xGmbugb+HyuEqRDkwY+a20Hj11Wm
	 X0Z8hR/VsbDchT7iijGyCHWoUTwXY9R9frbE8tb3C+XdudauBFM8FPqAaKmkMiAe/mAcV
	 fspt6bS9rT2t5qo2AMyukwyXssjH5jfDZpfn+TBa3Tn38l30b11R9vQQZTsdvq7Gaa4DU
	 xQayJQpCBECfArTYCNi1U67l+mRgBszxKyZLiwoNNVIby1QKGbJWn6smgLmdUhvKvhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8Kp1Lt8;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89813606A32F;
	Fri,  6 Nov 2026 07:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89813606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c8Kp1Lt8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793948953; x=1825484953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OUGuNyqryQOFxGNp6nFo4jOyHCw/u/ojLjv23UVGCJs=;
  b=c8Kp1Lt8gMgzUQ2GPZozIt39stwLyYFW0szapPtAN9Ep3CLhM0miZhTB
   E1Di0H2wLy4m+gDrzIGPjbawa9OUyix06cq5jAf9cao/1MnkiKVL1e9b/
   lkgcm9IUWiPce3VbKvMRaYYCYTnQInYDEoMuJncYmFIOZpj0fs63E9OSO
   Bj9YqOmLChNHxCQHpAQTef2AV15pfEPe/hPdP+87eDwnElw2hwgc5whgb
   9Z/wBuMreKWzDlFmh+U7BiAIx4Ly5UPUevbpOO+pRC4S/CXVxuYrZsq4Q
   WUOx1M7WR0T63jh3PNuTZJFRB8hwnLkN5/QMCJNv1T49ypsMj+3zr+I74
   g==;
X-CSE-ConnectionGUID: Jhvs9FJCSMelWVP8tHmgjg==
X-CSE-MsgGUID: wzg/glsxTzK6+q1L6ZLLbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2857236"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2857236"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:09:11 -0800
X-CSE-ConnectionGUID: 74tMFnRySIy1WUprcNcG8A==
X-CSE-MsgGUID: Hu2US4D2RnKw+lv8RLLzIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8965863"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:09:09 -0800
Message-ID: <254f0864-6576-4054-956a-5eb82bfd298a@linux.intel.com>
Date: Fri, 6 Nov 2026 15:09:07 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 08/20] perf/x86/intel: Avoid re-enabling PMU and LBR
 for BPF when disabled
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-9-dapeng1.mi@linux.intel.com>
 <sashiko-outbox-200793@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <sashiko-outbox-200793@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/6/2026 1:06 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf/x86/intel: cpuc->enabled not cleared in intel_pmu_snapshot_branch_stack()
> --
>
> commit f8f32e2d56da9a93e561d91b6c3fb89e787c5d9e
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled
>
> This commit updates __intel_pmu_snapshot_branch_stack() and its callers
> to save the PMU and LBR enabled state and only re-enable them after
> taking a branch snapshot if they were originally enabled.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 9d8398da1989f..739c454827ac5 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2821,7 +2821,8 @@ static void intel_pmu_enable_all(int added)
>>  
>>  static noinline int
>>  __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>> -				  unsigned int cnt, unsigned long flags)
>> +				  unsigned int cnt, unsigned long flags,
>> +				  int pmu_enabled, int lbr_enabled)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>> @@ -2829,7 +2830,22 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>>  	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>>  
>>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>> -	intel_pmu_enable_all(0);
>> +
>> +	/*
>> +	 * Do not blindly call intel_pmu_enable_all() to re-enable LBR.
>> +	 * This path may be entered from the PMI handler through
>> +	 * bpf_overflow_handler().
>> +	 *
>> +	 * If PMU version < 4, LBR is disabled by the LBR freeze mechanism,
>> +	 * LBR can't be re-enabled here.
>> +	 * If PMU version >= 4, LBR is only frozen instead of disabled,
>> +	 * LBR should be re-enabled here.
>> +	 */
>> +	if (lbr_enabled)
>> +		intel_pmu_lbr_enable_all(false);
>> +	if (pmu_enabled)
>> +		___intel_pmu_enable_all();
>> +
>>  	local_irq_restore(flags);
>>  	return cnt;
>>  }
>> @@ -2837,27 +2853,41 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>>  static int
>>  intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
>>  {
>> +	struct cpu_hw_events *cpuc;
>>  	unsigned long flags;
>> +	int pmu_enabled;
>> +	int lbr_enabled;
>>  
>>  	/* must not have branches... */
>>  	local_irq_save(flags);
>> +	cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	pmu_enabled = cpuc->enabled;
>> +	lbr_enabled = cpuc->lbr_enabled;
>>  	__intel_pmu_disable_all(false); /* we don't care about BTS */
>>  	__intel_pmu_lbr_disable();
>>  	/*            ... until here */
>> -	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
>> +	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags,
>> +						 pmu_enabled, lbr_enabled);
>>  }
>>  
>>  static int
>>  intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
>>  {
>> +	struct cpu_hw_events *cpuc;
>>  	unsigned long flags;
>> +	int pmu_enabled;
>> +	int lbr_enabled;
>>  
>>  	/* must not have branches... */
>>  	local_irq_save(flags);
>> +	cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	pmu_enabled = cpuc->enabled;
>> +	lbr_enabled = cpuc->lbr_enabled;
>>  	__intel_pmu_disable_all(false); /* we don't care about BTS */
>>  	__intel_pmu_arch_lbr_disable();
>>  	/*            ... until here */
>> -	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
>> +	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags,
>> +						 pmu_enabled, lbr_enabled);
>>  }
> [Severity: Medium]
> Should intel_pmu_snapshot_branch_stack() and
> intel_pmu_snapshot_arch_branch_stack() also clear cpuc->enabled = 0
> before calling __intel_pmu_disable_all(false), and restore
> cpuc->enabled = pmu_enabled in __intel_pmu_snapshot_branch_stack()?
>
> While __intel_pmu_lbr_disable() and __intel_pmu_arch_lbr_disable() clear
> cpuc->lbr_enabled = 0, __intel_pmu_disable_all(false) only writes 0 to
> MSR_CORE_PERF_GLOBAL_CTRL without updating cpuc->enabled.
>
> When bpf_get_branch_snapshot() is invoked outside PMI context (where
> cpuc->enabled is 1), local_irq_save() does not mask NMIs. If an in-flight
> PMI or another NMI arrives while __intel_pmu_snapshot_branch_stack() is
> reading the LBRs, perf_event_nmi_handler() -> intel_pmu_handle_irq()
> observes cpuc->enabled == 1 and re-enables the PMU (and LBR on PMU
> version < 4) before returning:

Same with AMD. This issue should never happen in reality since
__intel_pmu_disable_all() would disable PMU, so no PMI can be interrupt the
BPF LBR snapshot.


>
> arch/x86/events/intel/core.c:intel_pmu_handle_irq() {
> 	pmu_enabled = cpuc->enabled;
> 	...
> done:
> 	if (mid_ack)
> 		apic_write(APIC_LVTPC, APIC_DM_NMI);
> 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
> 	cpuc->enabled = pmu_enabled;
> 	if (pmu_enabled)
> 		__intel_pmu_enable_all(true);
> }
>
> Similarly, a nested snapshot from an NMI or fentry/kprobe BPF program
> during __intel_pmu_snapshot_branch_stack() would see cpuc->enabled == 1
> and prematurely call ___intel_pmu_enable_all() before the outer snapshot
> finishes.
>
> Setting cpuc->enabled = 0 is a plain store with no branches, so could it
> be cleared alongside saving pmu_enabled and restored in
> __intel_pmu_snapshot_branch_stack() to match x86_pmu_disable(),
> __intel_pmu_quiesce(), and intel_pmu_handle_irq()?
>
