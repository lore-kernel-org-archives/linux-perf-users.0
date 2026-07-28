Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50553C4B68;
	Tue, 28 Jul 2026 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260074; cv=none; b=gSLPrBHH5EhdF1jioHyxQYra75z+q2xdhwcruo4s4wq3Fdz+Buw3ZHzvBboh58ov9+WoZwJ4QtjqJVSW4ewYkm3QAHhnLXYq7Uk6q8PxIgRhbz7EddCx7tPsD4Vu/KjY7mwePS7Wl4bVL80WU1eI9w4uTO1vp8+o0uRnzsJ05n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260074; c=relaxed/simple;
	bh=x1MLYRp+1ts5xb8QyVR9GgsNOPYoY/e+8Hz1hvZOclg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of5GSR9StmYskiUv48uxl700seLIv1IRMOc4yeuwWxjlsVXKu8ec88mKzaSh59nDcAp/ClVJJT2v8d1qzATVI7SWCvvqj4Lu9R6t+54Ld3G2K/g8U4K030LwVu/dj3YVcO2zcCcVYlvfxw1hqhOHD3roxK3Y8vEB8di68bDiyYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Agr47fqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Agr47fqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5AC1F000E9;
	Tue, 28 Jul 2026 17:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260072;
	bh=ilI08JoD0Zr3QHn61+BtJ60EmZcWY3VUDc4hiw78MsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Agr47fqa7+D7jlmCjZVhUFADPq27vPn6P/5BJbGLtO4falVW5gMxBipoC6QbfHfuM
	 x+1L5sHyAoO4HjYoUkJFgI0HsdX/6GFA/xgRfZi4jr/TR2ScmN1P7NrC69YPupV674
	 oDOZk5T1/LjHhgxae5ypYOSlDWDrlCi1Hf4iVjafKdGiDrQgT/Jm7+xit9lGkTUyX9
	 bXo1qVp1WeyTKIOTG3RM66EwUgb+8YiKk0j1ANQ0WXIgpuhSmCOoe4uBovp27fouT0
	 E87s43XBBiU3rVrbXIzzhpjpN3Ze7ykr264hwAk4tPu/ghC3dvJQCKcqNsmG5e26Uu
	 biOw/ja//0rRg==
Date: Tue, 28 Jul 2026 10:34:31 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v2 6/6] perf c2c: print memory region data with stdio
 output
Message-ID: <amjoJwZSS_aM8T47@google.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
 <20260714004359.179451-7-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714004359.179451-7-thomas.falcon@intel.com>

On Mon, Jul 13, 2026 at 07:43:59PM -0500, Thomas Falcon wrote:
> Print memory range data in perf-c2c subcommand. Only available in stdio
> mode currently. If memory ranges are not supported or present, print
> nothing.

Can you please add an example output?

Thanks,
Namhyung

> 
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index cba2e9f21ae7..68348a93bd33 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2634,6 +2634,34 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
>  	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
>  }
>  
> +
> +static void print_memory_ranges_info(FILE *out, struct perf_session *session)
> +{
> +	struct perf_env *env = perf_session__env(session);
> +	int nr_ranges = 0;
> +
> +	if (!perf_header__has_feat(&session->header, HEADER_MEMORY_RANGES))
> +		return;
> +	nr_ranges = env->nr_memory_ranges;
> +	if (nr_ranges == 0) {
> +		pr_debug("No memory ranges found, skipping\n");
> +		return;
> +	}
> +
> +	fprintf(out, "\n");
> +	fprintf(out, "=================================================\n");
> +	fprintf(out, "                  Memory Ranges                  \n");
> +	fprintf(out, "=================================================\n");
> +
> +	for (int i = 0; i < nr_ranges; i++) {
> +		struct memory_range *r = &env->memory_ranges[i];
> +
> +		fprintf(out, "Range %d: [0x%016" PRIx64 "-0x%016" PRIx64 "] Node %d, local region id %u, remote region id %u\n",
> +			i, r->base, r->base + r->length - 1, r->node,
> +			r->local_region_id, r->remote_region_id);
> +	}
> +}
> +
>  static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
>  {
>  	setup_pager();
> @@ -2647,6 +2675,8 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
>  	if (c2c.stats_only)
>  		return;
>  
> +	print_memory_ranges_info(out, session);
> +
>  	fprintf(out, "\n");
>  	fprintf(out, "=================================================\n");
>  	fprintf(out, "           Shared Data Cache Line Table          \n");
> -- 
> 2.43.0
> 
