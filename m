Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77F10E9;
	Fri, 11 Jul 2025 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201460; cv=none; b=KavIhjjXYTjVAFuFldgH/I34XiJFN1+/oND3NRK874Fs6fjw3OiicpV3wVfT8e9fIs/9TKrdKXPXpHrBF9cyIrQQSY6uLzblnfHO+AYviEgh7pi+DerS8CgS/LK/1kH2adGIHvzW8gIaDSKP1SAIuA0WITpQSFTPhSiSFoJ5p8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201460; c=relaxed/simple;
	bh=BjPHHr4a5+oy9DmWRAHHKi4KHpsYaKX1I09Y7rUXVb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7iBD4HZ4F+PlOjfPSCBLLZt6ZX6VneimbX/xPFlj0S1z7raUAXziALUSb+tSxyjbO0Srone374DWp+yIGSSScph8GGPlyHKFBlbhAinETrX7k33UVyAdu0t2oqbXlZ0HCmgpVvFHGAdqMqtzavVVgQ1945E9VYlb1YcLePlbio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0L1YSF1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0L1YSF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752201459; x=1783737459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BjPHHr4a5+oy9DmWRAHHKi4KHpsYaKX1I09Y7rUXVb8=;
  b=Q0L1YSF1G4TP2qTYEzaiocTQ9hlcebPaoAYrlGocy5hi24gT7JMuJIY2
   ce+FhaXp1iybK+LIEvmHJ+PL1hMgXnAO2A/WcBT5jzryhJhnTtbOhKuvx
   xzoeyVGxsG9cDab6Wd4UXHY+A7eNjpwOREmmnKhHu9WAIsvVYPXIJLkuC
   FGZHsSkj7dxnT2pv2gAQt7adao8x7M/m36bRsxy8uo7mKqlYL0OJ4Li0g
   EUcR5fFjM4gPLo25EgyG39/3ZLspKYwJ35iwR7+iFARzqeF8Ds3YNDS0O
   KGEUApd+THFhrFmXA2C2FePb8q9dViDyT80e+QPJnBXI9D6mxsh7JxZXl
   g==;
X-CSE-ConnectionGUID: HfbEe11GSfy26QdZKZIMtg==
X-CSE-MsgGUID: YOyGKbdvTdujDw8mzMovIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54432852"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="54432852"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:37:38 -0700
X-CSE-ConnectionGUID: T2ZGoxUfSQ+RhxSiSDNaZg==
X-CSE-MsgGUID: urrDk3QdTuK4SmkeRrraSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="155883670"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.37]) ([10.124.240.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 19:37:34 -0700
Message-ID: <9c96ca51-70ef-43f2-be84-b6879dc4c79d@linux.intel.com>
Date: Fri, 11 Jul 2025 10:37:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Use early_initcall() to hook bts_init()
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Andrew Zaborowski <andrew.zaborowski@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250606111606.84350-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250606111606.84350-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kindly ping.

@Peter, not sure you have bandwidth to review this change? Thanks.

On 6/6/2025 7:16 PM, Dapeng Mi wrote:
> After the commit 'd971342d38bf ("perf/x86/intel: Decouple BTS
>  initialization from PEBS initialization")' is introduced, x86_pmu.bts
> would initialized in bts_init() which is hooked by arch_initcall().
>
> Whereas init_hw_perf_events() is hooked by early_initcall(). Once the
> core PMU is initialized, nmi watchdog initialization is called
> immediately before bts_init() is called. It leads to the BTS buffer is
> not really initialized since bts_init() is not called and x86_pmu.bts is
> still false at that time. Worse, BTS buffer would never be initialized
> then unless all core PMU events are freed and reserve_ds_buffers()
> is called again.
>
> Thus aligning with init_hw_perf_events(), use early_initcall() to hook
> bts_init() to ensure x86_pmu.bts is initialized before nmi watchdog
> initialization.
>
> Fixes: d971342d38bf ("perf/x86/intel: Decouple BTS initialization from PEBS initialization")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/bts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 9560f693fac0..f0d9729ed255 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -642,4 +642,4 @@ static __init int bts_init(void)
>  
>  	return perf_pmu_register(&bts_pmu, "intel_bts", -1);
>  }
> -arch_initcall(bts_init);
> +early_initcall(bts_init);
>
> base-commit: e7d952cc39fca34386ec9f15f68cb2eaac01b5ae
