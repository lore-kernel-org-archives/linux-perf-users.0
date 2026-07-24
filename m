Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C734F474
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916115; cv=none; b=NAgEIPzg4xHuMuLfF8jKxClbG6skgc1yYwQo0Kakx20jv50DtP+NDODwKoIXIhjKJnzjudK9oJt4/KLZaW3rZRC0kdvAfD10xM+pvq6XVATKtrn5NZ4qtmgxR9TG8jlGM762TMzeUp7AR9AlLd2vTBE2kwgcugQ43xifn0GzOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916115; c=relaxed/simple;
	bh=JihJeWDJjRZG0Bv+al8XQbcOu0xRg6yEzPWyvpv3DeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KssOJwPEUXUXaZ3DLcdjHFHaaPv65CmJ62mcn9W30FzWHCJRnTsKrFnAcnnllgKDBfhLVvSDntosY5lAzmmD47Ap82Pgngt2IOt6EcQF8dq9M/QaWfdcX7lsO7Paz4rfogXvklPDAsJjQd5WMQNFpINrD3yJ9jniri22lVCGyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzZcY8nu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzZcY8nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2731F000E9;
	Fri, 24 Jul 2026 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784916114;
	bh=j/eWu5UvKrPwbuJZZ+Pa2lRB3AVBZLcZ+NSnrUUm3u4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OzZcY8nu1DFsxZcqo6xvGW3AeBacmCDHrSVrURwBkBENzhuKwbVwtSwnbLak2zvTV
	 dIm2rJipfDLio5XxuIo57TTAzqVLKuHOvctaC3QkCnCQ9mFkHS3OiBuldKVHSkTfJB
	 0FnkiP8bzulDIte1euqH9q6+sPH4rR/DG3GeRm/q4kopAtTTl00uRtmoZ5+AeyEmCi
	 ZxYg7iziuT9+7xPG/pEEhN/FoHnACmzjaNzPQJggTPvTkIAwXdkx/JA/XLePQYIm13
	 FW8FMjq6VfoI5UNTmjbe+w4ImQVxgApwTeobyIN6dJhiaFwweyTyLsaJixKaBbzK5t
	 /LKzrj+bjUTVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf: Generic hotplug/cpumask for system PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d85ac6d5f5f6383be5b882b6694052eac8062ced.1784911757.git.robin.murphy@arm.com>
References: <cover.1784911757.git.robin.murphy@arm.com>
 <d85ac6d5f5f6383be5b882b6694052eac8062ced.1784911757.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:01:53 +0000
Message-Id: <20260724180154.3D2731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing teardown of per-CPU state on PMU unregister and error =
paths.
- [High] The `init_cpu` callback is executed in inconsistent contexts: hard=
irq context during PMU registration, but preemptible thread context during =
CPU hotplug.
- [High] `perf_pmu_register` iterates over `cpu_online_mask` instead of `pe=
rf_online_mask` under `pmus_lock`, causing races with CPU hotplug.
--

--- Patch [1]: [PATCH v2 1/2] perf: Generic hotplug/cpumask for system PMUs=
 ---
commit b04553873017de2f8ea25f74f3ddf8a646a7b19d
Author: Robin Murphy <robin.murphy@arm.com>

perf: Generic hotplug/cpumask for system PMUs

This commit introduces a generic uncore machinery extension for system PMUs.
It adds PERF_PMU_SCOPE_CPUMASK to allow PMUs to dynamically determine their
cpumask. It also introduces init_cpu and exit_cpu callbacks to manage priva=
te
CPU-affine state during CPU hotplug and PMU registration.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7b..3d8ccdfdd5707 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -12920,6 +12945,17 @@ int perf_pmu_register(struct pmu *_pmu, const ch=
ar *name, int type)
>  	INIT_LIST_HEAD(&pmu->events);
>  	spin_lock_init(&pmu->events_lock);
> =20
> +	/*
> +	 * Finally, if appropriate give the PMU a chance to pick an initial CPU
> +	 * affinity for its cpumask, or initialise any general per-CPU state.
> +	 * Note that we're serialised against perf_event_{init,exit}_cpu()
> +	 * themselves here by virtue of pmus_lock.
> +	 */
> +	if (pmu->init_cpu) {
> +		for_each_online_cpu(cpu)

[Severity: High]
Does this iteration over cpu_online_mask race with CPU hotplug?

Since pmus_lock serializes against perf_event_exit_cpu() and
perf_event_init_cpu(), which update perf_online_mask, iterating over
cpu_online_mask here can lead to desynchronization.

If a CPU is going offline, it may have been removed from perf_online_mask b=
ut
is still in cpu_online_mask, resulting in an init_cpu call without a
corresponding exit_cpu call. Similarly, a CPU coming online might be
initialized here and then double-initialized in perf_event_setup_cpumask().

Should this use perf_online_mask instead?

> +			smp_call_function_single(cpu, perf_scope_init_cpu, pmu, 1);

[Severity: High]
Will calling the init_cpu callback via smp_call_function_single() here crash
PMU drivers migrating to this API?

This executes the callback in an IPI (hardirq) context with interrupts
disabled. However, during CPU hotplug, perf_event_setup_cpumask() calls
init_cpu directly in preemptible CPUHP_AP_PERF_ONLINE thread context.=20

If PMU drivers perform sleeping operations like request_irq() or
kzalloc(..., GFP_KERNEL) in their init_cpu callback, this IPI context will
cause a "BUG: scheduling while atomic" panic during driver probe.

> +	}
> +
>  	/*
>  	 * Now that the PMU is complete, make it visible to perf_try_init_event=
().
>  	 */

[Severity: Critical]
Does the error path following this initialization leak the per-CPU state?

When a PMU is registered, init_cpu() is invoked for all online CPUs to
initialize per-CPU state. If perf_pmu_register() fails immediately after th=
is
at idr_cmpxchg(), or when the driver module is later unloaded and
perf_pmu_unregister() is called, the framework does not iterate over online
CPUs to call exit_cpu().

Because this new API bypasses the standard cpuhp_remove_state(), per-CPU
resources will be permanently leaked, potentially causing a Use-After-Free
panic when the module unloads and active interrupts point to freed code.

[ ... ]
> @@ -15258,6 +15305,17 @@ static void perf_event_setup_cpumask(unsigned in=
t cpu)
>  		    cpumask_any_and(pmu_cpumask, cpumask) >=3D nr_cpu_ids)
>  			cpumask_set_cpu(cpu, pmu_cpumask);
>  	}
> +
> +	/* Allow migrating if the new CPU is preferable (e.g. NUMA locality) */
> +	list_for_each_entry(pmu, &pmus, entry) {
> +		int prev_cpu =3D pmu->cpumask ? cpumask_any(pmu->cpumask) : nr_cpu_ids;
> +		bool cpumask_migrate =3D false;
> +
> +		if (pmu->init_cpu && (!pmu->cpumask || !cpumask_test_cpu(cpu, pmu->cpu=
mask)))
> +			cpumask_migrate =3D pmu->init_cpu(pmu, cpu);

[Severity: High]
This is the second half of the API contract mismatch mentioned above.

Calling init_cpu() here executes in a preemptible thread context, while
perf_pmu_register() calls it from a hardirq IPI context. Can this difference
in context cause issues for PMU drivers that expect a consistent execution
environment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784911757.gi=
t.robin.murphy@arm.com?part=3D1
