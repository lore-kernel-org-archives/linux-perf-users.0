Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C12C3244;
	Tue, 23 Dec 2025 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459281; cv=none; b=s1bZxgfgmghiPXd6q4nFhl4czbM8pX11hPI4Hw+gslPW5VU2fLfb7vR6Y3oJE3aXsw7eZrl0b66HXFiIQAZPOmLdEuDDNoo8H1jvSCT5iCYIfeSZiUo8gGlqkNfFZHqk9tpJtzorZr5QFbqTmwkaPTBTzwXdmmorWqK/RmFMIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459281; c=relaxed/simple;
	bh=NxQpC9a7flYGrS9lYQAWfOfqluA+iubN9F4FIiNn07M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGOh9yjC+qshF2Rk/EqTsK/aQfvaN71Vb2sSV83Y+btm9Wr/T3oYRk3/9YKpEL7/64jQh88CF0NgOIXFY0+9Bg1JIOO3eAXu25axYRCDUQ373Tb8ClBP/A40+biLLN8t4OjOPBSkp2WsBdmE+WLXFZPpl5+XJwsi9DriETGfuEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BetRAyRN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BetRAyRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766459279; x=1797995279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NxQpC9a7flYGrS9lYQAWfOfqluA+iubN9F4FIiNn07M=;
  b=BetRAyRNZrWg9bGlJHLFYypolvAIqr7ABqrG+sRLsndLSV6F374DVMAQ
   +acajS2PLq9MMPzrBxzRbyO7lZMbjD4LfmTaeoOR5zlhv6RIdL5w1fc3Z
   EVaCJj68TXuNiXeccKg1SIHQwtsB5Mkh39y+OdjXvF4Z/09mu8CdmyZ51
   7hMgA/u7Hvi5JMhAUeBXCzd8dtZ6ZWeQQRJgriLB2L7dq+3rw/wqDr9Ek
   28cqtLDphmibVCaW6MdIPszc12BjpdDSh378kD+oDaLSZVcig0oiwgKpy
   CXg6X0ubfzPV3JdW2QtxQs3BZGf+hfaC4FxbPyaFJRMHCxQ1oq2R6Ebra
   A==;
X-CSE-ConnectionGUID: Bfbs1uuhQlCMFvrjfujLUA==
X-CSE-MsgGUID: rMzJtvgHRDmdxe59DUEk+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79674084"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="79674084"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 19:07:59 -0800
X-CSE-ConnectionGUID: MKR4IaZTRZi4FAIOwFCXbA==
X-CSE-MsgGUID: 0YguEJbmRyWKwtW6C6FcRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="204723186"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 19:07:54 -0800
Message-ID: <b161f36b-2142-4d99-bf39-3792f140fa82@linux.intel.com>
Date: Tue, 23 Dec 2025 11:07:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] perf/x86/intel/uncore: Add dual PCI/MSR discovery
 support
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
 <20251212210007.13986-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251212210007.13986-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/13/2025 5:00 AM, Zide Chen wrote:
