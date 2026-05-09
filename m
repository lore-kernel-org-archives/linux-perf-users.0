Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690F36606E
	for <linux-perf-users@vger.kernel.org>; Sat,  9 May 2026 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337499; cv=none; b=uiXKRSz73iBJ1Ls9orelPHkC+0kYraf+Or/yaOTTIEHEfF/Cw9DVaTQ6TsHQNt8WnsUAO2Bj4t8ItiPa8430gaVWi7ioCdWhZHOBmUC8jHocZUW1oIy3QVTixZhShGrObO5q6/108/e3Rvg1WUF+xAm7CfJCd8iD74M7RevwTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337499; c=relaxed/simple;
	bh=GhdWvbsAhQYajww50i4obo3O4xeZ/HFwV/XFOGXza6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JzrHSrbONb1hmWKZmh8Ohfdzx9pmjcvlliGP+IvQw+Rk7pJ6QPpiCMtkPNQuffb9tJymp6U2A6tgGS/a1AAd5rLq009bhS7ssgaScG3ClY/s/S3k8JRmISV2L91wQJLmQkxVp/G3n55ZTKm3AiHe7fWB2ZD1Ym13vywy4cd7KmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTKY4q+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTKY4q+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B170EC2BCB2;
	Sat,  9 May 2026 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778337498;
	bh=GhdWvbsAhQYajww50i4obo3O4xeZ/HFwV/XFOGXza6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JTKY4q+7UBWu87T52pByzsyXkuHJJ+Ojy1Z8godSsBcRRhDxxfcBC/1LSjzJu0FMp
	 uv+uDjYGWBrtdRhmtBB7IyAbAc4HaTGLTpiEQAQInGingolbEdCUB6198GFdpcNqMi
	 bkeCirTLGkTw5IPiL8tTUARixsaP0HkecE1CoZx7f4SFJK95g3C/p5uPPHUhTtMF3u
	 KgKXYAzOOHW0UWpNpHz4Qt//N/kOzCnc7527O/vV0zHnVcDv4ismWf/PUM2VSXIPsN
	 2RvDt3cCCp2ITzMxgpgLou4/62ZltMARmJWaESFeNodMKxgqjELlkL6Q1hmGdaAtrA
	 Vi5zYogC+hK6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/5] drivers: firmware: add riscv SSE support
Reply-To: sashiko@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7d86cbd47688700fbdfc27e530e824a6bec0548c.1778331862.3.git.zhangzhanpeng.jasper@bytedance.com>
References: <7d86cbd47688700fbdfc27e530e824a6bec0548c.1778331862.3.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 14:38:15 +0000
Message-Id: <20260509143818.B170EC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] Missing braces around `scoped_guard(cpus_read_lock)` in `sse_e=
vent_unregister` releases lock prematurely, leading to a race condition and=
 use-after-free.
- [High] Event registration rollback uses the wrong revert function, leakin=
g firmware registrations and causing use-after-free.
- [High] Missing validation of `riscv_hartid_to_cpuid` return value leads t=
o out-of-bounds array access.
- [High] `sse_cpu_teardown` causes out-of-bounds array access on single-CPU=
 teardown and fails to unregister global events across reboots.
- [High] 64-bit physical addresses are silently truncated to 32 bits on RV3=
2.
- [High] CPU hotplug unconditionally enables local events, ignoring driver-=
defined disabled states.
- [High] Early release of `cpus_read_lock` in `sse_event_register` causes m=
issed event registration on hotplugged CPUs.
- [High] `sse_event_alloc_global` calls `smp_processor_id()` in a preemptib=
le context.
- [High] Missing synchronization in `sse_event_unregister()` leads to use-a=
fter-free with concurrently executing hardware event handlers.
- [Medium] `sse_event_set_target_cpu_nolock` silently ignores attribute wri=
te failures.
- [Medium] Mixing `goto` error handling with `guard()` and `scoped_guard()`=
 declarations violates subsystem cleanup guidelines.
- [Medium] The commit message claims clients can 'complete SSE events', but=
 no such API exists.
--

commit 1f43f4083e7681521e63a564e1ff80519c1569f5
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
Subject: drivers: firmware: add riscv SSE support

This commit adds a driver-level interface for RISC-V SSE support, allowing
Linux clients to register handlers and manage SSE events. It supports both
local and global events and handles CPU hotplug and PM transitions.

>     Add a driver-level interface for RISC-V SSE support.  The interface l=
ets
>     Linux clients register handlers and enable, disable and complete SSE
>     events.  It will be used by PMU and GHES drivers.

The commit message states the interface lets clients complete SSE events.
However, there does not appear to be any API provided to complete an event.

Could the commit message be updated to reflect the actual implementation?

> diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/ri=
scv/riscv_sbi_sse.c
> new file mode 100644
> index 0000000000000..830011ddd33f7
> --- /dev/null
> +++ b/drivers/firmware/riscv/riscv_sbi_sse.c
> @@ -0,0 +1,694 @@
[ ... ]
> +static int sse_event_attr_get_no_lock(struct sse_registered_event *reg_e=
vt,
> +				      unsigned long attr_id, unsigned long *val)
> +{
> +	struct sbiret sret;
> +	u32 evt =3D reg_evt->event->evt_id;
> +	unsigned long phys;
> +
> +	phys =3D sse_event_get_attr_phys(reg_evt);

Can this physical address be truncated on RV32 systems?

When CONFIG_ARCH_PHYS_ADDR_T_64BIT is enabled, physical addresses are 64 bi=
ts,
but unsigned long is 32 bits. Will the firmware receive a corrupted 32-bit
physical address since the ABI expects 64-bit values to be passed in two
registers on RV32?

[ ... ]
> +static int sse_event_attr_set_nolock(struct sse_registered_event *reg_ev=
t,
> +				     unsigned long attr_id, unsigned long val)
> +{
> +	struct sbiret sret;
> +	u32 evt =3D reg_evt->event->evt_id;
> +	unsigned long phys;
> +
> +	reg_evt->attr =3D val;
> +	phys =3D sse_event_get_attr_phys(reg_evt);

Is this subject to the same RV32 physical address truncation mentioned abov=
e?

[ ... ]
> +static int sse_event_set_target_cpu_nolock(struct sse_event *event,
> +					   unsigned int cpu)
> +{
> +	unsigned long hart_id =3D cpuid_to_hartid_map(cpu);
> +	struct sse_registered_event *reg_evt =3D event->global;
> +	u32 evt =3D event->evt_id;
> +	bool was_enabled;
> +	int ret;
> +
> +	if (!sse_event_is_global(evt))
> +		return -EINVAL;
> +
> +	was_enabled =3D reg_evt->is_enabled;
> +	if (was_enabled)
> +		sse_event_disable_local(event);
> +
> +	ret =3D sse_event_attr_set_nolock(reg_evt, SBI_SSE_ATTR_PREFERRED_HART,
> +					hart_id);
> +	if (ret =3D=3D 0)
> +		sse_global_event_update_cpu(event, cpu);
> +
> +	if (was_enabled)
> +		sse_event_enable_local(event);
> +
> +	return 0;
> +}

Should this function return the error code instead of unconditionally retur=
ning 0?

If the SBI call to set the preferred hart fails, the error is masked from t=
he
caller, leaving the kernel thinking the migration succeeded while the firmw=
are
state is out of sync.

[ ... ]
> +static int sse_event_alloc_global(struct sse_event *event)
> +{
> +	int err;
> +	struct sse_registered_event *reg_evt;
> +
> +	reg_evt =3D kzalloc_obj(*reg_evt, GFP_KERNEL);
> +	if (!reg_evt)
> +		return -ENOMEM;
> +
> +	event->global =3D reg_evt;
> +	err =3D sse_event_init_registered(smp_processor_id(), reg_evt, event);

Is it safe to call smp_processor_id() here?

sse_event_alloc_global() is invoked from sse_event_register(), which only
holds a mutex and runs with preemption enabled. Could this trigger a warning
if CONFIG_DEBUG_PREEMPT is enabled, or allow the thread to migrate
immediately after, yielding an invalid CPU ID?

[ ... ]
> +struct sse_event *sse_event_register(u32 evt, u32 priority,
> +				     sse_event_handler_fn *handler, void *arg)
> +{
> +	struct sse_event *event;
> +	int cpu;
> +	int ret =3D 0;
> +
> +	if (!sse_available)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	guard(mutex)(&sse_mutex);

This isn't a bug, but is it intended to mix goto-based error handling with
scope-based guard declarations in the same function?

The cleanup subsystem documentation recommends against this pattern as it c=
an
create confusing ownership semantics.

> +	if (sse_event_get(evt))
> +		return ERR_PTR(-EEXIST);
> +
> +	event =3D sse_event_alloc(evt, priority, handler, arg);
> +	if (IS_ERR(event))
> +		return event;
> +
> +	scoped_guard(cpus_read_lock) {
> +		if (sse_event_is_global(evt)) {
> +			unsigned long preferred_hart;
> +
> +			ret =3D sse_event_attr_get_no_lock(event->global,
> +							 SBI_SSE_ATTR_PREFERRED_HART,
> +							 &preferred_hart);
> +			if (ret)
> +				goto err_event_free;
> +
> +			cpu =3D riscv_hartid_to_cpuid(preferred_hart);

Can riscv_hartid_to_cpuid() return -ENOENT here?

If the firmware returns an unknown or unmapped hart ID, it appears the
negative value is passed to sse_global_event_update_cpu(), which uses it to
index the logical hart array via cpuid_to_hartid_map(), potentially causing
an out-of-bounds memory read.

> +			sse_global_event_update_cpu(event, cpu);
> +
> +			ret =3D sse_sbi_register_event(event, event->global);
> +			if (ret)
> +				goto err_event_free;
> +
> +		} else {
> +			ret =3D sse_on_each_cpu(event, SBI_SSE_EVENT_REGISTER,
> +					      SBI_SSE_EVENT_DISABLE);

Should the revert function be SBI_SSE_EVENT_UNREGISTER instead of
SBI_SSE_EVENT_DISABLE?

Disabling an event merely masks it without unregistering it from the firmwa=
re.
If registration fails on any CPU, does this leave the firmware holding an
active registration pointing to freed memory after the error path frees the
event structures?

> +			if (ret)
> +				goto err_event_free;
> +		}
> +	}
> +
> +	scoped_guard(spinlock, &events_list_lock)
> +		list_add(&event->list, &events);

Because the cpus_read_lock is released before acquiring events_list_lock to
add the event to the global list, could a CPU hotplug operation occur in
this window?

If so, sse_cpu_online() would iterate over the list and miss the new event,
resulting in the event not being registered on the new CPU.

> +
> +	return event;
> +
> +err_event_free:
> +	sse_event_free(event);
> +
> +	return ERR_PTR(ret);
> +}
[ ... ]
> +void sse_event_unregister(struct sse_event *event)
> +{
> +	scoped_guard(mutex, &sse_mutex) {
> +		scoped_guard(cpus_read_lock)
> +			sse_event_unregister_nolock(event);

Is there a missing compound block around the cpus_read_lock guard?

Without braces, the lock is dropped before acquiring events_list_lock. Coul=
d a
concurrent CPU hotplug operation acquire the list lock, find the partially
unregistered event still in the list, and erroneously register and enable
it in the firmware for the new CPU?

> +
> +		scoped_guard(spinlock, &events_list_lock)
> +			list_del(&event->list);
> +
> +		sse_event_free(event);

Since SBI events are delivered as NMI-like notifications, could an event ha=
ve
just fired and its handler be actively executing on another CPU?

Without synchronization like waiting for active handlers or RCU grace perio=
ds,
it seems sse_handle_event() might dereference evt->handler and
evt->handler_arg after the memory has been freed.

> +	}
> +}
[ ... ]
> +static int sse_cpu_online(unsigned int cpu)
> +{
> +	struct sse_event *event;
> +
> +	scoped_guard(spinlock, &events_list_lock) {
> +		list_for_each_entry(event, &events, list) {
> +			if (sse_event_is_global(event->evt_id))
> +				continue;
> +
> +			sse_event_register_local(event);
> +			if (sse_get_reg_evt(event))
> +				sse_event_enable_local(event);

Should this check reg_evt->is_enabled before unconditionally enabling the e=
vent?

If a driver registers an event but intentionally leaves it disabled, it loo=
ks
like it will unexpectedly become enabled on the newly hotplugged CPU.

> +		}
> +	}
> +
> +	/* Ready to handle events. Unmask SSE. */
> +	return sse_events_unmask();
> +}
> +
> +static int sse_cpu_teardown(unsigned int cpu)
> +{
> +	int ret =3D 0;
> +	unsigned int next_cpu;
> +	struct sse_event *event;
> +	struct sse_registered_event *reg_evt;
> +
> +	/* Mask the sse events */
> +	ret =3D sse_events_mask();
> +	if (ret)
> +		return ret;
> +
> +	scoped_guard(spinlock, &events_list_lock) {
> +		list_for_each_entry(event, &events, list) {
> +			/* Disable local event on current cpu */
> +			if (!sse_event_is_global(event->evt_id)) {
> +				reg_evt =3D sse_get_reg_evt(event);
> +				if (reg_evt->is_enabled)
> +					sse_event_disable_local(event);
> +
> +				sse_sbi_unregister_event(event);
> +				continue;
> +			}
> +
> +			if (event->cpu !=3D smp_processor_id())
> +				continue;
> +
> +			/* Update destination hart for global event */
> +			next_cpu =3D cpumask_any_but(cpu_online_mask, cpu);
> +			ret =3D sse_event_set_target_cpu_nolock(event, next_cpu);

What happens if there are no other CPUs online during teardown?

If cpumask_any_but() returns a value greater than or equal to nr_cpu_ids,
passing it to sse_event_set_target_cpu_nolock() might result in an
out-of-bounds array read in cpuid_to_hartid_map().

Furthermore, by migrating rather than unregistering global events on reboot,
does this break kexec by leaving the event actively registered for the next
kernel?

> +		}
> +	}
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778331862.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D3
