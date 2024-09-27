Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F715D5C1;
	Fri, 27 Sep 2024 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727418950; cv=none; b=nayKxkU/P32aWiHjJxGdv6RkmLOWuporKf8NevOL2lS907HNR+46nDeXAKnG/wIdm3/GmDAI9HYksOJcVQ1C/b4P6Gy1Xr8ifitQ5WtM+v32Q5ESvobWFHUTrsFrZDTedsEK+yk19XVtoI1NYQCeqr0q5F9erNl74ef7kVpmNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727418950; c=relaxed/simple;
	bh=dHncd2eLjwHvu2QwgdvMZB1HbQlijscjhgYoUwAfAE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/suPnNkdt9pD1zN2U1Rshad5IJFEYNVT1ksMC+E5PWzzkCPoDlHQaiy1XT8RU3TNg7q+EMC1PAAfIgagAim0EXt4yJOhCqOFg1AhgYtTn0M57bZrZP7GLesYlfvP75FVOFuA0AwnSIJgLNBfPKpHV5KmWgWluHclpVIv2ABcek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQMYkyAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQMYkyAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F55C4CEC4;
	Fri, 27 Sep 2024 06:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727418950;
	bh=dHncd2eLjwHvu2QwgdvMZB1HbQlijscjhgYoUwAfAE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQMYkyAA5yUSR0EP/1Z7Twfsf+uFF/Qh1iK2LxKfaRnhHGUoA4kTWVmKU000C9vPF
	 jzpbeyyyw5gVsybEIR3lyjRJ0ciwHweuc2sLAgTnHoRPVvhEUajU96RPR2TTsimd/h
	 7lU1TERAuFXsNQ6U+oMbDIFlvLZT+SH05JAC3OtSYSXRgmTlbNYW07sBpl0rOk4QiH
	 rMfKKaRFrLvKQCx2gftqkRDwczV6P9h2E37/FO5inyrXo8K/ySJSdxyyp97qCjq56X
	 N1wHNO9fvJp/vUT2mLLXvyrVZE0CUwmJdlCAhDlXm3gntpI9oZPZJIT/EWxCNo9ZBs
	 IpHoMCIWETZ3Q==
Date: Thu, 26 Sep 2024 23:35:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] perf arm-spe: Support metadata version 2
Message-ID: <ZvZSRNi_rVnrecPZ@google.com>
References: <20240914215458.751802-1-leo.yan@arm.com>
 <20240914215458.751802-5-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914215458.751802-5-leo.yan@arm.com>

