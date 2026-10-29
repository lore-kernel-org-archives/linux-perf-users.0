Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276376;
	b=PIjoX6TGYVy2HJqQHq6VXjCfkceVl5Ppi5yrJcpIf9f6vumKqwX1139SCX9Rs1c+W61p
	 IsxABIs9kGh6yKqJ6PxhCu2ggcsjazZQRvIObaaJZHd4qdAPzg97WCX4RbVm0254xu12K
	 6OdwVUC2iiLPHCit7kkLP0OF/+EkoAxeKCOKIGrDYNuhaQiNbYON7GdchpAyr6EL56buH
	 oFWdmP/i+2HXjYZk43fYR5f7cQBdiGuViTC2ut4CrvEm8DAT1yf4pMtBhIEIQCuUEhqKv
	 g+XuxcKiY976wNzEk6hVEqwIqfoG4CQ0wppYCP6QhbHMA4JAef7zWaRZ5LhujFwRtDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276376;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=43zuC1gQ3zh3ao02S+50DMBflUoTJ4uKXxXOufYJEk8=;
	b=m8IgNd7Nldws3CZkUb6399/HZoqg+SyZb/gQTYIlpFrDqLmvB78oTCMGEZTEZ7I9vwWO
	 1XjhC5KJRA8Mpjxd1u+VsZupZr7wNDKqBfotLLHqAjvPzvz+H6pZ6zC5oCdoU7couvXcW
	 B4HTu31y0zhikNNKJ4ZD6ZU+gF5K4T5OQ+tc4BQ0eR10P2w+NdMhKlX2d0XScgfijiqoO
	 5mZn2tqB1YmyKXxPJAJvOLOEhMB3TinOsLsUT1cP8iFPGprTK2PTIRoEkLHruWkRH10J1
	 lYwfHiu3IjNHJzsqIJv60u8P/LPs6CHD6RtsiIH7fPmZCUkYcLglaQfE5Hnh+5uqHVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqmTFN9+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4861606A31D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqmTFN9+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA181F01825;
	Thu, 29 Oct 2026 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793276375;
	bh=43zuC1gQ3zh3ao02S+50DMBflUoTJ4uKXxXOufYJEk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TqmTFN9+5isb5RaGSwrNN1gQF+7MLolLQbT4WOQix09UlVj+HjScZ+7TUsfSE0oPn
	 wKcKkFiNA0pj6oitfjcqhr0S+8YRAtZ49at1Km/C+GYvOCKkZGEKNowKplB6skExkz
	 X8Oxj67WvutDi///2s3crQPoRYuWBjnPMCz14diGjjKvdhE/GaPcS077uhdS/lTmkD
	 bAB3apfIJ6YmaLJUChCr3a8S0kz8FV2TPBYYoWTrGRP9Du4wI+I397i6ThThmKQVJb
	 j3KkKX25ocxNnPq7SJyfapEI+KjhSxcneAaPon2ZfcdLKyhRWzLOJemUN0eg2ICW4m
	 /i4n2Ce8ZzbGg==
Message-ID: <sashiko-outbox-189274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/11] drivers: firmware: add riscv SSE support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029074853.35467-5-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-5-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:19:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] firmware: riscv_sbi_sse: sse_pm_notifier() unmasks SSE on unready =
CPUs
- [High] firmware: riscv_sbi_sse: sse_event_cleanup() leaks retained SSE ev=
ents
- [High] firmware: riscv_sbi_sse: sse_cpu_teardown() mishandles CPU-up roll=
back
- [High] firmware: riscv_sbi_sse: missing synchronization in sse_event_*_lo=
cal()
- [Medium] firmware: riscv_sbi_sse: invalid hart/CPU check in sse_event_reg=
ister()
- [Medium] firmware: riscv_sbi_sse: bad rollback in sse_event_set_target_cp=
u_nolock()
--

commit a43ce7f3ee4ccdf7ca9265079df6d0b217323b41
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

drivers: firmware: add riscv SSE support

This commit adds a driver-level interface for RISC-V Supervisor Software
Events (SSE), allowing kernel clients to register handlers, manage target
CPUs for global events, and enable, disable, or unregister local and global
events. It also coordinates per-CPU SSE state across CPU hotplug, idle power
management, panic, and reboot/kexec transitions.

> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/ri=
scv/riscv_sbi_sse.c
> new file mode 100644
> index 0000000000000..0cb738bab6c39
> --- /dev/null
> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
[ ... ]
> +static int sse_sbi_event_func(struct sse_event *event, unsigned long fun=
c)
> +{
> +	struct sbiret ret;
> +	u32 evt =3D event->evt_id;
> +	struct sse_registered_event *reg_evt =3D sse_get_reg_evt(event);
> +
> +	ret =3D sbi_ecall(SBI_EXT_SSE, func, evt, 0, 0, 0, 0, 0);
> +	if (ret.error) {
> +		pr_warn("Failed to execute func %lx, event %x, error %ld\n",
> +			func, evt, ret.error);
> +		return sse_err_map_linux_errno(ret.error);
> +	}
> +
> +	if (func =3D=3D SBI_SSE_EVENT_DISABLE)
> +		reg_evt->is_enabled =3D false;
> +	else if (func =3D=3D SBI_SSE_EVENT_ENABLE)
> +		reg_evt->is_enabled =3D true;
> +
> +	return 0;
> +}
> +
> +int sse_event_disable_local(struct sse_event *event)
> +{
> +	if (!sse_event_is_global(event->evt_id))
> +		lockdep_assert_preemption_disabled();
> +
> +	if (!sse_get_reg_evt(event)->is_enabled)
> +		return 0;
> +
> +	return sse_sbi_event_func(event, SBI_SSE_EVENT_DISABLE);
> +}
> +EXPORT_SYMBOL_GPL(sse_event_disable_local);
> +
> +int sse_event_enable_local(struct sse_event *event)
> +{
> +	struct sse_registered_event *reg_evt =3D sse_get_reg_evt(event);
> +	int ret;
> +
> +	if (!sse_event_is_global(event->evt_id))
> +		lockdep_assert_preemption_disabled();
> +
> +	rcu_read_lock();
> +	if (READ_ONCE(sse_shutting_down)) {
> +		ret =3D -ESHUTDOWN;
> +		goto out;
> +	}
> +
> +	if (!reg_evt->is_registered) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (reg_evt->is_enabled) {
> +		ret =3D 0;
> +		goto out;
> +	}
> +
> +	ret =3D sse_sbi_event_func(event, SBI_SSE_EVENT_ENABLE);
> +out:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sse_event_enable_local);

[Severity: High]
Can sse_event_enable_local() and sse_event_disable_local() race with hardir=
qs,
CPU hotplug teardown, or reboot teardown and trigger duplicate or invalid-s=
tate
SBI calls?

There appear to be several related synchronization gaps here:

1. In sse_sbi_event_func(), reg_evt->is_enabled is updated only after
sbi_ecall() returns, and neither sse_event_disable_local() nor
sse_event_enable_local() masks interrupts. If a hardirq (such as
perf_event_task_tick(), perf_mux_hrtimer_handler(), or a perf IPI calling
perf_pmu_disable() -> pmu_sbi_sse_disable() -> sse_event_disable_local())
fires after sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_DISABLE) completes in
firmware but before reg_evt->is_enabled =3D false is written, the IRQ handl=
er
observes stale reg_evt->is_enabled =3D=3D true and issues a second
SBI_SSE_EVENT_DISABLE call that fails with SBI_ERR_INVALID_STATE (-EINVAL).
If the IRQ handler then calls sse_event_enable_local(), it also sees stale
reg_evt->is_enabled =3D=3D true and returns 0 without re-enabling the event=
 in
firmware.

2. During reboot or kexec, sse_reboot_notifier() runs at default priority 0
(before perf_reboot_notifier at INT_MIN) and calls
cpuhp_remove_state(CPUHP_AP_RISCV_SSE_ONLINE) while higher states such as
CPUHP_AP_PERF_ONLINE are still active. In sse_cpu_teardown(),
sse_events_mask() only masks SSE delivery, and scoped_guard(preempt) leaves
hardirqs enabled for local events (and is not used for global events).
Because sse_event_disable_local() does not check sse_shutting_down, a racing
timer IRQ or IPI calling sse_event_disable_local() concurrently with
sse_teardown_event() can cause one of the two SBI_SSE_EVENT_DISABLE calls to
fail with -EINVAL. That causes sse_teardown_event() to abort before
sse_sbi_unregister_event(), sets sse_teardown_failed, and triggers
panic("SSE teardown failed; refusing unsafe kexec") during kexec.

