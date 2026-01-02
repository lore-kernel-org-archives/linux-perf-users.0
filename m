Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26B22F772;
	Fri,  2 Jan 2026 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767393607; cv=none; b=d5Kqh0zCzeiwy+5tcRpoqpTL6EQpN8BBVXSnmY06vbwwBzZKzVI0RoIH3j4d7CgqMN/KNJ3OSKGwH5a+8J1cA/eYgecuExZS9iaCuhFIU65yg7VRiuAIgiEtH4NGeJhstCJK4zcY/a1jk9wX6fJAAaQgH9H5eBtYgZvzW09s/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767393607; c=relaxed/simple;
	bh=u2sBzbUtQ52TAIVixNJyjTXZ4doXDV44CBYUI02UpS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0GIs5KGjdoS0UyYQ+OaVpYng/zgoKUyP4120uPN0xfg8VJwAUR0lWWXiDygx2VZQtJMVyjOAVI8XJ6aNgEGlOUjChxr0hoUypnBI5buvLu8oYJP7+5Wz+cb0i8igtQuRSCF1OevHx2dVKKzkDXLwICfyrS93/mRyB7rJi4AE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxwptyRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxwptyRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E96CC116B1;
	Fri,  2 Jan 2026 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767393607;
	bh=u2sBzbUtQ52TAIVixNJyjTXZ4doXDV44CBYUI02UpS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hxwptyRlqOilA+7ZQgpbMzaWtdwKTZP3MB2sXq9XO0QxXj5ZzoTe83WGBSxYz0Yaj
	 PW47boH91GDqNZKenbkTriPmILAUjQDI1pi8u15rJ3YIN8TophAfp6xDz3ebM1jocx
	 BWVn7QtE/kCvn6QwbC7hny8MK0W2jeNBdgKU0kiYpa2xBLYaq2CNgZEGNeiVq+wTjb
	 +RWTbfGpmCUqhz7zxgEgt4ddklcQ7XVu2fQucs9YHiN3hU3E0iCwP8n5+wRmngg5+x
	 pelaOM7QGH3B517vLaJc0PDMhs3wSgdEtQF1Nfyh1ZxwaSeIfM71BnkcHI8sjvK5EF
	 N4MsBKkh1zclg==
Date: Fri, 2 Jan 2026 14:40:05 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Dump callchain context marker names
Message-ID: <aVhJRW9URWItj2fh@google.com>
References: <20260102-james-perf-dump-callchain-markers-v1-1-3a9bdec20c58@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260102-james-perf-dump-callchain-markers-v1-1-3a9bdec20c58@linaro.org>

Hi James,

Happy new year!

On Fri, Jan 02, 2026 at 12:15:43PM +0000, James Clark wrote:
> These are hard to interpret in the raw output because they are printed
> as hex but are defined in perf_event.h as decimal. Make it much easier
> to read the raw callchains by just printing their names.
> 
> For example:
> 
>   $ perf report -D
> 
>   1798195372321 0x4638 [0xb0]: PERF_RECORD_SAMPLE(IP, 0x4002): 44922/44922: 0x7c8046dd3400 period: 120218 addr: 0
>   ... FP chain: nr:12
>   .....  0: fffffffffffffe00 (PERF_CONTEXT_USER)
>   .....  1: 00007c8046dd3400
>   .....  2: 00007c8046db86d3
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/session.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4236503c8f6c..e812f8954075 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -841,6 +841,26 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
>  	}
>  }
>  
> +static const char *callchain_context_str(u64 ip)
> +{
> +	switch (ip) {
> +	case PERF_CONTEXT_HV:
> +		return " (PERF_CONTEXT_HV)";
> +	case PERF_CONTEXT_KERNEL:
> +		return " (PERF_CONTEXT_KERNEL)";
> +	case PERF_CONTEXT_USER:
> +		return " (PERF_CONTEXT_USER)";

We now have PERF_CONTEXT_USER_DEFERRED too.

Thanks,
Namhyung


> +	case PERF_CONTEXT_GUEST:
> +		return " (PERF_CONTEXT_GUEST)";
> +	case PERF_CONTEXT_GUEST_KERNEL:
> +		return " (PERF_CONTEXT_GUEST_KERNEL)";
> +	case PERF_CONTEXT_GUEST_USER:
> +		return " (PERF_CONTEXT_GUEST_USER)";
> +	default:
> +		return "";
> +	}
> +}
> +
>  static void callchain__printf(struct evsel *evsel,
>  			      struct perf_sample *sample)
>  {
> @@ -853,8 +873,9 @@ static void callchain__printf(struct evsel *evsel,
>  	printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
>  
>  	for (i = 0; i < callchain->nr; i++)
> -		printf("..... %2d: %016" PRIx64 "\n",
> -		       i, callchain->ips[i]);
> +		printf("..... %2d: %016" PRIx64 "%s\n",
> +		       i, callchain->ips[i],
> +		       callchain_context_str(callchain->ips[i]));
>  
>  	if (sample->deferred_callchain)
>  		printf("...... (deferred)\n");
> 
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20260102-james-perf-dump-callchain-markers-64d175b108c8
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
