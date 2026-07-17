Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374773F8ECA
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294645; cv=none; b=F4/KfSJ2chliGcpC0nVzXf49q5PXdkN82SadVYUxNVMfMryTwYhhrqpri0Z5NuQUYOQ3rKe91wGy2kqZhVgKaKC8/vaqRYSgjyQp7QOVX9o8OZ5LDHclTg7g5ME4mdMjDhqCWbWUbtuAZ1EJtXpml1PZDJP3I5T241CMOx0gnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294645; c=relaxed/simple;
	bh=G4bhqj112gCpm3QmuNViKDj1MezMl6L8mZvfirqxdys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L75TKPHqSkjcFq64jtCYWlEasNT3vNFXH0BdFU9e1wrV/WVUD3L1FP8AypPVfyWVPWHY9Ieq14drPW9fL+v/9RJvMOaAiCn4yerJrrslyFYewXo4w0P+CGDo66+3zJ4k7UWuNYlNidgLzzZdvuXz0EGhIimU7jtT94CUvrYQtBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy/MMupi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy/MMupi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BD51F000E9;
	Fri, 17 Jul 2026 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294643;
	bh=jmZ413dnkyppPCRzrYk6pCAICVg9l3NNwoVkedj1oIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iy/MMupiofu2Cnvj/FqqlkrbO1Qo5zh6iXLC+oY0tRJcCxXfzgrdemMnyPZ3jPdkM
	 otW0eGWfQFIrSadjtEW4dxQ7yRBVh3gtgcuwjUvWX60PjjBASTJuzXwkn92cVpftBG
	 ZTNKxqO8INI7eKgCx6FdUW65o1q0gby9VDuHpuP88E4ONt12OCx0muJBqBEMReSY8r
	 hYKrJq1ejsFu9JITzOBNxBOOTdrIFw1xiVsC/zLm4GdImMSFKAuD+GI913CfpB3//P
	 yk4ykhCp+mNn6p1S0jG3p0pqEVyMRVQL2/KqLPVv/fgFECtYG++bJqV8/qVCJRrvXO
	 Vie/RXXzzML4A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/13] mm/kwatch: add hardware breakpoint backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinchao Wang" <wangjinchao600@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717130520.1902926-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
 <20260717130520.1902926-1-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:24:02 +0000
Message-Id: <20260717132402.E8BD51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Modifying the trace_seq buffer directly during TP_printk argument =
evaluation prepends the stack trace and corrupts the trace output.
- [High] Race condition in CPU offline callback leading to Use-After-Free i=
n the IPI handler.
- [High] Concurrent read and write of the shared `wp->attr` structure acros=
s CPUs can result in torn reads and invalid hardware breakpoint configurati=
on.
- [High] Untracked csd_arm IPIs can execute after the watchpoint is freed i=
f the target CPU goes offline.
- [High] The `wp->arm_tsk` pointer is assigned to `current` without holding=
 a reference, causing a Use-After-Free if the task exits.
- [High] Missing NULL check on `register_wide_hw_breakpoint` return value c=
auses a kernel panic if hardware breakpoints are unsupported.
- [Medium] Newly onlined CPUs are unconditionally forced to watch the dummy=
 address, missing hits if the watchpoint is currently active.
- [Medium] Per-CPU throttling of arm IPIs causes unrelated watchpoints to b=
e silently ignored on remote CPUs.
- [Medium] A race gap between `register_wide_hw_breakpoint` and `cpuhp_setu=
p_state_nocalls` drops watchpoints on concurrently hotplugged CPUs.
--

--- Patch [8]: [RFC PATCH v2 08/13] mm/kwatch: add hardware breakpoint back=
end ---
commit 6c7794f69c285985dbf3f0583ef594237690a973
Author: Jinchao Wang <wangjinchao600@gmail.com>

mm/kwatch: add hardware breakpoint backend

