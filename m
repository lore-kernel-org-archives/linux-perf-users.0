Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973413;
	b=G9s1ryx7slZttHrhdjuCjnr0giY34AobJ6AQK6LrFQyYxP7IXoO6enqZ9y6upKglsA9Y
	 /oOUyH4KAOMprImWsCqbEfx7uv7VYG/3oZ3q9Nn8nfIsrObJkMAWkYa9b9Dr4QQEACm0/
	 1c+bYoOMKLT0tDHwU66NLciB61v9ig/20xZ1S7wpqEAKJJDtZgCy1dOq+cSK4Nm9rK4bm
	 xah/lE0wOD6UAbRa/OXrEnf+H5re5SRNA3/KgVQ3rCeS3bVzrU529eJVRwI7vINjgqPvl
	 Ct5rCcaHAU+blTR2e2ZEqGwdghQuzWPclrHkz5c82ymPwk28njZJ5xfpIkcja0PcyJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+p5MlAGzvw71fdo0AWFOJilWn1c85StymLp8MpQlwaQ=;
	b=j+zinWmg6u4xzAAd7JHJmcaiEF5mKJQM6girFRBn8SNTmDwBN2wc9KrO7tBThWMy8suH
	 ZiFSE/iOaGVQ92Ub5yXxy/H8uHiElPeXq6s/bjQkj6Ovg6PM33R9XC9zjYIxeGlTtgm4m
	 3iJf7eqF+qHiHsp5dj82YkaSmjhCnEgOZoaSUxOAA+0s2Ji+DTN2hJDHyvE3CvI0oHznU
	 oWyU2FxJGYyjKCXaV+D/bcBOgvDO7I/5quzGdLhAfWQp4tFTruSCWT4Yd9D/EIfP2Jkn9
	 VVPtF0MjAE7CcWy28/1zc+YEYY46KM4XNPoHLeWtXeRJKERnxaN9Is9ZnsNqnwjlXTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5364VZS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3FF606A31C;
	Wed, 18 Nov 2026 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5364VZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B791F000C4;
	Wed, 18 Nov 2026 03:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973413;
	bh=+p5MlAGzvw71fdo0AWFOJilWn1c85StymLp8MpQlwaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5364VZSxLNMpLMVDd8LvQvQ49CxoEoQkOAiWs5+k1YzxCDoR6WFX/TgC+h3JAAs6
	 hCIe7SFGee0C7cAhN9z3T+KS0dxfxPk6eGBWVJhBvvHlG+WI36iPqZeI2XT9ikVlZa
	 SFSoqROvBCK+u6TufnzLvZJodeE7adru1tclWBHFMw04gBhT8ojSI+aViNBI8doYJ7
	 yaNzjd1KQRhiTfPyauCn7iGvWjbMcj7efXaw/4C+IBnSMQw4lrk3rA+Z7XnRxpWYwd
	 mKOLIG5+YU/qpQlu9ZP2XEGvYhW0KeX5Ji155eS16fMnSsG1enlcYWavhBik2iZida
	 5rc7Fv5KV+uSQ==
Message-ID: <sashiko-outbox-220035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 06/24] perf/x86/amd: Avoid re-enabling PMU and LBR
 for BPF when disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261118031453.1353625-7-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:43:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf/x86/amd: PMU enabled before LBR in
  amd_pmu_v2_snapshot_branch_stack()
--

commit 496e4315c6fe26a4c320a0d5de1185d312c47c38
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled

This commit saves the enabled states of the core PMU and LBR in
amd_pmu_v2_snapshot_branch_stack() and only restores them if they were
enabled before the snapshot was taken.

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index bf631f60757cc..dd0e24f26c6b0 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -932,22 +932,31 @@ static int amd_pmu_v2_snapshot_branch_stack(struct =
perf_branch_entry *entries, u
>  {
>  	struct cpu_hw_events *cpuc;
>  	unsigned long flags;
> +	int pmu_enabled;
> +	int lbr_enabled;
> =20
>  	/*
>  	 * The sequence of steps to freeze LBR should be completely inlined
>  	 * and contain no branches to minimize contamination of LBR snapshot
>  	 */
>  	local_irq_save(flags);
> +	cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +	pmu_enabled =3D cpuc->enabled;
> +	lbr_enabled =3D cpuc->lbr_enabled;
> +	cpuc->enabled =3D 0;
>  	amd_pmu_core_disable_all();
>  	__amd_pmu_lbr_disable();
> =20
> -	cpuc =3D this_cpu_ptr(&cpu_hw_events);
> -
>  	amd_pmu_lbr_read();
>  	cnt =3D min(cnt, cpuc->lbr_stack.nr);
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * c=
nt);
> =20
> -	amd_pmu_v2_enable_all(0);
> +	if (pmu_enabled) {
> +		cpuc->enabled =3D 1;
> +		amd_pmu_core_enable_all();
> +	}
> +	if (lbr_enabled)
> +		amd_pmu_lbr_enable_all();

[Severity: Low]
Should amd_pmu_lbr_enable_all() run before amd_pmu_core_enable_all(),
matching amd_pmu_v2_enable_all()?

Calling amd_pmu_core_enable_all() first restarts the hardware PMCs while
amd_pmu_lbr_enable_all() is still reprogramming the LBR MSRs, so the PMCs
count the MSR accesses in amd_pmu_lbr_enable_all() and can overflow before
DEBUGCTLMSR_FREEZE_LBRS_ON_PMI and DBG_EXTN_CFG_LBRV2EN are restored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D6
