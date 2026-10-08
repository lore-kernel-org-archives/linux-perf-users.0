Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019264CB8D7;
	Thu,  8 Oct 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472382; cv=none; b=C6wFuCuTv2aUp/PmElDzYjqj58vFiPC07TjcVHEnx6nt5zxjF9KS6kpPVtf7/e6hSUWp1IJ+Z0vrm61YOiQGesmaaBQuodqFJn+fkVHiowC/mwOMXZwk7d20eTOlDLcCKttvrVzON5V+aG1pLsjfag9GZk0QlyD+fDjW+JQV9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472382; c=relaxed/simple;
	bh=S8Qj4JiVGmSAKNEHAdb2Qw61sB9GI38imUB2dF/Oqjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JweDmZET5oBMC9fN7djeedgd4a1F3WI39nEjfSRYeBPHkQLecbDXcl/I+Tw9nyGeZYTdIDKh4jDfbHIIgjhtxDD5ZiJNmUfxf+oaWyECZp1h4zk31BpRp0cwJLPEH7l4xgWiK00rTJOXWjXwBBeg1+qn2kGcGGWLpSvcUgfEv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2dIpx99; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2dIpx99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791472375; x=1823008375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S8Qj4JiVGmSAKNEHAdb2Qw61sB9GI38imUB2dF/Oqjo=;
  b=m2dIpx9936NO7BOs0z9l1uDVhZgMvEYBstCI5PwzFzv83up6lq9mQXxN
   7g2h5mtTmgUj8ldcSaTUK2eF53XL8/2MeWTIlvk6qK1Wi97Bl4pPxcXYl
   F0wD1CRhzbYFi3cbuYcj4cVlh5tlIqPUKq0gFf37NwfSNukco04VRvkLv
   Fp5sBlmIIY3mANtR66SreObyI/jOi4wIH2yYbkhXNrSgZnFmEnZD5Cte/
   rCtU7LQkikNrW0+3rkdK5tJ6DEEP8muyOf3l33s4onhcyGwMGz/5rCDmQ
   34uG7vZ/1Esg+AsVm7lxs4MMHrOlpESIOmnXSIEFdQsDJhFy5pWjeq58L
   A==;
X-CSE-ConnectionGUID: GGW6VyVvTJiihNEhIG2I8w==
X-CSE-MsgGUID: GCpKoEq4Qe6ItmZEqrYRiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="256629"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="256629"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 08:12:50 -0700
X-CSE-ConnectionGUID: jijYxYCQSB2qODj8Eg8ZTg==
X-CSE-MsgGUID: 71MFXqMrTqevPhNcx3GKZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="427414"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 08:12:48 -0700
Message-ID: <bcb837c5-8a8d-4cba-9c14-73275c5a7bb0@intel.com>
Date: Thu, 8 Oct 2026 10:12:40 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix DMR CXL CM invert filter
To: Guixiong Wei <weiguixiong@bytedance.com>, peterz@infradead.org
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261008051953.6293-2-weiguixiong@bytedance.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20261008051953.6293-2-weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/8/2026 12:19 AM, Guixiong Wei wrote:
> The DMR CXL CM PMU places its invert filter at config bit 21 and its
> 9-bit threshold at bits 23-31. However, dmr_uncore_cxlcm uses
> GENERIC_PMON_RAW_EVENT_MASK, which covers the threshold through the
> generic bit 23 invert field and bits 24-31 threshold field, but does not
> include the relocated invert bit. As a result, uncore_pmu_event_init()
> silently clears bit 21 and inv=1 programs the same configuration as
> inv=0.
> 
> Add bit 21 to a DMR CXL CM-specific event mask so the requested invert
> filter reaches hardware.
> 
> Fixes: 6daf2c35b835 ("perf/x86/intel/uncore: Add IMH PMON support for Diamond Rapids")
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index a97cd029db366..1b460cf27a10f 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -474,6 +474,9 @@
>  /* DMR */
>  #define DMR_IMH1_HIOP_MMIO_BASE			0x1ffff6ae7000
>  #define DMR_HIOP_MMIO_SIZE			0x8000
> +#define DMR_CXLCM_PMON_CTL_INVERT		BIT(21)
> +#define DMR_CXLCM_PMON_RAW_EVENT_MASK		(GENERIC_PMON_RAW_EVENT_MASK | \
> +						 DMR_CXLCM_PMON_CTL_INVERT)
>  #define DMR_CXLCM_EVENT_MASK_EXT		0xf
>  #define DMR_HAMVF_EVENT_MASK_EXT		0xffffffff
>  #define DMR_PCIE4_EVENT_MASK_EXT		0xffffff
> @@ -6696,7 +6699,7 @@ static struct event_constraint dmr_uncore_cxlcm_constraints[] = {
>  
>  static struct intel_uncore_type dmr_uncore_cxlcm = {
>  	.name			= "cxlcm",
> -	.event_mask		= GENERIC_PMON_RAW_EVENT_MASK,
> +	.event_mask		= DMR_CXLCM_PMON_RAW_EVENT_MASK,

Thanks for the fix!

Reviewed-by: Zide Chen <zide.chen@intel.com>


>  	.event_mask_ext		= DMR_CXLCM_EVENT_MASK_EXT,
>  	.constraints		= dmr_uncore_cxlcm_constraints,
>  	.format_group		= &dmr_cxlcm_uncore_format_group,

