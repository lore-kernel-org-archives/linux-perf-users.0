Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091920;
	b=AlyVHe4C0XUojFikuPCk0m0I3+hVQWxKHG7D4/L8o3bS1pJA1e0FFQiXFed7YCszOS9W
	 tCYeWa1U7b8/WfZE1eRWkTmzBRJ1EsAMGqZzaECC1h1xv5bVa4B4DTw8brK32KSeNOzH6
	 owGS7TyYGf+3NfMdUzvisqwT37dq9yPm5wXjQ00c1XybzviezSy6hl8yIUjnLPb8FxawL
	 WCWrvIvf3rPCV7q5FaHnXAW25Mz35YE5brrgqwyn9tkOmGDs9YpHgX+OX6vqHHdrrn28k
	 C9LiFLVqsO8jjYTej+ISHhRUWiBl/kcg8PMARahrHhAITF94RfSzOivQqvugPOWcCkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091920;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3vQ9QKeYxKjkC4yLhi9kn1a/pVZvnd3GNok3QMGXXL8=;
	b=RinSJXvAd7kf9oGpE2HTojcljoqgc27ZpFO1NHsS7slOmN625rKCsyLPU/nBubMGCFVA
	 uu31ckK7QhSbN7dZgwzzyJWgp+3O0A5XH3gNVFx3Ja/ZoLf5CbyqCL23BiBFlGghgOhqK
	 L2FlFqMpERBkavlVDeP21oO5vnxRDCxYKEV4MA18b5nTvTtp7JoMTRkuOqYrpgQMOQ7qJ
	 k2vZTQqUYHLxqH2II+IRgUjDZAQRFBGR4hCp+xKS1p8UW9V+mL+EhMpH8ohDNjTs+fb4J
	 Q01zovtGalVwvVJvJPrfz7INr/PeD+3C21jsAby0b/b7LCVoMbAP4bwP7CK6tbNepZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St3QCvvI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA0606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St3QCvvI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D98F1F000C4;
	Thu, 19 Nov 2026 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091920;
	bh=3vQ9QKeYxKjkC4yLhi9kn1a/pVZvnd3GNok3QMGXXL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=St3QCvvIzBszj26Cwhd6jxTzL8xtlpMLNdQ4GvXi9XtT69WoJRZ7u7GZz15OW2TUd
	 imIyeqlXluf3RLsQViEQkDDV0+Oh2AvDBzi9WQtDvu78qArd3c0VZfB+Wr37okbove
	 xzXQQPy0Yb9iFeUcD8jp+Q9zuxPUMIa4M86epKC1ZNm1sdl4IdtjhNkmV4ItXjRIcZ
	 yFPB20l1uesZl+Y6vQZ3djBZ1xdxQrHEfHTUPLRPdg/ng8hArP3rYEuKcPusrbiP0W
	 LY58v8kyyij8n/f5yTNmX6wynQqXq7r+Y7JIcamgCJzkmCHxAlGOr/4UnliDqACvj9
	 zXFsRar/kK1TA==
Message-ID: <sashiko-outbox-223100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/11] drivers: firmware: add riscv SSE support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-17-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-17-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:38:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] firmware: riscv_sbi_sse: sse_pm_notifier() unmasks SSE on
  unready or offlining CPUs
- [High] firmware: riscv_sbi_sse: sse_event_cleanup() leaks retained SSE
  events
- [High] firmware: riscv_sbi_sse: missing IRQ and teardown sync in
  sse_event_*_local()
- [High] firmware: riscv_sbi_sse: sse_cpu_teardown() mishandles CPU-up
  rollback
- [Medium] firmware: riscv_sbi_sse: missing hart and CPU bounds check in
  sse_event_register()
- [Medium] firmware: riscv_sbi_sse: sse_event_setup_all_cpus() can
  return -EOPNOTSUPP with enabled state
- [Medium] firmware: riscv_sbi_sse: sse_reboot_notifier() races with CPU
  hotplug callbacks
- [Medium] firmware: riscv_sbi_sse: broken rollback in
  sse_event_set_target_cpu_nolock()
--

commit 62013a3fca4c71adabe66ac29e99aa0bab92f5a1
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

drivers: firmware: add riscv SSE support

This commit adds a driver-level interface for RISC-V Supervisor Software
Events (SSE) to manage global and per-CPU event registration, enabling,
disabling, and CPU hotplug and reboot teardown.

> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/ri=
scv/riscv_sbi_sse.c
> new file mode 100644
> index 0000000000000..0cb738bab6c39
> --- /dev/null
> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
> @@ -0,0 +1,1219 @@

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
Can a hardirq interrupting sse_event_disable_local(),
sse_event_enable_local(), or sse_teardown_event() observe stale
reg_evt->is_enabled state and issue conflicting SBI calls?

sse_event_disable_local(), sse_event_enable_local(), and
sse_cpu_teardown() run with local interrupts enabled, and
sse_sbi_event_func() updates reg_evt->is_enabled only after sbi_ecall()
returns:

sse_cpu_teardown()
  sse_teardown_event()
    if (reg_evt->is_enabled)
      sse_event_disable_local()
        <hardirq>
          perf_mux_hrtimer_handler()
            ...
              sse_event_disable_local()
                sbi_ecall(..., SBI_SSE_EVENT_DISABLE, ...)
                reg_evt->is_enabled =3D false;
        sse_sbi_event_func(..., SBI_SSE_EVENT_DISABLE)
          sbi_ecall(..., SBI_SSE_EVENT_DISABLE, ...)  <-- returns -EINVAL

During reboot or kexec, sse_reboot_nb runs at default priority 0 while
CPUHP_AP_PERF_ONLINE and perf timer interrupts are still active.  When the
second SBI_SSE_EVENT_DISABLE fails with -EINVAL, sse_teardown_event()
aborts before unregistering the event and sets sse_teardown_failed,
causing sse_reboot_notifier() to panic on kexec.

The same window exists when an interrupt nests inside normal
sse_event_disable_local() or sse_event_enable_local() calls, or when an
interrupt calls sse_event_enable_local() after sse_teardown_event() (on
normal CPU offline where sse_shutting_down is false) or
sse_event_set_target_cpu_nolock() disables an event while
reg_evt->is_registered is still true.

Also, sse_event_enable_local() calls sse_get_reg_evt(event) (which calls
smp_processor_id() for local events) before
lockdep_assert_preemption_disabled(), and sse_restore_local_events()
restores local events from event->enable_requested rather than the
per-CPU reg_evt->is_enabled state that was active before
sse_cpu_teardown() began.

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
Does the rollback in sse_event_set_target_cpu_nolock() misbehave when
setting SBI_SSE_ATTR_PREFERRED_HART or rolling it back fails?

If sse_event_attr_set_nolock() fails (ret !=3D 0) on an enabled event and
re-enabling the event also fails (enable_ret !=3D 0), the code enters the
rollback block even though the preferred hart was never changed,
redundantly writing old_hart_id and returning enable_ret instead of ret.

