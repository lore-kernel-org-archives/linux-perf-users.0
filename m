Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDF8F66
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 00:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747269451; cv=none; b=Gz/jo98i+Sp+IsMsZSFOvISM9NNnQV6zrRkR62jywMStti1dvgb101ibWgH9g0OGb67d0GDBVQqOMQkoU8ObXXXcIZLmDihbrjJ8Fh6Ne3mOeIZPWk7JUGWrovxYJXN3SbTLUUfwY6rt3YNDF/K8L0HSbGGdp1/QlCi/WF3P7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747269451; c=relaxed/simple;
	bh=20JZZATn2xYn8yCBr4Nu5Nw8VR/pgtNNgy1qu7hFmHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vAWCb7czI5cRII2MvNpsn9BI/zagfdNn/2Cot4+vKmJF9X5/FcJ8TUpCW1eHd5boRlbxZJ3tCfxpGWezwOhzg16cQk+Y5pMHUX8DxOX0Srrwkz4ZLH1uY7y0vLpzwz/yHSpmuEil5JbuxmAPaZj/9KVNdDOK8naCuue/8hjfW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urR8CUfh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urR8CUfh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30c8c9070d2so610954a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 17:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747269447; x=1747874247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2QJBCuK1Gmwp843LF9HX9up42dO/Q8RSynscXuV78Hc=;
        b=urR8CUfht/kxJEmiPUzudfpInfP0vDOH9AUkUO5PFtkjxO3REUOnYrD3RHzN1cNAsq
         /lCA2oriXCJ6NBkMc9TvG7dlThoOYcTMdVvACUEpxQFQO9Oq5dfE04sLssjkOJNFSHmx
         4CJjAqFxPAe6hMkgud535k67q+q3Letyv3bpPc4wibj4ZT8X6BBTSAK55Js6YGNNeKMB
         qsmOEiDTq7ozhfcPdQY2lw2tusd1GBJiT0ZD0E8B3vmJLu5HmF5Wo3dIZcPSGG+MUztG
         /XrSHt4ehJ/eG/3EznurxSGzCdcGJM+2odczdvY43OE3LjOGe4sZUQcxSCloWJDAdZSJ
         fiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747269447; x=1747874247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QJBCuK1Gmwp843LF9HX9up42dO/Q8RSynscXuV78Hc=;
        b=LhGrcyeK2iPPHAFwxuWG+e8EA9PpxS8m0kt73UDhA+f4kM9hyNlR3NSNHRH9BBJBvQ
         g8E8IcEMsfT9dHqYhonNsE8ka0n/nT9H6zD5vdodBhmuq8FWpEazy/tgBCMNKGQN52FV
         6Kjk7v+WvNbYAkpfrXj/5E7c6PS47BORXiK2Vw/sUP7ZZTQBP4TNPhtAUH1mUXOJdoSE
         EWVvLhctKA50+Mt7Bv0jpeSHeb8bL9L4iEbgus/Y6opefLc4vSr6Sa23d0uWw/8IxTdH
         +jFE4h21obMfWJ3tHf+dypDWvC+XW+NF/8qU3Opwl9DGc6xbejBZCIPD8Fxs6+hY3CVy
         UGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV+PBKAe3LYzDmv0k94hYOL6Zv4j57unHksB2kDQsLf7CtaCCzliD0iiISgKfTTEHFwe9WdluyFTRmVO3UZUm0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JuiY6HA5I/MPu7X6iTA0jmDUJ1YgbY2/4JbeX8nI6w3gDydk
	dRGtgmaR2+p6hPWaaSPKA7DbtooPbi/MxCVpX3syO7gcIooZzwZfyaduJqMjQm9T4bVzNH4+KQG
	03w==
