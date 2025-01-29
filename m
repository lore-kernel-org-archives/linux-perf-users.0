Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C815672;
	Wed, 29 Jan 2025 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738126983; cv=none; b=j8Hr48BhQxluWd1lVYQHtRGL3ptBa3kbO0dUoZ2b6zWbmS9rKVH5qk8Fg2kXz9/DGj545MM9HY2YOvhfsdbp7Y59NXdJjrsbz+/U33jeqbpa66aQsJrqpJSKwfjf5EUXj6QX4gbL+/ulhTPiry0YLgax26W1Asm6JeW8RW9tQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738126983; c=relaxed/simple;
	bh=SbKKHLYPiE//3PbTJJNXx5sAsvWGgBiRilF4LJcbESY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raoDqrE31V/p38qXsRF+gXSwW7ocV94Fiw58jSgRNDU+Q8xqsprtb/0W4xGRt5wh8SH3rcsd8BQ2DrOGmVv6F13HopZHDtXTmRdnbv8A3cY1cqRhCKhOKYfnzhvhrDwdrjhnCEHS8CYCZgeEKCm0OcvUViYfhmaaZeJN4igjRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkpCRPt8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkpCRPt8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9831C4CED3;
	Wed, 29 Jan 2025 05:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738126983;
	bh=SbKKHLYPiE//3PbTJJNXx5sAsvWGgBiRilF4LJcbESY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkpCRPt8Fi21g5eTpJwM49Pqfl0IyeILbDPovE7KvCblGSfKhoKxmVCEq+uRlmycz
	 FJmtAlIV2QtGrPKfVV3thZsu0fNBBxnDucGAW82UG0v1tN2QsrO18RJjftIP+b8Vpu
	 osKWTxspvVBaIxHSyl9Jsx2Cl7z87Xs5LqGXoqemTqnDmLec2EnoFQRgHu7imZWmD4
	 o35EHtxzoyBs/3R3gSkQ2iPu+s8J45cFYXd5kDUAHJ9sz2J4O+hK/03j5AIS9rtvfU
	 rSzuzVJdh7l+70FMl5PkFO7qnB4bUbjIeJfGxaUsu0XKGwixflBv2mV2oVRYIP3Uzs
	 cT3V+6SsC0zcA==
Date: Tue, 28 Jan 2025 21:03:01 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 6/7] perf report: Add --latency flag
Message-ID: <Z5m2hdR3HZxIdhWR@google.com>
References: <cover.1737971364.git.dvyukov@google.com>
 <70523ae7dd5d5c41d2d954324297d9d2cfad1b1f.1737971364.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70523ae7dd5d5c41d2d954324297d9d2cfad1b1f.1737971364.git.dvyukov@google.com>

On Mon, Jan 27, 2025 at 10:58:53AM +0100, Dmitry Vyukov wrote:
> Add record/report --latency flag that allows to capture and show
> latency-centric profiles rather than the default CPU-consumption-centric
> profiles. For latency profiles record captures context switch events,
> and report shows Latency as the first column.

It'd be nice if you could add a small example output in the commit
message.

> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
[SNIP]
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index bc4c3acfe7552..2b6023de7a53a 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -2622,6 +2622,7 @@ struct hpp_dimension {
>  	const char		*name;
>  	struct perf_hpp_fmt	*fmt;
>  	int			taken;
> +	int			was_taken;
>  };
>  
>  #define DIM(d, n) { .name = n, .fmt = &perf_hpp__format[d], }
> @@ -3513,6 +3514,7 @@ static int __hpp_dimension__add(struct hpp_dimension *hd,
>  		return -1;
>  
>  	hd->taken = 1;
> +	hd->was_taken = 1;
>  	perf_hpp_list__register_sort_field(list, fmt);
>  	return 0;
>  }
> @@ -3547,10 +3549,15 @@ static int __hpp_dimension__add_output(struct perf_hpp_list *list,
>  	return 0;
>  }
>  
> -int hpp_dimension__add_output(unsigned col)
> +int hpp_dimension__add_output(unsigned col, bool implicit)
>  {
> +	struct hpp_dimension *hd;
> +
>  	BUG_ON(col >= PERF_HPP__MAX_INDEX);
> -	return __hpp_dimension__add_output(&perf_hpp_list, &hpp_sort_dimensions[col]);
> +	hd = &hpp_sort_dimensions[col];
> +	if (implicit && !hd->was_taken)
> +		return 0;

I don't understand why you need 'was_taken' field.  Can it use the
'taken' field?


> +	return __hpp_dimension__add_output(&perf_hpp_list, hd);
>  }
>  
>  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> @@ -3809,10 +3816,24 @@ static char *setup_overhead(char *keys)
>  	if (sort__mode == SORT_MODE__DIFF)
>  		return keys;
>  
> -	keys = prefix_if_not_in("overhead", keys);
> -
> -	if (symbol_conf.cumulate_callchain)
> -		keys = prefix_if_not_in("overhead_children", keys);
> +	if (symbol_conf.prefer_latency) {
> +		keys = prefix_if_not_in("overhead", keys);
> +		keys = prefix_if_not_in("latency", keys);
> +		if (symbol_conf.cumulate_callchain) {
> +			keys = prefix_if_not_in("overhead_children", keys);
> +			keys = prefix_if_not_in("latency_children", keys);
> +		}
> +	} else if (!keys || (!strstr(keys, "overhead") &&
> +			!strstr(keys, "latency"))) {
> +		if (symbol_conf.enable_latency)
> +			keys = prefix_if_not_in("latency", keys);
> +		keys = prefix_if_not_in("overhead", keys);
> +		if (symbol_conf.cumulate_callchain) {
> +			if (symbol_conf.enable_latency)
> +				keys = prefix_if_not_in("latency_children", keys);
> +			keys = prefix_if_not_in("overhead_children", keys);
> +		}
> +	}

Do you really need this complexity?  I think it's better to fix the order
of columns in both case.

Thanks,
Namhyung

>  
>  	return keys;
>  }
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 11fb15f914093..180d36a2bea35 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -141,7 +141,7 @@ int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, i
>  
>  bool is_strict_order(const char *order);
>  
> -int hpp_dimension__add_output(unsigned col);
> +int hpp_dimension__add_output(unsigned col, bool implicit);
>  void reset_dimensions(void);
>  int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>  			struct evlist *evlist,
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index c5b2e56127e22..cd9aa82c7d5ad 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -49,7 +49,9 @@ struct symbol_conf {
>  			keep_exited_threads,
>  			annotate_data_member,
>  			annotate_data_sample,
> -			skip_empty;
> +			skip_empty,
> +			enable_latency,
> +			prefer_latency;
>  	const char	*vmlinux_name,
>  			*kallsyms_name,
>  			*source_prefix,
> -- 
> 2.48.1.262.g85cc9f2d1e-goog
> 
