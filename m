Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8F04457B6
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745769; cv=none; b=XJlZYzZ/1WIE5STuZp1rxxFtAatrfsqqWVQ1eQCh4RgSy9/O5oRkPqVsCFcV7FGfylvaDeDTvdmEvt9F5zXV9Rgw6KuqGYeaxtbZVv9BnErjQd/S4IUBzBKV/o86YRYz3oTlZByLsDHhxnq8fJFyM1hSon0o3p8lzDZX5DUU1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745769; c=relaxed/simple;
	bh=UpkkLVhcUdbV4sHkaLil4o/61r82DGsnOUXMquq08gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r05OT6wuRlM1JTfi9BRpKZ7erwIORmKVASot8MByWZrCMn3eTEHLF9q9FGbndYC3sWiuD0D8xkSlrsmQaPit4xiEvD3wM3pzHpnFGLRKrtY0lawcZZEQ388F1kb0oBP41dVOztqKDfJ+6YRhuf6aoOb8IlDH46OF5ZZ9krnmLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OWShmEZS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OWShmEZS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A990F1595;
	Wed, 22 Jul 2026 11:42:41 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E28D03F59E;
	Wed, 22 Jul 2026 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784745765; bh=UpkkLVhcUdbV4sHkaLil4o/61r82DGsnOUXMquq08gs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OWShmEZSOMqFrSAc1zqVaBsfBPkVAiS2i09Q1XprvrOIH7LcYSMSFmUgSlfKDhKOk
	 O8GAC3nAlIEkJ1oHBWCkGD07+aHbIsPX1AlX0ZlDA4LZth7hldqId7O91S0k5FcoO1
	 umDWV3/0B6b4hEL1SCBSKhb9eRzN1c97ZAzr5XGk=
Message-ID: <30da4613-dfc3-4126-8873-f6320a3db0bf@arm.com>
Date: Wed, 22 Jul 2026 19:42:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf: Generic hotplug/cpumask for system PMUs
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1784653319.git.robin.murphy@arm.com>
 <b8aae1114794a348ecfb4e9cf7a792b3ac300d56.1784653319.git.robin.murphy@arm.com>
 <20260722173816.3E7AF1F000E9@smtp.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260722173816.3E7AF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2026 6:38 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential issue(s) to consider:
> - [Critical] Taking a CPU offline triggers a NULL pointer dereference if a PMU defines `init_cpu` but not `exit_cpu`.
> - [High] CPU online context migration passes the new CPU as both source and destination to `perf_pmu_migrate_context`, causing a self-deadlock and failing to migrate events.
> - [High] When a PMU is unregistered, the perf core fails to invoke the `pmu->exit_cpu()` callback for currently online CPUs, leaking state.
> - [High] Missing bounds check in `perf_event_setup_cpumask` leads to an out-of-bounds per-CPU pointer access during migration.
> - [High] `perf_pmu_register()` invokes the PMU's `init_cpu` callback in atomic IPI context, contradicting its documented thread context.
> - [Medium] Secondary CPU hotplug triggers a `WARN_ON_ONCE` because `perf_event_setup_cpumask` incorrectly iterates up to `PERF_PMU_SCOPE_CPUMASK`.
> - [Medium] PMUs using `PERF_PMU_SCOPE_CPUMASK` with static masks but no hotplug callbacks will never have their context migrated on CPU offline.
> - [Medium] If `perf_pmu_register()` fails during the IDR allocation step, it leaks the CPU-affine state initialized via `pmu->init_cpu()`.
> --
> 
> --- Patch [1]: [PATCH 1/2] perf: Generic hotplug/cpumask for system PMUs ---
> commit aa795c7bb07889a3ee4d3e9c388a299913298dba
> Author: Robin Murphy <robin.murphy@arm.com>
> 
> perf: Generic hotplug/cpumask for system PMUs
> 
> This commit extends the generic uncore machinery to handle system PMUs
> by introducing a new PERF_PMU_SCOPE_CPUMASK scope. It allows the core
> code to retrieve a per-PMU cpumask dynamically and adds optional callbacks
> to manage CPU-affine state during hotplug operations.
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index ba5bd6a78fe7b..505cbda2ac41f 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> 
> [ ... ]
> 
>> @@ -12920,6 +12945,16 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
>>   	INIT_LIST_HEAD(&pmu->events);
>>   	spin_lock_init(&pmu->events_lock);
>>   
>> +	/*
>> +	 * Finally, if appropriate give the PMU a chance to initialise any
>> +	 * of its own CPU-affine state. Note that we're serialised against
>> +	 * perf_event_{init,exit}_cpu() themselves by virtue of pmus_lock.
>> +	 */
>> +	if (pmu->init_cpu) {
>> +		for_each_online_cpu(cpu)
>> +			smp_call_function_single(cpu, perf_scope_init_cpu, pmu, 1);
>> +	}
>> +
> 
> [Severity: High]
> Does executing init_cpu via smp_call_function_single() conflict with the
> header documentation?
> 
> The documentation states init_cpu runs from CPUHP_AP_PERF_ONLINE context,
> which is preemptible.

