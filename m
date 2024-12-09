Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744DC19E97C;
	Mon,  9 Dec 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785857; cv=none; b=kQFWknUYdhFiIFPpCz9HC73MVJnJcuwjNs763Qud0ww+J5o1uWZXO9kDl2fMC+5lTTkvicsMt3CTU/WlMULi1y2gm6n14AurXR5G3on0BevckxHGnJWYbor5YJLOrbqkV2GKwBmeriOGwBvAP9zl+p30SXuW+dJ1TRX9oUME/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785857; c=relaxed/simple;
	bh=qP7vsdicRQuCVVCrhvVjbo7LX1EgSPHbrz3rcVNJm24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpbCB5yGMbxR/kEDSXYf7wAiTVPsX9guE/ZM1E79+0YHJTW1PhcXNTQSzYm5OkXRaMXjFHEe3b/w5K+LGUNYn259vemPfZ3R4HQ0s6qv9wuaJ+TLBR0mOktZz5SjDi1NOHXc1O7PichduheB2QRRvI14/jZmJuRbZLuPCqFpBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9JLhlVV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9JLhlVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F84C4CED1;
	Mon,  9 Dec 2024 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733785857;
	bh=qP7vsdicRQuCVVCrhvVjbo7LX1EgSPHbrz3rcVNJm24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9JLhlVVVoFrH2qPJ5mrGc0mT5uuCYxnONm80oNAL6GsxZ+4iqNXEJa9HqYU1dwMw
	 t6QyUw5DjN5HoaeXZddqRq1IdBatlhD/ZRBMwjw0KZLHMYDTs3KnAr7T70HIwAEi0j
	 dBHjEqcXKmbE/5EOBUZDRaFO9FY88j2valdZzN0KOW3m+V/+6R6lIMXULZ6VnBGbpe
	 4c+Zax4V/HZfs+RipKUhc3/IGlScQNxvMFnA6I2dwwu8qfFn6OIt93PM7lGYbWFWcg
	 hVJuOK7W7OIt3d+ka2bSKq4RuPmql0zIWqLxNQnCLE3zGDVBM7649UIMJhzuNMpnqC
	 +VRL0sFt6Zsag==
Date: Mon, 9 Dec 2024 15:10:54 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <Z1d4_kq5WoFA1GsJ@google.com>
References: <20241209171222.1422577-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
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
