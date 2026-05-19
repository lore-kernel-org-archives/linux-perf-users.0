Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4153ED12F;
	Tue, 19 May 2026 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229196; cv=none; b=Kzmvz+Zz2nzrkas11HyvmQF4U5pe544H0Exfwou2x2YBycZUYxWpFwNaBUZ4nh7EMctU2DTpmEnYAse0SPE/Fg0w4CqHGxaO8FywXkBbKPeNEXgticm3XFK0k7nM10lg5Fh5ooNV0hIZi6gd8P9Lm10338w8PjILJnAzya+5Hho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229196; c=relaxed/simple;
	bh=MTHTNfXukqdTdIga62ItcQgsYMwjkCp6Yncf+Zeivtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjwR+fRKdNvCg+ykS2r1ptgz0ZsRR3ttZpQS/R1K+mg/9s3D0/RGWrKJsAkNMYOIl2eJv7ZNPPVBHcQiqXfPxBdLdLRX/GZrC5VDyqA2jr23KwbEQrSPSN8Ig9uFMot2wjHc000eFm7OFujCeX+KGKRuOyOHP71jIftkFAeHhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4KzMbDn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4KzMbDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779229194; x=1810765194;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MTHTNfXukqdTdIga62ItcQgsYMwjkCp6Yncf+Zeivtk=;
  b=h4KzMbDnTDG1oyh2BXjhUp2ol4ku4FpYsK+eK6okofEo9CVdA6+Xzti3
   H9HOclp+Ou67LSBPH98oYe7N5VFXY2Ek8UPnjTC7i+JnMubd3Od0JZZ+8
   kQsyIeuNUYWkoJcLR0zOJTFVjlRs1kcNAekcsGX3F4Byl+cBiLxHx8QLa
   68ZdcJAPut6HlXcwcgw/NXEacohV387s2k+WQ+OmYZsocn/W/3wtNX4y4
   a2gnSEExdq9a4PeTiKeJxc8PdyeeR+JnssZBbxPHWn6tTTE4iplR7UGHy
   zMTygoQQ2welrrX2g1lLIbrhn9Z6lb/27uhf0NtTwrNhfgSoWEazK2AEY
   g==;
X-CSE-ConnectionGUID: L1jaByc4TcuKOFdy99WMIQ==
X-CSE-MsgGUID: MAGlKdrRSmid89u7zOAkvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="82691157"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="82691157"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:19:53 -0700
X-CSE-ConnectionGUID: a9iwYezwSYCDioxZUGd4Hg==
X-CSE-MsgGUID: v89atLlqStGglHT2Nngdcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241739733"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:19:52 -0700
Message-ID: <487c57bd-da28-4d7c-b983-05734425edd6@intel.com>
Date: Tue, 19 May 2026 17:19:51 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] perf/x86/intel: Update event constraints for DMR
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
 <20260515061143.338553-4-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260515061143.338553-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 11:11 PM, Dapeng Mi wrote:
> Add missed event constraint for 0x0200 event and add comments to show
> the event names in pnc_hw_cache_extra_regs[].
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

Reviewed-by: zide.chen@intel.com


>  arch/x86/events/intel/core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b3ccc785a4f6..0d0edc2d1b90 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -466,11 +466,12 @@ static struct extra_reg intel_lnc_extra_regs[] __read_mostly = {
>  
>  static struct event_constraint intel_pnc_event_constraints[] = {
>  	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
> -	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
> +	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* pseudo INST_RETIRED.ANY */
>  	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
> -	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
> +	FIXED_EVENT_CONSTRAINT(0x0200, 1),      /* pseudo CPU_CLK_UNHALTED.THREAD */
> +	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* pseudo CPU_CLK_UNHALTED.REF_TSC */
>  	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
> -	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
> +	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* pseudo TOPDOWN.SLOTS */
>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
> @@ -821,12 +822,12 @@ static __initconst const u64 pnc_hw_cache_extra_regs
>  {
>   [ C(LL  ) ] = {
>  	[ C(OP_READ) ] = {
> -		[ C(RESULT_ACCESS) ] = 0x4000000000000001,
> -		[ C(RESULT_MISS)   ] = 0xFFFFF000000001,
> +		[ C(RESULT_ACCESS) ] = 0x4000000000000001,	/* OMR.DEMAND_DATA_RD.ANY_RESPONSE */
> +		[ C(RESULT_MISS)   ] = 0xFFFFF000000001,	/* OMR.DEMAND_DATA_RD.L3_MISS */
>  	},
>  	[ C(OP_WRITE) ] = {
> -		[ C(RESULT_ACCESS) ] = 0x4000000000000002,
> -		[ C(RESULT_MISS)   ] = 0xFFFFF000000002,
> +		[ C(RESULT_ACCESS) ] = 0x4000000000000002, 	/* OMR.DEMAND_RFO.ANY_RESPONSE */
> +		[ C(RESULT_MISS)   ] = 0xFFFFF000000002,	/* OMR.DEMAND_RFO.L3_MISS */
>  	},
>   },
>  };

