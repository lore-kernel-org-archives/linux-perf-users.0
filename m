Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED698276038;
	Thu,  9 Oct 2025 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989494; cv=none; b=nU+WsN8+OKUnqN7KDGY+jw3faZMBxEpRWhIUTRinWd5J7SqapsjN+PKsbEU9wgrIswWNDMAdTM5fFVb6uNxnF8nXE+mmC55cJoxBlUiMkFtcE/zs21hEbBztmkQQT85IbffQKL8HhpfmgZYXdOwBXXNhp3OZ7CBsM7QdMlAIGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989494; c=relaxed/simple;
	bh=1A3SXpIZU25uw5qjlzvrIPAeI2fzg4oWZW/VfTtyyZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXtFEllhCkJDWBOenD2WzcIUHYTxoxuGdz6WbD9XhV0+jzZiyZym2n1AIbAPdATblQcjWpetn2t3h+U1kOHEzzRyCWFvwxghKb9NVmQSE6JxT1t8hhcwLs/geJMhYFUEADcoQS+EptIDqQkLUdHD+I1qMkVpbuFomyjegcpj7kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaGsPBmo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaGsPBmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F89AC4CEE7;
	Thu,  9 Oct 2025 05:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759989493;
	bh=1A3SXpIZU25uw5qjlzvrIPAeI2fzg4oWZW/VfTtyyZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaGsPBmodXbaga1PrzcVUqp9/E1Cg1E49jQt/SERcJpHH4YoW69NJTJGRIOH1MEm/
	 ek1WHMVz9Cv4bJLwiSV7i+KcER7eSPtM5R2VL72RXjJJM4pcq2I4+JMTxfnd5W5nyO
	 gtji2IGN+Glwtv0eZEk/sMiEJQIFMfeqyXAS6Ig+pUDM5+gHmuZTKiHg7wMJxYELS2
	 ArtC9RJLwDYi5Chz6P7VQ/zTGP8H5ndpzuLHRss1qhvJ4rUF4Br8fxoGFdE0PuMGtN
	 9EZWPjvWtpgvT0SgUjBjl+zIsFMT1CLebqMJe/KXb0qDB0BlN7XF2MEgheiVAsy7D1
	 9jsUSIFyf0EbA==
Date: Thu, 9 Oct 2025 14:58:09 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf bpf_counter: Fix opening of "any"(-1) CPU events
Message-ID: <aOdO8beKmaY8M5Ir@google.com>
References: <20251008162347.4005288-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251008162347.4005288-1-irogers@google.com>

On Wed, Oct 08, 2025 at 09:23:47AM -0700, Ian Rogers wrote:
> The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
> wanting to aggregate a count against a CPU, which avoids the need for
> atomics so let's not change that. Force evsels used for BPF counters
> to require a CPU when not in system-wide mode so that the "any"(-1)
> value isn't used during map propagation and evsel's CPU map matches
> that of the PMU.
> 
> Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing hybrid")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     | 13 +++++++++++++
>  tools/perf/util/bpf_counter.c |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7006f848f87a..0fc6884c1bf1 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2540,6 +2540,7 @@ int cmd_stat(int argc, const char **argv)
>  	unsigned int interval, timeout;
>  	const char * const stat_subcommands[] = { "record", "report" };
>  	char errbuf[BUFSIZ];
> +	struct evsel *counter;
>  
>  	setlocale(LC_ALL, "");
>  
> @@ -2797,6 +2798,18 @@ int cmd_stat(int argc, const char **argv)
>  
>  	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
>  
> +	evlist__for_each_entry(evsel_list, counter) {
> +		/*
> +		 * Setup BPF counters to require CPUs as any(-1) isn't
> +		 * supported. evlist__create_maps below will propagate this
> +		 * information to the evsels. Note, evsel__is_bperf isn't yet
> +		 * set up, and this change must happen early, so directly use
> +		 * the bpf_counter variable.
> +		 */
> +		if (counter->bpf_counter)

Is it set for --bpf-counters as well?

What about this?

		if ((counter->bpf_counter || target.use_bpf) &&
		    !target__has_cpu())

Thanks,
Namhyung

> +			counter->core.requires_cpu = true;
> +	}
> +
>  	if (evlist__create_maps(evsel_list, &target) < 0) {
>  		if (target__has_task(&target)) {
>  			pr_err("Problems finding threads of monitor\n");
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index ca5d01b9017d..d3e5933b171b 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -495,6 +495,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>  	 * following evsel__open_per_cpu call
>  	 */
>  	evsel->leader_skel = skel;
> +	assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
>  	evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
>  
>  out:
> -- 
> 2.51.0.710.ga91ca5db03-goog
> 
