Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3E47A6A
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877700; cv=none; b=X36DvnUiE4896fFB85DZdApmPS9giuE5MZIIC0Nys94ZjiYlE9PbXSSbaAVn0audL/VQ/bwyo+uW32cAOcLKiuqn8mnb12Ucdsjo8SF4/QsJR8hwB34NbKzRHI0W6HUs2vh5bZmFWkgS/ibuxdte/n4FyytDzWr4PPIHMCo6M8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877700; c=relaxed/simple;
	bh=6ZwCVg4MusV6lQ7ItLH6EESwYxCw9nUT7b8OHDZdHT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=asp5qu5K+e2Rr9IivjsWMS4WGDfU+6sKrPHGeCWqHDB0thiUMWCwvqK3mTdqwd9wbGYqnEbk8ghJppu26l7ur6nwrFMFJc7msrJ5PSpXNF4tl6jMdm9pa19pNY/OlR3EfM1kD2o8bf1aNsvSb1QhHeclWyFNUePW6+pdVtuovAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7BaZD4L; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7BaZD4L"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6150dcdf83fso5810787b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 16:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712877698; x=1713482498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lorpjlq0547PTTOUkeSdAvU0WcM/oDvCo7GfzO8Vzks=;
        b=h7BaZD4Lk7bbJVf/l/WvglQtSL2oGI6oS/d1AH7bUYm+lo1z2xDLUY0dfo/4y2LIr7
         PEVf3LdP2yZqpt0DU9lRh2RjgHURaaNrP7bi+Rky7JWbSjz8J69QOtotAS297aR8Cuzw
         zFGz/qAcF6PA/uqrkDDghqN5dwnWE3TcYb2gHs4SGkECk/un+GplfeDgEh9Myt2PxE46
         6sNlkGTPa35AvCV/z1b1AikRfkclAZx7WrJjGXc1ZI+pH5ox/EI1SDulF9unikyHvXnM
         tJl9IpeKGLQVFT5AiEcv2LyBPZzklIFKQkSMY/CTL+93kE94O8OpJ1su+ihzuhmiyGBz
         z1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877698; x=1713482498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lorpjlq0547PTTOUkeSdAvU0WcM/oDvCo7GfzO8Vzks=;
        b=ewlm+7JPMgyOsvQQCjV3RaY9U9+rcLL1fEFKWGhETrWS1J9XoRMLeDkuYkbr0HpEY1
         QlAfzM30NsL9pFRFL01De+Zpt11xsMEenpTpmVtQtqIc21/U1ZRi3ncovadcYThZshvf
         sZYQ1qQRGJqCob1jRaj1SIHUhlChcRhq5rOFN8W1/l9OvOuoatXGem8fszNeIqQBBCoU
         ftBzfbVcvlT05Cf7BnUqaWhPjBUjqp5WYOJtrR2GXsZGLghiGfSOx5tOH/8rWRFJW/Zu
         B6Ur95+gRmMztNtDrUmvUKK/VS+GCfNXF43HHQhO2vufFNffn+btjxz7VIIVEVcSi2Cr
         IenA==
X-Forwarded-Encrypted: i=1; AJvYcCW3IT85IWI/yuln9/3FyHqA7EfAZaBur8B0DzPLcwUMWOo8TTK5R0ZbFk1w9wlruVFJaCZH+ePlyjFBcpVGmSeyr0GDIp0aLl61kVF9Eai4fQ==
X-Gm-Message-State: AOJu0Yy5niWFleHyRupcwAX/eOlHtPuXbliH+4QmQG9EMFSsCFVKrswO
	Nv9zJRCPTpoq45WtPnm4Zc7e3mM+GIwoodZqk+hxehxKB8YPQjbOjjfwurGubWBdB2M2jLK2Boc
	06g==
X-Google-Smtp-Source: AGHT+IFVKkpv5zYi+YuG2a/YkPh8ZcgQ30c7S48yC8dspxgNJRM9VCSeO9DRhVk55/D5JlCVeG/xmM/XmkU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1002:b0:dc6:e5d3:5f03 with SMTP id
 w2-20020a056902100200b00dc6e5d35f03mr293019ybt.4.1712877698131; Thu, 11 Apr
 2024 16:21:38 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:21:36 -0700
