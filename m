Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091835;
	b=x/KNx+5xzSPKQfWtfZAwWFMt2gTr9VaQNUiiWvT91lb2DNgBTl+OQ1EgkDyry0lXgVnW
	 YjOQWt3gcT4sDoHAvUTcdj61nCln+nX3ElcMLDzZDi4HXUxp582W8yrFSXzUHcc+EFyoe
	 nDpqQK6doagv1R/TeISasXsvH0dR0FLHoXT0+wNPGX/nMqfM5oAF6fIpU3YqR6syAU7o1
	 egE6TXk6ZWjC9afmgZvue0EUq0qAHPgaYtwL5RDVTZOUgsFP3fJO1P9mVgM7hk9jTCjXH
	 T23oCJQvQ8hUn9bA2dvJQY/GIONGcO0afuxZThG98EA6wCIXf8GfDjx1HTjJfCvrsKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/AoMC/1cb5tMqw0OE5DyqvSftJxPvWsVp36Na7nehD0=;
	b=Novt5hrxTImu3mvEwXILDOp1m8eJhwJHL24ZgCJErOwLqPFB05fqnqU4lYO87CZ7T60M
	 yROdDZZiTkxzzNgaVK0P1nDxxXsubp7wM5H2OWOGtmSouHZyeLqn/GmOurMff53GRU6X0
	 p2I+s+Hm8nwXf+lKA+J4JG1w6wNw47sf1NZPKNxFlb/lA6nSku0O/XRTxRxH0oLv91TVk
	 0gduYbwUD+qad8Ri8OeNvSbWjJJ76PTnoHAzIDaGSo/W+t0HoqnAH3ZIFMTfwB3kBltA7
	 PU/G38Ydx3iaR49P5WyHF8pCXRK/DIeti3ScmjlNWVzrnDKNfzVQ8YIJAuY88RDVBHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4O1aMA6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF7606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n4O1aMA6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573C01F000C5;
	Thu, 19 Nov 2026 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795091834;
	bh=/AoMC/1cb5tMqw0OE5DyqvSftJxPvWsVp36Na7nehD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4O1aMA6vKv9+nsoIGjpwzQm9HyVectkN6yDzqMNXzHbxBM1JYUQnCh8lZpVYyYRS
	 wM6wzlWEqJx7FCQvygo9xYEMNT118YIJ69bOYzs6QWBkGDD6vAcaP8vzN5Z2sSUgNb
	 nJy4BLb/742ahPQIlViEctlyJWSpww/dOFTYxkQh1k22gYjONSkh7jN6eiY45Kx8qz
	 7eSUHnz6sczLaBJC4dKaBiQRAUPeZbzmItswdIEkdXlqHBXTHbtlMbE6zP1Xw3DCja
	 sCLAwqZGJwobDxz0e/miis4dknrp+dM4izEHzXEe90qC4G6J0RlWqgnair2mJsr1H+
	 8u/CbBxn+blow==
Message-ID: <sashiko-outbox-223098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/11] selftests/riscv: add SSE test module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119120824.13969-23-zhangzhanpeng.jasper@bytedance.com>
References: <20261119120824.13969-13-zhangzhanpeng.jasper@bytedance.com>
 <20261119120824.13969-23-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:37:13 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [Medium] selftests/riscv: sse: deadlock between migrate_disable() and
  cpus_read_lock()
- [Medium] selftests/riscv: sse: fast test ignores errors and races on
  1-jiffy timeout
- [Medium] selftests/riscv: sse: stress test treats -EEXIST as failure
  instead of skip
- [Medium] selftests/riscv: sse module Makefile defaults KDIR to host
  /lib/modules
- [Low] selftests/riscv: sse: stale pointers left in priority_test_arg
  on teardown
- [Low] selftests/riscv: sse: swapped log args in sse_test_handler() and
  dead field
- [Low] selftests/riscv: run_sse_test.sh added with non-executable mode
  0644
--

commit e938d689e90e8ec77bc093b9edf15fcf64552952
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

selftests/riscv: add SSE test module

This commit adds a kernel module and kselftest runner script to test the
RISC-V SBI Supervisor Software Events (SSE) framework, including fast
injection, event priority chaining, and stress modes.

