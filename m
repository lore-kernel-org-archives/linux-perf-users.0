Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B78400E1F
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741898; cv=none; b=AYf/o3PuP/PRjKULTO1UNmlT3Vog3RkwPch1EzrTH3mFIY6aeMDLy/FjuU0D2kQXtBjr6gD3rkWw+pCLPS7CN+zjOi74KqqT4aXqxGCP1xkm9g/HgXfv4RkFcVieyhBwvUVCV3XI5dEcsqMUYJy0T5d7hwRqn3BqmvF4e3ekKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741898; c=relaxed/simple;
	bh=1qbyKx205frSo2yB/fI+bsGOftYjALIM/EX29TW2ud0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lTBh+1CpGJsdJcpoVGkfZ7O7bKBplozE8dnTaWEQ13RbQuzWzWFVV9ypsCq7Z1BnE0tVWBdXiVVTLEiWzPM4qXt/IMgTET1BMy1YzE14dAqb9OnqjCrN361uE/FcR6j/WLvikeCPOYuBbAkYYzXqQ2xrYJOOcp+LfxmLRm2vkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyZ/D8Um; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyZ/D8Um"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7AF1F000E9;
	Wed, 22 Jul 2026 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741896;
	bh=qEXkdboNetVT7L+F9e7XRQQ2dinhiymUmqeG5krjWK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AyZ/D8Um+dz5MiUaJcwdqDWPj8g8pDBPyNasHJYIhQoiAxEld/e9TI0WieqoUhQNe
	 /TiK/WHL0w2+m4zg3g4uLfeoAOANXn2Mo5N2qvBVJtP3KltqgREeK4gmgGJLtEP7aL
	 aLyzetHC4CFVy+IqUzTfdSdCUGOo+H5cPqUnXPZNx/zIfxjsOv/AmcS6bz5iLvf1jt
	 GQRjqKjfTY8ptR/fk7BB8YjzCEu8f9buaNWFtLLY04VnM3/cgviMagmmmeC0xAXz1U
	 tGXnBRPahnyOEkv+JPpPYr21i8OIZg3CDxdTIlHjQMewr19zzWWGeYRjqEGjRYaQvX
	 9rpe2zh8J8yyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf: Generic hotplug/cpumask for system PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <b8aae1114794a348ecfb4e9cf7a792b3ac300d56.1784653319.git.robin.murphy@arm.com>
References: <cover.1784653319.git.robin.murphy@arm.com>
 <b8aae1114794a348ecfb4e9cf7a792b3ac300d56.1784653319.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:38:15 +0000
Message-Id: <20260722173816.3E7AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Taking a CPU offline triggers a NULL pointer dereference if a =
PMU defines `init_cpu` but not `exit_cpu`.
- [High] CPU online context migration passes the new CPU as both source and=
 destination to `perf_pmu_migrate_context`, causing a self-deadlock and fai=
ling to migrate events.
- [High] When a PMU is unregistered, the perf core fails to invoke the `pmu=
->exit_cpu()` callback for currently online CPUs, leaking state.
- [High] Missing bounds check in `perf_event_setup_cpumask` leads to an out=
-of-bounds per-CPU pointer access during migration.
- [High] `perf_pmu_register()` invokes the PMU's `init_cpu` callback in ato=
mic IPI context, contradicting its documented thread context.
- [Medium] Secondary CPU hotplug triggers a `WARN_ON_ONCE` because `perf_ev=
ent_setup_cpumask` incorrectly iterates up to `PERF_PMU_SCOPE_CPUMASK`.
- [Medium] PMUs using `PERF_PMU_SCOPE_CPUMASK` with static masks but no hot=
plug callbacks will never have their context migrated on CPU offline.
- [Medium] If `perf_pmu_register()` fails during the IDR allocation step, i=
t leaks the CPU-affine state initialized via `pmu->init_cpu()`.
--

--- Patch [1]: [PATCH 1/2] perf: Generic hotplug/cpumask for system PMUs ---
commit aa795c7bb07889a3ee4d3e9c388a299913298dba
Author: Robin Murphy <robin.murphy@arm.com>

perf: Generic hotplug/cpumask for system PMUs

This commit extends the generic uncore machinery to handle system PMUs
by introducing a new PERF_PMU_SCOPE_CPUMASK scope. It allows the core
code to retrieve a per-PMU cpumask dynamically and adds optional callbacks
to manage CPU-affine state during hotplug operations.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7b..505cbda2ac41f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -12920,6 +12945,16 @@ int perf_pmu_register(struct pmu *_pmu, const ch=
ar *name, int type)
>  	INIT_LIST_HEAD(&pmu->events);
>  	spin_lock_init(&pmu->events_lock);
> =20
> +	/*
> +	 * Finally, if appropriate give the PMU a chance to initialise any
> +	 * of its own CPU-affine state. Note that we're serialised against
> +	 * perf_event_{init,exit}_cpu() themselves by virtue of pmus_lock.
> +	 */
> +	if (pmu->init_cpu) {
> +		for_each_online_cpu(cpu)
> +			smp_call_function_single(cpu, perf_scope_init_cpu, pmu, 1);
> +	}
> +

[Severity: High]
Does executing init_cpu via smp_call_function_single() conflict with the
header documentation?

The documentation states init_cpu runs from CPUHP_AP_PERF_ONLINE context,
which is preemptible. However, smp_call_function_single() executes the
callback in atomic IPI context. If a driver sleeps here, will it cause a
panic?

