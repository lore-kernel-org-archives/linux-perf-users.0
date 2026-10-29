Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793250538;
	b=FWw6qL+TQn3M4Odc+k8/yoC7/ezQYiBHiXYgzD9TDAkAqM8FmeMN2+bVLW05kcQX4P2t
	 fJFO6+q0t3OhT3ftCqmTEfDLTLTcr79iPSqJQg0Jk9TCAnRFYtDwPyczOU4z9wV617XY2
	 JZe/MKt8KH4HLt3pzit/2I2YeA1sX7twUEjlBWrZRFiDrdtecS3WUznP646Fz+7B2LMG3
	 jp5WwrnLNhYLKkoJ0dUCKmhF2X9Ah7sWPDoHFAbM1mHoC4Q17XtsaEakkqSvjQyYovDlP
	 EEhNLTPaykygAeHhBlpYPnXcD8EVPrwMRputtM8VCADtVBGOIWK7qheOyP1UTYySCSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793250538;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4UYXLnaKFzSQTERwJCQg2GbTAiaoEZmzusk6n2ms8us=;
	b=2EDBhh6i85NIZ3VXIrdG+eJH5i88HoqZiX3lEXC6xtAX9hpbXBxA7t4gjXhYOVDwZiAM
	 Vp1Vxm/lh9R+Rcil29lb+6t7yx7lxahQo8CzFPvGZexlrV5JvXiJaotmctbJBcugwi4ua
	 /kcScuRX0MSuzZJjKhg03RVOIkxPwn0vnOKw4GIdZANndYhrBeJzhl8qFWmWRplRF7EE4
	 zsSvH5DDKUaTVhUuparV/6vHeH7+tUk1R6jqUqozooROLasvmQxDjkOND9QcP684XXMIB
	 TV7jd6Ds7OkZxUsu2mXj1frioanTl7pEOi990W2d9xhNm3Q1TYo6z2Ju6slxZvAzAzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FJRJ/hho";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D5606A31A;
	Thu, 29 Oct 2026 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJRJ/hho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1305F1F01825;
	Thu, 29 Oct 2026 05:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793250537;
	bh=4UYXLnaKFzSQTERwJCQg2GbTAiaoEZmzusk6n2ms8us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJRJ/hhow7aJRDWlFX3KoJkWQaF+lJksSPCVlNY9eJM/pJEECQwE6QakKsbmo+pDq
	 U5oEaZ11g6lDqplPxGwTkh//K0WUm7IZwnwom2rJfQugv12ANQPjox0/NWFM+zdLLt
	 fdpBOCpLJt26O9Z6EG5QTJoWg3Yt6F20lqnDn4plgp8742wpwjj+QKOl33Tef16COp
	 9kznPs8c6F7pc5P/7Q/rud9om6apCrU1/PLV8N8c0YFreKfYHQxlqb+ZZU6iTIA4if
	 Sl8fiQ+8QqsymubnrOAo9j3f+kDRMPXtaKACtmX7HKifKzcpzkvuQdn6kF0EoKG05Z
	 d37IPL0D6Cb9A==
Message-ID: <sashiko-outbox-188730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v5 06/18] perf/x86/amd: Avoid re-enabling PMU and LBR
 for BPF when disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261029043914.1395147-7-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:08:56 +0000
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
- [Medium] perf/x86/amd: amd_pmu_v2_snapshot_branch_stack() leaves cpuc->en=
abled set while PMU is disabled
--

commit cb298524c7ea53df65b77e5a09ad097e570397f6
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled

This commit updates amd_pmu_v2_snapshot_branch_stack() to save the current
PMU and LBR enabled state and only re-enable them after taking the LBR
snapshot if they were originally enabled. This avoids unconditionally
re-enabling the PMU and LBR when called from a PMI context where they were
already disabled.

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index bf631f60757cc..851d8a938f522 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -932,22 +932,28 @@ static int amd_pmu_v2_snapshot_branch_stack(struct =
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
> +	if (lbr_enabled)
> +		amd_pmu_lbr_enable_all();
> +	if (pmu_enabled)
> +		amd_pmu_core_enable_all();

[Severity: Medium]
Should amd_pmu_v2_snapshot_branch_stack() in arch/x86/events/amd/core.c also
clear cpuc->enabled =3D 0 while the core PMU is disabled, and restore
cpuc->enabled =3D pmu_enabled before re-enabling it?

While __amd_pmu_lbr_disable() sets cpuc->lbr_enabled =3D 0 and
amd_pmu_lbr_enable_all() sets cpuc->lbr_enabled =3D 1, amd_pmu_core_disable=
_all()
only clears the hardware MSR and leaves cpuc->enabled set to 1.

If a BPF program running in non-NMI context (such as a kprobe, tracepoint, =
or
fentry/fexit hook) calls bpf_get_branch_snapshot() ->
amd_pmu_v2_snapshot_branch_stack() while cpuc->enabled is 1, local_irq_save=
()
masks normal interrupts but does not mask NMIs. If an NMI arrives while
amd_pmu_v2_snapshot_branch_stack() is in amd_pmu_lbr_read() or memcpy(),
perf_event_nmi_handler() -> amd_pmu_v2_handle_irq() will observe
cpuc->enabled =3D=3D 1:

arch/x86/events/amd/core.c:amd_pmu_v2_handle_irq() {
	pmu_enabled =3D cpuc->enabled;
	cpuc->enabled =3D 0;

	/* Stop counting but do not disable LBR */
	amd_pmu_core_disable_all();
	...
done:
	cpuc->enabled =3D pmu_enabled;

	/* Resume counting only if PMU is active */
	if (pmu_enabled)
		amd_pmu_core_enable_all();
}

Similarly, if a BPF program triggered inside an NMI calls
amd_pmu_v2_snapshot_branch_stack() re-entrantly during that window, it will
also see cpuc->enabled =3D=3D 1.

In both cases, wouldn't the NMI path call amd_pmu_core_enable_all() on exit
and prematurely re-enable hardware PMU counting before the outer
amd_pmu_v2_snapshot_branch_stack() has finished?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029043914.1395=
147-1-dapeng1.mi@linux.intel.com?part=3D6