On Sat, Sep 14, 2024 at 10:54:57PM +0100, Leo Yan wrote:
> This commit is to support metadata version 2 and at the meantime it is
> backward compatible for version 1's format.
> 
> The metadata version 1 doesn't include the ARM_SPE_HEADER_VERSION field.
> As version 1 is fixed with two u64 fields, by checking the metadata
> size, it distinguishes the metadata is version 1 or version 2 (and any
> new versions if later will have). For version 2, it reads out CPU number
> and retrieves the metadata info for every CPU.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/arm-spe.c | 95 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 70989b1bae47..17782cb40fb5 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -78,6 +78,10 @@ struct arm_spe {
>  
>  	unsigned long			num_events;
>  	u8				use_ctx_pkt_for_pid;
> +
> +	u64				**metadata;
> +	u64				metadata_ver;
> +	u64				metadata_nr_cpu;
>  };
>  
>  struct arm_spe_queue {
> @@ -1016,6 +1020,73 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
>  	return 0;
>  }
>  
> +static u64 *arm_spe__alloc_per_cpu_metadata(u64 *buf, int cpu_size)
> +{
> +	u64 *metadata;
> +
> +	metadata = zalloc(sizeof(*metadata) * cpu_size);

Maybe calloc() is slightly better here, but not a strong opinion.


> +	if (!metadata)
> +		return NULL;
> +
> +	memcpy(metadata, buf, cpu_size);

I'm not sure if it's correct since you allocated cpu_size * 8 and copies
only cpu_size.


> +	return metadata;
> +}
> +
> +static void arm_spe__free_metadata(u64 **metadata, int nr_cpu)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_cpu; i++)
> +		zfree(&metadata[i]);
> +	free(metadata);
> +}
> +
> +static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
> +				     u64 *ver, int *nr_cpu)
> +{
> +	u64 *ptr = (u64 *)info->priv;
> +	u64 metadata_size;
> +	u64 **metadata = NULL;
> +	int hdr_sz, cpu_sz, i;
> +
> +	metadata_size = info->header.size -
> +		sizeof(struct perf_record_auxtrace_info);
> +
> +	/* Metadata version 1 */
> +	if (metadata_size == ARM_SPE_AUXTRACE_V1_PRIV_SIZE) {
> +		*ver = 1;
> +		*nr_cpu = 0;
> +		/* No per CPU metadata */
> +		return NULL;
> +	}
> +
> +	*ver = ptr[ARM_SPE_HEADER_VERSION];
> +	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
> +	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
> +
> +	metadata = zalloc(sizeof(*metadata) * (*nr_cpu));

calloc() instead?  But probably better defining a struct for metadata.

Thanks,
Namhyung


> +	if (!metadata)
> +		return NULL;
> +
> +	/* Locate the start address of per CPU metadata */
> +	ptr += hdr_sz;
> +	cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
> +
> +	for (i = 0; i < *nr_cpu; i++) {
> +		metadata[i] = arm_spe__alloc_per_cpu_metadata(ptr, cpu_sz);
> +		if (!metadata[i])
> +			goto err_per_cpu_metadata;
> +
> +		ptr += cpu_sz / sizeof(u64);
> +	}
> +
> +	return metadata;
> +
> +err_per_cpu_metadata:
> +	arm_spe__free_metadata(metadata, *nr_cpu);
> +	return NULL;
> +}
> +
>  static void arm_spe_free_queue(void *priv)
>  {
>  	struct arm_spe_queue *speq = priv;
> @@ -1050,6 +1121,7 @@ static void arm_spe_free(struct perf_session *session)
>  	auxtrace_heap__free(&spe->heap);
>  	arm_spe_free_events(session);
>  	session->auxtrace = NULL;
> +	arm_spe__free_metadata(spe->metadata, spe->metadata_nr_cpu);
>  	free(spe);
>  }
>  
> @@ -1267,15 +1339,24 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	const char *cpuid = perf_env__cpuid(session->evlist->env);
>  	u64 midr = strtol(cpuid, NULL, 16);
>  	struct arm_spe *spe;
> -	int err;
> +	u64 **metadata = NULL;
> +	u64 metadata_ver;
> +	int nr_cpu, err;
>  
>  	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
>  					min_sz)
>  		return -EINVAL;
>  
> +	metadata = arm_spe__alloc_metadata(auxtrace_info, &metadata_ver,
> +					   &nr_cpu);
> +	if (!metadata && metadata_ver != 1) {
> +		pr_err("Failed to parse Arm SPE metadata.\n");
> +		return -EINVAL;
> +	}
> +
>  	spe = zalloc(sizeof(struct arm_spe));
>  	if (!spe)
> -		return -ENOMEM;
> +		goto err_free_metadata;
>  
>  	err = auxtrace_queues__init(&spe->queues);
>  	if (err)
> @@ -1284,8 +1365,14 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	spe->session = session;
>  	spe->machine = &session->machines.host; /* No kvm support */
>  	spe->auxtrace_type = auxtrace_info->type;
> -	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
> +	if (metadata_ver == 1)
> +		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
> +	else
> +		spe->pmu_type = auxtrace_info->priv[ARM_SPE_SHARED_PMU_TYPE];
>  	spe->midr = midr;
> +	spe->metadata = metadata;
> +	spe->metadata_ver = metadata_ver;
> +	spe->metadata_nr_cpu = nr_cpu;
>  
>  	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
>  
> @@ -1346,5 +1433,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  	session->auxtrace = NULL;
>  err_free:
>  	free(spe);
> +err_free_metadata:
> +	arm_spe__free_metadata(metadata, nr_cpu);
>  	return err;
>  }
> -- 
> 2.34.1
> 
