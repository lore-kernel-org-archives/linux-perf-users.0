Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CF2264AB;
	Fri, 16 Jan 2026 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768540781; cv=none; b=BbiKDQx2g7dZxyjqW4W2vnX/Gfi5fGxs8NK+Rkzj5WhSV6MXGbupNStbT4vjdahzOuJ7OzCT74ZNbygvfQgwDhKOpnZRijcNr6OosOVUycVT+2541fLPzjKK9y8A7SL41gAnZ3DiufVUb2COt1XuCei+1cs0bY57Txc0+T/gtUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768540781; c=relaxed/simple;
	bh=NjaRIeNPuqZQMSohOVwbQjJNUp0QgDUE9NRk+PWzX20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJUEov2cgu1F1wq/3nMAo1NhpKagXSf9cgScId0WZxp3Xfx8vuDOVHC/Fc4p7ZyhExuZkV9vlkyF6c1A7BF4qsX/ERKL2KzHJ3cP50IITMcAF0bKhiC7q4VTa23bkWgeqr6MIlayk9Ndf138eeIEfbQ0f7nsGfrR1T0Sx4i+wxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPKh8hMc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPKh8hMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768540780; x=1800076780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NjaRIeNPuqZQMSohOVwbQjJNUp0QgDUE9NRk+PWzX20=;
  b=iPKh8hMcCw5ldFgL27y0KBAG//3z3DVWjCEl9QHBM27FZ4+7pwW4jjtL
   I8m+7j6dw8e8Q00+rDo7gXuJ2u3xOKbLP/E4xzVENh3zblBWyDLqzE3JK
   I/MC3Qci0YORWaxtV/y0n40ieygEFTBnUX1N8g26JpglHJUyUsPLeDeHA
   Sk/KmQOgBVUsjhCH7qxExXbAdL+3UThKpplQSY0vGJNMox+CyUTn+sNV9
   FjrpNTdVoDzdM+O2SA93g3WCOAhKSBTmetGgQYmr/HrmtrvkXNnsCODvy
   gGeyYHcaLZSTlBmtnMjDPYa9wRLJ7c+TgzVdRFII21YtWx5Cix0RyKTRI
   g==;
X-CSE-ConnectionGUID: cFQcaRtGT6WVYzBXxGGZmQ==
X-CSE-MsgGUID: sQjotz/lQdm3xscnPgvEsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="68864804"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="68864804"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 21:19:39 -0800
X-CSE-ConnectionGUID: MhnpS4J3Qrm+5u1tqdm1Ug==
X-CSE-MsgGUID: xaor9QoZREuOzzNXZu2z0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="210185822"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 21:19:34 -0800
Message-ID: <047a815b-2b69-4dda-9ba0-6a91f5d955ce@linux.intel.com>
Date: Fri, 16 Jan 2026 13:19:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] perf/x86/intel/uncore: Skip discovery table for
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
References: <20260116031113.45098-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260116031113.45098-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/16/2026 11:11 AM, Zide Chen wrote:
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
> V3:
> - Remove the overly cautious WARN_ON()
>
>  arch/x86/events/intel/uncore_discovery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


