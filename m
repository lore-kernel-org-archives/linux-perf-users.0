Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447CB288C3F;
	Thu, 30 Oct 2025 01:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761788367; cv=none; b=sNaGw8el0JdFNVVrsyFI23P/4xDIJFp3mPyXnvM4YWXVqmS0sNGG7WqAOGv38dBKve0nHTfnOl9EfLd1wosJ8lcvPo5sZNtZU+fso1kZoYNp6r8SyUxw5E7eWgYyK+6DmMeoJeO6+yNlQ6vru55ykdw8mUgq36VF9MJaXsvbdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761788367; c=relaxed/simple;
	bh=adm5ygKpSDNzeRAC32xf829c/z3nWD3Ca4EKvxVtclI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8Kro7BfnyUNmPXwuOevI0z4138PLpm02x83Vu47mE3DXNo/OAAV0l4TT811cT4BkEHNrMTYdOgxnUuzVYhMFxmu40L9WjwweKPpjHmHhVhLnYs0Vyo2UfLW4w/MP8BSgorZobaJJKMWVIme+Nb7XCaCFupeTUSV1iJ2EU0sRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcsOAiPp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcsOAiPp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761788366; x=1793324366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=adm5ygKpSDNzeRAC32xf829c/z3nWD3Ca4EKvxVtclI=;
  b=UcsOAiPp5SK+li3yS28jt9Wv20qpg55FfQ7d/WTRYhTqIryD5Tl6WQ+t
   0ATVhRFgtQstqEvZaf4zbsNy6TYj8ljeP5POiPW4oNO5YLtmr3SuqafAT
   ijHNcxY5XFpoU2a3aKmyyvIWUwtsal5kLEQNOnLCaAOBTQjatFsQAYg7f
   vtIv4wrjpO83p1RbX+fTmlQukOUPVkXrSW5+VvuONKcKV0foZNNHFit8C
   91/rXBfPSHN+RBjWdriLnMWAgQX+VzhMA+P69+z08Yu/K7MlgHhcuvqp9
   gnIRbbUUn/ugDWd/NDPW3wiojeA0Nhvo3D5YVU+5eFmBndJ3HDS7hHv8S
   Q==;
X-CSE-ConnectionGUID: KJG7yNaGQv6OFcRVlJ52Qw==
X-CSE-MsgGUID: QHoVBMwhSw6XJSrTJq6I4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74598594"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="74598594"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:39:26 -0700
X-CSE-ConnectionGUID: jYIG8WygRHyNb4Y26ufaSg==
X-CSE-MsgGUID: bi04rw+CR4iop/PZqvi46w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185910626"
Received: from haochenw-mobl1.ccr.corp.intel.com (HELO [10.238.3.228]) ([10.238.3.228])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:39:22 -0700
Message-ID: <926de635-35ae-4ac9-b235-2d394f20ae7e@linux.intel.com>
Date: Thu, 30 Oct 2025 09:39:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/intel/uncore: Fix die ID init and look up
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
References: <20251029220711.57909-1-zide.chen@intel.com>
 <20251029220711.57909-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251029220711.57909-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/30/2025 6:07 AM, Zide Chen wrote:
> In snbep_pci2phy_map_init(), if there are more than 8 nodes,
> uncore_device_to_die(ubox_dev) may return -1 if all CPUs
> associated with the UBOX device are offline.  This is not an error
> and we still need to populate map->pbus_to_dieid[].
>
> If NUMA is disabled on a NUMA-capable platform, pcibus_to_node()
> returns NUMA_NO_NODE and uncore_device_to_die() returns -1.  As a
> result, in spr_update_device_location(), which is used on Intel SPR,
> GNR etc., the PMON units are ignored and not added to the RB tree.

It seems spr_update_device_location() currently is only called by SPR,
please double check. 

BTW, is this a SPR specific issue or a common issue? Thanks.


>
> Use uncore_pcibus_to_dieid() instead, which retrieves topology
> information from the GIDNIDMAP register of the UBOX device.
>
> Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
> Fixes: 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c       |  1 +
>  arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 5c3aeea5c78d..84d6e481f18f 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -77,6 +77,7 @@ int uncore_die_to_segment(int die)
>  	return bus ? pci_domain_nr(bus) : -EINVAL;
>  }
>  
> +/* Note: This API can only be used when NUMA information is available. */
>  int uncore_device_to_die(struct pci_dev *dev)
>  {
>  	int node = pcibus_to_node(dev->bus);
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index ad4d11762ecf..e68467f617f9 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1471,13 +1471,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
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
> @@ -6530,7 +6524,7 @@ static void spr_update_device_location(int type_id)
>  
>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>  
> -		die = uncore_device_to_die(dev);
> +		die = uncore_pcibus_to_dieid(dev->bus);
>  		if (die < 0)
>  			continue;
>  
> @@ -6554,6 +6548,11 @@ static void spr_update_device_location(int type_id)
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
