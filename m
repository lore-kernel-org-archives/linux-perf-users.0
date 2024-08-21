Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9BB155307
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Aug 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244674; cv=none; b=f754j6fy1d5U8Eqqusev3ZmzQ2o+AmI+VrJTRgdd6l/YEAQVxpSWNevDrhKwnsgEXI9Bdl5u+mQ34NWXwpi7YkWLxepV6lQKB+e3eu/uw0lZGtAdmyzXN9w3OJLIHjknoD2sM4YMxTC2I004xQxDNBhpbGz6/rVvZ2MfM4V8RdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244674; c=relaxed/simple;
	bh=3kk9FB2Qg9EQluc1yWJwlVnjqomuB8gqG6ulP4gTqB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKWFXl9eCLxucqiTaob+vJAb66QObdieDUjWBQvh6uMyJpjtMqEaFH6mR+ZkYxNZ6Aw8M9y5vy+8Wzyl0SCmo3Ww/Bjb/MXKfPv2dKT7pkvmns31JzHjwPyxasJgPiTr3ifln1zMU0yuZjorvNy3rLD7+mtYu/3yhDr9TO/uIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gIlM+c9U; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gIlM+c9U"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so902929866b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Aug 2024 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724244671; x=1724849471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=raDu59AbuTAiHZu2m2E9hviyqY7JsE7FECBT8mn6n1o=;
        b=gIlM+c9UPyt7JUNXz6nXtohD7M6PUiEIvU3M/RHCZXZgCAEFRv66BnlpyH3x/BTSzY
         r6irwhIdDWqGjZfp8tN+WqZXZpkVWZp+mWeFr52+TcYer8lnTQ/ZIsECYPqCkcmc5HWd
         cBGuEkyBIiF0PZXYj3+QXfNsjcTjXcJOUsbNeGScm5E9q8zlydLrBJz/ulkDBwR3fnpp
         rXSs1ooFaDPXCpljdByxhQIpxOmRR2enJvbqxZrxygbPX6TsK1Tdq6ZBIwufOppGbvgY
         QySRvs2MiTFva1ruDNUBgss6s0BhEnVFh6uL062wdCNEYwKZUHt8+52UZz78Na74DDJ1
         Tqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244671; x=1724849471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raDu59AbuTAiHZu2m2E9hviyqY7JsE7FECBT8mn6n1o=;
        b=IxzjpY6tU1lXc6smySCDObos0eg5ROBn3+cwGgMaQDahzAt7dPPWpRRuCkYWkqhGqm
         X6++h8Sl/yEdxTuggzOxmPNOfDIr3i/EMnYjtYqigRY0clwaaVIITBJ2u99uPzKezDkt
         XUty9tYoJmWvGwO/shQ0Mf9P0OL0qQ0W/5hPqO9314+qsVgFSSWFf21XqbuoI9B7a0Jh
         tVAiO08O8/kfUrTwKnyYSWOEzwo5sBNeFxY48316aziS5zZmL7fEK0Xnd7fVPZDAyltH
         7Y1SkjtmEQ4WO8Cszk7vXIoAlAAEyj0ngqX9Xbmz2TAy/4/zuU15ho+ScQ5aVis+W9Pe
         4MFA==
X-Forwarded-Encrypted: i=1; AJvYcCUmWmcDn/3SC3nM7WZ1eBLAIo0o5+XOd/9dk1gcvAXic3TjOEFuvaoWes+OzIDHYH2JBxv0WrP+0HEhnIbYCYw6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ULQL7LLkibMFEzzZL6L/cxTFuBmFznldsryO1LGkAKc1R5tW
	j6+zIM+Jd6HRfmFJLBnfV4FMJZcP1L5BafojMztjdttMkVM7HzuiH+dS189MERk=
