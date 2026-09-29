Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3A38DC78;
	Tue, 29 Sep 2026 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725696; cv=none; b=s0H1SHj1rmGduMpKZOVfg7ZonrClKnIMeMCXHf1DgpZVk07FaPXoctD/V4V4/0vJ0ASwaRefmXjT13L533ajEe3hzltM2uqZbjwR1f+aCLTH8rZPlN3kGVN3WZxU0q3+sD0FLsyxFJDuJrDWCK18HewENRNbi+835+BmuRqcrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725696; c=relaxed/simple;
	bh=IeLpjxVDA3GrnDgmvTeCyQjgNOUdg4es+X/2CCUKubU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9bb/sYsMvtW0QHTihBDp+BR0u1EJeDa/s8EthtidHeqLJ44SWRbzgvRXiXCheLh+by1WhgCZSjk5lWZw+MR63xYjp6bnUDxPKwkcitKSB7KzDwPH9ZjnrCK+CDTgNIorCtBFV61uG7aC3YjxDHW0gSetbUtsgx3WW8foqJPN1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhzkGaRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhzkGaRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4E61F000FF;
	Tue, 29 Sep 2026 23:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790725694;
	bh=gIqFVKJu6AToIPs1PJ0I4keo47YZu7KeaLmxN+BVCuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VhzkGaReqEEO2XgPU/r2WxwZs5SREUmfSQgiINcUoXIv8bBkXCl/itC0FnAJhcF8n
	 Tz+4njQV8/Wgfcl43M937K7PtNuNSkcGEXjt3HUaVepxjLJcyrhqL2+36zcl7IyBHH
	 jbsE8zfLCs6qhqBfgUTtJhqNRxkRwcsi184Gp+TemzUMEBuS628poVt66JzIIL4yry
	 49uRU97VXmCzeR4F6TYSr2gMQFr2uHv8fjuk9UI29dF4bxd8hN+WyweFY7EjOE8Txh
	 dAUolPFB7vgrvHbuKDJpZODJWAwXCrV7wIX0Q45KTU1L0jJ2Wr8fVUtoAdNoCM8sFE
	 0quruYrLofanw==
Date: Tue, 29 Sep 2026 16:48:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 3/5] perf report: Add --no-progress option
Message-ID: <arxOPEU1bCePHzVx@google.com>
References: <20260929212246.2532021-1-acme@kernel.org>
 <20260929212246.2532021-4-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929212246.2532021-4-acme@kernel.org>

On Tue, Sep 29, 2026 at 11:22:44PM +0200, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Add the counterpart of --progress: the TUI and GTK browsers present
> progress of their own and there is no way to turn it off, while the
> option just added allows asking for it when there is none.  Install the
> no-op ui_progress ops, the ones already used until a backend sets
> theirs, after setup_browser() installed them.  The phases are still
> counted, nothing is shown for them, and --no-progress takes precedence
> over --progress.

Hmm.. I mean --progress already gives --no-progress for free.  We just
need to handle that for TUI and GTK.

Thanks,
Namhyung

> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Documentation/perf-report.txt |  5 +++++
>  tools/perf/builtin-report.c              | 17 ++++++++++++++---
>  tools/perf/ui/progress.c                 |  6 ++++++
>  tools/perf/ui/progress.h                 |  2 ++
>  4 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index a7429a30ec28f903..bc0f2031b100f425 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -43,6 +43,11 @@ OPTIONS
>  	present progress information, or when --quiet is used, that asks
>  	for no messages at all.
>  
> +--no-progress::
> +	Do not show progress while processing the perf.data file.  It
> +	also turns off the progress the TUI and GTK browsers present,
> +	which is their own, and takes precedence over --progress.
> +
>  -n::
>  --show-nr-samples::
>  	Show the number of samples for each symbol
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 963808b561e547c3..8d23c077fab5f874 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -88,6 +88,7 @@ struct report {
>  #endif
>  	bool			use_stdio;
>  	bool			progress;
> +	bool			no_progress;
>  	bool			show_full_info;
>  	bool			show_threads;
>  	bool			inverted_callchain;
> @@ -1385,8 +1386,16 @@ int cmd_report(int argc, const char **argv)
>  		    "Use the stdio interface"),
>  	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
>  			"Show or hide weight columns in annotation. Default show if non-zero."),
> -	OPT_BOOLEAN(0, "progress", &report.progress,
> -		    "Show progress while processing the perf.data file"),
> +	/*
> +	 * Not auto negatable: parse-options turns --no-progress into the
> +	 * negation of this option before it ever reaches the --no-progress
> +	 * below, which is the one that also turns off the TUI and GTK progress.
> +	 */
> +	OPT_BOOLEAN_FLAG(0, "progress", &report.progress,
> +			 "Show progress while processing the perf.data file",
> +			 PARSE_OPT_NOAUTONEG),
> +	OPT_BOOLEAN(0, "no-progress", &report.no_progress,
> +		    "Do not show progress while processing the perf.data file"),
>  	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
>  	OPT_BOOLEAN(0, "header-only", &report.header_only,
>  		    "Show only data header."),
> @@ -1798,7 +1807,9 @@ int cmd_report(int argc, const char **argv)
>  	 * processed so far for each processing phase.  --quiet asks for no
>  	 * messages at all, so it leaves the phases uncounted.
>  	 */
> -	if (report.progress && !quiet && use_browser == 0)
> +	if (report.no_progress)
> +		ui_progress__noop_init();
> +	else if (report.progress && !quiet && use_browser == 0)
>  		stdio_progress__init();
>  
>  	if (report.data_type && use_browser == 1) {
> diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
> index 99d60223c74b2957..362680989ace606a 100644
> --- a/tools/perf/ui/progress.c
> +++ b/tools/perf/ui/progress.c
> @@ -13,6 +13,12 @@ static struct ui_progress_ops null_progress__ops =
>  
>  struct ui_progress_ops *ui_progress__ops = &null_progress__ops;
>  
> +/* Everything counts but nothing is shown, the way it starts out. */
> +void ui_progress__noop_init(void)
> +{
> +	ui_progress__ops = &null_progress__ops;
> +}
> +
>  void ui_progress__update(struct ui_progress *p, u64 adv)
>  {
>  	u64 last = p->curr;
> diff --git a/tools/perf/ui/progress.h b/tools/perf/ui/progress.h
> index 03f1a8bb260ba076..e8c4f9f768aaf12b 100644
> --- a/tools/perf/ui/progress.h
> +++ b/tools/perf/ui/progress.h
> @@ -25,6 +25,8 @@ void ui_progress__update(struct ui_progress *p, u64 adv);
>  
>  void stdio_progress__init(void);
>  
> +void ui_progress__noop_init(void);
> +
>  struct ui_progress_ops {
>  	void (*init)(struct ui_progress *p);
>  	void (*update)(struct ui_progress *p);
> -- 
> 2.55.0
> 
