Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25162EEE86
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788833773; cv=none; b=gZcf3mQ837CFiHotGIMz0SbSvlwqgTi3eT/fQMPhzsmfQWoGqlIDCl/b6Vj+p2Ctaz0nWxvDahiEjSmP/NUhsnNYga+wbFmAG2hncjFIaSgAFHXIilGDdgvLXX5rK9roMlZjD2bUqAUEN+HfCDnvbWN7IUhqfsu321teVftio1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788833773; c=relaxed/simple;
	bh=wzua8yVaKFzsWoPiQtODaCMZjOsaEpM38jIpijcaO4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=daayTp9a6wyAJ6WB4RqMnrLXBi/oReofUP2BFe+IbJDB0MFANW0GZwF/oJ8WvdwWiVLsunf8H4vugLYPePy4lSlmiyuXfE3vUz78Pugigb8BaeZVhQhwcQhSfKaSKZ5h+7JUpkcEruG8S8xl5o/NL5auAWAqqUO6rElAkaksAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXg71mDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXg71mDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B931F00A3A;
	Tue,  8 Sep 2026 02:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788833771;
	bh=6qwhjKPQ/+uVOl1cTEdDAmT3sY9nTvWjMPhgfpjDvfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IXg71mDYjljjP6Xr/o6ztwUxpZQh2UW73zWbgdrpSNkEu0/jn1ATiwBzOxJ92BU69
	 kzzv9/C1h9IVEBeu+NNiOk+nUXZ2guUgtWk+n8mvX9YAUISA0fzxYj3p7JS8sNClRC
	 PUsDUPb/9WXrKUrPrqhYUcmtMTw8A16rrUrkGlacRiSYfhbBOrIp4EjW2PV5jspXmJ
	 y7ioubnejEorNReJGAvCnzCZttsaB57JNoRMiIxObtimh6uT3iTvTIMlrUjPfbLsoS
	 wnT0pYdTybOpXfsxye287l5ZASau4A3EfH8YxI4cdI9qS/r/DSLJlsvzn9GrsjMVUO
	 WbE430+U85VaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908020347.1836653-2-zong.li@sifive.com>
References: <20260908020347.1836653-1-zong.li@sifive.com>
 <20260908020347.1836653-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 02:16:10 +0000
Message-Id: <20260908021611.71B931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] CPU hotplug race causes concurrent lockless access to PMU state an=
d registers.
- [High] Deferring to irq_work without clearing IPSR.PMIP causes an interru=
pt storm on systems using level-triggered wired interrupts.
--

commit 9de4660461d623132294a2de1ef096c0d7941787
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: add risc-v iommu pmu driver

Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
device driver created by the parent RISC-V IOMMU driver to handle hardware
performance monitoring counters.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..3a1cf366a79fd
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c

[ ... ]

> +static int riscv_iommu_pmu_offline_cpu(unsigned int cpu, struct hlist_no=
de *node)
> +{
> +	struct riscv_iommu_pmu *iommu_pmu;
> +	unsigned int target_cpu;
> +
> +	iommu_pmu =3D hlist_entry_safe(node, struct riscv_iommu_pmu, node);
> +
> +	if (READ_ONCE(iommu_pmu->on_cpu) !=3D (int)cpu)
> +		return 0;

[ ... ]

> +	target_cpu =3D riscv_iommu_pmu_bind_cpu(iommu_pmu, cpu);
> +	if (WARN_ON_ONCE(target_cpu >=3D nr_cpu_ids)) {
> +		WRITE_ONCE(iommu_pmu->on_cpu, -1);
> +	} else {
> +		WRITE_ONCE(iommu_pmu->on_cpu, target_cpu);
> +		perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target_cpu);
> +	}

[Severity: High]
Could this lead to a CPU hotplug race condition? By updating the IRQ affini=
ty
and on_cpu pointer before calling perf_pmu_migrate_context(), the IRQ handl=
er
might run on the new CPU while the old CPU is still actively modifying the =
PMU
state during the migration.

If a PMU overflow interrupt arrives during this window, the interrupt trigg=
ers
on target_cpu, causing riscv_iommu_pmu_process_overflow() to execute
concurrently with the perf core invoking pmu->del (via
perf_pmu_migrate_context) on the outgoing CPU. Could this concurrent lockle=
ss
access to pmu->events and shared hardware registers cause data corruption or
invalid PMU configurations?

> +
> +	return 0;
> +}

[ ... ]

> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
> +	struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_id;
> +	int target_cpu;
> +
> +	/* Check whether this interrupt is for PMU */
> +	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR=
_PMIP))
> +		return IRQ_NONE;

[ ... ]

> +	target_cpu =3D READ_ONCE(pmu->on_cpu);
> +	if (target_cpu !=3D smp_processor_id() && target_cpu >=3D 0 &&
> +	    cpu_online(target_cpu)) {
> +		irq_work_queue_on(&pmu->work, target_cpu);
> +		return IRQ_HANDLED;
> +	}

[Severity: High]
Will returning IRQ_HANDLED here without clearing the device-level interrupt
status bit (IPSR.PMIP) cause an interrupt storm on systems using
level-triggered wired interrupts?

When the hardirq handler queues an irq_work and returns without clearing the
hardware interrupt bit, the interrupt line remains asserted. Once the CPU
unmasks the line upon return, it seems it would immediately re-enter the
interrupt handler, potentially resulting in an infinite interrupt storm that
could hard lock the CPU.

> +
> +	/*
> +	 * Either this is the bound CPU, or there is no usable one to defer to.
> +	 * In the latter case handle it here anyway: nobody else is going to
> +	 * clear ipsr.pmip, and without that the pmu would stop reporting for
> +	 * good.
> +	 */
> +	riscv_iommu_pmu_process_overflow(pmu);
> +
> +	return IRQ_HANDLED;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908020347.1836=
653-1-zong.li@sifive.com?part=3D1
