Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42A1EA65;
	Sun,  4 Jan 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767492029; cv=none; b=O9EubgjfnlHsF/cVez9UkqJDupO+0VRgdy8RZ6+PV+wwvcJ9RCcgkbS/Om7WY41INGbN/PhbPGlQCrO5R8mXfdoGP/IWdBHwHgfX0GKp8smUjjGj1fVjNwsBuoFZs1T9ECQeDZ+dtrQiaNRFNTxKVNr8F/aEqzWMF2LikD1MovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767492029; c=relaxed/simple;
	bh=OmpWqGphfA7o5FctdWmK3u8HXro9Axgx+gqGfL4wlk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKtk7FPN5i4RQi6hW4vvJo08nP73LzEL5lzv7hRTDgC+LdIDalUfbC3FAXx8UmZQFX+zk1X/Jn7q0LH3il7gekyGhK2DuDPkwghB/z5Y61feaB45EaS36dONKKpv41ATYgUcHVCBSAVCigEjqfUIo8sFTZCk26cBUfy/4BFZKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n81pn7D0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n81pn7D0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767492027; x=1799028027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OmpWqGphfA7o5FctdWmK3u8HXro9Axgx+gqGfL4wlk4=;
  b=n81pn7D0baj5HMC6bSJj4O7a0Y6vL9c48STimBVQMZkb+mDmGacJL18n
   0KEIpyLAXnWsgw7ZniR5Lx0wsYTViAYaYfP8zjtQstScTrqPVW3HQzv/9
   y7uKykA9fWpJKae9bQtKkuIOekCsqOhDJnKSzho353MyxyrnKG8bjuPCW
   L8dK0ZRwCR52bTVMX9OR5W/fbAet3P5PQ73o0U2YYo0qEdgnUdethwQcY
   ipot2Hs8cfY0PlqxpD1SyYN3kG6g2NdE1hgUdhygyqxS6eew+mnBCjbG/
   KecrXaf0b+ooIlhdhcJtaom9ggLq0gyv9pZ1yzyAmqviVP9m7U25KXSDu
   w==;
