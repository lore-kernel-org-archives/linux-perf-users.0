Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DA360EC9;
	Fri, 31 Jul 2026 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785535308; cv=none; b=l4cpEiDinuJ//6N8w7bYdrMkaJmAXW8WgyREwxi4J9xHIgn4lvWNagk1jQc3O1gacuNJBf1lA6BamtCwOkGTN9jZvVEn+1Pp2jCFL6jh3uTj285Uu+6TgK4cqb/v0oEGoDNW4ddciqQiQpyTVFFr0R4g6VcWHWYySl+gb0APlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785535308; c=relaxed/simple;
	bh=uKYikd2mVQNZ1VGYe342htO7GIUKF6i9NqEBTfAElwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE/iDU2ORyojBWLkS0wxaFdP6ngVd3NwST8FOVr6G6LFb5v5C2WEOgfmrT6wBcC0/acnz8lYGg6FkTvFpNYpgxGh3nXXTxtruPa8ry5PXU2T6K4i6gveylY+43g3mqTJznGMrWaoifP5onZr8NEhViDBJRZnRAS5GwQu89lQ5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyWNfmjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyWNfmjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC581F00AC4;
	Fri, 31 Jul 2026 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785535307;
	bh=wsuLrkdoUKeF2en7zAA3Fbfk2jDB3PrDyYbtFD8nnFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KyWNfmjtbX6asvvK/StkZLfwK/OkNt5zi6YxH0hnqRT82ifVR+yB0X1o7wCegcp6Q
	 5KDJEu2fC0an3Wx68nKi99kE/wka0ay1YFcn54fFckaz8rS+rA3mEQcqlgZYJEvhnE
	 OzIV7dTBmQ0ktYqwX/mKKwk1sdEvCsjap9xBpS+cOpBJP+oOFT6qiynQryRmJyb3Dw
	 QJhhwL/2P/jcntCFLQuBPaPa0IaRmAmJmNrEdz17k4YB+dsPsqA2LnIEbAs+0kizIR
	 CZKwkxjs8KWxRJPrs/eKzFCFgXCufAC3LA8exZougT9xYmCIfu5tXmrnq2MRulOq7l
	 NDXCGwEubseTQ==
Date: Fri, 31 Jul 2026 15:01:45 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf sched latency: Auto-scale latency and
 runtime display units
Message-ID: <am0bSUV7tRYWoWyr@google.com>
References: <20260730185416.97166-1-atomlin@atomlin.com>
 <20260730185416.97166-3-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730185416.97166-3-atomlin@atomlin.com>

On Thu, Jul 30, 2026 at 02:54:15PM -0400, Aaron Tomlin wrote:
> Currently, 'perf sched latency' displays task runtime and delay values
> exclusively in milliseconds (ms). This can be hard to read when
> latencies are very small (in the microsecond or nanosecond range) or
> unusually large (seconds).
> 
> Introduce auto-scaling for latency and runtime display columns. Values
> are dynamically scaled and output with the most appropriate unit:
> nanoseconds (ns), microseconds (us), milliseconds (ms), or seconds (s).
> 
> Additionally, rename column headers from "Runtime ms", "Avg delay ms",
> and "Max delay ms" to "Runtime", "Avg delay", and "Max delay"
> respectively, adjust spacing to maintain column alignment and stripe
> redundant prefix strings from each row's format string to produce a
> clean, tabular output.

It'd be nice if you could include example output when you touched user-
visible area.  Comparing before and after would be great.

Thanks,
Namhyung

> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-sched.c | 42 +++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 0abf9f1f3c2e..bfbedd12b346 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -246,6 +246,17 @@ struct perf_sched {
>  	struct perf_data *data;
>  };
>  
> +static int scnprintf_latency_unit(char *buf, size_t size, u64 nsecs)
> +{
> +	if (nsecs < 1000)
> +		return scnprintf(buf, size, "%6" PRIu64 " ns", nsecs);
> +	if (nsecs < NSEC_PER_MSEC)
> +		return scnprintf(buf, size, "%6.3f us", (double)nsecs / NSEC_PER_USEC);
> +	if (nsecs < NSEC_PER_SEC)
> +		return scnprintf(buf, size, "%6.3f ms", (double)nsecs / NSEC_PER_MSEC);
> +	return scnprintf(buf, size, "%6.3f s ", (double)nsecs / NSEC_PER_SEC);
> +}
> +
>  /* per thread run time data */
>  struct thread_runtime {
>  	u64 last_time;      /* time of previous sched in/out event */
> @@ -1405,6 +1416,8 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
>  	int i;
>  	int ret;
>  	u64 avg;
> +	char runtime_lat[32];
> +	char avg_lat[32], max_lat[32];
>  	char max_lat_start[32], max_lat_end[32];
>  
>  	if (!work_list->nb_atoms)
> @@ -1430,14 +1443,17 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
>  		printf(" ");
>  
>  	avg = work_list->total_lat / work_list->nb_atoms;
> +	scnprintf_latency_unit(runtime_lat, sizeof(runtime_lat), work_list->total_runtime);
> +	scnprintf_latency_unit(avg_lat, sizeof(avg_lat), avg);
> +	scnprintf_latency_unit(max_lat, sizeof(max_lat), work_list->max_lat);
>  	timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeof(max_lat_start));
>  	timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(max_lat_end));
>  
> -	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
> -	      (double)work_list->total_runtime / NSEC_PER_MSEC,
> -		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
> -		 (double)work_list->max_lat / NSEC_PER_MSEC,
> -		 max_lat_start, max_lat_end);
> +	printf(" |%15s |%9" PRIu64 " |%16s |%16s |%20s s |%20s s |\n",
> +	       runtime_lat,
> +	       work_list->nb_atoms, avg_lat, max_lat,
> +	       max_lat_start, max_lat_end);
> +
>  }
>  
>  static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
> @@ -3616,6 +3632,7 @@ static int perf_sched__lat(struct perf_sched *sched)
>  {
>  	int rc = -1;
>  	struct rb_node *next;
> +	char total_runtime_str[32];
>  
>  	setup_pager();
>  
> @@ -3628,9 +3645,9 @@ static int perf_sched__lat(struct perf_sched *sched)
>  	perf_sched__merge_lat(sched);
>  	perf_sched__sort_lat(sched);
>  
> -	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
> -	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
> -	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
> +	printf("\n -----------------------------------------------------------------------------------------------------------------------------------------\n");
> +	printf("  Task                   |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
> +	printf(" -----------------------------------------------------------------------------------------------------------------------------------------\n");
>  
>  	next = rb_first_cached(&sched->sorted_atom_root);
>  
> @@ -3642,11 +3659,12 @@ static int perf_sched__lat(struct perf_sched *sched)
>  		next = rb_next(next);
>  	}
>  
> -	printf(" -----------------------------------------------------------------------------------------------------------------\n");
> -	printf("  TOTAL:                |%11.3f ms |%9" PRIu64 " |\n",
> -		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count);
> +	printf(" -----------------------------------------------------------------------------------------------------------------------------------------\n");
> +	scnprintf_latency_unit(total_runtime_str, sizeof(total_runtime_str), sched->all_runtime);
> +	printf("  TOTAL:                 |%15s |%9" PRIu64 " |\n",
> +	       total_runtime_str, sched->all_count);
>  
> -	printf(" ---------------------------------------------------\n");
> +	printf(" -----------------------------------------------------\n");
>  
>  	print_bad_events(sched);
>  	printf("\n");
> -- 
> 2.55.0
> 
