Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58491A6823;
	Thu,  2 Apr 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120132; cv=none; b=IUyQrVGQR8sWQ6UrDVPRMrDiLRw0JH5k7GIs3hcmDa4cyVYBQbQK3alO8PSeL3qs/4bQZxuPv47OM4mbT5PsTFWhU1E/7bRylgGgnWUXmgAkEVmhsPz2yKev+Ojop6tcFenF7NbyC9X1xq9/HvNiX0uXhmGMNnA7St9PHrSTIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120132; c=relaxed/simple;
	bh=HUBoVHsckwO6N4latD6vOejzyFA+Rxg9Tizm48i3nxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERKhF7f0h7X6SzfTpHgTnqsCDLZXmyumnSkplvmcua7fos0WVP07jy5V4Wl/mjnEBw4PkCwu39SwB8/SZrl8PaL9aP3dYcPL2lrGDvN9/tpPZbv8tLzClBam6zzU4evni83tuL7lbq9h37Dc0ilfNBzIjtg9jG96Vmp3oRGduhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TglQgoXh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TglQgoXh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 104361A25;
	Thu,  2 Apr 2026 01:55:23 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40C923F915;
	Thu,  2 Apr 2026 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775120128; bh=HUBoVHsckwO6N4latD6vOejzyFA+Rxg9Tizm48i3nxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TglQgoXhVei8xi7VkJgRQD4LLcnJIghnDPsGsJC3qjDyl8sSRmXf0S5hVfWnxP7UI
	 6ELdDHkz41GsDtQU7zU9SdK8/2/yYQ/cqG7S4MN75MGSlcWEUjHKH0dz/+Di29Sgvl
	 Uj0Rls8WDQLth/VQn87sJiFFiadjJxqvMIJqrb/Q=
Date: Thu, 2 Apr 2026 09:55:26 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] perf arm_spe: Make a function to get the MIDR
Message-ID: <20260402085526.GE356832@e132581.arm.com>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-1-ad0d372c220c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-james-spe-impdef-decode-v1-1-ad0d372c220c@linaro.org>

On Wed, Apr 01, 2026 at 03:25:49PM +0100, James Clark wrote:
> We'll need the MIDR to dump IMPDEF events in the next commits so extract
> a function for it.
> 
> No functional changes intended.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/util/arm-spe.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 70dd9bee47c7..7447b000f9cd 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -958,14 +958,9 @@ static void arm_spe__synth_memory_level(struct arm_spe_queue *speq,
>  	}
>  }
>  
> -static void arm_spe__synth_ds(struct arm_spe_queue *speq,
> -			      const struct arm_spe_record *record,
> -			      union perf_mem_data_src *data_src)
> +static int arm_spe__get_midr(struct arm_spe *spe, int cpu, u64 *midr)
>  {
> -	struct arm_spe *spe = speq->spe;
> -	u64 *metadata = NULL;
> -	u64 midr;
> -	unsigned int i;
> +	u64 *metadata;
>  
>  	/* Metadata version 1 assumes all CPUs are the same (old behavior) */
>  	if (spe->metadata_ver == 1) {
> @@ -973,15 +968,28 @@ static void arm_spe__synth_ds(struct arm_spe_queue *speq,
>  
>  		pr_warning_once("Old SPE metadata, re-record to improve decode accuracy\n");
>  		cpuid = perf_env__cpuid(perf_session__env(spe->session));
> -		midr = strtol(cpuid, NULL, 16);
> -	} else {
> -		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
> -		if (!metadata)
> -			return;
> -
> -		midr = metadata[ARM_SPE_CPU_MIDR];
> +		*midr = strtol(cpuid, NULL, 16);
> +		return 0;
>  	}
>  
> +	metadata = arm_spe__get_metadata_by_cpu(spe, cpu);
> +	if (!metadata)
> +		return -EINVAL;
> +
> +	*midr = metadata[ARM_SPE_CPU_MIDR];
> +	return 0;
> +}
> +
> +static void arm_spe__synth_ds(struct arm_spe_queue *speq,
> +			      const struct arm_spe_record *record,
> +			      union perf_mem_data_src *data_src)
> +{
> +	u64 midr;
> +	unsigned int i;
> +
> +	if (arm_spe__get_midr(speq->spe, speq->cpu, &midr))
> +		return;
> +
>  	for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
>  		if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
>  			return data_source_handles[i].ds_synth(record, data_src);
> 
> -- 
> 2.34.1
> 
> 
