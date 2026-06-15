Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903EA37B41B
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527103; cv=none; b=i2+OP4XCXBArm4a8KqLSfhny18lhS32xY1sxLupVntfLy7I0vqIqCLHCW0wkquPw0FYHMXqAkxI90sI4DXNTNxqr3z1Ngg8EcDogsnVsc8wB6Jdjfk+EydbInZuU22Xzif162jnz2vx3OZ3edlLzdMbn61IWOipg7gx+REeTvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527103; c=relaxed/simple;
	bh=lzu8Fh3pIoV3Nz+OZ7MTorJ9EmZB88Y1YWPs5Js9n6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fkhYYcUgl/T2lSj94DK9LDbqUGKvjQf64hPJtHM5grjbgyR/ADvoY6X706tvEJpaJQ+W6b3bHzjncYkPzYChkCFXOoGLw+czSulwcdb5YtTnABecmCJlWaovM5eGBiwk8fmnXjfm2hZ6Ez05KfU427k9S+eHIJ2Z2AN0R3Ld7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckiLD/iC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckiLD/iC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9311F000E9;
	Mon, 15 Jun 2026 12:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781527102;
	bh=bfdTLgQ9ePTL8DqI5waDCI4LcuhlagkHe7Y7476kEm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckiLD/iCb44tJqiIyY1z/3XsmY1aGGdfvU3FCRGEpx5UOUkuLLL/4QaVNu5KeIv2F
	 Vr2SX3qZmddPpyYs9RMYjPXt2gD6duNRWbKr+p7pi+g3IoVwH3uh+kjnrBrUAnv/ra
	 BXRMVq/25CAMP+feqa3P6Whs8ok5/b6joGE3lMY5yPbKuqG1psBWWfNJfiztCduhAE
	 aA+lcKuAmErcStfFBZ+vY5MDLC1XS3XeyI6ILRBirMSFSIdNUZQmZDkCcsapQW4b98
	 3chuNs/Jc7DTrvzrFjwGEvIuUIk1nPL+SwQgs0P/KwfD+Untkde2n51o9XXl4ff1kT
	 ovQKQEk0OTTNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] perf/x86/uncore: Add L3 PMU support for Hygon
 family 18h model 6h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fu Hao" <fuhao@open-hieco.net>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d387dd1497ac938b82ecc0c56505a64a61443c22.1781523812.git.fuhao@open-hieco.net>
References: <d387dd1497ac938b82ecc0c56505a64a61443c22.1781523812.git.fuhao@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 12:38:21 +0000
Message-Id: <20260615123822.3B9311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Registered PMUs are not unregistered if `cpuhp_setup_state()` fail=
s during module initialization, leading to a Use-After-Free.
--

commit 98d69c16b51701dce640f5ac92cee0daa35f2cfb
Author: Fu Hao <fuhao@open-hieco.net>

perf/x86/uncore: Add L3 PMU support for Hygon family 18h model 6h

This patch adds L3 PMU support for the Hygon family 18h model 6h processor
by adjusting the slicemask and threadmask in the uncore driver.

> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 9293ce50574da..21f00edd3caa6 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c

[ ... ]

> @@ -877,7 +910,8 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore,=
 unsigned int cpu)
>  	pmu->rdpmc_base =3D RDPMC_BASE_LLC;
>  	pmu->group =3D amd_uncore_ctx_gid(uncore, cpu);
> =20
> -	if (boot_cpu_data.x86 >=3D 0x17) {
> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_AMD &&
> +	    boot_cpu_data.x86 >=3D 0x17) {
>  		*l3_attr++ =3D &format_attr_event8.attr;
>  		*l3_attr++ =3D &format_attr_umask8.attr;

[ ... ]

> +	if (boot_cpu_data.x86_vendor =3D=3D X86_VENDOR_HYGON &&
> +	    boot_cpu_data.x86 =3D=3D 0x18) {
> +		*l3_attr++ =3D &format_attr_event8.attr;
> +		*l3_attr++ =3D &format_attr_umask8.attr;
> +		if (boot_cpu_data.x86_model >=3D 0x6 && boot_cpu_data.x86_model <=3D 0=
xf) {
> +			*l3_attr++ =3D &format_attr_threadmask32.attr;
> +			pmu->pmu.attr_update =3D hygon_uncore_l3_attr_update;
> +		} else {
> +			*l3_attr++ =3D &format_attr_threadmask8.attr;
> +		}
> +	}
> +
>  	if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
>  		free_percpu(pmu->ctx);
>  		pmu->ctx =3D NULL;

[Severity: High]
This is a pre-existing issue, but registering the PMU here exposes a teardo=
wn
issue in the module initialization error path.

If cpuhp_setup_state() fails for the online state in amd_uncore_init(), the
error path jumps to fail_start and removes the hotplug states. This triggers
the amd_uncore_cpu_dead() teardown callback, which correctly frees the
per-CPU context by calling amd_uncore_ctx_free().

However, the error path does not unregister the PMU or free the uncore->pmus
array:

arch/x86/events/amd/uncore.c:amd_uncore_init() {
    ...
fail:
	for (i =3D 0; i < UNCORE_TYPE_MAX; i++) {
		uncore =3D &uncores[i];
		if (uncore->info) {
			free_percpu(uncore->info);
			uncore->info =3D NULL;
		}
	}

	return ret;
}

Since the initialization failed, the module will be unloaded, but the perf
subsystem retains references to the registered PMUs.

Could this lead to a use-after-free if the perf subsystem later accesses
these dangling PMUs (for instance, via perf stat) after the module memory
has been freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781523812.gi=
t.fuhao@open-hieco.net?part=3D4