> On DMR platforms, IMH discovery tables are enumerated via a PCI device,
> while CBB tables are enumerated via an MSR.  This differs from prior
> CPUs, which relied exclusively on either PCI or MSR.
>
> Extend intel_uncore_has_discovery_tables() to support platforms that
> require discovery through both PCI and MSR.
>
> DMR CBB uncore uses MSR 0x710 for discovery instead of MSR 0x201e.
> Introduce a discovery_msr field to store platform-specific MSR values.
>
> Similarly, add a discovery_pci field so that DMR can enumerate through
> PCI device 0x9a1 rather than 0x9a7.
>
> In the !x86_match_cpu() fallback path, has_generic_discovery_table()
> is removed because it does not consider multiple possible PCI devices
> and its performance is not important here.  Only probe MSR 0x201e to
> keep the code simple.
>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c           | 30 ++++++++++++-----
>  arch/x86/events/intel/uncore_discovery.c | 42 +++++++-----------------
>  arch/x86/events/intel/uncore_discovery.h |  2 +-
>  3 files changed, 34 insertions(+), 40 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index a762f7f5b161..ecf500470f8e 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1703,8 +1703,10 @@ struct intel_uncore_init_fun {
>  	void	(*cpu_init)(void);
>  	int	(*pci_init)(void);
>  	void	(*mmio_init)(void);
> -	/* Discovery table is required */
> -	bool	use_discovery;
> +	/* MSR carries the Discovery table base address */
> +	u32	discovery_msr;
> +	/* PCI device carries the Discovery table base address */
> +	u32	discovery_pci;
>  	/* The units in the discovery table should be ignored. */
>  	int	*uncore_units_ignore;
>  };
> @@ -1810,7 +1812,7 @@ static const struct intel_uncore_init_fun lnl_uncore_init __initconst = {
>  static const struct intel_uncore_init_fun ptl_uncore_init __initconst = {
>  	.cpu_init = ptl_uncore_cpu_init,
>  	.mmio_init = ptl_uncore_mmio_init,
> -	.use_discovery = true,
> +	.discovery_msr = UNCORE_DISCOVERY_MSR,
>  };
>  
>  static const struct intel_uncore_init_fun icx_uncore_init __initconst = {
> @@ -1829,7 +1831,7 @@ static const struct intel_uncore_init_fun spr_uncore_init __initconst = {
>  	.cpu_init = spr_uncore_cpu_init,
>  	.pci_init = spr_uncore_pci_init,
>  	.mmio_init = spr_uncore_mmio_init,
> -	.use_discovery = true,
> +	.discovery_pci = UNCORE_DISCOVERY_TABLE_DEVICE,
>  	.uncore_units_ignore = spr_uncore_units_ignore,
>  };
>  
> @@ -1837,7 +1839,7 @@ static const struct intel_uncore_init_fun gnr_uncore_init __initconst = {
>  	.cpu_init = gnr_uncore_cpu_init,
>  	.pci_init = gnr_uncore_pci_init,
>  	.mmio_init = gnr_uncore_mmio_init,
> -	.use_discovery = true,
> +	.discovery_pci = UNCORE_DISCOVERY_TABLE_DEVICE,
>  	.uncore_units_ignore = gnr_uncore_units_ignore,
>  };
>  
> @@ -1908,6 +1910,11 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
>  
> +static bool ucore_use_discovery(struct intel_uncore_init_fun *uncore_init)
> +{
> +	return (uncore_init->discovery_pci || uncore_init->discovery_msr);
> +}
> +
>  static int __init intel_uncore_init(void)
>  {
>  	const struct x86_cpu_id *id;
> @@ -1922,16 +1929,21 @@ static int __init intel_uncore_init(void)
>  
>  	id = x86_match_cpu(intel_uncore_match);
>  	if (!id) {
> -		if (!uncore_no_discover && intel_uncore_has_discovery_tables(NULL))
> +		if (!uncore_no_discover &&
> +		    intel_uncore_has_discovery_tables(NULL,
> +				UNCORE_DISCOVERY_MSR, PCI_ANY_ID))
>  			uncore_init = (struct intel_uncore_init_fun *)&generic_uncore_init;
>  		else
>  			return -ENODEV;
>  	} else {
>  		uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
> -		if (uncore_no_discover && uncore_init->use_discovery)
> +		if (uncore_no_discover && ucore_use_discovery(uncore_init))
>  			return -ENODEV;
> -		if (uncore_init->use_discovery &&
> -		    !intel_uncore_has_discovery_tables(uncore_init->uncore_units_ignore))
> +		if (ucore_use_discovery(uncore_init) &&
> +		    !intel_uncore_has_discovery_tables(
> +			uncore_init->uncore_units_ignore,
> +			uncore_init->discovery_msr,
> +			uncore_init->discovery_pci))
>  			return -ENODEV;
>  	}
>  
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 7d57ce706feb..86373b00e966 100644
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
> @@ -350,18 +332,13 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
>  	return __parse_discovery_table(addr, die, parsed, ignore);
>  }
>  
> -static bool intel_uncore_has_discovery_tables_pci(int *ignore)
> +static bool intel_uncore_has_discovery_tables_pci(int *ignore, u32 device)
>  {
> -	u32 device, val, entry_id, bar_offset;
> +	u32 val, entry_id, bar_offset;
>  	int die, dvsec = 0, ret = true;
>  	struct pci_dev *dev = NULL;
>  	bool parsed = false;
>  
> -	if (has_generic_discovery_table())
> -		device = UNCORE_DISCOVERY_TABLE_DEVICE;
> -	else
> -		device = PCI_ANY_ID;
> -
>  	/*
>  	 * Start a new search and iterates through the list of
>  	 * the discovery table devices.
> @@ -399,7 +376,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
>  	return ret;
>  }
>  
> -static bool intel_uncore_has_discovery_tables_msr(int *ignore)
> +static bool intel_uncore_has_discovery_tables_msr(int *ignore, u32 msr)
>  {
>  	unsigned long *die_mask;
>  	bool parsed = false;
> @@ -417,7 +394,7 @@ static bool intel_uncore_has_discovery_tables_msr(int *ignore)
>  		if (__test_and_set_bit(die, die_mask))
>  			continue;
>  
> -		if (rdmsrq_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
> +		if (rdmsrq_safe_on_cpu(cpu, msr, &base))
>  			continue;
>  
>  		if (!base)
> @@ -432,10 +409,15 @@ static bool intel_uncore_has_discovery_tables_msr(int *ignore)
>  	return parsed;
>  }
>  
> -bool intel_uncore_has_discovery_tables(int *ignore)
> +bool intel_uncore_has_discovery_tables(int *ignore, u32 msr, u32 device)
>  {
> -	return intel_uncore_has_discovery_tables_msr(ignore) ||
> -	       intel_uncore_has_discovery_tables_pci(ignore);
> +	bool ret = false;
> +
> +	if (msr)
> +		ret = intel_uncore_has_discovery_tables_msr(ignore, msr);
> +	if (device)
> +		ret |= intel_uncore_has_discovery_tables_pci(ignore, device);
> +	return ret;
>  }
>  
>  void intel_uncore_clear_discovery_tables(void)
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
> index dff75c98e22f..a919b1ac88fe 100644
> --- a/arch/x86/events/intel/uncore_discovery.h
> +++ b/arch/x86/events/intel/uncore_discovery.h
> @@ -136,7 +136,7 @@ struct intel_uncore_discovery_type {
>  	u16		num_units;	/* number of units */
>  };
>  
> -bool intel_uncore_has_discovery_tables(int *ignore);
> +bool intel_uncore_has_discovery_tables(int *ignore, u32 msr, u32 device);
>  void intel_uncore_clear_discovery_tables(void);
>  void intel_uncore_generic_uncore_cpu_init(void);
>  int intel_uncore_generic_uncore_pci_init(void);

The changes look good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


