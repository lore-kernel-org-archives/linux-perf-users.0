Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BE282F16
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776987106; cv=none; b=VH+X0j4+EEd3tR+s7HQxHTL3780mDsPthlp+wzlyk6dg+z04wcb2kerKGDAoNBNVjCYpSJxdTyG7bxWmtNjko7gsNgnoqWsQSztNCrWt/IQgM91HbvLoswUu6HBaS9pZhMrUKUFx0giypOHClWkyeuTySRdyva4t93dnCBT4wCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776987106; c=relaxed/simple;
	bh=FkmWitNqson7U9T29IH6ytAQ/lMECWjaHSuT4hoWXtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WtV2NCPz0jg9poGseYO2W0wiRWOgHzgpsMUoAaFCMyhaGfRVe+zO5IaCxHTAUKaAOiD3PHdvJBw5AKKyfnRjyIdj6liAUWGbgpFXjqDqwfqXbpfSMeEOW+6Wa7ArVaX70WVTniDtK5IeVg88zfFQTkzHB5a6QsVxREiQJNPA0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgd84Rlz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgd84Rlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC5BC2BCAF;
	Thu, 23 Apr 2026 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776987106;
	bh=FkmWitNqson7U9T29IH6ytAQ/lMECWjaHSuT4hoWXtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Rgd84RlzhmO7714azdoJvbKvm7DppmJmesQm4OvTdWGIs3lCKJ7jAHd61UKVz+fuz
	 J9OrRdW1w2GeCOY7JZUuAO86L/wUsxZpxQqAKuBU16aQVGhvbj0eJUtX+4wHfIOMvD
	 cUGE0uZU7kLRXAkD0AZnIXQX4Q7CsMcw5jFVn1wsXUQjUpB/Jx3IkHZwZxe5j0zMPo
	 Jzygh8EEz1iiK6AZ2mDwilT3H7FoXE9nR9y2b+JIsLzPUtQZv1pHKuLXb8sW5LypeS
	 +O23u+5K9YX+9bNiuMAiTCTlJlDmBo7qzAcv0GNmSBmAzl39ntyXlFCse3ju4Xaww2
	 U7G91FfNxaakw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated
 struct for getting guest PEBS data
Reply-To: sashiko@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423150340.463896-5-seanjc@google.com>
References: <20260423150340.463896-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 23:31:45 +0000
Message-Id: <20260423233145.DDC5BC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unconditional external function call to intel_pmu_get_cross_mapp=
ed_mask() introduced in the VMX hot path.
--

commit bf596eb4f1ae159ccdd3b9e0517c0eaa4c80ce4a
Author: Sean Christopherson <seanjc@google.com>

perf/x86: KVM: Have perf define a dedicated struct for getting guest PEBS d=
ata

This commit introduces a dedicated struct (x86_guest_pebs) for passing guest
PEBS data from KVM to perf. It replaces the previous method of passing an
opaque pointer to kvm_pmu, allowing perf to define its own data requirements
independently of KVM-internal state.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a29896a9ef1456..e6c1c64a8c949d 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7313,12 +7313,15 @@ static void atomic_switch_perf_msrs(struct vcpu_v=
mx *vmx)
>  	if (kvm_vcpu_has_mediated_pmu(&vmx->vcpu))
>  		return;
> =20
> -	pmu->host_cross_mapped_mask =3D 0;
> -	if (pmu->pebs_enable & pmu->global_ctrl)
> -		intel_pmu_cross_mapped_check(pmu);
> +	struct x86_guest_pebs guest_pebs =3D {
> +		.enable =3D pmu->pebs_enable,
> +		.ds_area =3D pmu->ds_area,
> +		.data_cfg =3D pmu->pebs_data_cfg,
> +		.cross_mapped_mask =3D intel_pmu_get_cross_mapped_mask(pmu),
> +	};

Does this introduce an unnecessary function call overhead on the VMX hot pa=
th?

Prior to this patch, the external function intel_pmu_cross_mapped_check()
was conditionally called only when PEBS was enabled, which avoided an
external function call in the vast majority of cases.

Because intel_pmu_get_cross_mapped_mask() is in a different compilation
unit (pmu_intel.c), calling it unconditionally here results in a function
call on every VM-entry.

Would it be better to restore the inline condition check, perhaps using a
ternary operator when initializing cross_mapped_mask?

> =20
>  	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. =
*/
> -	msrs =3D perf_guest_get_msrs(&nr_msrs, (void *)pmu);
> +	msrs =3D perf_guest_get_msrs(&nr_msrs, &guest_pebs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423150340.4638=
96-1-seanjc@google.com?part=3D4
