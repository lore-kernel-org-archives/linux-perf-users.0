Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D35B03A
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Mar 2024 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802208; cv=none; b=EnTuSveXU1ZymfJFBmtJ1hRxzq1PatJPVjKRI7lVg6MoTY2iqtSsULPrsXRGKw5ClQFS7JkziaLetoB33QwoNa8h7VL8oasPiZJC/J/UHT5iihjC1h6s8M+iVXsjU78O8NqwY11qpNS5WeZ0v6LQtZAuvhXY54rg8gPoExnCPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802208; c=relaxed/simple;
	bh=j2F5c9awjwHydGFsrc6IensBkERJfcx5SEh0tNqi3PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALxD1HvF1/kBRhwZSRbpXD5ep9MdEbeJd1KpFY5d4epz0cHiI9V2FHl5IZ1JQcRJfFVsimyFp2uxJL2RXWIMhIqaslOf4l22BNOsP80nHaU2kTJHPjw7PkSuZfALfWpXWIyU9aYFK5HL08XxqQ17Z5A1SApotj5y9/fy+ZGK3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrKwcPLE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrKwcPLE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e00b1c2684so15676745ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Mar 2024 15:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710802206; x=1711407006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNWbkAuEkPYJlyHqAZD/CIqyfffUNvIYkFP7cLrf3Yw=;
        b=ZrKwcPLEDQsam1vj+NF+OrpFXsHDLTYIJzo3Of5lQFSrt5zoGvxdn9L4RMJAmfQyzp
         D77ocX+b1YI//05iB+176cF6VN2BLRvkukGrZpWsd42AW9q/eN8+jRUIeBdDI8gIWXtj
         rOSx9hxS5pRif5GzB1SutFY3JjEdy/JhlMpBhIsRbosN6ohMp3BBM9q4WBStnEPG3u6M
         2LUK8KSlnpU199035gZ3H38yktJs5SBhtH4t0bwLXjayTNl0UNByAGt6JLPQDkPgts5T
         UpgH25XDMx7o/622c7J6aZ5vkk/EUQFCLKZ+QYTo6lYxKj8ZUxhcvw8PDn2GGFLwpttD
         K7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802206; x=1711407006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNWbkAuEkPYJlyHqAZD/CIqyfffUNvIYkFP7cLrf3Yw=;
        b=JU36mb/9ZJsCTyD5eb5jnBS1LPmk3xi7eF56AG7Kfh8eCvibf9HOhg/7yILaujsxnm
         n/j8xu14O91M319KZxywfuRxoRtbNwSLR168vv8zOP4+wLlyT6lQADEjYKe9Fyv5pLoq
         vmtiboblUfGstnbM/Saiy3uprBjGP5+odRkrp9vJxl7p6iPI8+kr2tPS4/VJ0e38sgcx
         1mkxdT1ZqTkVIL28xgUYLuRi0cVtImChMsxfaHwQPrEOogsaJabYaV8AQfBd7RjR5RKz
         5nQtVaAAju5ycjjuF+ATg1tpUx83BNXTLN5jpp0BTiCyJbeoPCQRCZ7Kz1ML+yyPljga
         /Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCV8XO87A+jc/ygXtjutuOgMOJX7XHmSH2wkaNph09ZPfOyXczpiWdWwGFKrbJF2SfYHRHCj7UrQ+U+2uccreAdecVxV1C9+IV6pjVEOnOWTbQ==
X-Gm-Message-State: AOJu0YyiV2Lo1ygBUATXMmlTk7uH9/jUkserCkGjaBIJhJ0YtdczhnM8
	Z7cJHCsNvAzsPn9v3ijUF/vr5Obj5B8AIqA5Pqq91fjXP2ukLQSKQmP+OrO2Pg==
X-Google-Smtp-Source: AGHT+IH2uub6actYUAG+gi1xsVDB1ZTBcKAecNEMuqQUMmgJWl3PcNTonWASodNB0f+Z/PZGYA/4vg==
X-Received: by 2002:a17:903:1c9:b0:1de:f32d:f5ba with SMTP id e9-20020a17090301c900b001def32df5bamr12667167plh.42.1710802205857;
        Mon, 18 Mar 2024 15:50:05 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902a70e00b001db66f3748fsm3462466plq.182.2024.03.18.15.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:50:05 -0700 (PDT)
Date: Mon, 18 Mar 2024 22:50:01 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 1/3] KVM: VMX: Snapshot LBR capabilities during module
 initialization
Message-ID: <ZfjFGZvy_3gH1UjV@google.com>
References: <20240307011344.835640-1-seanjc@google.com>
 <20240307011344.835640-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307011344.835640-2-seanjc@google.com>

On Wed, Mar 06, 2024, Sean Christopherson wrote:
> Snapshot VMX's LBR capabilities once during module initialization instead
> of calling into perf every time a vCPU reconfigures its vPMU.  This will
> allow massaging the LBR capabilities, e.g. if the CPU doesn't support
> callstacks, without having to remember to update multiple locations.
> 
> Opportunistically tag vmx_get_perf_capabilities() with __init, as it's
> only called from vmx_set_cpu_caps().
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Mingwei Zhang <mizhang@google.com>

>  arch/x86/kvm/vmx/pmu_intel.c | 2 +-
>  arch/x86/kvm/vmx/vmx.c       | 9 +++++----
>  arch/x86/kvm/vmx/vmx.h       | 2 ++
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 12ade343a17e..be40474de6e4 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -535,7 +535,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
>  	if (cpuid_model_is_consistent(vcpu) &&
>  	    (perf_capabilities & PMU_CAP_LBR_FMT))
> -		x86_perf_get_lbr(&lbr_desc->records);
> +		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
>  	else
>  		lbr_desc->records.nr = 0;
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 7a74388f9ecf..2a7cd66988a5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -217,6 +217,8 @@ module_param(ple_window_max, uint, 0444);
>  int __read_mostly pt_mode = PT_MODE_SYSTEM;
>  module_param(pt_mode, int, S_IRUGO);
>  
> +struct x86_pmu_lbr __ro_after_init vmx_lbr_caps;
> +
>  static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
>  static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_cond);
>  static DEFINE_MUTEX(vmx_l1d_flush_mutex);
> @@ -7844,10 +7846,9 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	vmx_update_exception_bitmap(vcpu);
>  }
>  
> -static u64 vmx_get_perf_capabilities(void)
> +static __init u64 vmx_get_perf_capabilities(void)
>  {
>  	u64 perf_cap = PMU_CAP_FW_WRITES;
> -	struct x86_pmu_lbr lbr;
>  	u64 host_perf_cap = 0;
>  
>  	if (!enable_pmu)
> @@ -7857,8 +7858,8 @@ static u64 vmx_get_perf_capabilities(void)
>  		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
>  
>  	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
> -		x86_perf_get_lbr(&lbr);
> -		if (lbr.nr)
> +		x86_perf_get_lbr(&vmx_lbr_caps);
> +		if (vmx_lbr_caps.nr)
>  			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
>  	}
>  
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 65786dbe7d60..cc10df53966e 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -109,6 +109,8 @@ struct lbr_desc {
>  	bool msr_passthrough;
>  };
>  
> +extern struct x86_pmu_lbr vmx_lbr_caps;
> +
>  /*
>   * The nested_vmx structure is part of vcpu_vmx, and holds information we need
>   * for correct emulation of VMX (i.e., nested VMX) on this vcpu.
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 
