Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C571CEAA2;
	Wed, 23 Oct 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703393; cv=none; b=SL/Xa6Et4pUJs7ZIFmCvBcYQOC2p49bzbT0jyCtWOLVOnyzmsYYmaOoSIQDoHQv6Mql5QzxzrCv05BVmeNIl3vH9mo512iKVjio+Gaqq2rRcJNOqAf2WWl4KqgoNwJGUzRfYKkQIJxNCEuk/OtoO+zLaVFbKOZn6QcX20EJCr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703393; c=relaxed/simple;
	bh=Cg6sJexjYbzrv+cP7qxNk7rCDRXghi3QsRiTvK2Cxf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dlNegh9rGfLWngts19yohIpcDR2FZurJOhTwPh5uxGpaWlGUWKZpE6V+D6qCHR7nDM6MJrAlmuYmviq/IPHurqv29b60d1YPcU/kLS0A4oXRIW65MzAHfdOUdXX8zQxgnbD9Engz6TXXVGTaG12NFyiiqx44FKYOh3AEQ+9gMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxxA4xdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxxA4xdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5316CC4CEC6;
	Wed, 23 Oct 2024 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729703392;
	bh=Cg6sJexjYbzrv+cP7qxNk7rCDRXghi3QsRiTvK2Cxf0=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=CxxA4xdgFa+ycOMIhsVazHuiCJ3OWunJoPtgBIQWmhuKmruhyHMtIdML+0B8IDoOE
	 vBWdsaA3HQl6OwEhyAxDY6p+klKEX3YrujLb9HKUmiN+7KHGP6BULwa37UBx7XIZTy
	 DmUgUId8f5eFaykn2Y35HCkY3HJ6j9gpAtLYy7WM/sfXD4EkNZtOiG9BxTf0VzDdSC
	 Lvdl/ccZcfY/o5b6zUpXlbmnQ8CiEStID24ba+wwzSlDWFCQ0RYmJZK/YWR3Zo9wU+
	 6hQLEaVh9KbV98WS2Z4IvOKinUs4QT3Fe+kXZcEfSAfERYdi/DUGDNVu/WU1Gi7Ci8
	 wxAuzFnxS20YA==
Message-ID: <f856d105-5463-4b8b-8715-0e6871165616@kernel.org>
Date: Wed, 23 Oct 2024 19:09:47 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/7] perf: Generic hotplug support for a PMU with a scope
Content-Language: en-GB
To: kan.liang@linux.intel.com
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-2-kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 linux-perf-users@vger.kernel.org
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240802151643.1691631-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kan Liang,

(+ cc Perf ML)

On 02/08/2024 17:16, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The perf subsystem assumes that the counters of a PMU are per-CPU. So
> the user space tool reads a counter from each CPU in the system wide
> mode. However, many PMUs don't have a per-CPU counter. The counter is
> effective for a scope, e.g., a die or a socket. To address this, a
> cpumask is exposed by the kernel driver to restrict to one CPU to stand
> for a specific scope. In case the given CPU is removed,
> the hotplug support has to be implemented for each such driver.
> 
> The codes to support the cpumask and hotplug are very similar.
> - Expose a cpumask into sysfs
> - Pickup another CPU in the same scope if the given CPU is removed.
> - Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
> - In event init, always set the CPU in the cpumask to event->cpu
> 
> Similar duplicated codes are implemented for each such PMU driver. It
> would be good to introduce a generic infrastructure to avoid such
> duplication.
> 
> 5 popular scopes are implemented here, core, die, cluster, pkg, and
> the system-wide. The scope can be set when a PMU is registered. If so, a
> "cpumask" is automatically exposed for the PMU.
> 
> The "cpumask" is from the perf_online_<scope>_mask, which is to track
> the active CPU for each scope. They are set when the first CPU of the
> scope is online via the generic perf hotplug support. When a
> corresponding CPU is removed, the perf_online_<scope>_mask is updated
> accordingly and the PMU will be moved to a new CPU from the same scope
> if possible.

Thank you for the patch.

It looks like this modification causes the following warning on my side
when shutting down a VM running a kernel built with a debug config
including CONFIG_PROVE_RCU_LIST=y (and CONFIG_RCU_EXPERT=y):


