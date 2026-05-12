Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EED2882B7;
	Tue, 12 May 2026 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561959; cv=none; b=hVTeT+a9zU0z8LutAJaVPuux9rtDLud0ECQMM7gUXYPVpO8v+3QMUTz9YZxOGdiZh2bb1FvJ+H2LbbgalLttwRfnBRt7GnXAtXycnY3c3atAlag4e/2CsKXMJXyJM4qb4KsWbgSc0GnVXw8aV75rfUgJLU2CwWCR0tY/GI11ux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561959; c=relaxed/simple;
	bh=LFJ9JbRzEy7jmD3+7XS3GK537ULYM7NySB5HHr4HX6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmNNN0w0pw/v+xQfhXeo2KTBjQ/wDyzqf3ogt31ZurWDkzCNntKQrJ/BoVyKkCT/ECSvyT0WkEOEEDL53Hr/BfcxNMbYkL+r0VfcRHhebQRvNks/J5HqfGsJmrELp+SUjwXu5fU+9fu+A/uuc+VgslLdOtVeOHEbSiJCKZt+/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=goH6FTUc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="goH6FTUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778561958; x=1810097958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LFJ9JbRzEy7jmD3+7XS3GK537ULYM7NySB5HHr4HX6U=;
  b=goH6FTUc84exCq5WtPH+jipJFhuVeSi9czwmXyU9T8c/tSCElIjHA7T0
   8shA0mzay4yunuGrHg53El0zon7+t8/jt8o53gGK/TR6tWzk4dB4ZpgEj
   uXnyja6pZHj2+GPxTmh6V/XqMoHDrAosk8AmE+4F/ZG02dyf6DIzBwtz/
   9YkDrJReNtQ/Vj2Bkl5U/L5iDdsWEV17U6wAK9OKJy3j0zQ6KzrjMOZX8
   G5CB1ePREsDazjpEqo+n3MxAvf7oeoyQyeeHws1T5vcTRSuik5QXXeXUD
   /E7GHvpIiIN7iLQZ1XmAl5Y56G5bWf6iZdktVVMwWxMdRPnqRpCUPJwOG
   w==;
X-CSE-ConnectionGUID: mDenUyvsRU66yCdCGqBLdQ==
X-CSE-MsgGUID: QqnVvuNoT4OG9HK+Lsa43A==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="66990196"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="66990196"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:59:17 -0700
X-CSE-ConnectionGUID: TfAIEZKWQTmNYaUJ14lLwQ==
X-CSE-MsgGUID: MxwqVamxTQWZ9eQnZIK+NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="236677716"
Received: from unknown (HELO [10.238.3.169]) ([10.238.3.169])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:59:14 -0700
Message-ID: <44d5687e-dcd4-491d-b5f6-0e9bf7393563@linux.intel.com>
Date: Tue, 12 May 2026 12:59:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs
 entirely within KVM
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
 <20260508231353.406465-8-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260508231353.406465-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/9/2026 7:13 AM, Sean Christopherson wrote:
> Now that perf operates on a KVM-provided snapshot of PMU state, handled
> cross-mapped PEBS counters entirely in KVM by clearing unusable counters
> from the to-be-enabled mask instead of foisting the work on perf.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c      |  8 --------
>  arch/x86/include/asm/perf_event.h |  1 -
>  arch/x86/kvm/vmx/vmx.c            | 10 ++++++++--
>  3 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index e9acfc3f3a82..8f6be0cc4c4b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5053,14 +5053,6 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
>  			  ~cpuc->intel_ctrl_exclude_guest_mask &
>  			  cpuc->intel_ctrl_exclude_host_mask;
>  
> -	/*
> -	 * Disable counters where the guest PMC is different than the host PMC
> -	 * being used on behalf of the guest, as the PEBS record includes
> -	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> -	 * wrong counter(s).
> -	 */
> -	guest_pebs_mask &= ~guest_pebs->cross_mapped_mask;
> -
>  	/*
>  	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
>  	 *        of disabling guest PEBS entirely if the host is using PEBS.
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index bc7e48f6f4a8..19f874a79ab0 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -790,7 +790,6 @@ struct x86_guest_pebs {
>  	u64	enable;
>  	u64	ds_area;
>  	u64	data_cfg;
> -	u64	cross_mapped_mask;
>  };
>  #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
>  extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9f0a028cf10b..fbe3ce5f5a51 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7319,8 +7319,14 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
>  		.data_cfg = pmu->pebs_data_cfg,
>  	};
>  
> -	if (pmu->pebs_enable & pmu->global_ctrl)
> -		guest_pebs.cross_mapped_mask = intel_pmu_get_cross_mapped_mask(pmu);
> +	/*
> +	 * Disable counters where the guest PMC is different than the host PMC
> +	 * being used on behalf of the guest, as the PEBS record includes
> +	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> +	 * wrong counter(s).
> +	 */
> +	if (guest_pebs.enable & pmu->global_ctrl)
> +		guest_pebs.enable &= ~intel_pmu_get_cross_mapped_mask(pmu);
>  
>  	/* Note, nr_msrs may be garbage if perf_guest_get_msrs() returns NULL. */
>  	msrs = perf_guest_get_msrs(&nr_msrs, &guest_pebs);

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