The documentation states it runs from there *and* once upon initial 
registration. This is the initial registration.

> However, smp_call_function_single() executes the
> callback in atomic IPI context. If a driver sleeps here, will it cause a
> panic?

Probably they just shouldn't sleep, since the vast majority of cases are 
basically only to invoke irq_set_affinity() anyway. Hence it didn't seem 
worth overcomplicating the initial design, but if something does turn 
out to really need a thread, it could be done.

> [Severity: Medium]
> If idr_cmpxchg() fails shortly after this initialization loop, does this
> leak the newly allocated CPU-affine state?
> 
> There doesn't appear to be an error path to invoke exit_cpu on the online CPUs
> to unwind this initialization.
> 
> [Severity: High]
> While not explicitly in this diff, since this function sets up CPU-affine
> state for a PMU during registration, is there a corresponding teardown step
> missing?
> 
> It appears perf_pmu_unregister() doesn't invoke exit_cpu across the online
> CPUs, which could leave this state dangling when a driver is unloaded.

The expectation is that drivers should be able to clean up without 
requiring explicit teardown calls. This cpu_init call is really just to 
allow picking _some_ initial affinity at the right point in the process 
to avoid the races, without having to have some additional dedicated 
method just for that.

>>   	/*
>>   	 * Now that the PMU is complete, make it visible to perf_try_init_event().
>>   	 */
> 
> [ ... ]
> 
>> @@ -15189,10 +15225,19 @@ static void perf_event_clear_cpumask(unsigned int cpu)
>>   
>>   	/* migrate */
>>   	list_for_each_entry(pmu, &pmus, entry) {
>> +		bool cpumask_migrate = false;
>> +
>> +		if (pmu->init_cpu && (!pmu->cpumask || cpumask_test_cpu(cpu, pmu->cpumask)))
>> +			cpumask_migrate = pmu->exit_cpu(pmu, cpu);
>> +
> 
> [Severity: Critical]
> Is there a risk of a NULL pointer dereference here?

Oops, just a copy-paste error.

> This code checks if pmu->init_cpu is present, but then invokes
> pmu->exit_cpu. Because both callbacks are optional, a PMU driver might
> define init_cpu but leave exit_cpu as NULL.
> 
>>   		if (pmu->scope == PERF_PMU_SCOPE_NONE ||
>>   		    WARN_ON_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE))
>>   			continue;
>>   
>> +		target[PERF_PMU_SCOPE_CPUMASK] = -1;
>> +		if (cpumask_migrate && !WARN_ON_ONCE(!pmu->cpumask))
>> +			target[PERF_PMU_SCOPE_CPUMASK] = cpumask_any_but(pmu->cpumask, cpu);
>> +
> 
> [Severity: Medium]
> Does this strand PMU contexts for PMUs that use a static cpumask without
> providing hotplug callbacks?
> 
> Since cpumask_migrate defaults to false and is only set if a callback
> is invoked, target[PERF_PMU_SCOPE_CPUMASK] remains -1 and the migration
> seems to be bypassed, leaving the context orphaned on the offline CPU.