In-Reply-To: <20240126085444.324918-42-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-42-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhwgFzFgklQFisv@google.com>
Subject: Re: [RFC PATCH 41/41] KVM: nVMX: Add nested virtualization support
 for passthrough PMU
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> From: Mingwei Zhang <mizhang@google.com>
> 
> Add nested virtualization support for passthrough PMU by combining the MSR
> interception bitmaps of vmcs01 and vmcs12. Readers may argue even without
> this patch, nested virtualization works for passthrough PMU because L1 will
> see Perfmon v2 and will have to use legacy vPMU implementation if it is
> Linux. However, any assumption made on L1 may be invalid, e.g., L1 may not
> even be Linux.
> 
> If both L0 and L1 pass through PMU MSRs, the correct behavior is to allow
> MSR access from L2 directly touch HW MSRs, since both L0 and L1 passthrough
> the access.
> 
> However, in current implementation, if without adding anything for nested,
> KVM always set MSR interception bits in vmcs02. This leads to the fact that
> L0 will emulate all MSR read/writes for L2, leading to errors, since the
> current passthrough vPMU never implements set_msr() and get_msr() for any
> counter access except counter accesses from the VMM side.
> 
> So fix the issue by setting up the correct MSR interception for PMU MSRs.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 52 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index c5ec0ef51ff7..95e1c78152da 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -561,6 +561,55 @@ static inline void nested_vmx_set_intercept_for_msr(struct vcpu_vmx *vmx,
>  						   msr_bitmap_l0, msr);
>  }
>  
> +/* Pass PMU MSRs to nested VM if L0 and L1 are set to passthrough. */
> +static void nested_vmx_set_passthru_pmu_intercept_for_msr(struct kvm_vcpu *vcpu,

Heh, 50 instances of passthrough, and then someone decides to shave a few characters
with passthru :-)  Long live mediated PMU!!!

> +							  unsigned long *msr_bitmap_l1,
> +							  unsigned long *msr_bitmap_l0)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	int i;
> +
> +	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
> +		nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
> +						 msr_bitmap_l0,
> +						 MSR_ARCH_PERFMON_EVENTSEL0 + i,
> +						 MSR_TYPE_RW);
> +		nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
> +						 msr_bitmap_l0,
> +						 MSR_IA32_PERFCTR0 + i,
> +						 MSR_TYPE_RW);
> +		nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
> +						 msr_bitmap_l0,
> +						 MSR_IA32_PMC0 + i,
> +						 MSR_TYPE_RW);
> +	}
> +
> +	for (i = 0; i < vcpu_to_pmu(vcpu)->nr_arch_fixed_counters; i++) {

Curly braces aren't needed, and this can use "pmu" instead of "vcpu_to_pmu".

> +		nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
> +						 msr_bitmap_l0,
> +						 MSR_CORE_PERF_FIXED_CTR0 + i,
> +						 MSR_TYPE_RW);
> +	}
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
> +					 msr_bitmap_l0,
> +					 MSR_CORE_PERF_FIXED_CTR_CTRL,
> +					 MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
> +					 msr_bitmap_l0,
> +					 MSR_CORE_PERF_GLOBAL_STATUS,
> +					 MSR_TYPE_RW);
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
> +					 msr_bitmap_l0,
> +					 MSR_CORE_PERF_GLOBAL_CTRL,
> +					 MSR_TYPE_RW);
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,
> +					 msr_bitmap_l0,
> +					 MSR_CORE_PERF_GLOBAL_OVF_CTRL,
> +					 MSR_TYPE_RW);
> +}
> +
>  /*
>   * Merge L0's and L1's MSR bitmap, return false to indicate that
>   * we do not use the hardware.
> @@ -660,6 +709,9 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
>  					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
>  
> +	if (is_passthrough_pmu_enabled(vcpu))
> +		nested_vmx_set_passthru_pmu_intercept_for_msr(vcpu, msr_bitmap_l1, msr_bitmap_l0);

More code that's probably cleaner if the helper handles the PMU type.

	nested_vmx_set_pmu_msr_intercepts(vcpu, msr_bitmap_l1, msr_bitmap_l0);

and then

	if (!enable_mediated_pmu || !pmu->version)
		return;

> +
>  	kvm_vcpu_unmap(vcpu, &vmx->nested.msr_bitmap_map, false);
>  
>  	vmx->nested.force_msr_bitmap_recalc = false;
> -- 
> 2.34.1
> 
