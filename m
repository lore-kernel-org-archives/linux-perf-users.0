Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275950;
	b=gvLbIRt0fBJtfoAXnIT6j/by83O/UyxaFKC8eQgOifiGIgTQhk2CE89ew2dLasGdFtYU
	 ojb+swuB76XZ1JRJQzgvj3QHzSFANE/qlizPdDr4FYOHu/jI4WhKrMRK7I1Hfjzx48vo/
	 rwHpWm8PMAp93L62u1S0IGfkR64hbqurq/1idjClZcnUQvr6auIXmFX90BkH2N5/x+hSF
	 e8WaWTstZ9Z6jP+y2YrAabaBr4446NT8bfI0AXnm5GOl5JwUwLm6uTLrzd1dfunuoiMJ3
	 7VusQC6mZBIXYMJEonUERaQthnMdmzHVLoL9ELLAUyB3gUVJ/lA8soBZXFuFvfNY6ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275950;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BrwPS8X9OSHbJfL7Q2I8zaZhuz2iTkj5sJBog61uFI8=;
	b=ZSlQ+77wt8fBVkjHkn0HVTZjYP4rjHbzdeHaHa6+YpUFisXhvGqhRpjN7Rp+SKhwbXgb
	 3IDczqcZgPZJ3oEGg4UANk/FI0FZL8jaUuR0R9gEMJNNdUKRGyIHgm/1bYzmUkp2By8dB
	 BJePkGPBTJCVgMqX5gL5e8/klVlYYww96SErSbHw+RHGn71rGzJQ1GJO8Y4ZUyr/xzm2I
	 1XpT3IzZwk5aUZSjroEE4EmCxO/mkdrM9SN+fNriAPUSA6/pFGizAy/rh2L8/TAav1S6T
	 sMUJzXthdJmq+mkr6J0tlCkN/eCKIsf0DRrNPGC+hmNkauTmMnjuRApIjQ6qa8324wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcDMquUJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10E606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcDMquUJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A56A1F01825;
	Thu, 29 Oct 2026 12:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793275949;
	bh=BrwPS8X9OSHbJfL7Q2I8zaZhuz2iTkj5sJBog61uFI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcDMquUJFcAzJPFcmfI60241K4nKO7sUmHxBBcGPFg1Tb7U1sUZF/vOOkFYuqKmek
	 CfwXdzFAvs/GRno57MPMYMOzC0cAwKMh4tSJePjzEtUwZme3Kz97S0yvgiIrom7l0w
	 JvOeC2dTT3CpZ2emTPJiL8MP0aEYbw96ajm6CTWJ0tVkhjfa8qnblMTcaJ9+hWoHhq
	 hJRiKwXu+BWErNUGR59fCqE0SPFY1+WIvCtWJFi3RheOSkmtrEKZnMuAc3KrRnid3H
	 RSlZNJAL5tk+4iIqhYKvPOuQandO5BJ6sQ4YUCtMSs7TG8/0lu30N0zf9YYYTz2uKg
	 lnvagstv3t7Xw==
Message-ID: <sashiko-outbox-189260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/11] selftests/riscv: add SSE test module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029114953.27453-2-zhangzhanpeng.jasper@bytedance.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029114953.27453-2-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 12:12:29 +0000
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
- [High] selftests/riscv: sse: deadlock between migrate_disable() and cpus_=
read_lock()
- [Medium] selftests/riscv: sse: fast test ignores errors and races on 1-ji=
ffy timeout
- [Medium] selftests/riscv: sse: make install fails when riscv_sse_test.ko =
is not built
- [Medium] selftests/riscv: sse: run_sse_test.sh added without executable p=
ermissions
- [Medium] selftests/riscv: sse: stress test treats -EEXIST as failure inst=
ead of skip
- [Low] selftests/riscv: sse: swapped event ID arguments in sse_test_handle=
r()
--

commit f2ce096e05cb9e91fc9386faf3d3f4d77029d337
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

selftests/riscv: add SSE test module

This commit adds a RISC-V SSE selftest kernel module and a shell runner
script to exercise event injection, priority ordering, and stress scenarios
with SBI calls and self re-injection.

> diff --git a/tools/testing/selftests/riscv/sse/Makefile b/tools/testing/s=
elftests/riscv/sse/Makefile
> new file mode 100644
> index 0000000000000..7e2677fdce09a
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/Makefile
> @@ -0,0 +1,5 @@
> +TEST_GEN_MODS_DIR :=3D module
> +
> +TEST_PROGS :=3D run_sse_test.sh
> +
> +include ../../lib.mk
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
Does make install fail for the riscv selftests when riscv_sse_test.ko is not
built?

