Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF9322B83;
	Fri, 16 Jan 2026 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541060; cv=none; b=MVnuPhm9D2tLY7ZBbNGA67rImS2+GEUGSdeTa/oU/vtkx0k72qfhSl/YlzA5xptfYgE9oTtY1+Icw4rXrtVj11rfzRIU8Ee/PLSJ8zwixmXmhMC0yyX7EMTUWfrDsH9n0nHouBBIscV9CKF9Ef4mtXt8zXaZTWmlSM3Woy8hafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541060; c=relaxed/simple;
	bh=QmbYGw2nvWGmbjHT8Whd9RNhLpAIln7hXoDZkpR4ymg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea6hKT0GsCzcUBDjdzVoQEkcDrchgMFbN6o2AlnJwGGc0azxfHsHyHMqoUgJ0beT8RJk043/wKjVohNzIjFa420r+CJU7yLGAkYZQayRo1951IJmkTK8/xGtVmS7cq9p7lAyYo2FW9WDLYUzA0mcS735kmQKLKe/5fyYQKNCdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjmCqihS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjmCqihS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768541059; x=1800077059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QmbYGw2nvWGmbjHT8Whd9RNhLpAIln7hXoDZkpR4ymg=;
  b=QjmCqihS/VNendhLXZj6DB/SMMfca/CBfAJTr4aa6BiWewP2vGqzP2GV
   sNdCHRwf61uVuA8UAZ9zMW3oLMAYHrji0GGOOIKlAecSlWtMsrOz5EZT8
   2Rh+naL+hR+WCxTGiK5OM2vkVMxHLVADwx81w3ypqExyvt/Nd6wLOvziN
   QUf4N1szRtSN1q3A4cytxkl/ywT6p6++BiSZYgmN+xJWNWzE50Ej6lhxc
   s7iuiLZR9K0JBcbdhRB/WOhTlx6LQ+Tqr+xxD/il2HPCFn5pHgJWXSQAx
   YujR0TxiGIUctqReP1K0xYv30ceh4mK8LlzeYBHZ0QeCsDDg2ofW+04Ds
   g==;
X-CSE-ConnectionGUID: 0YDZ/yJyRF2N/HRfmbzGyA==
X-CSE-MsgGUID: INDWLAwRSziS8ArzArJ3VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="72441820"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="72441820"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 21:24:18 -0800
X-CSE-ConnectionGUID: bupVUTkORPCvtEhIyzwz9g==
X-CSE-MsgGUID: At+ghkJUS86sXmPl9m9SoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="210186383"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 21:24:14 -0800
Message-ID: <b33c8735-40ed-459f-8a7f-e11fa7a961c9@linux.intel.com>
Date: Fri, 16 Jan 2026 13:24:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/2] perf/x86/intel/uncore: Fix die ID init and look up
 bugs
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20260116031113.45098-1-zide.chen@intel.com>
 <20260116031113.45098-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260116031113.45098-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/16/2026 11:11 AM, Zide Chen wrote:
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
> V3: no changes
>
>  arch/x86/events/intel/uncore.c       |  1 +
>  arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 4684649109d9..94592de6431a 100644
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
> index 7ca0429c4004..52dec34d18c4 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1459,13 +1459,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>  			}
>  
>  			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
> -
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

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