[Severity: Medium]
If idr_cmpxchg() fails shortly after this initialization loop, does this
leak the newly allocated CPU-affine state?

There doesn't appear to be an error path to invoke exit_cpu on the online C=
PUs
to unwind this initialization.

[Severity: High]
While not explicitly in this diff, since this function sets up CPU-affine
state for a PMU during registration, is there a corresponding teardown step
missing?

It appears perf_pmu_unregister() doesn't invoke exit_cpu across the online
CPUs, which could leave this state dangling when a driver is unloaded.

>  	/*
>  	 * Now that the PMU is complete, make it visible to perf_try_init_event=
().
>  	 */

[ ... ]

> @@ -15189,10 +15225,19 @@ static void perf_event_clear_cpumask(unsigned i=
nt cpu)
> =20
>  	/* migrate */
>  	list_for_each_entry(pmu, &pmus, entry) {
> +		bool cpumask_migrate =3D false;
> +
> +		if (pmu->init_cpu && (!pmu->cpumask || cpumask_test_cpu(cpu, pmu->cpum=
ask)))
> +			cpumask_migrate =3D pmu->exit_cpu(pmu, cpu);
> +

[Severity: Critical]
Is there a risk of a NULL pointer dereference here?

This code checks if pmu->init_cpu is present, but then invokes
pmu->exit_cpu. Because both callbacks are optional, a PMU driver might
define init_cpu but leave exit_cpu as NULL.

>  		if (pmu->scope =3D=3D PERF_PMU_SCOPE_NONE ||
>  		    WARN_ON_ONCE(pmu->scope >=3D PERF_PMU_MAX_SCOPE))
>  			continue;
> =20
> +		target[PERF_PMU_SCOPE_CPUMASK] =3D -1;
> +		if (cpumask_migrate && !WARN_ON_ONCE(!pmu->cpumask))
> +			target[PERF_PMU_SCOPE_CPUMASK] =3D cpumask_any_but(pmu->cpumask, cpu);
> +

[Severity: Medium]
Does this strand PMU contexts for PMUs that use a static cpumask without
providing hotplug callbacks?

Since cpumask_migrate defaults to false and is only set if a callback
is invoked, target[PERF_PMU_SCOPE_CPUMASK] remains -1 and the migration
seems to be bypassed, leaving the context orphaned on the offline CPU.

>  		if (target[pmu->scope] >=3D 0 && target[pmu->scope] < nr_cpu_ids)
>  			perf_pmu_migrate_context(pmu, cpu, target[pmu->scope]);
>  	}

[ ... ]

> @@ -15246,7 +15292,7 @@ static void perf_event_setup_cpumask(unsigned int=
 cpu)
>  		goto end;
>  	}
> =20
> -	for (scope =3D PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; sco=
pe++) {
> +	for (scope =3D PERF_PMU_SCOPE_NONE + 1; scope <=3D PERF_PMU_SCOPE_CPUMA=
SK; scope++) {

[Severity: Medium]
Does iterating up to PERF_PMU_SCOPE_CPUMASK unconditionally trigger a
warning during secondary CPU hotplug?

For this scope, perf_scope_cpumask() explicitly returns NULL, which would
immediately trip the WARN_ON_ONCE(!pmu_cpumask || !cpumask) check later in
this loop.

>  		const struct cpumask *cpumask =3D perf_scope_cpu_topology_cpumask(scop=
e, cpu);
> =20
>  		pmu_cpumask =3D perf_scope_cpumask(scope);

[ ... ]

> @@ -15258,6 +15304,16 @@ static void perf_event_setup_cpumask(unsigned in=
t cpu)
>  		    cpumask_any_and(pmu_cpumask, cpumask) >=3D nr_cpu_ids)
>  			cpumask_set_cpu(cpu, pmu_cpumask);
>  	}
> +
> +	/* Allow migrating if the new CPU is preferable (e.g. NUMA locality) */
> +	list_for_each_entry(pmu, &pmus, entry) {
> +		bool cpumask_migrate =3D false;
> +
> +		if (pmu->init_cpu && (!pmu->cpumask || !cpumask_test_cpu(cpu, pmu->cpu=
mask)))
> +			cpumask_migrate =3D pmu->init_cpu(pmu, cpu);
> +		if (cpumask_migrate && !WARN_ON_ONCE(!pmu->cpumask))
> +			perf_pmu_migrate_context(pmu, cpu, cpumask_any(pmu->cpumask));
> +	}

[Severity: High]
Will this cause a self-deadlock in perf_pmu_migrate_context()?

The newly onlined CPU is passed as both the source CPU (cpu) and
potentially the destination CPU (via cpumask_any). This would lock the same
mutex twice in perf_pmu_migrate_context():

kernel/events/core.c:perf_pmu_migrate_context() {
    ...
    mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
    ...
}

Should this be migrating from the old CPU to the new CPU instead?

[Severity: High]
What happens if the PMU cpumask is empty here?

If init_cpu returns true but the PMU's mask is empty (for example, if it
defaulted to cpu_none_mask), cpumask_any() could return a value greater
than or equal to nr_cpu_ids. Passing this out-of-bounds value to
perf_pmu_migrate_context() might result in corrupting memory when it access=
es
the per-CPU pointers.

>  end:
>  	cpumask_set_cpu(cpu, perf_online_mask);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784653319.gi=
t.robin.murphy@arm.com?part=3D1
