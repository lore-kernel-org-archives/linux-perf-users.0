Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2BD20C001;
	Thu, 30 Oct 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805398; cv=none; b=EQGg0J+9QbMPME+KEEvY3eOUjmhKdYt9CALwuVOtf4BCYiYPhn27Jq6DXZYllltN41qCfb53TgkN/vJ7c2ayn9DAMuvpNXTfVpiDUL2O/yJjytRNMbPmwSVkXGR6wC/FJ/jFVAUk3vCu08b/MM3ygMdMa4idsP43AwjHMGkQ9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805398; c=relaxed/simple;
	bh=8JEvfJznp6jGS3DzFu1jptEDBsT3mI082oE29zkbrJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+OS3IxIG/lnTt5Ax5Gaiw7pbGfX2jYvtnWwoaQ8aAud9KQBEjFkxe1iQKCoWUEj0VukKvFAN00eS3FOuwKWo02vWQpOyu/syX/XXiSjBXqfbaBD9Uxv2ITtDyVoQ1O9FENHSiJvBJq9dPOSA5s2zXtJH9iYIZd1QZ5dFNBWDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCaQy/8c; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCaQy/8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761805396; x=1793341396;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8JEvfJznp6jGS3DzFu1jptEDBsT3mI082oE29zkbrJo=;
  b=UCaQy/8cN8s1IHyIxRik2R5+zvrhcmWlDELieXzUwCiGyEvDxzDorTib
   a2vbh2fhLBS+ktTSo1nb/8RNo5EVHSXdEJiQpe0hkarCwZZvdjnxjNA2D
   pj3zTI7T8lDQ9WF1MvBvpx7BgB1AQ8SepMqTsXN1wcy54rmqq0o/tEsmY
   jE+xy00F1lrdCKydlVd+U6+V1b3OM/jk0dFYePs0reHPtSwwpnfG2lXJf
   +woJt3EcZr4Ek7Y8xFaL/w4VOS77G45AkhIcIS93DapziyJ3owAX33dgs
   pd9orufy+StHNu9bftgasO3VY8iOZRa/5HWV2E+nAJX7B3fSFjkC6aUvk
   g==;
X-CSE-ConnectionGUID: UvJughhSSI6GpjRe7n+gog==
X-CSE-MsgGUID: DnN4MseDRdiM0wmHPRvYjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63637520"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63637520"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 23:23:15 -0700
X-CSE-ConnectionGUID: 8Qw0+HVuRrG4/FaLyl+1dA==
X-CSE-MsgGUID: DwV7meWpTEyxh9YB/uvt1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216528980"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.233.250]) ([10.124.233.250])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 23:23:12 -0700
Message-ID: <2d5456ec-b799-4a90-ac7a-f49deafa110d@linux.intel.com>
Date: Thu, 30 Oct 2025 14:23:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel/uncore: Skip discovery table for
 offline dies
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
 <189f3475-81e3-4353-8f7e-f7a5933143a5@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <189f3475-81e3-4353-8f7e-f7a5933143a5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/30/2025 12:38 PM, Chen, Zide wrote:
> On 10/29/2025 6:37 PM, Mi, Dapeng wrote:
>> On 10/30/2025 6:07 AM, Zide Chen wrote:
>>> This warning can be triggered if NUMA is disabled and the system
>>> boots with fewer CPUs than the number of CPUs in die 0.
>>>
>>> WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]
>>>
>>> Currently, the discovery table continues to be parsed even if all CPUs
>>> in the associated die are offline. This can lead to an array overflow
>>> at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
>>> trigger the warning above or cause other issues.
>>>
>>> Reported-by: Steve Wahl <steve.wahl@hpe.com>
>>> Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>>  arch/x86/events/intel/uncore.c           | 4 ++++
>>>  arch/x86/events/intel/uncore_discovery.c | 2 +-
>>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>> index ee586eb714ec..5c3aeea5c78d 100644
>>> --- a/arch/x86/events/intel/uncore.c
>>> +++ b/arch/x86/events/intel/uncore.c
>>> @@ -1380,6 +1380,10 @@ static void uncore_pci_pmus_register(void)
>>>  
>>>  		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
>>>  			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
>>> +
>>> +			if (WARN_ON(unit->die >= uncore_max_dies()))
>> Base on my understanding, it seems an valid situation which could happen.
>> If so, we'd better remove the WARN_on to avoid it mislead users. Thanks.
> Now, for invalid or offline die IDs, we skip parsing the discovery
> table, and no PMON units are expected to be inserted into the RB tree.
> Therefore, using WARN_ON() here seems appropriate.
>
> I put a WARN_ON() here because invalid die ID could cause array overflow.

Ok, it's good then. Thanks.


>
>  >> +				continue;
>>> +
>>>  			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
>>>  							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
>>>  							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
>>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>>> index 1bf6e4288577..d6aee12139f1 100644
>>> --- a/arch/x86/events/intel/uncore_discovery.c
>>> +++ b/arch/x86/events/intel/uncore_discovery.c
>>> @@ -388,7 +388,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
>>>  				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
>>>  
>>>  			die = get_device_die_id(dev);
>>> -			if (die < 0)
>>> +			if ((die < 0) || (die >= uncore_max_dies()))
>>>  				continue;
>>>  
>>>  			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
