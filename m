Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F017557C;
	Fri, 27 Sep 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727418764; cv=none; b=LyRdXvD5mkAJj+d/mH2QFsQHLOYjN+NmIwkMrwIsGXSN3ysG2q+Xd3+kHgD2U6ROyMepa2xUAQTlLGXBtblC71GqeexGCGVcMYEkBIFzmsJb6UCMWRogY1mEm4VTgWQHaQ+qMPlP8x3WUYVKJNEGC5s08IzRkHcmzBmmLxeVV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727418764; c=relaxed/simple;
	bh=pOdpKSFFX2DeTzjK8oSk8ZcZgBPu7DfNa+BPtyH4q6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOiyA1q2IrqITHd8FOwg/x260HTSsQ1EYZe3fj0ycpe3qaYQeNtO7Mzc2trockQQio2Hp0sk9HOoWovlAmc683tpHCWUBqy4/xUXQbml2HmDwA1TqXMS5vO7OnTKVxG1MjG4icvJN5oQxbYp1g1+ZcmRNbnbTDmEm0Lhioh4qdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF003AU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF003AU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1069BC4CEC4;
	Fri, 27 Sep 2024 06:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727418763;
	bh=pOdpKSFFX2DeTzjK8oSk8ZcZgBPu7DfNa+BPtyH4q6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LF003AU2xt3Op4738uhhsEoyysYHu3Yx7v9vox2lDOemKKT825bEhADmosvpRO2mY
	 BWbFskRjpE0lAPbTpKfqcdtX/Gws3LFMWyZ90aaux/tkmD/XeuJ0etrt8TUr8QwrOX
	 vNGYGkdlcrP1m+ujAMefXswmkrMzgPsoF4tGvPdWTpMtURuB23vpXgzO03lbmTjPUT
	 ZItZ2aGceKgkn8zRI8WhHUlWspDtU1MKuf6DpZvgDFLC8V99JhiOBvOysKz3KVpfy2
	 PLEIYdOmxAGTda4GNlOFIabiCWI4I0aWvSMZgH/lwKVXjAc2DE8QLnZqF9Ke77FtRP
	 93lxNw1n8bnuw==
Date: Thu, 26 Sep 2024 23:32:41 -0700
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
Subject: Re: [PATCH v2 1/5] perf arm-spe: Define metadata header version 2
Message-ID: <ZvZRiTYrTOdXUVUk@google.com>
References: <20240914215458.751802-1-leo.yan@arm.com>
 <20240914215458.751802-2-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914215458.751802-2-leo.yan@arm.com>

On Sat, Sep 14, 2024 at 10:54:54PM +0100, Leo Yan wrote:
> The first version's metadata header structure doesn't include a field to
> indicate a header version, which is not friendly for extension.
> 
> Define the metadata version 2 format with a new header structure and
> extend per CPU's metadata. In the meantime, the old metadata header will
> still be supported for backward compatibility.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/arch/arm64/util/arm-spe.c |  4 +--
>  tools/perf/util/arm-spe.c            |  2 +-
>  tools/perf/util/arm-spe.h            | 38 +++++++++++++++++++++++++++-
>  3 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 2be99fdf997d..c2d5c8ca4900 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -41,7 +41,7 @@ static size_t
>  arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
>  		       struct evlist *evlist __maybe_unused)
>  {
> -	return ARM_SPE_AUXTRACE_PRIV_SIZE;
> +	return ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
>  }
>  
>  static int arm_spe_info_fill(struct auxtrace_record *itr,
> @@ -53,7 +53,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
>  			container_of(itr, struct arm_spe_recording, itr);
>  	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
>  
> -	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
> +	if (priv_size != ARM_SPE_AUXTRACE_V1_PRIV_SIZE)
>  		return -EINVAL;
>  
>  	if (!session->evlist->core.nr_mmaps)
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 138ffc71b32d..70989b1bae47 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1262,7 +1262,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session)
>  {
>  	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
> -	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
> +	size_t min_sz = ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
>  	struct perf_record_time_conv *tc = &session->time_conv;
>  	const char *cpuid = perf_env__cpuid(session->evlist->env);
>  	u64 midr = strtol(cpuid, NULL, 16);
> diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
> index 4f4900c18f3e..5416d4e1d15f 100644
> --- a/tools/perf/util/arm-spe.h
> +++ b/tools/perf/util/arm-spe.h
> @@ -12,10 +12,46 @@
>  enum {
>  	ARM_SPE_PMU_TYPE,
>  	ARM_SPE_PER_CPU_MMAPS,
> +	ARM_SPE_AUXTRACE_V1_PRIV_MAX,
> +};
> +
> +#define ARM_SPE_AUXTRACE_V1_PRIV_SIZE	\
> +	(ARM_SPE_AUXTRACE_V1_PRIV_MAX * sizeof(u64))
> +
> +enum {
> +	/*
> +	 * The old metadata format (defined above) does not include a
> +	 * field for version number. Version 1 is reserved and starts
> +	 * from version 2.
> +	 */
> +	ARM_SPE_HEADER_VERSION,
> +	/* Number of sizeof(u64) */
> +	ARM_SPE_HEADER_SIZE,
> +	/* PMU type shared by CPUs */
> +	ARM_SPE_SHARED_PMU_TYPE,
> +	/* Number of CPUs */
> +	ARM_SPE_CPUS_NUM,
>  	ARM_SPE_AUXTRACE_PRIV_MAX,
>  };

Why don't you define something like struct arm_spe_header_v2 ?

Thanks,
Namhyung

>  
> -#define ARM_SPE_AUXTRACE_PRIV_SIZE (ARM_SPE_AUXTRACE_PRIV_MAX * sizeof(u64))
> +enum {
> +	/* Magic number */
> +	ARM_SPE_MAGIC,
> +	/* CPU logical number in system */
> +	ARM_SPE_CPU,
> +	/* Number of parameters */
> +	ARM_SPE_CPU_NR_PARAMS,
> +	/* CPU MIDR */
> +	ARM_SPE_CPU_MIDR,
> +	/* Associated PMU type */
> +	ARM_SPE_CPU_PMU_TYPE,
> +	/* Minimal interval */
> +	ARM_SPE_CAP_MIN_IVAL,
> +	ARM_SPE_CPU_PRIV_MAX,
> +};
> +
> +#define ARM_SPE_HEADER_CURRENT_VERSION	2
> +
>  
>  union perf_event;
>  struct perf_session;
> -- 
> 2.34.1
> 
