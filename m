Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200718;
	b=uvZ8V9+Zlb5wsGDpN42IZCAc9gTxWWCb4sxFAodZL4T+iVKrar8xvamhJnZCGl93h/FY
	 qOdKdJUYNSYBPh7NillVQb/7SxRjQnZKFVtsd0m3fltdjkafVKaTFjrCCq0MYZ0sJSSs0
	 n7uU82wsA9q8fuOsbCxadziuR78k8E1aRtas6MhaNa+NARV5SLpB+RLM7JxPByFN3x6eS
	 zlNxcxoTxiweEDBio8mgrChmNU9DYBNCVHyXORxGibwMMOqSRD6FGy1nlSp7ITp9IVY6P
	 QFYLyUqwvUnzZWYw3zsTw9YmzgCEnDHsQmTQ1o1fL5lXmAaT7anOMML8cFEDuJfc5UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200718;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YhDYB9VCD0yrPWZ2fcw1r0wfo4j7xSr05dSXAefrmpI=;
	b=Q47Eb5JMlv3/yvUw363mYR2EozTYAfinbfnvQYox63VenQpRNTTkFnQgXdn7RCqC067x
	 l6ai559wXQDPG9lCkv2oIQfRpYJ1qIxkqytIz6zpBs9yedHyyDsgQOuYulo7WAYil9ACF
	 wfWe2I6tJt047GUzCowDOlvnu+ByyQ9h6KQBFdIGzSI9bParLs7mLS5P/c8yLxp07Ju5v
	 pJQslg4s3DWjWxFs7in3e20GFwk4Vs4i9fSl5OxzHkgA64yR/YYx0PzbU/2sHOhwVMLA1
	 sXKqAqdQyd/ZkYY7T2L3uCW7wfyQ01u4C/HfKM8DNmZx1CKyAuHWZZmGEqEIvUBTKAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RT0uoa9D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5D606A31C;
	Mon,  9 Nov 2026 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RT0uoa9D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78401F0089F;
	Mon,  9 Nov 2026 05:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794200717;
	bh=YhDYB9VCD0yrPWZ2fcw1r0wfo4j7xSr05dSXAefrmpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RT0uoa9Dmej4PB7jnw7+6GHBmV2aqp8rxLzZhCFTSlPlfvfdPDiHGIEslZ17OZREG
	 hL1FF+CPSSwwWWTYAE56jq+ewwJN7Ud1U/tOmFeTWXN8xEkGqTwFlM2BNuhiJv4h4S
	 +48eRoTtr7bgOl4RvDB0Z1Os00GK6z6qo+GflBLwJ99Ab+1gjrAAmlXUdHE0YiAhWn
	 AsV3E7XJOaAxQ4jU/8k84EtCXndx6hqBYY+GC68HS64vPE6esEScmPpMuDzT2389Nq
	 EzEAxiIRQIfGsLIjj4lyhT9eWN4Jj7KIr+uXrTeoRFkyBHiXtJ7FIKCgnAsQvFobJi
	 poDZv/d6ltbYw==
Date: Sun, 8 Nov 2026 21:05:15 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf iostat: Release the port list if command allocation
 fails
Message-ID: <avFUi_R0dzVEaT2X@z2>
References: <20261106021840.2186-1-lirongqing@baidu.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106021840.2186-1-lirongqing@baidu.com>

Hello,

On Fri, Nov 06, 2026 at 10:18:40AM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> The event-group builder takes ownership of the root port list and frees
> it on its normal and parsing-error paths. If allocation of the event
> command fails, however, it returns directly without releasing the list,
> its pointer array or its ports.
> 
> Use the existing cleanup path for this allocation failure too, before
> any port has been transferred to an event.
> 
> Found while testing the iostat fixes with allocation fault injection.
> 
> Fixes: f9ed693e8bc0 ("perf stat: Enable iostat mode for x86 platforms")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

This patch doesn't apply.  Can you please rebase onto the current
perf-tools-next?

Thanks,
Namhyung

> ---
>  tools/perf/arch/x86/util/iostat.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> index 2dc5ac6..f8b4939 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -342,8 +342,10 @@ static int iostat_event_group(struct evlist *evl,
>  	struct perf_cpu cpu;
>  	unsigned int cpu_map_idx;
>  
> -	if (!iostat_cmd)
> -		return -ENOMEM;
> +	if (!iostat_cmd) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
>  
>  	for (idx = 0; idx < list->nr_entries; idx++) {
>  		sprintf(iostat_cmd, iostat_cmd_template,
> -- 
> 2.9.4
> 
