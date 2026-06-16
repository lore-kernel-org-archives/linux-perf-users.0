Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CE3C9EDF
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 05:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586235; cv=none; b=c6OJ9g0f7s8Wz9cImwdjVbFZYVmJ3TCnYZn3qvzd1pOgrAXKXvjZu+0kj27jW0/VRi4zHHUoh/Q6aTVou2Xw/+qOaAmkmV9Aau16TRkus5v8p8w/m7KYOJ2yqCLx1abrGa8PhBCNnyUg2ZT2QXj8HcHp6LLzrq+c3zE3MxFJHXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586235; c=relaxed/simple;
	bh=lV8B/lQJ0YzOcCD+2I8I0NLuIB0N0Y9JbeGiWlwu3Fg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FYiwinW9qT1rAx8vgm5EXa6V0MyY3kS0izsiPIa4tIQcsKr852m23iEVudLyR15Kp7gf+H1kwGyeKZ4uuqcJ9chC2PZVTuezxEdRlYm8CeLrfr33oAIrfFWSq5ji/tFNTUtMcP+V7wC+ynlejVdd1LbXZwltID07x9ZeNt0IYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6wWCGaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6wWCGaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31FA1F000E9;
	Tue, 16 Jun 2026 05:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781586234;
	bh=8BTBR0sVCK3rsOiLqjEpgVPvpbKc37aZgqu3ZmE2eOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b6wWCGaMsag9jJlLI8rJMjUUCvErygF2lXxIUXZjSKDLvqlvbq3KFlK05HbqVt/oU
	 9f1SzRzuqd0sacX8RS+hyM61HmW2Y8Satp1TgtvaO8pT33rEyyGM4hE4AsZfM/D9P9
	 KNsZmp5gLWBGyLlXiYkoSQ3L4g1btYBKRTtfofChiFV7fyTme4SkM+vxCoCdSZopym
	 GBVgzzu+4UO1D/djmrZrmIW7eAV/iY79V4ZIItt5gxIegkBwS3JXkJIcUhyQa3zviq
	 Rq2ZjwcdKETFxNv8MAtBUWxFNyD+hZNPo+9nUta3EziKcZkjEH90hFXwGR6jWsZJV1
	 GgNCQyRhRi9iw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v4 4/8] perf/x86/intel: Fix kernel address leakages in
 LBR stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616044654.3468742-5-dapeng1.mi@linux.intel.com>
References: <20260616044654.3468742-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:03:53 +0000
Message-Id: <20260616050353.E31FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The kernel address leak fixed in Intel LBR is also present in the =
AMD LBR and AMD BRS implementations.
--

commit 6e58211ef4792cdee63b678a385b927eb7214af9
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Fix kernel address leakages in LBR stack

This commit fixes an information leak in Intel LBR where the software filter
failed to validate the from address. By validating both the from and to
addresses against the requested privilege mask, it prevents kernel addresses
from leaking into user-only branch stacks.

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
This isn't a bug introduced by this patch, but does the same kernel address
leak exist in the AMD LBR and BRS implementations?

Looking at arch/x86/events/amd/lbr.c, the software filter sets the branch
privilege strictly based on the target address. Kernel-to-user branches mig=
ht
bypass the filter and leak the kernel from address:

arch/x86/events/amd/lbr.c:amd_pmu_lbr_filter() {
    ...
    type =3D branch_type_fused(from, to, 0, &offset);

    /* If type does not correspond, then discard */
    if (type =3D=3D X86_BR_NONE || (br_sel & type) !=3D type) {
    ...
}

Similarly, in arch/x86/events/amd/brs.c, the privilege filter only evaluates
the target address against the requested privilege mask:

arch/x86/events/amd/brs.c:amd_brs_match_plm() {
    ...
    if (!(type & plm_k) && kernel_ip(to))
        return 0;

    if (!(type & plm_u) && !kernel_ip(to))
        return 0;

    return 1;
}

Because the hardware PMU natively records branches going from kernel space =
to
user space, could unprivileged users requesting user-only branches still
sample kernel addresses on AMD through these paths?

>  			cpuc->lbr_entries[i].from =3D 0;
>  			compress =3D true;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616044654.3468=
742-1-dapeng1.mi@linux.intel.com?part=3D4
