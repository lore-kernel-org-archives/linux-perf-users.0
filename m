Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363373E5571;
	Tue, 19 May 2026 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226177; cv=none; b=suVcTMzIKAtgs5/teu9dmPktn4X2l/jUW8kF/4wjNdsLGlLyZnB32ZyRd5mrNfG22fFoQ5JAoq55oFUlW1c35ojkURxwhKpuP/E6lW571aG4y0LLy04Ysj1lnDF5QwnQ7ywJeXo1RQEkMKGlhwshnirNBrlPpNq9dpjOD6178NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226177; c=relaxed/simple;
	bh=HsV1ptmFFlZpaqvCtKkO+i2xNb7DCAe/MNw7jm8PDko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFnpbkuTRFyhKVt1ho2zYcypDUb61U7F3WyC+uai2ElfWKyI3dkpiKCD7T5C3LDw0FD0FQgB/GLL8pgXH5SKsia8PoyF9BieibJHhkE6W70WdH/yVSElRNYQ0zvRIh/QGzpvR32HQWLulgxMSkvk4pSSWHMyJD4PexgHdsmFrLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFGw8D72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFGw8D72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE651F000E9;
	Tue, 19 May 2026 21:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779226176;
	bh=iPIOcafaNOiNRKA24JL2Ev1fD8cHmWcx6Ouavo8TZig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MFGw8D72l1csYI5TVUnDOKTcy04GnS0jA6FhyD31n+sBJdHdB5UUPGpPRbAsF/HJ2
	 UJClSAEF09FK65Dr6/jRuqrUuNfCu+0PozV/4jrUMmHL5PTmLnIfMx/Qka61Ubtz2r
	 JMSGoOtgQnnzWEBGoZiiwPjb9MPTu2Zc+kBVdbzgryPtQfErJ0VfB1/ahGrDwvMxYo
	 0t6OF1MZ4HXVB2vNxpBjliS5j1Z4URd5dCx37pGl3tZ20PoJCjX0vmcorkAT3GwaH9
	 g9jYFunVYRWpR1HnWrpUN3mJ6I4U51iObO8II/+D83leXHxOw3+g1NxoakcI6kWi2O
	 AIDQdDAiyXs2g==
Date: Tue, 19 May 2026 14:29:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v13 13/32] perf kmem: Don't pass evsel with sample
Message-ID: <agzWPecR0C0el3Ua@google.com>
References: <20260413041143.1736055-1-irogers@google.com>
 <20260512223001.2952848-1-irogers@google.com>
 <20260512223001.2952848-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512223001.2952848-14-irogers@google.com>

On Tue, May 12, 2026 at 03:29:42PM -0700, Ian Rogers wrote:
> The sample contains the evsel and so it is unnecessary to pass the
> evsel as well.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-kmem.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 2cdc56bc2616..68a39f56204d 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -171,7 +171,7 @@ static int insert_caller_stat(unsigned long call_site,
>  	return 0;
>  }
>  
> -static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_alloc_event(struct perf_sample *sample)
>  {
>  	unsigned long ptr = perf_sample__intval(sample, "ptr"),
>  		      call_site = perf_sample__intval(sample, "call_site");
> @@ -198,7 +198,7 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
>  	 * If the tracepoint contains the field "node" the tool stats the
>  	 * cross allocation.
>  	 */
> -	if (evsel__field(evsel, "node")) {
> +	if (evsel__field(sample->evsel, "node")) {
>  		int node1, node2;
>  
>  		node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu});
> @@ -243,7 +243,7 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
>  	return NULL;
>  }
>  
> -static int evsel__process_free_event(struct evsel *evsel __maybe_unused, struct perf_sample *sample)
> +static int evsel__process_free_event(struct perf_sample *sample)
>  {
>  	unsigned long ptr = perf_sample__intval(sample, "ptr");
>  	struct alloc_stat *s_alloc, *s_caller;
> @@ -751,8 +751,7 @@ static char *compact_gfp_string(unsigned long gfp_flags)
>  	return NULL;
>  }
>  
> -static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
> -			   unsigned int gfp_flags)
> +static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
>  {
>  	struct tep_record record = {
>  		.cpu = sample->cpu,
> @@ -773,7 +772,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
>  	}
>  
>  	trace_seq_init(&seq);
> -	tp_format = evsel__tp_format(evsel);
> +	tp_format = evsel__tp_format(sample->evsel);
>  	if (tp_format)
>  		tep_print_event(tp_format->tep, &seq, &record, "%s", TEP_PRINT_INFO);
>  
> @@ -805,7 +804,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
>  	return 0;
>  }
>  
> -static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_page_alloc_event(struct perf_sample *sample)
>  {
>  	u64 page;
>  	unsigned int order = perf_sample__intval(sample, "order");
> @@ -835,7 +834,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
>  		return 0;
>  	}
>  
> -	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
> +	if (parse_gfp_flags(sample, gfp_flags) < 0)
>  		return -1;
>  
>  	callsite = find_callsite(sample);
> @@ -876,8 +875,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
>  	return 0;
>  }
>  
> -static int evsel__process_page_free_event(struct evsel *evsel __maybe_unused,
> -					  struct perf_sample *sample)
> +static int evsel__process_page_free_event(struct perf_sample *sample)
>  {
>  	u64 page;
>  	unsigned int order = perf_sample__intval(sample, "order");
> @@ -954,8 +952,7 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
>  	return false;
>  }
>  
> -typedef int (*tracepoint_handler)(struct evsel *evsel,
> -				  struct perf_sample *sample);
> +typedef int (*tracepoint_handler)(struct perf_sample *sample);
>  
>  static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  				union perf_event *event,
> @@ -973,14 +970,15 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  		return -1;
>  	}
>  
> -	if (perf_kmem__skip_sample(sample))
> +	if (perf_kmem__skip_sample(sample)) {
>  		return 0;
> +	}

Nit: unnecessary change.

Thanks,
Namhyung

>  
>  	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread__tid(thread));
>  
>  	if (evsel->handler != NULL) {
>  		tracepoint_handler f = evsel->handler;
> -		err = f(evsel, sample);
> +		err = f(sample);
>  	}
>  
>  	thread__put(thread);
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
