Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B967155CBF;
	Mon, 29 Jul 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263161; cv=none; b=RaTcoEZM+ES8J28LuooK6RF+h0s9nndF3cPaYZAi4epyC2sn6C06fB3Z9lDgQLypGthwMCMBSIlZqiLA8OC4HeQHxSVwS0pJINLZTF881e3S03bW5ui4WknDLMOI6rvUHICdNx7rGSwdeNBYr650F9CSh2zSQ2FglBwlH7Pc9i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263161; c=relaxed/simple;
	bh=/nG09U2qE9DSG8vW5H4AZ/C06tGqWTmwc69ow7pFg+A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kRZzIbkM6JzZzdpP/TqkQ9Xtx39QR+MwKpYDtVugZTEZWw+gBaoXk+OPIzSHDdED7jbdVAgSSfwioJZSxs43+BPuaNTEOodNx4SIQjOhjIyiBtIY/MMXk5tiJMmNp6TVxu3sDvudJH/k3sHrhFsnxp+iN87T6qXLU87n6meu6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WXgd31DgpzxVfg;
	Mon, 29 Jul 2024 22:25:43 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 51514180064;
	Mon, 29 Jul 2024 22:25:52 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 22:25:51 +0800
Subject: Re: [PATCH v2] perf/x86: Fix smp_processor_id()-in-preemptible
 warnings
To: <peterz@infradead.org>, <mingo@redhat.com>, <kan.liang@linux.intel.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>
CC: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <ak@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240729220928.325449-1-lihuafei1@huawei.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <5611daa0-f463-08e5-2db1-0612531d55da@huawei.com>
Date: Mon, 29 Jul 2024 22:25:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240729220928.325449-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)

Sorry Prateek, I forgot to Cc you.

On 2024/7/30 6:09, Li Huafei wrote:
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
> 
