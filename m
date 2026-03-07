Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BF2D0C98;
	Sat,  7 Mar 2026 01:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846854; cv=none; b=EGi0jn7T+8Aci5WVI/wWVdryiZgmLw7WHd4lIEm6VMnaxWGKAAzI7HkFGekFyG2PBVj7wLnQHG57qmFsL57EhFqT/7zJaS221HEJMOEg+yoK+ax7mrnCWirdA8rImpnfIOskzoxtjQGVeFUwg6Z/SynE1xnD06S4rxsVSRKu7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846854; c=relaxed/simple;
	bh=B00VZkMY+tokLm76I5cAhksLYuCxNysByVSjWAn43z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/5JG4nm+rIlD54I/E62sRCDEgovU1IWQWe3kWqP0cOUt6HxtRrSU7h8cBvaJN6ae9RrLtVEw2yrPMEZw1hIU2eYVaLKtGAtio6fjJWk1T6CejO+frpDtd+XGCCXawOz1IfPShE9UemcaQ1zTJnr/M9dXV4shFcTXdZaNU0o4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNQ4QaGi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNQ4QaGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772846853; x=1804382853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B00VZkMY+tokLm76I5cAhksLYuCxNysByVSjWAn43z0=;
  b=XNQ4QaGiaEkYKuKx5oZ9Ulyu15Ac3oZHU7zWXitvukpvGGrFPAHcZaF1
   NxmKLq6Ys8WLF161aL46WQdt88l5DxhuUkq+iZq8fKkbfmBxSmfW19y7c
   QZRTT3CueJSDwlzv0kx7iVqGh4I1hpsnbmtap/RfL3/Jsjq+uS29P/oa/
   2ypjfx1DvTEmjM9AN6LdnKGBl+RDiBkBvTSF9Q9x4R0Nfk2h7YXnRRXOP
   7t6VY0oKhbYPDbkB/ifjfV6j2dRo7soogGnFniS8rXovHJ1RannylDzvG
   Q9V36bKurcedaIHJolafzB8BYvmRftmFKv+OWKx5+5YZ1I1ZxupSWBXjn
   A==;
X-CSE-ConnectionGUID: rpyqNsO2T4KFtg2e+K8V/w==
X-CSE-MsgGUID: FbkSe3RKQqGue/lQXN0wAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73878272"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73878272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 17:27:33 -0800
X-CSE-ConnectionGUID: cXKbv+2oSKKyWXaH55aqxw==
X-CSE-MsgGUID: pLXKST8oRUeiXFMB2786Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="219158073"
Received: from unknown (HELO [10.241.240.211]) ([10.241.240.211])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 17:27:33 -0800
Message-ID: <3b101b08-7c31-4bc0-80ff-4d3cd5f7897f@intel.com>
Date: Fri, 6 Mar 2026 17:27:32 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch 1/2] perf/x86/intel: Only check GP counters for
 PEBS constraints validation
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260228053320.140406-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/2026 9:33 PM, Dapeng Mi wrote:
> It's good enough to only check GP counters for PEBS constraints
> validation since constraints overlap can only happen on GP counters.
> 
> Besides opportunistically refine the code style and use pr_warn() to
> replace pr_info() as the message itself is a warning message.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

LGTM.

Reviewed-by: Zide Chen <zide.chen@intel.com>

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

