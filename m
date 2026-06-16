Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E33C8738
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 05:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586224; cv=none; b=RY8qxdSycOkysZfBCFGynMRP01sYWjR1TkcQr/hINwt9aKTWxiYH5jQYtDZfLHo6TP+YA9SQuEJzWPbJj1IYkjJMbWN0Jr2gLPW+fBDfgW1rWJ2kslqKpJDBFgjGKKxVJFeB7flnH+ojcXotzjogFmeGoND2zW+tCGQ7Lg0tLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586224; c=relaxed/simple;
	bh=010GdWB6CwR0bUkp2M4897Eibr4s+08g7Ev+8pc2QR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjdzLNcs8fjuoXNb54AlZxMeBQSKLg7MARnLPEMQvGqClDgNQf2CkaRsTUSt+frWgVBkpwS6i2ILND1nL9JIGHHlvT0RGtE9FjhOE45PsNyiwvkmRhGYBGVVY37VitxOmDheFLeNq7B7sfsrzREWqlIGTh5mNxH0cQ4T6KrU9vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwofqBaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwofqBaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8111F000E9;
	Tue, 16 Jun 2026 05:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781586223;
	bh=qyQl3as2Vw5xT7uIjB5KH1EI7q/rpwzeITrlnPfGKk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwofqBaY0aMo9r+bJDg9/+yn7jSOgUdUIYea7Z4bSJ18TDbvTJVpjNXNmd5xsOdhI
	 CWY6uLssKwTavTN+E236k2Ob3ukxTMRtAB4ZjvAjc8uoFrRSl5FO/0j+/An4ZsLcQ6
	 AK77UEqwzXkzEfoQy35xcepCwXNp/d9/VQ0iJTv7AGpxCnYd7IVr4U+saxA/kqjyk8
	 m4yebIsW2foTvevbwYKo/ddm1ueLmwCj4vMIhSzDSuR9CCwQxZc78DnpkWGpDgPRSA
	 p1nzoICiXRUr3bW6YgNYJMCxwoIm+3zQqJ2SH2vlMpjVsRr0xATYA0L+lPWfCIDBYO
	 pYGHvtW6LeJtQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 3/8] perf/x86/intel: Fallback to sw branch type
 decoding if no hw decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616044654.3468742-4-dapeng1.mi@linux.intel.com>
References: <20260616044654.3468742-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:03:42 +0000
Message-Id: <20260616050343.5D8111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Forcing `X86_BR_TYPE_SAVE` on Arch LBR CPUs without hardware branc=
h-type support causes massive NMI overhead due to an unconditional fallback=
 to software decoding.
--

commit f25e57aa8ef5b59fd749c6fcb24f34aa7668326f
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Fallback to sw branch type decoding if no hw decoding

This commit updates the arch-LBR filtering to fall back to software
branch-type decoding when the hardware feature is unavailable. This ensures
branch classification works correctly across different arch-LBR
configurations.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 72f2adcda7c68..e2657f791e507 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1231,7 +1231,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  		 * Doesn't support OTHER_BRANCH decoding for now.
>  		 * OTHER_BRANCH branch type still rely on software decoding.
>  		 */
> -		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
> +		if (static_branch_likely(&x86_lbr_type) &&

[Severity: High]
Does this change unintentionally cause a massive performance regression on
systems without hardware branch-type support?

In intel_pmu_setup_hw_lbr_filter(), X86_BR_TYPE_SAVE is always forced
for all Arch LBR CPUs:

arch/x86/events/intel/lbr.c:intel_pmu_setup_hw_lbr_filter() {
    ...
    if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
        reg->config =3D mask;
        ...
        reg->reg |=3D X86_BR_TYPE_SAVE;
        return 0;
    }
}

Because X86_BR_TYPE_SAVE is forced, the fast-path early exit in
intel_pmu_lbr_filter() is never taken:

arch/x86/events/intel/lbr.c:intel_pmu_lbr_filter() {
    ...
    if (((br_sel & X86_BR_ALL) =3D=3D X86_BR_ALL) &&
        ((br_sel & X86_BR_TYPE_SAVE) !=3D X86_BR_TYPE_SAVE))
        return;
    ...
}

With the fallback introduced by this patch, won't every sampled branch be
forced to undergo high-overhead software disassembly in the NMI context, ev=
en
when the user requested no specific branch type filtering?

Should intel_pmu_setup_hw_lbr_filter() be updated to conditionally force
X86_BR_TYPE_SAVE only if x86_lbr_type is actually enabled?

>  		    type <=3D ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>  			to_plm =3D kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>  			type =3D arch_lbr_br_type_map[type] | to_plm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616044654.3468=
742-1-dapeng1.mi@linux.intel.com?part=3D3
