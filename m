Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E206EAC6
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267777; cv=none; b=DwC9G+1KJ4mvqW9BV50GfrYjmDgZnh0UegTo6vxxUtMlqZElX5k8CcJdv6rvkiIuCjQcXtcsOKzJ9L822u+ZdtI8NEIBjeoydb2V75sEn7nvMgG5TBH5CAqhE9Xb6FEjYkQspY5eKEox2/8aMEPjt4Eo+Y+uFfg7THtVESPEF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267777; c=relaxed/simple;
	bh=ebAJP3ZuCK7o9jdqJnixc0CAvLRTF4r6aeQRLMVjXek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IrF58HlqpxOg8EWJE4uRtuOk5pwatMpTn7WowoIOBJwQ/9IyubUnOOLZ+/1GV20CJUyD50KjDFRMSuDbYoCLS8fXbDxbyLRWfjj017y7jBT1AvevXYJ0VYQhn3IferF/q43MYsg0xLpzp3sypvqmBUHSU0XhnhwNE3QmePzbaoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qvf8EjE4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qvf8EjE4"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af5310c1ac1so156042a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747267774; x=1747872574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D09EdKCu+qKlZnyk51V1issnwhEZW8zkeiyjfE2Xyzc=;
        b=Qvf8EjE4XZxD84wDra+eqFSdrZGfkZW/tpBpoIIX/ByQ05KlWwrLzOXiLwzAcDH5iq
         MAtQwUCZGnGVkdF6G/N7gCzJG0sc9gIYqPywje/wP03LwbKvcSpo9bG//Zk8OCR9xZGK
         /eO8f5xXgMMDP+aJtQQPnuEXeA2snKTw/HbI6H3vP3YqQWIaEhlI74Kilha1dnc9FqcT
         BhzQwaTxyvT6X1QbOHS5Mc9NmMjt3Gqv79ENKglpMeJ60Ya3N3MjHOs+5hGQwpjAcR2S
         yUX+PV/2Iz73Og6z8LPSv5hbvo9XAS3A2D7jmBGsB3/HSQpVajag6u4k6pBGaczAEl9g
         pYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747267774; x=1747872574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D09EdKCu+qKlZnyk51V1issnwhEZW8zkeiyjfE2Xyzc=;
        b=S0QMxcDqgyny6WB3Cq1etQWh9Q6PMh/zZ45omPcFB1pAGb/MLYbIBX1FHQOU0wdFWR
         yb4KdD1DnzJ6kO2BIkmwLBt5erRfwaJgdqUBNQueTb7Ux/EYc2eVL4QmKYK7h7Byyw2R
         mCM9HmUd4Y8NvlIlWNtzCaxOD2FN6oVkqjWSgJ8CQIxPQ4mIWPmD6wpkjzT1vvv4no/+
         uR6vNvIZNYZwxQOE5cbtjID3Jr/qiGMiAjv3IsOkkJgxMAp4ObUsBRKqTorK5Hb2ew6K
         If5dhGlJCcxkCVLA5ATQnlUjItMUa0dcsYIjZSeBaaKaBhEu9C8CrCO8GMvKAJkJYFDr
         FoMg==
X-Forwarded-Encrypted: i=1; AJvYcCU/TMfy3lZFoCKmWjpN5X0uY1ARZ3fU2ApTHeiNyAfAawfVKQTpATg+XRaHrcUq8CAgl4+3Te/NJP2Y95eP4Bud@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1keDY6Hoe0ZBcvBS1TD0t0LYb0sJNWfCRCLvZ98NJffHyRv9
	bDILVWYcty7x+DNMbyJaLwCmR0bYZH+c8VUo+HwzKGAPcRuLL19DaXTiuFsq2KLBFao1SwWaHEa
	/sQ==
