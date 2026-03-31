Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCD319617;
	Tue, 31 Mar 2026 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920423; cv=none; b=hPehyyxj4in4bQ4oSKds5qpJwG4D5wTs5N29IXApJB+tTwCky8+ksHMEefmDY8ff9ofyTBMspR8YRc6fhPx1zqi430bOtwgkL5HRaLquqsAB2OUdcplNvbAxJjMUNL34eh3Q3+sNn1SFke4MidbxanSxvzjPjSV1/L8jwZcsHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920423; c=relaxed/simple;
	bh=tdikCDSwXSWQXNlH4pP3oTBO/piRHW9T/nktj8KdS5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkllmJpsyA+JdUBd2+9tbLTkvIBOPkV1jWWePRVaVxmLbmuEkY3EpiNwcrYoxCkx3YsgDnO31x1EsAqcwEmfRv+VMNtP5nFJBHeS0bctdp0EJIx0Ac2GyzjEO903++VXivpLtH8kXJ6BENIezvXKSePo58W96v9VT/9dS2+j9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SK1HUsH+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SK1HUsH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774920421; x=1806456421;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tdikCDSwXSWQXNlH4pP3oTBO/piRHW9T/nktj8KdS5U=;
  b=SK1HUsH+XiQEj6ICO8AerAVHdaQcZmjEHeeEqMI7QIreh8xoybdNJrsh
   rfcrIF9E26u+Pg2ZspLGJY473AvnzEf8D9Wuz8TtT5JCfPUH9FhM52TQN
   CFIR8CQODaCaatuDAp/nLoVdSjvOFg43wL7dkbuhwGXQhBQal7vSnHTl7
   ckzEMjjRZjftaLJEPQg355hzSYnErLgs0/HhkphwY0ikChPrHxLAmrQMn
   7BAivGNmTEiQc9FYEK05CqYYVYO8EjL3eW3ChA5NzxDBryTVHt/TZeB4o
   U2L81RmphyA9wIG5WXKC5JB/MIlzYEFjAcISwcoMsYrSSH7714aOrp1Qy
   A==;
X-CSE-ConnectionGUID: 5ZK5evtYSBuqMqfQQkA6nA==
X-CSE-MsgGUID: Mmy5y8bPT8ifya+SrqqzzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75819630"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75819630"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 18:27:01 -0700
X-CSE-ConnectionGUID: 2CkRbMrcSpmZ0FQV8F9Pmw==
X-CSE-MsgGUID: 4pjiz/gqRDWtJq14TVY+Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="227834632"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 18:26:57 -0700
Message-ID: <e899636d-371a-44dc-b8e7-578f499847fa@linux.intel.com>
Date: Tue, 31 Mar 2026 09:26:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] perf/x86/intel/uncore: Fix PMON enumeration with
 NUMA disabled
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Chun-Tse Shao <ctshao@google.com>,
 Markus Elfring <Markus.Elfring@web.de>
References: <20260330212444.117325-1-zide.chen@intel.com>
 <20260330212444.117325-5-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260330212444.117325-5-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/31/2026 5:24 AM, Zide Chen wrote:
> When NUMA is disabled on a NUMA-capable platform, UPI and M3UPI PMON
> units are not enumerated.
>
> In this case, pcibus_to_node() always returns NUMA_NO_NODE, causing
> uncore_device_to_die() to return -1 for all PCI devices. As a result,
> the corresponding PMON units are not added to the RB tree.
>
> These PMON units are per-die resources, and their utility when NUMA is
> disabled is limited.  The driver does not prohibit their use, and the
> enumeration should still work correctly.
>
> Fix this by using uncore_pcibus_to_dieid(), which works regardless of
> whether NUMA is enabled.  This requires calling
> snbep_pci2phy_map_init() in spr_uncore_pci_init().
>
> Since pci_init() is called before mmio_init(), remove the redundant
> snbep_pci2phy_map_init() call from spr_uncore_mmio_init().  If
> snbep_pci2phy_map_init() fails, uncore driver should be bailed out,
> so the fallback path in spr_uncore_mmio_init() can be removed.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V6:
> - Split from patch v5 3/4.
> - Remove the redundant call in spr_uncore_mmio_init().
> - Update commit messages.
> ---
>  arch/x86/events/intel/uncore.c       |  1 +
>  arch/x86/events/intel/uncore_snbep.c | 26 +++++++++++---------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 786bd51a0d89..e9cc1ba921c5 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -67,6 +67,7 @@ int uncore_die_to_segment(int die)
>  	return bus ? pci_domain_nr(bus) : -EINVAL;
>  }
>  
> +/* Note: This API can only be used when NUMA information is available. */
>  int uncore_device_to_die(struct pci_dev *dev)
>  {
>  	int node = pcibus_to_node(dev->bus);
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 8ee06d4659bb..73da1e88e286 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6415,7 +6415,7 @@ static void spr_update_device_location(int type_id)
>  
>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>  
> -		die = uncore_device_to_die(dev);
> +		die = uncore_pcibus_to_dieid(dev->bus);
>  		if (die < 0)
>  			continue;
>  
> @@ -6439,6 +6439,10 @@ static void spr_update_device_location(int type_id)
>  
>  int spr_uncore_pci_init(void)
>  {
> +	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * The discovery table of UPI on some SPR variant is broken,
>  	 * which impacts the detection of both UPI and M3UPI uncore PMON.
> @@ -6460,21 +6464,13 @@ int spr_uncore_pci_init(void)
>  
>  void spr_uncore_mmio_init(void)
>  {
> -	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
> +	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
> +						 UNCORE_SPR_MMIO_EXTRA_UNCORES,
> +						 spr_mmio_uncores,
> +						 UNCORE_SPR_NUM_UNCORE_TYPES,
> +						 spr_uncores);
>  
> -	if (ret) {
> -		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
> -							 UNCORE_SPR_NUM_UNCORE_TYPES,
> -							 spr_uncores);
> -	} else {
> -		uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
> -							 UNCORE_SPR_MMIO_EXTRA_UNCORES,
> -							 spr_mmio_uncores,
> -							 UNCORE_SPR_NUM_UNCORE_TYPES,
> -							 spr_uncores);
> -
> -		spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;
> -	}
> +	spr_uncore_imc_free_running.num_boxes = uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_SPR_IMC) / 2;

I'm not sure if we can directly remove the snbep_pci2phy_map_init() call
here. In theory, the snbep_pci2phy_map_init() call in spr_uncore_pci_init()
could fail and then spr_uncore_mmio_init() doesn't know it and directly
initializes MMIO PMU, then it could lead to the MMIO initialization fails.

Currently the PCI, CPU and MMIO initialization are totally independent,
only when the 3 types initialization all fail, then uncore PMU can abort.

``` 

   if (uncore_init->pci_init) {
        pret = uncore_init->pci_init();
        if (!pret)
            pret = uncore_pci_init();
    }

    if (uncore_init->cpu_init) {
        uncore_init->cpu_init();
        cret = uncore_cpu_init();
    }

    if (uncore_init->mmio_init) {
        uncore_init->mmio_init();
        mret = uncore_mmio_init();
    }

    if (cret && pret && mret) {
        ret = -ENODEV;
        goto free_discovery;
    }
```


>  }
>  
>  /* end of SPR uncore support */
