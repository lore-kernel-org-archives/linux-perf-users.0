Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989046;
	b=Qcsr/r2VfomXQNXON9m2gCPtuXVn6tRmW+e1CjbDAGBw4HQc/szUv1mHOQXCJpmssypr
	 6atJ1CkcGFceclL6l8OtqLJ1/16vGwBPXTG/2SzL1i7/NSKiAn4rX+MCpFdPKY0KNaDAa
	 +uolXZHjDo0Mk8/J4mTpm2NTcLditOpoaEp0RLMQgWvWFHoUXLkSTNVGGhcfUvH7FrkGJ
	 lqbM6yqbnd4iNyVWza7UQSFwoq5S4mBeTPzXq1MkN33CAjlL76aR5hSc6hQgDTANFcMIE
	 Ca9EfY456wp/974lcfCo7ibp4yZVP9XZkyW4od8M/GXcKErNGN+Ef+NfgnCOrVPUxng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tK8L+JOFV1vmheksY7awEgZTYdeg7j1crOSCzmzQlgs=;
	b=K+NaRVXsVXfJ+enQ52QH3GP1D0vP3v3aDiMJp/XdR/IvZ6NulnF1r7kX5mRELFnkHKw5
	 ID9+r4sOoQajeTjZ/1F0lvQoJXnS2Wu4wchCmM0oGUojjvf5KWt0K1TyRu8hZZt1YSqun
	 HVtN/Pe75KeJz+V6oWADz9kkKzl0LVhdgzYe58CPnKUdqa7kyZF6F9mlB6iXCUek3OdC1
	 8MkWC/ZWaPP/Kcr63mymOJswW4YSevY74ocWXjt/OP7fmIzBSgmXqP8kqVbmM39UOSyzf
	 sF1VcKBI5nKaJsdedSRF4QC5p3ADgM36FqvlMwB393uhbfj2tCt+yWGpIgiwA4L8cTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSHa0RcS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA24D606A33D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSHa0RcS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F8A1F008A1;
	Fri,  6 Nov 2026 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989045;
	bh=tK8L+JOFV1vmheksY7awEgZTYdeg7j1crOSCzmzQlgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSHa0RcS3PX9rJSHqk6cdNZhahdSIxTgqp59YpT0p+Po+ZIpkiTj1Uf0MY+1brkPj
	 dFQKRSWMo5AnhCjK7r8iL8LLWSq3PHGPK8zkmvYzUolNkgUsj5UIbfZKvrDe3/e/L/
	 32vDm5eRJ5VFPtcNYPBtVnhJ4PMhoR4YlXt2UTyboMtUlGqR1CZBYfPdHWGHCBrsTW
	 buJdAOMdBDliEYs6RZXjdVH1DJRLgdCc0Rc7prfbM2iWQh8VoXarO9wRnlRKLANLIs
	 EVFKcj7BPder+2dIt5oqzOPOsrVNCdpz4yG55AAfYR/QWfJKrxIwI6UBn7otwRJLxO
	 mw4FUOorVerEQ==
Message-ID: <sashiko-outbox-202006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] perf/arm_cspmu: Add Arm system PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <2cf79599d522539440a53adb4221dfc5a4d7b9e6.1793986672.git.robin.murphy@arm.com>
References: <cover.1793986672.git.robin.murphy@arm.com>
 <2cf79599d522539440a53adb4221dfc5a4d7b9e6.1793986672.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:17:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf/arm_cspmu: arm_cspmu_init_impl_ops() defers probe when
  ARM_SYSTEM_PMU=3Dn
--

commit ae4570e49b496427e88dd55c46f9506b33a8b68e
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm_cspmu: Add Arm system PMU

This commit adds the arm_syspmu backend module to support an additional
64-bit event filter register (PMEVFILT3R) on Arm system PMUs with product
ID 0x9c3.

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/=
arm_cspmu.c
> index 912f03ce3ef5f..9f298ea1a9745 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -358,6 +358,13 @@ static struct arm_cspmu_impl_match impl_match[] =3D {
>  		.module		=3D NULL,
>  		.impl_init_ops	=3D NULL,
>  	},
> +	{
> +		.module_name	=3D "arm_syspmu",
> +		.pmiidr_val	=3D ARM_CSPMU_IMPL_ID_ARM,
> +		.pmiidr_mask	=3D PMIIDR_IMPLEMENTER,
> +		.module		=3D NULL,
> +		.impl_init_ops	=3D NULL,
> +	},
>  	{
>  		.module_name	=3D "ampere_cspmu",
>  		.pmiidr_val	=3D ARM_CSPMU_IMPL_ID_AMPERE,

[Severity: Medium]
Does adding an unconditional impl_match[] entry for ARM_CSPMU_IMPL_ID_ARM
cause arm_cspmu_init_impl_ops() to defer probing indefinitely when
CONFIG_ARM_SYSTEM_PMU is disabled?

Previously, CoreSight PMUs with Arm's implementer ID did not match any
entry in impl_match[] and probed using the generic ops.  With this entry
present, arm_cspmu_init_impl_ops() requires the arm_syspmu module to
register match->impl_init_ops:

drivers/perf/arm_cspmu/arm_cspmu.c:arm_cspmu_init_impl_ops() {
    ...
		if (match->impl_init_ops) {
    ...
		} else {
			request_module_nowait(match->module_name);
			ret =3D dev_err_probe(cspmu->dev, -EPROBE_DEFER,
					    "Waiting for module %s to load\n",
					    match->module_name);
		}
    ...
}

Because CONFIG_ARM_SYSTEM_PMU has no default in Kconfig, existing configs
with CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU enabled will have
CONFIG_ARM_SYSTEM_PMU=3Dn, leaving every Arm-implemented CoreSight PMU
(including non-0x9c3 devices where arm_syspmu_init_ops() is a no-op)
permanently stuck in -EPROBE_DEFER.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793986672.gi=
t.robin.murphy@arm.com?part=3D1
