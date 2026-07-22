Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF43345EBD
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743177; cv=none; b=FakhnGH245NKlsKRVg90++Gc4rxyGpM5+HQnFbUtm3QkMqL7YhvxYuQdvNbEoiQrP261yvaUDE9eLjDTKlLQzvP7I4wYMGwGqTjkZKEEPhsGUGbraag12YyHTysa0K7xWCjQFJfdBB+6aI/SYyCMF48yovd8I7L+TQm61KXrPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743177; c=relaxed/simple;
	bh=sJf4o2iNDjHagjCjrMpMns1eXZCnrVqDUoYkKQI64Ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BIv8/b8cmUvyYyGFMai6THbBYYu0vGT/d5jOO/HW4ZVXTZ3LDaQSMBUN8lnO+44CfTa85qRllvmJDECm/ytSwzqPsA4oBJ91jPzJQEH00oIkUB4rFVao9dtrqfcZfyh5vnsit5TrN0FTTrgZ0jGLcvV766WNRvkhVyAS3H7dea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUZ1NsTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUZ1NsTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AA61F000E9;
	Wed, 22 Jul 2026 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743174;
	bh=zE4XuEpThAbBuxW/iBJU5l742XuBkO3zalSWUsfgAp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUZ1NsTo3q0iVIP8tFQWXwfBhhZHeK2UsH3GtP7TCXsXPMVHW80kJgbjFyLNIcAq6
	 +AIx1VnZ3lpi55CZiCpK0FwhxtEPJflI/oof81aX8il74VQ1lDxQVsxHiVpjnWS7Wp
	 TAGpiCxOZu7/LSCEzBm5xup5/rcy/fNlKKFU9QX9bthcjm7QeNhboBJVJeTwS3VcXQ
	 fppE0GlxGnzwHDKZcmNSEJ4ceWICElVLmbwOYneDJuIC03W3JcQldik+OaPBZBOYPZ
	 zSj+V7qkR3GlIUOIETswtpltxJddYrfouXM/Y4B5A6N0TyXcvaqGf64wkriTukQFGL
	 o6Au6ZGiduT8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf/arm-cmn: Switch to generic cpumask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <fff3eca9886d2626a8be95a22629d8650fd45177.1784653319.git.robin.murphy@arm.com>
References: <cover.1784653319.git.robin.murphy@arm.com>
 <fff3eca9886d2626a8be95a22629d8650fd45177.1784653319.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:59:33 +0000
Message-Id: <20260722175934.35AA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Generic PMU CPU hotplug online migration is broken, causing a =
self-deadlock and failing to migrate events.
--

--- Patch [2]: [PATCH 2/2] perf/arm-cmn: Switch to generic cpumask ---
commit e67db05bf209b086de25b5674a2cd9a5ee2ab5f4
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm-cmn: Switch to generic cpumask

With perf core now providing appropriately-sequenced hotplug callbacks
via the new PMU scope, all the state management boilerplate can go,
while the cpumask also takes care of enforcing event affinity.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 6e5cc4086a9e2..10243ac6217d4 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c

[ ... ]

> @@ -2008,48 +1987,38 @@ static int arm_cmn_commit_txn(struct pmu *pmu)
>  	return 0;
>  }
> =20
> -static void arm_cmn_migrate(struct arm_cmn *cmn, unsigned int cpu)
> +static bool arm_cmn_migrate(struct arm_cmn *cmn, unsigned int cpu)
>  {
> -	unsigned int i;
> -
> -	perf_pmu_migrate_context(&cmn->pmu, cmn->cpu, cpu);
> -	for (i =3D 0; i < cmn->num_dtcs; i++)
> -		irq_set_affinity(cmn->dtc[i].irq, cpumask_of(cpu));
> -	cmn->cpu =3D cpu;
> +	cmn->pmu.cpumask =3D cpumask_of(cpu);
> +	for (int i =3D 0; i < cmn->num_dtcs; i++)
> +		irq_set_affinity(cmn->dtc[i].irq, cmn->pmu.cpumask);
> +	return true;
>  }
> =20
> -static int arm_cmn_pmu_online_cpu(unsigned int cpu, struct hlist_node *c=
puhp_node)
> +static bool arm_cmn_init_cpu(struct pmu *pmu, int cpu)
>  {
> -	struct arm_cmn *cmn;
> -	int node;
> +	struct arm_cmn *cmn =3D to_cmn(pmu);
> +	int node =3D dev_to_node(cmn->dev);
> =20
> -	cmn =3D hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
> -	node =3D dev_to_node(cmn->dev);
> -	if (cpu_to_node(cmn->cpu) !=3D node && cpu_to_node(cpu) =3D=3D node)
> -		arm_cmn_migrate(cmn, cpu);
> -	return 0;
> +	if (!cpumask_intersects(pmu->cpumask, cpumask_of_node(node)) &&
> +	    (cpu_to_node(cpu) =3D=3D node || cpumask_empty(pmu->cpumask)))
> +		return arm_cmn_migrate(cmn, cpu);

[Severity: Critical]
Does this cause a self-deadlock during CPU hotplug online operations?

When arm_cmn_init_cpu() calls arm_cmn_migrate(), it updates cmn->pmu.cpumask
to the new CPU and returns true.

The core framework in kernel/events/core.c:perf_event_setup_cpumask() sees
the true return value and triggers a migration:

    cpumask_migrate =3D pmu->init_cpu(pmu, cpu);
    if (cpumask_migrate && !WARN_ON_ONCE(!pmu->cpumask))
        perf_pmu_migrate_context(pmu, cpu, cpumask_any(pmu->cpumask));

Because pmu->cpumask was just updated by the driver, cpumask_any() evaluates
to the new CPU, meaning the source and destination CPUs passed to
perf_pmu_migrate_context() are exactly the same.

When perf_pmu_migrate_context() resolves src_ctx and dst_ctx, they will poi=
nt
to the same per-CPU context. It then attempts to double lock the same
non-recursive mutex:

    mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);

Is it possible to migrate events from the previous CPU if the driver
already overwrote pmu->cpumask before returning to the core framework?

> +	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784653319.gi=
t.robin.murphy@arm.com?part=3D2
