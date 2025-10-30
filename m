Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A42DECDE;
	Thu, 30 Oct 2025 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761799119; cv=none; b=ZbdK4GBQJv9TY8YtVbo4nJweVLaDHI9rDrSt6JFvHUXT79lhkwQDwMSu1IDEwL3HwvMvpjK9EVxDXC1vRknjXObmLFBRxx6l87qGZ9MH6MYUD2EXjHtkVHPbHhwOjVkwZ6pgEiEBDweqmyS1PMBipDuLgZIu6a2la5TDFON+qY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761799119; c=relaxed/simple;
	bh=erYvSFJ0MeLGYLbfR1vnaY7iR18cOOrQbEV15SRTuVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxB4CC51ayF71Su/n15PqzBl0D36VlePrGTn2XVGuYftzVTS5TdXQahcVCxeuLgOY492PuMzAqtlZcCMmoibNq86RyDiK7ujnFZlAKVk7KDqkXdhGao0LK5u5Ln9ZPz4lON90wdaWL0Njzn8wLEPYUnL+DKQeA631dK95Rj8IMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlPBEW1+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlPBEW1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761799117; x=1793335117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=erYvSFJ0MeLGYLbfR1vnaY7iR18cOOrQbEV15SRTuVM=;
  b=VlPBEW1+Ymt4qTBuCHZCJp2bsNMz5tWDH9t8aL4iAaHeCbIgngPGX0V5
   /JcLk4ubfQrA1njZo+yNPZYAq1j9nVSznPGoeoMn6Sv+6Gxl25Fe1+FeE
   K5Qx4T+lQEhNG7KHQSCSiQ29bU0L9M64sfgW7ekF6B0v6K9lxkPaEh01z
   u/rZGtrstibX3XwY/e6p68FQirSgktX/Y+EwUw3NKx5ujNYMprx/Hm2jc
   a/zNeFFRs8guxL36ZNfU+p08t2cwJccKXyI7Of0FAGOd5y0Qxt6pSeah/
   3OGoRwUdUzV9nxNNPIXmJAS0sIvBgoLI5yqzj2NOl02BTa5xwFExz3rMx
   g==;
X-CSE-ConnectionGUID: kfBjrd12Tai1ol9SeVuciw==
X-CSE-MsgGUID: Dy7a8aHFQeGAF6t9SMrqug==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64081229"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64081229"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 21:38:37 -0700
X-CSE-ConnectionGUID: LsLq6yelSXm05Z/vdFT4aQ==
X-CSE-MsgGUID: QH5iBq/MT6CafnxqbZKDsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185939072"
Received: from aathaval-mobl.amr.corp.intel.com (HELO [10.125.182.143]) ([10.125.182.143])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 21:38:36 -0700
Message-ID: <189f3475-81e3-4353-8f7e-f7a5933143a5@intel.com>
Date: Wed, 29 Oct 2025 21:38:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel/uncore: Skip discovery table for
 offline dies
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
 <8b53854e-f407-4c58-badc-01327d2d4be0@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <8b53854e-f407-4c58-badc-01327d2d4be0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/29/2025 6:37 PM, Mi, Dapeng wrote:
> 
> On 10/30/2025 6:07 AM, Zide Chen wrote:
>> This warning can be triggered if NUMA is disabled and the system
>> boots with fewer CPUs than the number of CPUs in die 0.
>>
>> WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]
>>
>> Currently, the discovery table continues to be parsed even if all CPUs
>> in the associated die are offline. This can lead to an array overflow
>> at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
>> trigger the warning above or cause other issues.
>>
>> Reported-by: Steve Wahl <steve.wahl@hpe.com>
>> Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/uncore.c           | 4 ++++
>>  arch/x86/events/intel/uncore_discovery.c | 2 +-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index ee586eb714ec..5c3aeea5c78d 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -1380,6 +1380,10 @@ static void uncore_pci_pmus_register(void)
>>  
>>  		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
>>  			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
>> +
>> +			if (WARN_ON(unit->die >= uncore_max_dies()))
> 
> Base on my understanding, it seems an valid situation which could happen.
> If so, we'd better remove the WARN_on to avoid it mislead users. Thanks.

Now, for invalid or offline die IDs, we skip parsing the discovery
table, and no PMON units are expected to be inserted into the RB tree.
Therefore, using WARN_ON() here seems appropriate.

I put a WARN_ON() here because invalid die ID could cause array overflow.

 >> +				continue;
>> +
>>  			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
>>  							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
>>  							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>> index 1bf6e4288577..d6aee12139f1 100644
>> --- a/arch/x86/events/intel/uncore_discovery.c
>> +++ b/arch/x86/events/intel/uncore_discovery.c
>> @@ -388,7 +388,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
>>  				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
>>  
>>  			die = get_device_die_id(dev);
>> -			if (die < 0)
>> +			if ((die < 0) || (die >= uncore_max_dies()))
>>  				continue;
>>  
>>  			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);