Manage a preallocated pool of wide (per-CPU) perf hardware breakpoints.
All breakpoints are registered up front against a dummy address; arming a
watchpoint only re-points an already-registered event, so the arm path can
run from a kprobe handler.

> diff --git a/include/trace/events/kwatch.h b/include/trace/events/kwatch.h
> index 0000000000000..8a2ec6811ad49
> --- /dev/null
> +++ b/include/trace/events/kwatch.h

[ ... ]

> +	TP_printk("KWatch HIT: time=3D%llu.%06u ip=3D%pS addr=3D0x%lx%s",
> +		  div_u64(__entry->time_ns, 1000000000ULL),
> +		  (unsigned int)(div_u64(__entry->time_ns, 1000ULL) % 1000000ULL),
> +		  (void *)__entry->ip, __entry->addr,
> +		  kwatch_trace_print_stack(p, __get_dynamic_array(stack),
> +					   __entry->stack_nr))

[Severity: High]
Does evaluating kwatch_trace_print_stack() as a TP_printk() argument modify
the trace_seq buffer prematurely?

Because C argument evaluation order is unsequenced, calling trace_seq_print=
f()
directly inside kwatch_trace_print_stack() mutates the trace_seq buffer p
before or while the main format string is processed.

This causes the output to be written out-of-order or truncated.

> diff --git a/mm/kwatch/hwbp.c b/mm/kwatch/hwbp.c
> index 0000000000000..d1e93754cce82
> --- /dev/null
> +++ b/mm/kwatch/hwbp.c

[ ... ]

