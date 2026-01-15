Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942544C81;
	Thu, 15 Jan 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501038; cv=none; b=oU/QOuuxlG/imOKCVitKk33H98JUfJvz8ZG4zA7cTxFakwCr7b01VhpP3MBRGbjqPVPv1N8SmBq0z+I/cqAhMNFOs8fXZUX2bZe2ztqo/MckJchIqgYYMiA2k8o5MIG5o/9WVft7mIO0H0AIkWk6AnpsdwojpuxSMRbBU1Bfp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501038; c=relaxed/simple;
	bh=N6NKRgzwl3lXmSkzjZsx1633PUjUv2stdgLbhns6WA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lqi7ogK06aKaULlpgNSzliwPjHLDoirV2iWNkeZvPnUFp2ruOCeaWQoqR8NDWG4Bx3Kk2arCvbqcL+OgX7GFZ9YghncWgRuBnp9lV1sIRGwALjpP0bED9JVIBuW2bjfvELDFb6jgjASCrsc4WfCEuP2yPm2KG2PFbICJRcH96Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGBhLXW7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGBhLXW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768501035; x=1800037035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N6NKRgzwl3lXmSkzjZsx1633PUjUv2stdgLbhns6WA8=;
  b=bGBhLXW7KCPSATeb4DbV6nIcMeudQQTYasdwXEDkXGSJE4j1W4BWX/sE
   axwNEKlPFaGXs1SRiGb741Np0rvoadOHiRn2vfExnYdCQYBf8Mi38xtxA
   um1mjzk+0zsOcKF+vjSv1+yNXCDN+axnMDbjiKIU32D5fr7Cn7FWcWmDM
   k4e1+Gq/E1XF+nksRQgSfS75GNnfTIa1/szXj7rZc9S7xfWJR1LWjmadL
   ImCElBIz/uo4vlaNsPBMklutdL7t75dqqTgzkNKqf7dlcF5sNo1riiaBj
   BPonUqG1RkwzFjzF1D2nrIWLt//nM+0pdubK69qEH+x0ojW1jFD8LvLHO
   Q==;
X-CSE-ConnectionGUID: 56pylib3SrW2RTF/DqKQog==
X-CSE-MsgGUID: 7yjNpo7KS2yMSluw96VdQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69906065"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69906065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 10:17:15 -0800
X-CSE-ConnectionGUID: Ne0wxOdXShyeC/09hGC8eA==
X-CSE-MsgGUID: XFqG56w6S9uYgATMZl+27g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="205079937"
Received: from unknown (HELO [10.241.241.114]) ([10.241.241.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 10:17:14 -0800
Message-ID: <35c0bfdd-2f1e-4165-be34-660ecb99d141@intel.com>
Date: Thu, 15 Jan 2026 10:17:14 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] perf/x86/intel/uncore: Fix die ID init and look up
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
References: <20260113205650.5201-1-zide.chen@intel.com>
 <20260113205650.5201-2-zide.chen@intel.com>
 <54ac8a9e-e846-42eb-b09e-76e781a4375f@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <54ac8a9e-e846-42eb-b09e-76e781a4375f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/13/2026 9:19 PM, Mi, Dapeng wrote:
> 
> On 1/14/2026 4:56 AM, Zide Chen wrote:
>> In snbep_pci2phy_map_init(), in the nr_node_ids > 8 path,
>> uncore_device_to_die() may return -1 when all CPUs associated
>> with the UBOX device are offline.
>>
>> Remove the WARN_ON_ONCE(die_id == -1) check for two reasons:
>>
>> - The current code breaks out of the loop. This is incorrect because
>>   pci_get_device() does not guarantee iteration in domain or bus order,
>>   so additional UBOX devices may be skipped during the scan.
>>
>> - Returning -EINVAL is incorrect, since marking offline buses with
>>   die_id == -1 is expected and should not be treated as an error.
>>
>> Separately, when NUMA is disabled on a NUMA-capable platform,
>> pcibus_to_node() returns NUMA_NO_NODE, causing uncore_device_to_die()
>> to return -1 for all PCI devices.  As a result,
>> spr_update_device_location(), used on Intel SPR and EMR, ignores the
>> corresponding PMON units and does not add them to the RB tree.
>>
>> Fix this by using uncore_pcibus_to_dieid(), which retrieves topology
>> from the UBOX GIDNIDMAP register and works regardless of whether NUMA
>> is enabled in Linux.  This requires snbep_pci2phy_map_init() to be
>> added in spr_uncore_pci_init().
>>
>> Keep uncore_device_to_die() only for the nr_node_ids > 8 case, where
>> NUMA is expected to be enabled.
>>
>> Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
>> Fixes: 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR")
>> Tested-by: Steve Wahl <steve.wahl@hpe.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V2:
>> - Fix the commit message to note that spr_update_device_location() is
>>   used by EMR, not GNR.
>> - Rewrite the commit message for clarity.
>> - Add a Tested-by tag.
>>
>>  arch/x86/events/intel/uncore.c       |  1 +
>>  arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index c126a29ab729..c721042be629 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -67,6 +67,7 @@ int uncore_die_to_segment(int die)
>>  	return bus ? pci_domain_nr(bus) : -EINVAL;
>>  }
>>  
>> +/* Note: This API can only be used when NUMA information is available. */
>>  int uncore_device_to_die(struct pci_dev *dev)
> 
> Not everyone could look at the comment and follow the rule. Could we add a
> WARN_ON in this function and WARN the users if it's not used appropriately? 

I may be missing something, but I can’t find a simple, clean, and
reliable way to determine that NUMA is not available (either disabled by
Linux/firmware or not supported by the hardware).

For example, NUMA_NO_NODE returned from pcibus_to_node() only indicates
that the kernel cannot associate the given PCI bus with any NUMA node.
This can happen even when NUMA is enabled, if the PCI locality
information is unavailable for some PCI buses for some reasons.

Commit ad5086108b (“PCI: Warn if no host bridge NUMA node info”)
explicitly discusses this case, which is also consistent with the Linux
documentation:

https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-pci

I haven’t looked closely at the CPU-to-node mapping and don’t know
whether it would work reliably here. Even if it does, my intuition is
that it may not worth adding the extra complexity in this situation.


> Others look good to me.
> 
> 
>>  {
>>  	int node = pcibus_to_node(dev->bus);
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index 7ca0429c4004..52dec34d18c4 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -1459,13 +1459,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
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
>> @@ -6420,7 +6414,7 @@ static void spr_update_device_location(int type_id)
>>  
>>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>>  
>> -		die = uncore_device_to_die(dev);
>> +		die = uncore_pcibus_to_dieid(dev->bus);
>>  		if (die < 0)
>>  			continue;
>>  
>> @@ -6444,6 +6438,11 @@ static void spr_update_device_location(int type_id)
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

