Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FD2253FC
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776135240; cv=none; b=hqjtYzI9UkgYt+6c+Q8IGtzYM8cZrgaArr0MWt926JS55q5CBczwseAY5qmF9f4a4DBdzxHnuaHbLbLR5DQ9piUUfdbw1x8PeEsy4K78P8ZFmlmzDgaKP9QlkdEOYbzVC1B7ZadS3v1MeBQb/N5bXO5ATAA5Xt3JxAPiwzVg8CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776135240; c=relaxed/simple;
	bh=hGjODFAFWtzSSuvBPdPR17eMg959BI19uMYMg9kao1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I3P9bRpvu8Nidxnw41us9tzeOekyUlbCMe9X0sLA2UxMN8a2ws4OxOeo+FplBYSassSpaHTBs7VxzIaxkynDdlbwmRaadaLdyqgREvh1r9PvZNuv+1YqhiiutrK2vvEqEGDxMZ0j1JD4UyM4VIxLRCwO/FSUJe+XAKw5KlF5m0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxIJhJX8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxIJhJX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F0FC2BCAF;
	Tue, 14 Apr 2026 02:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776135240;
	bh=hGjODFAFWtzSSuvBPdPR17eMg959BI19uMYMg9kao1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hxIJhJX8fFqd7iXyb7TaKdt9bh0XYrL4/sHJfl1CKq0Pd8Y6tmfC1y9TtgEIX5KqS
	 V3KUdTzdAecfFE8ks5ZLwQeN3YeQI/133/+07nsOSPM5+hihX8dRu/XnMhkxeYGGMQ
	 GhTLuFFLjFEFrAkVe+lhsQgnivRHDH/LnwVcNAiI/BmPo3ryOZzyeu7zkqWLLjPSen
	 h8suM+5WIvmvIhHNoUZuqXSceVJ1mMl0i5sLHj7AFLX/H9sQFafAFm1QxXktx9ajZk
	 PY350aCGp9gICMH5ALjFiLKv/mmOzdRiWaKbD/q4caZPv8KhCH1yb/8IToyJMuxjHF
	 Z25Hit6rQJQfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix redundant branch type check in
 intel_pmu_lbr_filter()
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414021440.928068-1-dapeng1.mi@linux.intel.com>
References: <20260414021440.928068-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 02:53:59 +0000
Message-Id: <20260414025359.E9F0FC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Meaningful code and commit message mismatch due to a false premi=
se
--

commit 98c2839085a2b609f94d9f3f338217d29525fd08
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Fix redundant branch type check in intel_pmu_lbr_filter()

This commit modifies the branch filter logic to mask out privilege level
bits before checking if a branch type is X86_BR_NONE.

> In intel_pmu_lbr_filter(), the 'type' variable is bitwise ORed with
> 'to_plm' (which contains X86_BR_USER and/or X86_BR_KERNEL bits). Because
> of this, 'type' can never equal X86_BR_NONE (0) after the assignment.
>=20
> As a result, the subsequent check 'if (type =3D=3D X86_BR_NONE)' is dead =
code
> and the entries with X86_BR_NONE type would not be skipped eventually.

Is this description entirely accurate?=20

Looking at intel_pmu_lbr_filter(), the bitwise OR with to_plm only happens
in the X86_FEATURE_ARCH_LBR path:

intel_pmu_lbr_filter() {
    ...
    if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
        type <=3D ARCH_LBR_BR_TYPE_KNOWN_MAX) {
        to_plm =3D kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
        type =3D arch_lbr_br_type_map[type] | to_plm;
    } else
        type =3D branch_type(from, to, cpuc->lbr_entries[i].abort);
    ...
}

In the software fallback path, type is assigned the result of branch_type().
If branch_type() cannot decode the branch and returns X86_BR_NONE (0),
wouldn't type evaluate to exactly X86_BR_NONE without any to_plm bits set?

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 72f2adcda7c68..16977e4c6f8a5 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1245,7 +1245,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  		}
> =20
>  		/* if type does not correspond, then discard */
> -		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
> +		if ((type & ~X86_BR_PLM) =3D=3D X86_BR_NONE || (br_sel & type) !=3D ty=
pe) {

While masking out ~X86_BR_PLM doesn't appear to break the software fallback
behavior since (0 & ~X86_BR_PLM) =3D=3D 0, the original check for X86_BR_NO=
NE
appears to have been functional and necessary for that path.

Could the commit message be updated to clarify that the check was not actua=
lly
dead code for the software fallback path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414021440.9280=
68-1-dapeng1.mi@linux.intel.com?part=3D1
