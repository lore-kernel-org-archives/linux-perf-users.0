Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3333EAEC
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517263; cv=none; b=Ajalq5M99nEIuFijoDrucdo5Dk8YxH7oZQseEq/qhOcN8sCoHzPCQpPCRKtIghqwB+dwz30uP3/EHtFK1EIwJk8h8Y8zeIw0Wk4QYXbgjzP4KCpLu6H5GV+on/oGdqg3dpuWRdtpoS6CX04B+aNkiWAcjJm5TCCx31UF8vZQpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517263; c=relaxed/simple;
	bh=Q7tG4BsYk7qisQ3XO+NRrv1qxaM0MYpaMUsydG4u9U0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uR/odKbuE7JCKOZXQaMBuCxb07DcMIx9N5ryEpCu2gOxa46ZcPyFR4Jav01ETLK5BxRQaVkP3DQOaeJYuBDO8pl5acsHNgeFfL/6uhTroKt1QY7AdZje4axI2ZcM7Il/3YyAu7+T7gFPT4KT9wBVsdnUsYL67r2SCZEeWdAakXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c811deJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c811deJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF131F000E9;
	Wed,  8 Jul 2026 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783517261;
	bh=GuoOYaJ1GnLjgRRnrCg/yG03UJbJQfqYcdBX0lqaQk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c811deJVEbwZ+on49KW8y2KFosx1y1pfVVKFRUQ9hw7UIrkIEV1PL9vw49iYHw3db
	 Od18TsclU9p6USR+YkA7L+ggQHZlZ1YRi7sxztBEVkGXDSxD0KSwu+oNfcSlq73hXg
	 QfLTgn5mtq0quqqu+MczN4q1IWdOjcphw89gK/PKW4FUB0Vr17M9JJD2XeAV3us1iU
	 tA8MsY6Sdy1PyGzq7ZWeK58PqRyYewNSy7W6uIm0q2rz4j8MgfPgTnrCfL7niP5O3X
	 M0mlxpY5DU8YclJ9lflCdCYWUfACcurLlANnBy86q0j4jfXswJE2cOIa4favp0HA2r
	 zcj6lNGhypE4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708131315.13766-2-liuqi@hygon.cn>
References: <20260708131315.13766-1-liuqi@hygon.cn>
 <20260708131315.13766-2-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 13:27:41 +0000
Message-Id: <20260708132741.9DF131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Module initialization error path fails to unregister PMUs and leak=
s per-CPU arrays, leading to a Use-After-Free.
- [Medium] The CPU online callback aborts PMU initialization on the first f=
ailure, leaving remaining independent PMUs uninitialized.
- [Medium] The patch removes L3 cache uncore PMU support for Hygon processo=
rs without providing a replacement.
- [Medium] The `update_interval` module parameter lacks bounds checking, al=
lowing a value of 0 to cause a CPU-locking interrupt storm.
--

--- Patch [1]: [PATCH v3 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU sup=
port ---
commit 451a8d6c91c9ade8b2dbc942f864d5c36dc872c9
Author: Qi Liu <liuqi@hygon.cn>
Subject: perf/x86/amd/uncore: Add Hygon uncore PMU support

This commit adds a new uncore PMU driver specifically for Hygon Family 18h
processors, supporting Data Fabric and IO Die counters. It also removes the
Hygon-specific checks from the AMD uncore driver to keep the vendor
implementations separate.

> diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hyg=
on_uncore.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/x86/events/amd/hygon_uncore.c
> @@ -0,0 +1,863 @@

[ ... ]

> +/* Interval for hrtimer, defaults to 60000 milliseconds */
> +static unsigned int update_interval =3D 60 * MSEC_PER_SEC;
> +module_param(update_interval, uint, 0444);

[Severity: Medium]
Could setting this to 0 cause an interrupt storm? If a privileged user loads
the module with update_interval=3D0, hrtimer_duration becomes 0. When this =
is
passed to hrtimer_forward_now(), it is clamped to the minimum resolution,
causing the high-resolution timer to fire continuously in a loop. Should
there be a minimum bounds check here to prevent a CPU lockup?

[ ... ]

> +static int hygon_uncore_cpu_online(unsigned int cpu)
> +{
> +	struct hygon_uncore *uncore;
> +	int i;
> +
> +	for (i =3D 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
> +		uncore =3D &uncores[i];
> +		if (uncore->init(uncore, cpu))
> +			break;

[Severity: Medium]
Should this be a continue instead of a break? If the first PMU type (e.g.,
hygon_df) fails to initialize, this break aborts the loop, which prevents
any subsequent independent PMUs (like hygon_df_iod) from initializing on
this CPU. The same patch corrects this exact logic flaw in
amd_uncore_cpu_online(), but it seems to have been reintroduced here.

> +	}
> +
> +	return 0;
> +}

[ ... ]

> +fail_start:
> +	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING);
> +fail_prep:
> +	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
> +fail:
> +	hygon_uncore_info_cleanup();
> +	return ret;
> +}

[Severity: High]
Does this error path leak the registered PMUs? If cpuhp_setup_state()
fails for the ONLINE state, we remove the previous hotplug states but it
looks like hygon_uncore_pmu_cleanup() is never called.

Any PMUs successfully registered during the initial CPU online callbacks
would remain registered, and their per-CPU arrays would not be freed. When
the module unloads, could this lead to a use-after-free if the perf
subsystem tries to access the freed module memory?

[ ... ]

> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index dbc00b6dd69ee..3f8e40abba736 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c

[ ... ]

> @@ -1120,8 +1116,7 @@ static int __init amd_uncore_init(void)
>  	int ret =3D -ENODEV;
>  	int i;
> =20
> -	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD &&
> -	    boot_cpu_data.x86_vendor !=3D X86_VENDOR_HYGON)
> +	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
>  		return -ENODEV;

[Severity: Medium]
Does this intentionally drop L3 cache uncore support for Hygon? By
removing Hygon support here in amd_uncore.c, the previous L3 cache
counters are no longer available. Looking at the new hygon_uncore.c, it
only implements the Data Fabric and IO Die PMUs, meaning L3 PMU support
appears to be lost completely.

>  	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
>  		return -ENODEV;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708131315.1376=
6-1-liuqi@hygon.cn?part=3D1
