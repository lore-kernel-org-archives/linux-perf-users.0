Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371461EA65;
	Sun,  4 Jan 2026 02:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767492204; cv=none; b=GOJQ2hPWgOBFsaAjs/EEjfs9vGeGvEDWCNC4Evm331E9SBDwDBOoQTjPymsWvwZC0/b+6pJZyzaeopWNAoCwMXoOVCOwRaeVNejgSssCaO47wiUhfGf13lGvDnmkq0wEIkrxSjG76ziCxw8Stf2NWluCBs6SRIvAojDNwSgFqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767492204; c=relaxed/simple;
	bh=CdEwyOjXwEqagbEAJ1XbH3ZgR5+11jShTsbYAXgu8UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRw4VHS4xmuzx4IHIPe1m0yTFN7zUaoh2qLwZy0ffKfkhzmW+3olYiTvTFtweQ7xaTNcg2QBzmeQm9V2ZnIQ3GPRttpiEWsXQBnuG5JVAppAFMT1GKgohBWfQP3GkMEiR3Kg0JCJDhvuoZozfj57bajBboJbkA9ZjajWJA5AW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDscW39s; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDscW39s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767492202; x=1799028202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CdEwyOjXwEqagbEAJ1XbH3ZgR5+11jShTsbYAXgu8UE=;
  b=fDscW39sTywaYQaOb5F4lVWCWHp11UOCaiM/ZejuMpr3KZa/0DxMKsxy
   WhriKUjO6pEX1PwqY4BEHarO7qFRMyHLFrusesxQOe0tACIB/AYOOaWgk
   qKm5EfpEU25WlZL5OKmLKFUF+oDfvVQ61SBGWLEjg64c3lOj48L6bPaS+
   wb1OvlbK5siXi3eyfxzkY7zHEuDaVlva7fswb9xUhr5HzH93NjZTTSVHr
   zEYJMd6/6PSZr9raAxSEO9s2N+NcleNI+zQ2hZys1xtlaxQKeltDXEvbS
   8DRkTRh+Zp3SbNlBZERQ4+LRbgSY5BBI3sYAnDVE0DEpNVnIGuX+8OJpe
   A==;
X-CSE-ConnectionGUID: ukiEdg+hRcCj7e3gHZdDfQ==
X-CSE-MsgGUID: A4C5/ghfQ32K1qMc1CWo6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="71493292"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="71493292"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:03:22 -0800
X-CSE-ConnectionGUID: /Oxe92g2RCSmhA/3csC6+A==
X-CSE-MsgGUID: fC0omfg5TOeFllq9cMCQVg==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:03:18 -0800
Message-ID: <2a33e952-db37-43f3-943c-545360c3b682@linux.intel.com>
Date: Sun, 4 Jan 2026 10:03:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 03/13] perf/x86/intel/uncore: Remove
 has_generic_discovery_table()
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251231224233.113839-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/1/2026 6:42 AM, Zide Chen wrote:
> In the !x86_match_cpu() fallback path, has_generic_discovery_table()
> is removed because it does not handle multiple PCI devices.  Instead,
> use PCI_ANY_ID in generic_uncore_init[] to probe all PCI devices.
>
> For MSR portals, only probe MSR 0x201e to keep the fallback simple, as
> this path is best-effort only.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2: Separate patch from [PATCH V1 1/7]
> - Move has_generic_discovery_table() related code to its own patch for
>   easier review.
>
>  arch/x86/events/intel/uncore.c           |  3 ++
>  arch/x86/events/intel/uncore_discovery.c | 42 +++++-------------------
>  2 files changed, 12 insertions(+), 33 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 844030ef87c4..2a1c6dce8a35 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1835,6 +1835,9 @@ static const struct uncore_plat_init generic_uncore_init __initconst = {
>  	.cpu_init = intel_uncore_generic_uncore_cpu_init,
>  	.pci_init = intel_uncore_generic_uncore_pci_init,
>  	.mmio_init = intel_uncore_generic_uncore_mmio_init,
> +	.domain[0].base_is_pci = true,
> +	.domain[0].discovery_base = PCI_ANY_ID,
> +	.domain[1].discovery_base = UNCORE_DISCOVERY_MSR,
>  };
>  
>  static const struct x86_cpu_id intel_uncore_match[] __initconst = {
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 3bcbf974d3a8..6f409e0b4722 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -12,24 +12,6 @@
>  static struct rb_root discovery_tables = RB_ROOT;
>  static int num_discovered_types[UNCORE_ACCESS_MAX];
>  
> -static bool has_generic_discovery_table(void)
> -{
> -	struct pci_dev *dev;
> -	int dvsec;
> -
> -	dev = pci_get_device(PCI_VENDOR_ID_INTEL, UNCORE_DISCOVERY_TABLE_DEVICE, NULL);
> -	if (!dev)
> -		return false;
> -
> -	/* A discovery table device has the unique capability ID. */
> -	dvsec = pci_find_next_ext_capability(dev, 0, UNCORE_EXT_CAP_ID_DISCOVERY);
> -	pci_dev_put(dev);
> -	if (dvsec)
> -		return true;
> -
> -	return false;
> -}
> -
>  static int logical_die_id;
>  
>  static int get_device_die_id(struct pci_dev *dev)
> @@ -358,12 +340,7 @@ static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
>  	struct pci_dev *dev = NULL;
>  	bool parsed = false;
>  
> -	if (domain->discovery_base)
> -		device = domain->discovery_base;
> -	else if (has_generic_discovery_table())
> -		device = UNCORE_DISCOVERY_TABLE_DEVICE;
> -	else
> -		device = PCI_ANY_ID;
> +	device = domain->discovery_base;
>  
>  	/*
>  	 * Start a new search and iterates through the list of
> @@ -406,7 +383,7 @@ static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
>  {
>  	unsigned long *die_mask;
>  	bool parsed = false;
> -	int cpu, die, msr;
> +	int cpu, die;
>  	u64 base;
>  
>  	die_mask = kcalloc(BITS_TO_LONGS(uncore_max_dies()),
> @@ -414,16 +391,13 @@ static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
>  	if (!die_mask)
>  		return false;
>  
> -	msr = domain->discovery_base ?
> -	      domain->discovery_base : UNCORE_DISCOVERY_MSR;
> -
>  	cpus_read_lock();
>  	for_each_online_cpu(cpu) {
>  		die = topology_logical_die_id(cpu);
>  		if (__test_and_set_bit(die, die_mask))
>  			continue;
>  
> -		if (rdmsrq_safe_on_cpu(cpu, msr, &base))
> +		if (rdmsrq_safe_on_cpu(cpu, domain->discovery_base, &base))
>  			continue;
>  
>  		if (!base)
> @@ -446,10 +420,12 @@ bool uncore_discovery(struct uncore_plat_init *init)
>  
>  	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
>  		domain = &init->domain[i];
> -		if (!domain->base_is_pci)
> -			ret |= uncore_discovery_msr(domain);
> -		else
> -			ret |= uncore_discovery_pci(domain);
> +		if (domain->discovery_base) {
> +			if (!domain->base_is_pci)
> +				ret |= uncore_discovery_msr(domain);
> +			else
> +				ret |= uncore_discovery_pci(domain);
> +		}
>  	}
>  
>  	return ret;

LGTM. 

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


