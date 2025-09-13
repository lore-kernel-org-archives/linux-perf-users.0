Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CFA2EB10;
	Sat, 13 Sep 2025 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724503; cv=none; b=AJ7Xver+aw6Xn5tDUFsAL3H4u7emGY7tdNj7mvei7aYs91tCzlYoWjZqNM5hzeocV4gDX8fF3bWMdfX+2Ah3/Sh5JSGOvCqG4gUOaldMh+pc8cx/UxDHjkz45oGEquqZ+/Yg1pizFHCQFZ7eBqjK9Zdm0GX4aW/wU3rKNk7H8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724503; c=relaxed/simple;
	bh=1TwK5Sh9P3VBpxt1xTJbYYycQrwk9/QJHOpONGvrf0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYu0OfaA2rlCTN+jhC6ulorG2AIwPyvwT7FRF+tZUBeSz21hXimsmO55LKKBAJTr42cKKiZHtuZ5J7Ade/XEk7+4ARnGWuu7XYAHuY64ppTCAgoNyv0ULKKSu8+orsjoDJJ9DWuNvD9vd0SkysyVHH0qstgGxsVdZsYt5v9wjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGJQs2m/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGJQs2m/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974D5C4CEF1;
	Sat, 13 Sep 2025 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757724502;
	bh=1TwK5Sh9P3VBpxt1xTJbYYycQrwk9/QJHOpONGvrf0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGJQs2m/zshV8BraUqNJf5g7rzsOTIZWDRIk3KPkfA72qDngGGUetkRRC7PuZ2//o
	 dmiiRpqwWgdCcv9a/AgcfyZ7iHce99lgbXY/8D7eQ8+mCRCKcs0IScpsfTyAOBSFdD
	 7jo9y2628/pRHsEb12gUsQXQp9DMv6rzfJ48d1vpHSuk6Gua4HRc1CPgEuKggJA0il
	 CbQUxXaRz5bHWl6gg+GyC+4oQWtVQvYbzmb7iFPSLbfKZHh4RgGSpHgjET4LLAc3ES
	 nMSTcQdtGBT6Xw9dq/v3rdaov5+iEoFG2ZtaWRwo7VSTRsnvf/bF9pfVTVty7+jJOS
	 OJ1v4XtM4kh3Q==
Date: Fri, 12 Sep 2025 17:48:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf lock: Provide a host_env for session new
Message-ID: <aMS_VJpwvwBIW44t@google.com>
References: <20250913000129.1306162-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250913000129.1306162-1-irogers@google.com>

On Fri, Sep 12, 2025 at 05:01:29PM -0700, Ian Rogers wrote:
> When "perf lock con" is run in a live mode, with no data file, a host
> environment must be provided. Testing missed this as a failing assert
> was creating the 1 line of expected stderr output.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Please consider this patch for v6.17 fixes.

Yep, I'll queue it to perf-tools tree.

Thanks,
Namhyung

> ---
>  tools/perf/builtin-lock.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index fd49703021fd..078634461df2 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2009,6 +2009,7 @@ static int __cmd_contention(int argc, const char **argv)
>  		.owner = show_lock_owner,
>  		.cgroups = RB_ROOT,
>  	};
> +	struct perf_env host_env;
>  
>  	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
>  	if (!lockhash_table)
> @@ -2024,7 +2025,10 @@ static int __cmd_contention(int argc, const char **argv)
>  	eops.mmap		 = perf_event__process_mmap;
>  	eops.tracing_data	 = perf_event__process_tracing_data;
>  
> -	session = perf_session__new(use_bpf ? NULL : &data, &eops);
> +	perf_env__init(&host_env);
> +	session = __perf_session__new(use_bpf ? NULL : &data, &eops,
> +				/*trace_event_repipe=*/false, &host_env);
> +
>  	if (IS_ERR(session)) {
>  		pr_err("Initializing perf session failed\n");
>  		err = PTR_ERR(session);
> @@ -2142,6 +2146,7 @@ static int __cmd_contention(int argc, const char **argv)
>  	evlist__delete(con.evlist);
>  	lock_contention_finish(&con);
>  	perf_session__delete(session);
> +	perf_env__exit(&host_env);
>  	zfree(&lockhash_table);
>  	return err;
>  }
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
