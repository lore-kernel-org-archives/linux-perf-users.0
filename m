Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0154332601;
	Fri, 10 Apr 2026 04:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796199; cv=none; b=WurlAiCYeEOFGwhSsz7vCsoM5UPlCkxoyD/wbtS+u22fCKBtyTw/hlE9ZY9y4EkaYvHCLDMAcYayinCU2YNMRIiQnNK6jGwy01PGIUhYqdkV9JJLd/zMzjYBUj20NJh/+/7zNLcgKPpkvTjm+ZNWKA/S11f9Fv7mOS0koWBYmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796199; c=relaxed/simple;
	bh=hAJRnbBuxe+0OzAgSiPCaISGPn0d8MqKB4sPsAz9U8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6u8ewZiEuvPRWuTrsq1WCuWIeKxJXgd+wJFafD4xz/Zbuqj/82ljy+8b+erWGOvk1XMAl6DP2LbFax+P8MPwMhqSAojjbjE8bv4ABVol+Ow3am29jwEuIeYghM2XR/qHgyn/SqudxKjfYIOtgyM2Th5zcOmFF4BUIyhI88Kcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfMZb+KG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfMZb+KG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2D9C2BC9E;
	Fri, 10 Apr 2026 04:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775796199;
	bh=hAJRnbBuxe+0OzAgSiPCaISGPn0d8MqKB4sPsAz9U8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfMZb+KGosp3G2jcEb3ihrT3Gbh20vSu8rwYP/JWzkWBkR3qcxrYGwsRDjgOZRcdC
	 KlyzxkrfFjN6W0r5COxp6P45Dw7jKaYAmW8z64r0GEOUgQj4QtX58cMhRGzKHkxkH8
	 PIbTyGDIq/FaupfRNcYbi/gPLE2c0+HQMKoDPBBAU1Mlzxh2ZDbkseFt3oy4A8W7EK
	 5k8TCSOzInM3tx5RSFJb200Vw2tM24pnVzQz3hB+gZKSormweT5Fk5eaw/P4IKfQtP
	 v/5cFz+iPZApIuUj/CdPXDzf+uioVuB4uX0bfQ57GQXFPFiwX6Lie3uygRpFk9hD0d
	 ROglcL5RGubUw==
Date: Thu, 9 Apr 2026 21:43:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Ian Rogers <irogers@google.com>, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/2] perf pmu intel: Adjust cpumaks for sub-NUMA
 clusters on Emeraldrapids
Message-ID: <adh_5WvH10yQrIRw@google.com>
References: <20260407203918.3178481-1-ctshao@google.com>
 <20260407203918.3178481-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407203918.3178481-2-ctshao@google.com>

On Tue, Apr 07, 2026 at 01:38:43PM -0700, Chun-Tse Shao wrote:
> Similar to GNR [1], Emeraldrapids supports sub-NUMA clusters as well.
> Adjust cpumasks as the logic for GNR in [1].
> 
> Tested on Emeraldrapids with SNC2 enabled:
>   $ perf stat --per-node -e 'UNC_CHA_CLOCKTICKS,UNC_M_CLOCKTICKS' -a -- sleep 1
> 
>    Performance counter stats for 'system wide':
> 
>   N0       30        72125876670      UNC_CHA_CLOCKTICKS
>   N0        4         8815163648      UNC_M_CLOCKTICKS
>   N1       30        72124958844      UNC_CHA_CLOCKTICKS
>   N1        4         8815014974      UNC_M_CLOCKTICKS
>   N2       30        72121049022      UNC_CHA_CLOCKTICKS
>   N2        4         8814592626      UNC_M_CLOCKTICKS
>   N3       30        72117133854      UNC_CHA_CLOCKTICKS
>   N3        4         8814012840      UNC_M_CLOCKTICKS
> 
>          1.001574118 seconds time elapsed
> 
> [1] lore.kernel.org/20250515181417.491401-1-irogers@google.com
> 
> Reviewed-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/arch/x86/util/pmu.c | 56 +++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 938be36ec0f7..3743f5145505 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -30,8 +30,9 @@ static bool x86__is_snc_supported(void)
>  
>  	if (!checked_if_snc_supported) {
>  
> -		/* Graniterapids supports SNC configuration. */
> +		/* Emeraldrapids Graniterapids support SNC configuration. */
>  		static const char *const supported_cpuids[] = {
> +			"GenuineIntel-6-CF", /* Emeraldrapids */
>  			"GenuineIntel-6-A[DE]", /* Graniterapids */

It'd be great if we can share these string literals..


>  		};
>  		char *cpuid = get_cpuid_str((struct perf_cpu){0});
> @@ -141,23 +142,42 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  	// Compute the IMC SNC using lookup tables.
>  	unsigned int imc_num;
>  	int snc_nodes = snc_nodes_per_l3_cache();
> -	const u8 snc2_map[] = {1, 1, 0, 0};
> -	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
> -	const u8 *snc_map;
> -	size_t snc_map_len;
> -
> -	switch (snc_nodes) {
> -	case 2:
> -		snc_map = snc2_map;
> -		snc_map_len = ARRAY_SIZE(snc2_map);
> -		break;
> -	case 3:
> -		snc_map = snc3_map;
> -		snc_map_len = ARRAY_SIZE(snc3_map);
> -		break;
> -	default:
> -		/* Error or no lookup support for SNC with >3 nodes. */
> -		return 0;
> +	char *cpuid;
> +	static const u8 emr_snc2_map[] = { 0, 0, 1, 1 };
> +	static const u8 gnr_snc2_map[] = { 1, 1, 0, 0 };
> +	static const u8 snc3_map[] = { 1, 1, 0, 0, 2, 2 };
> +	static const u8 *snc_map;
> +	static size_t snc_map_len;
> +
> +	/* snc_map is not inited yet. We only look up once to avoid expensive operations. */
> +	if (!snc_map) {
> +		switch (snc_nodes) {
> +		case 2:
> +			cpuid = get_cpuid_str((struct perf_cpu){ 0 });
> +			if (cpuid) {
> +				if (strcmp_cpuid_str("GenuineIntel-6-CF", cpuid) == 0) {
> +					snc_map = emr_snc2_map;
> +					snc_map_len = ARRAY_SIZE(emr_snc2_map);
> +				} else if (strcmp_cpuid_str("GenuineIntel-6-A[DE]", cpuid) == 0) {
> +					snc_map = gnr_snc2_map;
> +					snc_map_len = ARRAY_SIZE(gnr_snc2_map);

... in here as well.

Thanks,
Namhyung


> +				}
> +				free(cpuid);
> +			}
> +			break;
> +		case 3:
> +			snc_map = snc3_map;
> +			snc_map_len = ARRAY_SIZE(snc3_map);
> +			break;
> +		default:
> +			/* Error or no lookup support for SNC with >3 nodes. */
> +			return 0;
> +		}
> +
> +		if (!snc_map) {
> +			pr_warning("Unexpected: can not find snc map config");
> +			return 0;
> +		}
>  	}
>  
>  	/* Compute SNC for PMU. */
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
