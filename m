Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC11D0E14
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033928; cv=none; b=Q64HuvWx4aArwp/1BQNeezJnmqXLKSIpMelVSqsIcsbpNKKn8celaUGhjsOda+Xy90L6NGi7bKq7zHdD38soH6S2hE8Y2QN8dKCHTDLofFn7BoEfHBCEIfvgFFfkNQDRTjQk82t2KLtyR8qVxLO7kjdH9BTzqeMl+yNxXreDKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033928; c=relaxed/simple;
	bh=2ekSIgrAzzeYMbHqvayaK6X9jApON1Mrqm4gAr1xfuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BiEtiYpzggLT78YoG0b6eplxkRMnQaQlwnNg24qHVz94wyM+MGvjzG2ruXZ8y+9uKqnfr0K9QcystjOBGJQIMvxfVA4cXvS7u8xNOYUTd1+c9Rjzz93xwyRWX5Q6f3Cnqa9vaoGeVT/HCcafnD87f8gXinfyyNH+YuERtixhPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zsx18bgV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zsx18bgV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2122b6cadb1so20476755ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732033925; x=1732638725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNbKX5TNOs33VCY6qePAD5uOIqkp/me0ayOtaNKA/No=;
        b=Zsx18bgVO7bkns/T1bdF4o8hwm4HvGQ8K1njUTD4dTXju86ClsCpINQqIWpGIFTQKB
         e6LHXGXZj58Aljcko4CXtyhKWQF0yK2DFGNyOzVW0cqUfb0OBPJwmvdt91XIAWFTIuqN
         TIWgfTJGzEuY4McD0XEnaIHAK9foqqASgCE1MftAhb4xDILZ8YoBisNLcY6BrNEt6Ak/
         IfFrMfLcASkDlOulcA8dQZy+rNDsGyUJKevl2EGxlLy4S7W14LO+32nHQgYueNlER7yZ
         +HPJP4DhPq5/KNm7IeX+xKotS6DRYeStV2FIKNsR4OCQvjivgD6S6x7xBeVFM1YR/u+A
         YZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033925; x=1732638725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNbKX5TNOs33VCY6qePAD5uOIqkp/me0ayOtaNKA/No=;
        b=xGNSV0Bhkw98choZMKAbDkbI4mjvi9ApkoYYIvBbeb8cgbBndmaEtkvhX/lYwXRica
         cayeP40wI0lPHcsc5g7foFdiGGufJfVTwR+PcQGYp8Vu9P3fjoJRVmSV/sWVDUTkm+bI
         lE0yTj0p3d9qmlpLUaIyIH47e6xgJxESudo6uk0doVx06Ejqs2uYLsXuS+1BsGvUv7PX
         E8YstVNzQqCdXjFoKa77gXz4i1s2npCcJ2XPGs+FBIQRWD5J3QhxXBX9DgV23Ja2dYwN
         rLXActlJV6Ni3BL4OcxO0ci4Jh3xcsO7h7kX10gDGSauIjNeXadPD34yxOxYCaIEeXR3
         /POQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU7vY/pxzgA4afW9HtRZ4lQO2g7jmStPLQep4KiPWgcZzprmchxTXyu7pbXsyUVigEMNfZCzO/FGTk1uwXCwwW@vger.kernel.org
X-Gm-Message-State: AOJu0YylNYpz6JJgW9tM1bWfoL5mkTU2nH16saC8CLXmrImQL4HZgLUA
	Z3Lt/ftYYPrW3K+WDF8FEgfS6gnyX8a1NifQx5YL5uccmVfBZKhDfjHS8xxUBl4RlTP3bBDNchq
	VZA==
X-Google-Smtp-Source: AGHT+IHsgdDVo1GLilnJsRb44nsrNpagX5eSv1Mr8vSstq32Le09fOxuyDrall8LHgWMDjvlpZV4/rkUUOc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:2350:b0:212:6342:b592 with SMTP id
 d9443c01a7336-2126342b73amr9395ad.8.1732033925225; Tue, 19 Nov 2024 08:32:05
 -0800 (PST)
