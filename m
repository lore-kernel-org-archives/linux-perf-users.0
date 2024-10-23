Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4B83CDA;
	Wed, 23 Oct 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705609; cv=none; b=GUekV45372FWoxuiA1Ua+0MUCcvU2hv6suQ2qWzzv9fUx0M91IoQJg2qDWGo2ITYsLC4NoT0UT9eHi6y/NmMLAI7XUhNqIywo9nBupAgaeb/CTmnYLLn83+mo1AK6Mb0d0FaFsDiI13p/VUYmUZmsmBUrbg2q2hBDMDiyv1GgWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705609; c=relaxed/simple;
	bh=DU8+bg5SNI4oXTTw77GkxJG0vawcjUiseS+OAiYnRYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrLVmMpDil8Fz0CtTzxKbBovGXjR0d07FkE930k6gMPHv4O0v3JoC3d9vnw8oALiTCKTDpuS0VnJugEMzz1QtxjbxrepfFdFWWCECyP4rmJeA4ZzSprDh0kajitgS+azifLtRw+NYIQ8OdkluUfbkVKdGrouvh77T8nnLmdZ6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZWaYWvd; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZWaYWvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729705608; x=1761241608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DU8+bg5SNI4oXTTw77GkxJG0vawcjUiseS+OAiYnRYc=;
  b=ZZWaYWvdueaYV9murWrfg2Rzu2GJVLSdcsGCZFETrV4UrzI59+kMd3F6
   rX/LpVI26QODsz91ijLDOxgDzT5rq0QQrQEBqHKXZHRuN7y5HeGaF7nju
   UZDjyHtNTYUDdyg/rFrjQvaVF6dcKREDf9MTjg/lMU0M0tBnaoD2H7paA
   +2nExkyFPJrl6lxeuf8AptIjpFUdWNVwaG+Upu302JaY0dt3bHJsxIQdO
   hjn5U0ZpXuvcMC93TiL87DWFLf6pKNVWN3J4N9VlKFwV2d8D8cymyDwAc
   D2j2Psvn6O/tDrZ7PDUE+PpXtxWxaR5Sy/D9W23SfbPdxODsNi0aNPwNF
   A==;
