Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC9329E6C;
	Thu, 26 Mar 2026 22:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562551; cv=none; b=tMjDM1h3T1mT5lOJEk6UXBsdh6bz642BwLymkl3H0+RHDBO8erVd6E8wjcJ/3hYfh3vprxSATXzGQl0q+2Jtz/cr+N5kFjVB2UPggfBjNReOMoJINr1mrCvqSKQ72PDOrPgdVOthCfWpyE4JA/8ZBgIlnucmyRDpavxLx53vVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562551; c=relaxed/simple;
	bh=gRNPoUuUlFMlvvoA/CvHNeMEwTUtTfTmqdQjTNdqDmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RizyAZjgLUIGii02q5H1qnRssg0HTSTBkg364kDvod3TmyBtVgyUnzFDEOV8eXGBXk6vsZkpi6S92OtDEdh0hPZBIP71fX5SI8WReA6M/NX3CRDVRaiYcEmLLjXXp2RUfflH2m/43LrkkLZtTCVLD9wLlH42H0C3+R5AfdQmjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCu6v8UI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCu6v8UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41994C116C6;
	Thu, 26 Mar 2026 22:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774562551;
	bh=gRNPoUuUlFMlvvoA/CvHNeMEwTUtTfTmqdQjTNdqDmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCu6v8UItvowi6ElrWpUinjpm4Vo8MXTt0j9qziqHf3voTYp72CBhvnqwlMpICMpj
	 gsRyJRclcEAaKxij0RUByESwEo+kpSHvCC+K52if2WOaYPldUEXXLxPRcKt6WG8/dD
	 DYZMDnggi2W/HqV0n60gtd1mJ+UZj7/EDdipcXh6sT2mYJq+GHNfadn7f+ZO27M0lU
	 a8E8tKyoQKqC1yjMOwncCcidxhN8n9Ggiz9g6s5JwzrSkJkZZWrtU0+4Kf1q+nsnqm
	 3vXbX0nzByJHPo07Sag1mUYjPZU7pWy1TQ8772CxsCoMEZvpVxvqgx3XLasZtP2R9X
	 ux/yDVLBAZMjQ==
Date: Thu, 26 Mar 2026 15:02:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v2 2/2] perf stat: Fix opt->value type for
 parse_cache_level
Message-ID: <acWs9Vrj4AA4YypB@google.com>
References: <20260319221215.207951-1-irogers@google.com>
 <20260319233349.306012-1-irogers@google.com>
 <20260319233349.306012-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319233349.306012-2-irogers@google.com>

