Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A686F1420DD;
	Mon, 13 Jan 2025 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783247; cv=none; b=C/RVf5nkg8KEBWobhyB8IVrnL+mgP0ZmykTBz+YP7Mf04Ny4rse0mBKjtn4ZzU3/M0A28HKphMoCTOlJZz3iRhIdMxB/7dZoNDwI6yir9nSivvNINZKV3YYStjPfbFO8OLhEmxIvwrJdwR2CZcfijXtY76ZAdaWIX+5Dcb8rr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783247; c=relaxed/simple;
	bh=oxLzB40VbG925YES8dIbMXGmc0WKPKteapK7aX6jX+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1hPiWFzTIWlA0oCiXvCZxz0pBoh21j2fAG6+3sbtdkHcjgf9oF4swV9QWfli8oGYHp8BvwlE+WqbAESLbqhGXorImjJSINqonKhRYo4FBQsCpOkgZef9LY9AmQGAT4vJ0EQ/zxMUK1ua1U3LLWmmDXManmzbq2JKEf0yVwprhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyGxmVxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyGxmVxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEBDC4CEE2;
	Mon, 13 Jan 2025 15:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783247;
	bh=oxLzB40VbG925YES8dIbMXGmc0WKPKteapK7aX6jX+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyGxmVxpz94K5k++YY8kBePkDQ5vJgLBbxnhjjAtuTXJtFdnMPbHWioD62lfmkPLK
	 0BIwyqqp6H39IT05u5bcEvRhZTokc8Rayv4cVqrWHp74qUri8XZY6gxD9KhzeOwlIX
	 X7juBrtzUnft4ytMMcPyjaWVYIOtt815IUdCBu9UG9KcsX2Tf67ethBcbb+SLaJM49
	 geUcUm1U/X8sTeq05FWHRuHw+6/BglpO9/7d0PkJXMaHRlSVlqPt5rCbAf878WPXNA
	 IalAs+vmTZJZP9ftb6355javM3j9e02Pcr+OMOU5huXh/rvpajshnmawL1acDaUABP
	 CaU5NJ8kuZpng==
Date: Mon, 13 Jan 2025 12:47:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	mhiramat@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf probe: Rename err label
Message-ID: <Z4U1jAlk2Pv1t9Bi@x1>
References: <20241211085525.519458-1-james.clark@linaro.org>
 <20241211085525.519458-3-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085525.519458-3-james.clark@linaro.org>

On Wed, Dec 11, 2024 at 08:55:24AM +0000, James Clark wrote:
> Rename err to out to avoid confusion because buf is still supposed to be
> freed in non error cases.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Tested-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/probe-event.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index eaa0318e9b87..35af6570cf9b 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1383,20 +1383,20 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  		if (p == buf) {
>  			semantic_error("No file/function name in '%s'.\n", p);
>  			err = -EINVAL;
> -			goto err;
> +			goto out;
>  		}
>  		*(p++) = '\0';
>  
>  		err = parse_line_num(&p, &lr->start, "start line");
>  		if (err)
> -			goto err;
> +			goto out;
>  
>  		if (*p == '+' || *p == '-') {
>  			const char c = *(p++);
>  
>  			err = parse_line_num(&p, &lr->end, "end line");
>  			if (err)
> -				goto err;
> +				goto out;
>  
>  			if (c == '+') {
>  				lr->end += lr->start;
> @@ -1416,11 +1416,11 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  		if (lr->start > lr->end) {
>  			semantic_error("Start line must be smaller"
>  				       " than end line.\n");
> -			goto err;
> +			goto out;
>  		}
>  		if (*p != '\0') {
>  			semantic_error("Tailing with invalid str '%s'.\n", p);
> -			goto err;
> +			goto out;
>  		}
>  	}
>  
> @@ -1431,7 +1431,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  			lr->file = strdup_esq(p);
>  			if (lr->file == NULL) {
>  				err = -ENOMEM;
> -				goto err;
> +				goto out;
>  			}
>  		}
>  		if (*buf != '\0')
> @@ -1439,7 +1439,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  		if (!lr->function && !lr->file) {
>  			semantic_error("Only '@*' is not allowed.\n");
>  			err = -EINVAL;
> -			goto err;
> +			goto out;
>  		}
>  	} else if (strpbrk_esq(buf, "/."))
>  		lr->file = strdup_esq(buf);
> @@ -1448,10 +1448,10 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  	else {	/* Invalid name */
>  		semantic_error("'%s' is not a valid function name.\n", buf);
>  		err = -EINVAL;
> -		goto err;
> +		goto out;
>  	}
>  
> -err:
> +out:
>  	free(buf);
>  	return err;
>  }
> -- 
> 2.34.1
> 
