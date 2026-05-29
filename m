Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641D3B7765
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046667; cv=none; b=mzh8X9u0FD/h8R5F0gudSUK3lfBEHEONNfJjIfsI52Dx2w/TCUCYFvQsuANC+DB7JLp/kI4ES5DQq0jLK3qJnn77v8Gmpir4+2oSA1sQV9HfQL+YjFiBubxzGOewB3GaeoHlXEpx8voFywgv6zB6nP5+1kJ8/n4S+90c/+LydX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046667; c=relaxed/simple;
	bh=RrTANDnrEkEwMZJZcvpmSj3dhk8gV0W7adyiS7oHBWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lOGhRDLhlr8O/LakTGQd4i3eUxbeacnwaUrnKYoHNxMDZtWrCtQqDEIo3QBdtkT78jHYa+GN1fNkBeLUto47GFNofMsDwDs9JZEBXQiOF+ZzDuOgkyxIgNGQOPHL8GX6JKVmPek965E6AlfjlBrBGEXwGxj9brYDo1bhqn/Mx68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL2oMvLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL2oMvLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD81F00893;
	Fri, 29 May 2026 09:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780046664;
	bh=9b0+OwTIfreG9PkRO5/M7QX1wQZ1cFD56BO43Pc2uUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PL2oMvLWM1bHa12yEsYsLHcN9y03F5ylsIS9RUT/cs4cD/Sc0A6MAFoT1BwOrDYBl
	 TGwuv3fqwPwBt3dIajX20ny23JxNdWIntY8ouzkrrjcqm5fR7wijy8ijuScp/yD7PB
	 BDq5ycTms9GBQE5xzVl6UoRnV2sEj76taF9QpgNOvuDKg02Iaa2O4mVP1/Fw8TdcFf
	 4nyYptAmo5EmBfYxeKxGHqspoaTDlifrjlTcDQvNIAmKLIxKwe8rf/lr0PLV8h5Zf6
	 1zR52r2J25E2g5Dn9Mtc36GIdQTZ7Xx1dccXDxcfrbxbB1SBQP3CyhvPnKGwRutRCK
	 Ot1HuFfGe9rHw==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v8 11/23] perf/x86: Enable XMM register sampling for
 REGS_USER case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260529075645.580362-12-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-12-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:24:23 +0000
Message-Id: <20260529092423.F2DD81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling `xsaves_nmi()` for PEBS events on CPUs lacking `X86_FEATUR=
E_XSAVES` causes an invalid opcode exception (`#UD`), triggering warning lo=
ops and overhead.
- [High] Guest XMM registers are incorrectly sampled as host REGS_USER XMM =
registers when a PMU interrupt occurs during KVM guest execution.
--

commit feabaffcb00c51c951e3f0889a9ad615fe731d5e
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86: Enable XMM register sampling for REGS_USER case

