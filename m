Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760485;
	b=qxuGSi+kxuOb/cdMmEVeqUx70q69oeWnYbr8ndMt2fuaPdDnv03QmvvAZeUwYFKXARCH
	 FmAcqjTjYxhqIFDM7NtwFqytnmABFarZISOxr/O5FMeBKUe3axLP5Y96OnGR1n9Si9iRs
	 62tLRPqpWf9BiJEkyH+7k7k6HzQ2zMbfKQuNbzDn+/+2PZ9hTTeGZ8WBJCWQoi6TSliSv
	 9yc44/LCA+Tk882fa5PURk6dsfxLmKEjBO/Tyqxq5rDt0F82KnNOEW9DFcVgpOyGureo/
	 M47w/FgbpKij8D27B1S4OF7P2Hu9qRuVOJbCLW1Cy1pPiGvoxXQCwHW99e9UOUEPvVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760485;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=82EwstHdQu4Y/+4bP7xZIud9S7A6tPap9VkmQiAPPjw=;
	b=Pg42ETrG5qrHrxYcGvhhl6VRzfMHxTIjJ+sg9e1Y9YEr4HdFtV8Y6vSqZIWs8tkELjv0
	 6V4vmxyJXbKNlrEh3LL+y7mCFChXmp3DxnSaaLs+vCflASAJ/PDCJFbsieLAeSM1jRZS9
	 ejoF53KWWGvDw29IWXJt8yZzXNEvRoW1IHd0/kc8EhFqQvI6A6eEYEzNJ84CwvXY2+BlJ
	 38paDTusnsggFRllYWcpFQQs3535eHXNY8wS6iMfq9+fZql2bh0D4WW4O12Q70jghSYcb
	 jp7gg5lBRliDz7K4bB4LuV6jo8DE5yECZ197gxWIgUAAGIUDuTSC7NvWN1f+QueymJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gaULv49K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7E606A31B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gaULv49K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7E31F01825;
	Fri, 23 Oct 2026 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760485;
	bh=82EwstHdQu4Y/+4bP7xZIud9S7A6tPap9VkmQiAPPjw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gaULv49KVvIMAz0EUgYEO78fEIZPFCrfIutoI/0szpNyDtulxF44dQrQqBogFnay1
	 svp0N1yZGFMOb/e1xj0J8ikqoGZ+whtDRp8WlAKjm7X5MNF8mr4ug48/9WThyoV8vd
	 CV0yM19hx44N4/t6G3VcSvIBTIC3kXAQc4GzheuSNdsOR57JjzqkGBusfFcoeV1lNu
	 imACCI2gfLp3tHv2P8ia5tQVAtwzErol1M90C2bpz1Bnq28DO06qQoXRuvfp/wOH8n
	 DmjxKL4bVNWG6V+J0MwHrfR8cYwbrK6y6WpnCZmMrcER5nvcVxQrEpuNPE3h5jpZXg
	 NnWMHPngyf/FA==
Message-ID: <sashiko-outbox-182810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261023124157.75524-1-puranjay@kernel.org>
References: <20261023124157.75524-1-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 13:01:24 +0000
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
- [Medium] perf/x86/amd/lbr: cleared lbr_select in amd_pmu_lbr_del() forces=
 PMI freeze
--

commit 2fc471183ee73ff1339b34a8c3b4d4e03264c10b
Author: Puranjay Mohan <puranjay@kernel.org>

perf/x86/amd/lbr: Freeze LBR on PMI only when kernel branches are recorded

This commit skips setting DEBUGCTLMSR_FREEZE_LBRS_ON_PMI on CPUs with
X86_FEATURE_AMD_LBR_PMC_FREEZE when LBR_SELECT suppresses branches into the
kernel.

> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index a55646fcb8465..7ec50380ac81d 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_con=
text *pmu_ctx,
>  void amd_pmu_lbr_enable_all(void)
>  {
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> -	u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> +	u64 lbr_select =3D 0, dbg_ctl, dbg_extn_cfg;
> =20
>  	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>  		return;
> @@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
> =20
>  	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>  		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> -		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
> +		/* Freeze unless the filter suppresses branches into the kernel */
> +		if (lbr_select & LBR_KERNEL)
> +			dbg_ctl &=3D ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +		else
> +			dbg_ctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> +		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>  	}

[Severity: Medium]
Can DEBUGCTLMSR_FREEZE_LBRS_ON_PMI still be set for user-only branch-stack
events when more than one branch-stack event is scheduled on the same CPU?

When two user-only branch-stack events are added via amd_pmu_lbr_add(),
cpuc->lbr_users is incremented to 2 and cpuc->lbr_select is set to 1.

If one of those events is subsequently removed or scheduled out via
x86_pmu_del() -> amd_pmu_del_event() -> amd_pmu_lbr_del(), cpuc->lbr_select
is unconditionally cleared even though another branch-stack event remains
active:

arch/x86/events/amd/lbr.c:amd_pmu_lbr_del() {
	if (!x86_pmu.lbr_nr)
		return;

	if (has_branch_stack(event))
		cpuc->lbr_select =3D 0;

	cpuc->lbr_users--;
}

When amd_pmu_lbr_enable_all() then runs with cpuc->lbr_users =3D=3D 1 and
cpuc->lbr_select =3D=3D 0:

	if (cpuc->lbr_select) {
		lbr_select =3D cpuc->lbr_sel->config & LBR_SELECT_MASK;
		wrmsrq(MSR_AMD64_LBR_SELECT, lbr_select);
	}

the if (cpuc->lbr_select) block is skipped, leaving the local lbr_select at
0 (and also leaving MSR_AMD64_LBR_SELECT zeroed after a context switch calls
amd_pmu_lbr_sched_task() -> amd_pmu_lbr_reset()).

Wouldn't (lbr_select & LBR_KERNEL) then evaluate to false and re-enable
DEBUGCTLMSR_FREEZE_LBRS_ON_PMI despite the remaining active event
suppressing kernel branches?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023124157.7552=
4-1-puranjay@kernel.org?part=3D1
