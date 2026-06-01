Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F113DA5D2
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326788; cv=none; b=XrXpsGVslKJkjuRJ3/uH4SEh3q1c2yiVUMnUJLUWp7caKSDMkRzst72IskpbReKCDREcxIjY9yZiD3y4WDsueMvgViOPoOOenPgNkJjZph8nsXNMBoSkxreiwqcCej5fgE+J4rgDBrbmnj/A0qvhOqb+9ZQR6tYtVF4Fk3ZsQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326788; c=relaxed/simple;
	bh=zXJ/7Rw8CQ9ZNSa84+mX4EbblIjz9wtHpmDdCs6iGi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DOB6MxC0W930LlCGmgp1U/Iy23chHK/1GmLfWvxsLpwOxUcAD23Cuqvh29qr+VFZCeNki+fDofapXBiFT4YUYySb79eUNhkH23viGmSA1iynkMYCKC9pNUw0F8pgRQSoUbdj4yEsWiIq9Sj/sTTItuWklgByGDZbMFcIjaGAawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8c5sfTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8c5sfTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A631F00893;
	Mon,  1 Jun 2026 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326785;
	bh=7EvhoUe0H4XSQFi4sXnSmY/7Gx5NbUG2hToZHCvG34E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H8c5sfTyZLfJhZqQO1CuS+3h/iiLiyZztkPMbszW1hjMdJDI5OBXIT/+ChVLld256
	 LxIt/RtLQzgEz+3c1Kx8mgD0ax5gVrzkEWbLceWJBFdK2t9bRTvxyv3uCLtl3fsaas
	 AKKg9txfYRVFs+GtihWJDGnkadN4MCWMNqIlxogEuh4KQLEpYz5hWHqCyPP7MCVxPs
	 GwTtWpNcov0PozVHMPcQuomNnmieYqhhshN2V75OsGZIdZJKCAjZm8J9cCog6Cld/t
	 /Bnol/oSN2NSQu1C+XJhZFmfJGK8E0VoYOhZ8UlCDt0PwasRHg6o005KtT/y6Yc/WU
	 bVpV7FemTpVcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/core: Always use the NMI latency
 mitigation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <29a3c970da289ab8f24282933bdb36545c0403e8.1780325517.git.sandipan.das@amd.com>
References: <29a3c970da289ab8f24282933bdb36545c0403e8.1780325517.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 15:13:04 +0000
Message-Id: <20260601151305.33A631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized `perf_nmi_tstamp` combined with `INITIAL_JIFFIES` ca=
uses the AMD PMU to silently swallow unhandled NMIs during the first ~5 min=
utes of system uptime on 32-bit x86.
--

commit 71c3691b558a0c49eaeaca25067c0e97960a98e6
Author: Sandipan Das <sandipan.das@amd.com>

perf/x86/amd/core: Always use the NMI latency mitigation

This commit unconditionally enables the NMI latency mitigation by setting up
the perf_nmi_window during initialization. Previously, this was restricted
to processors with X86_FEATURE_PERFCTR_CORE.

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 44656d2fb5550..ec0b74b9da4fa 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1412,12 +1412,12 @@ static int __init amd_core_pmu_init(void)
>  	u64 even_ctr_mask =3D 0ULL;
>  	int i;
> =20
> -	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> -		return 0;
> -
>  	/* Avoid calculating the value each time in the NMI handler */
>  	perf_nmi_window =3D msecs_to_jiffies(100);

[Severity: High]
This is a pre-existing issue, but does enabling this mitigation globally
expose 32-bit systems without PERFCTR_CORE to swallowed NMIs during
early boot?

The per-CPU variable perf_nmi_tstamp is zero-initialized:

arch/x86/events/amd/core.c:
    static DEFINE_PER_CPU(unsigned long, perf_nmi_tstamp);

On 32-bit x86, jiffies starts at INITIAL_JIFFIES (a large positive 32-bit
integer like -300 * HZ). If an unhandled NMI occurs before any PMU event
sets perf_nmi_tstamp, amd_pmu_adjust_nmi_window() checks:

arch/x86/events/amd/core.c:amd_pmu_adjust_nmi_window() {
    ...
    if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
        return NMI_DONE;

    return NMI_HANDLED;
}

Due to 32-bit modulo arithmetic, time_after(INITIAL_JIFFIES, 0) evaluates
to false for the first ~5 minutes of uptime.

Could this cause the AMD PMU NMI handler to incorrectly return NMI_HANDLED
instead of NMI_DONE, silently dropping external hardware watchdog and PCI
error NMIs until jiffies wraps past 0?

> =20
> +	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> +		return 0;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/29a3c970da289ab8f24=
282933bdb36545c0403e8.1780325517.git.sandipan.das@amd.com?part=3D1
