Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E419E992
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982490; cv=none; b=tvPieJu6FzUfmth+h8B/IvKzu+ppj1Mcb8X/5iY3gwLxNHnVgSB9FUox00entYsBA7tuqlPu6xwFCd/MD6cKNcEbNVwlxba7ynf1l8xrOjhwDRW2NQ3oaV6h5F3yqQQw7lLDRbyoQP3+SAUmqiBwEXOjsX+voaEAY4X27G7K8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982490; c=relaxed/simple;
	bh=AuQhExcAdLT5L2ig4vqV84RSpi2qZkvm8wKQTmDAVC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ii6ZWiYUh8+TsoCFOD4eb81j19RnfAHPUYIpGMCKRYkqy0ADu3XP2zpKMpzBh1cxbtb68xAviUOTi8TB+ff9ALwBbH7PVhJFcF1T5u0oWBsO1hDuvxXXPDTR2er/PfUZ1aDyynd6E14JGqWeyINcxhrIE42k++/Dtuz56X2zFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNIqoOW8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNIqoOW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811C51F00893;
	Tue,  9 Jun 2026 05:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780982488;
	bh=NOs5F7TctIcmEYWP7j8tl9Fxi5pOzjLSDGCvSOM06XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNIqoOW8232G2E4j2cndwmirfjhGJYTYjczV7SsnaP7oZs+sW0okeUW7hnfzMnGLy
	 1zhhHs2DLRlppMcaO9bx01SGehzv1cGou/FxiOPSez/2FRm77G6MeTA/NGZwZN3bD3
	 byoJvhd//MKwm9QtfFe0CEObDUgLxdNpgR7SdqHyLB5/ELipH9dboOsnmQuR47rcV5
	 egOSh7a5DtR51P9PXIs30xaLJc5F9LpNh2JF2w6UTpbf+Ma/eGuBut6NriSEnzz8Q1
	 eYpD6t7MMU6WtiHBRfwXgsx1hQ+maOoHVSdUIdOrrxZSqkRUklPhBI8owY591m6SOL
	 VpILQHCIlIwkg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 5/9] perf/x86/intel: Drop LBR entries whose privilege
 level mismatches br_sel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609050222.2458129-6-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:21:27 +0000
Message-Id: <20260609052128.811C51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The kernel address leak in LBR stacks fixed here for Intel PMUs st=
ill exists in AMD PMUs (both AMD LBR and AMD BRS), allowing KASLR bypass.
--

commit 955fb4f61b3305a8e4972ee94bb41e752a3dd25c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Drop LBR entries whose privilege level mismatches br_sel

This commit fixes an issue where kernel branch addresses could be exposed
to user space in user-only branch stacks. It extends the software filter
in intel_pmu_lbr_filter() to validate both the from and to addresses
against the requested branch privilege filter.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 171fdf1962ade..9a63209cc7878 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c

[ ... ]

> @@ -1246,8 +1246,16 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  				type |=3D X86_BR_NO_TX;
>  		}
> =20
> -		/* if type does not correspond, then discard */
> -		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
> +		from_plm =3D kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
> +		/*
> +		 * If type does not correspond, then discard.
> +		 * Especially filter out the entries whose from or to address is
> +		 * a kernel address while only X86_BR_USER is set. This prevents
> +		 * kernel address from being leaked into a user-space-only LBR stack.
> +		 */
> +		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type ||
> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL)) ||
> +		    (!(br_sel & X86_BR_USER) && (from_plm & X86_BR_USER))) {
>  			cpuc->lbr_entries[i].from =3D 0;
>  			compress =3D true;
>  		}

[Severity: High]
This is a pre-existing issue, but does the AMD PMU code suffer from this
same vulnerability?

Looking at the AMD LBR software filter, it appears to only check the
target privilege level and is missing the from_plm privilege validation:

arch/x86/events/amd/lbr.c:amd_pmu_lbr_filter() {
    ...
    /* If type does not correspond, then discard */
    if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
        cpuc->lbr_entries[i].from =3D 0;  /* mark invalid */
    ...
}

Similarly, the AMD BRS filter explicitly only validates the to address
and ignores the from address:

arch/x86/events/amd/brs.c:amd_brs_match_plm() {
    ...
    if (!(type & plm_k) && kernel_ip(to))
        return 0;

    if (!(type & plm_u) && !kernel_ip(to))
        return 0;

    return 1;
}

Could kernel addresses from kernel-to-user branches leak into user-space
LBR stacks on AMD systems through these paths, bypassing KASLR in the
same way?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609050222.2458=
129-1-dapeng1.mi@linux.intel.com?part=3D5
