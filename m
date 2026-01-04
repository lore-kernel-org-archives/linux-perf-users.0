Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF3924A066;
	Sun,  4 Jan 2026 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493623; cv=none; b=msrNSV2kRezBQvYpFanKhtpmry5QyAhbkL3gDYC3zSVI3dg7gMHlZehAXSEJ3DxvV/plYUx8VBUhczILLz56dnCFZoEZGaMIiMEj1zWFJIfEe5QOFbW9BDTwlPYhAQKli852J/sADW6E4igia+1qn9cKCdIrouLte/Q8Z+Quc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493623; c=relaxed/simple;
	bh=VKniHd5iQ1c8qoQ3hvtdSeZOd6P4CvqvuC/shIWUhnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toR6NcpsBAYzPPFh7aAB756A9PHLjHIY+5Iuji5IpICecojr2HmCrd+EG2x/E2xAcG5VrK+3a7NuPtue8oT10rVfjBKWMLzzl49r8cF8NzG1jdtDg8AKR8/55BiSn7oBbBbzsgK9+u4ynXMD7C3BNDMM7WIQw0dOVfTJqiCAMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAiCskf5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAiCskf5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767493622; x=1799029622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VKniHd5iQ1c8qoQ3hvtdSeZOd6P4CvqvuC/shIWUhnY=;
  b=VAiCskf5aOq5a6gkmqgOTq3Rum9pFOmv7Jyjyyz6nufrQa740qtBcrYH
   pdUs9IdBBMMRab2cL2x1mtJWXDpuXM4mvDicOFdYJiR6lZ60gJC1wbpWr
   M4W8moNkZ5S5ijsfmi4RvZ18d1emrgOATf5ZuReS4DY4g56C3v3Y2huB8
   Ie2V3yMueQom3UZSg+Oa6gv9Lc6dhNXjPQ3pn+yAeuITmOFNtji2A/W8q
   6c0gEpLRn6FJYI6HlSUBJ1cQfxDyQgrU+RgOZlN+vyxEpPx7HQ4ucsSrP
   s6mvM51Pz3hzYQM8eeNCfebskVLaxJvrgZTO0bZDYrdEP5lMZ/tO6bx6K
   Q==;
X-CSE-ConnectionGUID: wfWfWPzGQn2PYl8mEXOOdg==
X-CSE-MsgGUID: 0yOYZa53QdSMhTaQif7Y+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="72769522"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="72769522"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:27:00 -0800
X-CSE-ConnectionGUID: L6OKyH4fQ2yO3O9sVtVVSA==
X-CSE-MsgGUID: 7G6HkHxiT6yxw/zznjQDbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="206969912"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:26:57 -0800
Message-ID: <dc5edcc0-0bb9-4ec1-981f-ae9a5530dddd@linux.intel.com>
Date: Sun, 4 Jan 2026 10:26:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/13] perf/x86/intel/uncore: Add domain global init
 callback
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-7-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251231224233.113839-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/1/2026 6:42 AM, Zide Chen wrote:
> In the Intel uncore self-describing mechanism, the Global Control
> Register freeze_all bit is SoC-wide and propagates to all uncore PMUs.
>
> On Diamond Rapids, this bit is set at power-on, unlike some prior
> platforms.  Add a global_init callback to unfreeze all PMON units.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2: New patch
>
>  arch/x86/events/intel/uncore.c           | 16 ++++++++++++++++
>  arch/x86/events/intel/uncore.h           |  2 ++
>  arch/x86/events/intel/uncore_discovery.c |  3 +++
>  3 files changed, 21 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 1565c0418fb1..080b6870a88d 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1697,6 +1697,21 @@ static int __init uncore_mmio_init(void)
>  	return ret;
>  }
>  
> +static int uncore_mmio_global_init(u64 ctl)
> +{
> +	void __iomem *io_addr;
> +
> +	io_addr = ioremap(ctl, sizeof(ctl));
> +	if (!io_addr)
> +		return -ENOMEM;
> +
> +	/* Clear bit 0, all other bits are reserved */

Better make the comment clearer, like this.

/* Clear freeze bit (bit 0) to enable all counters. */

Others look good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



> +	writel(0, io_addr);
> +
> +	iounmap(io_addr);
> +	return 0;
> +}
> +
>  static const struct uncore_plat_init nhm_uncore_init __initconst = {
>  	.cpu_init = nhm_uncore_cpu_init,
>  };
> @@ -1839,6 +1854,7 @@ static const struct uncore_plat_init dmr_uncore_init __initconst = {
>  	.domain[0].units_ignore = dmr_uncore_imh_units_ignore,
>  	.domain[1].discovery_base = CBB_UNCORE_DISCOVERY_MSR,
>  	.domain[1].units_ignore = dmr_uncore_cbb_units_ignore,
> +	.domain[1].global_init = uncore_mmio_global_init,
>  };
>  
>  static const struct uncore_plat_init generic_uncore_init __initconst = {
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 83d01a9cefc0..55e3aebf4b5e 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -51,6 +51,8 @@ struct uncore_discovery_domain {
>  	/* MSR address or PCI device used as the discovery base */
>  	u32	discovery_base;
>  	bool	base_is_pci;
> +	int	(*global_init)(u64 ctl);
> +
>  	/* The units in the discovery table should be ignored. */
>  	int	*units_ignore;
>  };
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 6f409e0b4722..3a5a3876b74c 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -286,6 +286,9 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>  	if (!io_addr)
>  		return -ENOMEM;
>  
> +	if (domain->global_init && domain->global_init(global.ctl))
> +		return -ENODEV;
> +
>  	/* Parsing Unit Discovery State */
>  	for (i = 0; i < global.max_units; i++) {
>  		memcpy_fromio(&unit, io_addr + (i + 1) * (global.stride * 8),
