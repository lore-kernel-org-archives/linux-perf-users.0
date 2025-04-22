Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D56228469B;
	Tue, 22 Apr 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331670; cv=none; b=utzapWSOgnJC+MJYCcyGaujx4Ltmt5g1pTmCBz+vrjATDDNRgO6JSs/k1t02PreQQY6cMwxIQtDxIOe/k80FhKzMc1lbEbhhQNgXVMbFlS5jxv6HYvkcLhkzyEykbNdS+gxB0NeG82PpTCzAgUrlpC+9hkfor1VtlZ5KuLPtyI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331670; c=relaxed/simple;
	bh=bqIeIQeh4fLBXqUF5XbW0OIF6SuCLBF7zBYy0ok2Z80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLELRAz6PQ/98VyV0qUPNa4SQrRiY8zC9H1vqD6yRTl5M1So3nPpFYfJ+/3Hsk4mizwPfos4iuRR/pD9PPuYrE9h2vKVFIeDciEXYm5P6hzOMJWuFrwkFdLoF1JoZVCvM6pqNg3NQBTTTRJb34LEZKnRMOcIqakcscRj6FtXFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56BF1152B;
	Tue, 22 Apr 2025 07:21:03 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 485253F66E;
	Tue, 22 Apr 2025 07:21:07 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:21:02 +0100
From: Leo Yan <leo.yan@arm.com>
To: Yabin Cui <yabinc@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] coresight: etm-perf: Add AUX_NON_CONTIGUOUS_PAGES to
 cs_etm PMU
Message-ID: <20250422142102.GI28953@e132581.arm.com>
References: <20250421215818.3800081-1-yabinc@google.com>
 <20250421215818.3800081-3-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421215818.3800081-3-yabinc@google.com>

On Mon, Apr 21, 2025 at 02:58:18PM -0700, Yabin Cui wrote:
> The cs_etm PMU, regardless of the underlying trace sink (ETF, ETR or
> TRBE), doesn't require contiguous pages for its AUX buffer.

Though contiguous pages are not mandatory for TRBE, I would set the
PERF_PMU_CAP_AUX_NO_SG flag for it.  This can potentially benefit
performance.

For non per CPU sinks, it is fine to allocate non-contiguous pages.

Thanks,
Leo

> This patch adds the PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES capability
> to the cs_etm PMU. This allows the kernel to allocate non-contiguous
> pages for the AUX buffer, reducing memory fragmentation when using
> cs_etm.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index f4cccd68e625..c98646eca7f8 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -899,7 +899,8 @@ int __init etm_perf_init(void)
>  	int ret;
>  
>  	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
> -					   PERF_PMU_CAP_ITRACE);
> +					   PERF_PMU_CAP_ITRACE |
> +					   PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES);
>  
>  	etm_pmu.attr_groups		= etm_pmu_attr_groups;
>  	etm_pmu.task_ctx_nr		= perf_sw_context;
> -- 
> 2.49.0.805.g082f7c87e0-goog
> 
> 
