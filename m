Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4432B10B
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305097; cv=none; b=AVPWD0IDyZs2c32z/2YRWUC3rOXZwxnLYu2tKdH6WKa6SwvvsXcxvDIpK83N6TnjFLGfEAndWGBmMkCD9zUHm7ZDZYiTLDX1p4WM67cckOfMsByEvhuLXuBbPCbqejZdoQckxz7wZTvfHz7U4ZYmId0XDrcjRJpUp34dk7gOJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305097; c=relaxed/simple;
	bh=P5IL+cbqRZaYBXBY760h6T4ZiZLsLwwFQpp9gFCtDgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GAV1ugJFRJpuOW4u8Y2NLZZoy7sVsCrUA2nQqSN41vrLw1Cn6m3EugkVSbeIG9cbwJuoSLRskgyYQpioKr5qSWz3tv2w3TVY6J9IhdO4mMmbS8SxHkx86hJEkicI/2KS3LVSfCFex82ouI5F+TmeE2hqPSLuh3wd8PBq81tMWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKd95hvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKd95hvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D411F000E9;
	Mon,  6 Jul 2026 02:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783305096;
	bh=EKfpzyxADMxm3qxGGXckhiOvxalu9f1TsKBMUVsTy/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AKd95hvi3fw0kU1bZM+AuajIeaWGJXV6zHTEqoLodPDLYNOhFEMQRJz9WK+YPYLau
	 Qkp68GMieuWKoY0kzwHD/E4mqc6IAfnT2wp/Lr2rpNx17wliSw+hWEF3/b5aKOAQzs
	 WxgA3WcbOrjDOhxCOKqQpNj/xHjAJtVWkm/aF38VpinrTztXLoZmmRDPxRf5tGQA+d
	 ufr21uYH4xpmjodEHSCLPLsdd92+HDudg1FEHmDfjDbjciqCnELt0lk2iKHvg27bTF
	 b5UgKTEKD2KH3FLOEB9G+QTbSBmvzxwKFgupKLYehIOkdM6vg83L0pxKF2P6fX+bJl
	 pBH18HipLNFPA==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 06/24] perf/x86: Use x86_perf_regs in NMI handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-7-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:31:34 +0000
Message-Id: <20260706023135.63D411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent use of `x86_pebs_regs` and `x86_user_regs` per-CPU vari=
ables between NMI and IRQ-disabled contexts corrupts PEBS samples.
--

commit a90fb4d272f2182569ad5a2105f6b3f7c429263d
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Use x86_perf_regs in NMI handlers

Support for sampling additional register state in NMI context requires an
x86-specific register container. This switches x86 NMI handlers to use
the x86_perf_regs structure.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0888d3b0923e1..d83ea02e24577 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1788,9 +1788,11 @@ void perf_put_guest_lvtpc(void)
>  EXPORT_SYMBOL_FOR_KVM(perf_put_guest_lvtpc);
>  #endif /* CONFIG_PERF_GUEST_MEDIATED_PMU */
> =20
> +static DEFINE_PER_CPU(struct x86_perf_regs, x86_intr_regs);
>  static int
>  perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
>  {
> +	struct x86_perf_regs *x86_regs =3D this_cpu_ptr(&x86_intr_regs);
>  	u64 start_clock;
>  	u64 finish_clock;
>  	int ret;
> @@ -1814,7 +1816,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_=
regs *regs)
>  		return NMI_DONE;
> =20
>  	start_clock =3D sched_clock();
> -	ret =3D static_call(x86_pmu_handle_irq)(regs);
> +	x86_regs->regs =3D *regs;
> +	ret =3D static_call(x86_pmu_handle_irq)(&x86_regs->regs);

[Severity: High]
Is this call path safe from NMI reentrancy when accessing the per-CPU
variables introduced earlier in this series?

If intel_pmu_drain_pebs_buffer() is called from a non-NMI context (e.g.
intel_pmu_read_event() via the perf_event_read syscall) with local IRQs
disabled, NMIs can still fire.

If a hardware PMI fires during the execution of __intel_pmu_pebs_events(),
the CPU will jump here to perf_event_nmi_handler().

The NMI handler calls x86_pmu_handle_irq() -> handle_pmi_common(), which
also calls x86_pmu_drain_pebs(). Since the earlier patch in this series
"perf/x86/intel: Convert x86_perf_regs to per-cpu variables" replaced stack
allocations with shared per-CPU variables:

arch/x86/events/intel/ds.c:__intel_pmu_pebs_events() {
    ...
	struct x86_perf_regs *perf_regs =3D this_cpu_ptr(&x86_pebs_regs);
	struct pt_regs *regs =3D &perf_regs->regs;
    ...
}

And similarly for user regs:

arch/x86/events/core.c:x86_pmu_get_regs_user() {
    ...
	struct x86_perf_regs *x86_regs_user =3D this_cpu_ptr(&x86_user_regs);
    ...
}

Will the NMI handler overwrite the same per-CPU structures the interrupted
non-NMI context was actively using, leading to corrupted PEBS samples when
the original context resumes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D6
