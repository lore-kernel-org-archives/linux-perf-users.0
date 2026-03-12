Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9031E82D;
	Thu, 12 Mar 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297832; cv=none; b=SedUxxgjF+97ZIVIPFLAGCMLc6uOrv2SKVcERUBemtudJfo1tO4EikVkvDGX+gp3hQY1iA2Kt7ca/2Q2wGBiYL/Do1lspUE3+lDGOZ2WmyMd8Env/y7Or4nxvVUpGmul3oCH4xG//HludYriK7BQnqCqS3046U+2iD+BLUrqyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297832; c=relaxed/simple;
	bh=V3JZwP7hCqKlJdk5Pth2VHAcfLFPeTR6k/wW/UGj8kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4bxptrrrAhE6tq3iYXihjGmlzgPjzd8K9dEEUOrv78LrJwPX5jxpQFcEwn53kdfx3kzLQcFvnY5UHm+BvLd0z1WhvMb5pms6sPpl+6k/J53FSDjqpWYBDdcxysVQ5SfJAXj3F/RtGyBulhycIlGbdDtZoRtM5asrVl9zim+16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mH2AdKSE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mH2AdKSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773297831; x=1804833831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V3JZwP7hCqKlJdk5Pth2VHAcfLFPeTR6k/wW/UGj8kI=;
  b=mH2AdKSE+2PRqwdjO8DwmFD45zpVk9x/ruotlUDD2CGWne0mh96zv3dO
   AU9tAlLATlgTaG2niNYHNRbMusb2iK2oUfF1Ute/2sMbrwXkFaAQvSTgi
   q2WavvRHyGAK4t5yxRGcybxrtKcZG+46HxSo2W4fsaQN3QvlaRPJ+wjeP
   WjipiVymzhGOGw/rj3NqfirQqaczZ8pgO8quaOcbVyggMBaqxVWNe++FE
   h02LNh4w7397BvYSBDPC/aKD7n4YK+/mB5M28giX2tuvzJoPJtH0ESMuX
   oZtrqG9NJP5OQe0K6fT5u51XlhAndrsZFzyqjy10To4vxSARpnGgRykCa
   Q==;
X-CSE-ConnectionGUID: rsdDL/qRTBew2+TlCrhYBQ==
X-CSE-MsgGUID: +u3cmqWLROS3J/LI2HNDNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85856386"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="85856386"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:43:50 -0700
X-CSE-ConnectionGUID: B6//lyLbTHma3NYdhAS9oA==
X-CSE-MsgGUID: hAXE/atISdm7W8cs2ysJlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; 
   d="scan'208";a="225685541"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 23:43:47 -0700
Message-ID: <a61eae6d-7a6d-40bd-83ec-bd4ea7657b9d@linux.intel.com>
Date: Thu, 12 Mar 2026 14:43:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf/x86: Avoid inadvertent casts to
 x86_hybrid_pmu
To: Ian Rogers <irogers@google.com>, dapeng1.mi@intel.com
Cc: acme@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
 alexander.shishkin@linux.intel.com, eranian@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
 thomas.falcon@intel.com, xudong.hao@intel.com, zide.chen@intel.com
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260312054810.1571020-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/12/2026 1:48 PM, Ian Rogers wrote:
> The patch:
> https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux.intel.com/
> showed it was pretty easy to accidentally cast non-x86 PMUs to
> x86_hybrid_pmus. Add a BUG_ON for that case. Restructure is_x86_event
> and add an is_x86_pmu to facilitate this.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Only build tested.
> ---
>  arch/x86/events/core.c       | 16 ----------------
>  arch/x86/events/perf_event.h | 19 ++++++++++++++++++-
>  2 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 03ce1bc7ef2e..6c6567dc6c88 100644
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
> index fad87d3c8b2c..f1123c95d174 100644
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
> +	      (pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE);
> +}
> +
> +static inline bool is_x86_event(struct perf_event *event)
> +{
> +	return is_x86_pmu(event->pmu);
> +}
>  
>  static inline bool check_leader_group(struct perf_event *leader, int flags)
>  {
> @@ -779,6 +795,7 @@ struct x86_hybrid_pmu {
>  
>  static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
>  {
> +	BUG_ON(!is_x86_pmu(pmu));
>  	return container_of(pmu, struct x86_hybrid_pmu, pmu);
>  }
>  

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


