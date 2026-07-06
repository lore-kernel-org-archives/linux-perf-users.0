Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D42E7383
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305357; cv=none; b=UI+2tr6w6CvmbPjCO8jUFlLoazapUpGOLocLDwHYqpkpdBbqF+2LBJlLxLrWSpZ4X6v9AZ35qNPCrwEJqpaDCG8N8hFww28AsfZQ1Zxh50D1INXZTqbsF8qu9a+HQENkesVwvKZeRnDE/8e9uLcCnK5GzN10nw9WxszMwPS3Wa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305357; c=relaxed/simple;
	bh=z5BW4L17cISTS1ZyHhx3dwv5e17GK1MHuDXVM1gNHLs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m4OutnAHsZHkb7k5eZZlfZ4AG57LZfU1tI4mAeD5CW25WM7Also/INMyJeRW7lEo3kMCcD+H/prIR0hsCr9c0AsTQR1Dlc+k+jLLlBy6IjweXTQKTvI6aisgP83NIMOoglIstsCJyaWJ/HkyN18p/68ay5TzLMXVEF1PDFuHLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/aeuSry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/aeuSry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939A71F000E9;
	Mon,  6 Jul 2026 02:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783305351;
	bh=NQr5TjulRUfGxUv2giUvBnCFKHIFRSxPjB2tmrjx7PU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/aeuSrydOwPsnThvCOJml/Ul6IUAiRMSNy3Rg7D/m07CZRQnfwO4qXyMMLX6qL1V
	 ZptPk3kKWwYyNuGRd7t/zup6yNaja6WH/y6GU6vvSzTEED1eAW1KkJUKgWPeg8ngth
	 CFDM2alREnuTDCNpC8JAjdRY8l3VfQaXjNyKf2nw4rJW1Nuzfuty89aZ9vmTrLDtbg
	 CEjAd9ClFm8fe7S+xSLhiQ04VyYb6/9Wz/zmp0Pn2/E/WdTLSVYnnEBFO8vDlYgYRd
	 8mzZMaybXn9sB+2kQEv/CRWxPJQ0oOiKAUE0HbzvTXKONrOtwOGZWSvC2fW0z5v3qW
	 8v+BEFqOUHSPQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 12/24] perf/x86: Enable XMM register sampling for
 REGS_USER case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-13-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:35:48 +0000
Message-Id: <20260706023550.939A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] For PEBS events, a delayed PMI NMI hitting in kernel mode causes R=
EGS_INTR to overwrite REGS_USER's XMM registers with the current hardware F=
PU state, leaking kernel FPU data.
- [High] PERF_SAMPLE_REGS_USER incorrectly samples Guest XMM registers pair=
ed with Host GPRs when a PMI hits during KVM guest execution, leaking guest=
 state to the host.
--

commit 74494b0320a832fddee80ea2906067a8bc2b32e0
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Enable XMM register sampling for REGS_USER case

This commit introduces support for XMM register sampling in the REGS_USER
case. It adds a per-CPU x86_user_regs to store REGS_USER-specific XMM
registers and a helper x86_pmu_update_user_xregs() to retrieve them either
from cached task FPU state or hardware registers.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 3e52610510cdc..0d42c51761f9d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c

[ ... ]

> @@ -1812,33 +1806,165 @@ static void x86_pmu_update_regs_intr(struct perf=
_event *event,

[ ... ]

> +static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *dat=
a,
> +					    struct pt_regs *regs,
> +					    u64 mask, u64 ignore_mask)
> +{
> +	struct x86_perf_regs *perf_regs;
> +	struct xregs_state *xsave;
> +	unsigned int guest_state;
> +	struct fpu *fpu;
> +	struct fpstate *fps;
> +	u64 user_mask =3D mask;
> +
> +	if (data->regs_user.abi =3D=3D PERF_SAMPLE_REGS_ABI_NONE)
> +		return 0;
> +
> +	/*
> +	 * If PEBS hits kernel space, need to re-sample extended
> +	 * registers for user space.
> +	 */
> +	if (user_mode(regs))
> +		user_mask &=3D ~ignore_mask;
> +
> +	if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {

[Severity: High]
Can this incorrectly sample Guest XMM registers paired with Host GPRs when
a PMI hits during KVM guest execution?

Since TIF_NEED_FPU_LOAD is cleared when KVM actively runs a guest, this
condition evaluates to false, bypassing the fpu->__task_fpstate memory
load.

If the guest is running in user mode, perf_guest_state() & PERF_GUEST_USER
will be true, causing this function to return user_mask. Consequently,
xsaves_nmi() will sample the live hardware FPU containing the guest's
registers instead of QEMU's.

> +		perf_regs =3D container_of(data->regs_user.regs,
> +				 struct x86_perf_regs, regs);
> +		fpu =3D x86_task_fpu(current);
> +		/*
> +		 * If __task_fpstate is set, it holds the right pointer,
> +		 * otherwise fpstate will.
> +		 */
> +		fps =3D READ_ONCE(fpu->__task_fpstate);

[ ... ]

>  static void x86_pmu_sample_xregs(struct perf_event *event,
>  				 struct perf_sample_data *data,
> +				 struct pt_regs *regs,
>  				 u64 ignore_mask)
>  {

[ ... ]

> +	if (user_mask) {
> +		perf_regs =3D container_of(data->regs_user.regs,
> +					 struct x86_perf_regs, regs);
> +		update_perf_regs(perf_regs, xsave, user_mask);
> +	}
> +
>  	if (intr_mask) {
>  		perf_regs =3D container_of(data->regs_intr.regs,
>  					 struct x86_perf_regs, regs);
> -		xsave->header.xfeatures =3D 0;
> -		xsaves_nmi(xsave, mask);
>  		update_perf_regs(perf_regs, xsave, intr_mask);

[Severity: High]
For PEBS events, if a delayed PMI NMI hits in kernel mode, can REGS_INTR
overwrite REGS_USER's XMM registers and leak kernel FPU data?

If a PEBS event requests both PERF_SAMPLE_REGS_USER and
PERF_SAMPLE_REGS_INTR, and a PEBS record is generated in user space but
the PMI is delivered while the CPU is in kernel mode (after the kernel has
set TIF_NEED_FPU_LOAD):

x86_pmu_update_regs_user() sets:
    data->regs_user.regs =3D regs;
   =20
x86_pmu_update_regs_intr() sets:
    data->regs_intr.regs =3D regs;
   =20
Both now share the same x86_perf_regs container. In x86_pmu_sample_xregs(),
the container is first updated with the user's FPU state, but then it is
unconditionally overwritten with the kernel's live FPU state from
xsaves_nmi() here because intr_mask is non-zero.

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D12
