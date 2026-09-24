Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B3424646
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244773; cv=none; b=BQb26h+mhzD0SjMl/pBNWXT5nvtZeVe/N+qMupqL3JJppgA/HyK8WmiEnX3vkM0srNeVkPHFDF6ZADtTMk9mLjQgFOqxefz3iBC9WvknUBEyea0hy2cSTB1t/URMusguu+efzoklp0l845Z66bDJC2cCCMnZTo8ejNcEZZcCLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244773; c=relaxed/simple;
	bh=ASa3ieveJcmm0B2FG31R/HKp7yddQav6S8JH3pJmOMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NQ3Kuppu12bxLK3rMFMBEmz0iPIda7IdDvzscUq9CEQSfgM2tplkJ0hwTbJORDQGJQ2D2SE0gU4InrBM3Kgb/nKpoduRvFom6GLI20e4PwA0v4yFiOMIlt7wz2uoeMDm/TkDAXKZNuodZH0oE8snuDg8GjMxEpL3QZFvw+Qknb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR0U87sN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR0U87sN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14EC1F00893;
	Thu, 24 Sep 2026 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790244759;
	bh=xPmMNmt4R5kSOXmSfE9PYph8Y2qLZIZktnOfydxnsTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cR0U87sNjaWk3YrKta6StCrTBGk09ImBidrNpFU06Mg0oUi6CGGAu++gsK1EvWMXs
	 SQt3PQe/7Fu99a9fmFBS55IjdjeqXyeQrlt+nLkNzH5intMcwKuLKsPn/p/b84zdSj
	 IOS/qKPTu9IP9/3TBOHByoB8V7AMPSVl6TY9hKklpl3V67pGxS0Zbs2B6AYUj5deNW
	 OKYPGjVdQ3qmSak+JaLBy87VLUsZt/+jJxa7hnyF25qLmSUmgIMyU91oeSb+FigVjj
	 h0hROr7Cl2RlHVmrkvWqiYSLbSHMAwAAmcTN96C7ak9y5d2vgpbr76wOsPaOQc9Eww
	 lL0vwrC2u5RbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924100106.2054127-2-zong.li@sifive.com>
References: <20260924100106.2054127-1-zong.li@sifive.com>
 <20260924100106.2054127-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 10:12:39 +0000
Message-Id: <20260924101239.B14EC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf: riscv-iommu: use-after-free on CPU hotplug due to missing cl=
eanup in probe error path
- [High] perf: riscv-iommu: NULL pointer dereference in CPU offline race be=
fore PMU registration
- [Medium] perf: riscv-iommu: stale read on cross-CPU lock contention in ri=
scv_iommu_pmu_read()
--

