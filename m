Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9A4756B8;
	Tue, 28 Jul 2026 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274201; cv=none; b=NXMj3aAP2uIGZZgArW2NxuLKT+sjaUc3PhNbaSDKQaJ+KOzgjxKpwQFvj3StDgRWeOeQRsQbwW5Pu3BUFh2KZLQbdlLWKedgnjVqeeTpQUuTqRU8dzVXZHNUkGTJlOGjR+n18yWlaN+/nN5nxw09VIvRNQn6vqCoG8Znkhj27kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274201; c=relaxed/simple;
	bh=v46Cd1mzXQz/Wtc9VwZohS2q8ORbv7e3Q1e5kIT5iYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCJmpM0DYZXl9s8cxe2Z7kCo9qDHDEjZrqtEHSHVfgrSIsMRstd6uWRW8FakOZaCIhfOyyXZ/yUaA8x13MDxg+3+Y+PPluspflFDS0tr957z/6pRixTL1LVO9xdpzsR0hkokOLmvK4X4Q2RuZtGwo3UKA3IAvw8V/QnBEV+9UA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csOD4qr3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csOD4qr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754791F000E9;
	Tue, 28 Jul 2026 21:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274197;
	bh=IFHMVDeaPzm3lnHx4Ji60KFjy5yglUJZI0xjMqJW9UU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csOD4qr3GcVVGEuXGz/iNRIOKBdApLwdGfeyON57k9O0mBM21GBR2pwcpZo/zFcdV
	 FBnWDIXxxZ67skp1vtnoyP+fRDybL/V6HVOZ+4wSUnktKjOwpCIbR5cLPIgRNczp3o
	 BzqtXONNeY5MCvhOMCQcBocY7kgs2khrOiZ+bc4qs8Juf7RwNGMT0RLUyyq6HUJYmz
	 Hk4yjLOuDkc5FdHnH5lvgeFrTyFFG9MMgoHdHNbNBycS6mJIoucetPultCu+pmscVt
	 G9LHOtIiE7XXDS97uvJzRrz3lTkumFsFo877rSp71er2qib0HpIPNwwFtUh+aJXc1E
	 QQLQYbUBpQ+BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] perf/cxl: Keep the overflow interrupt pinned to the
 managed CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260728210551.2449093-6-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
 <20260728210551.2449093-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 21:29:56 +0000
Message-Id: <20260728212957.754791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race window during CPU offline allows interrupts to fire on the ol=
d CPU after events have migrated, causing cross-CPU concurrency on local64_=
t.
- [High] Using IRQF_SHARED with independent per-device CPU hotplug states a=
llows PMU instances sharing an IRQ to drift onto different CPUs, breaking t=
he local64_t same-CPU guarantee.
--

--- Patch [5]: [PATCH 5/9] perf/cxl: Keep the overflow interrupt pinned to =
the managed CPU ---
commit e894c4110202a2f84025491b6b4843a427420643
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Keep the overflow interrupt pinned to the managed CPU

The PMU pins its overflow interrupt to info->on_cpu in the hotplug
online/offline callbacks, but requests it with only IRQF_SHARED |
IRQF_NO_THREAD. Without IRQF_NOBALANCING, irqbalance or a userspace
smp_affinity write can move the interrupt to another CPU.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 7db858727ac61..0c53f9e5ccb1d 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -876,7 +876,8 @@ static int cxl_pmu_probe(struct device *dev)
>  	if (!irq_name)
>  		return -ENOMEM;
> =20
> -	rc =3D devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_TH=
READ,
> +	rc =3D devm_request_irq(dev, irq, cxl_pmu_irq,
> +			      IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,
>  			      irq_name, info);

[Severity: High]
This is a pre-existing issue, but does using IRQF_SHARED with independent
per-device CPU hotplug states allow PMU instances sharing an IRQ to drift o=
nto
different CPUs?

If multiple PMU instances on a CXL device share the same MSI vector and req=
uest
it with IRQF_SHARED, each PMU registers its own independent CPU hotplug
instance.

If an administrator unbinds and rebinds one PMU instance, its
cxl_pmu_online_cpu() callback executes and sets the shared IRQ's affinity to
its newly chosen CPU.

The other PMU instances sharing the IRQ remain affine to their existing on_=
cpu,
but will now receive interrupts on the new CPU. When the IRQ fires, the ker=
nel
executes cxl_pmu_irq() for all sharing PMUs on the new CPU. This causes
cxl_pmu_read() to execute on the wrong CPU concurrently with userspace read=
s on
the correct CPU, corrupting the local64_t counters.

While this patch adds IRQF_NOBALANCING to stop external irqbalance, does it
leave the driver vulnerable to its own internal hotplug divergence?

[Severity: High]
This isn't a bug introduced by this patch, but is there a race window during
CPU offline that allows interrupts to fire on the old CPU after events have
migrated?

Looking at cxl_pmu_offline_cpu():

	perf_pmu_migrate_context(&info->pmu, cpu, target);
	info->on_cpu =3D target;
	/*
	 * CPU HP lock is held so we should be guaranteed that this CPU hasn't yet
	 * gone away.
	 */
	WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));

Does perf_pmu_migrate_context() schedule the events out from the old CPU and
into the new CPU before the driver updates the IRQ affinity?

If an interrupt fires during this window, it would be routed to the old CPU.
cxl_pmu_irq() would execute on the old CPU and call cxl_pmu_read().
Concurrently, an unprivileged user reading the counter forces cxl_pmu_read(=
) to
execute on the new CPU via IPI, corrupting the local64_t counters.

>  	if (rc)
>  		return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728210551.2449=
093-1-dave.jiang@intel.com?part=3D5
