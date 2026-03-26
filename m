Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94129E0F7;
	Thu, 26 Mar 2026 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505012; cv=none; b=lQQpzgW2bBs+zppWQ0++hWrh7wR7KsI+ZtDw5RkzAR/JqWEXiW3y/fxBFYlNJcUzf1QFVC07h68mYLR/yzgkPm5hmkAcLbkXSBJNCoCJ22XGxygK+Qo/fGpv18o8tSe8X7VRlKox713oTl8fplJaVv0Ih/YaQRCK6LIw7Lv5lU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505012; c=relaxed/simple;
	bh=NIhhkU8xgTkzGHpUHRwnHtPQ9M/ydF43azkWbDE4faQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvWBGVOc6qggXnN17fIOlh2hAUN8rKoDcO5xialNhtKLeujMw+RqVCDLEws1rVEOTubI5+8Ar7/VlSBNU7gF4/k+wvTGoqcxttioihdvsn2j34zZeCob6gzsxBxTVvspgld6WSJcg1aPt4RXIizIPmAag4GTSOiuRJQiQqacnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLhdQ/vG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLhdQ/vG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774505010; x=1806041010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NIhhkU8xgTkzGHpUHRwnHtPQ9M/ydF43azkWbDE4faQ=;
  b=gLhdQ/vGARTxPDgqOXLDuGWBc8k61TCiBx8RZ5M1hewxGJcLQrQT14/R
   DC6X9L/38FXkxqRAxABfW/CySFVPBkxubUsxgyh38S3JN7NHrPlMEgseK
   N+NQzo9wjHLEa+7A/dlxMj41NmslpJ8YE+I0/TOLCOJhHHlDeCfluwil8
   K48o3BLOJ1N8uObLZ4EcUmCdUWnKTincKOfem864zevkzV0j9YNSlQ6As
   n3ZK5ui+KumUVGx6nKX6Npl7qDx269nd+BQIWmn+NBOJ2Fyr1gMZpODEO
   vi0z1QVvdBal1D+oIjqSkTHbqE5RdemPsgqIpDtvwUXRbrMjpAAJq7Arw
   g==;
X-CSE-ConnectionGUID: 4E64U9XfSUStyWEpJ7Rbqw==
X-CSE-MsgGUID: +OtwszE2SOqb4p4Nm6G+RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="78148945"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="78148945"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 23:03:29 -0700
X-CSE-ConnectionGUID: fIdFycCGTRuxpjxnhZbweg==
X-CSE-MsgGUID: cSZ5tVjaQ4mFqn7eVy9iPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="229675578"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 23:03:26 -0700
Message-ID: <7a6c5cf7-0d26-4b0b-b5b7-51d0d9782db8@linux.intel.com>
Date: Thu, 26 Mar 2026 14:03:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/4] perf/x86/intel/uncore: Fix die ID init and look up
 bugs
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Chun-Tse Shao <ctshao@google.com>,
 Markus Elfring <Markus.Elfring@web.de>
References: <20260324214932.10068-1-zide.chen@intel.com>
 <20260324214932.10068-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324214932.10068-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Zide, Sashiko gave some comments on this patch. Could you please have a
look if they are reasonable? Thanks.

https://sashiko.dev/#/patchset/20260324214932.10068-1-zide.chen%40intel.com


On 3/25/2026 5:49 AM, Zide Chen wrote:
> In snbep_pci2phy_map_init(), in the nr_node_ids > 8 path,
> uncore_device_to_die() may return -1 when all CPUs associated
> with the UBOX device are offline.
>
> Remove the WARN_ON_ONCE(die_id == -1) check for two reasons:
>
> - The current code breaks out of the loop. This is incorrect because
>   pci_get_device() does not guarantee iteration in domain or bus order,
>   so additional UBOX devices may be skipped during the scan.
>
> - Returning -EINVAL is incorrect, since marking offline buses with
>   die_id == -1 is expected and should not be treated as an error.
>
> Separately, when NUMA is disabled on a NUMA-capable platform,
> pcibus_to_node() returns NUMA_NO_NODE, causing uncore_device_to_die()
> to return -1 for all PCI devices.  As a result,
> spr_update_device_location(), used on Intel SPR and EMR, ignores the
> corresponding PMON units and does not add them to the RB tree.
>
> Fix this by using uncore_pcibus_to_dieid(), which retrieves topology
> from the UBOX GIDNIDMAP register and works regardless of whether NUMA
> is enabled in Linux.  This requires snbep_pci2phy_map_init() to be
> added in spr_uncore_pci_init().
>
> Keep uncore_device_to_die() only for the nr_node_ids > 8 case, where
> NUMA is expected to be enabled.
>
> Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
> Fixes: 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR")
> Tested-by: Steve Wahl <steve.wahl@hpe.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - Fix the commit message to note that spr_update_device_location() is
>   used by EMR, not GNR.
> - Rewrite the commit message for clarity.
> - Add a Tested-by tag.
>
> V5:
> - Remove unused variable die_id (Dapeng).
> ---
>  arch/x86/events/intel/uncore.c       |  1 +
>  arch/x86/events/intel/uncore_snbep.c | 17 ++++++++---------
>  2 files changed, 9 insertions(+), 9 deletions(-)
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
> index 9b51883fd6fd..5ef205a70559 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1413,7 +1413,7 @@ static int topology_gidnid_map(int nodeid, u32 gidnid)
>  static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool reverse)
>  {
>  	struct pci_dev *ubox_dev = NULL;
> -	int i, bus, nodeid, segment, die_id;
> +	int i, bus, nodeid, segment;
>  	struct pci2phy_map *map;
>  	int err = 0;
>  	u32 config = 0;
> @@ -1458,14 +1458,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>  				break;
>  			}
>  
> -			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
> -
> +			map->pbus_to_dieid[bus] = uncore_device_to_die(ubox_dev);
>  			raw_spin_unlock(&pci2phy_map_lock);
> -
> -			if (WARN_ON_ONCE(die_id == -1)) {
> -				err = -EINVAL;
> -				break;
> -			}
>  		}
>  	}
>  
> @@ -6420,7 +6414,7 @@ static void spr_update_device_location(int type_id)
>  
>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>  
> -		die = uncore_device_to_die(dev);
> +		die = uncore_pcibus_to_dieid(dev->bus);
>  		if (die < 0)
>  			continue;
>  
> @@ -6444,6 +6438,11 @@ static void spr_update_device_location(int type_id)
>  
>  int spr_uncore_pci_init(void)
>  {
> +	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
> +
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * The discovery table of UPI on some SPR variant is broken,
>  	 * which impacts the detection of both UPI and M3UPI uncore PMON.