The idea of a driver which sets PERF_PMU_SCOPE_CPUMASK but does not 
provide init_cpu/exit_cpu was kind of in case of CPU-coupled devices 
which want to provide per-CPU events for some fixed subset of CPUs. I'm 
not sure any such thing exists, but it seems like more work to actively 
forbid it than to leave the possibility open...

> 
>>   		if (target[pmu->scope] >= 0 && target[pmu->scope] < nr_cpu_ids)
>>   			perf_pmu_migrate_context(pmu, cpu, target[pmu->scope]);
>>   	}
> 
> [ ... ]
> 
>> @@ -15246,7 +15292,7 @@ static void perf_event_setup_cpumask(unsigned int cpu)
>>   		goto end;
>>   	}
>>   
>> -	for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
>> +	for (scope = PERF_PMU_SCOPE_NONE + 1; scope <= PERF_PMU_SCOPE_CPUMASK; scope++) {
> 
> [Severity: Medium]
> Does iterating up to PERF_PMU_SCOPE_CPUMASK unconditionally trigger a
> warning during secondary CPU hotplug?

Oops, could have sworn I fixed that... For these loops I initially had 
"< PERF_PMU_SCOPE_CPUMASK", decided that "<= PERF_PMU_SCOPE_SYS_WIDE" 
might be clearer, apparently somehow this one got stuck in-between.

> For this scope, perf_scope_cpumask() explicitly returns NULL, which would
> immediately trip the WARN_ON_ONCE(!pmu_cpumask || !cpumask) check later in
> this loop.
> 
>>   		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(scope, cpu);
>>   
>>   		pmu_cpumask = perf_scope_cpumask(scope);
> 
> [ ... ]
> 
>> @@ -15258,6 +15304,16 @@ static void perf_event_setup_cpumask(unsigned int cpu)
>>   		    cpumask_any_and(pmu_cpumask, cpumask) >= nr_cpu_ids)
>>   			cpumask_set_cpu(cpu, pmu_cpumask);
>>   	}
>> +
>> +	/* Allow migrating if the new CPU is preferable (e.g. NUMA locality) */
>> +	list_for_each_entry(pmu, &pmus, entry) {
>> +		bool cpumask_migrate = false;
>> +
>> +		if (pmu->init_cpu && (!pmu->cpumask || !cpumask_test_cpu(cpu, pmu->cpumask)))
>> +			cpumask_migrate = pmu->init_cpu(pmu, cpu);
>> +		if (cpumask_migrate && !WARN_ON_ONCE(!pmu->cpumask))
>> +			perf_pmu_migrate_context(pmu, cpu, cpumask_any(pmu->cpumask));
>> +	}
> 
> [Severity: High]
> Will this cause a self-deadlock in perf_pmu_migrate_context()?
> 
> The newly onlined CPU is passed as both the source CPU (cpu) and
> potentially the destination CPU (via cpumask_any). This would lock the same
> mutex twice in perf_pmu_migrate_context():
> 
> kernel/events/core.c:perf_pmu_migrate_context() {
>      ...
>      mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
>      ...
> }
> 
> Should this be migrating from the old CPU to the new CPU instead?

Ooh, now that is a real bug. Indeed this isn't the same as the exit_cpu 
path, it needs to be in fully inverse order such that we sample the 
cpumask *before* init_cpu might update it.

> [Severity: High]
> What happens if the PMU cpumask is empty here?

Then the driver has done something egregiously wrong. However I guess 
since I do already have the WARN condition (for a misbehaving 
hotplug-only driver invalidly requesting migration), I may as well add 
cpumask_empty() to that as well.

Robin.

> If init_cpu returns true but the PMU's mask is empty (for example, if it
> defaulted to cpu_none_mask), cpumask_any() could return a value greater
> than or equal to nr_cpu_ids. Passing this out-of-bounds value to
> perf_pmu_migrate_context() might result in corrupting memory when it accesses
> the per-CPU pointers.
> 
>>   end:
>>   	cpumask_set_cpu(cpu, perf_online_mask);
>>   }
> 

