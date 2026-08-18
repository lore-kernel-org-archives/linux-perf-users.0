Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8A3BB4A
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048188; cv=none; b=hCWO9KoAAG5zZ1KdKdVHBMLMWHpvwfPvFAG4WBrzR78YcsqnQ/gwz7QJw5JiIuEtOe0ClV7Jwn0GjScc6PKHs7pgWbouRRrbBFXEycB+ogk3PKVku9EROMM/yUP5/0YwME5ti2Z99qtugCuv2JnnrVK/K6hR1ECx6eWMSlgIqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048188; c=relaxed/simple;
	bh=8z95LZVtKZh4AlU6MswD+QTLm3vRqtnYlyxJH5/wPrY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JU1us3xBb+Mx9hbxbMrlF0gikJwqV+Dayt4zUybSBIBi9h2c0guxoc1akrhejZL/nWHQuoaHZz8vyRfht39hcaQo3LZWtRagLxDbPkFFmLnCkecD3UeJHjn9srFKqxioIQJ3u2zfXu1LpjHcOVSZXVnLRrOSpfustv41YLSueUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0sQe+xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0sQe+xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5424B1F000E9;
	Tue, 18 Aug 2026 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787048187;
	bh=bFA9D6ZHPx5NiXtGBUrTMfPPmuxhDy2MmGTndgrAIi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b0sQe+xcNzXhZTWs0e77A+G1XjQcyneaaUQR+tIvjKO8sOer1tHRndOOzcXruGFOo
	 taaQaNAHT17f5FBWtg10JIAWBtrwvFMIO8rajAUlMXKdVKAxV3ZtF1bBw5nwN5yI+N
	 wM4WlMEF9YABPWhIuzfmNfh5A9XN0/PsQe+CI3idcwF959rvAOEtD8yBVOvjl7mBNt
	 zEkBeMK0caWPlqbrGNLnrKtuE3rwFIvXLg4Dwaa9ISmcWZYNW/5uCCUB+UgHM4VJHU
	 Q/F2o1u98fHw6VXr1C7aKLeUyGuaAh7dpmxskjfp6eG9YmhfKXGj0lQCRUe/vNHzwW
	 Ogyha8f68RaFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260818100118.12944-2-liuqi@hygon.cn>
References: <20260818100118.12944-1-liuqi@hygon.cn>
 <20260818100118.12944-2-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:16:26 +0000
Message-Id: <20260818101627.5424B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removal of Hygon L3 Uncore PMU support without a replacement in =
the new driver.
--

--- Patch [1]: [PATCH v5 1/2] perf/x86/amd/uncore: Add Hygon uncore PMU sup=
port ---
commit 1b6dd18387bea20f9f548951bf79cae006705b47
Author: Qi Liu <liuqi@hygon.cn>

perf/x86/amd/uncore: Add Hygon uncore PMU support

This commit introduces a separate uncore PMU driver for Hygon processors to
support Data Fabric (DF) and Data Fabric IO Die (DF_IOD) counters. It also
removes the Hygon vendor checks from the AMD uncore driver to keep the
vendor-specific features separated.

> diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hyg=
on_uncore.c
> new file mode 100644
> index 0000000000000..471955d6fc282
> --- /dev/null
> +++ b/arch/x86/events/amd/hygon_uncore.c

[ ... ]

> +static struct hygon_uncore uncores[HYGON_UNCORE_TYPE_MAX] =3D {
> +	/* HYGON DF */
> +	{
> +		.scan =3D hygon_uncore_df_ctx_scan,
> +		.init =3D hygon_uncore_df_ctx_init,
> +		.move =3D hygon_uncore_ctx_move,
> +		.free =3D hygon_uncore_ctx_free,
> +	},
> +	/* HYGON DF IOD */
> +	{
> +		.scan =3D hygon_uncore_df_iod_ctx_scan,
> +		.init =3D hygon_uncore_df_iod_ctx_init,
> +		.move =3D hygon_uncore_ctx_move,
> +		.free =3D hygon_uncore_ctx_free,
> +	}
> +};

[ ... ]

> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index dbc00b6dd69ee..6c486e1ab001a 100644
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
> =20
>  	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))

[Severity: Medium]
Does this inadvertently remove L3 uncore PMU support for Hygon systems?

Removing the Hygon vendor check in amd_uncore_init() prevents the AMD uncore
driver from initializing on Hygon CPUs, which previously provided L3 cache =
PMU
support.

Looking at the new driver in hygon_uncore.c, the uncores[] array only
implements the DF and DF_IOD components. It does not appear to provide a
replacement for the L3 cache PMU that was previously available.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818100118.1294=
4-1-liuqi@hygon.cn?part=3D1