X-CSE-ConnectionGUID: yRgveRzkSNC8UzNj1ohHnw==
X-CSE-MsgGUID: ltyVTNl3Ri6hHaDFKzJiEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="71493164"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="71493164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:00:26 -0800
X-CSE-ConnectionGUID: 68WFdj8BSN2oMDd23gY1eg==
X-CSE-MsgGUID: e5lRjWrZQ6O+MD4oKFWZqg==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:00:23 -0800
Message-ID: <ec9373cb-b8a4-4f23-affe-de27f40f8b28@linux.intel.com>
Date: Sun, 4 Jan 2026 10:00:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/13] perf/x86/intel/uncore: Support per-platform
 discovery base devices
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-3-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251231224233.113839-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/1/2026 6:42 AM, Zide Chen wrote:
> On DMR platforms, IMH discovery tables are enumerated via PCI, while
> CBB domains use MSRs, unlike earlier platforms which relied on either
> PCI or MSR exclusively.
>
> DMR also uses different MSRs and PCI devices, requiring support for
> multiple, platform-specific discovery bases.
>
> Introduce struct uncore_discovery_domain to hold the discovery base and
> other domain-specific configuration.
>
> Move uncore_units_ignore into uncore_discovery_domain so a single
> structure can be passed to uncore_discovery_[pci/msr].
>
> No functional change intended.
>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Introduce uncore_discovery_domain[] to support possible any
>   combination of MSR or PCI discovery base.
> - Move has_generic_discovery_table() related code to a separate patch
>   for easier review.
> - Update commit messages.
>
>  arch/x86/events/intel/uncore.c           | 32 ++++++++-----
>  arch/x86/events/intel/uncore.h           | 15 +++++--
>  arch/x86/events/intel/uncore_discovery.c | 57 +++++++++++++++---------
>  3 files changed, 69 insertions(+), 35 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index cd561290be8c..844030ef87c4 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1798,7 +1798,7 @@ static const struct uncore_plat_init lnl_uncore_init __initconst = {
>  static const struct uncore_plat_init ptl_uncore_init __initconst = {
>  	.cpu_init = ptl_uncore_cpu_init,
>  	.mmio_init = ptl_uncore_mmio_init,
> -	.use_discovery = true,
> +	.domain[0].discovery_base = UNCORE_DISCOVERY_MSR,
>  };
>  
>  static const struct uncore_plat_init icx_uncore_init __initconst = {
> @@ -1817,16 +1817,18 @@ static const struct uncore_plat_init spr_uncore_init __initconst = {
>  	.cpu_init = spr_uncore_cpu_init,
>  	.pci_init = spr_uncore_pci_init,
>  	.mmio_init = spr_uncore_mmio_init,
> -	.use_discovery = true,
> -	.uncore_units_ignore = spr_uncore_units_ignore,
> +	.domain[0].base_is_pci = true,
> +	.domain[0].discovery_base = UNCORE_DISCOVERY_TABLE_DEVICE,
> +	.domain[0].units_ignore = spr_uncore_units_ignore,
>  };
>  
>  static const struct uncore_plat_init gnr_uncore_init __initconst = {
>  	.cpu_init = gnr_uncore_cpu_init,
>  	.pci_init = gnr_uncore_pci_init,
>  	.mmio_init = gnr_uncore_mmio_init,
> -	.use_discovery = true,
> -	.uncore_units_ignore = gnr_uncore_units_ignore,
> +	.domain[0].base_is_pci = true,
> +	.domain[0].discovery_base = UNCORE_DISCOVERY_TABLE_DEVICE,
> +	.domain[0].units_ignore = gnr_uncore_units_ignore,
>  };
>  
>  static const struct uncore_plat_init generic_uncore_init __initconst = {
> @@ -1897,6 +1899,17 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
>  
> +static bool ucore_use_discovery(struct uncore_plat_init *config)
> +{
> +	int i;
> +
> +	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++)
> +		if (config->domain[i].discovery_base)
> +			return true;
> +
> +	return false;
> +}
> +
>  static int __init intel_uncore_init(void)
>  {
>  	const struct x86_cpu_id *id;
> @@ -1911,15 +1924,14 @@ static int __init intel_uncore_init(void)
>  
>  	id = x86_match_cpu(intel_uncore_match);
>  	if (!id) {
> -		if (!uncore_no_discover && uncore_discovery(NULL))
> -			uncore_init = (struct uncore_plat_init *)&generic_uncore_init;
> -		else
> +		uncore_init = (struct uncore_plat_init *)&generic_uncore_init;
> +		if (uncore_no_discover || !uncore_discovery(uncore_init))
>  			return -ENODEV;
>  	} else {
>  		uncore_init = (struct uncore_plat_init *)id->driver_data;
> -		if (uncore_no_discover && uncore_init->use_discovery)
> +		if (uncore_no_discover && ucore_use_discovery(uncore_init))
>  			return -ENODEV;
> -		if (uncore_init->use_discovery &&
> +		if (ucore_use_discovery(uncore_init) &&
>  		    !uncore_discovery(uncore_init))
>  			return -ENODEV;
>  	}
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 568536ef28ee..1574ffc7ee05 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -47,14 +47,21 @@ struct uncore_event_desc;
>  struct freerunning_counters;
>  struct intel_uncore_topology;
>  
> +struct uncore_discovery_domain {
> +	/* MSR address or PCI device used as the discovery base */
> +	u32	discovery_base;
> +	bool	base_is_pci;
> +	/* The units in the discovery table should be ignored. */
> +	int	*units_ignore;
> +};
> +
> +#define UNCORE_DISCOVERY_DOMAINS	2
>  struct uncore_plat_init {
>  	void	(*cpu_init)(void);
>  	int	(*pci_init)(void);
>  	void	(*mmio_init)(void);
> -	/* Discovery table is required */
> -	bool	use_discovery;
> -	/* The units in the discovery table should be ignored. */
> -	int	*uncore_units_ignore;
> +
> +	struct uncore_discovery_domain domain[UNCORE_DISCOVERY_DOMAINS];
>  };
>  
>  struct intel_uncore_type {
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index d39f6a0b8cc3..3bcbf974d3a8 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -259,23 +259,24 @@ uncore_insert_box_info(struct uncore_unit_discovery *unit,
>  }
>  
>  static bool
> -uncore_ignore_unit(struct uncore_unit_discovery *unit, int *ignore)
> +uncore_ignore_unit(struct uncore_unit_discovery *unit,
> +		   struct uncore_discovery_domain *domain)
>  {
>  	int i;
>  
> -	if (!ignore)
> +	if (!domain || !domain->units_ignore)
>  		return false;
>  
> -	for (i = 0; ignore[i] != UNCORE_IGNORE_END ; i++) {
> -		if (unit->box_type == ignore[i])
> +	for (i = 0; domain->units_ignore[i] != UNCORE_IGNORE_END ; i++) {
> +		if (unit->box_type == domain->units_ignore[i])
>  			return true;
>  	}
>  
>  	return false;
>  }
>  
> -static int __parse_discovery_table(resource_size_t addr, int die,
> -				   bool *parsed, int *ignore)
> +static int __parse_discovery_table(struct uncore_discovery_domain *domain,
> +				   resource_size_t addr, int die, bool *parsed)
>  {
>  	struct uncore_global_discovery global;
>  	struct uncore_unit_discovery unit;
> @@ -314,7 +315,7 @@ static int __parse_discovery_table(resource_size_t addr, int die,
>  		if (unit.access_type >= UNCORE_ACCESS_MAX)
>  			continue;
>  
> -		if (uncore_ignore_unit(&unit, ignore))
> +		if (uncore_ignore_unit(&unit, domain))
>  			continue;
>  
>  		uncore_insert_box_info(&unit, die);
> @@ -325,9 +326,9 @@ static int __parse_discovery_table(resource_size_t addr, int die,
>  	return 0;
>  }
>  
> -static int parse_discovery_table(struct pci_dev *dev, int die,
> -				 u32 bar_offset, bool *parsed,
> -				 int *ignore)
> +static int parse_discovery_table(struct uncore_discovery_domain *domain,
> +				 struct pci_dev *dev, int die,
> +				 u32 bar_offset, bool *parsed)
>  {
>  	resource_size_t addr;
>  	u32 val;
> @@ -347,17 +348,19 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
>  	}
>  #endif
>  
> -	return __parse_discovery_table(addr, die, parsed, ignore);
> +	return __parse_discovery_table(domain, addr, die, parsed);
>  }
>  
> -static bool uncore_discovery_pci(int *ignore)
> +static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
>  {
>  	u32 device, val, entry_id, bar_offset;
>  	int die, dvsec = 0, ret = true;
>  	struct pci_dev *dev = NULL;
>  	bool parsed = false;
>  
> -	if (has_generic_discovery_table())
> +	if (domain->discovery_base)
> +		device = domain->discovery_base;
> +	else if (has_generic_discovery_table())
>  		device = UNCORE_DISCOVERY_TABLE_DEVICE;
>  	else
>  		device = PCI_ANY_ID;
> @@ -386,7 +389,7 @@ static bool uncore_discovery_pci(int *ignore)
>  			if (die < 0)
>  				continue;
>  
> -			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
> +			parse_discovery_table(domain, dev, die, bar_offset, &parsed);
>  		}
>  	}
>  
> @@ -399,11 +402,11 @@ static bool uncore_discovery_pci(int *ignore)
>  	return ret;
>  }
>  
> -static bool uncore_discovery_msr(int *ignore)
> +static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
>  {
>  	unsigned long *die_mask;
>  	bool parsed = false;
> -	int cpu, die;
> +	int cpu, die, msr;
>  	u64 base;
>  
>  	die_mask = kcalloc(BITS_TO_LONGS(uncore_max_dies()),
> @@ -411,19 +414,22 @@ static bool uncore_discovery_msr(int *ignore)
>  	if (!die_mask)
>  		return false;
>  
> +	msr = domain->discovery_base ?
> +	      domain->discovery_base : UNCORE_DISCOVERY_MSR;
> +
>  	cpus_read_lock();
>  	for_each_online_cpu(cpu) {
>  		die = topology_logical_die_id(cpu);
>  		if (__test_and_set_bit(die, die_mask))
>  			continue;
>  
> -		if (rdmsrq_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
> +		if (rdmsrq_safe_on_cpu(cpu, msr, &base))
>  			continue;
>  
>  		if (!base)
>  			continue;
>  
> -		__parse_discovery_table(base, die, &parsed, ignore);
> +		__parse_discovery_table(domain, base, die, &parsed);
>  	}
>  
>  	cpus_read_unlock();
> @@ -434,10 +440,19 @@ static bool uncore_discovery_msr(int *ignore)
>  
>  bool uncore_discovery(struct uncore_plat_init *init)
>  {
> -	int *ignore = init ? init->uncore_units_ignore : NULL;
> +	struct uncore_discovery_domain *domain;
> +	bool ret = false;
> +	int i;
>  
> -	return uncore_discovery_msr(ignore) ||
> -	       uncore_discovery_pci(ignore);
> +	for (i = 0; i < UNCORE_DISCOVERY_DOMAINS; i++) {
> +		domain = &init->domain[i];
> +		if (!domain->base_is_pci)
> +			ret |= uncore_discovery_msr(domain);
> +		else
> +			ret |= uncore_discovery_pci(domain);
> +	}
> +
> +	return ret;
>  }
>  
>  void intel_uncore_clear_discovery_tables(void)

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


