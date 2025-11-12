Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBF1C84BC;
	Wed, 12 Nov 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978030; cv=none; b=dJaXX+QinH3YMGC7+lFps9TuF3x2ut4g7motSBYPGMPy5QPZJ1Dp0PlmuaD0WhQQ0OLufZIId5wMBSVTQRptG163DCUIl2Wz696hbgjix5Jvi2ZLI8rWA4U2L/BH29WN9LGUUSlK/CQJH4G4L9zr08xUPCZrQnmnw83VX2G9CyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978030; c=relaxed/simple;
	bh=lNrADTAjHCL/8ph+gaFxK81xVCY1Yx3FkCYSO+ujXoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edF25K7YZs/6vLy+zZNZ5n6TgheH/oB8Tb6iRCdguXTlngE1SLe949rCYo81Him16l91ySaPPr0I/5jl7PIXkqXUw/F6oeUXEWi2ACFL2ReieLkXfGKILFHvx4YcTSFVpTH38xNWVZN/WQxNxNLZ2NPyOerMQFv1R0GsnX8Tx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9p2GEhh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9p2GEhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762978028; x=1794514028;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lNrADTAjHCL/8ph+gaFxK81xVCY1Yx3FkCYSO+ujXoo=;
  b=f9p2GEhhnlmU0QF7b2INt/Cp672Y0Yw3J7JPlKpMmHwCrQHtoyp3nGjh
   lhBfjs0sJX2StQygvZiKPavNiKO0wOjiDr/Z3iLpGPiDMnwmh4UzSrGeU
   g32ImTm9HG2vOxQ4/1tAB0xwzOKeP5b9nqKlsKxrXBSgEWFH22ZE4+kzz
   /cIEeYulluK8hVLm/F4WqacAeq0amOkXzlaqJkvJ04KsyeZRgWxC7cADU
   wldEgDhoyG/LmO0h8C2hnt/W2D8RbPWVeNF4Wahiii/wZsVYafuSfgMHU
   GDmpm2/ithU3Kts4yB3N7CREEcCtE/ci3D8T8wAtxjslf/XR5afucWDjt
   A==;
X-CSE-ConnectionGUID: ipP3JoBbS7OkgZ976gXwBA==
X-CSE-MsgGUID: HtJwK82kSDe/Wp6sU1y9rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75733766"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="75733766"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 12:07:08 -0800
X-CSE-ConnectionGUID: S8sPkm7mSD600uzD0O9gdg==
X-CSE-MsgGUID: CI0c+6CjQfmlpAplnocR5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="188599822"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.22]) ([10.125.108.22])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 12:07:07 -0800
Message-ID: <1ba407b6-a108-41ce-b1b2-3c03aa25d272@intel.com>
Date: Wed, 12 Nov 2025 12:07:07 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/events/intel/cstate: Add Pantherlake support
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112090024.3298186-1-kaushlendra.kumar@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20251112090024.3298186-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/25 01:00, Kaushlendra Kumar wrote:
> It supports the same C-state residency counters as Lunarlake.This
> enables monitoring of C1, C6, C7 core states and C2,C3,C6,C10
> package states residency counters on Pantherlake platforms.

Is this actually documented? Or is there just a smoke-filled room at
Intel somewhere where this is decided?

> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
> index ec753e39b007..b3582eeb6c4b 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -41,7 +41,7 @@
>   *	MSR_CORE_C1_RES: CORE C1 Residency Counter
>   *			 perf code: 0x00
>   *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
> - *					  MTL,SRF,GRR,ARL,LNL
> + *					  MTL,SRF,GRR,ARL,LNL,PTL

Could we get rid of these, please?

Folks can 100% figure this out from the data structures themselves.
Unless there's a compelling reason, this is pure churn.

> @@ -652,6 +653,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
>  	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&adl_cstates),
>  	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&adl_cstates),
>  	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_cstates),
> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&lnl_cstates),
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
Also, why *can't* this just be enumerated?