X-Google-Smtp-Source: AGHT+IEwfm+Du4RUeKdC/ksRMikSeXOxPtIXncZ5f2NEIIJa2t/AKg6M6lFZyNG4z4xRSqoFUoMMpIdmjzY=
X-Received: from pjbsk9.prod.google.com ([2002:a17:90b:2dc9:b0:308:64af:7bb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c0a:b0:303:703f:7f8
 with SMTP id 98e67ed59e1d1-30e2e633642mr7091539a91.34.1747269447560; Wed, 14
 May 2025 17:37:27 -0700 (PDT)
Date: Wed, 14 May 2025 17:37:26 -0700
In-Reply-To: <20250324173121.1275209-23-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-23-mizhang@google.com>
Message-ID: <aCU3Ri0iz0aDBDup@google.com>
Subject: Re: [PATCH v4 22/38] KVM: x86/pmu: Optimize intel/amd_pmu_refresh() helpers
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

This is not an optimization in any sane interpretation of that word.

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Currently pmu->global_ctrl is initialized in the common kvm_pmu_refresh()
> helper since both Intel and AMD CPUs set enable bits for all GP counters
> for PERF_GLOBAL_CTRL MSR. But it may be not the best place to initialize
> pmu->global_ctrl. Strictly speaking, pmu->global_ctrl is vendor specific

And?  There's mounds of KVM code that show it's very, very easy to manage
global_ctrl in common code.

> and there are lots of global_ctrl related processing in
> intel/amd_pmu_refresh() helpers, so better handle them in same place.
> Thus move pmu->global_ctrl initialization into intel/amd_pmu_refresh()
> helpers.
> 
> Besides, intel_pmu_refresh() doesn't handle global_ctrl_rsvd and
> global_status_rsvd properly and fix it.

Really?  You mention a bug fix in passing, and squash it into an opinionated
refactoring that is advertised as "optimizations" without even stating what the
bug is?  C'mon.

> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/pmu.c           | 10 -------
>  arch/x86/kvm/svm/pmu.c       | 14 +++++++--
>  arch/x86/kvm/vmx/pmu_intel.c | 55 ++++++++++++++++++------------------
>  3 files changed, 39 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 4e8cefcce7ab..2ac4c039de8b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -843,16 +843,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  		return;
>  
>  	kvm_pmu_call(refresh)(vcpu);
> -
> -	/*
> -	 * At RESET, both Intel and AMD CPUs set all enable bits for general
> -	 * purpose counters in IA32_PERF_GLOBAL_CTRL (so that software that
> -	 * was written for v1 PMUs don't unknowingly leave GP counters disabled
> -	 * in the global controls).  Emulate that behavior when refreshing the
> -	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
> -	 */
> -	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)
> -		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);

Absolutely not, this code stays where it is.

>  }
>  
>  void kvm_pmu_init(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 153972e944eb..eba086ef5eca 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -198,12 +198,20 @@ static void __amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
>  					 kvm_pmu_cap.num_counters_gp);
>  
> -	if (pmu->version > 1) {
> -		pmu->global_ctrl_rsvd = ~((1ull << pmu->nr_arch_gp_counters) - 1);
> +	if (kvm_pmu_cap.version > 1) {

It's not just global_ctrl.  PEBS and the fixed counters also depend on v2+ (the
SDM contradicts itself; KVM's ABI is that they're v2+).

> +		/*
> +		 * At RESET, AMD CPUs set all enable bits for general purpose counters in
> +		 * IA32_PERF_GLOBAL_CTRL (so that software that was written for v1 PMUs
> +		 * don't unknowingly leave GP counters disabled in the global controls).
> +		 * Emulate that behavior when refreshing the PMU so that userspace doesn't
> +		 * need to manually set PERF_GLOBAL_CTRL.
> +		 */
> +		pmu->global_ctrl = BIT_ULL(pmu->nr_arch_gp_counters) - 1;
> +		pmu->global_ctrl_rsvd = ~pmu->global_ctrl;
>  		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
>  	}
>  
> -	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;
> +	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;

I like these cleanups, but they too belong in a separate patch.

>  	pmu->reserved_bits = 0xfffffff000280000ull;
>  	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
>  	/* not applicable to AMD; but clean them to prevent any fall out */
