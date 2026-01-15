Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B23B8BB3;
	Thu, 15 Jan 2026 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501481; cv=none; b=KYycGtG4eRBZ1gyiQDufW/JDn4Xc/tGPcgrcXcOnFzJKJQCp5EIFIGg5AIywyI404WKwjqZx7SHMbi6RYvu62T5hI+nASVF65I+Cu/hLxD70mc7QHV6W/J5r2bJHy+zyC+EUOr2gNprNzQi/8uYLQVlvh04Rz2NNDFO/LD8w5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501481; c=relaxed/simple;
	bh=lmXQjyikOlfKxEhC8rWVGxFmvRC6zxqSFw870uhsPCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0eemLrC1fD89TCicNEV7M+HUWJndLe2CVX676Y28PEtoYxZ+mYw0yBV/CaO5kenvEBsTSIZ5gZ3A8j6aB4dS6cm1+kVujr77yxnfD4VZbffZj5o+SUOvnja/iuzIan7vYFz2j/lE+thqzRgZUBHpFVQVWPlkuMInoKp3TTjuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjwCQ6YA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjwCQ6YA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768501480; x=1800037480;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lmXQjyikOlfKxEhC8rWVGxFmvRC6zxqSFw870uhsPCI=;
  b=YjwCQ6YAdJHxyGNaSkw/RcVEbSzb/hfmOGHZQfJ/PUYl0xMOkc9EfikV
   BbU9tthniTLhRrRMaz4jP9yCaIzh9jlN+Y5Cc5emZ5AinXFezalt8ffCm
   VKFbS7OrC5FE+8wdsY0yQiML9PrYQKWgnMBgEnQyZTq4cZqZ8NaQldkd2
   DFQrx64O1T6qAcAunZvGhWWlQTVNeEsyy1ioiEmvAdBFj9RxVNSILDNoO
   XOyGKAPjkB3OTi6Fn1RL4gqttLiGm2IBBsBPzJVV2KfCZ66vPA8YTLaqg
   olxtVXAptK1Lsj0psFAn5G2UoD9+5jGHohWIiQbwmi8Jdt8y2YaXFvse/
   g==;
X-CSE-ConnectionGUID: CTlBUNwFSmOnB6LK3OPW5w==
X-CSE-MsgGUID: todM87u1QhqkMqXcEcK+FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69906610"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="69906610"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 10:24:39 -0800
X-CSE-ConnectionGUID: TFaU34dfSCumbr2jonCh+Q==
X-CSE-MsgGUID: KzBsjPbvRmOCol+41/rBgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="205080920"
Received: from unknown (HELO [10.241.241.114]) ([10.241.241.114])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 10:24:39 -0800
Message-ID: <d263cc20-6e6c-47c4-9a9b-0d9b4221322e@intel.com>
Date: Thu, 15 Jan 2026 10:24:38 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] perf/x86/intel/uncore: Skip discovery table for
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
References: <20260113205650.5201-1-zide.chen@intel.com>
 <a2723541-ee60-4793-8376-b1247e72ae86@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <a2723541-ee60-4793-8376-b1247e72ae86@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/2026 6:31 PM, Mi, Dapeng wrote:
> 
> On 1/14/2026 4:56 AM, Zide Chen wrote:
>> This warning can be triggered if NUMA is disabled and the system
>> boots with fewer CPUs than the number of CPUs in die 0.
>>
>> WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]
>>
>> Currently, the discovery table continues to be parsed even if all CPUs
>> in the associated die are offline.  This can lead to an array overflow
>> at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
>> trigger the warning above or cause other issues.
>>
>> Reported-by: Steve Wahl <steve.wahl@hpe.com>
>> Tested-by: Steve Wahl <steve.wahl@hpe.com>
>> Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V2:
>> - Add the Tested-by tag
>> - Rebase onto perf/core (base commit: a491c02c2770)
>>
>>  arch/x86/events/intel/uncore.c           | 4 ++++
>>  arch/x86/events/intel/uncore_discovery.c | 2 +-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 4684649109d9..c126a29ab729 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -1368,6 +1368,10 @@ static void uncore_pci_pmus_register(void)
>>  
>>  		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
>>  			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
>> +
>> +			if (WARN_ON(unit->die >= uncore_max_dies()))
>> +				continue;
> 
> I'm thinking if we need to add "WARN_ON" here. Since all uncore units that
> the die id is larger than uncore_max_dies() would be skipped in discovery
> phase, the unit die id should be not larger than uncore_max_dies() in
> uncore_pci_pmus_register(). Is it right?


I originally added this as a defensive check in case it could trigger an
array overflow.

However, I agree it can be dropped since this condition should not be
reachable.



>> +
>>  			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
>>  							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
>>  							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>> index b46575254dbe..0e414cecb6f2 100644
>> --- a/arch/x86/events/intel/uncore_discovery.c
>> +++ b/arch/x86/events/intel/uncore_discovery.c
>> @@ -366,7 +366,7 @@ static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
>>  				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
>>  
>>  			die = get_device_die_id(dev);
>> -			if (die < 0)
>> +			if ((die < 0) || (die >= uncore_max_dies()))
>>  				continue;
>>  
>>  			parse_discovery_table(domain, dev, die, bar_offset, &parsed);