X-Google-Smtp-Source: AGHT+IHZxjMDZEUoyieykpHJBN8fkIofFqi4PCpWEy+uuvPUHwBl4Xu9AdE++jsZ4ntU4sQV8cnlqyvgKCE=
X-Received: from pfwz32.prod.google.com ([2002:a05:6a00:1da0:b0:740:c2df:693f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b882:b0:216:119f:7fa2
 with SMTP id adf61e73a8af0-216119f9be0mr367084637.34.1747267774638; Wed, 14
 May 2025 17:09:34 -0700 (PDT)
Date: Wed, 14 May 2025 17:09:33 -0700
In-Reply-To: <20250324173121.1275209-15-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-15-mizhang@google.com>
Message-ID: <aCUwvXPKD0ANKFb7@google.com>
Subject: Re: [PATCH v4 14/38] KVM: x86/pmu: Introduce enable_mediated_pmu
 global parameter
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

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Introduce enable_mediated_pmu global parameter to control if mediated
> vPMU can be enabled on KVM level. Even enable_mediated_pmu is set to
> true in KVM, user space hypervisor still need to enable mediated vPMU
> explicitly by calling KVM_CAP_PMU_CAPABILITY ioctl. This gives
> hypervisor flexibility to enable or disable mediated vPMU for each VM.
> 
> Mediated vPMU depends on some PMU features on higher PMU version, like
> PERF_GLOBAL_STATUS_SET MSR in v4+ for Intel PMU. Thus introduce a
> pmu_ops variable MIN_MEDIATED_PMU_VERSION to indicates the minimum host
> PMU version which mediated vPMU needs.
> 
> Currently enable_mediated_pmu is not exposed to user space as a module
> parameter until all mediated vPMU code are in place.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/kvm/pmu.c              |  3 ++-
>  arch/x86/kvm/pmu.h              | 11 +++++++++
>  arch/x86/kvm/svm/pmu.c          |  1 +
>  arch/x86/kvm/vmx/capabilities.h |  3 ++-
>  arch/x86/kvm/vmx/pmu_intel.c    |  5 ++++
>  arch/x86/kvm/vmx/vmx.c          |  3 ++-
>  arch/x86/kvm/x86.c              | 44 ++++++++++++++++++++++++++++++---
>  arch/x86/kvm/x86.h              |  1 +
>  8 files changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 75e9cfc689f8..4f455afe4009 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -775,7 +775,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->pebs_data_cfg_rsvd = ~0ull;
>  	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
>  
> -	if (!vcpu->kvm->arch.enable_pmu)
> +	if (!vcpu->kvm->arch.enable_pmu ||
> +	    (!lapic_in_kernel(vcpu) && enable_mediated_pmu))

This check belongs in KVM_CAP_PMU_CAPABILITY, i.e. KVM needs to reject enabling
a mediated PMU without an in-kernel local APIC, not silently drop the PMU.

>  		return;
>  
>  	kvm_pmu_call(refresh)(vcpu);
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index ad89d0bd6005..dd45a0c6be74 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -45,6 +45,7 @@ struct kvm_pmu_ops {
>  	const u64 EVENTSEL_EVENT;
>  	const int MAX_NR_GP_COUNTERS;
>  	const int MIN_NR_GP_COUNTERS;
> +	const int MIN_MEDIATED_PMU_VERSION;

I like the idea, but simply checking the PMU version is insufficient on Intel,
i.e. just add a callback.

>  };
>  
>  void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
> @@ -63,6 +64,12 @@ static inline bool kvm_pmu_has_perf_global_ctrl(struct kvm_pmu *pmu)
>  	return pmu->version > 1;
>  }
>  
> +static inline bool kvm_mediated_pmu_enabled(struct kvm_vcpu *vcpu)

kvm_vcpu_has_mediated_pmu() to align with e.g. guest_cpu_cap_has(), and because
kvm_mediated_pmu_enabled() sounds like a VM-scoped or module-scoped helper.

> +{
> +	return vcpu->kvm->arch.enable_pmu &&

This is superfluous, pmu->version should never be non-zero without the PMU being
enabled at the VM level.

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 77012b2eca0e..425e93d4b1c6 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -739,4 +739,9 @@ struct kvm_pmu_ops intel_pmu_ops __initdata = {
>  	.EVENTSEL_EVENT = ARCH_PERFMON_EVENTSEL_EVENT,
>  	.MAX_NR_GP_COUNTERS = KVM_MAX_NR_INTEL_GP_COUNTERS,
>  	.MIN_NR_GP_COUNTERS = 1,
> +	/*
> +	 * Intel mediated vPMU support depends on
> +	 * MSR_CORE_PERF_GLOBAL_STATUS_SET which is supported from 4+.
> +	 */
> +	.MIN_MEDIATED_PMU_VERSION = 4,
>  };
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 00ac94535c21..a4b5b6455c7b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7916,7 +7916,8 @@ static __init u64 vmx_get_perf_capabilities(void)
>  	if (boot_cpu_has(X86_FEATURE_PDCM))
>  		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
>  
> -	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
> +	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR) &&
> +	    !enable_mediated_pmu) {
>  		x86_perf_get_lbr(&vmx_lbr_caps);
>  
>  		/*

There's a bit too much going on in this patch.  I think it makes sense to split
the vendor chunks out to separate patches, so that each can elaborate on the
exact requirements.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 72995952978a..1ebe169b88b6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -188,6 +188,14 @@ bool __read_mostly enable_pmu = true;
>  EXPORT_SYMBOL_GPL(enable_pmu);
>  module_param(enable_pmu, bool, 0444);
>  
> +/*
> + * Enable/disable mediated passthrough PMU virtualization.
> + * Don't expose it to userspace as a module paramerter until
> + * all mediated vPMU code is in place.
> + */

No need for the comment, documenting this in the changelog is sufficient.

> +bool __read_mostly enable_mediated_pmu;
> +EXPORT_SYMBOL_GPL(enable_mediated_pmu);
> +
>  bool __read_mostly eager_page_split = true;
>  module_param(eager_page_split, bool, 0644);
>  
> @@ -6643,9 +6651,28 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  			break;
>  
>  		mutex_lock(&kvm->lock);
> -		if (!kvm->created_vcpus) {
> -			kvm->arch.enable_pmu = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
> -			r = 0;
> +		/*
> +		 * To keep PMU configuration "simple", setting vPMU support is
> +		 * disallowed if vCPUs are created, or if mediated PMU support
> +		 * was already enabled for the VM.
> +		 */
> +		if (!kvm->created_vcpus &&
> +		    (!enable_mediated_pmu || !kvm->arch.enable_pmu)) {
> +			bool pmu_enable = !(cap->args[0] & KVM_PMU_CAP_DISABLE);
> +
> +			if (enable_mediated_pmu && pmu_enable) {

Local APIC check goes here.

> +				char *err_msg = "Fail to enable mediated vPMU, " \
> +					"please disable system wide perf events or nmi_watchdog " \
> +					"(echo 0 > /proc/sys/kernel/nmi_watchdog).\n";
> +
> +				r = perf_get_mediated_pmu();
> +				if (r)
> +					kvm_err("%s", err_msg);


#define MEDIATED_PMU_MSG "Fail to enable mediated vPMU, disable system wide perf events and nmi_watchdog.\n"

				r = perf_create_mediated_pmu();
				if (r)
					kvm_err(MEDIATED_PMU_MSG);

> +			} else
> +				r = 0;
> +
> +			if (!r)
> +				kvm->arch.enable_pmu = pmu_enable;
>  		}
>  		mutex_unlock(&kvm->lock);
>  		break;
> @@ -12723,7 +12750,14 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
>  	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
>  	kvm->arch.guest_can_read_msr_platform_info = true;
> -	kvm->arch.enable_pmu = enable_pmu;
> +
> +	/*
> +	 * PMU virtualization is opt-in when mediated PMU support is enabled.
> +	 * KVM_CAP_PMU_CAPABILITY ioctl must be called explicitly to enable
> +	 * mediated vPMU. For legacy perf-based vPMU, its behavior isn't changed,
> +	 * KVM_CAP_PMU_CAPABILITY ioctl is optional.
> +	 */

Again, too much extraneous info, the exception proves the rule.  I.e. by calling
out that mediated PMU is special, it's clear the rule is that PMUs are enabled by
default in the !mediated case.

	/*
	 * Userspace must explicitly opt-in to PMU virtualization when mediated
	 * PMU support is enabled (see KVM_CAP_PMU_CAPABILITY).
	 */

> +	kvm->arch.enable_pmu = enable_pmu && !enable_mediated_pmu;

So I tried to run a QEMU with this and it failed, because QEMU expected the PMU
to be enabled and tried to write to PMU MSRs.  I haven't dug through the QEMU
code, but I assume that QEMU rightly expects that passing in PMU in CPUID when
KVM_GET_SUPPORTED_CPUID says its supported will result in the VM having a PMU.

I.e. by trying to get cute with backwards compatibility, I think we broke backwards
compatiblity.  At this point, I'm leaning toward making the module param off-by-default,
but otherwise not messing with the behavior of kvm->arch.enable_pmu.  Not sure if
that has implications for KVM_PMU_CAP_DISABLE though.