> # /usr/lib/klibc/bin/poweroff
> 
> =============================
> WARNING: suspicious RCU usage
> 6.12.0-rc3+ #3 Not tainted
> -----------------------------
> kernel/events/core.c:13962 RCU-list traversed in non-reader section!!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 3 locks held by poweroff/11748:
>  #0: ffffffff9b441e28 (system_transition_mutex){+.+.}-{3:3}, at: __do_sys_reboot (kernel/reboot.c:770)
>  #1: ffffffff9b43eab0 ((reboot_notifier_list).rwsem){++++}-{3:3}, at: blocking_notifier_call_chain (kernel/notifier.c:388)
>  #2: ffffffff9b6d06c8 (pmus_lock){+.+.}-{3:3}, at: perf_event_exit_cpu_context (kernel/events/core.c:13983)
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 11748 Comm: poweroff Not tainted 6.12.0-rc3+ #3
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> Call Trace:
>  <TASK>
>  dump_stack_lvl (lib/dump_stack.c:123)
>  lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
>  perf_event_clear_cpumask (kernel/events/core.c:13962 (discriminator 9))
>  ? __pfx_perf_event_clear_cpumask (kernel/events/core.c:13939)
>  ? acpi_execute_simple_method (drivers/acpi/utils.c:679)
>  ? __pfx_acpi_execute_simple_method (drivers/acpi/utils.c:679)
>  ? md_notify_reboot (drivers/md/md.c:9860)
>  perf_event_exit_cpu_context (kernel/events/core.c:13984 (discriminator 1))
>  perf_reboot (kernel/events/core.c:14066 (discriminator 3))
>  ? trace_notifier_run (include/trace/events/notifier.h:59 (discriminator 2))
>  notifier_call_chain (kernel/notifier.c:93)
>  blocking_notifier_call_chain (kernel/notifier.c:389)
>  kernel_power_off (kernel/reboot.c:294)
>  __do_sys_reboot (kernel/reboot.c:771)
>  ? __pfx___do_sys_reboot (kernel/reboot.c:717)
>  ? __pfx_ksys_sync (fs/sync.c:98)
>  do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1))
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)


It is very easy for me to reproduce it: simply by stopping the VM. Just
in case, here are the steps I used to have the same VM:

  $ cd [kernel source code]
  $ echo true > .virtme-exec-run
  $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug -e RCU_EXPERT -e PROVE_RCU_LIST


I have one question below about the modification you did here.

(...)

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aa3450bdc227..5e1877c4cb4c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

(...)

> @@ -13730,6 +13816,40 @@ static void __perf_event_exit_context(void *__info)
>  	raw_spin_unlock(&ctx->lock);
>  }
>  
> +static void perf_event_clear_cpumask(unsigned int cpu)
> +{
> +	int target[PERF_PMU_MAX_SCOPE];
> +	unsigned int scope;
> +	struct pmu *pmu;
> +
> +	cpumask_clear_cpu(cpu, perf_online_mask);
> +
> +	for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
> +		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(scope, cpu);
> +		struct cpumask *pmu_cpumask = perf_scope_cpumask(scope);
> +
> +		target[scope] = -1;
> +		if (WARN_ON_ONCE(!pmu_cpumask || !cpumask))
> +			continue;
> +
> +		if (!cpumask_test_and_clear_cpu(cpu, pmu_cpumask))
> +			continue;
> +		target[scope] = cpumask_any_but(cpumask, cpu);
> +		if (target[scope] < nr_cpu_ids)
> +			cpumask_set_cpu(target[scope], pmu_cpumask);
> +	}
> +
> +	/* migrate */
> +	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {


Here is the line causing the warning, because rcu_read_lock() is not
used before.

I don't know this code, but I guess you are not only doing read
operations here if you are migrating something, right? This operation is
done under the "pmus_lock", maybe the "_rcu" variant is not needed here?

So just using this instead is maybe enough?

  list_for_each_entry(pmu, &pmus, entry) {


> +		if (pmu->scope == PERF_PMU_SCOPE_NONE ||
> +		    WARN_ON_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE))
> +			continue;
> +
> +		if (target[pmu->scope] >= 0 && target[pmu->scope] < nr_cpu_ids)
> +			perf_pmu_migrate_context(pmu, cpu, target[pmu->scope]);
> +	}
> +}
> +
>  static void perf_event_exit_cpu_context(int cpu)
>  {
>  	struct perf_cpu_context *cpuctx;
> @@ -13737,6 +13857,11 @@ static void perf_event_exit_cpu_context(int cpu)
>  
>  	// XXX simplify cpuctx->online
>  	mutex_lock(&pmus_lock);
> +	/*
> +	 * Clear the cpumasks, and migrate to other CPUs if possible.
> +	 * Must be invoked before the __perf_event_exit_context.
> +	 */
> +	perf_event_clear_cpumask(cpu);
>  	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
>  	ctx = &cpuctx->ctx;
>  
> @@ -13744,7 +13869,6 @@ static void perf_event_exit_cpu_context(int cpu)
>  	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
>  	cpuctx->online = 0;
>  	mutex_unlock(&ctx->mutex);
> -	cpumask_clear_cpu(cpu, perf_online_mask);
>  	mutex_unlock(&pmus_lock);
>  }
>  #else
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

