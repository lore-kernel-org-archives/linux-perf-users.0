Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7B31367;
	Fri,  4 Jul 2025 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751591055; cv=none; b=Jn9v9J741T9U0XSnyOi0Wtm8ctcPz8JMOrTAGbCQG1JxsPuwb1EOl4ASzknO5KCy7UW0cXO/HVvBbCKUJAuNtUCOEmwjsBxmK/3yWhfh5cRdudxuvxj6UH1QjAKI2Z0wf0EojrSqWFIqj4QH4tgCk0nK07cvl814VlmIu5eLznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751591055; c=relaxed/simple;
	bh=NwYXwioSFA+26ntHEcsMyePfyCypoWUmjB3nl6lM3yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nOXCdpTEhJcGOvE8VJIRkpjZ2dZ94wwUe1UH3EJlXabWxALUJXS9DOK6T/WMuC5SlisGXQ0UbO95ARYVG4AhGIUY3umwfv0BU0OFhSbUmeW3u25qckuXeKf+CLzF/JDgFDx8kOvgybUUhQj/eXltC/ePXp+Ek5SYEwdksqqGbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLaIjUUU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLaIjUUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751591054; x=1783127054;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=NwYXwioSFA+26ntHEcsMyePfyCypoWUmjB3nl6lM3yM=;
  b=hLaIjUUUWyrq0Gvu6xzHJs7XPyAcjgSvYb0HfU+2QfHK8EYGFCZL0GK7
   +gR5TOaup8iFb7/lnjXMik1NJlykP08gTDXWjz3nth15hUam0Xz1LC0dN
   piam93EjjMgHalR00wMMBO2Sn6LOCwwvoNiKVtwYwLodhN33mkg1LUyZR
   fZo00t95qH8KvMMwk/PrwIvDzzHq3BzxQObJKdhhPxmnFdbxivtFEOWDw
   ZGoQ00Of8H5JeGwQoAc+HOm7zzvb2wRvVN6kq79Fwq2/rxaoJDqZhLiok
   O0y592YBLl2hCJ+vl4lK+wRYYdWpZAD8txNSN0114ujmg7fspGXXzzmfx
   g==;
X-CSE-ConnectionGUID: SW+IFz7bT7mOg9ARlC994A==
X-CSE-MsgGUID: mcIi/HtiSoGzQMV+IM7uGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57701430"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="57701430"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:04:13 -0700
X-CSE-ConnectionGUID: 0HQVXw3ITdOj0TgMEVV+qw==
X-CSE-MsgGUID: LaK5miYZRDC1gkzDLcBvsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="153929357"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.37]) ([10.124.240.37])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 18:04:11 -0700
Message-ID: <45caa98c-d84e-4e8f-acd8-c255ec339c6f@linux.intel.com>
Date: Fri, 4 Jul 2025 09:04:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/4] perf/x86/intel/uncore: Support MSR portal for
 discovery tables
To: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250703165614.606446-1-kan.liang@linux.intel.com>
 <20250703165614.606446-2-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250703165614.606446-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/4/2025 12:56 AM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Starting from the Panther Lake, the discovery table mechanism is also