> +static void kwatch_hwbp_handler(struct perf_event *bp,
> +				struct perf_sample_data *data,
> +				struct pt_regs *regs)
> +{
> +	struct kwatch_watchpoint *wp =3D bp->overflow_handler_context;
> +	unsigned long stack_entries[KWATCH_STACK_DEPTH];
> +	unsigned int stack_nr;
> +
> +	if (!kwatch_probe_validate_hit(regs, wp->arm_tsk))
> +		return;

[Severity: High]
Does this code dereference a freed task_struct if the arming task exits?

When armed, wp->arm_tsk is assigned to current without taking a reference
count. If the task exits, a subsequent breakpoint hit will dereference a
freed task, leading to a use-after-free and kernel panic.

[ ... ]

> +static void kwatch_hwbp_arm_local(void *info)
> +{
> +	struct kwatch_watchpoint *wp =3D info;
> +	struct perf_event *bp;
> +	unsigned long flags;
> +	int cpu, err;
> +
> +	local_irq_save(flags);
> +
> +	cpu =3D smp_processor_id();
> +	bp =3D per_cpu(*wp->event, cpu);

[Severity: High]
Can this dereference a freed perf_event or a NULL pointer?

If a concurrent CPU offline event unregisters and frees the perf_event, the
per-CPU pointer might be read here before it is nullified in
kwatch_hwbp_cpu_offline().

Additionally, if register_wide_hw_breakpoint() returned NULL during
initialization (which IS_ERR_PCPU does not catch), this will attempt to
access the NULL pointer.

> +
> +	if (unlikely(!bp))
> +		goto out;
> +
> +	kwatch_probe_mute(true);
> +	barrier();
> +
> +	/*
> +	 * On success this also updates the per-CPU bp->attr, so the hit
> +	 * handler reports what THIS CPU is watching instead of the shared
> +	 * wp->attr, which another CPU may be re-pointing.
> +	 */
> +	err =3D modify_wide_hw_breakpoint_local(bp, &wp->attr);

[Severity: High]
Can this read a torn or partially updated wp->attr structure?

The shared wp->attr structure is modified by kwatch_hwbp_arm() on another
CPU without locking or WRITE_ONCE(). Remote CPUs executing this IPI
concurrently can observe torn reads, leading to an invalid hardware
breakpoint configuration.

[ ... ]

> +static int kwatch_hwbp_cpu_online(unsigned int cpu)
> +{
> +	struct perf_event_attr attr;
> +	struct kwatch_watchpoint *wp;
> +	struct perf_event *bp;
> +
> +	mutex_lock(&kwatch_all_wp_mutex);
> +	list_for_each_entry(wp, &kwatch_all_wp_list, list) {
> +		attr =3D wp->attr;
> +		attr.bp_addr =3D (unsigned long)&kwatch_dummy_holder;

[Severity: Medium]
Will this unconditional override cause a newly onlined CPU to miss active h=
its?

If a watchpoint is currently armed and active, bringing a CPU online forces
the new CPU to watch the dummy address instead of the currently watched
address.

[ ... ]

> +static int kwatch_hwbp_cpu_offline(unsigned int cpu)
> +{
> +	struct kwatch_watchpoint *wp;
> +	struct perf_event *bp;
> +
> +	mutex_lock(&kwatch_all_wp_mutex);
> +	list_for_each_entry(wp, &kwatch_all_wp_list, list) {
> +		bp =3D per_cpu(*wp->event, cpu);
> +		if (bp) {
> +			unregister_hw_breakpoint(bp);
> +			per_cpu(*wp->event, cpu) =3D NULL;

[Severity: High]
Does unregistering the breakpoint before setting the pointer to NULL create=
 a
race condition?

If an IPI broadcast from kwatch_hwbp_arm() occurs concurrently, it can read
the stale pointer in kwatch_hwbp_arm_local() and access the freed memory.

> +		}
> +	}
> +	mutex_unlock(&kwatch_all_wp_mutex);
> +	return 0;
> +}

[ ... ]

> +void kwatch_hwbp_arm(struct kwatch_watchpoint *wp, unsigned long addr, u=
16 len)
> +{
> +	static DEFINE_PER_CPU(u64, last_ipi_time);
> +	int cur_cpu;
> +	call_single_data_t *csd;
> +	int cpu;
> +	bool is_disarm =3D (addr =3D=3D (unsigned long)&kwatch_dummy_holder);
> +	bool skip_remote =3D false;
> +
> +	wp->attr.bp_addr =3D addr;
> +	wp->attr.bp_len =3D len;

[Severity: High]
Can mutating these shared fields concurrently cause torn reads?

Because wp->attr is modified without locking or WRITE_ONCE(), remote CPUs
processing the arm IPI via modify_wide_hw_breakpoint_local() might read
partially updated states.

> +
> +	if (!is_disarm)
> +		wp->arm_tsk =3D current;

[Severity: High]
Can this result in a use-after-free on current?

No reference count is taken when storing the current task pointer. If the
task exits, a subsequent breakpoint hit will dereference a freed task.

> +
> +	/* ensure attr update visible to other cpu before sending IPI */
> +	smp_wmb();
> +
> +	atomic_set(&wp->pending_ipis, 1);
> +	cur_cpu =3D get_cpu();
> +
> +	/*
> +	 * Rate-limit only the cross-CPU broadcast, never the local re-point.
> +	 * Arming the current CPU is free and must always reflect this window;
> +	 * only the remote IPI fan-out is throttled to keep a hot function from
> +	 * storming every CPU. A suppressed broadcast means remote CPUs keep
> +	 * watching the previous address for that window (a missed remote-CPU
> +	 * writer is possible) - hence the visible counter, and why kwatch
> +	 * targets low-frequency functions. Disarm is never throttled: the
> +	 * slot must always be released.
> +	 */
> +	if (!is_disarm) {
> +		u64 now =3D local_clock();
> +		u64 last =3D this_cpu_read(last_ipi_time);
> +
> +		if (now - last < KWATCH_ARM_IPI_MIN_INTERVAL_NS) {
> +			atomic_long_inc(&kwatch_arm_ipi_suppressed);
> +			skip_remote =3D true;

[Severity: Medium]
Will this per-CPU throttling drop arm IPIs for entirely independent watchpo=
ints?

Since last_ipi_time is stored per-CPU rather than per-watchpoint, arming two
distinct watchpoints in rapid succession from the same CPU will cause the
second watchpoint to be silently ignored on remote CPUs.

> +		} else {
> +			this_cpu_write(last_ipi_time, now);
> +		}
> +	}
> +
> +	if (!skip_remote) {
> +		for_each_online_cpu(cpu) {
> +			if (cpu =3D=3D cur_cpu)
> +				continue;
> +
> +			if (is_disarm)
> +				atomic_inc(&wp->pending_ipis);
> +
> +			csd =3D per_cpu_ptr(is_disarm ? wp->csd_disarm : wp->csd_arm,
> +					  cpu);

[Severity: High]
Can leaving arm IPIs untracked result in a use-after-free?

Because only disarm IPIs are tracked by pending_ipis, an active csd_arm IPI
might still be queued on an offline-going CPU when kwatch_hwbp_free() is
called and frees the csd_arm structure.

[ ... ]

> +void kwatch_hwbp_free(void)
> +{
> +	struct kwatch_watchpoint *wp, *tmp;
> +
> +	kwatch_wp_nr =3D 0;
> +	kfree(kwatch_wp_slots);
> +	kwatch_wp_slots =3D NULL;
> +
> +	if (kwatch_hwbp_cpuhp_state !=3D CPUHP_INVALID) {
> +		cpuhp_remove_state_nocalls(kwatch_hwbp_cpuhp_state);
> +		kwatch_hwbp_cpuhp_state =3D CPUHP_INVALID;
> +	}
> +
> +	mutex_lock(&kwatch_all_wp_mutex);
> +	list_for_each_entry_safe(wp, tmp, &kwatch_all_wp_list, list) {
> +		list_del(&wp->list);
> +
> +		WRITE_ONCE(wp->teardown, true);
> +		atomic_dec(&wp->refcount);
> +
> +		/* Wait for all async IPIs to finish */
> +		while (atomic_read(&wp->refcount) > 0)
> +			cpu_relax();
> +
> +		unregister_wide_hw_breakpoint(wp->event);
> +		free_percpu(wp->csd_arm);

[Severity: High]
Is it safe to free csd_arm here while untracked arm IPIs might still be pen=
ding?

Since csd_arm IPIs are not tracked by pending_ipis, a delayed or queued
arm IPI on an offline-going CPU could access the freed csd_arm.

[ ... ]

> +int kwatch_hwbp_prealloc(u16 max_watch)
> +{
> +	struct kwatch_watchpoint *wp;
> +	int success =3D 0, cpu;
> +	int ret;

[ ... ]

> +		wp->event =3D register_wide_hw_breakpoint(&wp->attr,
> +							kwatch_hwbp_handler,
> +							wp);
> +		if (IS_ERR_PCPU(wp->event)) {

[Severity: High]
Can wp->event be NULL if hardware breakpoints are unsupported?

register_wide_hw_breakpoint() can return NULL. The IS_ERR_PCPU() check does
not catch a NULL return value, causing a kernel panic when
kwatch_hwbp_arm_local() later attempts to dereference the NULL pointer.

[Severity: Medium]
Does registering breakpoints before setting up CPU hotplug callbacks create=
 a
race gap?

If a CPU comes online between this register_wide_hw_breakpoint() loop and t=
he
cpuhp_setup_state_nocalls() below, the new CPU will miss the watchpoint
creation.

[ ... ]

> +	ret =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "kwatch:online",
> +					kwatch_hwbp_cpu_online,
> +					kwatch_hwbp_cpu_offline);
> +	if (ret < 0) {
> +		kwatch_hwbp_free();
> +		return ret;
> +	}
> +
> +	kwatch_hwbp_cpuhp_state =3D ret;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717125023.1895=
892-1-wangjinchao600@gmail.com?part=3D8
