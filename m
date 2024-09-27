Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB12172BB9;
	Fri, 27 Sep 2024 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727418106; cv=none; b=TfUV5PXzls0yNxv76yukImJMTAlhjDSdfhmFzMJH/FLmBnJN+UIv7gPkMBmJjdasXmnc5Bc8TKsB4WDvAiG/hkAuF5oBovYMrgrFrsgCRNfagE5s2b4IFmq/398bMtiMaSpen7di3cHLylXZqlvEfFmjubpv0u+4o74L7Ogua7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727418106; c=relaxed/simple;
	bh=/bXkNrfLPFESTu5Rql8XR2xPChqYbuPX9K486r1Xlbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbkGgvlDlP29IwYn8HjX9JGbUgVbGZO+gUyH/WsBAGLbyw6Wk23cQPzUiWuH0YMwRCx44CQySzlj1UMT9c+/+N92CaDq52TQJFvaYygtGChAfaRxo39KamY/I8yj9sHMEu8WvEfMQ0T+83PWgsL39EOlxzCQKqRcb/tOqCay3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnWSP3lI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnWSP3lI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC3C4CEC4;
	Fri, 27 Sep 2024 06:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727418105;
	bh=/bXkNrfLPFESTu5Rql8XR2xPChqYbuPX9K486r1Xlbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnWSP3lIW0/v2eMCiFy/xOIMzBUoUP4kk6co82o/Ot6G9KPi/s+FBPcDQnxkVJrd+
	 vc4X5NE56DOj3DI/9e14HKd+J/LxVCVbG68ycw+cKgNFDchaq2JexiLsSdEpSqY8Bn
	 fChAkePdu7MYyCpUOXIXJZU8kpA9AjkIDKmadjTKDqHPX6O3USTjSJUhq3JQ273wXP
	 K803AtMBkhasuxw6MgAJjyDB4KVYHR2xmIT6L93kjZpqaMbp0+LeagX1maddbq94HY
	 wSJaYzZaSEgqc3vkR4WtwP8bGyXUIE3R24LkPOr1F7OEdPOFjdCe0vUwb6DaJFSMSx
	 HWr9AMCRIdT/Q==
Date: Thu, 26 Sep 2024 23:21:43 -0700
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
Subject: Re: [PATCH v2 3/5] perf arm-spe: Save per CPU information in metadata
Message-ID: <ZvZO96lj8-aZkuZw@google.com>
References: <20240914215458.751802-1-leo.yan@arm.com>
 <20240914215458.751802-4-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914215458.751802-4-leo.yan@arm.com>

