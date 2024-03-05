Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBE12B17E
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Mar 2024 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680926; cv=none; b=EiWs6HbG/OT6kQ9UZzHBNipEKFxE4pYccJNtRlpOZxfGp8HfZAzCg0n1hGzp5TP0DuoAiHvBZU0aiB5k04R9aw+Zh1/YYs6Hy2YDYGHkrdUiXzxLrqEZft6DW197WokN93nPNkqnHyGZ+Q5ujMFDb9sPaaCBWrkgj4h4f9jyClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680926; c=relaxed/simple;
	bh=0QqKaja2wGQkp5VdpnZGiCLHufW+2W9QfUG8dJPnUnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIAOTP1g59PSeqqtn0BljODU6LXdYYlnOWp5yq7TxTedBbrgosJQ1CP+ZTbR9Z6jyL4Algjpk0cLhGuyjW71zCBjanGCsqwIsW2hw+9RZOgH3CK1Amt+D3esqJSgeZdX3mnGMPCzLnnGSNEbboQfs+6BQht8exImp7uLwfmcBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=moNdxZVo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moNdxZVo"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso9278385276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Mar 2024 15:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709680923; x=1710285723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+T4/DXA8g5wsjCQOI4d9Me0cBz3l8e073w7d7R7vr8=;
        b=moNdxZVo4RbNyCXRVz8nWLHm+neZUz3XQTPnd4mLkOAojODdufKDs7z1svMZ+whtZm
         3NmJtkoIh8U+KR7hzgx3F8Y8UdOU7ytESzTdmzVGNWQvN+hLWcp+/Lgn+cOsCzxGeDMd
         N15c0qTURgsTnCnGytft+aw1S6gZcLXs5g8wG3P8RS7eQPiIoG/PCf2M5bpK6WlWwsjh
         apC6xjUy5VuONutMiEfDH5pIBKd7wQ+fv4I5/5fDkT+F/jOptwa9eURR34GuVDmAJW4+
         7Fwhw1qSiVEpUroF7Ommk5ic7nNEdwBytmlyihdcxPVvg71cYO7NPfsyFVzx/rY0kPsc
         1HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680924; x=1710285724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+T4/DXA8g5wsjCQOI4d9Me0cBz3l8e073w7d7R7vr8=;
        b=IJIDc+6KhKT+w8ZC2F23SG7uqtXE9C3LLKHXG3+UNUiAF3cG1M+R2QBHYdsbWOLaYp
         XcOUTx9dTN+Z8Thv+eQK3948y1CTzyG7usrAC8uy4dWFgufTIgaubI3bqotdgPcwf/LS
         RQKQfDVBwg2VYzHNZQXnEZjJq05sn1wblUA9FWsoKLEGNI4+NMij3w8lOJxUJ1E+/2P/
         4cxGKnWn3oStt4Zu1c5ixG1HzhmOagvPI8Wu8iDdq3/h6cNEsK9GZAWZfYWfr3p/z3x7
         5SyYD76zCXfB+bNyKdIjloq8dyoeh8SEZPUmK3qTafn+mSMazed8bxmwPSmOTXy44T6n
         3ISA==
X-Forwarded-Encrypted: i=1; AJvYcCUjlYy/laWRlzgQjcQvNDfhiaZwEMO4LkHq8r/Ati+h+111tTvmulFE4mTnxe0UCCdr38rnn8nQIJAaFJWTBWmFin1U0ltxQC1OsYmesKT3ug==
X-Gm-Message-State: AOJu0YxS9jsfkzZV+VL+j7NjqFFUBQfAyJjVqFbSjTSkWYNgubbKzPu0
	zF+qgB/EG1DFhkpKX0h9YsRBLXnZPc4zibaWmadhcPJ+DbBovuF2QwpZ5E5qBdSQSGsb/pu1rQR
	FTQ==
X-Google-Smtp-Source: AGHT+IFkDwAHYCS99l3GSkk1EFfxwdOwqpDghQVC1M8Qt99OMUPaJBjB6sPk7lALPOP6nKY9i00G4WHXgm4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1821:b0:dc7:9218:df3b with SMTP id
 cf33-20020a056902182100b00dc79218df3bmr585948ybb.10.1709680923726; Tue, 05
 Mar 2024 15:22:03 -0800 (PST)
Date: Tue, 5 Mar 2024 15:22:02 -0800
In-Reply-To: <20230824020546.1108516-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230824020546.1108516-1-dapeng1.mi@linux.intel.com>
Message-ID: <ZeepGjHCeSfadANM@google.com>
Subject: Re: [Patch v3] KVM: x86/pmu: Manipulate FIXED_CTR_CTRL MSR with macros
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Like Xu <likexu@tencent.com>, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhang Xiong <xiong.y.zhang@intel.com>, Lv Zhiyuan <zhiyuan.lv@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"

+Mingwei

On Thu, Aug 24, 2023, Dapeng Mi wrote:
 diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 7d9ba301c090..ffda2ecc3a22 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -12,7 +12,8 @@
