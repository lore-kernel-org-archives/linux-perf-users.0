Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DF37CD52
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255927; cv=none; b=bNGuJf89diebrkGj7jxhqce1OrnFmxu/i73xq2kdNP458UXBOQ/eYu4dinNh0bIVB9CCsYhh63c1UTqAZyTshIC4/z3lK2yl92gXoxq/ZEybPphx/DPAPp6V/wM25ZH8YqZbvdONDmYX9huw0EboXGTvU4IditTdeNGh/vCDpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255927; c=relaxed/simple;
	bh=J/b41HhMgVcqameQW2fZvFtIVLF4NRkxGxrG4fZ+7pA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tsw1M5Svq9/A/hJonoEVMqXC4A7yAwyIyTkAvX+1mG2+IfXDFI+yKrjoUsyfPy0xKZ5V9zF3RpVszgw5xBfQ9U4tIqQ0nFNo0b+GsLWd2uzh5xoNjF3cnZl+Oai1bumHoDZeIhHlVdjqHHbtCzVYKCgTV9P3FB1WMh9aZ22Hp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOSeCEds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOSeCEds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8AB1F000E9;
	Fri, 12 Jun 2026 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781255922;
	bh=KQOxZZ82Fs3XQhK1PYfqPPFwqtZe/vzgCaW+6IhVnG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UOSeCEdsoZDDNjwhZbMpBClZSLnpN268iYyqxCfaBEh6FzSBmw7u1QtTQ7pEOVWZl
	 CepavIFo4Lf/ngoYnO2WxVmUXL0Lg7jRuib0Trm4mXEN5GQZykn/oPSjPPcXK/ACx1
	 O15vJ2GYJ/GxLHjlhMiJc2DpyNLtVx0SQxKV1/6QHUS2f12ua5lg+Ekc2AFExRIw5H
	 2GIlMUmS2DCVHoSLyWeBacNRZZmrvy3oxl7J2AYvs3cLMcswXBZzofyZaO/Yl1zQU/
	 BsTbFgrqh6R96I6lD7cEwti8hKgBWMylxR7ljac/V4qAw6V9Nr7OuCG8eq88NfOM3a
	 KOtCqyxycMrIg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 4/8] perf/x86/intel: Fix kernel address leakages in
 LBR stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612090114.3188886-5-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:18:41 +0000
Message-Id: <20260612091842.8E8AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing Privilege Escalation/Leakage Fix in AMD LBR
--

commit c04d9132d61b165193dd28c5a358e42d3c52a350
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Fix kernel address leakages in LBR stack

This commit fixes a kernel address leakage in the Intel LBR stack when
PERF_SAMPLE_BRANCH_USER is requested. The intel_pmu_lbr_filter function
previously only validated the privilege level of the "to" address, leaving
kernel "from" addresses exposed on SYSRET/ERET branches. The fix extends
software filtering to validate both addresses against the requested filter.

Cc: stable@vger.kernel.org
Reported-by: Ian Rogers <irogers@google.com>
Fixes: 47125db27e47 ("perf/x86/intel/lbr: Support Architectural LBR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index e2657f791e507..16eef15378166 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c

[ ... ]

> @@ -1244,8 +1244,14 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  				type |=3D X86_BR_NO_TX;
>  		}
> =20
> -		/* if type does not correspond, then discard */
> -		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
> +		from_plm =3D kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
> +		/*
> +		 * If type does not correspond, then discard.
> +		 * Specifically reject entries whose from address is in
> +		 * kernel space when only X86_BR_USER is requested.
> +		 */
> +		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type ||
> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {

[Severity: High]
This isn't a bug introduced by this patch, but does the exact same kernel
address leakage vulnerability exist in AMD's LBR implementation and remain
unpatched?

Looking at amd_pmu_lbr_filter() in arch/x86/events/amd/lbr.c, it relies on
branch_type_fused() to determine the branch type. For kernel-to-user branch=
es
(like SYSRET), it evaluates the privilege purely based on the target (to)
address and returns X86_BR_SYSRET | X86_BR_USER.

When user-only branches are requested, br_sel includes X86_BR_USER and
X86_BR_ANY. Because AMD hardware will record kernel-to-user branches when
filtering by "ending in CPL > 0", the check in amd_pmu_lbr_filter():

    if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
        cpuc->lbr_entries[i].from =3D 0;
        compress =3D true;
    }

evaluates to false since type is fully satisfied by br_sel. This allows the
branch to bypass the software filter and leaks the kernel from addresses to
unprivileged users.

Should a similar from_plm validation check be added to amd_pmu_lbr_filter()
to prevent KASLR bypass on AMD systems?

>  			cpuc->lbr_entries[i].from =3D 0;
>  			compress =3D true;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090114.3188=
886-1-dapeng1.mi@linux.intel.com?part=3D4