3. During normal CPU offline in sse_cpu_teardown() (where sse_shutting_down
is false) or global event migration in sse_event_set_target_cpu_nolock(), t=
he
event is disabled while reg_evt->is_registered remains true. A concurrent
sse_event_enable_local() from an IRQ on the same CPU (or from another CPU f=
or
a global event, since sse_event_enable_local() and sse_event_disable_local()
do not take sse_mutex or cpus_read_lock()) can re-enable the event in
firmware before SBI_SSE_EVENT_UNREGISTER or SBI_SSE_EVENT_ATTR_WRITE runs,
causing firmware to reject the operation with -EINVAL. Also,
sse_event_enable_local() calls sse_get_reg_evt(event) (which uses
smp_processor_id() for local events) before
lockdep_assert_preemption_disabled().

4. If CPU offline aborts and jumps to restore_cpu in sse_cpu_teardown(),
sse_restore_local_events() restores local events using
event->enable_requested, which is only updated by sse_event_enable() and
sse_event_disable(), losing per-CPU enable state set via
sse_event_enable_local() or sse_event_disable_local().

[ ... ]
> +static int sse_event_set_target_cpu_nolock(struct sse_event *event,
> +					   unsigned int cpu)
> +{
> +	unsigned long hart_id, old_hart_id;
> +	struct sse_registered_event *reg_evt =3D event->global;
> +	u32 evt =3D event->evt_id;
> +	unsigned int old_cpu;
> +	bool was_enabled;
> +	int ret;
> +
> +	if (!sse_event_is_global(evt))
> +		return -EINVAL;
> +
> +	if (cpu >=3D nr_cpu_ids || !cpu_online(cpu))
> +		return -EINVAL;
> +	hart_id =3D cpuid_to_hartid_map(cpu);
> +	old_cpu =3D event->cpu;
> +	old_hart_id =3D cpuid_to_hartid_map(old_cpu);
> +
> +	was_enabled =3D reg_evt->is_enabled;
> +	if (was_enabled) {
> +		ret =3D sse_event_disable_local(event);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PREFERRED_HART,
> +					hart_id);
> +	if (ret =3D=3D 0)
> +		sse_global_event_update_cpu(event, cpu);
> +
> +	if (was_enabled) {
> +		int enable_ret;
> +
> +		enable_ret =3D sse_event_enable_local(event);
> +		if (enable_ret) {
> +			int rollback_ret;
> +
> +			/*
> +			 * The preferred hart was already changed. Restore both the
> +			 * firmware attribute and Linux's cached target before reporting
> +			 * the failed migration.
> +			 */
> +			rollback_ret =3D sse_event_attr_set_nolock(reg_evt,
> +								 SBI_SSE_ATTR_PREFERRED_HART,
> +								 old_hart_id);
> +			if (!rollback_ret) {
> +				sse_global_event_update_cpu(event, old_cpu);
> +				rollback_ret =3D sse_event_enable_local(event);
> +			}
> +			if (!rollback_ret)
> +				return enable_ret;
> +
> +			pr_warn("Failed to restore global event %x to CPU %u: %d\n",
> +				evt, old_cpu, rollback_ret);
> +			event->enable_requested =3D false;
> +			return enable_ret;
> +		}
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
In sse_event_set_target_cpu_nolock(), what happens if
sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PREFERRED_HART, hart_id)
fails (ret !=3D 0) when was_enabled is true, and the subsequent
sse_event_enable_local(event) on old_cpu also fails?

Because the if (enable_ret) block does not check whether ret =3D=3D 0, it w=
ill
assume the preferred hart was changed, write old_hart_id to
SBI_SSE_ATTR_PREFERRED_HART again, call sse_event_enable_local(event) a
second time, and return enable_ret instead of the original attribute-write
error in ret.

[ ... ]
> +void sse_event_cleanup(struct sse_event *event)
> +{
> +	guard(mutex)(&sse_mutex);
> +	guard(cpus_read_lock)();
> +
> +	if (event->cleanup_pending)
> +		return;
> +
> +	/*
> +	 * Firmware may still enter the old callback after disable or unregister
> +	 * fails. Publish a core-owned callback, then wait before the client fr=
ees
> +	 * its callback data.
> +	 */
> +	event->cleanup_pending =3D true;
> +	rcu_assign_pointer(event->handler, sse_cleanup_event_handler);
> +	synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(sse_event_cleanup);
> +
> +static void sse_release_cleanup_event(struct sse_event *event)
> +{
> +	if (!event->cleanup_pending || sse_event_is_registered(event))
> +		return;
> +
> +	list_del(&event->list);
> +	sse_event_free(event);
> +}

[Severity: High]
Does sse_event_cleanup() leak struct sse_event (along with its global or
per-CPU registrations, vmap stacks, shadow call stacks, and interrupted
buffers) and leave the event ID permanently blocked in the events list with
-EEXIST?

In sse_event_cleanup(), event->cleanup_pending is set to true and the handl=
er
is replaced with sse_cleanup_event_handler, but sse_release_cleanup_event()=
 is
never called, nor does sse_event_cleanup() clear event->enable_requested or
attempt to disable and unregister remaining online instances.

This leaves the event stranded in two scenarios:

1. If all firmware registrations are already gone by the time
sse_event_cleanup() acquires sse_mutex, sse_event_is_registered(event) is
already false. This can happen if sse_event_unregister() fails on one CPU a=
nd
releases sse_mutex before returning the error, and that CPU goes offline via
sse_cpu_teardown() before the client calls sse_event_cleanup() (when
sse_cpu_teardown() ran, cleanup_pending was still false, so
sse_release_cleanup_event() was a no-op). It also happens during reboot/kex=
ec
if sse_reboot_notifier() runs cpuhp_remove_state(CPUHP_AP_RISCV_SSE_ONLINE)
first and a client shutdown callback then receives -ESHUTDOWN from
sse_event_disable() or sse_event_unregister() and calls sse_event_cleanup().
Once sse_event_cleanup() sets cleanup_pending =3D true on an already
unregistered event without calling sse_release_cleanup_event(event), nothing
may ever revisit it (especially for global events, which sse_cpu_online()
skips), leaking the event and causing future sse_event_register() calls for
that evt_id to fail with -EEXIST.

2. If a client calls sse_event_cleanup() directly after sse_event_disable()
fails on one CPU without calling sse_event_unregister(), sse_event_cleanup()
does not clear event->enable_requested or unregister the event on the online
CPUs where disabling succeeded. Those online CPUs remain registered in
firmware, preventing sse_release_cleanup_event() from ever freeing the even=
t.

[ ... ]
> +struct sse_event *sse_event_register(u32 evt, u32 priority,
> +				     sse_event_handler_fn *handler, void *arg)
> +{
[ ... ]
> +	if (sse_event_is_global(evt)) {
> +		unsigned long preferred_hart;
> +
> +		ret =3D sse_event_attr_get_no_lock(event->global,
> +						 SBI_SSE_ATTR_PREFERRED_HART,
> +						 &preferred_hart);
> +		if (ret)
> +			return sse_register_failed(event, ret);
> +
> +		cpu =3D riscv_hartid_to_cpuid(preferred_hart);
> +		if (cpu < 0 || !cpu_online(cpu)) {
> +			cpu =3D cpumask_first(cpu_online_mask);

[Severity: Medium]
What happens in sse_event_register() if firmware reports preferred_hart =3D=
=3D
INVALID_HARTID when nr_cpu_ids < NR_CPUS?

In arch/riscv/kernel/smp.c, unpopulated entries in __cpuid_to_hartid_map[NR=
_CPUS]
are initialized to INVALID_HARTID, and riscv_hartid_to_cpuid() loops up to
NR_CPUS:

arch/riscv/kernel/smp.c:riscv_hartid_to_cpuid() {
	for (i =3D 0; i < NR_CPUS; i++)
		if (cpuid_to_hartid_map(i) =3D=3D hartid)
			return i;
}

When preferred_hart is INVALID_HARTID, riscv_hartid_to_cpuid() returns the
first unpopulated index (cpu >=3D nr_cpu_ids) rather than a negative error.
Passing cpu >=3D nr_cpu_ids to cpu_online(cpu) without first checking
preferred_hart =3D=3D INVALID_HARTID or cpu >=3D nr_cpu_ids accesses past
nr_cpu_ids in cpu_online_mask and triggers WARN_ON_ONCE(cpu >=3D
small_cpumask_bits) in cpumask_check() when CONFIG_DEBUG_PER_CPU_MAPS is
enabled.

[ ... ]
> +static int sse_cpu_teardown(unsigned int cpu)
> +{
> +	/* Only a regular CPU-offline callback may abort the CPUHP operation. */
> +	bool regular_offline =3D READ_ONCE(sse_available) &&
> +			       !READ_ONCE(sse_shutting_down);
> +	unsigned int next_cpu;
> +	struct sse_event *event, *tmp;
> +	int first_error =3D 0;
> +	int ret;
> +
> +	/* Do not dismantle CPU state while firmware can still deliver SSE. */
> +	ret =3D sse_events_mask();
> +	if (ret) {
> +		pr_warn("Failed to mask SSE on CPU %u during teardown: %d\n",
> +			cpu, ret);
> +		if (READ_ONCE(sse_shutting_down))
> +			atomic_set(&sse_teardown_failed, 1);
> +		/* CPUHP installation rollback and state removal cannot fail. */
> +		return regular_offline ? ret : 0;
> +	}
> +
> +	list_for_each_entry_safe(event, tmp, &events, list) {
> +		if (sse_event_is_global(event->evt_id))
> +			continue;
> +
> +		scoped_guard(preempt)
> +			ret =3D sse_teardown_event(event, cpu);
> +		if (ret && !first_error)
> +			first_error =3D ret;
> +		sse_release_cleanup_event(event);
> +		if (ret && regular_offline)
> +			goto restore_cpu;
> +	}
> +
> +	list_for_each_entry_safe(event, tmp, &events, list) {
> +		if (!sse_event_is_global(event->evt_id) || event->cpu !=3D cpu)
> +			continue;
> +
> +		/*
> +		 * cpuhp_remove_state() invokes teardown while every CPU remains
> +		 * online. Do not migrate to a CPU whose callback may have run.
> +		 */
> +		if (READ_ONCE(sse_shutting_down) || event->cleanup_pending) {
> +			ret =3D sse_teardown_event(event, cpu);
> +		} else {
> +			next_cpu =3D cpumask_any_but(cpu_online_mask, cpu);
> +			if (next_cpu >=3D nr_cpu_ids) {
> +				ret =3D sse_teardown_event(event, cpu);
> +			} else {
> +				ret =3D sse_event_set_target_cpu_nolock(event, next_cpu);
> +				if (ret)
> +					pr_warn("Failed to migrate global event %x from CPU %u: %d\n",
> +						event->evt_id, cpu, ret);
> +			}
> +		}
> +
> +		if (ret && !first_error)
> +			first_error =3D ret;
> +		sse_release_cleanup_event(event);
> +		if (ret && regular_offline)
> +			goto restore_cpu;
> +	}
> +
> +	if (first_error) {
> +		/* An offline CPU is not revisited when this CPUHP state is removed. */
> +		atomic_set(&sse_teardown_failed, 1);
> +	}
> +
> +	return 0;
> +
> +restore_cpu:
> +	/*
> +	 * CPUHP leaves this CPU online when teardown returns an error. Restore
> +	 * every client-owned local event before making SSE delivery visible ag=
ain.
> +	 */
> +	ret =3D sse_restore_local_events(cpu);
> +	if (!ret)
> +		ret =3D sse_events_unmask();
> +	if (ret) {
> +		atomic_set(&sse_teardown_failed, 1);
> +		pr_warn("Failed to restore SSE after aborting CPU %u offline: %d\n",
> +			cpu, ret);
> +	} else {
> +		pr_warn("Aborted CPU %u offline after SSE teardown failed: %d\n",
> +			cpu, first_error);
> +	}
> +
> +	return first_error;
> +}

[Severity: High]
Does sse_cpu_teardown() handle a post-boot _cpu_up() rollback when a CPUHP
state after CPUHP_AP_RISCV_SSE_ONLINE fails?

Once sse_init() sets sse_available =3D true, if a CPU is being brought onli=
ne
via _cpu_up() and sse_cpu_online() succeeds at CPUHP_AP_RISCV_SSE_ONLINE, b=
ut
a later startup state (such as CPUHP_AP_PERF_ONLINE) fails, CPUHP sets
st->rollback =3D true and invokes teardown callbacks on the AP to roll back
towards offline.

During that _cpu_up() rollback, regular_offline is true in
sse_cpu_teardown(). If sse_events_mask() fails, sse_cpu_teardown() returns =
ret
without setting sse_teardown_failed. If any sse_teardown_event() call fails,
it jumps to restore_cpu, which calls sse_restore_local_events(cpu) and
sse_events_unmask(), leaves sse_teardown_failed unset if the restore succee=
ds,
and returns first_error (non-zero).

In kernel/cpu.c:cpuhp_thread_fun(), returning non-zero from a teardown
callback during rollback triggers WARN_ON_ONCE(st->rollback) and halts
rollback of earlier AP states, while cpuhp_up_callbacks() still proceeds to
takedown_cpu() and stops the CPU with SSE unmasked, local events still
registered and enabled in firmware, and sse_teardown_failed left at 0.

> +
> +static int sse_pm_notifier(struct notifier_block *nb, unsigned long acti=
on,
> +			   void *data)
> +{
> +	int ret;
> +
> +	WARN_ON_ONCE(preemptible());
> +
> +	switch (action) {
> +	case CPU_PM_ENTER:\n> +		ret =3D sse_events_mask();
> +		break;
> +	case CPU_PM_EXIT:
> +	case CPU_PM_ENTER_FAILED:
> +		if (READ_ONCE(sse_shutting_down))
> +			return NOTIFY_OK;
> +		ret =3D sse_events_unmask();
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	if (ret)
> +		return notifier_from_errno(ret);
> +
> +	return NOTIFY_OK;
> +}
[ ... ]
> +static int __init sse_init(void)
> +{
[ ... ]
> +	ret =3D cpu_pm_register_notifier(&sse_pm_nb);
> +	if (ret) {
> +		pr_warn("Failed to register CPU PM notifier...\n");
> +		return ret;
> +	}
> +
> +	ret =3D register_reboot_notifier(&sse_reboot_nb);
> +	if (ret) {
> +		pr_warn("Failed to register reboot notifier...\n");
> +		goto remove_cpupm;
> +	}
> +
> +	ret =3D atomic_notifier_chain_register(&panic_notifier_list, &sse_panic=
_nb);
> +	if (ret) {
> +		pr_warn("Failed to register panic notifier...\n");
> +		goto remove_reboot;
> +	}
> +
> +	/* Tear down perf events before dismantling their SSE delivery path. */
> +	ret =3D cpuhp_setup_state(CPUHP_AP_RISCV_SSE_ONLINE, "riscv/sse:online",
> +				sse_cpu_online, sse_cpu_teardown);

[Severity: High]
Can sse_pm_notifier() unmask SSE on a CPU before sse_cpu_online() has
initialized its per-CPU SSE state, or after sse_cpu_teardown() has already
dismantled it?

In sse_pm_notifier(), CPU_PM_EXIT and CPU_PM_ENTER_FAILED unconditionally c=
all
sse_events_unmask() whenever sse_shutting_down is false, without checking
whether SSE is currently online on this CPU:

1. In sse_init(), cpu_pm_register_notifier(&sse_pm_nb) is registered before
cpuhp_setup_state(CPUHP_AP_RISCV_SSE_ONLINE, ...). Because sbi_cpuidle_init=
()
is also an arch_initcall and drivers/cpuidle/ is linked before
drivers/firmware/, cpuidle can already be active on online CPUs and call
cpu_pm_exit() -> sse_pm_notifier() -> sse_events_unmask() before
sse_cpu_online() runs arch_sse_init_cpu() to set __sbi_sse_entry_task.

2. During secondary CPU bringup, the AP enables interrupts in smp_callin() =
and
enters the idle loop at CPUHP_AP_ONLINE_IDLE (cpu_startup_entry() -> do_idl=
e()
-> cpuidle_idle_call() -> cpu_pm_enter() / cpu_pm_exit()) before the cpuhp/=
%u
thread reaches CPUHP_AP_RISCV_SSE_ONLINE (or after sse_cpu_online() fails a=
nd
rolls back), unmasking SSE on an uninitialized hart.

3. During normal CPU offline (_cpu_down()), sse_cpu_teardown() runs at
CPUHP_AP_RISCV_SSE_ONLINE on the cpuhp/%u thread and masks SSE. The cpuhp/%u
thread then parks at CPUHP_AP_ONLINE_IDLE while the offlining CPU remains in
cpu_online_mask and runs do_idle() -> cpuidle_idle_call() waiting for the
control CPU to invoke takedown_cpu() -> stop_machine_cpuslocked(take_cpu_do=
wn,
...) at CPUHP_TEARDOWN_CPU. When the CPU wakes from cpuidle (for example, on
the stop_machine IPI), CPU_PM_EXIT in sse_pm_notifier() calls
sse_events_unmask() and re-enables SSE on the dying hart after teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D4
