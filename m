Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941579;
	b=0BxOzF385PMaalwUrKvw1nsYj2DH/eu9h+1N8R52SFuWLwMTGE4CvKlRwY4Mo9Rwuz8L
	 e4RQggamwgZKJEbOVx7kQNi6WX7WF7vqngT3cnFf1rP1Ieg6AcFqIDeLXIQWPkvddGOKv
	 09MgyiOSJ5hlKIDjQlCEVeN785xhwDQUNbeOYS0ydBXoNruFUtvGftRQ9f8TNUxmvoYA1
	 5/z6Ez5JWj/S6LFTkTcI+l63jbxHK3aBp/dtpbpqYg9PBIg3ltNiU88XOy0fiki1ReMel
	 AcIaq9Qvok54O9tdiTIibyyU/cjTeWU1G5Dc5TyHlSCNEOSqTldFZmVPq0CinLwM+Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941579;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=syS/C6YxFj39dUceNXQ+owql1MsmddolGQYRKyYlegs=;
	b=a+wkTEF/upkwI/2ZBUlpPDsjkIZ8ObBc5odgsybFWqUozh+AeDlRv+AZQtaX2rA+KmZN
	 e+IIYqzBEfUHlz82nYfTr4O4W+Cn8ZreamnFgXvSGEDlxUbv6VRoHS3/Wb6GvtFvSdFx+
	 skhFa1QJGY9FdH1y2iWKetSluSNMEN7hSbqq0amt4axMYEWnrRmAdRV9QngX93G0MDg2p
	 MZzh8T/3/eDZ92uvTEkuiERvjMKRD224JpZnY8h+rlKQphG0lJcVWBKDEFw4oKdTyawT/
	 xnO/otuLEzOQP1IV/g5921w0CbUzYfeIwWx3XGeZHezdJro7zl0EeynHGrDt7vam0ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TA+wib+7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7A606A31B;
	Fri,  6 Nov 2026 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TA+wib+7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D081F0089F;
	Fri,  6 Nov 2026 05:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793941579;
	bh=syS/C6YxFj39dUceNXQ+owql1MsmddolGQYRKyYlegs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TA+wib+7tOWtvKdusg7Io9rNXSeap419sz2mNChRxUv02b2Wl8LLv9fxxd2JbBnly
	 N12V3/CMCREcRxMYSZiWmtNSaULv0RxRAGUktinLJ5PW14bOPZ+qDfhnr923W180hg
	 nICZC8gyXcqeG7pMsivfDQMCpOA2EiFKDSTN8VEv909ftU7Gd5pDw3BDle3jQpv1GH
	 dacfbt7A4rpcggQuxvjr3JOofqVc0aU2iGYmKjuTS1Hwk5GoruvzDl8nmFbvLp8bvL
	 5b1c1EwvbL5djYggFsFohH+sbVy/xVC5nbUqNaK/fQODynw5akwFUAK4V2ELJTDZO3
	 GEzrjtHFIF06w==
Message-ID: <sashiko-outbox-200793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v6 08/20] perf/x86/intel: Avoid re-enabling PMU and LBR
 for BPF when disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261106043257.842864-9-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:06:18 +0000
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
- [Medium] perf/x86/intel: cpuc->enabled not cleared in intel_pmu_snapshot_=
branch_stack()
--

commit f8f32e2d56da9a93e561d91b6c3fb89e787c5d9e
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Avoid re-enabling PMU and LBR for BPF when disabled

