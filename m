Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106FA48EBE8;
	Wed, 29 Jul 2026 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338382; cv=none; b=KyevF2nX0GujbQqgEx0GV8IP0J4tR2kVZLDT1JokAWGas/KAWBryLRyJteL65UH9rOIyPRWrwkqyJVxFDqkwf+FAzFyuo7x1F8TMJK49bhT0Q47BgQ3BnzR/8ML6NDM8zIq1h55zY1KAg/DyLCSJIzzZhetxVQ1G78AoHFxlqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338382; c=relaxed/simple;
	bh=6dZnii8Vv/Bz2zaemYIbsN1oK0jbXM19RNtxbQ8JGWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nVgH/LcHBa4TEZZB/VKqiH12xfpyWP5LbQpW4kny1Nz7YCvFyojRt5j5Ru3SRxCJXFTwtpn+5wi7O4rmiKAHSeTwtSEz+DJE6pca/H6/s9ERCTrCSi0Py0ZuoPTJIwZTK1Cx1F3AxPfgfGwBoyBW3mpFsTiKv49PgfbpMEngjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cerOdun6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cerOdun6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382AD1F00A3D;
	Wed, 29 Jul 2026 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338380;
	bh=oKXjed0uHMb2k4eQSi0EHm/6NWbwOg96OgvBCpVCVnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cerOdun6jY2rZ75f/qCHx1g1b0IcSxIColUnLk/48prdqoRHLOamWly/gnuIiy6mQ
	 deLwp6WFRVwYfsHhxRDJZ19jg1S96LdsVhvY84L2t4szeS5SMNAu8QfHl7nV9plYMm
	 CwLBQab8FXwpC6FZcQq17Kr4LqaSzXSYeSnP1HO24rbiuRy9pzk2m/jAv72p/1rdKu
	 DcjvnpGGLIwGRxubVC/SB6hehn50L/DLrpKxfxmYG32IVvIHaaLQ3V/T8UE3mJQ1w6
	 N0jWDoE1UFwxYNn8sh4wBn/80Ejp/m+RyDIgAtAsGFmE4xOG8WmJwLmM1bYFHZSFZJ
	 yL0boyflMi7zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is
 assigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260729145555.3919550-10-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:19:39 +0000
Message-Id: <20260729151940.382AD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing validati=
on in cxl_pmu_event_init() leads to a severe out-of-bounds memory access vi=
a event->cpu.
--

--- Patch [9]: [PATCH v2 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is=
 assigned ---
commit a8e317fb50ca3d5fbb66719c1a84b3a5f9c785fc
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Avoid cpumask_of(-1) when no CPU is assigned

This commit fixes an out-of-bounds pointer arithmetic issue in cpumask_show=
()
caused by cpumask_of(-1) when info->on_cpu is transiently -1 during CPU
hotplug. It reads on_cpu once and emits an empty mask if it is negative.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -501,8 +501,17 @@ static ssize_t cpumask_show(struct device *dev, stru=
ct device_attribute *attr,
>  			    char *buf)
>  {
>  	struct cxl_pmu_info *info =3D dev_get_drvdata(dev);
> +	int cpu =3D READ_ONCE(info->on_cpu);
> =20
> -	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
> +	/*
> +	 * on_cpu is -1 before the first online callback and transiently during
> +	 * cxl_pmu_offline_cpu(). cpumask_of(-1) computes an out-of-bounds
> +	 * pointer, so report an empty mask instead.
> +	 */

[Severity: High]
This problem wasn't introduced by this patch, but since we are handling the
transient -1 state of info->on_cpu here, could the same state cause an
out-of-bounds memory access in cxl_pmu_event_init()?

If perf_event_open() is called concurrently while a CPU hotplug offline
operation (cxl_pmu_offline_cpu()) is temporarily setting info->on_cpu =3D -=
1,
the event initialization seems to blindly copy this value:

drivers/perf/cxl_pmu.c:cxl_pmu_event_init() {
    ...
	event->cpu =3D info->on_cpu;
    ...
}

The core perf subsystem then appears to dereference this -1 CPU index as an
array offset:

kernel/events/core.c:find_get_context() {
    ...
		cpuctx =3D per_cpu_ptr(&perf_cpu_context, event->cpu);
		ctx =3D &cpuctx->ctx;
    ...
}

Does passing -1 here cause an out-of-bounds array read that results in a
wild pointer to cpuctx? It looks like the kernel then immediately attempts
to take a spinlock on this wild pointer, which might lead to memory
corruption. Is additional validation needed in cxl_pmu_event_init() to
prevent this?

> +	if (cpu < 0)
> +		return sysfs_emit(buf, "\n");
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cpu));
>  }
>  static DEVICE_ATTR_RO(cpumask);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729145555.3919=
550-1-dave.jiang@intel.com?part=3D9
