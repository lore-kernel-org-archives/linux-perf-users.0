Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD6346E54;
	Mon, 16 Mar 2026 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644038; cv=none; b=ud/x3kebVVxk4+RnBSFCTgDEWYNyJQuhLYfAwnL7dTpE8RWl8YU//Ae6YWbuRL5rS0docOtknK2SkkKrH7NW+6+lU1KYZUaMjOM9PL7VZwETsFu/6K8K+Ra3uZr7waJOK/Hlwp1Esu+f/2IBznJiXca/cXQz+mC1mJQeh33/sVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644038; c=relaxed/simple;
	bh=1o24Y8PLR50PRp8YtGb4O5udNKNzuWgwdP8DQegvPLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8TtFg8E3NSSIv+eNgRIAkzAplS0kYDD13iEIHwFb6hWvSt2k6dBS7BKOHfLiexITEc1MfVYRvLBX6LQ+/K36E3IHoAP+AMhp28/wP6GnzVyZHCYbrQ1iBtN1oRBenEs7yzeI0kH/RvxNDnhkpeoacc+0FpaFky1T83Upd34tig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOS5nHfi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOS5nHfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773644035; x=1805180035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1o24Y8PLR50PRp8YtGb4O5udNKNzuWgwdP8DQegvPLs=;
  b=ZOS5nHfigO3Y6vFnvantIQY6OLAcw+lsmm/zrPBHTwN3zeoVRbP+vw0l
   31NG2ekjhnSZAnzD1TKmrrGTXLvXHfzHS+n1wuvizif8hcJNY0bMc3HCO
   BOZipmpFdTa78/Uy9P86VUsoPfeKfaSsdLjlkMibYLzqoLE6a/mYnsuXI
   kbsgM2ufF4cIDna8GvL7LvUKIUZx9QYn/jIeMuUtUgdxu9Y5pHMAe10lG
   2oOgHWObjHUM7cHuj3sj0CVKJm0PthSeISX5DgnAqJKsqkBxoknerqhfA
   e4wjPIuowFRQxfCbKJRGN/pTAHYIKRidmuGPkZ3mc+7UvwIyNxGYWZDbp
   Q==;
X-CSE-ConnectionGUID: 96NMXbwPSeyJ+JEs8lEsvQ==
X-CSE-MsgGUID: WHT7BHWFT4yoB4xHjI0img==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="92222528"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="92222528"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:53:54 -0700
X-CSE-ConnectionGUID: rW0nyuZ7Qd66/ay6xZdF8Q==
X-CSE-MsgGUID: gmikGwNJTaON6IpVZJIc1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="217680567"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 23:53:51 -0700
Message-ID: <c18ccaf6-3b4d-486a-9d88-76dd715902a2@linux.intel.com>
Date: Mon, 16 Mar 2026 14:53:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] perf/x86/intel/uncore: Fix die ID init and look up
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
References: <20260313174050.171704-1-zide.chen@intel.com>
 <20260313174050.171704-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260313174050.171704-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/14/2026 1:40 AM, Zide Chen wrote:
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
> V4: no changes.
> ---
>  arch/x86/events/intel/uncore.c       |  1 +
>  arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
>  2 files changed, 7 insertions(+), 7 deletions(-)
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
> index 9b51883fd6fd..421378f681d7 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1459,13 +1459,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>  			}
>  
>  			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);

The "die_id" variable is not needed any more after removing below check,
please remove it.

Others look good to me. Thanks.


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
