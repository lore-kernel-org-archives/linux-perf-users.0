Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495603D0921
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623218; cv=none; b=nm6tR3P8w1i/yG9YNVDsak5jHfLwVE2qo5I2NW4KOItfyDsrSqB5KJoobzW+agL4wbw6pigjN13kOioQvwPD3f5A1cj4ItUKb1era7h6kMF8ezbQojvyNdSn9RN/+XPH9p5gXGdjGh6aeeIQ0X8OjPkQZfGXSh+n1ceeklOuj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623218; c=relaxed/simple;
	bh=W8DIfAl/NuoYmAH83+/VO9Fh5Tpf9ufJn/B60sJYWSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJ7JxS9cL60/QlA0Wha9WjhNXcSxqHEsk3JZduqw6/MK8+vJs39soc2aAGUCwB2PsC9WCkiO+jIBBzm1HMm52tppIkzCviBQ0dOHF2juqEHPHER8TVMcWvfEgh4ZPDRYhgEE6iVXtvcgr9sxnOUd79x9hmNqqfevvdlkeJ65XDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBn56IjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBn56IjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D661F00893;
	Fri,  5 Jun 2026 01:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780623208;
	bh=EIYbZluwH+MJX9zB1/tb9zXx7Gky8PysPg8pi5woJCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBn56IjX38SFX/LMztqSfzUQNMvdIcxPkimBpW+OO5y2Rq9Z3EWsvrL1hvVIduC3e
	 HMDXDvpr9C/vnIBnCQodsKDtNb7hKhGI+K/cdeiUCfpQc43nVECODXQ+ExGJNLKoOc
	 2fhQN6CMMAmqPcJpcw7HwjeGVH3YJrW9rC2uMjP+1F8ETMslqNQWk5+wW1U2/aYokU
	 AMAAF3XZ9YB0OyfwU/nUz8SO4Q9L2Q7RHctx0dD3Gliz74kYC/NLV+V707L96caje1
	 eUwSrWbVDPH1hFbqxGz8IABLNkKfbOcoiAfeOlehBZRJOWjTSIDyfUfWTElZOBk5dD
	 SA5hsV52YB5oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf/x86/intel: Fix kernel address leakages in LBR
 stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605011136.2043393-6-dapeng1.mi@linux.intel.com>
References: <20260605011136.2043393-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 01:33:28 +0000
Message-Id: <20260605013328.86D661F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The exact same kernel address leak (KASLR bypass) vulnerability ex=
ists in the AMD LBR software filter (`amd_pmu_lbr_filter`), but the patch o=
nly fixes the Intel implementation.
- [High] On Arch LBR CPUs that do not support hardware branch type decoding=
, the software filter incorrectly classifies all branches as conditional ju=
mps (JCC).
- [Medium] The software filter fails to drop branches executing in user spa=
ce (e.g., SYSCALL) when only kernel branches are requested, diverging from =
hardware filter behavior.
--

commit e5f3b8c6179b0acb53df2e9f20348cf3b8f5a8be
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Fix kernel address leakages in LBR stack

This commit fixes a kernel address leakage in the LBR stack on Intel
platforms prior to arch-LBR. It extends the software filtering in
intel_pmu_lbr_filter() to check the "from" address privilege level,
preventing kernel addresses from leaking to user space.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 16977e4c6f8a5..deef81c16571a 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1212,7 +1212,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  {
>  	u64 from, to;
>  	int br_sel =3D cpuc->br_sel;
> -	int i, j, type, to_plm;
> +	int i, j, type, to_plm, from_plm;
>  	bool compress =3D false;
> =20
>  	/* if sampling all branches, then nothing to filter */

[Severity: High]
This is a pre-existing issue, but does this function correctly handle Arch
LBR CPUs that do not support hardware branch type decoding?

If an Arch LBR CPU does not support hardware branch type decoding
(LBR_INFO.BR_TYPE), the x86_lbr_type static key remains false and
get_lbr_br_type() returns 0.

Earlier in intel_pmu_lbr_filter(), the code checks:

    if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
        type <=3D ARCH_LBR_BR_TYPE_KNOWN_MAX) {

Since 0 <=3D 5 is always true, it maps arch_lbr_br_type_map[0] to X86_BR_JC=
C,
bypassing the software decoding fallback in branch_type().

Does this force all logged branches to be treated as conditional jumps on
these processors, destroying branch filtering accuracy?

[ ... ]

> @@ -1244,8 +1244,15 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  				type |=3D X86_BR_NO_TX;
>  		}
> =20
> -		/* if type does not correspond, then discard */
> -		if ((type & ~X86_BR_PLM) =3D=3D X86_BR_NONE || (br_sel & type) !=3D ty=
pe) {
> +		from_plm =3D kernel_ip(from) ? X86_BR_KERNEL : X86_BR_USER;
> +		/*
> +		 * If type does not correspond, then discard.
> +		 * Especially filter out the entries whose from or to address
> +		 * is a kernel address while only X86_BR_USER is set. This prevents
> +		 * kernel address from being leaked into a user-space-only LBR stack.
> +		 */
> +		if ((type & ~X86_BR_PLM) =3D=3D X86_BR_NONE || (br_sel & type) !=3D ty=
pe ||
> +		    (!(br_sel & X86_BR_KERNEL) && (from_plm & X86_BR_KERNEL))) {

[Severity: Medium]
This is a pre-existing issue, but does this logic miss the symmetric check
for scrubbing user-to-kernel branches from kernel-only samples?

If a user requests only kernel branches (X86_BR_USER is not set), a SYSCALL
(which goes from user to kernel) will be retained because the hardware
filters based on destination CPL (kernel) and the software filter sees a
valid to_plm.

Should there be a check like:

    (!(br_sel & X86_BR_USER) && (from_plm & X86_BR_USER))

to prevent user-space addresses from polluting kernel-only branch traces?


[Severity: High]
This isn't a bug introduced by this patch, but does the exact same KASLR
bypass vulnerability exist in the AMD LBR software filter?

AMD's software filter in arch/x86/events/amd/lbr.c:amd_pmu_lbr_filter()
uses branch_type_fused(), which only factors in the destination privilege
level.

When a user requests only user-space branches (PERF_SAMPLE_BRANCH_USER),
hardware can still record kernel-to-user branches (like SYSRET) because
the destination is in user space.

Since the AMD filter evaluates (br_sel & type) =3D=3D type as true based on=
ly
on the destination, it keeps the branch, exposing the kernel "from" address
to unprivileged userspace.

Should a similar fix be applied to amd_pmu_lbr_filter()?

>  			cpuc->lbr_entries[i].from =3D 0;
>  			compress =3D true;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605011136.2043=
393-1-dapeng1.mi@linux.intel.com?part=3D5
