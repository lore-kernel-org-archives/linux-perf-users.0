Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1831960B;
	Fri, 27 Mar 2026 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577033; cv=none; b=LcNsIvT87EHvkHjmLQaZluAtMErCS5ExaRvVKuuF8wv7+a+Z4Vzxxr4V+vmpA7rYpJQlEfm4B0uHccjH+VwXLU+9mgmNDXQay8nguKxEtXDDWC0wB6NxVxXMzRIVvlAI2f3aUWCdKo8ly2Fw0unzXaIDac47Br/XZy3c3wr9vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577033; c=relaxed/simple;
	bh=1mLwm6nWFkuZhwjNWGMKe7d/HVU11I2nz2eJ7ama8XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGyfH19clSHAwD5YeVjfhPsfpLoLxIcUJaNtA/Wo3U4p4wbv5fe70PqMYTwe4r9sm386F0lUi+GmYefRWmRrdxnmf7t402+ycM9+VLSFq+0k83aCTyuSBeGN3vSAnedQ/CmXU2NmxXdP8Nf13C3T1yHbtGt9Fd3fAK8El81jngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WywXl6Ew; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WywXl6Ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774577032; x=1806113032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1mLwm6nWFkuZhwjNWGMKe7d/HVU11I2nz2eJ7ama8XA=;
  b=WywXl6EwpQ1SVvZSbpuoJyY3K4nHYwkXyaYGQnjxzk5/zRGVF01bmlnF
   LlQtZUXs2oiPgETAkDQL3g9Sbq+fQVLfhar2B4b5rx3Q2FgN3iBblHNRh
   N/hLXOq4omBN9oE5lGFwt7iPOG1m8Kxrj1agUUcvu+6qSm/QPetTu80dV
   xI7GRmq5Fu9N2kpDHw2kqnxAFqYETh7xG+a5DWuef3sFXWLoVI332z2ZO
   V1WBs8VOCyEbVGjetR63+Nqw/i8bdEVpVd9gdwNqdfqszxX99or2ma5cA
   u0I2T3ShYQ0Tx+Am0ywQPLJmLlwEoEBiYDJwM8yZMpIebxYAhB2DE1GtI
   A==;
X-CSE-ConnectionGUID: FgGZx/xzRjWrEENMYMzNCw==
X-CSE-MsgGUID: FhOrAS4XSF+Oxmi0UzpCAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75616401"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75616401"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 19:03:51 -0700
X-CSE-ConnectionGUID: JNr6S7xjQnyz0yE2AnkGeQ==
X-CSE-MsgGUID: aMfhxPygRmGWUJfu/o6F5w==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 19:03:47 -0700
Message-ID: <360e04c7-68f0-4560-bcbf-d7adb7e94a35@linux.intel.com>
Date: Fri, 27 Mar 2026 10:03:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/4] perf/x86/intel/uncore: Fix die ID init and look up
 bugs
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Chun-Tse Shao <ctshao@google.com>,
 Markus Elfring <Markus.Elfring@web.de>
References: <20260324214932.10068-1-zide.chen@intel.com>
 <20260324214932.10068-4-zide.chen@intel.com>
 <7a6c5cf7-0d26-4b0b-b5b7-51d0d9782db8@linux.intel.com>
 <4d443905-a507-49cb-bbff-b1b212e5141a@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <4d443905-a507-49cb-bbff-b1b212e5141a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/27/2026 7:57 AM, Chen, Zide wrote:
>
> On 3/25/2026 11:03 PM, Mi, Dapeng wrote:
>> Zide, Sashiko gave some comments on this patch. Could you please have a
>> look if they are reasonable? Thanks.
>>
>> https://sashiko.dev/#/patchset/20260324214932.10068-1-zide.chen%40intel.com
> 1. Regarding the concern that this change may replace an offline node's
> -1 with the die ID of an adjacent online node, I do not think this is an
> issue.
>
> After this fix, the logic is the same for both (nr_node_ids <= 8) and
> (nr_node_ids > 8): map->pbus_to_dieid[bus] may be written with an
> invalid die_id (e.g., -1). This is not an error and is expected in some
> cases. We should continue to populate the map->pbus_to_dieid[] array.
>
> Regardless of the traversal order (as determined by the reverse
> argument), for a given die, the UBOX device is expected to reside on the
> first valid bus in the die it is affined to.
>
> Under the current assignment algorithm, all buses following a UBOX
> device, up to the next UBOX device or the end of traversal, are assigned
> the same die ID.
>
> For example, on SPR, there are two UBOX devices: one device on bus 0x7e
> in die 0, and another on bus 0xfe in die 1. With reversed traversal
> order, buses 0xff–0x7f are assigned die ID 1, while buses 0x7e–0x00 are
> assigned die ID 0.
>
> If all CPUs in die 1 are offline, then buses 0xff–0x7f are assigned -1.
> This is fine.
>
> That being said, the die ID for invalid buses is not consistent, which
> is not ideal.

Yes, for the case with 2 sockets and socket 1 is offline, it's correct. But
assume there are 4 sockets (0/1/2/3), buses 0x0-0x3f are attached to socket
0, buses 0x40-0x7f are attached to socket 1, buses 0x80-0xbf are attached
to socket 2 and buses 0xc0-0xff are attached to socket 3, the socket 2 is
offline. In reverse order, the die id of  buses 0x80-0xbf would be
overwritten to 3 instead of -1, right?