On Sat, Sep 14, 2024 at 10:54:56PM +0100, Leo Yan wrote:
> Save the Arm SPE information on a per-CPU basis. This approach is easier
> in the decoding phase for retrieving metadata based on the CPU number of
> every Arm SPE record.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/arch/arm64/util/arm-spe.c | 71 +++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 15478989ef30..2790a37709a5 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -26,6 +26,8 @@
>  #include "../../../util/arm-spe.h"
>  #include <tools/libc_compat.h> // reallocarray
>  
> +#define ARM_SPE_CPU_MAGIC		0x1010101010101010ULL
> +
>  #define KiB(x) ((x) * 1024)
>  #define MiB(x) ((x) * 1024 * 1024)
>  
> @@ -73,14 +75,66 @@ arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  	return size;
>  }
>  
> +static int arm_spe_save_cpu_header(struct auxtrace_record *itr,
> +				   struct perf_cpu cpu, __u64 data[])
> +{
> +	struct arm_spe_recording *sper =
> +			container_of(itr, struct arm_spe_recording, itr);
> +	struct perf_pmu *pmu = NULL;
> +	struct perf_pmu tmp_pmu;
> +	char cpu_id_str[16];
> +	char *cpuid = NULL;
> +	u64 val;
> +
> +	snprintf(cpu_id_str, sizeof(cpu_id_str), "%d", cpu.cpu);
> +	tmp_pmu.cpus = perf_cpu_map__new(cpu_id_str);
> +	if (!tmp_pmu.cpus)
> +		return -ENOMEM;
> +
> +	/* Read CPU MIDR */
> +	cpuid = perf_pmu__getcpuid(&tmp_pmu);
> +	if (!cpuid)
> +		return -ENOMEM;

You'd better call perf_cpu_map__put() before return.


> +	val = strtol(cpuid, NULL, 16);
> +	perf_cpu_map__put(tmp_pmu.cpus);
> +
> +	data[ARM_SPE_MAGIC] = ARM_SPE_CPU_MAGIC;
> +	data[ARM_SPE_CPU] = cpu.cpu;
> +	data[ARM_SPE_CPU_NR_PARAMS] = ARM_SPE_CPU_PRIV_MAX - ARM_SPE_CPU_MIDR;
> +	data[ARM_SPE_CPU_MIDR] = val;
> +
> +	/* Find the associate Arm SPE PMU for the CPU */
> +	if (perf_cpu_map__has(sper->arm_spe_pmu->cpus, cpu))
> +		pmu = sper->arm_spe_pmu;
> +
> +	if (!pmu) {
> +		/* No Arm SPE PMU is found */
> +		data[ARM_SPE_CPU_PMU_TYPE] = ULLONG_MAX;
> +		data[ARM_SPE_CAP_MIN_IVAL] = 0;
> +	} else {
> +		data[ARM_SPE_CPU_PMU_TYPE] = pmu->type;
> +
> +		if (perf_pmu__scan_file(pmu, "caps/min_interval", "%lu", &val) != 1)
> +			val = 0;
> +		data[ARM_SPE_CAP_MIN_IVAL] = val;
> +	}
> +
> +	return ARM_SPE_CPU_PRIV_MAX;
> +}
> +
>  static int arm_spe_info_fill(struct auxtrace_record *itr,
>  			     struct perf_session *session,
>  			     struct perf_record_auxtrace_info *auxtrace_info,
>  			     size_t priv_size)
>  {
> +	int i, ret;
> +	size_t offset;
>  	struct arm_spe_recording *sper =
>  			container_of(itr, struct arm_spe_recording, itr);
>  	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
> +	struct perf_cpu_map *cpu_map = arm_spe_find_cpus(session->evlist);

Maybe you can move this to later in the function to make the error
handling easier.  Otherwise it should call perf_cpu_map__put().


> +	struct perf_cpu cpu;
> +	__u64 *data;
>  
>  	if (priv_size != arm_spe_info_priv_size(itr, session->evlist))
>  		return -EINVAL;
> @@ -89,8 +143,23 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
>  		return -EINVAL;
>  
>  	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
> -	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
> +	auxtrace_info->priv[ARM_SPE_HEADER_VERSION] = ARM_SPE_HEADER_CURRENT_VERSION;
> +	auxtrace_info->priv[ARM_SPE_HEADER_SIZE] =
> +		ARM_SPE_AUXTRACE_PRIV_MAX - ARM_SPE_HEADER_VERSION;
> +	auxtrace_info->priv[ARM_SPE_SHARED_PMU_TYPE] = arm_spe_pmu->type;
> +	auxtrace_info->priv[ARM_SPE_CPUS_NUM] = perf_cpu_map__nr(cpu_map);
> +
> +	offset = ARM_SPE_AUXTRACE_PRIV_MAX;
> +	perf_cpu_map__for_each_cpu(cpu, i, cpu_map) {
> +		assert(offset < priv_size);
> +		data = &auxtrace_info->priv[offset];
> +		ret = arm_spe_save_cpu_header(itr, cpu, data);
> +		if (ret < 0)
> +			return ret;

Please break the loop and release the cpu map.

Thanks,
Namhyung


> +		offset += ret;
> +	}
>  
> +	perf_cpu_map__put(cpu_map);
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 
