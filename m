Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B3411A06;
	Wed, 29 Jul 2026 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338610; cv=none; b=JqXegrMAhlrfWw2va+n/Mhta/YYG8l5eCXwllCxmrdy6Y1CkbNc3LMH3RzeyEDaT5YJ+DIXn0I2wMyJ93Ivyq1VELPs45GFrcwu1YBakQSqG56O75yku9M/M5NjnhOKB63RPOD38pEqvKtNJT7BlZC3UbftzCE2IoMYZnrrOt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338610; c=relaxed/simple;
	bh=EJcgHzo6uigIVfDH2hG5a8I6BcmgwZxIdx/o1IFMyVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cbxYExYD9tlnCKVzsUkhkmnVPckLIBpl5UdwwCns/ppwitI0t993zQfIE3/ZskQApQd62XFZcv8wtcV7x0YFiysIF/PmqfkyPRukReTY8xdj/EXfp4nZMdD+Tm6PfnYGxCqUD/l7XcxyBqHaVuwdnWsk4LuhHNadF4B/cGuLRPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOJaUgr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOJaUgr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEFF1F000E9;
	Wed, 29 Jul 2026 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338608;
	bh=50rsSXsoP/bv1w+6RVJLA39slykJKiZr5Tv0c+CnnL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mOJaUgr1LXzsORfM5/jXv7iEKp1mqOn5BDzxAXFD8pW0HnbukEqZdNN7bad55jaPQ
	 f73c+S43paDGkiq4Oc/zGn5mMBDDCdFh3z67rzkTT8zQj2YI0z7qe6Z/mbJHG4hbrk
	 cMZkIU1Nn3/VzAuNcu/8CaP/QBwl4FU0p5JPIMXSMZbVJZcMGE/SBR1YOGBjuM8FBC
	 n1j1zyNbTx/12GwPpP8pH5TtBde7ljlVREaXzojdIpbIGSQ3Tj3IHN9YnSoqlk2ia+
	 bE6dWBkxeuBXIDVnmXnuHx05kh6TwDhw8bqrItQPDExDM9P+KCEdTwkBz+qWb+eRH7
	 jDlJMBgePLNfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned to
 the managed CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260729145555.3919550-6-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:23:27 +0000
Message-Id: <20260729152328.4EEFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying the affinity of a shared IRQ line during CPU hotplug vio=
lates local64_t locking rules.
- [High] Race condition during CPU hotplug migration violates local64_t loc=
king rules.
--

--- Patch [5]: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned =
to the managed CPU ---
commit d9c09f0087580638fe392e6b190d53e0657bbc87
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Keep the overflow interrupt pinned to the managed CPU

The PMU driver pins its overflow interrupt to the managing CPU, but requests
it with IRQF_SHARED without IRQF_NOBALANCING. This allows irqbalance to
move the interrupt, leading to concurrent cross-CPU access of local64_t
event counts. This commit adds IRQF_NOBALANCING to ensure the CPU hotplug
pinning holds.

Link: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.=
net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index d1e810601e363..8b89db8f4d689 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -888,7 +888,8 @@ static int cxl_pmu_probe(struct device *dev)
>  	if (!irq_name)
>  		return -ENOMEM;
> =20
> -	rc =3D devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_TH=
READ,
> +	rc =3D devm_request_irq(dev, irq, cxl_pmu_irq,
> +			      IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,
>  			      irq_name, info);

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a
pre-existing race condition in the CPU hotplug migration window that violat=
es
local64_t locking rules.

In cxl_pmu_offline_cpu(), perf_pmu_migrate_context() moves the PMU events
to the target CPU and restarts them:

drivers/perf/cxl_pmu.c:cxl_pmu_offline_cpu() {
	...
	perf_pmu_migrate_context(&info->pmu, cpu, target);
	info->on_cpu =3D target;
	/*
	 * CPU HP lock is held so we should be guaranteed that this CPU hasn't yet
	 * gone away.
	 */
	WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
	return 0;
}

Since perf_pmu_migrate_context() re-enables hardware interrupts, and
irq_set_affinity() is called after this migration, an interrupt firing
during this window will still be delivered to the old offlining CPU.

Concurrently, user-space reads of the migrated event will execute on the
new target CPU.

Could this lead to cross-CPU concurrent accesses to the local64_t event
counts, corrupting the data?

[Severity: High]
This is a pre-existing issue, but modifying the affinity of a shared IRQ
line during CPU hotplug appears to also violate local64_t locking rules.

Looking at the same cxl_pmu_offline_cpu() snippet above, the driver
registers its interrupt with IRQF_SHARED. Because affinity is a per-IRQ
property, calling irq_set_affinity() moves the interrupt for all PMU
instances sharing this IRQ line.

If another PMU instance is still managed by the old CPU (e.g. its offline
callback hasn't run yet), its interrupts will now fire on the new target CPU
while user-space reads concurrently execute on the old CPU.

Is there a risk that this cross-CPU access corrupts the local64_t counts?

>  	if (rc)
>  		return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729145555.3919=
550-1-dave.jiang@intel.com?part=3D5
