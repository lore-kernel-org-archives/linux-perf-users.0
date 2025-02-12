Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979520103D;
	Wed, 12 Feb 2025 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394328; cv=none; b=e+1ZWqM+K5xrcYGQ/rxtk/NT2ksbYzqFVYqTJkfMwSwCk4dY61mrQ7lXGzlSSkrfC/NqWKzkAgFoo/lvdTRaCsO9U1b9Gd6VZHDXERBaV7xYj4497Zvy4N/3qLetDUfL/ae5BgzYyRtBqXVXlTgzFp1I+v4iifQaj3NflJI49is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394328; c=relaxed/simple;
	bh=rL7TUlmSRX70EhZ0iEizH9XJp7ESxgFJhna1vEGCHBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROuNJmmzq1Hok5/XIaY8xEksCnSu40wsRIj6btDZv30wVmNovohZDa73Wewb0pTMhiBLk6WZi5b4Kyb++9VzzykSONG4Kui+d7Srwagca1qjwxgiNbAapqLCR+D3OLBadvbUp1rSrMHDupaDN15HbmWdzX+30HU+kQ7VHm43EwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnyaDuyZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnyaDuyZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CCAC4CEDF;
	Wed, 12 Feb 2025 21:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739394327;
	bh=rL7TUlmSRX70EhZ0iEizH9XJp7ESxgFJhna1vEGCHBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnyaDuyZIIOLvz4y78Ap5M3n2l0VYwRwxXHRSzhnr9adPQllPBnGjLK8gTyh1/U4X
	 tjSiPNVb2k9N8y3LYZ2kuLInrp/SG4w55BRqVBSG65JMXsLdQ4e6OkqIAdmaGGZRVm
	 8iKgZaFTXnepJnmB90VFT1eaYSYypJ+Clsc+RLn2F1C7BcuKBvRm4Tt0TXJqfSxRFK
	 jOvct2Vy7HU0MigIgRg+Nmf23su2FRe16m1A7ts6MnNFwQ7UauTEHaUjb3TOZkAkQ1
	 15j0eC+OeMjRqd+KNTOzHlybzUiEeLHY2+dAZv9+hxPPq9UKB7dM4Ubh5Uoa+4vair
	 hTWMp2AClduxw==
Date: Wed, 12 Feb 2025 22:05:24 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z60NFEAf2C8cL8Xh@x1>
References: <20250206000137.2026034-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206000137.2026034-1-namhyung@kernel.org>

On Wed, Feb 05, 2025 at 04:01:37PM -0800, Namhyung Kim wrote:
> Sometimes we need to analyze the data in process level but current sort
> keys only work on thread level.  Let's add 'tgid' sort key for that as
> 'pid' is already taken for thread.
> 
> This will look mostly the same, but it only uses tgid instead of tid.
> Here's an example of a process with two threads (thloop).
> 
>   $ perf record -- perf test -w thloop

Unrelated, but when building perf with DEBUG=1 and trying to test the
above I noticed:

