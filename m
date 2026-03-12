Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE532C937;
	Thu, 12 Mar 2026 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304132; cv=none; b=ObuhLWgodl3GZZLdZM7dJlT0pCP9EAdtxDrzqjqTC9HC7EgY9oWhjB2difPOAZwfBHKr0szbkTTnwERQ6rN4T0ICYi+mNancLHnFzJBbsdrWhbxgNQEd3lm6H6u1Byih2s6SLZ2xAkz+Mk2pgCNRRwQXeg8xWzhIVbAmYmb3JJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304132; c=relaxed/simple;
	bh=R7ysTWfJIPnh+yO7eGb9CDGeRBq9sP/0ksJM6klNF8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgYTWDfvbAGuQl7jOkc3jix2g2Mer676AKVOGuE0pVNUmTqohwuD0AdI1cuF/Mkt9g4J68SOp71HHAbCTkKdnNlxYSNBsOw7TB8okcWsQIouJh88Wf10V6mNHjXdlK0BiisSZTTRNy8sPZbQytiVzetVEV59NeTaWGTh+SXt2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX/OUBCC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX/OUBCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773304132; x=1804840132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R7ysTWfJIPnh+yO7eGb9CDGeRBq9sP/0ksJM6klNF8c=;
  b=OX/OUBCCmGOFRidhnRh7ONf2e3AvjmUdL/PU0opB8F+57H/HGh6zP70g
   TKdQO7XvIdm3i4GWPETzLS3cjgLx0QGaz1aDlFkEnTOjvxL511+xfPqkT
   c1aD+mmc4wGdWTLIS474x56jHgZpWlYLRuGuWeSsa4S4kv0I/A0IFQLvR
   cnKujt9JuUWqYpPvgQxfJftyr+nG7q5DjEB94/zhDCVR+my+Ru7XzSIGA
   KEPXuX9g8+hhTx7RNInyuGxtzhDhWAbWpvA8gTaMKvLhnuRd0PcLhxieg
   +w3NjEGWmbBLPExT+KtYKQUEg6is3ClU0AVxpBaYMYXhoXkBat4OW+cy7
   Q==;
X-CSE-ConnectionGUID: fHzoQchKTt6I4eaUwEi3ww==
X-CSE-MsgGUID: j7shwX09Tz+megTXJwFTcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74087544"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="74087544"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:28:51 -0700
X-CSE-ConnectionGUID: 0qtexKuCSU2gm0XwTieiTg==
X-CSE-MsgGUID: dU5RzPh2R5aUqHTR+sFehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="216894433"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 01:28:47 -0700
Message-ID: <c718111d-b836-4e03-b42c-5b86d409b6bc@linux.intel.com>
Date: Thu, 12 Mar 2026 16:28:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch 1/2] perf/x86/intel: Only check GP counters for
 PEBS constraints validation
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Could you please review and merge this change? This change suppose to be
low risky. Without this change, the dynamic constraints check would trigger
false positive on DMR/NVL. Thanks.


On 2/28/2026 1:33 PM, Dapeng Mi wrote:
> It's good enough to only check GP counters for PEBS constraints
> validation since constraints overlap can only happen on GP counters.
>
> Besides opportunistically refine the code style and use pr_warn() to
> replace pr_info() as the message itself is a warning message.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cf3a4fe06ff2..4768236c054b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5770,7 +5770,7 @@ static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
>  			}
>  
>  			if (check_fail) {
> -				pr_info("The two events 0x%llx and 0x%llx may not be "
> +				pr_warn("The two events 0x%llx and 0x%llx may not be "
>  					"fully scheduled under some circumstances as "
>  					"%s.\n",
>  					c1->code, c2->code, dyn_constr_type_name[type]);
> @@ -5783,6 +5783,7 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
>  				       struct event_constraint *constr,
>  				       u64 cntr_mask)
>  {
> +	u64 gp_mask = GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
>  	enum dyn_constr_type i;
>  	u64 mask;
>  
> @@ -5797,20 +5798,25 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
>  				mask = x86_pmu.lbr_counters;
>  			break;
>  		case DYN_CONSTR_ACR_CNTR:
> -			mask = hybrid(pmu, acr_cntr_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
> +			mask = hybrid(pmu, acr_cntr_mask64) & gp_mask;
>  			break;
>  		case DYN_CONSTR_ACR_CAUSE:
> -			if (hybrid(pmu, acr_cntr_mask64) == hybrid(pmu, acr_cause_mask64))
> +			if (hybrid(pmu, acr_cntr_mask64) ==
> +					hybrid(pmu, acr_cause_mask64))
>  				continue;
> -			mask = hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
> +			mask = hybrid(pmu, acr_cause_mask64) & gp_mask;
>  			break;
>  		case DYN_CONSTR_PEBS:
> -			if (x86_pmu.arch_pebs)
> -				mask = hybrid(pmu, arch_pebs_cap).counters;
> +			if (x86_pmu.arch_pebs) {
> +				mask = hybrid(pmu, arch_pebs_cap).counters &
> +				       gp_mask;
> +			}
>  			break;
>  		case DYN_CONSTR_PDIST:
> -			if (x86_pmu.arch_pebs)
> -				mask = hybrid(pmu, arch_pebs_cap).pdists;
> +			if (x86_pmu.arch_pebs) {
> +				mask = hybrid(pmu, arch_pebs_cap).pdists &
> +				       gp_mask;
> +			}
>  			break;
>  		default:
>  			pr_warn("Unsupported dynamic constraint type %d\n", i);
>
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
