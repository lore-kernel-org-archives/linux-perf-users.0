Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5377202C20;
	Wed, 12 Feb 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393436; cv=none; b=cspGX8JUtGBX6fwLzcIOkKXEZvMz0YRJ14LoSqk2IFZYgi9Nwg+9QOTysma4oT1UAIgHGdEw+7zXBzdGiaV5MNo+ZhXmlF4J/JAzBypZlFXJkll+CpgG+on/3MbJiFyLDEMWS8BySwfZGJSEoWsPx7S9qTplE1+ftdfJXA7LMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393436; c=relaxed/simple;
	bh=VUwLi8iAajOB4PfImJFtVxHjxtjmufutD6oNeB9QrRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohN+P3ceI/0B++X/681SJA7T8xFmJRMYGdYkibadRBg0ZfGEXxNKdj4TI+izE0MaObEE1ssnBU3KjeqVqTWxRg0EuMEN9DxbvWlCOjmWadHOyC3uv4frbVgS8hk3HcwClF5rByP8Q69QA0k2CwtXtS6UQ15pWoEld9kQifNfloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARCjO6N6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARCjO6N6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39BEC4CEDF;
	Wed, 12 Feb 2025 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739393436;
	bh=VUwLi8iAajOB4PfImJFtVxHjxtjmufutD6oNeB9QrRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARCjO6N69CR89sxFx4HUIdO/kMuvww42fADYY8wNtWRvkU+nRZcrG+rMHk2KbX8k6
	 V7yUESEp11EgSgYgJaRZhnbwLTf3f4E7k6CrAREgDc4NoDfAQfxf8wPlwT8KhX0vsW
	 Xg0GjeNZmrYPz5Cr8RGNCAm5U08wgFkh2UHnJcQs7yYVP2xyuOmOIovyweI9hQhbPC
	 ZkEhf1UzVWV6zqFEpEPOZwvNzrkDhR2kccp4tqN8/Cti8auCirqDuIwpRsFFWT0wV3
	 WXGSFUQLbdexY73S6cxjkITB390jCUvOz0CI3O/chZl7i7+MCEk/ALGIdzDWmQauxm
	 SrbeMrCR/ISBg==
Date: Wed, 12 Feb 2025 21:50:32 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Wander Costa <wcosta@redhat.com>
Subject: Re: [PATCH v3 1/4] perf trace: Allocate syscall stats only if
 summary is on
Message-ID: <Z60JmMKq-Do-VBUn@x1>
References: <20250205205443.1986408-1-namhyung@kernel.org>
 <20250205205443.1986408-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205205443.1986408-2-namhyung@kernel.org>

On Wed, Feb 05, 2025 at 12:54:40PM -0800, Namhyung Kim wrote:
> The syscall stats are used only when summary is requested.  Let's avoid
> unnecessary operations.  While at it, let's pass 'trace' pointer
> directly instead of passing 'output' file pointer and 'summary' option
> in the 'trace' separately.

root@number:~# perf probe -x ~/bin/perf intlist__new
Added new event:
  probe_perf:intlist_new (on intlist__new in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:intlist_new -aR sleep 1

root@number:~# perf trace -e probe_perf:intlist_new perf trace -e *nanosleep sleep 1
     0.000 (1000.184 ms): sleep/574971 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffda05c1be0) = 0
root@number:~# perf trace -e probe_perf:intlist_new perf trace -e *nanosleep --summary sleep 1
     0.000 :574984/574984 probe_perf:intlist_new(__probe_ip: 6861748)

 Summary of events:

 sleep (574985), 2 events, 25.0%

   syscall            calls  errors  total       min       avg       max       stddev
                                     (msec)    (msec)    (msec)    (msec)        (%)
   --------------- --------  ------ -------- --------- --------- ---------     ------
   clock_nanosleep        1      0  1000.205  1000.205  1000.205  1000.205      0.00%

root@number:~#

I'm trying to convince a colleague to have this short streamlined to
something like:

  # perf trace -e ~/bin/perf/intlist_new()/ perf trace -e *nanosleep sleep 1

Or some other event syntax that allows us to specify compactly and
unambiguously that we want to put a probe if one isn't there yet and
inside the () to specify which of the arguments we want collected, etc,
to save the 'perf probe' step, adding the probe and removing it if it
isn't there or reusing a pre-existing, compatible one.

Anyway, for the patch tested:

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Acked-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ac97632f13dc8f7c..7e0324a2e9182088 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1522,13 +1522,14 @@ struct thread_trace {
>  	struct intlist *syscall_stats;
>  };
>  
> -static struct thread_trace *thread_trace__new(void)
> +static struct thread_trace *thread_trace__new(struct trace *trace)
>  {
>  	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
>  
>  	if (ttrace) {
>  		ttrace->files.max = -1;
> -		ttrace->syscall_stats = intlist__new(NULL);
> +		if (trace->summary)
> +			ttrace->syscall_stats = intlist__new(NULL);
>  	}
>  
>  	return ttrace;
> @@ -1550,7 +1551,7 @@ static void thread_trace__delete(void *pttrace)
>  	free(ttrace);
>  }
>  
> -static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
> +static struct thread_trace *thread__trace(struct thread *thread, struct trace *trace)
>  {
>  	struct thread_trace *ttrace;
>  
> @@ -1558,7 +1559,7 @@ static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
>  		goto fail;
>  
>  	if (thread__priv(thread) == NULL)
> -		thread__set_priv(thread, thread_trace__new());
> +		thread__set_priv(thread, thread_trace__new(trace));
>  
>  	if (thread__priv(thread) == NULL)
>  		goto fail;
> @@ -1568,7 +1569,7 @@ static struct thread_trace *thread__trace(struct thread *thread, FILE *fp)
>  
>  	return ttrace;
>  fail:
> -	color_fprintf(fp, PERF_COLOR_RED,
> +	color_fprintf(trace->output, PERF_COLOR_RED,
>  		      "WARNING: not enough memory, dropping samples!\n");
>  	return NULL;
>  }
> @@ -2622,7 +2623,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  		return -1;
>  
>  	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
> -	ttrace = thread__trace(thread, trace->output);
> +	ttrace = thread__trace(thread, trace);
>  	if (ttrace == NULL)
>  		goto out_put;
>  
> @@ -2699,7 +2700,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
>  		return -1;
>  
>  	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
> -	ttrace = thread__trace(thread, trace->output);
> +	ttrace = thread__trace(thread, trace);
>  	/*
>  	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
>  	 * and the rest of the beautifiers accessing it via struct syscall_arg touches it.
> @@ -2771,7 +2772,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
>  		return -1;
>  
>  	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
> -	ttrace = thread__trace(thread, trace->output);
> +	ttrace = thread__trace(thread, trace);
>  	if (ttrace == NULL)
>  		goto out_put;
>  
> @@ -2960,7 +2961,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
>  	struct thread *thread = machine__findnew_thread(trace->host,
>  							sample->pid,
>  							sample->tid);
> -	struct thread_trace *ttrace = thread__trace(thread, trace->output);
> +	struct thread_trace *ttrace = thread__trace(thread, trace);
>  
>  	if (ttrace == NULL)
>  		goto out_dump;
> @@ -3214,7 +3215,7 @@ static int trace__pgfault(struct trace *trace,
>  		}
>  	}
>  
> -	ttrace = thread__trace(thread, trace->output);
> +	ttrace = thread__trace(thread, trace);
>  	if (ttrace == NULL)
>  		goto out_put;
>  
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