> supported in client platforms. The difference is that the portal of the
> global discovery table is retrieved from an MSR.
>
> The layout of discovery tables are the same as the server platforms.
> Factor out __parse_discovery_table() to parse discover tables.
>
> The uncore PMON is Die scope. Need to parse the discovery tables for
> each die.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore_discovery.c | 87 ++++++++++++++++++------
>  arch/x86/events/intel/uncore_discovery.h |  3 +
>  2 files changed, 70 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 571e44b49691..8680f66c3e34 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -273,32 +273,15 @@ uncore_ignore_unit(struct uncore_unit_discovery *unit, int *ignore)
>  	return false;
>  }
>  
> -static int parse_discovery_table(struct pci_dev *dev, int die,
> -				 u32 bar_offset, bool *parsed,
> -				 int *ignore)
> +static int __parse_discovery_table(resource_size_t addr, int die,
> +				   bool *parsed, int *ignore)
>  {
>  	struct uncore_global_discovery global;
>  	struct uncore_unit_discovery unit;
>  	void __iomem *io_addr;
> -	resource_size_t addr;
>  	unsigned long size;
> -	u32 val;
>  	int i;
>  
> -	pci_read_config_dword(dev, bar_offset, &val);
> -
> -	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
> -		return -EINVAL;
> -
> -	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
> -#ifdef CONFIG_PHYS_ADDR_T_64BIT
> -	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		u32 val2;
> -
> -		pci_read_config_dword(dev, bar_offset + 4, &val2);
> -		addr |= ((resource_size_t)val2) << 32;
> -	}
> -#endif
>  	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
>  	io_addr = ioremap(addr, size);
>  	if (!io_addr)
> @@ -341,7 +324,32 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
>  	return 0;
>  }
>  
> -bool intel_uncore_has_discovery_tables(int *ignore)
> +static int parse_discovery_table(struct pci_dev *dev, int die,
> +				 u32 bar_offset, bool *parsed,
> +				 int *ignore)
> +{
> +	resource_size_t addr;
> +	u32 val;
> +
> +	pci_read_config_dword(dev, bar_offset, &val);
> +
> +	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
> +		return -EINVAL;
> +
> +	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> +	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		u32 val2;
> +
> +		pci_read_config_dword(dev, bar_offset + 4, &val2);
> +		addr |= ((resource_size_t)val2) << 32;
> +	}
> +#endif
> +
> +	return __parse_discovery_table(addr, die, parsed, ignore);
> +}
> +
> +static bool intel_uncore_has_discovery_tables_pci(int *ignore)
>  {
>  	u32 device, val, entry_id, bar_offset;
>  	int die, dvsec = 0, ret = true;
> @@ -390,6 +398,45 @@ bool intel_uncore_has_discovery_tables(int *ignore)
>  	return ret;
>  }
>  
> +static bool intel_uncore_has_discovery_tables_msr(int *ignore)
> +{
> +	unsigned long *die_mask;
> +	bool parsed = false;
> +	int cpu, die;
> +	u64 base;
> +
> +	die_mask = kcalloc(BITS_TO_LONGS(__uncore_max_dies),

Better use uncore_max_dies() instead of __uncore_max_dies.


> +			   sizeof(unsigned long), GFP_KERNEL);
> +	if (!die_mask)
> +		return false;
> +
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		die = topology_logical_die_id(cpu);
> +		if (__test_and_set_bit(die, die_mask))
> +			continue;
> +
> +		if (rdmsrq_safe_on_cpu(cpu, UNCORE_DISCOVERY_MSR, &base))
> +			continue;
> +
> +		if (!base)
> +			continue;
> +
> +		__parse_discovery_table(base, die, &parsed, ignore);
> +	}
> +
> +	cpus_read_unlock();
> +
> +	kfree(die_mask);
> +	return parsed;
> +}
> +
> +bool intel_uncore_has_discovery_tables(int *ignore)
> +{
> +	return intel_uncore_has_discovery_tables_msr(ignore) ||
> +	       intel_uncore_has_discovery_tables_pci(ignore);
> +}
> +
>  void intel_uncore_clear_discovery_tables(void)
>  {
>  	struct intel_uncore_discovery_type *type, *next;
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
> index 0e94aa7db8e7..690f737e6837 100644
> --- a/arch/x86/events/intel/uncore_discovery.h
> +++ b/arch/x86/events/intel/uncore_discovery.h
> @@ -1,5 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  
> +/* Store the full address of the global discovery table */
> +#define UNCORE_DISCOVERY_MSR			0x201e
> +
>  /* Generic device ID of a discovery table device */
>  #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
>  /* Capability ID for a discovery table device */
