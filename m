Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6E101EE;
	Thu, 26 Sep 2024 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727328595; cv=none; b=AkTG2Y1aJUTXOWRHO/EcmFFhvajv2+Faqp97T2qCD6IdLsfRrvMNCj4MsWowf+BF1G7NNOXv3fB/jLkRazz3gnzatW9vb2SmkRObbXubLaGDCih6n+LMPFjDQhmf/x+KgF5DuQWuN9wikiVzWSN+7BlqotCvqCN3M4I4eHwNIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727328595; c=relaxed/simple;
	bh=REew6xXOENI9VHTFXgTcUmyaGcQo+B+fjty0o+i0lFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYcH//inXqx+EkqdoTdVG3qNUzE9VhJ+Sp0Qc/uZgdwYAm6dU9Aa0vtDTtHqfOojtI0R/1jqy71ZGhph/TIFk2L1Nl+7wtn6RmpQCLZfG6Cb1BN8A+fvpzXYGhMCZKPYOWLXvdcr+3kid91g5hD2cPB8fPtM4cp2yWa3nIJyfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQA/5T4/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQA/5T4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8864AC4CEC5;
	Thu, 26 Sep 2024 05:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727328595;
	bh=REew6xXOENI9VHTFXgTcUmyaGcQo+B+fjty0o+i0lFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQA/5T4/EJIWMRVdrgO/TMXzcRKphD6lwSjh++DVTI1cF7IrOJt/ReJPl7g7vHHTA
	 uEB+KAdsDkP+pfQVHezwtI95OtH0NW3vhgvNIMfg75dfKaIrcldej5Nx1/klPfsTRY
	 DCIdz7t0BRySuYF/yiazYy/mfNc/zTd13+/DbgtHUyFX3DeEW/PwtLgHvnOB+WA/K9
	 pdOnCGojjHCjyJvXP0DLUFu4XR4UDjVckobNT9L3fLa1NyfMHetoLq0LNHH2StXpQh
	 f9B/2NIv4IcuzHMhhXf+sr2D0NbsRvbQYU2zS4slP7Qye/EyfDsH/uKpXVmr3+/Zir
	 DoP1V4DQN61SA==
Date: Wed, 25 Sep 2024 22:29:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] libperf: Add perf_evsel__id() function
Message-ID: <ZvTxUXoyIO8Z_9xp@google.com>
References: <20240909-perf_evsel_get_id-v2-1-b26eae02f606@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240909-perf_evsel_get_id-v2-1-b26eae02f606@rivosinc.com>

Hello Charlie,

Sorry for the late reply.

On Mon, Sep 09, 2024 at 11:26:52PM -0700, Charlie Jenkins wrote:
> Introduce perf_evsel__id() to collect the id of an evsel. This allows
> applications to determine the allocated id of an evsel for each fd. The
> "ids" argument is expected to be an array the size of the number of open
> fd's for the evsel.  This will allow applications to link the id
> returned by PERF_SAMPLE_ID to the event being sampled.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v2:
> - Replaced id argument with array of ids for perf_evsel__id() to support
>   the id for each fd.
> - Link to v1: https://lore.kernel.org/r/20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com
> ---
>  tools/lib/perf/Documentation/libperf.txt |  2 ++
>  tools/lib/perf/evsel.c                   | 10 ++++++++++
>  tools/lib/perf/include/perf/evsel.h      |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index fcfb9499ef9c..754c103f7b13 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -94,6 +94,8 @@ SYNOPSIS
>    void perf_evlist__enable(struct perf_evlist *evlist);
>    void perf_evlist__disable(struct perf_evlist *evlist);
>  
> +  void perf_evsel__id(struct perf_evsel *evsel, __u64 ids[]);
> +
>    #define perf_evlist__for_each_evsel(evlist, pos)
>  
>    void perf_evlist__set_maps(struct perf_evlist *evlist,
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index c07160953224..d10dfcb605ba 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -484,6 +484,16 @@ int perf_evsel__disable(struct perf_evsel *evsel)
>  	return err;
>  }
>  
> +int perf_evsel__id(struct perf_evsel *evsel, __u64 ids[])
> +{
> +	int i;
> +	int err = 0;
> +
> +	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> +		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ID, (unsigned long)&ids[i], i);

This won't work correctly since perf_evsel__run_ioctl() has a loop
inside.  You should traverse xyarray correctly.

Now I think about the interface and it should look like this.

  struct perf_cpu_map *cpus = perf_evsel__cpus(evsel);
  struct perf_thread_map *threads = perf_evsel__threads(evsel);
  int x, y;
  u64 id;

  for (x = 0; x < perf_cpu_map__nr(cpus); x++) {
    for (y = 0; y < perf_thread_map__nr(threads); y++)
      perf_evsel__get_id(evsel, x, y, &id);
  }

I also found there's perf_evsel__{alloc,free}_id() but it doesn't seem
like to be exposed as API.  Maybe we can just use it internally to run
the ioctl and save the result.

Also it has the sample_id xyarray and id array (with ids size) but I
think they are the same and we need to get rid of one.

This is the implementation details and can be done separately.  For now
you can simply do like below:

  int perf_evsel__get_id(struct perf_evsel *evsel, int cpu_map_idx, int thread, u64 *id)
  {
      return perf_evsel__ioctl(evsel, PERF_EVENT_IOC_ID, id, cpu_map_idx, thread);
  }

Thanks,
Namhyung


> +	return err;
> +}
> +
>  int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
>  {
>  	int err = 0, i;
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 6f92204075c2..13f19189839a 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -41,6 +41,7 @@ LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx
>  LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
>  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> +LIBPERF_API int perf_evsel__id(struct perf_evsel *evsel, __u64 ids[]);
>  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
>  LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
>  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> 
> ---
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> change-id: 20240822-perf_evsel_get_id-f7e11f15504b
> -- 
> - Charlie
> 
