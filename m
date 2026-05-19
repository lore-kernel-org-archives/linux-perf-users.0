Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C410365A0B;
	Tue, 19 May 2026 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229531; cv=none; b=C3m4zNCrn99kCrCQgPE0FabIA4idLz2ocol6UjDep3armMUeXgk7EXWASxOfdPCFnM0v0XpWNrxNjFmI76lwkLJcv/N/uObhFceuIHM2lITzxY9HE8nR0Fsf/sEu3bRxanOM9STHLSrOpRA3aTjzIvuCgqbcOmjK1V4FzB+QMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229531; c=relaxed/simple;
	bh=pq4tjTrzauOiuQEC8CkCWR37RICioBIbLuDJ/+M6K5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpYmX0Q/i/WwCKgrpg4Xqx34moI66KCPRp9yR+NoBsS8pFnA96UYI5Q+hdqKcHtv1zrTkA7fJbZNDNrI8rhiEgx9Um49gi+sDeqaX7+ht6fE9mq2RGxGUaM998Q6XQI+Az4VMa5tR4EBVRon0gxBRA0HiOqhFAWIWSfmTIAD/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+BHuPLm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+BHuPLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779229530; x=1810765530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pq4tjTrzauOiuQEC8CkCWR37RICioBIbLuDJ/+M6K5A=;
  b=V+BHuPLmnpiO+JsxH56m3UkbOvb2PV4KKmlHOcC6Mh4kzpPAcfFIroMX
   ESeLA8mqbxtAuNlvjHP6jZ33gz9ITz2eu3g3WLqGa31GWuCFFN2NGLtxo
   FRPwCc3eXo8zDTkBkH7QZlX0Z0+MCbV6OfgsWgA2FfGMkwEe/9XVsbFKk
   p9K6T2vfHJWs/FNv0mAppsL3WtCdz+mg72AkdfFX5TJubL487fD1f47h1
   ZDeNeL24bz6WFWV1rxpqXFDsxd80/kd/TWolbBUEi1tZcPOPMnutK8Vmv
   1DET7R7ETqur97GESLHxuEgSoQiJcMEQ0PsX96PcpAMjQuuU2mcxccn5u
   w==;
X-CSE-ConnectionGUID: AnRnr5uwSma5LXiM+SfFwQ==
X-CSE-MsgGUID: 501DIvx0R5mjx4kotHhqdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="82691482"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82691482"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:25:29 -0700
X-CSE-ConnectionGUID: 1h1ZIXH/ROGJnplpkvnUrA==
X-CSE-MsgGUID: RdGSGC+eRyeDlWr5y4UHIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241741256"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:25:28 -0700
Message-ID: <9bcfb336-00f4-4f26-bca1-fa08d74a6828@intel.com>
Date: Tue, 19 May 2026 17:25:27 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for SPR
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
 <20260515061143.338553-3-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260515061143.338553-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 11:11 PM, Dapeng Mi wrote:
> Update perf hard-coded event constraints and cache_extra_regs[] for
> Sapphire rapids according to the latest SPR perfmon events (v1.39).
> 
> Emerald Rapids (EMR) and Granite Rapids (GNR) share exactly same event
> constraints and extra MSR values with SPR. No extra changes are needed
> for EMR and GNR.
> 
> Please note the change could temporarily impact other platforms which
> share the hard coded data structures, but it would be fixed in
> subsequent patches soon.
This may make bisection difficult. Would it be possible to reorder the
patches to avoid this? For example, moving patch 6/11 ahead of this
patch to avoid impacting Lunar Lake.

> SPR perfmon events:
> https://github.com/intel/perfmon/blob/main/SPR/events/sapphirerapids_core.json
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 1390d1da985b..b3ccc785a4f6 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -356,11 +356,12 @@ static struct extra_reg intel_glc_extra_regs[] __read_mostly = {
>  
>  static struct event_constraint intel_glc_event_constraints[] = {
>  	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
> -	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
> +	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* pseudo INST_RETIRED.ANY */
>  	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
> -	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
> +	FIXED_EVENT_CONSTRAINT(0x0200, 1),	/* pseudo CPU_CLK_UNHALTED.THREAD */
> +	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* pseudo CPU_CLK_UNHALTED.REF_TSC */
>  	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
> -	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
> +	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* pseudo TOPDOWN.SLOTS */
>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
> @@ -380,9 +381,13 @@ static struct event_constraint intel_glc_event_constraints[] = {
>  
>  	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
>  	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
> +	INTEL_UEVENT_CONSTRAINT(0x05a3, 0xf),
> +	INTEL_UEVENT_CONSTRAINT(0x06a3, 0xf),
>  	INTEL_UEVENT_CONSTRAINT(0x08a3, 0xf),
> +	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0xf),
>  	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
>  	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
> +	INTEL_UEVENT_CONSTRAINT(0x01cd, 0xfe),
>  	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x1),
>  	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
>  	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
> @@ -714,18 +719,18 @@ static __initconst const u64 glc_hw_cache_extra_regs
>  {
>   [ C(LL  ) ] = {
>  	[ C(OP_READ) ] = {
> -		[ C(RESULT_ACCESS) ] = 0x10001,
> -		[ C(RESULT_MISS)   ] = 0x3fbfc00001,
> +		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
> +		[ C(RESULT_MISS)   ] = 0x3fbfc00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
>  	},
>  	[ C(OP_WRITE) ] = {
> -		[ C(RESULT_ACCESS) ] = 0x3f3ffc0002,
> -		[ C(RESULT_MISS)   ] = 0x3f3fc00002,
> +		[ C(RESULT_ACCESS) ] = 0x3f3ffc0002,	/* OCR.DEMAND_RFO.ANY_RESPONSE */
> +		[ C(RESULT_MISS)   ] = 0x3f3fc00002,	/* OCR.DEMAND_RFO.L3_MISS */
>  	},
>   },
>   [ C(NODE) ] = {
>  	[ C(OP_READ) ] = {
> -		[ C(RESULT_ACCESS) ] = 0x10c000001,
> -		[ C(RESULT_MISS)   ] = 0x3fb3000001,
> +		[ C(RESULT_ACCESS) ] = 0x104000001,	/* OCR.DEMAND_DATA_RD.LOCAL_DRAM */
> +		[ C(RESULT_MISS)   ] = 0x730000001,	/* OCR.DEMAND_DATA_RD.REMOTE_DRAM */
>  	},
>   },
>  };

