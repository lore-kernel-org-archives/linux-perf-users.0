Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C829B200
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779167516; cv=none; b=BlUnNAyql3O1eWapxH29i/v6nt5/UnZi1nRUMwg4nKLGM1xSPLJgNUvdZIsLKZqraUMYQ1OsstpIa7QhBF7a+CF5kVMkAdkz0TFvCA989FImgQ1k5iwRqfP+F5cLvfFw0vYn0q4x/JuojRBFO9SNgZGc7E3PdnexS7/2a/eewhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779167516; c=relaxed/simple;
	bh=TBSBZdWkiULcpdSG/Xmi/wnvJri8QCiNXKQrZuebNTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QmPId+ZUvmf4z8Mc6iMvxzIY+zSHHX2theJx13bfyQ6XFfSZxvQJ7g0zi92hzP3rHdAeZluGvQPjGrR96ISlQ/EqK0Yz8IRyPT7O56fdW5Cvx2B8bP+UIMaqoE9KtUn//wPKOl26V1PvRdTqtpHcIIQuOMvKzpzDwBMu+58lGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfZLUuGf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfZLUuGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB63C2BCB3;
	Tue, 19 May 2026 05:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779167516;
	bh=TBSBZdWkiULcpdSG/Xmi/wnvJri8QCiNXKQrZuebNTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nfZLUuGfyNnydcMxIn8Kaslm3+hYwitA4qHQCZ1RENEsk2qgA/6eGI4kaNoNhZQc3
	 xZjBlkO/oARJM8rV5xm4oHwosRHMGy56cPAdpVhLrMglZ4Hpk+h7O/vbXmX23xrgpE
	 hnZuy0KDqsTKCLwmounEqdV36VovkQcxgE0p/HsLVwQ1YNqiKp0vPonszAblLl5gLA
	 QZyzHRpTHMzJ8cjU8GDHqDKi8WuoD4HgBMbBxfDUnGfVX4iqucZ4+pmibiBbn7j3vE
	 nIvTKCtT6vXxjJKsabKxuInjDuPzVEbf1DqzQy4jLHRXS3TkltPR/DdDtdhevOsZrA
	 84rbGOKkQk9sw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] perf/x86/amd/uncore: Add Hygon uncore PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260519033225.1479907-4-liuqi@hygon.cn>
References: <20260519033225.1479907-4-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 05:11:55 +0000
Message-Id: <20260519051155.ADB63C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing PMU unregistration in the module initialization error path=
 leads to a fatal Use-After-Free.
- [High] Integer truncation of the `num_pmcs` bitfield allows an out-of-bou=
nds array write.
- [Medium] Uninitialized stack memory is copied to long-lived per-CPU data =
structures.
- [Low] Use of non-existent macro `kzalloc_obj` causes a build failure.
- [Low] Linking `uncore_common.o` into both `amd-uncore` and `hygon-uncore`=
 causes multiple definition linker errors.
--

commit a3e675d32729bead13a45d2e64f57244f9040366
Author: Qi Liu <liuqi@hygon.cn>
Subject: perf/x86/amd/uncore: Add Hygon uncore PMU support

Add uncore PMU support for Hygon processors based on the shared AMD-family
uncore framework.

> diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
> index f951ae64ee361..32bf7aae23681 100644
> --- a/arch/x86/events/amd/Makefile
> +++ b/arch/x86/events/amd/Makefile
> @@ -5,6 +5,8 @@ obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+=3D power.o
>  obj-$(CONFIG_X86_LOCAL_APIC)		+=3D ibs.o
>  obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+=3D amd-uncore.o
>  amd-uncore-objs				:=3D uncore_common.o uncore.o
> +obj-$(CONFIG_PERF_EVENTS_HYGON_UNCORE)	+=3D hygon-uncore.o
> +hygon-uncore-objs			:=3D uncore_common.o hygon_uncore.o

If a kernel is configured with both CONFIG_PERF_EVENTS_AMD_UNCORE=3Dy and
CONFIG_PERF_EVENTS_HYGON_UNCORE=3Dy, won't Kbuild link uncore_common.o twice
into the built-in.a archive? Will this result in fatal 'multiple definition'
linker errors for all globally visible symbols defined in uncore_common.c
(e.g., uncore_common_event_init)?

> diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hyg=
on_uncore.c
> new file mode 100644
> index 0000000000000..133b6b1923de9
> --- /dev/null
> +++ b/arch/x86/events/amd/hygon_uncore.c
[ ... ]
> +static int hygon_uncore_df_ctx_init(struct uncore_common *uncore,
> +				    unsigned int cpu)
> +{
> +	struct attribute *df_attr;
> +	struct uncore_common_pmu *pmu;
> +	int num_counters;
> +
> +	if (uncore->init_done)
> +		return uncore_common_ctx_init(uncore, cpu);
> +
> +	num_counters =3D uncore_common_ctx_num_pmcs(uncore, cpu);
> +	if (!num_counters)
> +		goto done;
> +
> +	uncore->pmus =3D kzalloc_obj(*uncore->pmus);

Will this cause a build failure? The macro kzalloc_obj does not exist anywh=
ere
in the kernel codebase. Should this be using kzalloc() instead?

(This issue also appears in hygon_uncore_df_iod_ctx_init()).

[ ... ]
> +static void hygon_uncore_df_ctx_scan(struct uncore_common *uncore,
> +				     unsigned int cpu)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +	union uncore_common_info info;

Does this code copy uninitialized stack memory to long-lived per-CPU data
structures?

Because info is not zero-initialized, and the code manually assigns several
bitfields but omits others (like private here and aux_data in the IOD scan
below), the omitted bitfields will retain uninitialized stack garbage.

> +
> +	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
> +		return;
> +
> +	info.split.gid =3D 0;
> +	info.split.aux_data =3D 0;
> +	info.split.num_pmcs =3D NUM_COUNTERS_DF;
> +
> +	cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
> +	info.split.cid =3D ecx & 0xff;
> +
> +	*per_cpu_ptr(uncore->info, cpu) =3D info;

Since the entire 64-bit union is stored into per-CPU memory here, should in=
fo
be explicitly initialized?

> +}
> +
> +static void hygon_uncore_df_iod_ctx_scan(struct uncore_common *uncore,
> +					 unsigned int cpu)
> +{
> +	int num_packages, iods_per_package;
> +	union uncore_common_info info;
> +
> +	if (!boot_cpu_has(X86_FEATURE_PERFCTR_NB))
> +		return;
> +
> +	if (boot_cpu_data.x86_model < 0x4 || boot_cpu_data.x86_model =3D=3D 0x6)
> +		return;
> +
> +	num_packages =3D topology_max_packages();
> +	iods_per_package =3D amd_nb_num() / num_packages - topology_max_dies_pe=
r_package();
> +	if (iods_per_package <=3D 0)
> +		return;
> +
> +	info.split.cid =3D topology_physical_package_id(cpu);
> +	info.split.gid =3D 0;
> +	info.split.private =3D iods_per_package;
> +	info.split.num_pmcs =3D NUM_COUNTERS_DF * iods_per_package;

Could this truncation allow an out-of-bounds array write later during event
addition?

num_pmcs is an 8-bit bitfield. If the hardware topology presents a large
number of nodes (e.g., 65 IODs), NUM_COUNTERS_DF * iods_per_package yields
260, which silently truncates to 4.

Consequently, pmu->num_counters would be set to 4, and uncore_common_ctx_in=
it()
would allocate a ctx->events array of only 4 elements.

During hygon_uncore_df_iod_add():
    iod_idx =3D event->attr.config1;
    for (i =3D iod_idx * NUM_COUNTERS_DF; ...
        if (try_cmpxchg(&ctx->events[i], &tmp, event)) {

If event->attr.config1 is 64 (which passes validation because
info.split.private is correctly 65), the array index here would be 256. Cou=
ld
try_cmpxchg() write past the end of the 4-element ctx->events array?

[ ... ]
> +static int __init hygon_uncore_init(void)
> +{
> +	struct uncore_common *uncore;
> +	int ret =3D -ENODEV;
> +	int i;
> +
[ ... ]
> +	ret =3D cpuhp_setup_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_ONLINE,
> +				"perf/x86/hygon/uncore:online",
> +				hygon_uncore_cpu_online,
> +				hygon_uncore_cpu_down_prepare);
> +	if (ret)
> +		goto fail_start;
> +
> +	return 0;
> +
> +fail_start:
> +	cpuhp_remove_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_STARTING);
> +fail_prep:
> +	cpuhp_remove_state(CPUHP_PERF_X86_HYGON_UNCORE_PREP);
> +fail:
> +	for (i =3D 0; i < HYGON_UNCORE_TYPE_MAX; i++) {
> +		uncore =3D &hygon_uncores[i];
> +
> +		if (uncore->info) {
> +			free_percpu(uncore->info);
> +			uncore->info =3D NULL;
> +		}
> +	}
> +
> +	return ret;
> +}

Does the module initialization error path have a regression where it fails =
to
unregister any PMUs that were successfully registered via perf_pmu_register=
()?

If cpuhp_setup_state(CPUHP_AP_PERF_X86_HYGON_UNCORE_ONLINE) fails (for exam=
ple,
because uncore_common_ctx_init() returns -ENOMEM during DF_IOD setup), the
initialization aborts and jumps to fail_start. This error path removes CPU
hotplug states and frees uncore->info, but fails to unregister the PMU (if
the DF PMU succeeded earlier).

Since module initialization returns an error, the module is unloaded and its
memory is freed. The dangling PMU remains active in the core perf subsystem.
Would subsequent userspace operations on this PMU dereference function poin=
ters
(like .event_init) pointing to the unloaded module's memory and cause a
use-after-free panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519033225.1479=
907-1-liuqi@hygon.cn?part=3D3
