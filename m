Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C31E1E13;
	Tue, 13 May 2025 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169532; cv=none; b=uG/W0baJLeVoNz0DLohb5QuXaISaqHncM4EMn0161e6y+nkmZT2HuhIfw2+Timo97AU5gr8yLQiZPVv4iN4S3QMr9jBj5RlLk7qONg4Fx5aFP428lbHq/BZoUTq9rgtGIiJu4zglF05otFfVrLauPZ3Xm/0taByZnk/izPVyLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169532; c=relaxed/simple;
	bh=45izZRFiOaJ74+qHrbyGcZHN/6lAmsP2Y+eEWlL5m7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJX6yh9QSJficXOIdnHungcLianVZmgz0Cg9Rxfb+8P2XT4Sx4m9L+eQiNwaZlQHTOWEgzni0qkiWzQHqxgzAuGLP5wbEXfS0La5ReVo2v5NxnRXtgJI71mTgkI2O1Xgaoedw1uU5Q6xkzfGmGzJ7exS8z6GKf6Yy8usX3Uhfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9slKa/y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9slKa/y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025C4C4CEE4;
	Tue, 13 May 2025 20:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747169532;
	bh=45izZRFiOaJ74+qHrbyGcZHN/6lAmsP2Y+eEWlL5m7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9slKa/ySO302GZuBu6pmGs8ek/VS7FHeRpgdiaqTpccpjjbRWBFgKA87HweUHzv/
	 Sq/SXy+Zrt9Nk88xB4Sf5POAQH9BmNdo6PdM06Mvdf3Bc7n75ZNLpMYVnINdsIdosV
	 7z/XxHvJ3g/CljVn4j0DnA3xtmmFOlIG9+XRD5UBLT5s1p6QCrANcRXWD0K+P6Junw
	 4cubvacyWVEILth1BaTpmYTXY/ipfS11JIUmLBnoEX5l7uPqL5rE5I6WdrQyY6X+gv
	 jxQes/xMwy1JQ3ISAnM6XgaT3OST2PpysbhM2/03D0r28NjajbSv89brgd9zdQUhmf
	 4h3BC7/ppOudA==
Date: Tue, 13 May 2025 17:52:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf report: Add 'tgid' sort key
Message-ID: <aCOw-fzNUN0sh0H_@x1>
References: <20250509210421.197245-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509210421.197245-1-namhyung@kernel.org>

On Fri, May 09, 2025 at 02:04:21PM -0700, Namhyung Kim wrote:
> Sometimes we need to analyze the data in process level but current sort
> keys only work on thread level.  Let's add 'tgid' sort key for that as
> 'pid' is already taken for thread.
> 
> This will look mostly the same, but it only uses tgid instead of tid.
> Here's an example of a process with two threads (thloop).
> 
>   $ perf record -- perf test -w thloop
> 
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
> Reviewed-by: Ian Rogers <irogers@google.com>



Thanks, applied to perf-tools-next,

- Arnaldo

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-report.txt |  1 +
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/sort.c                   | 38 ++++++++++++++++++++++++
>  tools/perf/util/sort.h                   |  1 +
>  4 files changed, 41 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 3376c471057506d9..acef3ff4178eff66 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -94,6 +94,7 @@ OPTIONS
>  
>  	- comm: command (name) of the task which can be read via /proc/<pid>/comm
>  	- pid: command and tid of the task
> +	- tgid: command and tgid of the task
>  	- dso: name of library or module executed at the time of sample
>  	- dso_size: size of library or module executed at the time of sample
>  	- symbol: name of function executed at the time of sample
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 355198fd70281f43..c64254088fc77246 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -42,6 +42,7 @@ enum hist_column {
>  	HISTC_TIME,
>  	HISTC_DSO,
>  	HISTC_THREAD,
> +	HISTC_TGID,
>  	HISTC_COMM,
>  	HISTC_CGROUP_ID,
>  	HISTC_CGROUP,
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 8efafa7c10822ee9..45e6546539600a46 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -141,6 +141,43 @@ struct sort_entry sort_thread = {
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
> +	/* display comm of the thread-group leader */
> +	if (thread__pid(he->thread) == thread__tid(he->thread)) {
> +		comm = thread__comm_str(he->thread);
> +	} else {
> +		struct maps *maps = thread__maps(he->thread);
> +		struct thread *leader = machine__find_thread(maps__machine(maps),
> +							     tgid, tgid);
> +		if (leader) {
> +			comm = thread__comm_str(leader);
> +			thread__put(leader);
> +		}
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
> @@ -2508,6 +2545,7 @@ static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
>  
>  static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_PID, "pid", sort_thread),
> +	DIM(SORT_TGID, "tgid", sort_tgid),
>  	DIM(SORT_COMM, "comm", sort_comm),
>  	DIM(SORT_DSO, "dso", sort_dso),
>  	DIM(SORT_SYM, "symbol", sort_sym),
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 6e92ac62b9c80a0b..a742ab7f3c677f48 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -73,6 +73,7 @@ enum sort_type {
>  	SORT_SYM_OFFSET,
>  	SORT_ANNOTATE_DATA_TYPE_CACHELINE,
>  	SORT_PARALLELISM,
> +	SORT_TGID,
>  
>  	/* branch stack specific sort keys */
>  	__SORT_BRANCH_STACK,
> -- 
> 2.49.0.1015.ga840276032-goog