Conversely, if setting the new preferred hart succeeds (ret =3D=3D 0),
sse_global_event_update_cpu(event, cpu) updates event->cpu to the new
CPU.  If both sse_event_enable_local() and the rollback
sse_event_attr_set_nolock(..., old_hart_id) then fail, event->cpu remains
set to the new CPU while the function returns enable_ret, causing
sse_cpu_teardown() to abort the CPU offline even though the event has
already been moved to next_cpu and disabled.

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
> +
> +static int sse_event_setup_all_cpus(struct sse_event *event,
> +				    unsigned long func,
> +				    unsigned long rollback_func)
> +{
> +	struct sse_per_cpu_evt cpu_evt;
> +	int rollback_ret;
> +	int ret;
> +
> +	cpu_evt.event =3D event;
> +	atomic_set(&cpu_evt.first_error, 0);
> +	atomic_set(&cpu_evt.nonfallback_error, 0);
> +	cpumask_clear(&cpu_evt.changed);
> +	cpu_evt.func =3D func;
> +	on_each_cpu(sse_event_per_cpu_func, &cpu_evt, 1);
> +	/* IRQ fallback is safe only if every failing CPU reports unsupported. =
*/
> +	ret =3D atomic_read(&cpu_evt.nonfallback_error);
> +	if (!ret)
> +		ret =3D atomic_read(&cpu_evt.first_error);
> +	/*
> +	 * A previous attempt may already have changed some CPUs. Roll back only
> +	 * instances changed by this invocation.
> +	 */
> +	if (ret) {
> +		cpu_evt.func =3D rollback_func;
> +		atomic_set(&cpu_evt.first_error, 0);
> +		atomic_set(&cpu_evt.nonfallback_error, 0);
> +		on_each_cpu_mask(&cpu_evt.changed, sse_event_per_cpu_func, &cpu_evt, 1=
);
> +
> +		rollback_ret =3D atomic_read(&cpu_evt.nonfallback_error);
> +		if (!rollback_ret)
> +			rollback_ret =3D atomic_read(&cpu_evt.first_error);
> +
> +		/* A rollback failure leaves the firmware state uncertain. */
> +		return rollback_ret ?: ret;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Does sse_event_cleanup() leak struct sse_event and leave its evt_id
permanently blocked on the events list?

sse_event_cleanup() sets event->cleanup_pending =3D true and swaps the
handler, but never tears down remaining registrations or calls
sse_release_cleanup_event(event).

If all registrations were already removed before cleanup_pending was set
(for example, when sse_reboot_notifier() tore down all events and a
client's later sse_event_unregister() returned -ESHUTDOWN, or when the
failing CPU went offline in the window between sse_event_unregister()
dropping sse_mutex and sse_event_cleanup() acquiring it),
sse_release_cleanup_event() during sse_cpu_teardown() saw
!event->cleanup_pending and did nothing.  Once sse_event_cleanup() sets
cleanup_pending =3D true, nothing calls sse_release_cleanup_event(event)
again, leaking event and causing future sse_event_register() calls for
that evt_id to fail with -EEXIST.

Similarly, if a client calls sse_event_cleanup(event) directly after
sse_event_disable(event) fails on one CPU without calling
sse_event_unregister(event), sse_event_cleanup() neither clears
event->enable_requested nor unregisters the event on the online CPUs
where disabling succeeded, leaving those CPUs registered and preventing
sse_release_cleanup_event() from ever freeing the event.

[Severity: Medium]
Can sse_event_setup_all_cpus() return -EOPNOTSUPP to sse_event_enable()
while leaving the event enabled on some CPUs?

If the forward enable pass fails with a non-fallback error (such as -EIO)
after enabling the event on CPUs in cpu_evt.changed, and the rollback
disable pass fails with -EOPNOTSUPP, "return rollback_ret ?: ret;"
overwrites ret with -EOPNOTSUPP.  Likewise, if any CPU was already
enabled before sse_event_enable() ran (so changed was false on that CPU)
and another CPU fails with -EOPNOTSUPP, only cpu_evt.changed is rolled
back.  Unlike sse_event_register(), sse_event_enable() does not check
sse_event_is_enabled(event), so it returns -EOPNOTSUPP and allows the
client to select an IRQ fallback while firmware still has SSE enabled.

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
Can cpu_online(cpu) read past nr_cpu_ids when firmware reports an invalid
or unpopulated preferred_hart?

In arch/riscv/kernel/smp.c, __cpuid_to_hartid_map[NR_CPUS] initializes
all NR_CPUS slots to INVALID_HARTID, and riscv_hartid_to_cpuid() scans up
to NR_CPUS:

arch/riscv/kernel/smp.c:riscv_hartid_to_cpuid() {
	for (i =3D 0; i < NR_CPUS; i++)
		if (cpuid_to_hartid_map(i) =3D=3D hartid)
			return i;
}

When nr_cpu_ids < NR_CPUS and firmware returns preferred_hart =3D=3D
INVALID_HARTID (or a hart mapped at index >=3D nr_cpu_ids),
riscv_hartid_to_cpuid() returns an index >=3D nr_cpu_ids.  Passing that cpu
to cpu_online(cpu) without checking preferred_hart =3D=3D INVALID_HARTID or
cpu >=3D nr_cpu_ids (unlike sse_event_set_target_cpu_nolock()) reads past
nr_cpu_ids in cpu_online_mask and triggers the WARN_ON_ONCE() in
cpumask_check() when CONFIG_DEBUG_PER_CPU_MAPS is enabled.

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
What happens if sse_cpu_teardown() is invoked during a post-boot
_cpu_up() rollback after a later CPUHP state fails?

Because sse_available is true and sse_shutting_down is false after boot,
regular_offline evaluates to true even when sse_cpu_teardown() is rolling
back a failed CPU bringup.  If sse_teardown_event() or migration fails,
sse_cpu_teardown() jumps to restore_cpu, re-registers and re-enables
local events, unmasks SSE on the hart, leaves sse_teardown_failed unset
when restore succeeds, and returns first_error (triggering
WARN_ON_ONCE(st->rollback) in cpuhp_thread_fun()), while
cpuhp_up_callbacks() proceeds to take the CPU down via takedown_cpu()
with SSE still unmasked and events active in firmware.  Likewise, if
sse_events_mask() fails during a _cpu_up() rollback, sse_cpu_teardown()
returns a non-zero error without setting sse_teardown_failed.

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
> +	case CPU_PM_ENTER:
> +		ret =3D sse_events_mask();
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

[Severity: High]
Can sse_pm_notifier() unmask SSE on a CPU where SSE has already been torn
down, has not been initialized yet, or was intentionally left masked?

CPU_PM_EXIT and CPU_PM_ENTER_FAILED only check sse_shutting_down before
calling sse_events_unmask(), without tracking whether SSE is currently
online and unmasked on this CPU.

During normal CPU hot-unplug, sse_cpu_teardown() masks SSE and tears down
events at CPUHP_AP_RISCV_SSE_ONLINE, after which the cpuhp thread parks
at CPUHP_AP_ONLINE_IDLE and the offlining CPU enters do_idle() ->
cpuidle_idle_call() while waiting for takedown_cpu() at
CPUHP_TEARDOWN_CPU.  Exiting a CPU_PM idle state in that window calls
sse_events_unmask(), re-enabling SSE delivery on the dying hart after its
events have been torn down.

The same unconditional unmask can happen on a CPU exiting a CPU_PM idle
state before CPUHP_AP_RISCV_SSE_ONLINE has run arch_sse_init_cpu() (during
sse_init() where cpu_pm_register_notifier() runs before
cpuhp_setup_state(), or during _cpu_up()), or after restore_cpu in
sse_cpu_teardown() intentionally left SSE masked because
sse_restore_local_events() failed.

[ ... ]

> +static int sse_reboot_notifier(struct notifier_block *nb, unsigned long =
action,
> +			       void *data)
> +{
> +	int ret;
> +
> +	scoped_guard(mutex, &sse_mutex) {
> +		if (!sse_shutting_down) {
> +			WRITE_ONCE(sse_shutting_down, true);
> +			ret =3D cpu_pm_unregister_notifier(&sse_pm_nb);
> +			if (ret) {
> +				pr_warn("Failed to unregister CPU PM notifier: %d\n",
> +					ret);
> +				atomic_set(&sse_teardown_failed, 1);
> +			}
> +			/* Drain CPU PM callbacks and client enables before teardown. */
> +			synchronize_rcu();
> +			cpuhp_remove_state(CPUHP_AP_RISCV_SSE_ONLINE);
> +		}
> +	}
> +
> +	/* Normal kexec preserves firmware state but discards old kernel memory=
. */
> +	if (kexec_in_progress && atomic_read(&sse_teardown_failed))
> +		panic("SSE teardown failed; refusing unsafe kexec");
> +
> +	return NOTIFY_OK;
> +}

[Severity: Medium]
Can sse_reboot_notifier() setting sse_shutting_down without
cpus_read_lock() race with an in-progress sse_cpu_teardown() and trigger
the kexec panic?

Normal CPU hotplug callbacks run under cpus_write_lock() without holding
sse_mutex, while reboot notifiers run before migrate_to_reboot_cpu()
disables CPU hotplug:

CPU0                                     CPU1
_cpu_down()
  sse_cpu_teardown()
    regular_offline =3D true;
                                         sse_reboot_notifier()
                                           mutex_lock(&sse_mutex)
                                           WRITE_ONCE(sse_shutting_down, tr=
ue)
    sse_event_set_target_cpu_nolock()
      sse_event_enable_local()
        if (READ_ONCE(sse_shutting_down))
          return -ESHUTDOWN;
    goto restore_cpu;
    sse_restore_local_events()
      sse_event_enable_local()
        return -ESHUTDOWN;
    atomic_set(&sse_teardown_failed, 1)
                                           cpuhp_remove_state(...)
                                           if (kexec_in_progress &&
                                               atomic_read(&sse_teardown_fa=
iled))
                                             panic(...)  <-- false-positive=
 panic

Holding cpus_read_lock() across the sse_shutting_down transition (or
using __cpuhp_remove_state_cpuslocked() under cpus_read_lock()) would
serialize sse_reboot_notifier() against active CPU hotplug callbacks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D4