> diff --git a/tools/testing/selftests/riscv/sse/module/Makefile b/tools/te=
sting/selftests/riscv/sse/module/Makefile
> new file mode 100644
> index 0000000000000..eac4b1c6228bb
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/module/Makefile
> @@ -0,0 +1,22 @@
> +ifneq ($(CONFIG_RISCV_SBI_SSE),)
> +obj-m +=3D riscv_sse_test.o
> +endif
> +
> +ifndef KERNELRELEASE
> +
> +TESTMODS_DIR :=3D $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)=
))))
> +KDIR ?=3D /lib/modules/$(shell uname -r)/build
> +
> +# Ensure that KDIR exists, otherwise skip the compilation
> +modules:
> +ifneq ("$(wildcard $(KDIR))", "")
> +	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=3D$(TESTMODS_DIR)
> +endif

[Severity: Medium]
Does defaulting KDIR to /lib/modules/$(shell uname -r)/build break
cross-compilation and in-tree or O=3D builds?

When cross-compiling with ARCH=3Driscv on a non-RISC-V host where
/lib/modules/$(uname -r)/build exists, Kbuild runs against the host kernel
headers with ARCH=3Driscv and fails.  When /lib/modules/$(uname -r)/build is
absent or points to a running kernel without CONFIG_RISCV_SBI_SSE,
riscv_sse_test.ko is silently skipped instead of building against the
target kernel tree.  Other selftest modules (such as
tools/testing/selftests/mm/page_frag/Makefile) resolve KDIR from O,
KBUILD_OUTPUT, or $(abs_srctree).

