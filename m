Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C6F34F474
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044678; cv=none; b=b/AxTdWaCrGn1hhHKtRFdmur4DUZMR6XBrfXMwW3kjpHmvbrgW/IfomomfbxQhgYHFkvPnqeadtsdelk2SuupjyKqee6vZuSCv9NgFyS3/F3xL6aN3vcbCsiImJ7QT/PvHWDpJvzRpwRy+mnZ7X8lAYUmJHUxgDZgm/lrgXMvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044678; c=relaxed/simple;
	bh=NxS/44ldv1XOMrG5vJscVcE02pS8sTDxeKVO8s+usVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJ9UYO7TONa8HpYXZnReU1z88pEOm9Zh8ix0UG9gcHeiN3Q6PYmQnf6UQMNxv3zMuLBqfenaAEFKrHcc5TcFKk2md4VKjUSE4B25ZL2ZwiqJhw8MlpD4DI3ae+fes/Lw4L4Q8jJPwmcE0hOFMWo3Crt9ekiFoyGfAHKfeBaSxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h70nyZmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h70nyZmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92351F0089D;
	Fri, 29 May 2026 08:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044676;
	bh=zpdG2gUYbuyUSQ4yeG/XWT/E2Utz4IRdC3pt66mSHIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h70nyZmxSuud9kZgcScNYeJkdVycTTyIM3QutCcNBciUm/70btX/nsOejv9N4DMva
	 JC+kBWCrDD96H5fNai+DX5dyIKv9WsQtztkqZCS4xgPv/3niLaIm/eZqpvRFsX0xPP
	 GJtDpsGZb1CYrRW1QlabTZWXz2YIoqZPquMaSXaHLTkh3XLH11U698sS6kMdXCQhYR
	 VN3zDlBi0Tv0NyRwwQh6d8f1cyGDzTjVfh5/MQPSokv1A3XlpPFY7IYIJEaDvfh6wT
	 hRP8qGhjajKb+tFQZVV18LJP65uljAmn4NREgz+a/gWPbFQcr803AaPbvLOo6+z3Io
	 3cJ316xXcyCwg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 02/23] perf/x86: Move hybrid PMU initialization
 before x86_pmu_starting_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-3-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:51:15 +0000
Message-Id: <20260529085116.A92351F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free in `intel_pmu_cpu_dead()` triggered during error ro=
llback if `perf_pmu_register()` fails.
--

commit a6b6c338247bf2e5f630f8fc0cce5709a4fbe801
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()

This patch moves the default hybrid PMU structure initialization before
calling x86_pmu_starting_cpu(). This change prevents key fields like
capabilities from being inadvertently overwritten during initialization.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 4b9e105309c6a..17e122e27e0b7 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
[ ... ]
> @@ -2195,8 +2195,20 @@ static int __init init_hw_perf_events(void)
> =20
>  	pmu.attr_update =3D x86_pmu.attr_update;
> =20
> -	if (!is_hybrid())
> +	if (!is_hybrid()) {
>  		x86_pmu_show_pmu_cap(NULL);
> +	} else {
> +		int i;
> +
> +		/*
> +		 * Init default ops.
> +		 * Must be called before registering x86_pmu_starting_cpu(),
> +		 * otherwise some key PMU fields, e.g., capabilities
> +		 * initialized in x86_pmu_starting_cpu(), would be overwritten.
> +		 */
> +		for (i =3D 0; i < x86_pmu.num_hybrid_pmus; i++)
> +			x86_pmu.hybrid_pmu[i].pmu =3D pmu;

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
during error rollback.

During init_hw_perf_events(), the CPU hotplug states are set up and
x86_pmu_starting_cpu() sets cpuc->pmu to point to elements within the
dynamically allocated x86_pmu.hybrid_pmu array.

If the subsequent perf_pmu_register() loop fails, the error path frees the
x86_pmu.hybrid_pmu array via kfree() and jumps to out2 to unregister the
CPU hotplug states:

    if (i < x86_pmu.num_hybrid_pmus) {
        ...
        kfree(x86_pmu.hybrid_pmu);
        ...
        goto out2;
    }
    ...
    out:
        cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);

Tearing down the CPUHP_PERF_X86_PREPARE state triggers x86_pmu_dead_cpu(),
which eventually calls intel_pmu_cpu_dead().

Could tearing down CPUHP_PERF_X86_PREPARE evaluate the dangling cpuc->pmu
pointer in intel_pmu_cpu_dead(), causing cpumask_clear_cpu() to write to
the array that was just freed?

> +	}
> =20
>  	if (!x86_pmu.read)
>  		x86_pmu.read =3D _x86_pmu_read;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D2
