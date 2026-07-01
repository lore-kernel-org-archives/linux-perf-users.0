Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00D367F5E
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878188; cv=none; b=q5r0o8tp1jMR39lpGl9JjpFK2ummS412jHUofl0hLosoPp3fYCx+PvAGOc6wxlQvbKJNnvCiUHKCMEpMKCTf4P2jI/QQ/19K45OZTLKJX03jA4owbCG4uE7ooBAxpb9fdGssbcclOLmJf8Mdz/Bb5Pj6M4D/8O7N1D9E1wfRUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878188; c=relaxed/simple;
	bh=DdU3S2Z9gsBeeBVMGqn/cJtNRxaZA5GJoRi+ChGRA3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q7T8cBBc7MqssEyuIakPgz3+iPoq1SDfphny7JJD9v64GDhaCDxey1XZ/lMkUol64xkIVszwRII/Hrb6idCH3DlT68Rc5FVrC+MSZH+VJuTwcg6Y/leo/gnae9j9cdEyErfSHkjWvFIr+6hlXWE+qG2xuSxPk7A43MCdGIR7M+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohN7Oqnm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohN7Oqnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026621F000E9;
	Wed,  1 Jul 2026 03:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878185;
	bh=l+NWSbBuxLgMhJ+8S4osXHiuDMofSGrGqbd6N5rGsdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohN7OqnmxVpD2EXO5DM6Ip9bDDlAoocf+k9mqyHFgZBkDGsB/VP7RPi8KD2r8vrsV
	 ao2tZrvP6uWV/t2vES/zaYSGt2L28liWLfEHss8h1GnWTVJBvVtKLDAHRfWybKtrHG
	 iKD0V+wLZNQ5BewYFjrSSYGufogselVN31uo767yDXyZfAzNohZSKNtQI6FPEbp7BF
	 wbFMmpNDqNorlD4nEzb9R2TeTw3hJnjGXNW6bokpmzCvFhUv9tKoWeBjzaF8vR8nFU
	 PBpuex7QgKGHanDHp9F8GUnxzxEjiVZvhFrPLfxsXNXVeoOFIuEj+P6D7vXqRKohqg
	 VOppLSrNJxdpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf/x86/amd/uncore: Add Hygon uncore PMU support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Liu" <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701034413.718872-4-liuqi@hygon.cn>
References: <20260701034413.718872-1-liuqi@hygon.cn>
 <20260701034413.718872-4-liuqi@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 03:56:24 +0000
Message-Id: <20260701035625.026621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inconsistency between sysfs format attribute and event mask for =
unknown/future models (> 0x18) in the DF IOD PMU.
--

commit 7e45f23af16ead4a16cb506a64d18f3c1ad13f46
Author: Qi Liu <liuqi@hygon.cn>

perf/x86/amd/uncore: Add Hygon uncore PMU support

Add uncore PMU support for Hygon processors based on the
shared AMD-family uncore framework.

> diff --git a/arch/x86/events/amd/hygon_uncore.c b/arch/x86/events/amd/hyg=
on_uncore.c
> new file mode 100644
> index 0000000000000..7758a1dda21ae
> --- /dev/null
> +++ b/arch/x86/events/amd/hygon_uncore.c

[ ... ]

> +static u64 hygon_uncore_df_event_mask(void)
> +{
> +	if (boot_cpu_data.x86_model =3D=3D 0x4 ||
> +	    boot_cpu_data.x86_model =3D=3D 0x5)
> +		return HYGON_F18H_M4H_RAW_EVENT_MASK_DF;
> +
> +	if (boot_cpu_data.x86_model >=3D 0x6 &&
> +	    boot_cpu_data.x86_model <=3D 0x18)
> +		return HYGON_F18H_M6H_RAW_EVENT_MASK_DF;
> +
> +	return HYGON_F18H_RAW_EVENT_MASK_DF;
> +}

[ ... ]

> +static struct attribute *hygon_uncore_df_iod_format_attr[] =3D {
> +	&format_attr_event.attr,
> +	&format_attr_umask10.attr,
> +	&format_attr_constid.attr,
> +	&format_attr_iod.attr,
> +	NULL,
> +};

[ ... ]

> +static int hygon_uncore_df_iod_ctx_init(struct uncore_common *uncore,
> +					unsigned int cpu)
> +{

[ ... ]

> +	pmu->msr_base =3D MSR_HYGON_F18H_DF_IOD_CTL;
> +	pmu->rdpmc_base =3D -1;
> +	pmu->group =3D uncore_common_ctx_gid(uncore, cpu);
> +	pmu->private =3D uncore;
> +
> +	if (boot_cpu_data.x86_model >=3D 0x6 &&
> +	    boot_cpu_data.x86_model <=3D 0x18)
> +		hygon_uncore_df_iod_format_attr[1] =3D &format_attr_umask12.attr;

[Severity: Medium]
For unknown or future CPU models (where x86_model > 0x18), this initializat=
ion
leaves the DF IOD format attribute as the default 10-bit umask
(format_attr_umask10.attr).

However, hygon_uncore_df_event_mask() above falls back to returning the 8-b=
it
mask HYGON_F18H_RAW_EVENT_MASK_DF for these models.

Will this inconsistency cause userspace to believe a 10-bit umask is suppor=
ted
via sysfs, while the PMU driver silently truncates the top 2 bits when appl=
ying
the hardware mask in hygon_uncore_df_event_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701034413.7188=
72-1-liuqi@hygon.cn?part=3D3