Date: Tue, 19 Nov 2024 08:32:03 -0800
In-Reply-To: <20240801045907.4010984-24-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-24-mizhang@google.com>
Message-ID: <Zzy9gz9boGIzZlsQ@google.com>
Subject: Re: [RFC PATCH v3 23/58] KVM: x86/pmu: Allow RDPMC pass through when
 all counters exposed to guest
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiong Zhang <xiong.y.zhang@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 01, 2024, Mingwei Zhang wrote:
> Clear RDPMC_EXITING in vmcs when all counters on the host side are exposed
> to guest VM. This gives performance to passthrough PMU. However, when guest
> does not get all counters, intercept RDPMC to prevent access to unexposed
> counters. Make decision in vmx_vcpu_after_set_cpuid() when guest enables
> PMU and passthrough PMU is enabled.
> 
> Co-developed-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> ---
>  arch/x86/kvm/pmu.c     | 16 ++++++++++++++++
>  arch/x86/kvm/pmu.h     |  1 +
>  arch/x86/kvm/vmx/vmx.c |  5 +++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index e656f72fdace..19104e16a986 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -96,6 +96,22 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
>  #undef __KVM_X86_PMU_OP
>  }
>  
> +bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu)

As suggested earlier, kvm_rdpmc_in_guest().

> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	if (is_passthrough_pmu_enabled(vcpu) &&
> +	    !enable_vmware_backdoor &&

Please add a comment about the VMware backdoor, I doubt most folks know about
VMware's tweaks to RDPMC behavior.  It's somewhat obvious from the code and
comment in check_rdpmc(), but I think it's worth calling out here too.

> +	    pmu->nr_arch_gp_counters == kvm_pmu_cap.num_counters_gp &&
> +	    pmu->nr_arch_fixed_counters == kvm_pmu_cap.num_counters_fixed &&
> +	    pmu->counter_bitmask[KVM_PMC_GP] == (((u64)1 << kvm_pmu_cap.bit_width_gp) - 1) &&
> +	    pmu->counter_bitmask[KVM_PMC_FIXED] == (((u64)1 << kvm_pmu_cap.bit_width_fixed)  - 1))

BIT_ULL?  GENMASK_ULL?

> +		return true;
> +
> +	return false;

Do this:


	return <true>;

not:

	if (<true>)
		return true;

	return false;

Short-circuiting on certain cases is fine, and I would probably vote for that so
it's easier to add comments, but that's obviously not what's done here.  E.g. either

	if (!enable_mediated_pmu)
		return false;

	/* comment goes here */
	if (enable_vmware_backdoor)
		return false;

	return <counters checks>;

or

	return <massive combined check>;

> +}
> +EXPORT_SYMBOL_GPL(kvm_pmu_check_rdpmc_passthrough);

Maybe just make this an inline in a header?  enable_vmware_backdoor is exported,
and presumably enable_mediated_pmu will be too.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4d60a8cf2dd1..339742350b7a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7911,6 +7911,11 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  		vmx->msr_ia32_feature_control_valid_bits &=
>  			~FEAT_CTL_SGX_LC_ENABLED;
>  
> +	if (kvm_pmu_check_rdpmc_passthrough(&vmx->vcpu))

No need to follow vmx->vcpu, @vcpu is readily available.

> +		exec_controls_clearbit(vmx, CPU_BASED_RDPMC_EXITING);
> +	else
> +		exec_controls_setbit(vmx, CPU_BASED_RDPMC_EXITING);

I wonder if it makes sense to add a helper to change a bit.  IIRC, the only reason
I didn't add one along with the set/clear helpers was because there weren't many
users and I couldn't think of good alternative to "set".

I still don't have a good name, but I think we're reaching the point where it's
worth forcing the issue to avoid common goofs, e.g. handling only the "clear"
case and no the "set" case.

Maybe changebit?  E.g.

static __always_inline void lname##_controls_changebit(struct vcpu_vmx *vmx, u##bits val,	\
						       bool set)				\
{												\
	if (set)										\
		lname##_controls_setbit(vmx, val);						\
	else											\
		lname##_controls_clearbit(vmx, val);						\
}


and then vmx_refresh_apicv_exec_ctrl() can be:

	secondary_exec_controls_changebit(vmx,
					  SECONDARY_EXEC_APIC_REGISTER_VIRT |
					  SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY,
					  kvm_vcpu_apicv_active(vcpu));
	tertiary_exec_controls_changebit(vmx, TERTIARY_EXEC_IPI_VIRT,
					 kvm_vcpu_apicv_active(vcpu) && enable_ipiv);

and this can be:

	exec_controls_changebit(vmx, CPU_BASED_RDPMC_EXITING,
				!kvm_rdpmc_in_guest(vcpu));
