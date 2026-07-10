Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FA408001
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681357; cv=none; b=kn3WAxVZSKGCWUqMGGHitCW0nWR+oPxsKe3bLSwARjwYzhT8C2SQQ5S8L04eNq2/O+0VXHK4q8llDsc36yGwez78fcB66KOC2+oCWu3GHBlueaN9LcfoDEDV/AY1gDoUOwcMlqQzS/MAOorNlVuLfh8DvpbzTOm4TwgpJjQ07AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681357; c=relaxed/simple;
	bh=18P5r9d7OU0VGWUr5oWeIvsdP1xFGsECC7OqWskI47U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oCbE9kQIRavS5ZVpEEdEIEBWzWaDB6QqBkTc4sRjevwcvFieV+bFHOW3tAiUZzAGdmpgKB4YJXchDpsYtvR9+8LWM51IdhpIBVm9l6pzC/lkmcwY6jL7nPcTiOzmixO3c8pksJvjFZGDzZXvri0sWdx37E4CrPR3f6tYO5Gvi2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpeX4ypD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpeX4ypD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FD81F000E9;
	Fri, 10 Jul 2026 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783681356;
	bh=1RLolaa8pPfHkcp0P4cu5td+Kv7QI+JA07o0unLRFKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LpeX4ypD0+gibM/WXv7E60STt8vAj87JzRzIlA9xeFUwpSq51a0P7zVenvzD8n1AQ
	 dHnll0cVdRx1ui15oLfxvnUXlEeLp/drwXT3B94FXCANJgLZgzkFd0YKdiEWR8cr73
	 YT6I4SMBEHsq3B6JkxgxwNvofc8an9jik9VVZ7P8J80CYjWuPYJjaldTkyXRWwb+Gg
	 swjpso2WGM+qWGvLtE3XnbpNqS5gpzmP9kwvspbSaIbBSe6367xHdCiRneOul3AVzJ
	 VPZ2fSnV7bseERK6zKl6enNf1/3Zt/lquy6QKfhJYvV0VNNaETIiB8nZrrjXwtV4ZT
	 9GkU2+FoJYzrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/lbr: Fix kernel address leakage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a898a29725f6b2f30518354cdc2e432db66c43cf.1783680119.git.sandipan.das@amd.com>
References: <a898a29725f6b2f30518354cdc2e432db66c43cf.1783680119.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:02:34 +0000
Message-Id: <20260710110235.F3FD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AMD's Branch Record Sampling (BRS) software filter shares the exac=
t same logic flaw as AMD LBR V2, exposing kernel addresses when PERF_SAMPLE=
_BRANCH_USER is requested.
- [High] The Intel LBR software filter shares the same logic flaw, exposing=
 kernel addresses on Intel CPUs that rely on software filtering.
--

--- Patch [1]: [PATCH] perf/x86/amd/lbr: Fix kernel address leakage ---
commit f8aba9338ad1990ca06ee1ac10089bd82793534b
Author: Sandipan Das <sandipan.das@amd.com>

perf/x86/amd/lbr: Fix kernel address leakage

A user-only branch stack can contain branches that originate from the kerne=
l,
exposing kernel addresses to user space even when PERF_SAMPLE_BRANCH_USER
is requested. This commit extends software filtering on AMD processors
supporting X86_FEATURE_AMD_LBR_V2 to validate branch-from addresses against
the requested branch selection, dropping entries with kernel branch-from
addresses.

> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index d24da377df776..b9722e60d8bc7 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -125,7 +125,8 @@ static void amd_pmu_lbr_filter(void)
>  		}
> =20
>  		/* If type does not correspond, then discard */
> -		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
> +		if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type ||
> +		    (!(br_sel & X86_BR_KERNEL) && kernel_ip(cpuc->lbr_entries[i].from)=
)) {

[Severity: High]
This isn't a bug introduced by this patch, but does the AMD Branch Record
Sampling (BRS) software filter share this exact same logic flaw?

Looking at arch/x86/events/amd/brs.c:amd_brs_match_plm():

        if (!(type & plm_k) && kernel_ip(to))
                return false;

The software privilege filter evaluates only the target address (to) but
fails to validate the source address (from). When amd_brs_drain() reads
the unfiltered kernel 'from' address:

        rdmsrq(brs_from(brs_idx), from);

Could this allow kernel-to-user transitions to pass and leak kernel address=
es
when PERF_SAMPLE_BRANCH_USER is requested?


[Severity: High]
This is also a pre-existing issue not introduced by this patch, but does the
Intel LBR software filter have the same vulnerability?

Looking at arch/x86/events/intel/lbr.c:intel_pmu_lbr_filter():

        to_plm =3D kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
        type =3D arch_lbr_br_type_map[type] | to_plm;

The branch type's privilege level is determined exclusively by the target
address (to), ignoring the source address (from). When it checks the type
later in the same function:

        if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
                cpuc->lbr_entries[i].from =3D 0;
                compress =3D true;
        }

It seems this would also fail to filter out kernel-to-user branches when
PERF_SAMPLE_BRANCH_USER is requested. Should similar software filtering
be applied there to validate the branch-from addresses?

>  			cpuc->lbr_entries[i].from =3D 0;	/* mark invalid */
>  			compress =3D true;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a898a29725f6b2f3051=
8354cdc2e432db66c43cf.1783680119.git.sandipan.das@amd.com?part=3D1
