Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93F03382FC;
	Thu, 30 Apr 2026 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566125; cv=none; b=cmfuUu0qAj6PTSI6SrpLM5oAxJ//xIGMe5mVPaxhjkTlrOkPe2T2KYl8Hojkk9KB+LP3+yUEBaTl098pcPBc6BmA5Z+OTqCBFMgSQjE0RRztCG1xnm1urb2DCSckGiA0BPpHvAYoDFMcX/CphPYf3Ch3N54LZEJ+eyaxfFlGhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566125; c=relaxed/simple;
	bh=LiphD7LGq1XKCCBl4PKS2iC1W6FacpY6EjNllAzXuvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJQ8/85o5YNVswbMGxML4Dqpl4h6OpRW6qmUWiAY42iIlw2VGO2Y7yfGobza+rf7Z4rBxcwcriva7Lf4nvvl2b4KomWSjRhZdooOQKOQ8H2vIC7iIDkdNEEbyhniw7jZIA66F/qjavI/xH6JCXKUzV+3iad5mBYG1jtfWFqmbb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nt+7ZIbg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nt+7ZIbg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777566124; x=1809102124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LiphD7LGq1XKCCBl4PKS2iC1W6FacpY6EjNllAzXuvE=;
  b=nt+7ZIbgbYT+0EfiAnF+9UUQhnJ9kDeFuR3UVAwDJ24kXS74soXWMatv
   yGpnYj3Z0hBunt/MVCECqsLtlGLHhSalNmAwrd9wX0Es+vR739pSp1OhV
   nUPvgK60T4RjKRdqH7GwS4xxJMX71qsq7FbDKlv7L2fvL45/foIgMFYEB
   u+yMhNpxw5WqOxUDWHUsqlqCFPmEaQqhqZkTaLkNxiUNKz8VpLBHkKg2+
   AkPo4OqAAMj4xUiVVxu8TWqbvg++JNhSPwuLrVuPq/YTe+kClhBlxNXpb
   Mic30JEyVWsx1KLinjTrp4FDB1OhuoqAas5ldml1/qhfi+AEIVkPPdlW1
   A==;
X-CSE-ConnectionGUID: PPivg11GR8y77UQzHkvqWw==
X-CSE-MsgGUID: NYm2+WCgRYq22JbPAMzOMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="81101403"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="81101403"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:22:03 -0700
X-CSE-ConnectionGUID: OzQVO5fcQWK6fezr0bi2KQ==
X-CSE-MsgGUID: cCZGBM9lT1WrzqZqyzUHhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="239637032"
Received: from unknown (HELO [10.241.241.75]) ([10.241.241.75])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:22:03 -0700
Message-ID: <b75f8b75-6052-4da3-b1ee-dfa8f5dfd5a6@intel.com>
Date: Thu, 30 Apr 2026 09:22:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] perf/x86: Introduce is_x86_pmu() helper
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
References: <20260316050838.3624051-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260316050838.3624051-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/2026 10:08 PM, Dapeng Mi wrote:
> From: Ian Rogers <irogers@google.com>
> 
> To facilitate the detection of x86 PMU structures in upcoming patches,
> the is_x86_pmu() helper is introduced. Additionally, the is_x86_event()
> helper has been refactored to utilize is_x86_pmu().
> 
> No function changes intended.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

Reviewed-by: Zide Chen <zide.chen@intel.com>



> v2: new patch.
> 
>  arch/x86/events/core.c       | 16 ----------------
>  arch/x86/events/perf_event.h | 18 +++++++++++++++++-
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 810ab21ffd99..66b1a873c395 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -774,22 +774,6 @@ void x86_pmu_enable_all(int added)
>  	}
>  }
>  
> -int is_x86_event(struct perf_event *event)
> -{
> -	/*
> -	 * For a non-hybrid platforms, the type of X86 pmu is
> -	 * always PERF_TYPE_RAW.
> -	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
> -	 * is a unique capability for the X86 PMU.
> -	 * Use them to detect a X86 event.
> -	 */
> -	if (event->pmu->type == PERF_TYPE_RAW ||
> -	    event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
> -		return true;
> -
> -	return false;
> -}
> -
>  struct pmu *x86_get_pmu(unsigned int cpu)
>  {
>  	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..025f67726ecc 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -115,7 +115,23 @@ static inline bool is_topdown_event(struct perf_event *event)
>  	return is_metric_event(event) || is_slots_event(event);
>  }
>  
> -int is_x86_event(struct perf_event *event);
> +static inline bool is_x86_pmu(struct pmu *pmu)
> +{
> +	/*
> +	 * For a non-hybrid platforms, the type of X86 pmu is
> +	 * always PERF_TYPE_RAW.
> +	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
> +	 * is a unique capability for the X86 PMU.
> +	 * Use them to detect a X86 event.
> +	 */
> +	return pmu->type == PERF_TYPE_RAW ||
> +	       pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE;
> +}
> +
> +static inline bool is_x86_event(struct perf_event *event)
> +{
> +	return is_x86_pmu(event->pmu);
> +}
>  
>  static inline bool check_leader_group(struct perf_event *leader, int flags)
>  {
> 
> base-commit: becb26c89be3a6448dcd92522894427544d5b091

