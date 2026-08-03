Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0542FCBF;
	Mon,  3 Aug 2026 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780379; cv=none; b=dwBK4nsAB5KCz6zG6FTKPPgmfdFPEy0pucor/BQEgeuLsn/3sij/au0wdbpM9MbMyYdJWrWqAKkS007e9VRzy3X1hovPbRXnt1ZIZd5cltDy9wkSZSLefdKtI/juRHaP+HZ/Xij9Rwj7kBRH436cz/2hK54U91PMFUVZ2PEUTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780379; c=relaxed/simple;
	bh=6K2UMvnhmO84rOf45lL4Xbjamdh5YICzUmgX187EHTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXBy0zpZJ4Jo3dqmlvfWuREYADO5GmClJpvbw4X0dEAJj8/MqPbVmY+NxKakVHwMTfq38inRXEsbOSFmWa7s6bKj924lYiDKXRtIO+ETThYB1M0jOJUnBz8rQwLFxsPfruQoZqEIshJia+nzg17Y71rk2QVUvF37icjHiXDU6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJgb1IJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJgb1IJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FF41F000E9;
	Mon,  3 Aug 2026 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780378;
	bh=wk9RBIaww2EYigRcob1+IpRZm8HoD3K6FZ4xf0QADg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KJgb1IJwQjPZ/lnKDfarIaOk+hY48dKWJ5roQsZpVY2fx70V3O9ZuWfVGoopuL/YX
	 Sgygj9fw2BKm7+uZanVb/nfqKbmLGaNlI93l33AVKaCHyPgcUOkC/fywJjSLqKzS0T
	 i8cciTeQZPOYn5nUr9o0pTVZ+wnoCiBBA6LgjgaXaF2th5ErjrOPkJVqW1qHwANd+R
	 d9s5F2WV0+fzJubgh0lrJpp1QLvd2JnKuvsZv2nYaOmbxnyjK9j8/QOg53+8zPnzVa
	 ga5F5lWtHmUI79Dm/AAOjgH5eplCjPPNAeK15dg7tkjIW3BNn6Wl1+3DEJDNo3IYi/
	 OqKvOWcSbh9eg==
Date: Mon, 3 Aug 2026 11:06:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] perf sched latency: Add histogram and time
 interval options
Message-ID: <anDYmITjYFalURtB@google.com>
References: <20260802210914.199941-1-atomlin@atomlin.com>
 <20260802210914.199941-5-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260802210914.199941-5-atomlin@atomlin.com>

On Sun, Aug 02, 2026 at 05:09:14PM -0400, Aaron Tomlin wrote:
> While 'perf sched latency' reports task runtime and delay statistics
> (average and maximum delay), it does not provide a visual representation
> of how task wait times are distributed across latency ranges between
> snapshots (start and finish of the analysis window).
> 
> The --histogram option collects CPU wait latencies (time between when
> a task becomes runnable and when it gets scheduled onto a CPU) into 22
> latency buckets, displaying an ASCII bar chart distribution.
> 
> The --hist-mode option configures the bucketing scheme:
>   - log (default). Logarithmic latency buckets ranging from
>     sub-microsecond (< 1 us) up to >= 1.05 seconds
> 
>   - linear. Equal-width linear latency buckets
>     (i.e., 100 us steps up to >= 2.1 ms)
> 
> The --time option allows filtering trace event processing to a
> specific time interval [start,stop].
> 
> Example histogram output excerpt:
> 
>     ❯ sudo perf sched latency --histogram --CPU 0
> 
>      CPU Wait Latency Distribution Histogram (between snapshots) (total samples: 36114)
>      -------------------------------------------------------------------
>       Latency Range    |      Count |    Pct | Histogram Graph
>      -------------------------------------------------------------------
>       < 1 us           |         17 |   0.0% | #
>       2 - 4 us         |        673 |   1.9% | #
>       4 - 8 us         |       6237 |  17.3% | ######
>       8 - 16 us        |       3224 |   8.9% | ###
>       16 - 32 us       |       1388 |   3.8% | #
>       32 - 64 us       |        709 |   2.0% | #
>       64 - 128 us      |        690 |   1.9% | #
>       128 - 256 us     |        789 |   2.2% | #
>       256 - 512 us     |        541 |   1.5% | #
>       512 - 1024 us    |       2256 |   6.2% | ##
>       1 - 2 ms         |       3577 |   9.9% | ###
>       2 - 4 ms         |      13259 |  36.7% | ##############
>       4 - 8 ms         |       2523 |   7.0% | ##
>       8 - 16 ms        |        222 |   0.6% | #
>       16 - 32 ms       |         10 |   0.0% | #
>       >= 1.05 s        |          3 |   0.0% | #
>      -------------------------------------------------------------------
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
[SNIP] 
> @@ -1168,7 +1306,13 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
>  		atoms->max_lat_start = atom->wake_up_time;
>  		atoms->max_lat_end = timestamp;
>  	}
> +
>  	atoms->nb_atoms++;
> +
> +	b = latency_bucket(sched, delta);
> +	atoms->hist[b]++;
> +	if (strcmp(thread__comm_str(atoms->thread), "swapper"))
> +		sched->global_hist[b]++;

Why is the swapper thread not included in the global hist?

Also it's probably better to check thread__tid being 0.

>  }
>  
>  static void free_work_atoms(struct work_atoms *atoms)
[SNIP] 
> @@ -3659,6 +3831,21 @@ static int perf_sched__lat(struct perf_sched *sched)
>  	perf_sched__merge_lat(sched);
>  	perf_sched__sort_lat(sched);
>  
> +	next = rb_first_cached(&sched->sorted_atom_root);
> +	while (next) {
> +		struct work_atoms *work_list = rb_entry(next, struct work_atoms, node);
> +
> +		if (work_list->nb_atoms && strcmp(thread__comm_str(work_list->thread), "swapper"))

Ditto.  Comparing TID would be faster.

Thanks,
Namhyung


> +			break;
> +		next = rb_next(next);
> +	}
> +
> +	if (!next) {
> +		pr_info("No matching trace samples found.\n");
> +		rc = 0;
> +		goto out_free_atoms;
> +	}
