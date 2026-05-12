Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0426ED3A;
	Tue, 12 May 2026 05:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778562114; cv=none; b=kObgY1pfFUZpWQHPyo6/Ub08DVs0Jog97DA1FldOI/bXfzDpRNyh8bFTGu7OJGK6yrZf7Nw8/pAdXNuEAj6xkS1AXo8ZvaGgUS2QqfOogqBxQLm92wStOcmWjtyd3P0qbfd5qTPed8Fmfa4N5qD4jCtFd1BnPMQMxMC9d3XQOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778562114; c=relaxed/simple;
	bh=sGi9d1q6NWlsxKjJ+CJPnEr//TekLS/qP4CoL6DydEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNL8ikrsdZroLn88Lvbg6F392rK/72SL95MHkxXYX0CHd4stP9Z4VUVR6SC3UnvDjsvS3rB+vTxfR07a1rteWp+VPR+Dba7U+V4QO/f1wpTbWl/3LfUjis6I9RvMxtFA1yvpBw9u8ev2uN4pe/UQ6R6lBPrm47urMXcve3/PdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRDDckCa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRDDckCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778562112; x=1810098112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sGi9d1q6NWlsxKjJ+CJPnEr//TekLS/qP4CoL6DydEE=;
  b=PRDDckCaZPgG+M6UOPGoZTaSR47rI0Cqrg9XB2wVbX84dfdOqCaYhP4T
   un+ZSBtaPs2RtirpWpk17//yqXyiiRkOX2PUmhxYMUpIIIxevhoFRGpvq
   u36xusAZiSUnYQJsO8dvRAoa3LsYmkDxwoE3IP5BGi0hT7K/46+PXUtRv
   4viz/RfSx6Mot3muG9OktT5hsBozmoUJ9mOfdqWBtPuAZdpOr+yDgf9De
   pQFgysz4/Uvahj36V10N8ltbR4EiCqMQCn10ykbVcisnPckDh9s2qv9mE
   IktyrizgsArmKUT3NqW8CVUj3lPLlbj40RGvKGusVSOz7aC9p3phRSN6d
   Q==;
X-CSE-ConnectionGUID: Xu7vn3eDQE66gKid23i7KA==
X-CSE-MsgGUID: sMi5rwGwQkO5gRZCKF1HEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79179645"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79179645"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:01:52 -0700
X-CSE-ConnectionGUID: lvETUGQ7SiKHQ9WF4hfWxw==
X-CSE-MsgGUID: XENoeqydSFiIYpFNOsYszQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="237745314"
Received: from unknown (HELO [10.238.3.169]) ([10.238.3.169])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:01:48 -0700
Message-ID: <740a4e11-7f4c-444b-9ad0-2e6f4a1ccf8e@linux.intel.com>
Date: Tue, 12 May 2026 13:01:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] KVM: VMX: Only tell perf to enable PEBS counters
 for fully enabled PMCs
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Stephane Eranian <eranian@google.com>
References: <20260508231353.406465-1-seanjc@google.com>
 <20260508231353.406465-10-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260508231353.406465-10-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/9/2026 7:13 AM, Sean Christopherson wrote:
