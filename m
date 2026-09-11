Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2717830D3F6
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130430; cv=none; b=GtE2OKTgSDFt3a8y4p0dlpThGiyKGHtMZENkC07VrcCXN0pB9xESqbG9cU9aiynHVi4mOoXYl7DDD5+fEqKxCCjAT4ZmeBwNL2f8PE5oVL+qcC9qhwf46I/kLLT5pRb071fDejtxVrGaSKSYUL1/ziySMoU66KjRRGe910Mj5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130430; c=relaxed/simple;
	bh=OayXyXnO9y2H036qreDoQGiMQURR0OJHTQ9gnlSgn88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onn2XdpOPg1Cw/1utWe1ZY7xlF8Mrq/t3dfw88LWPFqTSKJGkdKzj0M1l3GdFyu5yXI+Du8F8eDzeRe2VJrf4KrflHkAGtCCt6sFj2RGwIDRqlVQw7Lr8oM3lgfBXLsCSAXF45UTXUFRSxSlp4qatIfQt5cf9Jht0V3w58K1QmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J37n2dhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J37n2dhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DB51F00893;
	Fri, 11 Sep 2026 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130427;
	bh=Xj2Fw0Jitb1/g3BNda7wzFroSZTmXPzd9QLWCnnsv9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J37n2dhrMa6631+wGuFCis3Ck0/DSV5ZICDuq2P6n8T7UcT9RCVvc6g4xzErHYnRT
	 qNa+nKRR2dlIsLyyDTc3ghkCjG6FQHgUlQHMQRMChviR0HABsiPOo1MafY3cFQ69IJ
	 1hDaFXgiM/zoiRzMY0YuY6cM4WqfwvrFZUoS4nItnPTx2gh4OvA+048ovmVGukal+9
	 eyjzZ3DYDeJYvuF8IOMTgw+sRz3ZqWx+p8xvl64DIbSfl0W1R/zQA7Qj2JSVv27HOG
	 +oFCAfvICWyNpkXEze9tMBcksh+VUgzMMZNxTpdNgkQCUMssW++Fo3ObYkS8swrvod
	 IGiwYzHcWZ8xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 8/9] selftests/riscv: add SSE test module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911121456.33223-9-zhangzhanpeng.jasper@bytedance.com>
References: <20260911121456.33223-1-zhangzhanpeng.jasper@bytedance.com>
 <20260911121456.33223-9-zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:40:26 +0000
Message-Id: <20260911124027.21DB51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] Physical address truncation when passing `attr_buf` to SBI on RV=
32.
- [Medium] Memory allocation inside a busy-wait loop in `sse_test_wait_not_=
running()`.
- [Medium] `sse_test_injection_fast()` ignores injection errors and can han=
g the test suite for over 16 minutes.
- [Medium] Background cleanup worker loops infinitely and permanently leaks=
 the module refcount if a queued event is already disabled.
- [Medium] A delayed SSE event handler can overwrite `fast_test_arg.complet=
ion` in a subsequent test iteration, causing false passes.
--

commit c7a4c7b5432c658881e0fc3e7c6fa179158e9592
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

selftests/riscv: add SSE test module
   =20
Add an SSE selftest module and runner. Loading the module executes
smoke tests for the SSE framework, and the runner reports any error
emitted by the module.

> diff --git a/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c b/=
tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
> index 0000000000000..cc5c2e46f2fdb 100644
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c

[ ... ]

> +static void sse_test_cleanup_workfn(struct work_struct *work)
> +{
> +	bool retry =3D false;
> +	int i, ret;
> +
> +	mutex_lock(&sse_test_cleanup_lock);
> +	for (i =3D 0; i < ARRAY_SIZE(sse_test_cleanup_events); i++) {
> +		struct sse_event *event =3D sse_test_cleanup_events[i];
> +
> +		if (!event)
> +			continue;
> +
> +		ret =3D sse_event_disable(event);
> +		if (!ret)
> +			ret =3D sse_event_unregister(event);
> +		if (ret) {
> +			retry =3D true;
> +			continue;
> +		}

[Severity: Medium]
Will this cleanup worker loop infinitely if a queued event is already
disabled? Since sse_event_disable() will return an error (SBI_ERR_INVALID_S=
TATE)
when called on an already disabled event, the unregister call is skipped,
retry is set to true, and this background worker reschedules itself
permanently, leaking the module refcount.

> +
> +		sse_test_cleanup_events[i] =3D NULL;
> +		module_put(THIS_MODULE);
> +	}
> +	mutex_unlock(&sse_test_cleanup_lock);
> +
> +	if (retry)
> +		mod_delayed_work(system_wq, &sse_test_cleanup_work,
> +				 msecs_to_jiffies(100));
> +}