X-Google-Smtp-Source: AGHT+IGMx+niZTB1tXBn3Y538ogJDgh4dcZ/uFfeMe6k354e5J0N3e8sWtPvtt2hfSLE4kakV9lvzw==
X-Received: by 2002:a17:907:7fac:b0:a86:817e:d27b with SMTP id a640c23a62f3a-a86817edc76mr63107466b.43.1724244670578;
        Wed, 21 Aug 2024 05:51:10 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb69sm894459266b.88.2024.08.21.05.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:51:10 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:51:09 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: KVM: add basic support for host vs guest
 profiling
Message-ID: <20240821-5284bf727abbb08a379e1d06@orel>
References: <cover.1723518282.git.zhouquan@iscas.ac.cn>
 <7eb3e1a8fc9f9aa0340a6a1fb88a127b767480ea.1723518282.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb3e1a8fc9f9aa0340a6a1fb88a127b767480ea.1723518282.git.zhouquan@iscas.ac.cn>

On Tue, Aug 13, 2024 at 09:24:10PM GMT, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> For the information collected on the host side, we need to
> identify which data originates from the guest and record
> these events separately, this can be achieved by having
> KVM register perf callbacks.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  arch/riscv/include/asm/kvm_host.h |  5 +++++
>  arch/riscv/kvm/Kconfig            |  1 +
>  arch/riscv/kvm/main.c             | 12 ++++++++++--
>  arch/riscv/kvm/vcpu.c             |  7 +++++++
>  4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 2e2254fd2a2a..d2350b08a3f4 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -286,6 +286,11 @@ struct kvm_vcpu_arch {
>  	} sta;
>  };
>

Let's add the same comment here that arm64 has unless you determine
that 'any event that arrives while a vCPU is loaded is considered to be
"in guest"' is not true for riscv.

> +static inline bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu)
> +{
> +	return IS_ENABLED(CONFIG_GUEST_PERF_EVENTS) && !!vcpu;
> +}
> +
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  
>  #define KVM_RISCV_GSTAGE_TLB_MIN_ORDER		12
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index 26d1727f0550..0c3cbb0915ff 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -32,6 +32,7 @@ config KVM
>  	select KVM_XFER_TO_GUEST_WORK
>  	select KVM_GENERIC_MMU_NOTIFIER
>  	select SCHED_INFO
> +	select GUEST_PERF_EVENTS if PERF_EVENTS
>  	help
>  	  Support hosting virtualized guest machines.
>  
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index bab2ec34cd87..734b48d8f6dd 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -51,6 +51,12 @@ void kvm_arch_hardware_disable(void)
>  	csr_write(CSR_HIDELEG, 0);
>  }
>  
> +static void kvm_riscv_teardown(void)
> +{
> +	kvm_riscv_aia_exit();
> +	kvm_unregister_perf_callbacks();
> +}
> +
>  static int __init riscv_kvm_init(void)
>  {
>  	int rc;
> @@ -105,9 +111,11 @@ static int __init riscv_kvm_init(void)
>  		kvm_info("AIA available with %d guest external interrupts\n",
>  			 kvm_riscv_aia_nr_hgei);
>  
> +	kvm_register_perf_callbacks(NULL);
> +
>  	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
>  	if (rc) {
> -		kvm_riscv_aia_exit();
> +		kvm_riscv_teardown();
>  		return rc;
>  	}
>  
> @@ -117,7 +125,7 @@ module_init(riscv_kvm_init);
>  
>  static void __exit riscv_kvm_exit(void)
>  {
> -	kvm_riscv_aia_exit();
> +	kvm_riscv_teardown();
>  
>  	kvm_exit();
>  }
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 8d7d381737ee..e8ffb3456898 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -226,6 +226,13 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
>  	return (vcpu->arch.guest_context.sstatus & SR_SPP) ? true : false;
>  }
>  
> +#ifdef CONFIG_GUEST_PERF_EVENTS
> +unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.guest_context.sepc;
> +}
> +#endif
> +
>  vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
>  {
>  	return VM_FAULT_SIGBUS;
> -- 
> 2.34.1
>

Thanks,
drew