In tools/testing/selftests/riscv/sse/Makefile, TEST_GEN_MODS_DIR is set
unconditionally to module. However, in
tools/testing/selftests/riscv/sse/module/Makefile, building riscv_sse_test.o
is skipped when CONFIG_RISCV_SBI_SSE is disabled or when KDIR (which defaul=
ts
to the build host's /lib/modules/$(shell uname -r)/build) does not exist.

When no .ko is produced in module/, INSTALL_MODS_RULE in
tools/testing/selftests/lib.mk runs:

    rsync -a --copy-unsafe-links module/*.ko $(INSTALL_PATH)/module

which fails with exit status 23 because module/*.ko matches no files. Since
sse is the final target in RISCV_SUBTARGETS in
tools/testing/selftests/riscv/Makefile, this causes the top-level riscv
selftests install target to fail.

[ ... ]

> diff --git a/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c b/=
tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
> new file mode 100644
> index 0000000000000..cc5c2e46f2fdb
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c

[ ... ]

> +static int sse_test_wait_not_running_on_cpu(u32 evt, unsigned int cpu)
> +{
> +	struct sse_test_wait_status wait =3D { .evt =3D evt };
> +	unsigned long timeout;
> +	int ret =3D 0;
> +
> +	if (sse_event_is_global(evt))
> +		return sse_test_wait_not_running(evt);
> +
> +	wait.attr_buf =3D kmalloc_obj(*wait.attr_buf, GFP_KERNEL);
> +	if (!wait.attr_buf)
> +		return -ENOMEM;
> +
> +	timeout =3D jiffies + HZ;
> +	do {
> +		ret =3D smp_call_function_single(cpu, sse_test_read_status_local,
> +					       &wait, true);
> +		if (ret || wait.ret) {
> +			ret =3D ret ?: wait.ret;
> +			break;
> +		}
> +		if (wait.status !=3D SBI_SSE_STATE_RUNNING)
> +			break;
> +		usleep_range(100, 200);
> +	} while (time_before(jiffies, timeout));
> +
> +	if (!ret && wait.status =3D=3D SBI_SSE_STATE_RUNNING) {
> +		sse_err("Timed out waiting for event %x on CPU %u\n", evt, cpu);
> +		ret =3D -ETIMEDOUT;
> +	}
> +
> +	kfree(wait.attr_buf);
> +
> +	return ret;
> +}

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
Are test_evt and evt swapped in the sse_err() format arguments in
sse_test_handler()? evt is the received event ID and test_evt is the
expected one.

> +
> +	if (!sse_event_is_global(evt) && cpu !=3D smp_processor_id()) {
> +		sse_err("Received SSE event %d on CPU %d instead of %d\n", evt, smp_pr=
ocessor_id(),
> +			cpu);
> +		ret =3D -EINVAL;
> +	}
> +
> +complete:
> +	WRITE_ONCE(targ->args_ready, false);
> +	/* Publish handler-side checks before waking the waiting CPU. */
> +	smp_store_release(&targ->completion, true);
> +
> +	return ret;
> +}
> +
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
> +	int i, ret =3D 0, j;
> +	u32 evt;
> +	struct sse_event *event;

[ ... ]

> +		for (j =3D 0; j < RUN_LOOP_COUNT; j++)
> +			sse_run_fast_test(&fast_test_arg, event, evt);
> +		pr_info("Finished testing event %s\n", sse_evt_name(evt));

[Severity: Medium]
What happens in sse_test_injection_fast() when sse_run_fast_test_cpu()
times out or returns an error?

In sse_run_fast_test_cpu(), timeout =3D jiffies + HZ / 100 is only 1 jiffy =
on
CONFIG_HZ_100=3Dy kernels (which can expire on the very next timer tick) and
2 jiffies on CONFIG_HZ_250=3Dy kernels. If this wait times out,
sse_run_fast_test_cpu() returns -ETIMEDOUT without calling
sse_test_wait_not_running_on_cpu(evt, cpu) to wait for the event to leave
SBI_SSE_STATE_RUNNING.

