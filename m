Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818363D561;
	Mon,  3 Nov 2025 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202004; cv=none; b=EGW66gDr6IM37fB/SPziiqDi81keC/Z0DbrAS+fsR63/6jSAll6kJ7VH+h070y6c8GBelbE5E3wsYwJFD9YnqSHTXsDgP7YAE1XHTSARbcGmY+PADe0e/Mh9rW00SYk7qv2ev9DnWsivozKwlsntU/lfNJFnstQI74F6Nwy2a3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202004; c=relaxed/simple;
	bh=KFUkblgsEEN8vjzJcuGJbVZaQoZIH0aQ8mp6eqbsoos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+GsK+s0y3r50dJOCrEvxE2JcCpo+Ne/CnpnIq3t3R6lg7MTTNPHVn9xO1m5FJK7wtVOgHZ4DA1ZExOXBjYiaYa25GwrQEiHXD36Al/w10TWUAO/BtJbReFJusS39ts8UHOTARiVkAogtSwFxFb1krYhq3xJr2vp3MIg1GmAhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEfWB4g1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEfWB4g1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8219EC4CEE7;
	Mon,  3 Nov 2025 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762202004;
	bh=KFUkblgsEEN8vjzJcuGJbVZaQoZIH0aQ8mp6eqbsoos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEfWB4g1GdxFAt8hlanFY7fEBht94H5mGkqLwHdxhsLsE2X0yixYFGj0GpmBcyoWd
	 L7z2RcQferEDtJl/EEiGHiFLXzA2w1iFMy8zvcZKZb8I08Q9Hub5F7JMAF2Qma6pj9
	 2l19cmg7+ecolAxCb7+81aubrLESR9IR1fP3TCcYqzW6F9MJMeKVIAezxZYkB/0Vu0
	 MsBkrWlFEsqu2wWhjBvMwyAPfFCBtvCsccaUIxmTbjroOSBkCXTyMwpE9E/VJc6OWu
	 gTURDw3pn5LcsqKwQbaQGeAEM6MmOI98DU/kOkc5zvWtKGMzWjnYG6/zA22JUiAmx/
	 aEli4xMn44xiQ==
Date: Mon, 3 Nov 2025 17:33:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] perf vendor events arm64 AmpereOneX: Fix spelling
 typo in the metrics file
Message-ID: <aQkRkLMYTGLVJAuZ@x1>
References: <20251103014633.1213-1-chuguangqing@inspur.com>
 <20251103014633.1213-2-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103014633.1213-2-chuguangqing@inspur.com>

On Mon, Nov 03, 2025 at 09:46:33AM +0800, Chu Guangqing wrote:
> The json file incorrectly used "acceses" instead of "accesses".

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  .../arch/arm64/ampere/ampereonex/metrics.json    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> index 6817cac149e0..a29aadc9b2e3 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> @@ -388,55 +388,55 @@
>          "MetricExpr": "L1D_CACHE_RW / L1D_CACHE",
>          "BriefDescription": "L1D cache access - demand",
>          "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "l1d_cache_access_prefetches",
>          "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
>          "BriefDescription": "L1D cache access - prefetch",
>          "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "l1d_cache_demand_misses",
>          "MetricExpr": "L1D_CACHE_REFILL_RW / L1D_CACHE",
>          "BriefDescription": "L1D cache demand misses",
>          "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "l1d_cache_demand_misses_read",
>          "MetricExpr": "L1D_CACHE_REFILL_RD / L1D_CACHE",
>          "BriefDescription": "L1D cache demand misses - read",
>          "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "l1d_cache_demand_misses_write",
>          "MetricExpr": "L1D_CACHE_REFILL_WR / L1D_CACHE",
>          "BriefDescription": "L1D cache demand misses - write",
>          "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "l1d_cache_prefetch_misses",
>          "MetricExpr": "L1D_CACHE_REFILL_PRFM / L1D_CACHE",
>          "BriefDescription": "L1D cache prefetch misses",
>          "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "ase_scalar_mix",
>          "MetricExpr": "ASE_SCALAR_SPEC / OP_SPEC",
>          "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) scalar operations",
>          "MetricGroup": "Instructions",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>      },
>      {
>          "MetricName": "ase_vector_mix",
>          "MetricExpr": "ASE_VECTOR_SPEC / OP_SPEC",
>          "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) vector operations",
>          "MetricGroup": "Instructions",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>      }
>  ]
> -- 
> 2.43.7
> 
