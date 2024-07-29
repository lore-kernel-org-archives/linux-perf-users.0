Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D090823A9;
	Mon, 29 Jul 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260596; cv=none; b=JqYN4cOcRvvlvH92uNX0K2Fx/PHIhyWTfHZif/zY9BWZD2UsxWBQGuCnt4REbeqsul8oz5S8N6/qgqXE0wp4T/ik73RC8yucxMZgsnK4AxS7GBp4JbY8wpedUqnesY2ZNKzHPmu/i+50a+RlRsl6+kLaU1+kyiPVP1dR7B24u2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260596; c=relaxed/simple;
	bh=4mQO8KGnT7sHHoH3xV44eI7Vk6adn1X7xSiPoFyNPWg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BTUoXJv6V2h3x/6FcvgqqljyU2ZW/4PpS8VPNWxYgXn++3OHkscvLQJm+Ivv8fg2IIYyUFAd3N8X5wVkeoQURSOsi86UkFX+YciZZicnD5BE8LjwNPi+xeAFT59/iiazeIsvaRGd+PyL1UjsGLd6Tt7o8xnZ/7l5b/UswIIZg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXffs2Tl9znd34;
	Mon, 29 Jul 2024 21:42:13 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id E659F1800D0;
	Mon, 29 Jul 2024 21:43:09 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 21:43:08 +0800
Subject: Re: [PATCH] perf/x86: Fix smp_processor_id()-in-preemptible warnings
To: K Prateek Nayak <kprateek.nayak@amd.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <kan.liang@linux.intel.com>
CC: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <ak@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240729114541.3517574-1-lihuafei1@huawei.com>
 <132ddbbd-5afc-8436-9db6-0f1add4bcec1@amd.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <9f6d6697-9de9-6934-257c-d8724f0db4c6@huawei.com>
Date: Mon, 29 Jul 2024 21:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <132ddbbd-5afc-8436-9db6-0f1add4bcec1@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/7/29 17:13, K Prateek Nayak wrote:
> Hello Huafei,
> 
> On 7/29/2024 5:15 PM, Li Huafei wrote:
>> The following bug was triggered on a system built with
>> CONFIG_DEBUG_PREEMPT=y:
>>
>>   # echo p > /proc/sysrq-trigger
>>
>>   BUG: using smp_processor_id() in preemptible [00000000] code: sh/117
>>   caller is perf_event_print_debug+0x1a/0x4c0
>>   CPU: 3 UID: 0 PID: 117 Comm: sh Not tainted 6.11.0-rc1 #109
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.13.0-1ubuntu1.1 04/01/2014
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x4f/0x60
>>    check_preemption_disabled+0xc8/0xd0
>>    perf_event_print_debug+0x1a/0x4c0
>>    __handle_sysrq+0x140/0x180
>>    write_sysrq_trigger+0x61/0x70
>>    proc_reg_write+0x4e/0x70
>>    vfs_write+0xd0/0x430
>>    ? handle_mm_fault+0xc8/0x240
>>    ksys_write+0x9c/0xd0
>>    do_syscall_64+0x96/0x190
>>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>
>> This is because the commit d4b294bf84db ("perf/x86: Hybrid PMU support
>> for counters") took smp_processor_id() outside the irq critical section.
>> If a preemption occurs in perf_event_print_debug() and the task is
>> migrated to another cpu, we may get incorrect pmu debug information.
>> Move smp_processor_id() back inside the irq critical section to fix this
>> issue.
>>
>> Fixes: d4b294bf84db ("perf/x86: Hybrid PMU support for counters")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>   arch/x86/events/core.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 12f2a0c14d33..c0157a5d8296 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -1521,19 +1521,24 @@ void perf_event_print_debug(void)
>>   {
>>       u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>>       u64 pebs, debugctl;
>> -    int cpu = smp_processor_id();
>> -    struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
>> -    unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
>> -    unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
>> -    struct event_constraint *pebs_constraints = hybrid(cpuc->pmu,
>> pebs_constraints);
>> +    int cpu;
>> +    struct cpu_hw_events *cpuc;好的，我会在v2中修改。
>> +    unsigned long *cntr_mask, *fixed_cntr_mask;
>> +    struct event_constraint *pebs_constraints;
>>       unsigned long flags;
>>       int idx;
> 
> nit. "cpu" and "idx" can be defined together and this can be converted
> to use revere xmas tree order.
> 

Ok, I'll change it in v2.

>>   +    local_irq_save(flags);
> 
> Perhaps use "guard(irqsave)();" here since ...
> 
>> +
>> +    cpu = smp_processor_id();
>> +    cpuc = &per_cpu(cpu_hw_events, cpu);
>> +    cntr_mask = hybrid(cpuc->pmu, cntr_mask);
>> +    fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
>> +    pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
>> +
>>       if (!*(u64 *)cntr_mask)
> 
> ... a "local_irq_restore(flags)" is required here now before returning
> and using the guard can avoid that. Even the flags variable will no
> longer be necessary.
> 

It's really bad, I forgot to restore irq before returning. Using lock
guard can indeed avoid such errors, and I will fix it in v2. Thanks!

> Thoughts?
> 
>>           return;
>>   -    local_irq_save(flags);
>> -
>>       if (x86_pmu.version >= 2) {
>>           rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>>           rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
> 
