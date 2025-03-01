Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F372F56;
	Sat,  1 Mar 2025 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787784; cv=none; b=uXiU8iPqMwtbIeUDq0MW89QGyOP53fwVg/Jk8QRjJqkpA/WK8B4wS3Q8Tf6u9JR+2d532BnujGCyC0nMn0j1NvswBJB/f0V6t3byDa8/E6XcVqLQ10M3l+3mRmj6yEeAgm2o3e86Xct4HJv9h+hBFrRAB8WHP/X6xMUfNG2qj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787784; c=relaxed/simple;
	bh=lI94YeP9vXALbFJ1hbAFK2++txCZPTsPZ8bAiGKBel0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYrDDimLBAyLg1Q7PNk3rwOwq5vIHmcESlnEzlWMhAnNOVftKbYAG5AcOlmHtiXqXI/BQwIYJSTz9MOPIScXaQir2U9AZwRqbKFGcirqVmK9UgD6BwkBsPcSc4AY1oxHuUrcEHxkXX7EcSugpkEYOZs90c5uba9f6UdEIBRKS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn6QNDFm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn6QNDFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7F5C4CEE2;
	Sat,  1 Mar 2025 00:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740787783;
	bh=lI94YeP9vXALbFJ1hbAFK2++txCZPTsPZ8bAiGKBel0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn6QNDFmdVo2BP3gHOwEhWhXeLnZAjLcVhEtGj/t0ZkSo0RYCoxk6XWWXZ58/4Bx4
	 Qjd9G6mOfwzqLVof0SCMJ66vQqKaqCsBKV4ZhK+M4GVatf7O8exzWyndJ4+nvUPdcX
	 MVAPZF16d+kaFbqpImzDftIU2nyJc2KngeFvp2OWPsGQwzY62XQXETFQjH5PCW+lqc
	 eH/btHnuDBxeRrDegnso7GzKJbjEvBw9aiehTiYRnxvCvgWxS6eAkmpJ2GzvoazEKf
	 +gsPmXwQVfSM1Bk0m0f6fFu5SdDdTJhvSBPWEk6Lk4RJENWgeZMKXtcXQL4l7tY4Gm
	 8SLkJwTLORrTw==
Date: Fri, 28 Feb 2025 16:09:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf stat: Fix uniquify for hybrid systems
Message-ID: <Z8JQRbjuhILt7-B4@google.com>
References: <20250228195351.1160071-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228195351.1160071-1-thomas.falcon@intel.com>

Hello,

On Fri, Feb 28, 2025 at 01:53:51PM -0600, Thomas Falcon wrote:
> Currently, perf stat is omitting the pmu name for legacy events
> on hybrid systems. git bisect indicated commit 357b965deba9 as the cause:
> 
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [357b965deba9fb71467413e473764ec4e1694d8d] perf stat: Changes to event
> name uniquification
> 
> Include an additional check for hybrid architectures when determining
> whether to uniquify legacy events.
> 
> Before:
> 
> $ sudo ./perf stat -e cycles -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        173,903,751      cycles
>        666,423,950      cycles
> 
>        1.006615048 seconds time elapsed
> 
> After:
> 
> $ sudo ./perf stat -e cycles -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        841,496,603      cpu_atom/cycles/
>      3,308,929,412      cpu_core/cycles/
> 
>        1.002483283 seconds time elapsed
> 
> Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Thanks for the fix, but there's a similar patch in the list.
Please take a look.

https://lore.kernel.org/r/20250226145526.632380-1-james.clark@linaro.org

Thanks,
Namhyung

> ---
>  tools/perf/util/stat-display.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index e65c7e9f15d1..df9f68080ec9 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1676,6 +1676,7 @@ static bool evlist__disable_uniquify(const struct evlist *evlist)
>  
>  static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config)
>  {
> +	bool hybrid = (!config->hybrid_merge && evsel__is_hybrid(counter));
>  	struct evsel *evsel;
>  
>  	if (counter->merged_stat) {
> @@ -1688,7 +1689,8 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
>  		return;
>  	}
>  
> -	if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
> +	if (!hybrid && counter->core.attr.type < PERF_TYPE_MAX &&
> +		counter->core.attr.type != PERF_TYPE_RAW) {
>  		/* Legacy event, don't uniquify. */
>  		return;
>  	}
> @@ -1705,7 +1707,7 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
>  		return;
>  	}
>  
> -	if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
> +	if (hybrid) {
>  		/* Unique hybrid counters necessary. */
>  		counter->needs_uniquify = true;
>  		return;
> -- 
> 2.48.1
> 
