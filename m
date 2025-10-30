Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271A1F4631;
	Thu, 30 Oct 2025 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801459; cv=none; b=OS/eSeFU1HgjmDR+5bWIox19q+Xzf8LheMqxN7YJSAGFKfRYa8J8SxRs8fm4wEzRTEBZP9d+i8nLgZJEBJ4/4+wggVfTzQ20D/l/eYjAq3XKYv3qyNOWnYSNJdFcKh7i/fg/N4IDyFSqM19UXdnnECj/+dkLzie9tvmJge/o6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801459; c=relaxed/simple;
	bh=f7TlgeVtEnw5QuGJCBWUdQupgLGr0mILsmLnG2oC5ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5sbkS4rWKlASPYHQx/C9QTX0z/y9SIQRSdMTdV6oNOC3xhLpWPgIAKT+u2HwsYQeqD0iQXCIDQsFoRivsAIvlEHyPxuM1JjoxvouD9PUqykYUQ8ISO1EXUBD4pWEsLzz8q2x+5Avxle4rH8RYlFdqDjfTIB810a55Ff9kj7KxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQF/lNxo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQF/lNxo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761801457; x=1793337457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f7TlgeVtEnw5QuGJCBWUdQupgLGr0mILsmLnG2oC5ns=;
  b=UQF/lNxoIRfp/L0XR9BfIZG+VCBCAs77ZVB11/HZt5Kq6VJAQCm33jID
   LHnjabSb/VBcnWc3nAG1kVZF+fJmOrx0gs90eOhAxSEVHMByZJkNBtclM
   u8w7UTYZ0Off8T90gtsSsXaWyYcpl0092QPzPL4/6/ChkpTe/V+JOz75J
   6ElUL+TAAnitjxvp6pyukKYK3sYCkHCwh48YqPUc1unaYo5cBe3Ha3bpn
   LiZx2B+MljE5bBZtWknsTRUvfFkIVDbL/R5T6FLLsXWHS/y8U/LvtvJdJ
   RH5g80wu98BL0/eqrlDku+UJO+y9Ix+p+fyRciUP3zVBJiPAlzLYnTCP2
   A==;
X-CSE-ConnectionGUID: 5pioP2mhSCaLUD0KwelmeA==
X-CSE-MsgGUID: 6X93XcfTRWGDO/jjsz40+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81353598"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="81353598"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 22:17:37 -0700
X-CSE-ConnectionGUID: m+F77FaHQH2ObhV/IqfVdQ==
X-CSE-MsgGUID: 7fKGZ7v0TX+KksZ24RwISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="190994513"
Received: from yjung-mobl.amr.corp.intel.com (HELO [10.125.83.0]) ([10.125.83.0])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 22:17:36 -0700
Message-ID: <370b7f4b-3996-466f-ae40-83c4890e8527@intel.com>
Date: Wed, 29 Oct 2025 22:17:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/intel/uncore: Fix die ID init and look up
 bugs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20251029220711.57909-1-zide.chen@intel.com>
 <20251029220711.57909-2-zide.chen@intel.com>
 <926de635-35ae-4ac9-b235-2d394f20ae7e@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <926de635-35ae-4ac9-b235-2d394f20ae7e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/2025 6:39 PM, Mi, Dapeng wrote:
> 
> On 10/30/2025 6:07 AM, Zide Chen wrote:
>> In snbep_pci2phy_map_init(), if there are more than 8 nodes,
>> uncore_device_to_die(ubox_dev) may return -1 if all CPUs
>> associated with the UBOX device are offline.  This is not an error
>> and we still need to populate map->pbus_to_dieid[].
>>
>> If NUMA is disabled on a NUMA-capable platform, pcibus_to_node()
>> returns NUMA_NO_NODE and uncore_device_to_die() returns -1.  As a
>> result, in spr_update_device_location(), which is used on Intel SPR,
>> GNR etc., the PMON units are ignored and not added to the RB tree.
> 
> It seems spr_update_device_location() currently is only called by SPR,
> please double check. 

Woops, it's used by SPR and EMR, not GNR.
> BTW, is this a SPR specific issue or a common issue? Thanks.
This is a general statement: uncore_device_to_die() can't be used when
numa=off. However, in the current code, it is misused only in
spr_update_device_location().
>>
>> Use uncore_pcibus_to_dieid() instead, which retrieves topology
>> information from the GIDNIDMAP register of the UBOX device.
>>
>> Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
>> Fixes: 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR")
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/uncore.c       |  1 +
>>  arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 5c3aeea5c78d..84d6e481f18f 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -77,6 +77,7 @@ int uncore_die_to_segment(int die)
>>  	return bus ? pci_domain_nr(bus) : -EINVAL;
>>  }
>>  
>> +/* Note: This API can only be used when NUMA information is available. */
>>  int uncore_device_to_die(struct pci_dev *dev)
>>  {
>>  	int node = pcibus_to_node(dev->bus);
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index ad4d11762ecf..e68467f617f9 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -1471,13 +1471,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>>  			}
>>  
>>  			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
>> -
>>  			raw_spin_unlock(&pci2phy_map_lock);
>> -
>> -			if (WARN_ON_ONCE(die_id == -1)) {
>> -				err = -EINVAL;
>> -				break;
>> -			}
>>  		}
>>  	}
>>  
>> @@ -6530,7 +6524,7 @@ static void spr_update_device_location(int type_id)
>>  
>>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>>  
>> -		die = uncore_device_to_die(dev);
>> +		die = uncore_pcibus_to_dieid(dev->bus);
>>  		if (die < 0)
>>  			continue;
>>  
>> @@ -6554,6 +6548,11 @@ static void spr_update_device_location(int type_id)
>>  
>>  int spr_uncore_pci_init(void)
>>  {
>> +	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>>  	/*
>>  	 * The discovery table of UPI on some SPR variant is broken,
>>  	 * which impacts the detection of both UPI and M3UPI uncore PMON.