X-CSE-ConnectionGUID: ITExNTphRJSae/Tgbx1Lrg==
X-CSE-MsgGUID: CIfB3vqHS9aUp5+vVXwbQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29411200"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="29411200"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 10:46:47 -0700
X-CSE-ConnectionGUID: oPOVRNMHTgSh+ktrEkYgWQ==
X-CSE-MsgGUID: 1YzJA9nUTgieXeZJSAhBQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84288042"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 10:46:47 -0700
Received: from [10.212.27.194] (kliang2-mobl1.ccr.corp.intel.com [10.212.27.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5080620CFED2;
	Wed, 23 Oct 2024 10:46:45 -0700 (PDT)
Message-ID: <eb552133-829d-4935-87e9-101e052fd40c@linux.intel.com>
Date: Wed, 23 Oct 2024 13:46:43 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] perf: Generic hotplug support for a PMU with a scope
To: Matthieu Baerts <matttbe@kernel.org>
Cc: linux-kernel@vger.kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-2-kan.liang@linux.intel.com>
 <f856d105-5463-4b8b-8715-0e6871165616@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <f856d105-5463-4b8b-8715-0e6871165616@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-10-23 1:09 p.m., Matthieu Baerts wrote:
> Hi Kan Liang,
> 
> (+ cc Perf ML)
> 
> On 02/08/2024 17:16, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The perf subsystem assumes that the counters of a PMU are per-CPU. So
>> the user space tool reads a counter from each CPU in the system wide
>> mode. However, many PMUs don't have a per-CPU counter. The counter is
>> effective for a scope, e.g., a die or a socket. To address this, a
>> cpumask is exposed by the kernel driver to restrict to one CPU to stand
>> for a specific scope. In case the given CPU is removed,
>> the hotplug support has to be implemented for each such driver.
>>
>> The codes to support the cpumask and hotplug are very similar.
>> - Expose a cpumask into sysfs
>> - Pickup another CPU in the same scope if the given CPU is removed.
>> - Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
>> - In event init, always set the CPU in the cpumask to event->cpu
>>
>> Similar duplicated codes are implemented for each such PMU driver. It
>> would be good to introduce a generic infrastructure to avoid such
>> duplication.
>>
>> 5 popular scopes are implemented here, core, die, cluster, pkg, and
>> the system-wide. The scope can be set when a PMU is registered. If so, a
>> "cpumask" is automatically exposed for the PMU.
>>
>> The "cpumask" is from the perf_online_<scope>_mask, which is to track
>> the active CPU for each scope. They are set when the first CPU of the
>> scope is online via the generic perf hotplug support. When a
>> corresponding CPU is removed, the perf_online_<scope>_mask is updated
>> accordingly and the PMU will be moved to a new CPU from the same scope
>> if possible.
> 
> Thank you for the patch.
> 
> It looks like this modification causes the following warning on my side
> when shutting down a VM running a kernel built with a debug config
> including CONFIG_PROVE_RCU_LIST=y (and CONFIG_RCU_EXPERT=y):
> 
> 
>> # /usr/lib/klibc/bin/poweroff
>>
>> =============================
>> WARNING: suspicious RCU usage
>> 6.12.0-rc3+ #3 Not tainted
>> -----------------------------
>> kernel/events/core.c:13962 RCU-list traversed in non-reader section!!
>>
>> other info that might help us debug this:
>>
>>
>> rcu_scheduler_active = 2, debug_locks = 1
>> 3 locks held by poweroff/11748:
>>  #0: ffffffff9b441e28 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot (kernel/reboot.c:770)
>>  #1: ffffffff9b43eab0 ((reboot_notifier_list).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain (kernel/notifier.c:388)
>>  #2: ffffffff9b6d06c8 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context (kernel/events/core.c:13983)
>>
>> stack backtrace:
>> CPU: 0 UID: 0 PID: 11748 Comm: poweroff Not tainted 6.12.0-rc3+ #3
>> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl (lib/dump_stack.c:123)
>>  lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
>>  perf_event_clear_cpumask (kernel/events/core.c:13962 (discriminator 9))
>>  ? __pfx_perf_event_clear_cpumask (kernel/events/core.c:13939)
>>  ? acpi_execute_simple_method (drivers/acpi/utils.c:679)
>>  ? __pfx_acpi_execute_simple_method (drivers/acpi/utils.c:679)
>>  ? md_notify_reboot (drivers/md/md.c:9860)
>>  perf_event_exit_cpu_context (kernel/events/core.c:13984 (discriminator 1))
>>  perf_reboot (kernel/events/core.c:14066 (discriminator 3))
>>  ? trace_notifier_run (include/trace/events/notifier.h:59 (discriminator 2))
>>  notifier_call_chain (kernel/notifier.c:93)
>>  blocking_notifier_call_chain (kernel/notifier.c:389)
>>  kernel_power_off (kernel/reboot.c:294)
>>  __do_sys_reboot (kernel/reboot.c:771)
>>  ? __pfx___do_sys_reboot (kernel/reboot.c:717)
>>  ? __pfx_ksys_sync (fs/sync.c:98)
>>  do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1))
>>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> 
> 
> It is very easy for me to reproduce it: simply by stopping the VM. Just
> in case, here are the steps I used to have the same VM:
> 
>   $ cd [kernel source code]
>   $ echo true > .virtme-exec-run
>   $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-debug -e RCU_EXPERT -e PROVE_RCU_LIST
> 
> 
> I have one question below about the modification you did here.
> 
> (...)
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index aa3450bdc227..5e1877c4cb4c 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> 
> (...)
> 
>> @@ -13730,6 +13816,40 @@ static void __perf_event_exit_context(void *__info)
>>  	raw_spin_unlock(&ctx->lock);
>>  }
>>  
>> +static void perf_event_clear_cpumask(unsigned int cpu)
>> +{
>> +	int target[PERF_PMU_MAX_SCOPE];
>> +	unsigned int scope;
>> +	struct pmu *pmu;
>> +
>> +	cpumask_clear_cpu(cpu, perf_online_mask);
>> +
>> +	for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
>> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(scope, cpu);
>> +		struct cpumask *pmu_cpumask = perf_scope_cpumask(scope);
>> +
>> +		target[scope] = -1;
>> +		if (WARN_ON_ONCE(!pmu_cpumask || !cpumask))
>> +			continue;
>> +
>> +		if (!cpumask_test_and_clear_cpu(cpu, pmu_cpumask))
>> +			continue;
>> +		target[scope] = cpumask_any_but(cpumask, cpu);
>> +		if (target[scope] < nr_cpu_ids)
>> +			cpumask_set_cpu(target[scope], pmu_cpumask);
>> +	}
>> +
>> +	/* migrate */
>> +	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
> 
> 
> Here is the line causing the warning, because rcu_read_lock() is not
> used before.
> 
> I don't know this code, but I guess you are not only doing read
> operations here if you are migrating something, right? This operation is
> done under the "pmus_lock", maybe the "_rcu" variant is not needed here?
> 
> So just using this instead is maybe enough?
> 
>   list_for_each_entry(pmu, &pmus, entry) {

Yes, it's good enough. A patch has been proposed, but haven't been
merged yet.

https://lore.kernel.org/lkml/20240913162340.2142976-1-kan.liang@linux.intel.com/

Thanks,
Kan
> 
> 
>> +		if (pmu->scope == PERF_PMU_SCOPE_NONE ||
>> +		    WARN_ON_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE))
>> +			continue;
>> +
>> +		if (target[pmu->scope] >= 0 && target[pmu->scope] < nr_cpu_ids)
>> +			perf_pmu_migrate_context(pmu, cpu, target[pmu->scope]);
>> +	}
>> +}
>> +
>>  static void perf_event_exit_cpu_context(int cpu)
>>  {
>>  	struct perf_cpu_context *cpuctx;
>> @@ -13737,6 +13857,11 @@ static void perf_event_exit_cpu_context(int cpu)
>>  
>>  	// XXX simplify cpuctx->online
>>  	mutex_lock(&pmus_lock);
>> +	/*
>> +	 * Clear the cpumasks, and migrate to other CPUs if possible.
>> +	 * Must be invoked before the __perf_event_exit_context.
>> +	 */
>> +	perf_event_clear_cpumask(cpu);
>>  	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
>>  	ctx = &cpuctx->ctx;
>>  
>> @@ -13744,7 +13869,6 @@ static void perf_event_exit_cpu_context(int cpu)
>>  	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
>>  	cpuctx->online = 0;
>>  	mutex_unlock(&ctx->mutex);
>> -	cpumask_clear_cpu(cpu, perf_online_mask);
>>  	mutex_unlock(&pmus_lock);
>>  }
>>  #else
> (...)
> 
> Cheers,
> Matt