> When passing the guest's requested PEBS_ENABLE (or rather, KVM's version
> of PEBS_ENABLE on behalf of the guest), omit counters that are locally
> disable and/or don't have a perf event (due to contention), in addition to
> omitting counters that are cross-mapped in the host.
>
> In practice, this should be a nop as perf will already have disabled the
> associated counter, i.e. cpuc->pebs_enabled should have been cleared, but
> paranoia is cheap, and the existing code _looks_ wrong.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 30 ++++++++++++++++--------------
>  arch/x86/kvm/vmx/vmx.c       | 11 +----------
>  arch/x86/kvm/vmx/vmx.h       | 15 ++++++++++++++-
>  3 files changed, 31 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 659fe097b904..1e420c8bca9d 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -736,34 +736,36 @@ static void intel_pmu_cleanup(struct kvm_vcpu *vcpu)
>  		intel_pmu_release_guest_lbr_event(vcpu);
>  }
>  
> -u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu)
> +u64 __intel_pmu_compute_pebs_enable(struct kvm_pmu *pmu)
>  {
> -	u64 host_cross_mapped_mask;
> +	u64 guest_pebs_enable = pmu->pebs_enable & pmu->global_ctrl;
> +	u64 pebs_enable = 0;
>  	struct kvm_pmc *pmc;
>  	int bit, hw_idx;
>  
>  	/*
> -	 * Provide a mask of counters that are cross-mapped between the guest
> -	 * and the host, i.e. where a guest PMC is mapped to a host PMC with a
> -	 * different index.  PEBS records hold a PERF_GLOBAL_STATUS snapshot,
> -	 * and so PEBS-enabled counters need to hold the correct index so as
> -	 * not to confuse the guest.
> +	 * Omit counters that are locally disabled, don't have a perf event, or
> +	 * ended up with a perf event that is using a different counter than
> +	 * the guest, i.e. where the guest PMC is different than the host PMC
> +	 * being used on behalf of the guest.  PEBS records include
> +	 * PERF_GLOBAL_STATUS, and so using a counter with a different index
> +	 * means the guest will see overflow status for the wrong counter(s).
>  	 */
> -	host_cross_mapped_mask = 0;
> -
> -	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&pmu->global_ctrl) {
> +	kvm_for_each_pmc(pmu, pmc, bit, (unsigned long *)&guest_pebs_enable) {
>  		if (!pmc_is_locally_enabled(pmc) || !pmc->perf_event)
>  			continue;
>  
>  		/*
> -		 * A negative index indicates the event isn't mapped to a
> +		 * Note, a negative index indicates the event isn't mapped to a
>  		 * physical counter in the host, e.g. due to contention.
>  		 */
>  		hw_idx = pmc->perf_event->hw.idx;
> -		if (hw_idx != pmc->idx && hw_idx > -1)
> -			host_cross_mapped_mask |= BIT_ULL(hw_idx);
> +		if (hw_idx != pmc->idx)
> +			continue;
> +
> +		pebs_enable |= BIT_ULL(pmc->idx);
>  	}
> -	return host_cross_mapped_mask;
> +	return pebs_enable;
>  }
>  
>  static bool intel_pmu_is_mediated_pmu_supported(struct x86_pmu_capability *host_pmu)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index fbe3ce5f5a51..31675e5cf563 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7314,20 +7314,11 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
>  		return;
>  
>  	struct x86_guest_pebs guest_pebs = {
> -		.enable = pmu->pebs_enable,
> +		.enable = intel_pmu_compute_pebs_enable(pmu),
>  		.ds_area = pmu->ds_area,
>  		.data_cfg = pmu->pebs_data_cfg,
>  	};
>  
> -	/*
> -	 * Disable counters where the guest PMC is different than the host PMC
> -	 * being used on behalf of the guest, as the PEBS record includes
> -	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> -	 * wrong counter(s).
> -	 */
> -	if (guest_pebs.enable & pmu->global_ctrl)
> -		guest_pebs.enable &= ~intel_pmu_get_cross_mapped_mask(pmu);
> -
>  	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
>  	msrs = perf_guest_get_msrs(&nr_msrs, &guest_pebs);
>  	if (!msrs)
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 0c4563472940..b055731efd2d 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -659,7 +659,20 @@ static __always_inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
>  	return container_of(vcpu, struct vcpu_vmx, vcpu);
>  }
>  
> -u64 intel_pmu_get_cross_mapped_mask(struct kvm_pmu *pmu);
> +u64 __intel_pmu_compute_pebs_enable(struct kvm_pmu *pmu);
> +
> +static inline u64 intel_pmu_compute_pebs_enable(struct kvm_pmu *pmu)
> +{
> +	/*
> +	 * Avoid the function call overhead in the common case that the guest
> +	 * isn't using PEBS.
> +	 */
> +	if (!(pmu->pebs_enable & pmu->global_ctrl))
> +		return 0;
> +
> +	return __intel_pmu_compute_pebs_enable(pmu);
> +}
> +
>  int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
>  void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu);

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>  