Because sse_run_fast_test() returns void, sse_test_injection_fast() continu=
es
running all RUN_LOOP_COUNT (1000) iterations even after a failure. On the
next iteration, sse_run_fast_test_cpu() immediately rewrites the shared
static fast_test_arg while the timed-out handler on the target CPU may still
be executing and accessing fast_test_arg. If sse_test_wait_not_running()
times out (1 second per iteration), running all 1000 iterations can also
stall module load for up to 1000 seconds.

Also, if sse_test_wait_not_running_on_cpu() fails with a non-timeout error
(such as -ENOMEM or an error from smp_call_function_single() or
sse_event_attr_read()), neither sse_test_wait_not_running_on_cpu() nor
sse_run_fast_test_cpu() calls sse_err(), so the error will not be logged as
a failure in dmesg. Should sse_run_fast_test() propagate errors to break out
of the RUN_LOOP_COUNT loop, use msecs_to_jiffies() for the completion
timeout, and ensure non-timeout errors are reported?

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
> +
> +	pr_info("Finished SSE priority test (%s)\n", test_name);
> +out:
> +	migrate_enable();
> +}

[Severity: High]
Can calling sse_event_register(), sse_event_set_target_cpu(),
sse_event_enable(), sse_event_disable(), and sse_event_unregister() inside a
migrate_disable() section in sse_test_injection_priority_arg() deadlock with
CPU hotplug?

In drivers/firmware/riscv/riscv_sbi_sse.c, each of those SSE APIs acquires
sse_mutex and cpus_read_lock():

    scoped_guard(mutex, &sse_mutex) {
        ...
        scoped_guard(cpus_read_lock) {
            ...
        }
    }

In sse_test_injection_priority_arg(), migrate_disable() pins the task to
target_cpu without holding cpus_read_lock() or cpu_hotplug_disable() across
the test. If a concurrent _cpu_down(target_cpu) starts between two SSE API
calls:

1. The hotplug thread acquires cpus_write_lock(), runs sse_cpu_teardown() on
   target_cpu (disabling/unregistering local events and migrating global
   events off target_cpu), and then waits in sched_cpu_wait_empty() ->
   balance_hotplug_wait() for !rq_has_pinned_tasks(rq) on target_cpu.

2. In sse_test_injection_priority_arg(), the next call to sse_event_*() tri=
es
   to acquire cpus_read_lock() while still holding migrate_disable() on
   target_cpu, blocking behind cpus_write_lock() while keeping
   rq->nr_pinned > 0.

Should sse_test_injection_priority_arg() acquire cpu_hotplug_disable()
before migrate_disable() (and release it after migrate_enable()) so that
target_cpu cannot be offlined while the task is pinned and acquiring
cpus_read_lock()?

[ ... ]

> +static int sse_stress_test_layer(int layer)
> +{
> +	struct sse_event *event;
> +	int inject_count, handler_count;
> +	int ret, target_cpu, unregister_ret;

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
> +
> +		msleep(100);
> +	}
> +
> +	pr_info("Finished SSE stress tests\n");
> +}

[Severity: Medium]
Should sse_stress_test_layer() skip rather than fail when
sse_test_event_register() returns -EEXIST?

The commit message notes that if firmware reports injectable events but the
test cannot acquire or handle any of them, it should report SKIP instead of
passing or failing. Both sse_test_injection_fast() and
sse_test_injection_priority_arg() check for PTR_ERR(event) =3D=3D -EEXIST a=
nd
skip with pr_info().

However, in sse_stress_test_layer(), -EEXIST is logged with sse_err() (which
emits the FAILED: prefix) and returned to sse_stress_test_all_layers(),
which logs another sse_err(). Because run_sse_test.sh checks for FAILED:
before SKIP:, an already-registered local software-injected event causes the
test run to fail instead of skipping.

[ ... ]

> diff --git a/tools/testing/selftests/riscv/sse/run_sse_test.sh b/tools/te=
sting/selftests/riscv/sse/run_sse_test.sh
> new file mode 100644
> index 0000000000000..e70a2fd14b05e
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/run_sse_test.sh
> @@ -0,0 +1,59 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0

[Severity: Medium]
Should tools/testing/selftests/riscv/sse/run_sse_test.sh be committed with
mode 100755 instead of 100644?

Because run_sse_test.sh is listed in TEST_PROGS without executable
permissions, running it directly fails with permission denied, and
tools/testing/selftests/kselftest/runner.sh (in run_one()) warns that the
file is not executable and falls back to invoking the interpreter without
forwarding $kselftest_cmd_args to the script.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029074853.3546=
7-1-zhangzhanpeng.jasper@bytedance.com?part=3D10
