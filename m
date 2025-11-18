Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3632695F;
	Tue, 18 Nov 2025 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433321; cv=none; b=ItjD14i2wunnPjzx5XO9oG4uKdbQ2ejtNmeBtoRacsmsgnS+5hoVHb+M4rWeWjq6PXniD23RECQszcZhb8CDG+Q6fGRbTZr3d0Rs/lKTiP6fTgIYUvI54Lt+lWa3YQOFHED9sda63nGj6JWE9e9z3TqKB5GhtT2+9kcNh2tFdQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433321; c=relaxed/simple;
	bh=QKr4Rs+gAqQQatqz59FAFdYXEdKMBS/5Tj+JW9ES7Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtrIsjt3p6lpM3Fw3XNT2QHWwci3iD76pe2ih0reDbyvpVFh3ThXnpVcjqgv19BDv7RNz4tHJXg05mpRgGyCIL+vHkQ7EQGcAY9CQl/lcps/AUTT4fHD5vaorpf9LlSTqN6PlZkktH+TnpzlzGAmXNitJFKP52qSucv6p8CG1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poz2q+Hf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poz2q+Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28960C19423;
	Tue, 18 Nov 2025 02:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763433320;
	bh=QKr4Rs+gAqQQatqz59FAFdYXEdKMBS/5Tj+JW9ES7Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poz2q+HfLZ5AeLzdvdPCiVrxBTBhRP//X19VDP/DNYtOjk6DDeRTZBg5x9iDRzha3
	 i62vHWpBQ98AcMHlXP3lg/6RyRCfBL9gF87iV08xBMIYYmZjtDc8KN/iUBYUhgVdw2
	 hPa7AWuMdAJh86/+dw/1KYyXsebFrb4bsGIRkSvnhIHJ8wZ/3qdkXto3BZ2iaGOlij
	 7Bxt0BU559O4u3C7XQopn82KMPyygeh0uaifUYY9nFILneoDBPObRXPYDMFdpzEACl
	 SjFuvw4ZCZwseFXGu6cBDm/I9eCOrzun6tnWQGIdyNNIUvcUewvJJovnPZlp3F2ng1
	 Kn1gD5hKXzShQ==
Date: Mon, 17 Nov 2025 18:35:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 09/10] perf stat: Read tool events last
Message-ID: <aRvbZbhcsjpCXiAU@google.com>
References: <20251113180517.44096-1-irogers@google.com>
 <20251113180517.44096-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113180517.44096-10-irogers@google.com>

On Thu, Nov 13, 2025 at 10:05:15AM -0800, Ian Rogers wrote:
> When reading a metric like memory bandwidth on multiple sockets, the
> additional sockets will be on CPUS > 0. Because of the affinity
> reading, the counters are read on CPU 0 along with the time, then the
> later sockets are read. This can lead to the later sockets having a
> bandwidth larger than is possible for the period of time. To avoid
> this moving the reading of tool events to occur after all other events
> are read.

Can you move this change before the affinity updates?  I think it's
straight-forward and can be applied independently.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 29 ++++++++++++++++++++++++++++-
>  tools/perf/util/evlist.c  |  4 ----
>  2 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 947f11b8b106..aec93b91fd11 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -379,6 +379,9 @@ static int read_counters_with_affinity(void)
>  		if (evsel__is_bpf(counter))
>  			continue;
>  
> +		if (evsel__is_tool(counter))
> +			continue;
> +
>  		if (!counter->err)
>  			counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
>  	}
> @@ -402,6 +405,24 @@ static int read_bpf_map_counters(void)
>  	return 0;
>  }
>  
> +static int read_tool_counters(void)
> +{
> +	struct evsel *counter;
> +
> +	evlist__for_each_entry(evsel_list, counter) {
> +		int idx;
> +
> +		if (!evsel__is_tool(counter))
> +			continue;
> +
> +		perf_cpu_map__for_each_idx(idx, counter->core.cpus) {
> +			if (!counter->err)
> +				counter->err = read_counter_cpu(counter, idx);
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int read_counters(void)
>  {
>  	int ret;
> @@ -415,7 +436,13 @@ static int read_counters(void)
>  		return ret;
>  
>  	// Read non-BPF and non-tool counters next.
> -	return read_counters_with_affinity();
> +	ret = read_counters_with_affinity();
> +	if (ret)
> +		return ret;
> +
> +	// Read the tool counters last. This way the duration_time counter
> +	// should always be greater than any other counter's enabled time.
> +	return read_tool_counters();
>  }
>  
>  static void process_counters(void)
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index b6df81b8a236..fc3dae7cdfca 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -368,10 +368,6 @@ static bool evlist__use_affinity(struct evlist *evlist)
>  	struct perf_cpu_map *used_cpus = NULL;
>  	bool ret = false;
>  
> -	/*
> -	 * With perf record core.user_requested_cpus is usually NULL.
> -	 * Use the old method to handle this for now.
> -	 */
>  	if (!evlist->core.user_requested_cpus ||
>  	    cpu_map__is_dummy(evlist->core.user_requested_cpus))
>  		return false;
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 
