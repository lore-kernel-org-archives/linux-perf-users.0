Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423532;
	b=3GLPMOBwPOJPtgbz/k7fuwxsbKdMgBk+n2bRWq5ILcfFtuqnioXPn99NvFdjrMfEEv7t
	 Yb30AyDSexecJBUULgDllw+ohtw1lM5jP7WZSxBuOVX/3BQTqxvnF9JweYc6AIOMjj4NJ
	 UirguXSjJPy2wlp16nPyLF1KpqSvZTOUZdkh2Jd6YWDm70uYkE7yyzIpodUwQx8VhyD5u
	 gxAQlSpd93tALn/Mm/oaQmM3HfZk2XgorVBK4HcxE12ZjFGsw/MX8nS2DYuLviJa4qw0P
	 LrcjGvPDZLUminZMMMMDO2/SuTk7CQz3Gj1XNB5G6F/0kptM4hERw969imqa73TE+Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423532;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u42YwYD4WN7MfD4Wa8fcG+850zCIboeTcTRkBWOE6ko=;
	b=4xSeIwBNQx2UT83kSioJ+oVQjIhQNFbFKDI8D3k9JOOR2RdQr4E4G4rwp3NLeHN29U+V
	 nXejiDVQ3shdQCEojKpAWX85qB+ArPuKPV5AMGd3/hhBcVl+z9TE8OJma+bBkphSodATj
	 binPxRo/dChk2rQ5FzudBIZEeDZbibYbxmVqfYPicomWlmMsWYg05FP0GTckTj9G6gN6Q
	 HghIEPsE3sc1471b54sjdRv8+FFtrdNSqhIt1WZpSjXiwQFmCa0uBVhAjhk1hvR3reezk
	 sbv2tPaglYSfTG3b65xbjH7ihHZ7pL6iZ8lo8FI/XkCFlr0VgGlXczY2b4RkDu75INg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXE9hIAn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955860B0991
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXE9hIAn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684D51F000C4;
	Mon, 19 Oct 2026 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423531;
	bh=u42YwYD4WN7MfD4Wa8fcG+850zCIboeTcTRkBWOE6ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXE9hIAn+GGB7AocbZO7WLQIbnxYZv9LsO9XAo2a6nr+Oec7MQ7rUU7pLISTqW2/f
	 4TpbkE78mzweynfIQI8eqRTqyER6Cv54ikS8+ZDk3IG8IxjILPXRr1p2hFXlTwkl6D
	 LXqrIvsY7sRb/5zkamBvF1RpDopLqWuAxDHJuALReOqIxTI1hhAwSjLm07H5bPgUKw
	 rCarhQR2LI/PLjxQBbb8KL4ghKyPEmDrIRcTG/VcpkaeHyuL8ROJLLR99Wgsb/Qx30
	 CoZo2qwRYICA6br/xBHLy342oC9Kuw22W4B6a8i3DghhQbsb4TuUuAFPuHJiYup3Kk
	 DK+NpBW7XmNmA==
Message-ID: <sashiko-outbox-177718@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] perf/x86/intel: Fallback to sw branch
 type decoding if no hw decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019135441.1420968-463-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-463-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:25:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/x86/intel: X86_BR_TYPE_SAVE forced in intel_pmu_setup_hw_lb=
r_filter()
--

commit c34c39f861fe5e2bf440b3a3e6e92d35016fb9be
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Fallback to sw branch type decoding if no hw decoding

This commit updates intel_pmu_lbr_filter() to check the x86_lbr_type static
branch instead of X86_FEATURE_ARCH_LBR, falling back to software branch-type
decoding when hardware branch-type decoding is unavailable on arch-LBR CPUs.

Link: https://patch.msgid.link/20260616044654.3468742-4-dapeng1.mi@linux.in=
tel.com

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 7aa59966e7c3e..896aeaac9e6a4 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1230,7 +1230,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  		 * Doesn't support OTHER_BRANCH decoding for now.
>  		 * OTHER_BRANCH branch type still rely on software decoding.
>  		 */
> -		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
> +		if (static_branch_likely(&x86_lbr_type) &&
>  		    type <=3D ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>  			to_plm =3D kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>  			type =3D arch_lbr_br_type_map[type] | to_plm;

[Severity: Medium]
Should intel_pmu_setup_hw_lbr_filter() also be updated to check
static_branch_likely(&x86_lbr_type) before forcing X86_BR_TYPE_SAVE?

Currently, intel_pmu_setup_hw_lbr_filter() checks X86_FEATURE_ARCH_LBR and
unconditionally enables X86_BR_TYPE_SAVE under the assumption that hardware
provides branch types without software disassembly:

arch/x86/events/intel/lbr.c:intel_pmu_setup_hw_lbr_filter() {
	...
	if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
		reg->config =3D mask;

		/*
		 * The Arch LBR HW can retrieve the common branch types
		 * from the LBR_INFO. It doesn't require the high overhead
		 * SW disassemble.
		 * Enable the branch type by default for the Arch LBR.
		 */
		reg->reg |=3D X86_BR_TYPE_SAVE;
		return 0;
	}
	...
}

When an event is opened with PERF_SAMPLE_BRANCH_USER |
PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_ANY (without
PERF_SAMPLE_BRANCH_TYPE_SAVE) on an arch-LBR CPU where x86_lbr_type is
disabled, forcing X86_BR_TYPE_SAVE into cpuc->br_sel causes
intel_pmu_lbr_filter() to bypass its fast-path return:

arch/x86/events/intel/lbr.c:intel_pmu_lbr_filter() {
	/* if sampling all branches, then nothing to filter */
	if (((br_sel & X86_BR_ALL) =3D=3D X86_BR_ALL) &&
	    ((br_sel & X86_BR_TYPE_SAVE) !=3D X86_BR_TYPE_SAVE))
		return;

With this change in intel_pmu_lbr_filter(), every LBR entry then falls back
to software disassembly via branch_type() in NMI context, and any entry whe=
re
branch_type() returns X86_BR_NONE (such as when copy_from_user_nmi() fails =
on
an unmapped user page) gets discarded even though the user asked to sample
all branches without branch-type saving:

		/* if type does not correspond, then discard */
		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
			cpuc->lbr_entries[i].from =3D 0;
			compress =3D true;
		}

Would it make sense to gate X86_BR_TYPE_SAVE in
intel_pmu_setup_hw_lbr_filter() on static_branch_likely(&x86_lbr_type) as
well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-463-sashal@kernel.org?part=3D1
