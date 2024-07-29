Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057315624C;
	Mon, 29 Jul 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265866; cv=none; b=Gl8Xssh0v/xOncnYsIhwSiWCAUaQaJT3mWlotLM70QS5eXt6rmN1rmT94FM4FCr9o5j7SS3UHWoHPkMehFADietK98XI+ncF87X0Wef3S8jhs2z0a5c+6AdP6SYlR00F2WgnXogxgvU8UUNat2z4smRRsC5Df+dZS7cRqyTtePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265866; c=relaxed/simple;
	bh=alzKCTE5dsQxSpcqgyj4UKYtuLeyJc1AtNu8l3lCzho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo7jPW1kcMJz2JGbkqlNMduAyhBtA4kT+A6Y82xl61gDdoVBR12TxcTxk7Dl3TzdvoN5G4RGZmbowj+BhkGme3icpo0Jonc8W2TPV9JUx4d4nlsp7nGyypkHvb3Y7AYBt4mHL4AgWoNCjANPh1LsvH9VcNW2kdeNWZHtBDrkV2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEuVl/kV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEuVl/kV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722265864; x=1753801864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=alzKCTE5dsQxSpcqgyj4UKYtuLeyJc1AtNu8l3lCzho=;
  b=CEuVl/kVn7dgh67usDIpJhQVg+OdjrZasmzQFaJHTZ2Km6wo7VjALMvD
   5luSqjePWYq/6fbNi60F01AlK8L6x9LfRbb8t5MJRyiF8blZWZ8ENmkst
   mI3t7fJGeIZWU7cfBdZ+W6+vKvVse9ofBcH6VBuPB+0X0EiLKqclQonVZ
   cUgzivyZPwyoF5jkIE++LjXVfQo+Cov1yfR+QAH6utMU/jb8GVeyE8fRQ
   UHHo0+1+gwKrqkMPZVpWAotrNOYNIwVeO8lgzWX/JKllnmnxmBO1Da80P
   d/YkNErMbUirBtHjC7z+T07rvSY2nWMiIgRYy4/UuqrJIFHCXwoKqObRQ
   g==;
X-CSE-ConnectionGUID: oCEDddBTTVO/H7stWq+84g==
X-CSE-MsgGUID: yi/KR1+IQwqMX4Rjb3U8jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19731064"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="19731064"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:11:03 -0700
X-CSE-ConnectionGUID: 1ot7KxbXR16p42lzywTy7Q==
X-CSE-MsgGUID: RCINIsxYRuSBf5HarEByOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="59100038"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:11:03 -0700
Received: from [10.212.79.71] (kliang2-mobl1.ccr.corp.intel.com [10.212.79.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 20FFC20BA6EC;
	Mon, 29 Jul 2024 08:11:01 -0700 (PDT)
Message-ID: <0f95d601-418f-4307-bcd1-5fcebac8018f@linux.intel.com>
Date: Mon, 29 Jul 2024 11:10:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/x86: Fix smp_processor_id()-in-preemptible
 warnings
To: Li Huafei <lihuafei1@huawei.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ak@linux.intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240729220928.325449-1-lihuafei1@huawei.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240729220928.325449-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-29 6:09 p.m., Li Huafei wrote:
> The following bug was triggered on a system built with
> CONFIG_DEBUG_PREEMPT=y:
> 
>  # echo p > /proc/sysrq-trigger
> 
>  BUG: using smp_processor_id() in preemptible [00000000] code: sh/117
>  caller is perf_event_print_debug+0x1a/0x4c0
>  CPU: 3 UID: 0 PID: 117 Comm: sh Not tainted 6.11.0-rc1 #109
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x4f/0x60
>   check_preemption_disabled+0xc8/0xd0
>   perf_event_print_debug+0x1a/0x4c0
>   __handle_sysrq+0x140/0x180
>   write_sysrq_trigger+0x61/0x70
>   proc_reg_write+0x4e/0x70
>   vfs_write+0xd0/0x430
>   ? handle_mm_fault+0xc8/0x240
>   ksys_write+0x9c/0xd0
>   do_syscall_64+0x96/0x190
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> This is because the commit d4b294bf84db ("perf/x86: Hybrid PMU support
> for counters") took smp_processor_id() outside the irq critical section.
> If a preemption occurs in perf_event_print_debug() and the task is
> migrated to another cpu, we may get incorrect pmu debug information.
> Move smp_processor_id() back inside the irq critical section to fix this
> issue.
> 
> Fixes: d4b294bf84db ("perf/x86: Hybrid PMU support for counters")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
> v2:
>  - "cpu" and "idx" are defined together.
>  - Use guard(irqsave)() instead of local_irq_save{restore}() to avoid
>    forgetting to restore irq when returning early.
> ---
>  arch/x86/events/core.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 12f2a0c14d33..2cadfdd8dd99 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1521,19 +1521,22 @@ void perf_event_print_debug(void)
>  {
>  	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>  	u64 pebs, debugctl;
> -	int cpu = smp_processor_id();
> -	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> -	unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> -	unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
> -	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
> -	unsigned long flags;
> -	int idx;
> +	int cpu, idx;
> +	struct cpu_hw_events *cpuc;
> +	unsigned long *cntr_mask, *fixed_cntr_mask;
> +	struct event_constraint *pebs_constraints;
> +
> +	guard(irqsave)();
> +
> +	cpu = smp_processor_id();
> +	cpuc = &per_cpu(cpu_hw_events, cpu);
> +	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> +	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
> +	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
>  
>  	if (!*(u64 *)cntr_mask)
>  		return;
>  
> -	local_irq_save(flags);
> -
>  	if (x86_pmu.version >= 2) {
>  		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>  		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
> @@ -1577,7 +1580,6 @@ void perf_event_print_debug(void)
>  		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
>  			cpu, idx, pmc_count);
>  	}
> -	local_irq_restore(flags);
>  }
>  
>  void x86_pmu_stop(struct perf_event *event, int flags)
