Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D72459DD
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100957; cv=none; b=bLHAyTxaopJxsHpxZ7thed6bQrMoF5VaJk0m+nYZ7rRvMpuvo1pnVRpY6zEusdeDGkxeXZjUu7tDU7YkneK6LsBEEsZOJqo+PwFno1sqwqX3JxVQ/jibo4k+wjIwz44+/BxmQ5k3CtPiwdRLkQ7LS84RUr0tSXyLi4Guh1dUtlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100957; c=relaxed/simple;
	bh=X+S9iGT2HZuWijXLu7tolVZGrlzdF76ew/mCGKUwvJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWfRCKVmR6qCrq7KbOCg9mxU5/k2/8Sq7UY8cDB+8Md4e2HsKoInWnJz7LK8aeBM5tCxCEwJmZrihnqzqfc/mcvT/CN6aVFf7t0sf58GBELXgWLl2VAguPtudFoIynqvAVEPQekDjxULLIqk6CzSN4npsLYPoqH4S0Z1jtonQ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/uiTo7s; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/uiTo7s"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0d058fc56so9886055ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100946; x=1769705746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrRnfOe0PxE3nW6MpoxAPcIWhyGqLCRkYDS8HFbpPvg=;
        b=r/uiTo7sNASbUmviSbHcoHRPVmYC5EuVH9ifUucmktHpwz4EoLxZHY0xYKQrU+8Bep
         5BKJxDqTUbKnrCtVW90LwPuNvFT+rmE2IX6LgaqsgGslJ3F9xuU7WBZAsdGHDrv/cE85
         ZxNFOW/nEtUVIY0domMjs8VUhkzb1j34vGXSM+31u0vJ35e7bkM1Wg1ifpKhA7QfmaTM
         UTqW2cqxnmaRwn3K/lxs7MbG7dZkvVzcLLl9yk64jaf1f3bpGsc46okS8gWafSPHqZeg
         23HmHtgAOGJlf4PNAN0GRc5y/e29jdv8P/tCcOezO2BiegaIcSE8aA6yZcZkaZBw6Ioa
         7vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100946; x=1769705746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrRnfOe0PxE3nW6MpoxAPcIWhyGqLCRkYDS8HFbpPvg=;
        b=qx/FK0TltML/w9aS/BRL9v1E6AUqDVaUyw0NWodfD4RSXucPic9Ttnh5figGBx+RIL
         FzbK0lZGLmhknVByyVlo71E7uDxcX1PErEtZzmk//z5+8l2BojuUKkDXK4zQO7r/hFuq
         QZi65vQM0wJ9ks+zpePYL5lCXKAfEwzOLqXZieJ+NOlO5+5ZduE+qiZj70Fxykqy3GLi
         8dJaO5Xu/S86jheagWUY/1nBBhaLb8U/DULBF3+Wp48+BIZaPFlPNZAodO0waXFdO1iO
         AM8zjnmJ9CZuGOs3gvJlrGW6qVNjvkbXBrZflcvlFbcU8QpEEn8m+XxzeW5snWJJK0pr
         ukNg==
X-Forwarded-Encrypted: i=1; AJvYcCWVTEwzd9OHfa0iVCf0jq6va4qs/amzF13z0xv7+5EpgMN1a05GBdPkGePlbJUgWWHxoeYq1Quiglv1/6VpK7+f@vger.kernel.org
X-Gm-Message-State: AOJu0YzjG99UuXwf976l7BO0ld41VJUHsPCRJk+jHD4HKfIJSLkMPJh0
	c+uzpiI0akGVu7suTToFLTSys5qM1GWlSjgW5hmgkXh+OoN9B+wA99Mbs0ie5bND4QSw3fELJQ9
	3Dvmpfg==
X-Received: from plot23.prod.google.com ([2002:a17:902:8c97:b0:2a7:ca54:ed0f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c2:b0:29e:e642:95d6
 with SMTP id d9443c01a7336-2a7fe77dd00mr370985ad.59.1769100945836; Thu, 22
 Jan 2026 08:55:45 -0800 (PST)
Date: Thu, 22 Jan 2026 08:55:44 -0800
In-Reply-To: <20260121225438.3908422-5-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-5-jmattson@google.com>
Message-ID: <aXJWkIw0oSzOmxLS@google.com>
Subject: Re: [PATCH 4/6] KVM: x86/pmu: [De]activate HG_ONLY PMCs at SVME
 changes and nested transitions
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 21, 2026, Jim Mattson wrote:
> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> index f0aa6996811f..7b32796213a0 100644
> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> @@ -26,6 +26,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
>  KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
>  KVM_X86_PMU_OP(mediated_load)
>  KVM_X86_PMU_OP(mediated_put)
> +KVM_X86_PMU_OP_OPTIONAL(set_pmc_eventsel_hw_enable)
>  
>  #undef KVM_X86_PMU_OP
>  #undef KVM_X86_PMU_OP_OPTIONAL
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 833ee2ecd43f..1541c201285b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -1142,6 +1142,13 @@ void kvm_pmu_branch_retired(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_branch_retired);
>  
> +void kvm_pmu_set_pmc_eventsel_hw_enable(struct kvm_vcpu *vcpu,
> +				       unsigned long *bitmap, bool enable)
> +{
> +	kvm_pmu_call(set_pmc_eventsel_hw_enable)(vcpu, bitmap, enable);
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_set_pmc_eventsel_hw_enable);

Why bounce through a PMU op just to go from nested.c to pmu.c?  AFAICT, common
x86 code never calls kvm_pmu_set_pmc_eventsel_hw_enable(), just wire up calls
directly to amd_pmu_refresh_host_guest_eventsels().

> @@ -1054,6 +1055,11 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
>  	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
>  		goto out_exit_err;
>  
> +	kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
> +		vcpu_to_pmu(vcpu)->pmc_hostonly, false);
> +	kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
> +		vcpu_to_pmu(vcpu)->pmc_guestonly, true);
> +
>  	if (nested_svm_merge_msrpm(vcpu))
>  		goto out;
>  
> @@ -1137,6 +1143,10 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  
>  	/* Exit Guest-Mode */
>  	leave_guest_mode(vcpu);
> +	kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
> +		vcpu_to_pmu(vcpu)->pmc_hostonly, true);
> +	kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
> +		vcpu_to_pmu(vcpu)->pmc_guestonly, false);
>  	svm->nested.vmcb12_gpa = 0;
>  	WARN_ON_ONCE(svm->nested.nested_run_pending);

I don't think these are the right places to hook.  Shouldn't KVM update the
event selectors on _all_ transitions, whether they're architectural or not?  E.g.
by wrapping {enter,leave}_guest_mode()?

static void svm_enter_guest_mode(struct kvm_vcpu *vcpu)
{
	enter_guest_mode(vcpu);
	amd_pmu_refresh_host_guest_eventsels(vcpu);
}

static void svm_leave_guest_mode(struct kvm_vcpu *vcpu)
{
	leave_guest_mode(vcpu);
	amd_pmu_refresh_host_guest_eventsels(vcpu);
}