commit ade01fdbbb7c20954560c04dafd143c2c60bee2e
Author: Zong Li <zong.li@sifive.com>
Subject: drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This commit adds a new driver to support the RISC-V IOMMU PMU, which is an
auxiliary device driver created by the parent RISC-V IOMMU driver. It inclu=
des
performance monitoring counters for specific device IDs/process IDs, hardwa=
re
detection of counters, and handles CPU hotplug operations.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..56f25f725f1c4
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
> @@ -0,0 +1,1012 @@
[ ... ]
> +static void riscv_iommu_pmu_read(struct perf_event *event)
> +{
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	unsigned long irqflags;
> +
> +	/*
> +	 * Use trylock, not lock: an NMI (e.g. a BPF program calling
> +	 * bpf_perf_event_read()) can land on this same CPU while it already
> +	 * holds pmu->lock in the irq handler, so blocking here could
> +	 * self-deadlock. Skipping the update on contention is safe -- the
> +	 * next successful read() or IRQ overflow will catch up.
> +	 */
> +	if (!raw_spin_trylock_irqsave(&pmu->lock, irqflags))
> +		return;

[Severity: Medium]
Will this trylock cause stale reads on cross-CPU lock contention?

If riscv_iommu_pmu_read() is called from a different CPU while the IRQ hand=
ler=20
(running on the CPU to which the PMU is bound) holds the global pmu->lock, =
the=20
trylock will fail. The function will then immediately return without callin=
g=20
riscv_iommu_pmu_update(), causing it to silently provide an un-updated, sta=
le=20
event->count to the caller.

Could we remove the lock here, since riscv_iommu_pmu_update() is inherently=
=20
lockless and safely resolves concurrency using local64_cmpxchg() along with=
 a=20
retry loop?

> +	riscv_iommu_pmu_update(event);
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> +}
[ ... ]
> +static int riscv_iommu_pmu_offline_cpu(unsigned int cpu, struct hlist_no=
de *node)
> +{
> +	struct riscv_iommu_pmu *iommu_pmu;
> +	unsigned int target_cpu;
[ ... ]
> +	target_cpu =3D riscv_iommu_pmu_bind_cpu(iommu_pmu, cpu);
> +	if (WARN_ON_ONCE(target_cpu >=3D nr_cpu_ids)) {
> +		WRITE_ONCE(iommu_pmu->on_cpu, -1);
> +	} else {
> +		WRITE_ONCE(iommu_pmu->on_cpu, target_cpu);
> +		/*
> +		 * perf_pmu_migrate_context() runs ->del() on cpu and ->add()
> +		 * on target_cpu with a synchronize_rcu() gap in between.
> +		 * riscv_iommu_pmu_irq_handler() can run concurrently with
> +		 * either step, on whichever CPU the interrupt physically
> +		 * lands on - pmu->lock serialises it against them instead of
> +		 * racing.
> +		 */
> +		perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target_cpu);

[Severity: High]
Can this migration call trigger a NULL pointer dereference?

In riscv_iommu_pmu_probe(), cpuhp_state_add_instance() is called before=20
perf_pmu_register(). If a CPU goes offline in the narrow window between the=
se=20
two calls, this migration function will dereference pmu->cpu_pmu_context be=
fore=20
it has been initialized, causing an immediate kernel oops.

> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> +				 const struct auxiliary_device_id *id)
> +{
[ ... ]
> +	ret =3D cpuhp_state_add_instance(cpuhp_state, &iommu_pmu->node);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\n", name, ret=
);
> +		return ret;
> +	}
> +
> +	ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to register %s: %d\n", name, ret);
> +		cpuhp_state_remove_instance_nocalls(cpuhp_state, &iommu_pmu->node);
> +		return ret;
> +	}

[Severity: High]
Is it possible to reorder cpuhp_state_add_instance() after=20
perf_pmu_register() to close the race window mentioned above where hotplug=
=20
events operate on an uninitialized PMU structure?

> +
> +	ret =3D devm_add_action_or_reset(&auxdev->dev,
> +				       riscv_iommu_pmu_do_unregister,
> +				       iommu_pmu);
> +	if (ret)
> +		return ret;

[Severity: High]
Does this error path leak the hotplug node?

If devm_add_action_or_reset() fails here (e.g. due to devres memory allocat=
ion=20
failure), it executes riscv_iommu_pmu_do_unregister() and immediately retur=
ns.=20
This skips the registration of the riscv_iommu_pmu_remove_cpuhp_instance=20
cleanup action. The driver core unwinds the device and frees the iommu_pmu=
=20
struct, but leaves a dangling iommu_pmu->node pointer in the global cpuhp_s=
tate=20
list, leading to a use-after-free panic during the next CPU hotplug event.

> +
> +	/*
> +	 * Registered after do_unregister so it runs first (LIFO) on unbind:
> +	 * the cpuhp instance must be gone before perf_pmu_unregister() runs.
> +	 */
> +	ret =3D devm_add_action_or_reset(&auxdev->dev,
> +				       riscv_iommu_pmu_remove_cpuhp_instance,
> +				       iommu_pmu);
> +	if (ret)
> +		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924100106.2054=
127-1-zong.li@sifive.com?part=3D1