> diff --git a/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c b/=
tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
> new file mode 100644
> index 0000000000000..cc5c2e46f2fdb
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
[ ... ]
> +static int sse_test_handler(u32 evt, void *arg, struct pt_regs *regs)
> +{
> +	int ret =3D 0;
> +	struct fast_test_arg *targ =3D arg;
> +	u32 test_evt;
> +	int cpu;
> +
> +	atomic_inc(&sse_test_handler_count);
> +
> +	/* Pairs with the argument publication in sse_run_fast_test_cpu(). */
> +	if (!smp_load_acquire(&targ->args_ready)) {
> +		sse_err("Received SSE event %x before its test arguments were publishe=
d\n",
> +			evt);
> +		ret =3D -EINVAL;
> +		goto complete;
> +	}
> +
> +	test_evt =3D READ_ONCE(targ->evt);
> +	cpu =3D READ_ONCE(targ->cpu);
> +
> +	if (evt !=3D test_evt) {
> +		sse_err("Received SSE event id %x instead of %x\n", test_evt, evt);
> +		ret =3D -EINVAL;
> +	}

[Severity: Low]
Are test_evt and evt swapped in this sse_err() call?  evt is the received
event ID and test_evt is the expected one.

Also, struct priority_test_arg below defines an unused check_func member.

[ ... ]

> +static int sse_run_fast_test_cpu(struct fast_test_arg *test_arg,
> +				 struct sse_event *event, u32 evt, int cpu)
> +{
> +	unsigned long timeout;
> +	int ret;
> +
> +	WRITE_ONCE(test_arg->completion, false);
> +	WRITE_ONCE(test_arg->args_ready, false);
> +	WRITE_ONCE(test_arg->evt, evt);
> +	WRITE_ONCE(test_arg->cpu, cpu);
> +	/* Publish all arguments before firmware can inject on another hart. */
> +	smp_store_release(&test_arg->args_ready, true);
> +
> +	ret =3D sse_test_inject_event(event, evt, cpu);
> +	if (ret) {
> +		sse_err("event %s injection failed, err %d\n",
> +			sse_evt_name(evt), ret);
> +		return ret;
> +	}
> +
> +	timeout =3D jiffies + HZ / 100;
> +	/* We can not use <linux/completion.h> since they are not NMI safe */
> +	/* Pairs with the handler's completion publication. */
> +	while (!smp_load_acquire(&test_arg->completion) &&
> +	       time_before(jiffies, timeout))
> +		cpu_relax();
> +	/* Acquire the handler's checks even if the loop observed a timeout. */
> +	if (!smp_load_acquire(&test_arg->completion)) {
> +		sse_err("Failed to wait for event %s completion on CPU %d\n",
> +			sse_evt_name(evt), cpu);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return sse_test_wait_not_running_on_cpu(evt, cpu);
> +}
> +
> +static void sse_run_fast_test(struct fast_test_arg *test_arg,
> +			      struct sse_event *event, u32 evt)
> +{
> +	int cpu;
> +
> +	if (sse_event_is_global(evt)) {
> +		/* Keep the selected target online through injection and completion. */
> +		cpu_hotplug_disable();
> +		for_each_online_cpu(cpu) {
> +			if (sse_run_fast_test_cpu(test_arg, event, evt, cpu))
> +				break;
> +		}
> +		cpu_hotplug_enable();
> +		return;
> +	}
> +
> +	guard(cpus_read_lock)();
> +	for_each_online_cpu(cpu) {
> +		if (sse_run_fast_test_cpu(test_arg, event, evt, cpu))
> +			return;
> +	}
> +}
> +
> +static void sse_test_injection_fast(void)
> +{
[ ... ]
> +		for (j =3D 0; j < RUN_LOOP_COUNT; j++)
> +			sse_run_fast_test(&fast_test_arg, event, evt);

[Severity: Medium]
Can a timeout in sse_run_fast_test_cpu() race with an in-flight handler on
fast_test_arg across the remaining RUN_LOOP_COUNT iterations?

With CONFIG_HZ=3D100, HZ / 100 is 1 jiffy, which can expire on the next
timer tick while waiting for a remote CPU.  On timeout,
sse_run_fast_test_cpu() returns without calling
sse_test_wait_not_running_on_cpu(), and sse_run_fast_test() discards the
error so sse_test_injection_fast() immediately starts the next iteration
and overwrites the shared static fast_test_arg while the delayed handler
may still be running (or stalls module load if all 1,000 iterations time
out).  In addition, non-timeout errors in
sse_test_wait_not_running_on_cpu() (-ENOMEM or smp_call_function_single()
and sse_event_attr_read() failures) return without logging sse_err(), so
run_sse_test.sh will not detect them.

[ ... ]

> +static void sse_test_injection_priority_arg(struct priority_test_arg *ar=
gs, unsigned int args_size,
> +					    sse_event_handler_fn handler, const char *test_name)
> +{
> +	unsigned int i;
> +	unsigned long timeout;
> +	int ret;
> +	int target_cpu;
> +	struct sse_event *event;
> +	struct priority_test_arg *arg, *first_arg =3D NULL, *prev_arg =3D NULL;
> +
> +	pr_info("Starting SSE priority test (%s)\n", test_name);
> +	/* Keep the complete priority chain on one CPU. */
> +	migrate_disable();
> +	target_cpu =3D smp_processor_id();
> +
> +	for (i =3D 0; i < args_size; i++) {
> +		arg =3D &args[i];
> +
> +		if (!sse_test_can_inject_event(arg->evt))
> +			continue;
> +
> +		WRITE_ONCE(arg->called, false);
> +		WRITE_ONCE(arg->next_evt_arg, NULL);
> +		WRITE_ONCE(arg->event, NULL);
> +		WRITE_ONCE(arg->enable_attempted, false);
> +
> +		event =3D sse_test_event_register(arg->evt, arg->prio, handler,
> +						(void *)arg);

[Severity: Medium]
Can calling sse_test_event_register() and the other SSE helpers inside
migrate_disable() deadlock with CPU hotplug?

migrate_disable() pins the task to target_cpu without blocking CPU
hotplug, while sse_event_register(), sse_event_set_target_cpu(),
sse_event_enable(), sse_event_disable(), and sse_event_unregister() each
acquire cpus_read_lock() internally:

CPU0 (target_cpu)                 CPU1
-----------------                 ----
sse_test_injection_priority_arg()
  migrate_disable()
                                  _cpu_down(target_cpu)
                                    cpus_write_lock()
                                    ...
                                    sched_cpu_wait_empty()
                                      balance_hotplug_wait()
  sse_test_event_register()
    sse_event_register()
      mutex_lock(&sse_mutex)
      cpus_read_lock()

 *** DEADLOCK ***

CPU1 holds cpus_write_lock() and waits in balance_hotplug_wait() for
pinned tasks on target_cpu to call migrate_enable(), while CPU0 is pinned
to target_cpu and blocks in cpus_read_lock() (also holding sse_mutex).
Surrounding the migrate_disable() section with cpu_hotplug_disable() and
cpu_hotplug_enable() avoids the lock inversion and prevents
sse_cpu_teardown() from tearing down SSE on target_cpu mid-test.

[ ... ]

> +release_events:
> +
> +	for (i =3D 0; i < args_size; i++) {
> +		arg =3D &args[i];
> +		event =3D arg->event;
> +		if (!event)
> +			continue;
> +
> +		ret =3D sse_test_wait_not_running_on_cpu(arg->evt, target_cpu);
> +		if (ret)
> +			sse_err("Event %s did not complete, err %d\n",
> +				sse_evt_name(arg->evt), ret);
> +
> +		if (arg->enable_attempted) {
> +			ret =3D sse_event_disable(event);
> +			if (ret) {
> +				sse_err("Failed to disable event %s, err %d\n",
> +					sse_evt_name(arg->evt), ret);
> +				sse_test_queue_cleanup(event);
> +				WRITE_ONCE(arg->event, NULL);
> +				WRITE_ONCE(arg->enable_attempted, false);
> +				continue;
> +			}
> +		}
> +
> +		ret =3D sse_test_event_unregister(event);
> +		if (ret) {
> +			sse_err("Failed to unregister event %s, err %d\n",
> +				sse_evt_name(arg->evt), ret);
> +			continue;
> +		}
> +
> +		WRITE_ONCE(arg->event, NULL);
> +		WRITE_ONCE(arg->enable_attempted, false);
> +	}

[Severity: Low]
Does release_events leave stale pointers in priority_test_arg when disable
or unregister fails?

When sse_test_event_unregister() fails, it queues event for deferred
freeing via sse_test_queue_cleanup(), but the error branch jumps to the
next iteration before clearing arg->event and arg->enable_attempted.
Also, release_events never clears arg->next_evt_arg, so if an event fails
to disable or unregister and fires late after its successor in args[] has
been unregistered, the handler will read a non-NULL targ->next_evt_arg and
signal the unregistered successor event.

[ ... ]

> +static int sse_stress_test_layer(int layer)
> +{
[ ... ]
> +	event =3D sse_test_event_register(stress_ctx.evt_id, 0,
> +					stress_handlers[layer], &stress_ctx);
> +	if (IS_ERR(event)) {
> +		sse_err("Failed to register stress event, err %ld\n",
> +			PTR_ERR(event));
> +		return PTR_ERR(event);
> +	}
[ ... ]
> +static void sse_stress_test_all_layers(void)
> +{
> +	int i, ret;
> +
> +	pr_info("Starting SSE stress tests: duration=3D%d ms, interval=3D%d ns\=
n",
> +		STRESS_DURATION_MS, STRESS_INJECT_NS);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(stress_handlers); i++) {
> +		ret =3D sse_stress_test_layer(i);
> +		if (ret) {
> +			sse_err("Stress layer %d failed, err %d\n", i, ret);
> +			break;
> +		}

[Severity: Medium]
Should sse_stress_test_layer() skip rather than fail when
sse_test_event_register() returns -EEXIST?

Unlike sse_test_injection_fast() and sse_test_injection_priority_arg(),
sse_stress_test_layer() and sse_stress_test_all_layers() log sse_err() on
-EEXIST.  Because run_sse_test.sh checks for FAILED: before SKIP:,
running with stress=3D1 or stress=3D2 when
SBI_SSE_EVENT_LOCAL_SOFTWARE_INJECTED is already registered exits with
failure (1) instead of ksft_skip (4).

> diff --git a/tools/testing/selftests/riscv/sse/run_sse_test.sh b/tools/te=
sting/selftests/riscv/sse/run_sse_test.sh
> new file mode 100644
> index 0000000000000..e70a2fd14b05e
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/run_sse_test.sh
> @@ -0,0 +1,59 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

[Severity: Low]
Should run_sse_test.sh have mode 0755 instead of 0644?

Because the script is not executable, invoking ./run_sse_test.sh directly
fails with permission denied, and tools/testing/selftests/kselftest/runner.=
sh
logs a warning and takes its non-executable fallback path, which drops
kselftest_cmd_args instead of forwarding module arguments such as stress=3D1
to insmod.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119120824.1396=
9-13-zhangzhanpeng.jasper@bytedance.com?part=3D10
