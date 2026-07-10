Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB097379C57
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668381; cv=none; b=JjLFPYZ6OzX75CbvAhZMTylxxFXM9J9ZtSuFQ2XSgXnZntRUY6pWRyzAdBWJj8PFB/FBCXLTyh978gqNQSSH4UidQm9zzZIG/sw11UqGsRgOmjpiH3sU4cTvXmVRssKIajs21UKeSqmsKsrx6OpFA1A6CF1JynUUSHS0L2an9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668381; c=relaxed/simple;
	bh=dE6PGL7YSe1c4hO+GA4CumqdzAulpazjF7X6x+/p7Qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OhoMp7bWiCyjcT9JloR5+5nodGVgT+kww8GVWbAjl4jaEqA2IADkOWJIYfyGZe2Jo5zCR7AdZPYqXNOibMYRWadYjkRJnBmm0t2HfRwF1m5amE7SBQnMe6Yca4InZBXLQ4Z2QNKN6JGiZ/QPKnVJeUkxBr2UXDxWpMeA6ItrjrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhVX5rsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhVX5rsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3011F000E9;
	Fri, 10 Jul 2026 07:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783668379;
	bh=mwYyjiqq69IvR2t/uIHM4LR96CPEKfxpYuW6jKvT6AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PhVX5rsu1D1Jolu+FQn2DZ523/g30t3ROhzEpTF1HuuFQ4/aaSqIdBh7/aUBkLo8x
	 ylaLjJVsJHNXhTHhrgG8TrBQdT5cQIpbGUVl0WPekgepRMCLBTULY8a7z0lwT1Fygj
	 eImG3ID9ZmoAfjccR3yUSTdr19y2LWzoBEctiF7MB3aIbz6wwT3o3YsYPTk7wkUH6w
	 6mH+Wl1YH8bJngVKgiKUoOFRnQBwlqmC1C8UkIixZ4uFKOAsH3bwOhKsuaoEJ5rdsG
	 RibUl1yiok/V16af0ZOfNy4iatlzPkDxFm2J/TfA+ineEJ2hLZCVtk4LsHfpWemvFg
	 LHxOQuA4nfD5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] perf/x86/intel: Clear cpuc->pmu on hybrid PMU init
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710065128.1799838-4-dapeng1.mi@linux.intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
 <20260710065128.1799838-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 07:26:18 +0000
Message-Id: <20260710072619.5E3011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Lockless double-read of `cpuc->pmu` in `x86_get_pmu()` leads to a =
TOCTOU race when racing with `cpuc->pmu =3D NULL`, causing a NULL pointer d=
ereference.

Pre-existing issues:
- [High] The patch leaves a critical memory corruption vulnerability unhand=
led if a CPU hotplug rollback occurs before the hybrid PMU initialization r=
uns.
- [High] An unhandled #GP fault occurs in `intel_pmu_handle_irq` if a spuri=
ous NMI/PMI is received on a CPU where PMU initialization failed.
--

--- Patch [3]: [PATCH 3/7] perf/x86/intel: Clear cpuc->pmu on hybrid PMU in=
it failure ---
commit 0c199c356195e47c5b429eac88846944835a4589
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Clear cpuc->pmu on hybrid PMU init failure

When init_hybrid_pmu() fails at check_hw_exists(), cpuc->pmu may still
point to the default static PMU. The CPU hotplug rollback then runs
intel_pmu_cpu_dead(). On hybrid systems, that path may call
hybrid_pmu(cpuc->pmu), which is not valid for the static PMU pointer and
can result in incorrect hybrid state access.

Fix this by resetting cpuc->pmu to NULL on hybrid PMU init failure.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b39c6ce0efb5c..9d4774278b508 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6329,8 +6329,10 @@ static bool init_hybrid_pmu(int cpu)
> =20
>  	intel_pmu_check_hybrid_pmus(pmu);
> =20
> -	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask))
> +	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask)) {
> +		cpuc->pmu =3D NULL;

[Severity: High]
Can this assignment race with concurrent readers?  Looking at x86_get_pmu()
in arch/x86/events/core.c, there is a lockless double-read of cpuc->pmu:

x86_get_pmu(int cpu)
{
    ...
    if (WARN_ON_ONCE(!cpuc->pmu))
        return &pmu;

    return cpuc->pmu;
}

If sys_perf_event_open() executes concurrently and calls x86_get_pmu()
via reserve_lbr_buffers(), could the compiler emit two independent loads?

If cpuc->pmu is non-NULL during the first load but is set to NULL by this
patch before the second load, x86_get_pmu() would return NULL.  Does this
lead to a NULL pointer dereference in reserve_lbr_buffers()?

> +		return false;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does this fully resolve the
rollback vulnerability?

If a CPU hotplug operation fails between the CPUHP_PERF_X86_PREPARE and
CPUHP_AP_PERF_X86_STARTING states, the hotplug core rolls back and invokes
intel_pmu_cpu_dead().

Because init_hybrid_pmu() is bypassed entirely, cpuc->pmu remains pointing
to the static default pmu struct.

intel_pmu_cpu_dead() then executes:

    if (is_hybrid() && cpuc->pmu)
        cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);

Since cpuc->pmu is non-NULL, hybrid_pmu() calculates a negative offset from
the static pmu struct, and cpumask_clear_cpu() performs an out-of-bounds
memory write. Is there a way to safely handle rollbacks that bypass
initialization entirely?

[Severity: High]
This is also a pre-existing issue, but what happens if a spurious NMI is
received on a CPU where check_hw_exists() failed?

If init_hybrid_pmu() returns false here, x86_pmu_starting_cpu() ignores this
failure and returns 0, allowing the CPU to come online with a disabled PMU.
If another CPU has active perf events, active_events is greater than 0.

When an NMI broadcast hits this broken CPU, perf_event_nmi_handler() sees
active_events > 0 and calls intel_pmu_handle_irq(), which executes:

    __intel_pmu_disable_all(true);

This unconditionally executes wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0).
Since the PMU MSRs are unsupported on this CPU, will this unchecked wrmsrq
trigger a fatal general protection fault?

>  	pr_info("%s PMU driver: ", pmu->name);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710065128.1799=
838-1-dapeng1.mi@linux.intel.com?part=3D3
