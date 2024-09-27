Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C322E630;
	Fri, 27 Sep 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727417677; cv=none; b=IW7v/yCSvF5SYQXc8FooIkNmkBUi0wT/4Y7GeqGG+edXY9ZYFgyiZlhRGQEhhjMWFqmf6DAYv7iunlWkoQzgWda0C4/jToWMvVpwtx5SI/aevlCcdvbHwa1geUgHE5VB0wnpJnt1cwVVCWOKMHJVYUOxpIWfK4BGP+43vJoTTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727417677; c=relaxed/simple;
	bh=dFnWqptwa4g51o3f5qA3cLBhc9QW7+s/c66VdIOj98s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuP6MCqLA9Uw/jTv+EIXtUVEAlmXZ0AfgBxoJgzuHu4bJHhHfTGjbOYYjhSodHaXl8+2O30s3/wO+W3TANmPKkxutNjgnwPTohzVqnQwOx+Q5ubfiJoBUBsuy18E6A0gPfFQkZaBKXV7sUxo6ubJ6ePlCyjXAoZw0q7hkd4SRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/Fjykn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/Fjykn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20846C4CEC4;
	Fri, 27 Sep 2024 06:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727417676;
	bh=dFnWqptwa4g51o3f5qA3cLBhc9QW7+s/c66VdIOj98s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A/Fjykn3UAi3C2DfhaZB4g8EJs4SH6mChYov00It07qrs0zaQn+5KggFJpw0b5YTk
	 gMyAbCT3fCR+5LvM2QrL/k6Oz75sB40QBsDuAz8lpbA8/V55Se1+Kgd/NWA8WJDDk1
	 usbsDMp+Bh0DaritjtVoAt5vepO9Zmd7iPAacQum2YFre74hH/7P61Tu5xgfG2ygG1
	 GqGVWY2TzZ0HThoO9awfBHcgZQ57mbuXTCzELcqYZaW559JRjQFEhhdQMsWDy/3dX2
	 2q1xZ1aBkmBXaP/TRSMj/pY4JWJkZgfxThZf55yy4KtAg2bA8xRQSW+XVR3msLc/rg
	 l1SYyfC/yqnnw==
Date: Thu, 26 Sep 2024 23:14:34 -0700
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
Subject: Re: [PATCH v2 2/5] perf arm-spe: Calculate meta data size
Message-ID: <ZvZNSr51YgWvc6tu@google.com>
References: <20240914215458.751802-1-leo.yan@arm.com>
 <20240914215458.751802-3-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914215458.751802-3-leo.yan@arm.com>

On Sat, Sep 14, 2024 at 10:54:55PM +0100, Leo Yan wrote:
> The metadata is designed to contain a header and per CPU information.
> 
> The arm_spe_find_cpus() function is introduced to identify how many CPUs
> support ARM SPE. Based on the CPU number, calculates the metadata size.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/arch/arm64/util/arm-spe.c | 35 +++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index c2d5c8ca4900..15478989ef30 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -37,11 +37,40 @@ struct arm_spe_recording {
>  	bool			*wrapped;
>  };
>  
> +static struct perf_cpu_map *arm_spe_find_cpus(struct evlist *evlist)

Please add a comment that it returns a new cpu map, and caller should
release the reference after use.

> +{
> +	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
> +	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
> +	struct perf_cpu_map *intersect_cpus;
> +
> +	/* cpu map is not "any" CPU , we have specific CPUs to work with */
> +	if (!perf_cpu_map__has_any_cpu(event_cpus)) {
> +		intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
> +		perf_cpu_map__put(online_cpus);
> +	/* Event can be "any" CPU so count all CPUs. */
> +	} else {
> +		intersect_cpus = online_cpus;
> +	}
> +
> +	return intersect_cpus;
> +}
> +
>  static size_t
>  arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> -		       struct evlist *evlist __maybe_unused)
> +		       struct evlist *evlist)
>  {
> -	return ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
> +	struct perf_cpu_map *cpu_map = arm_spe_find_cpus(evlist);
> +	size_t size;
> +
> +	if (!cpu_map)
> +		return 0;
> +
> +	size = ARM_SPE_AUXTRACE_PRIV_MAX +
> +	       ARM_SPE_CPU_PRIV_MAX * perf_cpu_map__nr(cpu_map);
> +	size *= sizeof(u64);
> +
> +	perf_cpu_map__put(cpu_map);
> +	return size;
>  }
>  
>  static int arm_spe_info_fill(struct auxtrace_record *itr,
> @@ -53,7 +82,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
>  			container_of(itr, struct arm_spe_recording, itr);
>  	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
>  
> -	if (priv_size != ARM_SPE_AUXTRACE_V1_PRIV_SIZE)
> +	if (priv_size != arm_spe_info_priv_size(itr, session->evlist))
>  		return -EINVAL;
>  
>  	if (!session->evlist->core.nr_mmaps)
> -- 
> 2.34.1
> 
