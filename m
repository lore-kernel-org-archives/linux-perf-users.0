Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537F305673
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048996; cv=none; b=jeyGYZccT0bBGI1QuB356euvX/6b3jxYypBfDZv0arVxOgssMOcWDOUHM6NfIa2Xo6Refaa/Q54j01dsViA6NEZFr++5uVmhuh49585F+nEaCYwcVXzlScrJl0Qd2QgJj0b/D924xnywCQMLIJWdSRVEbV6n8exjgcjB5SYVqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048996; c=relaxed/simple;
	bh=/LEWtHbWBH5/LwfuW5YqhpN6i6JD8Vd0Pdm0RRdEOHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bHx3uBZO4z1Slxz5xlcnS0JdSSBkIhatrGMrutE+ma6/VaHWIY+He57RKyNHs5dsCiadbnIxcSBGUEaseET2TuBIk0OlNkkW+Za7pma/abpH2p/zNAEgDWN4WOkCGs0mujsTnYNTLSmdiS0ynxMciA+1zB1POZ1DeOW2hEGN9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSoTCo55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSoTCo55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB601F00893;
	Fri, 29 May 2026 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780048995;
	bh=+RqjGx1bCD0xw7ekFXD74MU59A2puU28UssjhNz9K0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BSoTCo55gxCSHcd/z9wIsMguDHirQWuqYwhH2etATbnN+XjydbjoIruByEPLeU6VX
	 Ng76fUltI7zDSpF608SMalKj6tzKPp7zsI0kBTFuWwOiRT648+2zayIbF3UojRU02o
	 0LQbAetigo9QUxZO7Z71Z8zJYq/rNWWqdkPK23f7/ruxFlNXill+JoRJ+Op58OMjKX
	 ySojN7bJkK5om1oW7remJAqDMRUcjO+oUcWZMP/VCJV6T1n17G3OcRiKFAQTqAen7R
	 2p0lAfOmNcXVd04i6C4HA8kjofV1563k5v6s33/aSg2PB4f086eaYTCyRkg7fMZK3L
	 OGpdjnFqPb2jA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 19/23] perf/x86: Support SSP sampling using
 sample_regs_* fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-20-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-20-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 10:03:14 +0000
Message-Id: <20260529100314.8AB601F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The uAPI header addition for PERF_REG_X86_SSP is not synchronize=
d with the perf tool's copy, and the perf tool lacks support for formatting=
 or synthesizing the new register.
--

commit b3c69baea8c8d8c919d96ea56a7caf694d17f469
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Support SSP sampling using sample_regs_* fields

This patch supports sampling of the CET SSP register via the sample_regs_*
fields by using spare space reclaimed from the XMM space. It updates the
register extraction logic and enables arch-PEBS-based SSP sampling on
x86_64.

> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uap=
i/asm/perf_regs.h
> index 8774a1290fbef..31a025cb9dbaf 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h

[ ... ]

> @@ -51,10 +51,11 @@ enum perf_event_x86_regs {
>  	PERF_REG_X86_R29,
>  	PERF_REG_X86_R30,
>  	PERF_REG_X86_R31,
> +	PERF_REG_X86_SSP,

[Severity: Medium]
Should the corresponding UAPI header for the perf tool in
tools/arch/x86/include/uapi/asm/perf_regs.h be updated in sync with this
change?

Also, does the perf tool require additional updates to support this new
register? Without adding a string representation mapping for SSP, the
tool might not be able to parse '--user-regs=3Dssp' or print the register
name.

Furthermore, tools/perf/util/intel-pt.c relies on PERF_REG_X86_64_MAX
and a hardcoded pebs_gp_regs array that does not currently include SSP.
Will this cause the SSP register to be silently dropped from synthesized
PT PEBS samples?

>  	/* These are the limits for the GPRs. */
>  	PERF_REG_X86_32_MAX =3D PERF_REG_X86_GS + 1,
>  	PERF_REG_X86_64_MAX =3D PERF_REG_X86_R15 + 1,
> -	PERF_REG_MISC_MAX =3D PERF_REG_X86_R31 + 1,
> +	PERF_REG_MISC_MAX =3D PERF_REG_X86_SSP + 1,
> =20
>  	/* These all need two bits set because they are 128bit */
>  	PERF_REG_X86_XMM0  =3D 32,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D19
