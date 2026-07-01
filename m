Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBD37267F
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878443; cv=none; b=DJfxRTEHR7gVh2hgMUe83fxhgM7cl6WhGn17F1tw9zpPft4mZsfoJAjKWtZ3xecwrkHwRN0T7XKqI0DC7bjLOpUCoxdLmz4rvxYBt+2CDI1F/gtJzo1AHqLTmf5tYqx/t+3EIMR9lFQxLJ3/XljH2ZOXd3mW12gzwP51I10BVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878443; c=relaxed/simple;
	bh=cJ99rWxtcIlwa/pPqVajrisliWsYyogV1NxjyQ10iU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eWIGJAYMkjgsEGEuOf1y4N9VJ/vI5yQljHmeJBJcPPiCl37f8kUJJTfAMtgXnAmgIhmCkloQzsHPG/nvUBSNzjslJHRJo/NP3jYB4lTPHtoVtuZyAfetnmKTt5w2EtBKrHgqPvyk8JPcw6fsd67Ct5LNQ/4upv0F2TOP/pWzEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7guwWrn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7guwWrn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A047D1F00A3A;
	Wed,  1 Jul 2026 04:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878439;
	bh=+uutt4nBXg0Tp8bfv3yDuH5OQPUq/hSt/3KM5+uVqws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7guwWrnQvx10tfFOFs2S/RLG8SHW6zrtlgDKHE23cmqVyEUh8PbigiZls7S+2vGL
	 IEcClfjBNL3WCFFOH/CVXYgcGmpK5UPKinOxUugRWRL6ElPUAlKgQfS5KOzm08IDQ2
	 P0qlg7yXCgUgKnmKCklao6gzOOmToixXPRfIwuNE/dmEANdPdsGE7qgRsHd90pPIYl
	 BC0gwNfty46UTfV0T05oJku7P4tuc97n3x9fP2URuFVaC3Wnn2Z9A39y8v8zvr9qNw
	 4DOUv0Che9Zv1T8OZBc++LS8Jx9yvGLurDDReMvoo3GkCIzdYVTc3OKmWeBHgA/r1c
	 7b59bvlUyb3/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf/x86/amd/uncore: Convert AMD driver to common
 PMU helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701034413.718872-3-liuqi@hygon.cn>
References: <20260701034413.718872-1-liuqi@hygon.cn>
 <20260701034413.718872-3-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:00:39 +0000
Message-Id: <20260701040039.A047D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Context migration logic incorrectly alters the designated PMU CPU =
when a non-designated sibling CPU goes offline, permanently breaking PMU hr=
timers and event polling.
- [High] Module initialization failure during CPU hotplug setup leaks previ=
ously registered PMUs and their allocated structures, leading to a dangling=
 pointer in the kernel's PMU list.
--

commit 9535e3c8779a5fdb3921bce37f7ad4c941fd34c9
Author: Qi Liu <liuqi@hygon.cn>

perf/x86/amd/uncore: Convert AMD driver to common PMU helpers
   =20
Use the common uncore PMU helpers for AMD uncore event handling and
per-CPU context management.

> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index dbc00b6dd69ee..9cb8b0d1afe7a 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
[ ... ]
> @@ -1087,41 +654,40 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *unc=
ore, unsigned int cpu)
[ ... ]
> -static struct amd_uncore uncores[UNCORE_TYPE_MAX] =3D {
> +static struct uncore_common uncores[UNCORE_TYPE_MAX] =3D {
>  	/* UNCORE_TYPE_DF */
>  	{
>  		.scan =3D amd_uncore_df_ctx_scan,
>  		.init =3D amd_uncore_df_ctx_init,
> -		.move =3D amd_uncore_ctx_move,
> -		.free =3D amd_uncore_ctx_free,
> +		.move =3D uncore_common_ctx_move,
> +		.free =3D uncore_common_ctx_free,
>  	},

[Severity: High]
This isn't a bug introduced by this patch, but while moving the context
migration logic to uncore_common_ctx_move(), I noticed a potential issue
when a sibling CPU is taken offline.

In the migration loop, if the offline CPU is not the currently designated C=
PU,
will the loop pick the first online sibling CPU and forcibly update next->c=
pu
to it without checking if the offline CPU was the active one?

If this happens, the hrtimer would never start on the newly designated CPU
because no events were actually migrated. When the existing hrtimer fires
on the originally designated CPU, it evaluates this check in
uncore_common_hrtimer():

    if (!ctx->nr_active || ctx->cpu !=3D smp_processor_id())
        return HRTIMER_NORESTART;

Would this mismatched CPU cause the pinned hrtimer to permanently return
HRTIMER_NORESTART, stopping the PMU event polling?

[ ... ]
> @@ -1138,7 +706,7 @@ static int __init amd_uncore_init(void)
>  		BUG_ON(!uncore->move);
>  		BUG_ON(!uncore->free);
> =20
> -		uncore->info =3D alloc_percpu(union amd_uncore_info);
> +		uncore->info =3D alloc_percpu(union uncore_common_info);
>  		if (!uncore->info) {
>  			ret =3D -ENOMEM;
>  			goto fail;
>  		}

[Severity: High]
This is a pre-existing issue, but I noticed a potential leak in the module
initialization error path, such as at this goto fail or if cpuhp_setup_stat=
e()
fails later in amd_uncore_init().

If setup fails for CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE, it jumps to the err=
or
handling labels (e.g., fail_start). However, the error path doesn't seem to
unregister successfully registered PMUs or free uncore->pmus.

Unlike amd_uncore_exit() which correctly cleans up the PMUs:

    perf_pmu_unregister(&pmu->pmu);
    free_percpu(pmu->ctx);
    ...
    kfree(uncore->pmus);

Will failing during initialization leave dangling pointers in the global pm=
us
list and leak the allocated context memory, potentially causing a crash
during subsequent PMU accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701034413.7188=
72-1-liuqi@hygon.cn?part=3D2
