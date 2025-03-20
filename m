Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348792F28;
	Thu, 20 Mar 2025 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742431020; cv=none; b=m0DAnF4/TfdYWoiVT4ifHcqTRacirTFoZAKu1lZb7bJmmfdv1EJOeTzWdb84Yfjq+S65YbPHA5Ny44W9qOmSNIRKdjR5D5vSfYTht+B7nijGc0EeW9nseGn2AdvqxzN9yTG3H+7nXa6jgxffT68rMWhiHFyzz6rDodciRreDkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742431020; c=relaxed/simple;
	bh=YmwdLxB17tyBbP89p2h7IFyWsr1r6biPOCtAj6c7WYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Asd59HZ0mgm7I3A2AK7lvg9dqR7W/303leMMt6yWM3HSgbcFr7yWpYq+FgqISkyk/tm/y6+TRsf7/tD1amAO+XF323cqkbkJXubjZMR3Mi42tBFji35LT6wfQ2D5hyG9vjh/PhIv8IY73nbeMFoO/G8aUEovg7p1u2wltZfbrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyceVXVm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyceVXVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF1BC4CEE4;
	Thu, 20 Mar 2025 00:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742431019;
	bh=YmwdLxB17tyBbP89p2h7IFyWsr1r6biPOCtAj6c7WYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyceVXVmicIhEkiQaL3P71twrZ6TXeJTQktEc5t5TBEkm5x86VfnW+SZVA/2qTVbP
	 awIozhk2qspphtSvJXhDgs7pryOGT7QTC63fc615+mjJLNabfn2JDGnN5N8zoN50R0
	 C+dSvXGdG24Mbo2tBJ4TKyRWP9zw2lfvT67wqk2cqakDBumsJzYTokR8eMkp/y6Y1N
	 jyo3zfeOJDZ8a1ZnJw2T4fsH4qvVMMhpgY1+GB9dQyDDV7S4+5VEWlqY/gpn08/cLW
	 l/WRFU2EBwvm32XDqtyvO7BpES9+EhyxZyzjlrtch60ikat7yoGkN3C4yLOkrA24kK
	 933uI0QJTSFEA==
Date: Wed, 19 Mar 2025 17:36:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/3] perf sort: Keep output fields in the same level
Message-ID: <Z9tjKcKvjYgbR6hb@google.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307080829.354947-1-namhyung@kernel.org>

On Fri, Mar 07, 2025 at 12:08:27AM -0800, Namhyung Kim wrote:
> This is useful for hierarchy output mode where the first level is
> considered as output fields.  We want them in the same level so that it
> can show only the remaining groups in the hierarchy.
> 
> Before:
>   $ perf report -s overhead,sample,period,comm,dso -H --stdio
>   ...
>   #          Overhead  Samples / Period / Command / Shared Object
>   # .................  ..........................................
>   #
>      100.00%           4035
>         100.00%           3835883066
>            100.00%           perf
>                99.37%           perf
>                 0.50%           ld-linux-x86-64.so.2
>                 0.06%           [unknown]
>                 0.04%           libc.so.6
>                 0.02%           libLLVM-16.so.1
> 
> After:
>   $ perf report -s overhead,sample,period,comm,dso -H --stdio
>   ...
>   #    Overhead       Samples        Period  Command / Shared Object
>   # .......................................  .......................
>   #
>      100.00%          4035    3835883066     perf
>          99.37%          4005    3811826223     perf
>           0.50%            19      19210014     ld-linux-x86-64.so.2
>           0.06%             8       2367089     [unknown]
>           0.04%             2       1720336     libc.so.6
>           0.02%             1        759404     libLLVM-16.so.1
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Ping!  Anybody interested in this change? :)

Thanks,
Namhyung

> ---
>  tools/perf/util/sort.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f08fbc4bf0a2ce29..6b49d64854f5f986 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -3720,6 +3720,34 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>  	return -ESRCH;
>  }
>  
> +/* This should match with sort_dimension__add() above */
> +static bool is_hpp_sort_key(const char *key)
> +{
> +	unsigned i;
> +
> +	for (i = 0; i < ARRAY_SIZE(arch_specific_sort_keys); i++) {
> +		if (!strcmp(arch_specific_sort_keys[i], key) &&
> +		    !arch_support_sort_key(key)) {
> +			return false;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(common_sort_dimensions); i++) {
> +		struct sort_dimension *sd = &common_sort_dimensions[i];
> +
> +		if (sd->name && !strncasecmp(key, sd->name, strlen(key)))
> +			return false;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(hpp_sort_dimensions); i++) {
> +		struct hpp_dimension *hd = &hpp_sort_dimensions[i];
> +
> +		if (!strncasecmp(key, hd->name, strlen(key)))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int setup_sort_list(struct perf_hpp_list *list, char *str,
>  			   struct evlist *evlist)
>  {
> @@ -3727,7 +3755,9 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
>  	int ret = 0;
>  	int level = 0;
>  	int next_level = 1;
> +	int prev_level = 0;
>  	bool in_group = false;
> +	bool prev_was_hpp = false;
>  
>  	do {
>  		tok = str;
> @@ -3748,6 +3778,19 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
>  		}
>  
>  		if (*tok) {
> +			if (is_hpp_sort_key(tok)) {
> +				/* keep output (hpp) sort keys in the same level */
> +				if (prev_was_hpp) {
> +					bool next_same = (level == next_level);
> +
> +					level = prev_level;
> +					next_level = next_same ? level : level+1;
> +				}
> +				prev_was_hpp = true;
> +			} else {
> +				prev_was_hpp = false;
> +			}
> +
>  			ret = sort_dimension__add(list, tok, evlist, level);
>  			if (ret == -EINVAL) {
>  				if (!cacheline_size() && !strncasecmp(tok, "dcacheline", strlen(tok)))
> @@ -3759,6 +3802,7 @@ static int setup_sort_list(struct perf_hpp_list *list, char *str,
>  				ui__error("Unknown --sort key: `%s'", tok);
>  				break;
>  			}
> +			prev_level = level;
>  		}
>  
>  		level = next_level;
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 
