Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC66D2D7D3A
	for <linux-perf-users@vger.kernel.org>; Sat,  9 May 2026 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342244; cv=none; b=Z74pHbkk11a59y8fZEECQftQqq9/v1denc/jMAo5gwxKPW2PsuAeaWdzDqRKS3AY6HwgrGgqFpJOpjomkxh8aDfbDvI0psuEs/hSnEP+Mmn5sI73z8YLK7BmtxUvCZK6RXyVovSwXhVLW6zGPMnYIGMaAaQE5/De1MyXsas3RUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342244; c=relaxed/simple;
	bh=iNhvzvGcPYhtelN6rTkIcG/VyO+sNmO/c0l0UltBl6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D1xv9ASGUlPYJmx89yBaMCkXZcHu3L1Z5bA+SAXUo7oG11+HLdl+nZojulbvPropAOagy092jkXJ78UpBHGEoQ+NGeMRktqjYyD81m2NAGUtpMlHM1zY6LztVT9+dwe72muTwz45uOFBaij05aGiS1Vys6hsJ9A/2u56Gol+Eow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J26lsRts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J26lsRts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B87C2BCB2;
	Sat,  9 May 2026 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342244;
	bh=iNhvzvGcPYhtelN6rTkIcG/VyO+sNmO/c0l0UltBl6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=J26lsRtsN/EfcE76WhFZY4TLsfv+CEMZ9/n6V9QmOT9On4Sh0BlTLgfvY7H3DLsBc
	 yAsnMBamOVJTJWyO7ej0U+0EZ/5o5jHELpqj6nowBk+M3kT1laXL/AaZh8kuZnWr4y
	 vWuK3CnRmoudNER0dGoJ0/b+kKaNAqP7h/JqLjir1kul8ig7OYUE2pYAkiqkY1fg+L
	 niCGUr2A07YTalijdA7G/oR0CrEhtPcnCiRYgzQUZnFRjgH50j3y5ibjaycqd+F6ln
	 kPdNs0Z3LTUZBkh1va/zK+KMWCUw1bG9xiXpstne07PJqw3BCOEQ+n5alfUi71TVDH
	 6hwbtVwm6gY7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/5] selftests/riscv: add SSE test module
Reply-To: sashiko@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <1f66bfb775e8b6658c6f2f2f48aa4f668f911db5.1778331862.5.git.zhangzhanpeng.jasper@bytedance.com>
References: <1f66bfb775e8b6658c6f2f2f48aa4f668f911db5.1778331862.5.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 15:57:23 +0000
Message-Id: <20260509155724.51B87C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Event resource leak in error path leads to Use-After-Free of stack=
 memory.
- [High] Use-After-Free of `task_struct` due to unsynchronized `kthread_sto=
p()`.
- [High] Physical address truncation on RV32 leads to hypervisor memory cor=
ruption.
- [Medium] The executable test script `run_sse_test.sh` is incorrectly assi=
gned to `TEST_FILES` instead of `TEST_PROGS`.
- [Medium] Time-Of-Check to Time-Of-Use (TOCTOU) race in timeout evaluation=
 causes false test failures.
- [Medium] Using `smp_processor_id()` in a preemptible context triggers ker=
nel warnings and migration races.
- [Medium] Infinite busy-wait loop without a timeout risks test soft-lockup=
s.
--

commit 044a5142115aaf579bd893af3ea7d69bca6b7dfa
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

selftests/riscv: add SSE test module

This module, once loaded, will execute a series of tests using the SSE
framework. The provided script will check for any error reported by the
test module.

> diff --git a/tools/testing/selftests/riscv/sse/Makefile b/tools/testing/s=
elftests/riscv/sse/Makefile
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/Makefile
> @@ -0,0 +1,5 @@
> +TEST_GEN_MODS_DIR :=3D module
> +
> +TEST_FILES :=3D run_sse_test.sh

Should run_sse_test.sh be in TEST_PROGS instead of TEST_FILES?