On Thu, Mar 19, 2026 at 04:33:49PM -0700, Ian Rogers wrote:
> Commit f5803651b4a4 ("perf stat: Choose the most disaggregate command
> line option") changed aggregation option handling for `perf stat` but
> not `perf stat report` leading to parse_cache_level being passed a
> struct in the `perf stat` case but erroneously an aggr_mode enum value
> for `perf stat report`. Change the `perf stat report` aggregation
> handling to use the same opt_aggr_mode as `perf stat`. Also, just pass
> the boolean for consistency with other boolean argument handling.
> 
> Fixes: f5803651b4a4 ("perf stat: Choose the most disaggregate command line option")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Add in fixes suggested by Sashiko.
> ---
>  tools/perf/builtin-stat.c | 43 +++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 73c2ba7e3076..02c1c02d4b27 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -164,7 +164,7 @@ struct opt_aggr_mode {
>  };
>  
>  /* Turn command line option into most generic aggregation mode setting. */
> -static enum aggr_mode opt_aggr_mode_to_aggr_mode(struct opt_aggr_mode *opt_mode)
> +static enum aggr_mode opt_aggr_mode_to_aggr_mode(const struct opt_aggr_mode *opt_mode)
>  {
>  	enum aggr_mode mode = AGGR_GLOBAL;
>  
> @@ -1219,8 +1219,8 @@ static int parse_cache_level(const struct option *opt,
>  			     int unset __maybe_unused)
>  {
>  	int level;
> -	struct opt_aggr_mode *opt_aggr_mode = (struct opt_aggr_mode *)opt->value;
> -	u32 *aggr_level = (u32 *)opt->data;
> +	bool *per_cache = opt->value;
> +	u32 *aggr_level = opt->data;
>  
>  	/*
>  	 * If no string is specified, aggregate based on the topology of
> @@ -1258,7 +1258,7 @@ static int parse_cache_level(const struct option *opt,
>  		return -EINVAL;
>  	}
>  out:
> -	opt_aggr_mode->cache = true;
> +	*per_cache = true;
>  	*aggr_level = level;
>  	return 0;
>  }
> @@ -2305,24 +2305,23 @@ static struct perf_stat perf_stat = {
>  static int __cmd_report(int argc, const char **argv)
>  {
>  	struct perf_session *session;
> +	struct opt_aggr_mode opt_mode = {};
>  	const struct option options[] = {
>  	OPT_STRING('i', "input", &input_name, "file", "input file name"),
> -	OPT_SET_UINT(0, "per-socket", &perf_stat.aggr_mode,
> -		     "aggregate counts per processor socket", AGGR_SOCKET),
> -	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
> -		     "aggregate counts per processor die", AGGR_DIE),
> -	OPT_SET_UINT(0, "per-cluster", &perf_stat.aggr_mode,
> -		     "aggregate counts perf processor cluster", AGGR_CLUSTER),
> -	OPT_CALLBACK_OPTARG(0, "per-cache", &perf_stat.aggr_mode, &perf_stat.aggr_level,
> -			    "cache level",
> -			    "aggregate count at this cache level (Default: LLC)",
> +		OPT_BOOLEAN(0, "per-thread", &opt_mode.thread, "aggregate counts per thread"),

A wrong indentation.  I'll fix this time.


> +	OPT_BOOLEAN(0, "per-socket", &opt_mode.socket,
> +		    "aggregate counts per processor socket"),
> +	OPT_BOOLEAN(0, "per-die", &opt_mode.die, "aggregate counts per processor die"),
> +	OPT_BOOLEAN(0, "per-cluster", &opt_mode.cluster,
> +		    "aggregate counts per processor cluster"),
> +	OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode.cache, &perf_stat.aggr_level,
> +			    "cache level", "aggregate count at this cache level (Default: LLC)",
>  			    parse_cache_level),
> -	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
> -		     "aggregate counts per physical processor core", AGGR_CORE),
> -	OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
> -		     "aggregate counts per numa node", AGGR_NODE),
> -	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
> -		     "disable CPU count aggregation", AGGR_NONE),
> +	OPT_BOOLEAN(0, "per-core", &opt_mode.core,
> +		    "aggregate counts per physical processor core"),
> +	OPT_BOOLEAN(0, "per-node", &opt_mode.node, "aggregate counts per numa node"),
> +	OPT_BOOLEAN('A', "no-aggr", &opt_mode.no_aggr,
> +		    "disable aggregation across CPUs or PMUs"),
>  	OPT_END()
>  	};
>  	struct stat st;
> @@ -2330,6 +2329,10 @@ static int __cmd_report(int argc, const char **argv)
>  
>  	argc = parse_options(argc, argv, options, stat_report_usage, 0);
>  
> +	perf_stat.aggr_mode = opt_aggr_mode_to_aggr_mode(&opt_mode);
> +	if (perf_stat.aggr_mode == AGGR_GLOBAL)
> +		perf_stat.aggr_mode = AGGR_UNSET; /* No option found so leave unset. */

I think it's more intuitive if the function returns AGGR_UNSET if none
of the field was set.  Then we need to change record and stat parts to
set GLOBAL when it's UNSET.  But this could be a separate change.

Thanks,
Namhyung


> +
>  	if (!input_name || !strlen(input_name)) {
>  		if (!fstat(STDIN_FILENO, &st) && S_ISFIFO(st.st_mode))
>  			input_name = "-";
> @@ -2506,7 +2509,7 @@ int cmd_stat(int argc, const char **argv)
>  		OPT_BOOLEAN(0, "per-die", &opt_mode.die, "aggregate counts per processor die"),
>  		OPT_BOOLEAN(0, "per-cluster", &opt_mode.cluster,
>  			"aggregate counts per processor cluster"),
> -		OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode, &stat_config.aggr_level,
> +		OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode.cache, &stat_config.aggr_level,
>  				"cache level", "aggregate count at this cache level (Default: LLC)",
>  				parse_cache_level),
>  		OPT_BOOLEAN(0, "per-core", &opt_mode.core,
> -- 
> 2.53.0.959.g497ff81fa9-goog
> 
