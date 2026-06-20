Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B75F9E8
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jun 2026 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781914654; cv=none; b=WLvkGu5woHlBNahGxvTzD+UC13Nxi5IM1rFUu0YJE68y2jpSxTQ+DVL7/a/lXRfzkKMOmNIl2bo0YLSefq1X/vyUECspp5/nKDZ7s+JvFgvE0/pRNEkcy8Cg3wKBJR08/CPoKfMM1WcTpyhlc3KDu1/E69buipXlAKCE7KIplao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781914654; c=relaxed/simple;
	bh=Nqsk4Zu4JolJ+B6jTUvDukOe6zy9SGYRUikAhIfBnTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnHsJW2AQVOAmdNaOsq3kkiAit/blzUf2Qz8Bje+QJGWTcTPURA617vcpVg7Cv36WsrmsTUzOzl+lpktkY3UYpSolUT/4huxbkbJ414amZhSzuSIkN5FJsnK5rr6mJlT/DrKgPgW+fRE91OzCWzymqvh4+9OHw2XU/fogFX3UC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I8RV7s3U; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I8RV7s3U"
Message-ID: <e16f8195-c718-468d-a8a1-6abe66ea58b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781914641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuPKe4x7LtSDO7Ti95/VsJ0ejzbHENLWtMSvb8zGfqw=;
	b=I8RV7s3U/Gn/wiPC2ouFoiDntE0JDwv3RxnxSG+gZtq7QvbBEF83rwL9RkTGylwSAJ1Gm/
	MHgCc/Ci4YuTHkDJX59PckWiJ71lmVlfh0u8pSwNgkPr1+Mjpc7yGJvwb/1bGQWwEzikMQ
	81Q1PHqNxsi2vMm4yj2R1SNIZGWGjww=
Date: Fri, 19 Jun 2026 17:17:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 10/21] RISC-V: perf: Restructure the SBI PMU code
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260608-counter_delegation-v6-10-285b72ed65a9@meta.com>
 <20260609061839.70B9B1F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609061839.70B9B1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:18 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] NULL pointer dereference when tearing down the PMU on error paths in probe.
> - [High] Missing cleanup on error paths in rvpmu_device_probe() leads to Use-After-Free and resource leaks.
> - [High] Broadcasting `SCOUNTEREN` updates to all CPUs in `mm_cpumask` leaks counter access to userspace.
> --
>
> commit 497e3337649afaedc330eca31dba2dda185d6179
> Author: Atish Patra <atishp@rivosinc.com>
>
>      RISC-V: perf: Restructure the SBI PMU code
>      
>      With Ssccfg/Smcdeleg, supervisor mode can program and access the hpmcounters
>      and events directly, without the SBI PMU extension. The SBI PMU extension is
>      still required for firmware counters. Restructure the existing SBI PMU code so
>      the hpmcounter/event helpers can be shared between the SBI and the counter
>      delegation paths that follow.
>
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 385af5e6e6d0d..7f21c16003f04 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
> [ ... ]
>
>> @@ -1305,7 +1349,7 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>>   	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>>   }
> [Severity: Critical]
> This is a pre-existing issue, but does this code cause a NULL pointer
> dereference on error paths?
>
> In rvpmu_device_probe(), if an error occurs (such as perf_pmu_register(),
> pmu_sbi_snapshot_alloc(), or cpuhp_state_add_instance() failing), the error
> path jumps to out_unregister and calls riscv_pmu_destroy().
>
> Because cpuhp_state_add_instance() either was not called yet, or failed and
> did not hash the node, pmu->node.pprev is NULL. The function
> cpuhp_state_remove_instance() does not check if the node is unhashed and
> directly calls hlist_del(). This attempts to write to the previous node
> pointer, which crashes the kernel with a NULL pointer dereference.

Good catch. Fixed in v7.

I will have a separate patch for these fixes.

>> -static void pmu_sbi_event_init(struct perf_event *event)
>> +static void rvpmu_event_init(struct perf_event *event)
> [ ... ]
>
>> @@ -1347,14 +1391,14 @@ static void pmu_sbi_event_mapped(struct perf_event *event, struct mm_struct *mm)
>>   	 * that it is possible to do so to avoid any race.
>>   	 * And we must notify all cpus here because threads that currently run
>>   	 * on other cpus will try to directly access the counter too without
>> -	 * calling pmu_sbi_ctr_start.
>> +	 * calling rvpmu_sbi_ctr_start.
>>   	 */
>>   	if (event->hw.flags & PERF_EVENT_FLAG_USER_ACCESS)
>>   		on_each_cpu_mask(mm_cpumask(mm),
>> -				 pmu_sbi_set_scounteren, (void *)event, 1);
>> +				 rvpmu_set_scounteren, (void *)event, 1);
>>   }
> [Severity: High]
> This isn't a bug introduced by this patch, but does broadcasting scounteren
> updates to all CPUs leak counter access to userspace?
>
> When a user-accessible event is mapped, rvpmu_set_scounteren is broadcast
> across all CPUs where the process has threads running. This enables the
> scounteren bit corresponding to event->hw.idx.
>
> However, event->hw.idx is a dynamic, per-CPU hardware counter index allocated
> only on the CPU where the event was scheduled. Broadcasting this index across
> all CPUs in the mask grants userspace access to that specific hardware
> counter slot on CPUs where the event is not running.
>
> Could a thread on another CPU read from that counter slot, potentially leaking
> the count of whatever unrelated perf event is active on that counter?

It's a valid concern. Though it is very difficult to exploit to leak the 
counter values
through this approach as direct user access for programmable counters is 
a niche use case to begin with.

I think we can toggle the scounteren bit in add/delete path to avoid the 
leak. I will experiment
that idea and send a patch.

>> -static void pmu_sbi_event_unmapped(struct perf_event *event, struct mm_struct *mm)
>> +static void rvpmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
> [ ... ]
>
>> @@ -1419,7 +1463,7 @@ static const struct ctl_table sbi_pmu_sysctl_table[] = {
>>   	},
>>   };
>>   
>> -static int pmu_sbi_device_probe(struct platform_device *pdev)
>> +static int rvpmu_device_probe(struct platform_device *pdev)
>>   {
>>   	struct riscv_pmu *pmu = NULL;
>>   	int ret = -ENODEV;
> [Severity: High]
> This is a pre-existing issue, but does this probe function correctly clean
> up resources on error paths?
>
> If initialization fails after perf_pmu_register(), the code jumps to the
> out_unregister label:
>
> out_unregister:
> 	riscv_pmu_destroy(pmu);
>
> out_free:
> 	kfree(pmu);
> 	return ret;
>
> However, riscv_pmu_destroy() does not call perf_pmu_unregister(). This leaves
> the core perf subsystem with a dangling pointer to the freed pmu structure,
> which can lead to a use-after-free when the perf core attempts to access it.
>
> Additionally, the per-CPU memory allocated for pmu->hw_events and the per-CPU
> interrupts requested via request_percpu_irq() are never freed on these error
> paths, resulting in resource leaks.
Nice catch. Fixed in v7.
