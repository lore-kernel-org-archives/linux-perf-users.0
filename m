Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2E3BE65F
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280673; cv=none; b=n3D44Ce3lOdIQUtgHlU/qyLiCbz7kH8pTStWyZ8wxOIMPcogaqzuJ5EEBjyxFbkSLUBr2V+U4eGuJplbgkmk/MkdIy4y9ueOsQXhkJetScJmPVHQSjlOEFfVT85zPZeed+U+PpGmedH/aU97nkJ5YmWToAvFbwffo549Io1q2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280673; c=relaxed/simple;
	bh=zaOmCYFO5xCE0GgCQ0kjOD5m+TUe+dPqvWfCiMdw6jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bi88ZAPpY9HYKwC8iHRRoicJJYAtT5Re1OO1jAFkW3oKEHeIh5CjTiMMwed/ddH2q+9tpm3+lPRhf6DWnEvWBFaqPT2O/Vrtl17zZ9lWYvmUTM5/HLksyNKm7Fq7r3PcAdfEkwUg/Rjveo1rLsplRAQPz6KTCdIZMzp+NZn4M5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4DKyt9Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4DKyt9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A0F1F000E9;
	Fri, 17 Jul 2026 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280671;
	bh=WaZRqcMSJlFvM2U89mcmrMCL5r1Uc3q0C1qkaABylN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4DKyt9QMInL2joZzyRUxsS8si9CPgyMVeoYDHytRKOadr10RmQHci7P9Z8LPYNjh
	 gCKSlSmtCZHc0xdTsUG7AwTagF9itRNlK/TTx4KNHbgcfq5r82XGt3Sy6qYS1h8QZf
	 L8+0MyuCqf0aZqaKyUMlLMvY1aFvTgXvoCt8mS4ByFClD1bBHgEqkIdlu6Qk1PnABN
	 G0n+CctZDj5+7UMxNpa2NT+BGTDqRpQtJ9CZMG4RiQj73SGCJSRhfgdxJPFl90+Dls
	 YdegU6c0lIS/GB+GrXKUQe+Eym5xaNCMAf0WeJJBNae8K4kJRGSaa62pb3hmD8lilR
	 ptRrnFB12LFqw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 3/8] perf/x86: Guard intel_pmu_cpu_dead() against
 invalid hybrid PMU casts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717080342.1879573-4-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:31:11 +0000
Message-Id: <20260717093111.A5A0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Setting `cpuc->pmu =3D NULL` on initialization failure triggers a =
user-triggerable `WARN_ON_ONCE` in `x86_get_pmu()`.

Pre-existing issues:
- [High] Unchecked MSR writes in NMI handler cause a #GP fault on asymmetri=
c PMU configurations.
--

--- Patch [3]: [Patch v3 3/8] perf/x86: Guard intel_pmu_cpu_dead() against =
invalid hybrid PMU casts ---
commit 2ef12c59a0f0eb0a83a45dd11cf187ca55beecdf
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Guard intel_pmu_cpu_dead() against invalid hybrid PMU casts
   =20
Fix invalid container conversions in failure paths by clearing cpuc->pmu to
NULL when check_hw_exists() fails, and validating cpuc->pmu in
intel_pmu_cpu_dead(). A new helper x86_get_static_pmu() is added.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b39c6ce0efb5c..a991fc4f1575f 100644
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
Does setting cpuc->pmu to NULL here trigger a warning in x86_get_pmu()?

If check_hw_exists() fails (e.g., due to a hypervisor restricting PMU MSRs),
we now set cpuc->pmu to NULL but leave the CPU in the possible_cpus mask.

If a user later opens a perf event utilizing Architectural LBRs (like perf
record -b), x86_reserve_hardware() calls reserve_lbr_buffers() which
iterates over all possible CPUs:

arch/x86/events/intel/lbr.c:reserve_lbr_buffers() {
	...
	for_each_possible_cpu(cpu) {
		kmem_cache =3D x86_get_pmu(cpu)->task_ctx_cache;
	...
}

Because the failed CPU's cpuc->pmu is NULL, x86_get_pmu() hits its strict
WARN_ON_ONCE(!cpuc->pmu) assertion. If panic_on_warn=3D1 is set, could this
upgrade a graceful PMU initialization failure into a local panic?

Since intel_pmu_cpu_dead() now safely guards against the invalid cast with
cpuc->pmu !=3D pmu, is this assignment necessary?

[Severity: High]
This is a pre-existing issue, but does failing check_hw_exists() leave the
CPU vulnerable to a #GP fault during a spurious NMI?

If a CPU is brought online but its PMU MSRs are disabled by a hypervisor,
initialization for that CPU aborts here. However, perf_event_nmi_handler()
is registered globally if at least one CPU succeeds.

If an active perf event runs on a healthy CPU (so active_events > 0), and a
spurious or broadcast NMI strikes the broken CPU, it will execute:

intel_pmu_handle_irq()
    __intel_pmu_disable_all(true)
        wrmsrq(MSR_CORE_PERF_GLOBAL_CTRL, 0);

Could accessing this non-existent MSR on the failed CPU trigger an unchecked
#GP fault and kernel panic?

>  		return false;
> +	}
> =20
>  	pr_info("%s PMU driver: ", pmu->name);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717080342.1879=
573-1-dapeng1.mi@linux.intel.com?part=3D3
