Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201983;
	b=X29u7OxGHHqr4lyLYE1CqmbY4E4gDkHz59wX9AuxwHJBJAbYOKcE1RG2owemu3BcQw8p
	 c08IE+JO7DcBSzJC81ywZcrL0nEBdNZuViyVCbHMoCSeHLNk1d7tmR6a7Iorb02lzqo3o
	 tf020rd4MZHUSwWCC1HPsxx21ZlUHvJAx+A6Z59HBw6lIsrwsQWF/g45BtUElEByuZc/2
	 UehPUyJZMl0Kv+5zrE3fVHEEEZO1O450xxf4nh6UNBgTq/B+ln4wnkqzUuiZWbVSuptUU
	 ERo8V5T5ZvrC6RKVf5V5xq/XtfIGt2ofDAmqwlYysl7MZGjRzfeCbNEqkrhnKl25ekA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201983;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Uy6ZibXC/S+TPzv6yEZDSpvw02UsW0HIsbZ/ZeOvYfg=;
	b=0ccaxOpgHtNEEHZy08wG8A+m5FoV5Pjw7KX95arHXkN6AJ9oi0C1W8itGIhJ19I2ZvG6
	 M3eW0wpA+kNhoHLID9vnbNxP3hhI2WEf+WZGZVcgrvHw2x+sSm3Nm69679/VCoL7p442E
	 fJ9ftJGswm9okJ8rez6Wlg/fO6lvwMftekM6QRST1VJjiAU9P0ge5a4SzU6y6dHg/eb+Z
	 EI4SDQoksOyQMHBKZILbICFwyz3bWURxT1RXKbj2SRDnwuXMigsME9z3Qzb+Ijl044LGl
	 wOroGMcRy/SNvrlkulYlXIaGM1jVIRoYhAuWJCxn9IsXEbFD/jgSbgIgjdPqVtddwZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNJTK4Il;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C0606A31C;
	Mon,  9 Nov 2026 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNJTK4Il
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75651F0089F;
	Mon,  9 Nov 2026 05:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794201983;
	bh=Uy6ZibXC/S+TPzv6yEZDSpvw02UsW0HIsbZ/ZeOvYfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eNJTK4IlJicAgAYrOlvdIYd0JOY304zSG2g1l+1Sxg/5xyzlW7N2rivl2fOEda5z9
	 xFfImnAgHPS9UERr8kpB0exXpowczvc0kR+8vBbF3wBp3SNfYI5TfxtQbizZha13vb
	 +XwY/h4d1VHS2E/QlDhbjyExdAEPGbUE74U3QwrmYPZ6kpB6EwdGGTPPrmEyJU3tpo
	 2bvG+1HfdpMYwRIa/2USCMPRVhes224KNPkpXgOdhnaYvMF2mR8pl3RD1TeMQdFuyP
	 Qium/17It8gAX6gRG4XnFi+2a31lXC1/spFJfYT79Is/CEB5cvKTCUjrby4xYQbzDb
	 S+MBXdQEb8gtw==
Date: Sun, 8 Nov 2026 21:26:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf iostat: Do not compute interval deltas a second time
Message-ID: <avFZfcWDPD3eXW-w@z2>
References: <20261105080429.2472-1-lirongqing@baidu.com>
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
In-Reply-To: <20261105080429.2472-1-lirongqing@baidu.com>

On Thu, Nov 05, 2026 at 04:04:29PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> process_counter_values() now computes deltas directly in evsel->counts
> for global aggregation too. It saves the current cumulative raw count in
> prev_raw_counts before iostat prints the interval.
> 
> Subtracting prev_raw_counts again can therefore underflow the count.
> Worse, replacing the saved raw count with the interval delta corrupts
> the baseline used to calculate the next interval.

Can you share example output before and after this change?

Thanks,
Namhyung

> 
> Use the already computed delta and leave prev_raw_counts untouched.
> 
> Fixes: f976bc6b6bfc ("perf stat: Aggregate events using evsel->stats->aggr")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  tools/perf/arch/x86/util/iostat.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
> index 0cf0f93..fac6b4a 100644
> --- a/tools/perf/arch/x86/util/iostat.c
> +++ b/tools/perf/arch/x86/util/iostat.c
> @@ -434,20 +434,12 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
>  			 struct perf_stat_output_ctx *out)
>  {
>  	double iostat_value = 0;
> -	u64 prev_count_val = 0;
>  	const char *iostat_metric = iostat_metric_by_idx(evsel->core.idx);
>  	u8 die = ((struct iio_root_port *)evsel->priv)->die;
>  	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
>  
>  	if (count && count->run && count->ena) {
> -		if (evsel->prev_raw_counts && !out->force_header) {
> -			struct perf_counts_values *prev_count =
> -				perf_counts(evsel->prev_raw_counts, die, 0);
> -
> -			prev_count_val = prev_count->val;
> -			prev_count->val = count->val;
> -		}
> -		iostat_value = (count->val - prev_count_val) /
> +		iostat_value = count->val /
>  			       ((double) count->run / count->ena);
>  	}
>  	out->print_metric(config, out->ctx, METRIC_THRESHOLD_UNKNOWN, "%8.0f", iostat_metric,
> -- 
> 2.9.4
> 
