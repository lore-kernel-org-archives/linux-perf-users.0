Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44D37CD2C
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783304575; cv=none; b=pgVY2LyVjfOZf6YLAXHU9lJJDIAL7o8TxxmSIC13ClG0iVRTw7OmLt1L4xB7ge+ABnjqmTlhTLtWvMN4SYDzX2tayQCwJv+SZrNBOYjMcrpofyZvxyofXx/BAMi6UHPEwZiqlmdy8xpI020NC10RcIh/my+3QHRpaL1+8h23UpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783304575; c=relaxed/simple;
	bh=qAFLA27xm3AA7OTA7MC+kuj7KzzBfJAQh+xk9x+FEpg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SNl8IjChGg0KbT0s6mnHCE2dVEDVnBoBS9t/vCOdujQnKs3Vai041Tf7Dd86Kr9KZpxxCRSUyl49kk7FNivAzAhfg2IIL1s08w6WNTlN8lCTEe2jAqFuU1HPH5AfZ334tlGF7/qEBnUr2w607cK54yEIHXLNQ0mb9g5yuV19hTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkLP5Ly1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkLP5Ly1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214481F000E9;
	Mon,  6 Jul 2026 02:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783304574;
	bh=DQ88ljpyJWKPAwu4WC1GBdFK1KGY5mcRlxbLY4aH7V0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkLP5Ly1fL6qWuZGFc+ofamNo3HHANvGf1bdML400CnVMDhTzbIfelFnomFJgVilx
	 0CkA143LKUlunZcopGnxUohCXTbDl3WIRCrCTK+Y1dZEZKIbJvAF2kIro9ueEmDo18
	 PFBeHhFrtKG+doqyFv1MaKkKuOLwysQHzOXd+aQ42kegxXw+JYhf5Dg4J5qqwZ8KDM
	 ye/5w8VwPYoXZqvDdhNIcG0CsLcivitQRPIY0I6G73sm6Ex9Obb8qnmEfU/ZhXOy9k
	 5xwHaXK7JzwUIuMCclXYQuHGh1W+Cfch5dnFOZCt0ai4/HekuULihI7umIP7Olf9IE
	 QgjvOKg0OGNtg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v9 08/24] x86/fpu: Add update_fpu_state_and_flag()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706015439.3040804-9-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 02:22:53 +0000
Message-Id: <20260706022254.214481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Guest FPU state leaks to host perf samples because the NMI handler=
 incorrectly bypasses the `__task_fpstate` check when `TIF_NEED_FPU_LOAD` i=
s 0.
--

commit a7b6e478b8260eaf627518f9d19e511212779fab
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

x86/fpu: Add update_fpu_state_and_flag() helper

This commit introduces the update_fpu_state_and_flag() helper to save user
FPU state and set TIF_NEED_FPU_LOAD. It also adds memory barriers in the
host/guest FPU state switch path to ensure fpu->__task_fpstate is observed
correctly when non-NULL.

Link: https://lore.kernel.org/all/20251204154721.GB2619703@noisy.programmin=
g.kicks-ass.net/

> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 584fb9913be42..fb78e0ecd5fa8 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
[ ... ]
> @@ -383,13 +396,15 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fp=
u, bool enter_guest)
> =20
>  	/* Swap fpstate */
>  	if (enter_guest) {
> -		fpu->__task_fpstate =3D cur_fps;
> +		WRITE_ONCE(fpu->__task_fpstate, cur_fps);
> +		barrier();
>  		fpu->fpstate =3D guest_fps;
>  		guest_fps->in_use =3D true;
>  	} else {
>  		guest_fps->in_use =3D false;
>  		fpu->fpstate =3D fpu->__task_fpstate;
> -		fpu->__task_fpstate =3D NULL;
> +		barrier();
> +		WRITE_ONCE(fpu->__task_fpstate, NULL);

[Severity: High]
Can guest FPU state leak into host perf samples during this window?

The commit message mentions that subsequent patches will use this guarantee
in NMI context by checking TIF_NEED_FPU_LOAD before retrieving user FPU
state from the saved task FPU state.

However, during KVM guest execution and within the VM-exit path here,
TIF_NEED_FPU_LOAD is 0 because it was cleared on guest entry and is not set
by KVM.

If an NMI hits here before restore_fpregs_from_fpstate() restores the host
state, would the NMI handler bypass the fpu->__task_fpstate check because
TIF_NEED_FPU_LOAD is 0?

arch/x86/events/core.c:x86_pmu_update_user_xregs() {
	...
	if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {
		perf_regs =3D container_of(data->regs_user.regs,
				 struct x86_perf_regs, regs);
		fpu =3D x86_task_fpu(current);
		/*
		 * If __task_fpstate is set, it holds the right pointer,
		 * otherwise fpstate will.
		 */
		fps =3D READ_ONCE(fpu->__task_fpstate);
	...
}

If this memory check is skipped, wouldn't the NMI handler fall back to
reading directly from the hardware registers, which still contain the guest
FPU state at this point in fpu_swap_kvm_fpstate()?

>  	}
> =20
>  	cur_fps =3D fpu->fpstate;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706015439.3040=
804-1-dapeng1.mi@linux.intel.com?part=3D8
