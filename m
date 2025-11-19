Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC232B9BC;
	Wed, 19 Nov 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542595; cv=none; b=fSjSfJxmfru4u0+syVtdjOqYo2bYAeFR9tI1spHzrhIDWQohEKuEgS8SUrfjFHXDZXhq8wPNek5XuOM5xvJuI3Dr/slh6OGGpIguitEq75DsCyoJP64P3F6YTlwv4gwKt+E7UQ5QM/TwjSiB0hmXAOScCtxbGryZynqG/JpgeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542595; c=relaxed/simple;
	bh=IpYZ88/TiH83YFwORjBKN7geEfglftHaGiGpRG7AC4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQxIBZ4wQVyT1i4ETBQUEDe0iL1aaSLdWpDNfoVPQgU9F1sFbILqdEVbfc6iLdbBaIjHo1tRNuweQmxXBMSZtjocqqlaCReguKW6ThRNMoOu0jWycn4ZUyXfOLXedgvU573OFArj/ueMRiKAnLLqRTY7gbu3GCKrmgA+KXzgjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eD1MBvLr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eD1MBvLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763542594; x=1795078594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IpYZ88/TiH83YFwORjBKN7geEfglftHaGiGpRG7AC4M=;
  b=eD1MBvLrCr59QZNmzqnTVoMpte04VezjYv2czpNfvdU9fapgwaV8p8zY
   /OUOaUl0IYXHZF+QkkTf99JdjpxAcKj2OwoUz8VbXaY4tWP/PX1OlUa+L
   kwvNdDm3JIT2sifwtsgIbPmiEdN5FSOGd8B/ba64cu6niRnUVPudxEb1b
   4MiLyi8gpLvkIEMSqQYJ3LrK9XT5OU62DCHzMuOeB4dUWrHF03RTyFJTu
   S1h3T9+cqldXxixl92qOOK2oKlnreYAwps9l0y+BcFlirKTT5V58iKptX
   VWaV/1zFbPr9Azo1vOCowJG3sDUrjGH4lqSIm+/eKgeu5FGnnitV4Fzu8
   Q==;
X-CSE-ConnectionGUID: tjz3QIJGSMmkxT01eL8P6A==
X-CSE-MsgGUID: L7s4UdvpRUmcfPqSsRYhfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76932326"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="76932326"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 00:56:33 -0800
X-CSE-ConnectionGUID: TDX75HFFQ4egpRSB4GyKog==
X-CSE-MsgGUID: Sisz71N9RG2wPPiv0AKRRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190797401"
Received: from unknown (HELO [10.238.3.29]) ([10.238.3.29])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 00:56:29 -0800
Message-ID: <257afee5-f0ce-4311-9393-4f16084c07d0@linux.intel.com>
Date: Wed, 19 Nov 2025 16:56:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Only check GP counters for PEBS
 constraints validation
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251112004513.3279333-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251112004513.3279333-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Could you please review this patch? The PEBS constraints overlap validation
should be only limited in GP counters, otherwise it may cause some false
alarms on some platforms.

Thanks,

Dapeng Mi

On 11/12/2025 8:45 AM, Dapeng Mi wrote:
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
> index aad89c9d9514..81e6c8bcabde 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5506,7 +5506,7 @@ static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
>  			}
>  
>  			if (check_fail) {
> -				pr_info("The two events 0x%llx and 0x%llx may not be "
> +				pr_warn("The two events 0x%llx and 0x%llx may not be "
>  					"fully scheduled under some circumstances as "
>  					"%s.\n",
>  					c1->code, c2->code, dyn_constr_type_name[type]);
> @@ -5519,6 +5519,7 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
>  				       struct event_constraint *constr,
>  				       u64 cntr_mask)
>  {
> +	u64 gp_mask = GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
>  	enum dyn_constr_type i;
>  	u64 mask;
>  
> @@ -5533,20 +5534,25 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
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
> base-commit: 2093d8cf80fa5552d1025a78a8f3a10bf3b6466e