>  					  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
>  
>  /* retrieve the 4 bits for EN and PMI out of IA32_FIXED_CTR_CTRL */
> -#define fixed_ctrl_field(ctrl_reg, idx) (((ctrl_reg) >> ((idx)*4)) & 0xf)
> +#define fixed_ctrl_field(ctrl_reg, idx) \
> +	(((ctrl_reg) >> ((idx) * INTEL_FIXED_BITS_STRIDE)) & INTEL_FIXED_BITS_MASK)
>  
>  #define VMWARE_BACKDOOR_PMC_HOST_TSC		0x10000
>  #define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
> @@ -165,7 +166,8 @@ static inline bool pmc_speculative_in_use(struct kvm_pmc *pmc)
>  
>  	if (pmc_is_fixed(pmc))
>  		return fixed_ctrl_field(pmu->fixed_ctr_ctrl,
> -					pmc->idx - INTEL_PMC_IDX_FIXED) & 0x3;
> +					pmc->idx - INTEL_PMC_IDX_FIXED) &
> +					(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER);
>  
>  	return pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE;
>  }
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index f2efa0bf7ae8..b0ac55891cb7 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -548,8 +548,13 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  		setup_fixed_pmc_eventsel(pmu);
>  	}
>  
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
> -		pmu->fixed_ctr_ctrl_mask &= ~(0xbull << (i * 4));
> +	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> +		pmu->fixed_ctr_ctrl_mask &=
> +			 ~intel_fixed_bits_by_idx(i,
> +						  INTEL_FIXED_0_KERNEL |
> +						  INTEL_FIXED_0_USER |
> +						  INTEL_FIXED_0_ENABLE_PMI);
> +	}
>  	counter_mask = ~(((1ull << pmu->nr_arch_gp_counters) - 1) |
>  		(((1ull << pmu->nr_arch_fixed_counters) - 1) << INTEL_PMC_IDX_FIXED));
>  	pmu->global_ctrl_mask = counter_mask;
> @@ -595,7 +600,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
>  			for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
>  				pmu->fixed_ctr_ctrl_mask &=
> -					~(1ULL << (INTEL_PMC_IDX_FIXED + i * 4));

OMG, this might just win the award for most obfuscated PMU code in KVM, which is
saying something.  The fact that INTEL_PMC_IDX_FIXED happens to be 32, the same
bit number as ICL_FIXED_0_ADAPTIVE, is 100% coincidence.  Good riddance.

Argh, and this goofy code helped introduce a real bug.  reprogram_fixed_counters()
doesn't account for the upper 32 bits of IA32_FIXED_CTR_CTRL.

Wait, WTF?  Nothing in KVM accounts for the upper bits.  This can't possibly work.

IIUC, because KVM _always_ sets precise_ip to a non-zero bit for PEBS events,
perf will _always_ generate an adaptive record, even if the guest requested a
basic record.  Ugh, and KVM will always generate adaptive records even if the
guest doesn't support them.  This is all completely broken.  It probably kinda
sorta works because the Basic info is always stored in the record, and generating
more info requires a non-zero MSR_PEBS_DATA_CFG, but ugh.

Oh great, and it gets worse.  intel_pmu_disable_fixed() doesn't clear the upper
bits either, i.e. leaves ICL_FIXED_0_ADAPTIVE set.  Unless I'm misreading the code,
intel_pmu_enable_fixed() effectively doesn't clear ICL_FIXED_0_ADAPTIVE either,
as it only modifies the bit when it wants to set ICL_FIXED_0_ADAPTIVE.

*sigh*

I'm _very_ tempted to disable KVM PEBS support for the current PMU, and make it
available only when the so-called passthrough PMU is available[*].  Because I
don't see how this is can possibly be functionally correct, nor do I see a way
to make it functionally correct without a rather large and invasive series.

Ouch.  And after chatting with Mingwei, who asked the very good question of
"can this leak host state?", I am pretty sure that yes, this can leak host state.

When PERF_CAP_PEBS_BASELINE is enabled for the guest, i.e. when the guest has
access to adaptive records, KVM gives the guest full access to MSR_PEBS_DATA_CFG

	pmu->pebs_data_cfg_mask = ~0xff00000full;

which makes sense in a vacuum, because AFAICT the architecture doesn't allow
exposing a subset of the four adaptive controls.

GPRs and XMMs are always context switched and thus benign, but IIUC, Memory Info
provides data that might now otherwise be available to the guest, e.g. if host
userspace has disallowed equivalent events via KVM_SET_PMU_EVENT_FILTER.

And unless I'm missing something, LBRs are a full leak of host state.  Nothing
in the SDM suggests that PEBS records honor MSR intercepts, so unless KVM is
also passing through LBRs, i.e. is context switching all LBR MSRs, the guest can
use PEBS to read host LBRs at will.

Unless someone chimes in to point out how PEBS virtualization isn't a broken mess,
I will post a patch to effectively disable PEBS virtualization.

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 41a4533f9989..a2f827fa0ca1 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -392,7 +392,7 @@ static inline bool vmx_pt_mode_is_host_guest(void)
 
 static inline bool vmx_pebs_supported(void)
 {
-       return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
+       return false;
 }
 
 static inline bool cpu_has_notify_vmexit(void)
