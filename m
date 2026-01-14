Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BB7261D;
	Wed, 14 Jan 2026 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357896; cv=none; b=iHNnHrn9jsn9olI70gPhWY30hAc6l/T9LkWmt0u9v/JwOBbiwlhrxlpoOdiWey1fFqZIP0iTnuXUlJ5zE3P5Tfm5yyr+kmiQWckTWZDQQg0hONTfG2gZxzCunUveJS3Fg33+hMxF5AvNx+JMSpKH/XJajjzjLlzPbnvMuOKzmW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357896; c=relaxed/simple;
	bh=38CwZJ2x+56Uh8JKczXiJMcN6ykFIXwc6RUgiQWEaGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUsktHXnxVkx4nYyg5nka8V8CXANUsyfRk5saq39TUmFOQk7sklK9De4WAM7FGjbFB1MbRBlEAqyY2UgWwbDXAnWfGedb/T0LW39EXhtX+imEEepI4aagoVc08pbNRPEdZLcPkdPpqpyEnMxDsXKbLZpK2UaQsdJrpqYyrj7Xo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDuHUkgD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDuHUkgD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768357896; x=1799893896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=38CwZJ2x+56Uh8JKczXiJMcN6ykFIXwc6RUgiQWEaGE=;
  b=aDuHUkgD0j/p3nzaRZNQxmu32GNySbTI41j+BC59uqneHcglgmyQExGv
   lPh+SQDnzBDvTYQq18qARTxNVljnPyxIWYXmHy93vqV3xjSFI7j+/KGdR
   p01eSVl2UDlyh1Qjs7kgnVrL3BDN5fhDt90o8qHbJXJcSM5frvB/qsLn3
   ZZFzuESFJCb8ZKiS1g9t46rEdBsiC0Pp1hqGxnO3+KSkYzEDmeV+L39gF
   aS7ZqBtzu0mDwfjq14EOvF4aLX9IRHQZhaB8WmEzfVMVGL+7Yiqy/uVRO
   lJpc0vosaQyP0cQmK5TwHG54N3Sm22nMRbuGW8/H0CPiRhkT4IO2KcwNk
   w==;
X-CSE-ConnectionGUID: grxl68D3S4GDDr7UhdvCxw==
X-CSE-MsgGUID: 6DDmByIdR2GNYfv4Abha7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87067567"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="87067567"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 18:31:35 -0800
X-CSE-ConnectionGUID: U9epA1EdQ6ezJ1JHITNDtg==
X-CSE-MsgGUID: SwFDZTYiTcGJjnKB5fDGqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204441401"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 18:31:31 -0800
Message-ID: <a2723541-ee60-4793-8376-b1247e72ae86@linux.intel.com>
Date: Wed, 14 Jan 2026 10:31:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] perf/x86/intel/uncore: Skip discovery table for
 offline dies
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20260113205650.5201-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260113205650.5201-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/14/2026 4:56 AM, Zide Chen wrote:
> This warning can be triggered if NUMA is disabled and the system
> boots with fewer CPUs than the number of CPUs in die 0.
>
> WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]
>
> Currently, the discovery table continues to be parsed even if all CPUs
> in the associated die are offline.  This can lead to an array overflow
> at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
> trigger the warning above or cause other issues.
>
> Reported-by: Steve Wahl <steve.wahl@hpe.com>
> Tested-by: Steve Wahl <steve.wahl@hpe.com>
> Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - Add the Tested-by tag
> - Rebase onto perf/core (base commit: a491c02c2770)
>
>  arch/x86/events/intel/uncore.c           | 4 ++++
>  arch/x86/events/intel/uncore_discovery.c | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 4684649109d9..c126a29ab729 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1368,6 +1368,10 @@ static void uncore_pci_pmus_register(void)
>  
>  		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
>  			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
> +
> +			if (WARN_ON(unit->die >= uncore_max_dies()))
> +				continue;

I'm thinking if we need to add "WARN_ON" here. Since all uncore units that
the die id is larger than uncore_max_dies() would be skipped in discovery
phase, the unit die id should be not larger than uncore_max_dies() in
uncore_pci_pmus_register(). Is it right?


> +
>  			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
>  							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
>  							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index b46575254dbe..0e414cecb6f2 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -366,7 +366,7 @@ static bool uncore_discovery_pci(struct uncore_discovery_domain *domain)
>  				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
>  
>  			die = get_device_die_id(dev);
> -			if (die < 0)
> +			if ((die < 0) || (die >= uncore_max_dies()))
>  				continue;
>  
>  			parse_discovery_table(domain, dev, die, bar_offset, &parsed);
