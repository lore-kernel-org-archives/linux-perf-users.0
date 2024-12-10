Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4D41C64;
	Tue, 10 Dec 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837211; cv=none; b=WdEUewyX9tHsFbImEYhlYdrne+TsOi1+xJAo07eTPbd10R6ReCGiOFv/BnJVkGqNFDQISeSC1ABE281XDnnS+zN2et5wR6OxrbOgr3xbbQDbmfZTAIC6YdxUip7CfMz06cRJJNRqvCRbOB5kG9w+A8co9MXfvXLbo4/0C79X1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837211; c=relaxed/simple;
	bh=sXTucf7zi96OnR6q9RPV98KKkWEHPLcp10zsSkEWwfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqofWHQoekt3b8oRQsnhon81Lb7hp65CBATQx++2MhElbF340vr2jMKQ7EU6hzZkDRoMlI45CNAEfUQ6y7B0ChgUp1GsYptynMSg9y10qi5NkNQIaQlrfQuttfbh9Xrp9R0QW2YiV4bcQS++EQBQDB43LUiKc++jdkM0kpiXi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxKiOhrG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxKiOhrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC94EC4CEDE;
	Tue, 10 Dec 2024 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733837210;
	bh=sXTucf7zi96OnR6q9RPV98KKkWEHPLcp10zsSkEWwfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxKiOhrG6hxNPWoonT0B50VczPJNW0DjrBF63q6cbfbSrCyPFs9m/pBHFBqGxCo6Z
	 6oXrDYnDWUN2REYuTasnWh8cY5tsr9NGgeSKFuTT/tiyv2Wob1blHbtawv3kHhxanX
	 Equ5ayBaWrsjR6XWjdahDXnO6gdUUE44S8yuh6hW/pJEwFVKqUxAb5WNpcnvRLLUvd
	 5JQ7udiEPSkuB7K1/sTNSzWjBTo8JhfBfyOHsymgCb9Gz4dlClyDcUSfLN9mxdQsg9
	 JsUarcEEYEFf0bRpex4aN5713uM+irz9g2CVmur5rKlT/XV0rtq4yfWoAGstNJidpN
	 EiGSlz0qYAv6Q==
Date: Tue, 10 Dec 2024 10:26:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Leo Yan <leo.yan@arm.com>, Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Fix uninitialized variable
Message-ID: <Z1hBk3b5zcSy567S@x1>
References: <20241209171222.1422577-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209171222.1422577-1-james.clark@linaro.org>

On Mon, Dec 09, 2024 at 05:12:21PM +0000, James Clark wrote:
> Since the linked fixes: commit, err is returned uninitialized due to the
> removal of "return 0". Initialize err to fix it, and rename err to out
> to avoid confusion because buf is still supposed to be freed in non
> error cases.
> 
> This fixes the following intermittent test failure on release builds:
> 
>  $ perf test "testsuite_probe"
>  ...
>  -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
>  Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
>  ...

Namhyung, I think this should go via perf-tools,

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/probe-event.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 6d51a4c98ad7..35af6570cf9b 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  {
>  	char *buf = strdup(arg);
>  	char *p;
> -	int err;
> +	int err = 0;
>  
>  	if (!buf)
>  		return -ENOMEM;
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
