Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE2335067;
	Mon, 16 Mar 2026 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680343; cv=none; b=hcI348v83o0BGdnXLvTA9W/BDqTGp0NKo2e60rFyHVnoX7hk6cG2HzK3i4vs8IWLT9IULkzq+Y7qCtQ31VOb/ER1rIXwb+0YlgzAALQvWtowqOFda32t0Jl1ypTi/7s8BNNAQK2hjYUbkcrxYb62aqSrP1963nfkwQECxk1HDcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680343; c=relaxed/simple;
	bh=6kyhGMclKhoByEDQ31nH2QKzOsdm+RXquTaL6ve8oK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCwxBQbKDVDswkFHjBEjTk+xf39neOq3wnqm0WKGywgHvmKD3Vi/aH8HYxHNOzaWU3zdcLo2PWUTZA41Mvr3uuNe2zETpn+0OwcphTs8mo2NwMYF8lqlhOFfQR/SV2hmx+8DK0H1AP5DklxE58SbGaySBy+9tBqghKqgyXEZxhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXpx1l3m; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXpx1l3m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773680342; x=1805216342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6kyhGMclKhoByEDQ31nH2QKzOsdm+RXquTaL6ve8oK4=;
  b=YXpx1l3mRs7ge6WPTFotMsxZLUGfexCurhCFURv6Y8jv+gew5XJbrhYq
   enoTYp7brlLt/Zg8TK8Dnhfdo2z1VVWGFakXS92V12cChWmNFR9Ei979e
   vbrzhWI1PGiZaBC1XmC2fcL54Z1B9Ece2sE87pFQ9IN4h57tixJuaZHwT
   A827/CDWMsrk7xv/jRlTw+ZE9h70a7yHBtr5dF8RzfZjIIWxBCeVF8eHl
   HnEZPGjfqBNyNPRWhmmHT/FSzqDyAPA6qFr3cYxEBNIZrwUAIoxDGBs6a
   FdqAGlUfY1lU6RXaYUGw+Vi1TwBTFhLn4c2TtN0ehguWU/B3Lbso18cl2
   Q==;
X-CSE-ConnectionGUID: Rg+n4+7zTi6hg85FS5NN8Q==
X-CSE-MsgGUID: Jwu6R8ePTIKVINLqrgaNkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85331353"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85331353"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:59:00 -0700
X-CSE-ConnectionGUID: bx/1BhI+Qs6n6sP4JdTrOw==
X-CSE-MsgGUID: BCTi08vuRmmhjDQYUT3ukw==
X-ExtLoop1: 1
Received: from unknown (HELO [10.241.241.35]) ([10.241.241.35])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:58:59 -0700
Message-ID: <8f257e9d-6a39-438c-9c41-6f68e2ef6d62@intel.com>
Date: Mon, 16 Mar 2026 09:58:56 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] perf/x86/intel/uncore: Fix die ID init and look up
 bugs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Chun-Tse Shao <ctshao@google.com>,
 Markus Elfring <Markus.Elfring@web.de>
References: <20260313174050.171704-1-zide.chen@intel.com>
 <20260313174050.171704-4-zide.chen@intel.com>
 <c18ccaf6-3b4d-486a-9d88-76dd715902a2@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <c18ccaf6-3b4d-486a-9d88-76dd715902a2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/2026 11:53 PM, Mi, Dapeng wrote:
> 
> On 3/14/2026 1:40 AM, Zide Chen wrote:
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
>> V4: no changes.
>> ---
>>  arch/x86/events/intel/uncore.c       |  1 +
>>  arch/x86/events/intel/uncore_snbep.c | 13 ++++++-------
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 786bd51a0d89..e9cc1ba921c5 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -67,6 +67,7 @@ int uncore_die_to_segment(int die)
>>  	return bus ? pci_domain_nr(bus) : -EINVAL;
>>  }
>>  
>> +/* Note: This API can only be used when NUMA information is available. */
>>  int uncore_device_to_die(struct pci_dev *dev)
>>  {
>>  	int node = pcibus_to_node(dev->bus);
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index 9b51883fd6fd..421378f681d7 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -1459,13 +1459,7 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>>  			}
>>  
>>  			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
> 
> The "die_id" variable is not needed any more after removing below check,
> please remove it.

Good catch, thanks.

> Others look good to me. Thanks.
> 
> 
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