[ ... ]

> +static int sse_event_attr_read(u32 evt, unsigned long attr_id,
> +			       unsigned long *attr_buf)
> +{
> +	struct sbiret sret;
> +	phys_addr_t phys;
> +
> +	phys =3D virt_to_phys(attr_buf);
> +
> +	sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, evt, attr_id, =
1,
> +			 (unsigned long)phys, 0, 0);

[Severity: Medium]
Is the physical address safely cast here? On RV32 with >4GB physical RAM
(CONFIG_PHYS_ADDR_T_64BIT enabled), virt_to_phys() returns a 64-bit value,
which gets truncated to 32 bits by the (unsigned long) cast. The firmware
will receive a truncated address, potentially causing memory corruption.

> +	if (sret.error)
> +		return sbi_err_map_linux_errno(sret.error);
> +
> +	return 0;
> +}
> +
> +static int sse_event_attr_get(u32 evt, unsigned long attr_id,
> +			      unsigned long *val)
> +{
> +	unsigned long *attr_buf;
> +	int ret;
> +
> +	attr_buf =3D kmalloc_obj(*attr_buf, GFP_KERNEL);
> +	if (!attr_buf)
> +		return -ENOMEM;
> +
> +	ret =3D sse_event_attr_read(evt, attr_id, attr_buf);
> +	if (!ret)
> +		*val =3D *attr_buf;
> +	kfree(attr_buf);
> +
> +	return ret;
> +}

[ ... ]

> +static int sse_test_wait_not_running(u32 evt)
> +{
> +	unsigned long timeout =3D jiffies + HZ;
> +	unsigned long status;
> +	int ret;
> +
> +	do {
> +		ret =3D sse_event_attr_get(evt, SBI_SSE_ATTR_STATUS, &status);

[Severity: Medium]
Does this code thrash the allocator? sse_event_attr_get() calls kmalloc_obj=
()
and kfree() on each invocation. This loop repeatedly allocates and frees
memory while busy-waiting in a tight spin loop until the status changes
or a timeout is reached, which could cause massive memory traffic.

> +		if (ret) {
> +			sse_err("Failed to get status for evt %x, error %d\n", evt, ret);
> +			return ret;
> +		}
> +		status &=3D SBI_SSE_ATTR_STATUS_STATE_MASK;
> +		cpu_relax();
> +	} while (status =3D=3D SBI_SSE_STATE_RUNNING && time_before(jiffies, ti=
meout));
> +
> +	if (status =3D=3D SBI_SSE_STATE_RUNNING) {
> +		sse_err("Timed out waiting for event %x to leave RUNNING state\n", evt=
);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
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

[Severity: Medium]
Could a delayed handler from a previous timed-out test iteration execute
here and overwrite the completion flag for a newly started test iteration?
When sse_run_fast_test_cpu() times out, it abandons the pending hardware
event. If it fires later, it can cause the next loop iteration to falsely
report success.

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

[ ... ]

> +		for (j =3D 0; j < RUN_LOOP_COUNT; j++)
> +			sse_run_fast_test(&fast_test_arg, event, evt);

[Severity: Medium]
Will this loop unconditionally execute 1000 times regardless of whether
the internal test execution timed out or failed? Because sse_run_fast_test()
returns void, any errors like -ETIMEDOUT from sse_run_fast_test_cpu()
are dropped, and the test suite could hang for over 16 minutes blindly
looping if an event delivery consistently fails.

> +		pr_info("Finished testing event %s\n", sse_evt_name(evt));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911121456.3322=
3-1-zhangzhanpeng.jasper@bytedance.com?part=3D8