This patch adds support for XMM register sampling in the REGS_USER case.
To handle simultaneous sampling of XMM registers, a per-CPU x86_user_regs
is introduced to store REGS_USER-specific XMM registers. The
x86_pmu_update_user_xregs helper function is added to retrieve user-space
XMM registers.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -707,12 +707,12 @@ int x86_pmu_hw_config(struct perf_event *event)
>  			return -EINVAL;
>  	}
> =20
> -	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
> +	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS=
_USER)) {
>  		/*
>  		 * Besides the general purpose registers, XMM registers may
>  		 * be collected as well.
>  		 */
> -		if (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK) {
> +		if (event_has_extended_regs(event)) {
>  			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
>  				return -EINVAL;
>  			if (is_sampling_event(event) && !event->attr.precise_ip &&
>  			    !this_cpu_has(X86_FEATURE_XSAVES))
>  				return -EINVAL;
>  		}
>  	}
[ ... ]
> @@ -1812,33 +1803,155 @@ static void x86_pmu_update_regs_intr(struct perf=
_event *event,
[ ... ]
> +static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *dat=
a,
> +					    struct pt_regs *regs,
> +					    u64 mask, u64 ignore_mask)
> +{
> +	struct x86_perf_regs *perf_regs;
> +	struct xregs_state *xsave;
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
When KVM loads a guest's FPU state, fpu_swap_kvm_fpstate() caches the host's
state in fpu->__task_fpstate and explicitly clears the TIF_NEED_FPU_LOAD fl=
ag
via fpregs_mark_activate().

If a perf NMI interrupts the guest, this check for TIF_NEED_FPU_LOAD will
evaluate to false, causing x86_pmu_update_user_xregs() to return the mask
instead of reading the cached host state from __task_fpstate.

Does this cause xsaves_nmi() to sample the hardware registers directly, whi=
ch
currently hold the KVM guest's XMM registers, and expose them to the host's
user-space perf record, leading to cross-VM data leaks?

> +		perf_regs =3D container_of(data->regs_user.regs,
> +				 struct x86_perf_regs, regs);
> +		fpu =3D x86_task_fpu(current);
> +		/*
> +		 * If __task_fpstate is set, it holds the right pointer,
> +		 * otherwise fpstate will.
> +		 */
> +		fps =3D READ_ONCE(fpu->__task_fpstate);
> +		if (!fps)
> +			fps =3D fpu->fpstate;
> +		xsave =3D &fps->regs.xsave;
> +
> +		update_perf_regs(perf_regs, xsave, user_mask);
> +		return 0;
> +	}
> +
> +	return user_mask;
> +}
[ ... ]
>  static void x86_pmu_sample_xregs(struct perf_event *event,
>  				 struct perf_sample_data *data,
> +				 struct pt_regs *regs,
>  				 u64 ignore_mask)
>  {
>  	struct xregs_state *xsave =3D get_ext_regs_buf(smp_processor_id());
>  	u64 sample_type =3D event->attr.sample_type;
>  	struct x86_perf_regs *perf_regs;
> +	u64 user_mask =3D 0;
>  	u64 intr_mask =3D 0;
>  	u64 mask =3D 0;
> =20
>  	if (WARN_ON_ONCE(!xsave) || !in_nmi())
>  		return;
> =20
> -	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
> -	    (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK))
> +	if (event_has_extended_regs(event))
>  		mask |=3D XFEATURE_MASK_SSE;
> =20
>  	mask &=3D x86_pmu.ext_regs_mask;
> +	if (sample_type & PERF_SAMPLE_REGS_USER) {
> +		user_mask =3D x86_pmu_update_user_xregs(data, regs,
> +						      mask, ignore_mask);
> +	}
> =20
>  	if (sample_type & PERF_SAMPLE_REGS_INTR)
>  		intr_mask =3D mask & ~ignore_mask;
> =20
> +	if (user_mask | intr_mask) {
> +		xsave->header.xfeatures =3D 0;
> +		xsaves_nmi(xsave, user_mask | intr_mask);
> +	}

[Severity: High]
For PEBS events with PERF_SAMPLE_REGS_USER, the X86_FEATURE_XSAVES check in
x86_pmu_hw_config() is bypassed due to event->attr.precise_ip being set.

If this event triggers in kernel space on a CPU lacking XSAVES (for example,
booted with noxsaves or masked in a VM), user_mode(regs) is false, so
user_mask retains the extended bits from x86_pmu_update_user_xregs().

Since xsaves_nmi() unconditionally emits the xsaves instruction, will this
trigger an Invalid Opcode exception on CPUs without XSAVES support and add
overhead to every PEBS interrupt in kernel space?

> +
> +	if (user_mask) {
> +		perf_regs =3D container_of(data->regs_user.regs,
> +					 struct x86_perf_regs, regs);
> +		update_perf_regs(perf_regs, xsave, user_mask);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529075645.5803=
62-1-dapeng1.mi@linux.intel.com?part=3D11
