Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9E3DA7F8
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887928; cv=none; b=onHLq3LV5rN+5INhou6FCWuhwUtXx4Vv2sltgM7wC01VKPsbtd3hLknoI5CHvMgYxHtVd2N3Ae2YnSXPgH/4WOkIru26IZC6MXNMb44lH9dhCSr5csDYWlMeq7OjJ+NfmmpKsU1nQIzP6+yP7oxCq0XXGgG1WEL9K2P9rvZTFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887928; c=relaxed/simple;
	bh=D53cgw8cGk6YfwAGf1yl23JOr59ee37YND4t68i76Fc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mMNh7ljrkaDn9W/B47yhjFd6deRkeToRENMdCxv2R9FJ6+EPYD0Aw5qauyUuydJIqp0RSryLTqKc0Lum1bvbtr5/LacOFPfweCqEPHOi+AHQKeyW5/Pudbm6j1VWj1/idVWKdO2ODrQByCkEGBRKpUP/WZfIVeLUlnRwHzfPLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW0IuS+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW0IuS+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758CA1F000FF;
	Sun, 20 Sep 2026 07:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887926;
	bh=HH8YuRKdHvM+OdH8H2r4nCxSCqmHuUH81a3tbKOzQdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LW0IuS+u8bScHYAGmz9CEKA3s0F8TDXwhocGW0l1MTp8U4fcgVheqWb4STs9lqxpC
	 SH4LDO3N62Sz33+qRg0Fsl3RnNzXCSMET0DQHObjkUonlevrxAyhwNVj3UaVzzFV/c
	 wHnUduivJFn3aasMsEkBBGDSoia2153usskxWBYaJEY+89SiU6S4Aa3wjBX9sZ3trr
	 mOIgSTmBtrb4ct57muXdNut407tbsPbdhQknYQzMsRPSYyVaWbE4eq/+OpMA/ZM7wv
	 KsUpsEAp2QKOp4QLy3CJngphTjiQjP5lx9r560GinrMC3ZsAstWJlsAgJtPaUlE2wo
	 kCIzIG5UE/blQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86: Fix missing error code in
 init_hw_perf_events()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bramwel Barack" <bramwelbarack89@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260920065510.15362-1-bramwelbarack89@gmail.com>
References: <20260920065510.15362-1-bramwelbarack89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 07:05:25 +0000
Message-Id: <20260920070526.758CA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/x86: inconsistent initcall return semantics on PMU fallback
--

commit ddd975294722d296c4cdeacb54faa85cadfe14fb
Author: Bramwel Barack <bramwelbarack89@gmail.com>

perf/x86: Fix missing error code in init_hw_perf_events()

This commit assigns -ENODEV to err when check_hw_exists() fails in
init_hw_perf_events(). The commit message states this fixes a missing error
code, preventing the function from returning 0 when hardware checks fail and
the code jumps to the out_bad_pmu cleanup path.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index d1af33d96d0a3..81873eda5b17b 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2164,9 +2164,10 @@ static int __init init_hw_perf_events(void)
>  	pmu_check_apic();
> =20
>  	/* sanity check that the hardware exists or is emulated */
> -	if (!check_hw_exists(&pmu, x86_pmu.cntr_mask, x86_pmu.fixed_cntr_mask))
> +	if (!check_hw_exists(&pmu, x86_pmu.cntr_mask, x86_pmu.fixed_cntr_mask))=
 {
> +		err =3D -ENODEV;
>  		goto out_bad_pmu;
> -
> +	}

[Severity: Medium]
Does this change introduce inconsistent return semantics for the PMU fallba=
ck
path?

The x86 perf core uses the out_bad_pmu cleanup path to gracefully fall back
to software events when hardware is unsupported or broken. Earlier in
init_hw_perf_events(), when no vendor PMU driver is present, the code
explicitly forces err =3D 0 to signal a successful fallback rather than a f=
atal
initialization failure:

	if (err !=3D 0) {
		pr_cont("no PMU driver, software events only.\n");
		err =3D 0;
		goto out_bad_pmu;
	}

If check_hw_exists() validation fails, it similarly falls back to software
events. Prior to this patch, it correctly inherited err =3D 0. Setting
err =3D -ENODEV introduces an inconsistent state where functionally identic=
al
fallback paths return different codes (0 vs -ENODEV).

Can this cause initcall_debug and tracepoints (trace_initcall_finish) to
erroneously record a kernel initialization failure despite a successful
software PMU fallback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920065510.1536=
2-1-bramwelbarack89@gmail.com?part=3D1
