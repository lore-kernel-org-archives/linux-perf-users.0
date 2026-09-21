Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A0489FBD
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990346; cv=none; b=mzfpOM0ni8VRM/GLc4KdU/2kLbulXK6QEVEQ/pF6eDD5jeDgYS3MXYZSe7TH38fu5BQv77SGYRCCwF48vrox/qGrxcqm1fGhnoVaDN7QQjkcgemec7RDWfHfmSATz8Hf2aRIxMADVGuPpAbU3ST36dqrMWjvVPVywKNys58j3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990346; c=relaxed/simple;
	bh=GGFDCPwBgG+un/t/e6kK4eFmkCTP5LsU21UDLxVKp+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r+suOq45tVJsI1WBG6wq5rKe7PeDQUNy7w4I4cTcng84O1jVBwiveL3V2RV64UcSF7kua5XqoVf7WQRTmbwKj3wFuaPp80q9WimDjnvAPIQEL2eADmEW9/GOfxrnz8glr+sEEPb1/Gtp+QuQplPzXXylhYMbfgD+B/W7Z9MHEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ6sv5ci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ6sv5ci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2721B1F00893;
	Mon, 21 Sep 2026 11:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789990344;
	bh=2DSmgtOCUT1T3BXWjbu1vX7OrVcB7A+iBRh4NQ0g2kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZ6sv5ciuYxuDLn/XJAV8b1JuyhaOTEcYkt72tGKO8l6Djcq2uUxPGMpkMSmt7lC1
	 +bPhZmO866755+Z1YJQbjIAzTI0W0t/vN5qnF4ypBHoXGPNxa9eNb44+RGPk7biSVB
	 RF3/mniJzLc9T381ldIdpwxefeaK6G6ybndCEq9HWtoCe8om1un+XwkzKUSfQtdHHU
	 hWH+V83tNa/YBfqSEIh20juxeHWQlPJ2bOVteS+JVbtjTkGfGZ/gm4sdn8NHcT6Htl
	 lz9XmTOz3k3X11CBR1qqSpbdkFSFiEb4hFYsdp6GJP1YR2aCmTw+2c9TVQDnzuwR2H
	 JW8hDDp2BWQfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 RESEND 8/9] selftests/riscv: add SSE test module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhanpeng Zhang" <zhangzhanpeng.jasper@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b4d75027d7e52a81553ec3f6207b4ca14f009299.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
References: <cover.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
 <b4d75027d7e52a81553ec3f6207b4ca14f009299.1789974241.git.zhangzhanpeng.jasper@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:32:23 +0000
Message-Id: <20260921113224.2721B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] riscv/sse: truncating physical address in sse_event_attr_read() ca=
uses memory corruption on RV32
- [High] riscv/sse: unhandled timeout in sse_run_fast_test() leaves asynchr=
onous firmware event pending
- [High] riscv/sse: cleanup work loop deadlocks because sse_event_disable()=
 on disabled event fails
- [Medium] riscv/sse: HZ/100 timeout calculation causes guaranteed immediat=
e timeout when HZ < 100
--

commit a979d907b51d143e2d5c8ad22d308f8c21385e6f
Author: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

    selftests/riscv: add SSE test module
   =20
    Add an SSE selftest module and runner. Loading the module executes
    smoke tests for the SSE framework, and the runner reports any error
    emitted by the module.

> diff --git a/tools/testing/selftests/riscv/sse/module/riscv_sse_test.c b/=
tools/testing/selftests/riscv/sse/module/riscv_sse_test.c
> new file mode 100644
> index 0000000000000..cc5c2e46f2fdb
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

[Severity: High]
Does this code introduce an infinite loop during cleanup? If sse_event_disa=
ble()
is called on an already-disabled event, it may return an error like
SBI_ERR_INVALID_STATE. If ret is set, this check will skip
sse_event_unregister(), set retry =3D true, and permanently reschedule the =
work,
deadlocking the cleanup work queue.

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

[Severity: High]
Can this corrupt memory on RV32 systems? The function casts phys_addr_t phys
to unsigned long, which truncates it to 32 bits on RV32. Since 0 is passed =
for
arg4 (phys_hi), the SBI firmware will write attributes to the truncated phy=
sical
address, potentially corrupting arbitrary memory below 4GB instead of
modifying the intended buffer.

> +	if (sret.error)
> +		return sbi_err_map_linux_errno(sret.error);
> +
> +	return 0;
> +}
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

[Severity: Medium]
Will this evaluate to 0 if HZ < 100? If the kernel is configured with a low
HZ, HZ / 100 is 0. This causes the subsequent time_before() check to
immediately fail before the event can be handled, resulting in false test
failures.

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
> +		pr_info("Starting testing event %s\n", sse_evt_name(evt));
> +
> +		for (j =3D 0; j < RUN_LOOP_COUNT; j++)
> +			sse_run_fast_test(&fast_test_arg, event, evt);

[Severity: High]
Does this code ignore unhandled timeouts? If sse_run_fast_test_cpu() times =
out
and returns -ETIMEDOUT, the error is swallowed because sse_run_fast_test()
returns void. This loop immediately fires the next iteration, overwriting
fast_test_arg while an asynchronous firmware event may still be pending from
the previous loop, potentially causing a data race on the global test state.

> +		pr_info("Finished testing event %s\n", sse_evt_name(evt));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789974241.gi=
t.zhangzhanpeng.jasper@bytedance.com?part=3D8
