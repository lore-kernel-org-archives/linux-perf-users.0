Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0FA2DAFA9;
	Thu, 28 May 2026 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950824; cv=none; b=EDrLo+Ysb+rdwxnFOksWkbE6i0/feML4r0pxK2/zPO6OJTXYV1e5+UxXFhmKPPXxqwlCkBNE7f9FY8mskpcz/AlKl+8RMxIP4MiAX5onj84EF7T/eBNoTUtCJ+O0YPyGbgYacxvgv3BJH2fZEnSC3sk2JbGm5HIycFfr+i9a/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950824; c=relaxed/simple;
	bh=8ECSsgntb8bFsVpcc1EZDrg2NEzVJD89sATTSwDwrWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbJYKIyTi0Z3p0cxsDpvSc6gHLddbS6riw7S5eVGjtXe11KrUBa5x6ZFG7Gd1zVoog+HY8CojiuRbpSF3YM6ilLTxDx1SnE/S4AkJJ+dDxFmFoQh5JMi2egrZGYW7sxkxXYtmgOsFSt05nqCI31TFFaTdEFJGrFWnwrnjWLRlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPvBiN30; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPvBiN30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779950823; x=1811486823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ECSsgntb8bFsVpcc1EZDrg2NEzVJD89sATTSwDwrWc=;
  b=LPvBiN30Fly8My7rvVAVqEYEcBUTp63A+3VeBZK4Ho0ZaDTSpVXPf04G
   iHiKM40hYpZ2loZB8XgOCNQBdlT3m2i2ljpr8hjmb+tzgAeDlOXnNvEUZ
   31YkPglK8kL5xN+/dw8B+6U0xloU5696DBiks0kAsnOXbTLQiKVi1TSku
   FyH//cbBDvir1JGaxqmT4R85EPTt92QAK94PRTxQm3zea3y1dc2mwdFB1
   N0RQQklMIN2t74jk1mL+eFFB9Mv74wobORW2oRd9ixicOGMo9l9+k2IsV
   Lqe+uthM0p8DVPcvInCBFTkMWkiWRwSPt4VM0i3Ux5ecgnXxlmmJ7waLm
   A==;
X-CSE-ConnectionGUID: wXYnyK+CT5mX0na+9zk/Kg==
X-CSE-MsgGUID: 86dJt7bnQfus2dOtKg84JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84647415"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="84647415"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:46:44 -0700
X-CSE-ConnectionGUID: JEhX145USdSXCMeZD+4JFg==
X-CSE-MsgGUID: 58VO9UflReqSi85/WjGDMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="247541531"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:46:41 -0700
Message-ID: <507feaea-25fc-4111-a39b-648ce44e3316@linux.intel.com>
Date: Thu, 28 May 2026 14:46:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-7-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260527151154.130505-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/27/2026 11:11 PM, Zide Chen wrote:
> On Sierra Forest and Clearwater Forest, the FRZ_ALL bit in the global
> control register defaults to 0 at boot, but UBOX PMON units do not
> work until the global control register is explicitly written with 0
> to trigger hardware initialization properly.
>
> Implement the generic uncore_msr_global_init() callback and add it to
> gnr_uncore_init[], which is shared by GNR, GRR, SRF, and CWF.

Need a "Fixes" tag?

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - Propagate return value of wrmsrq_on_cpu() to global_init().
> ---
>  arch/x86/events/intel/uncore.c           | 13 ++++++++++++-
>  arch/x86/events/intel/uncore.h           |  2 +-
>  arch/x86/events/intel/uncore_discovery.c |  2 +-
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 4b3a1fa5b41b..7857959c6e82 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1716,7 +1716,7 @@ static int __init uncore_mmio_init(void)
>  	return ret;
>  }
>  
> -static int uncore_mmio_global_init(u64 ctl)
> +static int uncore_mmio_global_init(int die, u64 ctl)
>  {
>  	void __iomem *io_addr;
>  
> @@ -1731,6 +1731,16 @@ static int uncore_mmio_global_init(u64 ctl)
>  	return 0;
>  }
>  
> +static int uncore_msr_global_init(int die, u64 msr)
> +{
> +	int cpu = uncore_die_to_cpu(die);
> +
> +	if (cpu == -1)
> +		return -ENODEV;
> +
> +	return wrmsrq_on_cpu(cpu, msr, 0);
> +}
> +
>  static const struct uncore_plat_init nhm_uncore_init __initconst = {
>  	.cpu_init = nhm_uncore_cpu_init,
>  };
> @@ -1871,6 +1881,7 @@ static const struct uncore_plat_init gnr_uncore_init __initconst = {
>  	.domain[0].base_is_pci = true,
>  	.domain[0].discovery_base = UNCORE_DISCOVERY_TABLE_DEVICE,
>  	.domain[0].units_ignore = gnr_uncore_units_ignore,
> +	.domain[0].global_init = uncore_msr_global_init,
>  };
>  
>  static const struct uncore_plat_init dmr_uncore_init __initconst = {
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 94c68e3417b6..c2e5ccb1d72c 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -53,7 +53,7 @@ struct uncore_discovery_domain {
>  	/* MSR address or PCI device used as the discovery base */
>  	u32	discovery_base;
>  	bool	base_is_pci;
> -	int	(*global_init)(u64 ctl);
> +	int	(*global_init)(int die, u64 ctl);
>  
>  	/* The units in the discovery table should be ignored. */
>  	int	*units_ignore;
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index af2217b44a81..e36613d934b1 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -287,7 +287,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>  	if (!io_addr)
>  		return -ENOMEM;
>  
> -	if (domain->global_init && domain->global_init(global.ctl)) {
> +	if (domain->global_init && domain->global_init(die, global.ctl)) {
>  		ret = -ENODEV;
>  		goto out;
>  	}
