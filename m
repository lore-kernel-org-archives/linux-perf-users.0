Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6352ED5D;
	Wed,  9 Sep 2026 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952231; cv=none; b=tPYw+/e0SizRxdhRL4YA17GBVhlPHlBtL3oVMyJLHBImYfyt+ABAd11q8LLlAgbNNbEWmulJ3V2ljPDadIINnvqLD8U4GM93V4RMpEXBn3BxTuh+uo5j9f2FVT05cC/CL5kiTbiJJNA0NSCEmjeBBqBdYIg5E4Ma5Z0xJ59tcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952231; c=relaxed/simple;
	bh=cuwUkj2O7mRYSLohTaTJ7WLNaF7OOF9Ap2sARWIBf3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKAHCBOaNxTh2jDUzRrSf/etXPKo4AAS5X3GUREdLNx4E2xwEgd3Ona0lO3uZ22+GtgFNySQm3QLJWoF0LS7Xzx32A9w28gOTv/P5hfYmo/DAzb0lFUY0H9EawljQ5RAzVPDxCzarIUHN3n6R4Z4T2al0kh91l7K7ml9VqeWy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR5fOd7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR5fOd7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB901F00AC4;
	Wed,  9 Sep 2026 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952229;
	bh=GaJryd49s3a+qE5VmccUw8O8+mpT2/H9esENmSLtHv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XR5fOd7Yf7Dqp9W7U2Mp0NwtZJUWyliuVX2cyIcak29kWW3/rbkc+GXO0hILEeodq
	 m68jDB0i8Mq0di0aSusQ2wW5/z8YXkLm68ApWYsPb8xEmYekLbO96kD0cTpp8wUg06
	 nXnEmGt52kZEgoMfbWIUxVkbxEtJ8zRbaNUsIMn07mYNi5wxk313YonpGesoLW4EJG
	 gNPMwdbdyywlykwzl4hbelMssF3QihpjZRmL/oRE2WuFyUTxez9u04PKKwoHeR7+yj
	 hIINXK86+7p95bZXI7QVtDgfXVV++T7NlHNn39gw7oiXn/C/PDpX84V8I7Ul43Bd0b
	 w28HfyQYkDCPQ==
Date: Wed, 9 Sep 2026 08:10:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Avoid uninitialized memory read on error
Message-ID: <aqE-ol3L6kXfSOYr@x2>
References: <20260908220720.564614-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908220720.564614-1-irogers@google.com>

On Tue, Sep 08, 2026 at 03:07:20PM -0700, Ian Rogers wrote:
> If has_supported_counters fails then msg was passed to ui__error
> regardless of whether an error was written into msg leading to reading
> uninitialized memory. Avoid this by always terminating msg at
> initialization.
> 
> Opportunistically reduce the scope of msg to make its use clearer.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Fixes: c9a8c343ef2f ("perf stat: When no events, don't report an error if there is none")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c50cf230f16e..37752d6bfef4 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -777,7 +777,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	int interval = stat_config.interval;
>  	int times = stat_config.times;
>  	int timeout = stat_config.timeout;
> -	char msg[BUFSIZ];
>  	unsigned long long t0, t1;
>  	struct evsel *counter;
>  	size_t l;
> @@ -908,6 +907,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		}
>  	}
>  	if (!has_supported_counters && !stat_config.null_run) {
> +		char msg[BUFSIZ];
> +
> +		msg[0] = '\0';
>  		if (open_err) {
>  			evsel__open_strerror(evlist__first(evsel_list), &target, open_err,
>  					     msg, sizeof(msg));
> -- 
> 2.55.0.979.g7e5102b832-goog
> 