root@number:~# perf record -- perf test -w thloop
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.404 MB perf.data (7968 samples) ]
perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
Aborted (core dumped)
root@number:~# perf record -- perf test -w offcpu
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.040 MB perf.data (23 samples) ]
perf: util/maps.c:95: check_invariants: Assertion `map__end(prev) <= map__end(map)' failed.
Aborted (core dumped)
root@number:~#

I have:

⬢ [acme@toolbox perf-tools-next]$ git log --oneline perf-tools-next/perf-tools-next..
9de1ed6fa3b73cb1 (HEAD -> perf-tools-next) perf report: Add 'tgid' sort key
23e98ede2a353530 perf trace: Add --summary-mode option
e6d6104625a3790b perf tools: Get rid of now-unused rb_resort.h
173ec14e72ef4ed7 perf trace: Convert syscall_stats to hashmap
66edfb5d404e743d perf trace: Allocate syscall stats only if summary is on
ca6637e1ea08e6f4 perf parse-events filter: Use evsel__find_pmu()
bd1ac4a678f7f2c8 perf bench evlist-open-close: Reduce scope of 2 variables
cd59081880e89df8 perf test: Add direct off-cpu test
56cbd794c0c46ba9 perf record --off-cpu: Add --off-cpu-thresh option
28d9b19c5455556f perf record --off-cpu: Dump the remaining samples in BPF's stack trace map
2bc05b02743b50a7 perf script: Display off-cpu samples correctly
bfa457a621596947 perf record --off-cpu: Disable perf_event's callchain collection
eca732cc42d20266 perf evsel: Assemble offcpu samples
74ce50e40c569e90 perf record --off-cpu: Dump off-cpu samples in BPF
e75f8ce63bfa6cb9 perf record --off-cpu: Preparation of off-cpu BPF program
0ffab9d26971c91c perf record --off-cpu: Parse off-cpu event
efc3fe2070853b7d perf evsel: Expose evsel__is_offcpu_event() for future use
⬢ [acme@toolbox perf-tools-next]$

locally, that is the stuff I've been testing lately, doubt it is related
to these patches, I'll investigate later, have to go AFK, so FWIW as a
heads up.

- Arnaldo

>   $ perf report --stdio -s tgid,pid -H
>   ...
>   #
>   #    Overhead  Tgid:Command / Pid:Command
>   # ...........  ..........................
>   #
>      100.00%     2018407:perf
>          50.34%     2018407:perf
>          49.66%     2018409:perf
> 
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-report.txt |  1 +
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/sort.c                   | 35 ++++++++++++++++++++++++
>  tools/perf/util/sort.h                   |  1 +
>  4 files changed, 38 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 87f86451940623f3..4050ec4038425bf0 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -79,6 +79,7 @@ OPTIONS
>  
>  	- comm: command (name) of the task which can be read via /proc/<pid>/comm
>  	- pid: command and tid of the task
> +	- tgid: command and tgid of the task
>  	- dso: name of library or module executed at the time of sample
>  	- dso_size: size of library or module executed at the time of sample
>  	- symbol: name of function executed at the time of sample
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 46c8373e314657fa..c164e178e0a48a8e 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -38,6 +38,7 @@ enum hist_column {
>  	HISTC_TIME,
>  	HISTC_DSO,
>  	HISTC_THREAD,
> +	HISTC_TGID,
>  	HISTC_COMM,
>  	HISTC_CGROUP_ID,
>  	HISTC_CGROUP,
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 3dd33721823f365d..5987438174967fd6 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -141,6 +141,40 @@ struct sort_entry sort_thread = {
>  	.se_width_idx	= HISTC_THREAD,
>  };
>  
> +/* --sort tgid */
> +
> +static int64_t
> +sort__tgid_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return thread__pid(right->thread) - thread__pid(left->thread);
> +}
> +
> +static int hist_entry__tgid_snprintf(struct hist_entry *he, char *bf,
> +				       size_t size, unsigned int width)
> +{
> +	int tgid = thread__pid(he->thread);
> +	const char *comm = NULL;
> +
> +	if (thread__pid(he->thread) == thread__tid(he->thread)) {
> +		comm = thread__comm_str(he->thread);
> +	} else {
> +		struct maps *maps = thread__maps(he->thread);
> +		struct thread *leader = machine__find_thread(maps__machine(maps),
> +							     tgid, tgid);
> +		if (leader)
> +			comm = thread__comm_str(leader);
> +	}
> +	width = max(7U, width) - 8;
> +	return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, width, comm ?: "");
> +}
> +
> +struct sort_entry sort_tgid = {
> +	.se_header	= "   Tgid:Command",
> +	.se_cmp		= sort__tgid_cmp,
> +	.se_snprintf	= hist_entry__tgid_snprintf,
> +	.se_width_idx	= HISTC_TGID,
> +};
> +
>  /* --sort simd */
>  
>  static int64_t
> @@ -2501,6 +2535,7 @@ static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
>  
>  static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_PID, "pid", sort_thread),
> +	DIM(SORT_TGID, "tgid", sort_tgid),
>  	DIM(SORT_COMM, "comm", sort_comm),
>  	DIM(SORT_DSO, "dso", sort_dso),
>  	DIM(SORT_SYM, "symbol", sort_sym),
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index a8572574e1686be6..6044eb1d61447c0d 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -72,6 +72,7 @@ enum sort_type {
>  	SORT_ANNOTATE_DATA_TYPE_OFFSET,
>  	SORT_SYM_OFFSET,
>  	SORT_ANNOTATE_DATA_TYPE_CACHELINE,
> +	SORT_TGID,
>  
>  	/* branch stack specific sort keys */
>  	__SORT_BRANCH_STACK,
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