But it seems there is not a good way to fix this issue and the function
spr_update_device_location() won't really find the ubox device of socket 2
since socket 2 has been offline. So it won't cause a real issue. 


>
> 2. Regarding the repeated snbep_pci2phy_map_init() calls. I wanted a
> "simple" fix initially.  I may need to split this patch into two
> separate patches.
>
>> On 3/25/2026 5:49 AM, Zide Chen wrote:
>>> In snbep_pci2phy_map_init(), in the nr_node_ids > 8 path,
>>> uncore_device_to_die() may return -1 when all CPUs associated
>>> with the UBOX device are offline.
>>>
>>> Remove the WARN_ON_ONCE(die_id == -1) check for two reasons:
>>>
>>> - The current code breaks out of the loop. This is incorrect because
>>>   pci_get_device() does not guarantee iteration in domain or bus order,
>>>   so additional UBOX devices may be skipped during the scan.
>>>
>>> - Returning -EINVAL is incorrect, since marking offline buses with
>>>   die_id == -1 is expected and should not be treated as an error.
>>>
>>> Separately, when NUMA is disabled on a NUMA-capable platform,
>>> pcibus_to_node() returns NUMA_NO_NODE, causing uncore_device_to_die()
>>> to return -1 for all PCI devices.  As a result,
>>> spr_update_device_location(), used on Intel SPR and EMR, ignores the
>>> corresponding PMON units and does not add them to the RB tree.
>>>
>>> Fix this by using uncore_pcibus_to_dieid(), which retrieves topology
>>> from the UBOX GIDNIDMAP register and works regardless of whether NUMA
>>> is enabled in Linux.  This requires snbep_pci2phy_map_init() to be
>>> added in spr_uncore_pci_init().
>>>
>>> Keep uncore_device_to_die() only for the nr_node_ids > 8 case, where
>>> NUMA is expected to be enabled.
>>>
>>> Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
>>> Fixes: 65248a9a9ee1 ("perf/x86/uncore: Add a quirk for UPI on SPR")
>>> Tested-by: Steve Wahl <steve.wahl@hpe.com>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> V2:
>>> - Fix the commit message to note that spr_update_device_location() is
>>>   used by EMR, not GNR.
>>> - Rewrite the commit message for clarity.
>>> - Add a Tested-by tag.
>>>
>>> V5:
>>> - Remove unused variable die_id (Dapeng).
>>> ---
>>>  arch/x86/events/intel/uncore.c       |  1 +
>>>  arch/x86/events/intel/uncore_snbep.c | 17 ++++++++---------
>>>  2 files changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>> index 786bd51a0d89..e9cc1ba921c5 100644
>>> --- a/arch/x86/events/intel/uncore.c
>>> +++ b/arch/x86/events/intel/uncore.c
>>> @@ -67,6 +67,7 @@ int uncore_die_to_segment(int die)
>>>  	return bus ? pci_domain_nr(bus) : -EINVAL;
>>>  }
>>>  
>>> +/* Note: This API can only be used when NUMA information is available. */
>>>  int uncore_device_to_die(struct pci_dev *dev)
>>>  {
>>>  	int node = pcibus_to_node(dev->bus);
>>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>>> index 9b51883fd6fd..5ef205a70559 100644
>>> --- a/arch/x86/events/intel/uncore_snbep.c
>>> +++ b/arch/x86/events/intel/uncore_snbep.c
>>> @@ -1413,7 +1413,7 @@ static int topology_gidnid_map(int nodeid, u32 gidnid)
>>>  static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool reverse)
>>>  {
>>>  	struct pci_dev *ubox_dev = NULL;
>>> -	int i, bus, nodeid, segment, die_id;
>>> +	int i, bus, nodeid, segment;
>>>  	struct pci2phy_map *map;
>>>  	int err = 0;
>>>  	u32 config = 0;
>>> @@ -1458,14 +1458,8 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>>>  				break;
>>>  			}
>>>  
>>> -			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
>>> -
>>> +			map->pbus_to_dieid[bus] = uncore_device_to_die(ubox_dev);
>>>  			raw_spin_unlock(&pci2phy_map_lock);
>>> -
>>> -			if (WARN_ON_ONCE(die_id == -1)) {
>>> -				err = -EINVAL;
>>> -				break;
>>> -			}
>>>  		}
>>>  	}
>>>  
>>> @@ -6420,7 +6414,7 @@ static void spr_update_device_location(int type_id)
>>>  
>>>  	while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev)) != NULL) {
>>>  
>>> -		die = uncore_device_to_die(dev);
>>> +		die = uncore_pcibus_to_dieid(dev->bus);
>>>  		if (die < 0)
>>>  			continue;
>>>  
>>> @@ -6444,6 +6438,11 @@ static void spr_update_device_location(int type_id)
>>>  
>>>  int spr_uncore_pci_init(void)
>>>  {
>>> +	int ret = snbep_pci2phy_map_init(0x3250, SKX_CPUNODEID, SKX_GIDNIDMAP, true);
>>> +
>>> +	if (ret)
>>> +		return ret;
>>> +
>>>  	/*
>>>  	 * The discovery table of UPI on some SPR variant is broken,
>>>  	 * which impacts the detection of both UPI and M3UPI uncore PMON.
