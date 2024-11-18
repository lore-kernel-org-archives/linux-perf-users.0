Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D321E7674;
	Mon, 18 Nov 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964630; cv=none; b=O/SY7TS5w9YsJa7lJIgEtUkGctFXhAqNPWryFHEm5CcYcIiXB4DIxJPSce74mr+5w2u6lje8lH7S0KljhWkS2YPFoVHXMukcQzO8eStI/9hme9JXw5V17tJXW+29YCg4HVYa4oLWX2GJ4tkHUzpIwvrJ92c6HOPhGgqBsXRp22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964630; c=relaxed/simple;
	bh=9TBxA42ZTn5iyvXFYCgi43nTdVs128UxQ3PPtNhVW0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7HmY3U5XgX8/eVth/G7GUNanDn30HLIcRzDwe2wu7FHj9LY8QnAE9lfu0ySiopEzxJ7aAzA3PlWgcwM3EVOcIf2oaIWZ7LDTGUJkbrHqyVO4+dCbsBO1AlHJe2rP6TeFJ8AEuc+2GNvX692+1nEtfjMYDpaWbhoQibWHJYChYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFWfgJjk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFWfgJjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC1EC4CED7;
	Mon, 18 Nov 2024 21:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964629;
	bh=9TBxA42ZTn5iyvXFYCgi43nTdVs128UxQ3PPtNhVW0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFWfgJjkJUQ+OP98HTM7UPtE6PwDOeExCIjKKGH8Df5l43b2tLak/hTFl+1WLxYu9
	 wrP+TVgiegF2Hos7ZHj0iRYOQ0tb8usBqtg0q8YwwIZOt3+jYE8KdGZnyu3L+V7Gzm
	 nkI9zqe1hrj8BFfq+ZpLBhkLaIP8FRbmfRUMbJLfpXemRG9tITRA30I7C1JVN8UnZ7
	 VGf/Qvt1p8jqGGCgWAksbvVy3vWgJoS+Bg0ezWSWi0rnhhXMbZBN8lXDAfW2UpXVKw
	 I0MAMD4Dje5OX4d4WFA0wXHHqERgTwHba4+uBFFq0GOGAkbFxHnrPaQokd9hKwO/la
	 89o1C/ZUnE57w==
Date: Mon, 18 Nov 2024 13:17:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, irogers@google.com,
	mingo@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v8 03/10] perf record --off-cpu: Parse off-cpu event
Message-ID: <Zzuu06ybvy8IpH5m@google.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
 <20241113002818.3578645-4-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113002818.3578645-4-howardchu95@gmail.com>

On Tue, Nov 12, 2024 at 04:28:11PM -0800, Howard Chu wrote:
> Parse the off-cpu event using parse_event(), as bpf-output.
> 
> no-inherit should be set to 1, here's the reason:
> 
> We update the BPF perf_event map for direct off-cpu sample dumping (in
> following patches), it executes as follows:
> 
> bpf_map_update_value()
>  bpf_fd_array_map_update_elem()
>   perf_event_fd_array_get_ptr()
>    perf_event_read_local()
> 
> In perf_event_read_local(), there is:
> 
> int perf_event_read_local(struct perf_event *event, u64 *value,
> 			  u64 *enabled, u64 *running)
> {
> ...
> 	/*
> 	 * It must not be an event with inherit set, we cannot read
> 	 * all child counters from atomic context.
> 	 */
> 	if (event->attr.inherit) {
> 		ret = -EOPNOTSUPP;
> 		goto out;
> 	}
> 
> Which means no-inherit has to be true for updating the BPF perf_event
> map.
> 
> Moreover, for bpf-output events, we primarily want a system-wide event
> instead of a per-task event.
> 
> The reason is that in BPF's bpf_perf_event_output(), BPF uses the CPU
> index to retrieve the perf_event file descriptor it outputs to.
> 
> Making a bpf-output event system-wide naturally satisfies this
> requirement by mapping CPU appropriately.

I'm afraid the inherit attribute would be updated later:

  __cmd_record()
    evlist__config()
      evsel__config()

You can add a logic to check the config term when setting the inherit
value.

Thanks,
Namhyung

> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-4-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/bpf_off_cpu.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index a590a8ac1f9d..558c5e5c2dc3 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -38,32 +38,21 @@ union off_cpu_data {
>  
>  static int off_cpu_config(struct evlist *evlist)
>  {
> +	char off_cpu_event[64];
>  	struct evsel *evsel;
> -	struct perf_event_attr attr = {
> -		.type	= PERF_TYPE_SOFTWARE,
> -		.config = PERF_COUNT_SW_BPF_OUTPUT,
> -		.size	= sizeof(attr), /* to capture ABI version */
> -	};
> -	char *evname = strdup(OFFCPU_EVENT);
> -
> -	if (evname == NULL)
> -		return -ENOMEM;
>  
> -	evsel = evsel__new(&attr);
> -	if (!evsel) {
> -		free(evname);
> -		return -ENOMEM;
> +	scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/no-inherit=1,name=%s/", OFFCPU_EVENT);
> +	if (parse_event(evlist, off_cpu_event)) {
> +		pr_err("Failed to open off-cpu event\n");
> +		return -1;
>  	}
>  
> -	evsel->core.attr.freq = 1;
> -	evsel->core.attr.sample_period = 1;
> -	/* off-cpu analysis depends on stack trace */
> -	evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
> -
> -	evlist__add(evlist, evsel);
> -
> -	free(evsel->name);
> -	evsel->name = evname;
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (evsel__is_offcpu_event(evsel)) {
> +			evsel->core.system_wide = true;
> +			break;
> +		}
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