This commit updates __intel_pmu_snapshot_branch_stack() and its callers
to save the PMU and LBR enabled state and only re-enable them after
taking a branch snapshot if they were originally enabled.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 9d8398da1989f..739c454827ac5 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2821,7 +2821,8 @@ static void intel_pmu_enable_all(int added)
> =20
>  static noinline int
>  __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
> -				  unsigned int cnt, unsigned long flags)
> +				  unsigned int cnt, unsigned long flags,
> +				  int pmu_enabled, int lbr_enabled)
>  {
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> =20
> @@ -2829,7 +2830,22 @@ __intel_pmu_snapshot_branch_stack(struct perf_bran=
ch_entry *entries,
>  	cnt =3D min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
> =20
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * c=
nt);
> -	intel_pmu_enable_all(0);
> +
> +	/*
> +	 * Do not blindly call intel_pmu_enable_all() to re-enable LBR.
> +	 * This path may be entered from the PMI handler through
> +	 * bpf_overflow_handler().
> +	 *
> +	 * If PMU version < 4, LBR is disabled by the LBR freeze mechanism,
> +	 * LBR can't be re-enabled here.
> +	 * If PMU version >=3D 4, LBR is only frozen instead of disabled,
> +	 * LBR should be re-enabled here.
> +	 */
> +	if (lbr_enabled)
> +		intel_pmu_lbr_enable_all(false);
> +	if (pmu_enabled)
> +		___intel_pmu_enable_all();
> +
>  	local_irq_restore(flags);
>  	return cnt;
>  }
> @@ -2837,27 +2853,41 @@ __intel_pmu_snapshot_branch_stack(struct perf_bra=
nch_entry *entries,
>  static int
>  intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsig=
ned int cnt)
>  {
> +	struct cpu_hw_events *cpuc;
>  	unsigned long flags;
> +	int pmu_enabled;
> +	int lbr_enabled;
> =20
>  	/* must not have branches... */
>  	local_irq_save(flags);
> +	cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +	pmu_enabled =3D cpuc->enabled;
> +	lbr_enabled =3D cpuc->lbr_enabled;
>  	__intel_pmu_disable_all(false); /* we don't care about BTS */
>  	__intel_pmu_lbr_disable();
>  	/*            ... until here */
> -	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
> +	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags,
> +						 pmu_enabled, lbr_enabled);
>  }
> =20
>  static int
>  intel_pmu_snapshot_arch_branch_stack(struct perf_branch_entry *entries, =
unsigned int cnt)
>  {
> +	struct cpu_hw_events *cpuc;
>  	unsigned long flags;
> +	int pmu_enabled;
> +	int lbr_enabled;
> =20
>  	/* must not have branches... */
>  	local_irq_save(flags);
> +	cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +	pmu_enabled =3D cpuc->enabled;
> +	lbr_enabled =3D cpuc->lbr_enabled;
>  	__intel_pmu_disable_all(false); /* we don't care about BTS */
>  	__intel_pmu_arch_lbr_disable();
>  	/*            ... until here */
> -	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags);
> +	return __intel_pmu_snapshot_branch_stack(entries, cnt, flags,
> +						 pmu_enabled, lbr_enabled);
>  }

[Severity: Medium]
Should intel_pmu_snapshot_branch_stack() and
intel_pmu_snapshot_arch_branch_stack() also clear cpuc->enabled =3D 0
before calling __intel_pmu_disable_all(false), and restore
cpuc->enabled =3D pmu_enabled in __intel_pmu_snapshot_branch_stack()?

While __intel_pmu_lbr_disable() and __intel_pmu_arch_lbr_disable() clear
cpuc->lbr_enabled =3D 0, __intel_pmu_disable_all(false) only writes 0 to
MSR_CORE_PERF_GLOBAL_CTRL without updating cpuc->enabled.

When bpf_get_branch_snapshot() is invoked outside PMI context (where
cpuc->enabled is 1), local_irq_save() does not mask NMIs. If an in-flight
PMI or another NMI arrives while __intel_pmu_snapshot_branch_stack() is
reading the LBRs, perf_event_nmi_handler() -> intel_pmu_handle_irq()
observes cpuc->enabled =3D=3D 1 and re-enables the PMU (and LBR on PMU
version < 4) before returning:

arch/x86/events/intel/core.c:intel_pmu_handle_irq() {
	pmu_enabled =3D cpuc->enabled;
	...
done:
	if (mid_ack)
		apic_write(APIC_LVTPC, APIC_DM_NMI);
	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
	cpuc->enabled =3D pmu_enabled;
	if (pmu_enabled)
		__intel_pmu_enable_all(true);
}

Similarly, a nested snapshot from an NMI or fentry/kprobe BPF program
during __intel_pmu_snapshot_branch_stack() would see cpuc->enabled =3D=3D 1
and prematurely call ___intel_pmu_enable_all() before the outer snapshot
finishes.

Setting cpuc->enabled =3D 0 is a plain store with no branches, so could it
be cleared alongside saving pmu_enabled and restored in
__intel_pmu_snapshot_branch_stack() to match x86_pmu_disable(),
__intel_pmu_quiesce(), and intel_pmu_handle_irq()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106043257.8428=
64-1-dapeng1.mi@linux.intel.com?part=3D8