According to the selftests documentation, executable test scripts intended
to be run directly should be placed in TEST_PROGS, whereas TEST_FILES is
for auxiliary supporting files. Placing it in TEST_FILES might cause it to
be skipped during automated execution.

> diff --git a/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c b/=
tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c

[ ... ]

> +static int sse_event_attr_get(u32 evt, unsigned long attr_id,
> +			      unsigned long *val)
> +{
> +	struct sbiret sret;
> +	unsigned long *attr_buf, phys;
> +
> +	attr_buf =3D kmalloc_obj(*attr_buf, GFP_KERNEL);
> +	if (!attr_buf)
> +		return -ENOMEM;
> +
> +	phys =3D virt_to_phys(attr_buf);

Will this truncate the physical address on RV32 systems with high memory?

virt_to_phys() returns a phys_addr_t, which can be 64-bit on RV32 (Sv32).
Since phys is an unsigned long, the upper 32 bits might be silently
truncated.

> +
> +	sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, attr_id, =
1,
> +			 phys, 0, 0);

If the buffer resides above the 4GB boundary, could this corrupted physical
address cause the SBI firmware to write the attribute value to the wrong
memory location?

[ ... ]

> +static int sse_test_inject_event(struct sse_event *event, u32 evt, unsig=
ned int cpu)
> +{
> +	int res;
> +	unsigned long status;
> +
> +	if (sse_event_is_global(evt)) {
> +		/*
> +		 * Due to the fact the completion might happen faster than
> +		 * the call to SBI_SSE_COMPLETE in the handler, if the event was
> +		 * running on another CPU, we need to wait for the event status
> +		 * to be !RUNNING.
> +		 */
> +		do {
> +			res =3D sse_event_attr_get(evt, SBI_SSE_ATTR_STATUS, &status);
> +			if (res) {
> +				sse_err("Failed to get status for evt %x, error %d\n", evt, res);
> +				return res;
> +			}
> +			status =3D status & SBI_SSE_ATTR_STATUS_STATE_MASK;
> +		} while (status =3D=3D SBI_SSE_STATE_RUNNING);

Could this loop spin indefinitely if the SBI firmware encounters a bug or
takes an excessive amount of time?

Adding a timeout mechanism might be safer, especially since
sse_event_attr_get() allocates memory with GFP_KERNEL on each iteration.

[ ... ]

> +static void sse_run_fast_test(struct fast_test_arg *test_arg, struct sse=
_event *event, u32 evt)
> +{
> +	unsigned long timeout;
> +	int ret, cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		WRITE_ONCE(test_arg->completion, false);
> +		WRITE_ONCE(test_arg->cpu, cpu);
> +		/* Test arg is used on another CPU */
> +		smp_wmb();
> +
> +		ret =3D sse_test_inject_event(event, evt, cpu);
> +		if (ret) {
> +			sse_err("event %s injection failed, err %d\n", sse_evt_name(evt), ret=
);
> +			return;
> +		}
> +
> +		timeout =3D jiffies + HZ / 100;
> +		/* We can not use <linux/completion.h> since they are not NMI safe */
> +		while (!READ_ONCE(test_arg->completion) &&
> +		       time_before(jiffies, timeout)) {
> +			cpu_relax();
> +		}
> +		if (!time_before(jiffies, timeout)) {

Can this lead to a false test failure?

If the SSE event successfully completes at the exact same jiffy that the
timeout expires, the loop will exit safely because test_arg->completion is
true. However, the time_before() check right after will evaluate to false,
causing the code to incorrectly report a timeout. Checking
if (!READ_ONCE(test_arg->completion)) directly might be more robust.

> +			sse_err("Failed to wait for event %s completion on CPU %d\n",
> +				sse_evt_name(evt), cpu);
> +			return;
> +		}
> +	}
> +}

[ ... ]

> +static void sse_test_injection_priority_arg(struct priority_test_arg *ar=
gs, unsigned int args_size,
> +					    sse_event_handler_fn handler, const char *test_name)
> +{
> +	unsigned int i;
> +	int ret;
> +	struct sse_event *event;
> +	struct priority_test_arg *arg, *first_arg =3D NULL, *prev_arg =3D NULL;
> +
> +	pr_info("Starting SSE priority test (%s)\n", test_name);
> +	for (i =3D 0; i < args_size; i++) {
> +		arg =3D &args[i];
> +
> +		if (!sse_test_can_inject_event(arg->evt))
> +			continue;
> +
> +		WRITE_ONCE(arg->called, false);
> +		WRITE_ONCE(arg->next_evt_arg, NULL);
> +		WRITE_ONCE(arg->event, NULL);
> +
> +		event =3D sse_event_register(arg->evt, arg->prio, handler, (void *)arg=
);
> +		if (IS_ERR(event)) {
> +			if (PTR_ERR(event) =3D=3D -EEXIST) {
> +				pr_info("Event %s already registered, skipping\n",
> +					sse_evt_name(arg->evt));
> +				continue;
> +			}
> +			sse_err("Failed to register event %s, err %ld\n", sse_evt_name(arg->e=
vt),
> +				PTR_ERR(event));
> +			goto release_events;
> +		}
> +		arg->event =3D event;
> +
> +		if (sse_event_is_global(arg->evt)) {
> +			/* Target event at current CPU */
> +			ret =3D sse_event_set_target_cpu(event, smp_processor_id());

Is it safe to call smp_processor_id() here?

This function executes during module initialization, which is a preemptible
context. Calling smp_processor_id() without disabling preemption will
trigger a warning. Additionally, if the task migrates between CPUs during
this loop, global events might be bound to different CPUs, which might
violate the assumption that all events in the chain run on the exact same
CPU.

> +			if (ret) {
> +				sse_err("Failed to set event %s target CPU, err %d\n",
> +					sse_evt_name(arg->evt), ret);
> +				goto release_events;
> +			}
> +		}
> +
> +		ret =3D sse_event_enable(event);
> +		if (ret) {
> +			sse_err("Failed to enable event %s, err %d\n", sse_evt_name(arg->evt)=
, ret);
> +			goto release_events;
> +		}
> +
> +		if (prev_arg)
> +			WRITE_ONCE(prev_arg->next_evt_arg, arg);
> +
> +		prev_arg =3D arg;
> +
> +		if (!first_arg)
> +			first_arg =3D arg;
> +	}
> +
> +	if (!first_arg) {
> +		pr_info("No injectable event available for %s priority test\n",
> +			test_name);
> +		return;
> +	}
> +
> +	/* Inject first event, handler should trigger the others in chain. */
> +	ret =3D sse_test_inject_event(first_arg->event, first_arg->evt, smp_pro=
cessor_id());
> +	if (ret) {
> +		sse_err("SSE event %s injection failed\n", sse_evt_name(first_arg->evt=
));
> +		goto release_events;
> +	}
> +
> +	/*
> +	 * Event are injected directly on the current CPU after calling sse_tes=
t_inject_event()
> +	 * so that execution is preempted right away, no need to wait for timeo=
ut.
> +	 */
> +	arg =3D first_arg;
> +	while (arg) {
> +		if (!READ_ONCE(arg->called)) {
> +			sse_err("Event %s handler was not called\n",
> +				sse_evt_name(arg->evt));
> +			ret =3D -EINVAL;
> +		}
> +
> +		event =3D arg->event;
> +		arg =3D READ_ONCE(arg->next_evt_arg);
> +	}
> +
> +release_events:
> +
> +	arg =3D first_arg;
> +	while (arg) {
> +		event =3D arg->event;
> +		if (!event)
> +			break;
> +
> +		sse_event_disable(event);
> +		sse_event_unregister(event);
> +		arg =3D READ_ONCE(arg->next_evt_arg);
> +	}

Could this cleanup loop leak an event in the error path?

If sse_event_set_target_cpu() or sse_event_enable() fails, the code jumps
to release_events. However, the current event hasn't been linked into the
next_evt_arg chain yet (since prev_arg is updated after). This causes the
failing event to be skipped during cleanup.

If the firmware triggers this leaked event later, could it result in a
use-after-free? The handler context (arg) points to a local array on the
stack (e.g., default_hi_prio_args), so executing the handler after the
function returns would access destroyed stack memory.

> +
> +	pr_info("Finished SSE priority test (%s)\n", test_name);
> +}

[ ... ]

> +static int sse_stress_test_layer(int layer)
> +{
> +	struct sse_event *event;
> +	int ret;
> +
> +	if (layer < 0 || layer >=3D ARRAY_SIZE(stress_handlers))
> +		return -EINVAL;
> +
> +	pr_info("Starting SSE stress layer %d (%s)\n",
> +		layer, stress_layer_names[layer]);
> +
> +	memset(&stress_ctx, 0, sizeof(stress_ctx));
> +	stress_ctx.evt_id =3D SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED;
> +	stress_ctx.layer =3D layer;
> +	WRITE_ONCE(stress_ctx.running, true);
> +	atomic_set(&stress_ctx.inject_count, 0);
> +	atomic_set(&stress_ctx.handler_count, 0);
> +	init_waitqueue_head(&stress_ctx.wait_q);
> +
> +	event =3D sse_event_register(stress_ctx.evt_id, 0,
> +				   stress_handlers[layer], &stress_ctx);
> +	if (IS_ERR(event)) {
> +		sse_err("Failed to register stress event, err %ld\n",
> +			PTR_ERR(event));
> +		return PTR_ERR(event);
> +	}
> +
> +	stress_ctx.event =3D event;
> +
> +	ret =3D sse_event_enable(event);
> +	if (ret) {
> +		sse_err("Failed to enable stress event, err %d\n", ret);
> +		goto err_unregister;
> +	}
> +
> +	stress_ctx.monitor_task =3D kthread_run(stress_monitor_thread,
> +					      &stress_ctx, "sse_stress_mon");
> +	if (IS_ERR(stress_ctx.monitor_task)) {
> +		ret =3D PTR_ERR(stress_ctx.monitor_task);
> +		sse_err("Failed to create stress monitor thread, err %d\n", ret);
> +		goto err_disable;
> +	}
> +
> +	hrtimer_setup(&stress_ctx.timer, stress_timer_callback,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_PINNED);
> +	hrtimer_start(&stress_ctx.timer, ns_to_ktime(STRESS_INJECT_NS),
> +		      HRTIMER_MODE_REL_PINNED);
> +
> +	hrtimer_setup(&stress_ctx.stop_timer, stress_stop_timer_callback,
> +		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_start(&stress_ctx.stop_timer, ms_to_ktime(STRESS_DURATION_MS),
> +		      HRTIMER_MODE_REL);
> +
> +	wait_event(stress_ctx.wait_q, READ_ONCE(stress_ctx.test_done));
> +
> +	WRITE_ONCE(stress_ctx.running, false);
> +	hrtimer_cancel(&stress_ctx.timer);
> +	hrtimer_cancel(&stress_ctx.stop_timer);
> +	kthread_stop(stress_ctx.monitor_task);

Can setting stress_ctx.running to false before calling kthread_stop() lead
to a use-after-free?

If stress_monitor_thread() wakes up and observes running =3D=3D false, it w=
ill
exit its loop and terminate naturally, dropping its reference to the
task_struct. Since the caller didn't take an extra reference via
get_task_struct(), the task_struct might be freed before kthread_stop() is
called.

> +
> +	pr_info("Finished SSE stress layer %d (%s): inject=3D%d, handler=3D%d\n=
",
> +		layer, stress_layer_names[layer],
> +		atomic_read(&stress_ctx.inject_count),
> +		atomic_read(&stress_ctx.handler_count));
> +
> +err_disable:
> +	sse_event_disable(event);
> +err_unregister:
> +	sse_event_unregister(event);
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1778331862.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D5
