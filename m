Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937295237AE
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763509; cv=none; b=eMd2Hqm/cMxqdH0mDwSQYzdl2H+aSd3wA+HumylqG6OqUWznJ+xkOfmuJWIMrSWpH0oFnRHwvJgIKHe4UXfIFSIYBioc9yA+cGffCfXgyqNzgJhkzAlWRps++netMTAZZ4dcw8b3xc61T4iuzdiO7E5r8oL1xgHZ+Nh25UXz6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763509; c=relaxed/simple;
	bh=J+sTebpm4RtzYT3guZhgUnZPlRjepASE6tyAcDI/3Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1FKfJv+GKO89btij/ur4y7cmgQiO/gGqhP2ZL/mPaJe+gC0jevTqAJZ5VFEZ67nWRgExs34x5vW0TfDaVjch8LNca2AjcucPu22k3KZGfRkA0Nnt+FQKDoDoAiYTMMJ2aqn3S5+f2ol8wkvczKUM0EUaHNsWfW5XDuoXkz7qbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrHK9IQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrHK9IQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC99E1F000FF;
	Fri, 18 Sep 2026 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789763505;
	bh=5N+AQGTfo5/1sTUzghyFO/1kd8OSd2iUojvqjJvEr+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OrHK9IQyJ47Nc+FV2+oGRbFiI+WicvNZ1oA8XVzMoFY+ah4h43Tjzh9kA4gzB0Z/N
	 uFZQiCGYwzd+FC8VB0vQl4ouKAP3Acigp671itOu3QaJjSaYiPHig2bTgZBw8QiChi
	 WX2tA9VS5rkavBRH1rzjKO1DgAxJ0lC7MiMEHXlRv6hIxJyWfqtLLle65+Xm6fRK8u
	 D4HapCDBjiWKjutjmWfZQUU/nV7pduxQIKbu7dkMa1Z50aDTfNxAS3nfMQfHgxrRAy
	 Os4l5KSwlf9OyEM5pyTE6lGyP+wg6DEKHxoT7hrzYVt4WoG6GFy5s+vh9WncWWqdGY
	 6qSRP+kB8TO1g==
Date: Fri, 18 Sep 2026 17:31:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, ak@kernel.org, ak@linux.intel.com,
	andi@firstfloor.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 3/9] perf tools: Expose opt-in --hybrid-merge
Message-ID: <aq2fraVJUKUS2I2z@x2>
References: <20260916234652.439778-1-irogers@google.com>
 <20260917050708.704702-1-irogers@google.com>
 <20260917050708.704702-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917050708.704702-4-irogers@google.com>

On Wed, Sep 16, 2026 at 10:07:02PM -0700, Ian Rogers wrote:
> Add --hybrid-merge to perf report and perf top. It merges the events a
> wildcard expanded to across the core PMUs, and their histograms, so
> that a symbol which ran on more than one kind of core is reported once
> with the total rather than once per PMU.
> 
> evlist__merge_hybrid() links the events and evlist__merge_hists_hybrid()
> links the histograms. There is nothing to merge on a machine with a
> single core PMU, or when the events didn't come from a wildcard, so
> warn in that case rather than quietly producing an unmerged report.
> 
> Merging collapses the per-PMU entries into one set, which doesn't
> combine with the per-level breakdown of --hierarchy, so asking for both
> is an error.

It would be interesting to have a hotkey to switch to this mode on the
fly and back, even if it required to reset everything when doing so, but
probably it should be possible on the -> hybrid-merge way.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.1-pro
> ---
>  tools/perf/Documentation/perf-report.txt |  5 +++++
>  tools/perf/Documentation/perf-top.txt    |  5 +++++
>  tools/perf/builtin-report.c              | 19 +++++++++++++++++++
>  tools/perf/builtin-top.c                 | 17 +++++++++++++++++
>  tools/perf/util/symbol.c                 |  1 +
>  5 files changed, 47 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 1a4706329c6c..3718ebd297ce 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -578,6 +578,11 @@ include::itrace.txt[]
>  --raw-trace::
>  	When displaying traceevent output, do not use print fmt or plugins.
>  
> +--hybrid-merge::
> +	Merge matching events from all hybrid core PMUs into one
> +	display. For example, if a wildcard expands to run on both p-cores and
> +	e-cores, this aggregates them into a single view.
> +
>  -H::
>  --hierarchy::
>  	Enable hierarchical output.  In the hierarchy mode, each sort key groups
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 2da2a16bbf26..c5e96da6ed82 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -49,6 +49,11 @@ Default is to monitor all CPUS.
>  	encoding with the layout of the event control registers as described
>  	by entries in /sys/bus/event_source/devices/cpu/format/*.
>  
> +--hybrid-merge::
> +	Merge matching events from all hybrid core PMUs into one
> +	display. For example, if a wildcard expands to run on both p-cores and
> +	e-cores, this aggregates them into a single view.
> +
>  --filter=<filter>::
>  	Event filter.  This option should follow an event selector (-e). For
>  	syntax see linkperf:perf-record[1].
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 279e61c2366c..bda4836fc524 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1114,6 +1114,17 @@ static int __cmd_report(struct report *rep)
>  	evlist__for_each_entry(session->evlist, pos)
>  		rep->nr_entries += evsel__hists(pos)->nr_entries;
>  
> +	if (symbol_conf.hybrid_merge) {
> +		struct perf_env *env = perf_session__env(session);
> +
> +		if (evlist__can_merge_hybrid(session->evlist, env)) {
> +			evlist__merge_hybrid(session->evlist, env);
> +			evlist__merge_hists_hybrid(session->evlist, false);
> +		} else {
> +			ui__warning("--hybrid-merge: no events to merge across core PMUs\n");
> +		}
> +	}
> +
>  	if (use_browser == 0) {
>  		if (verbose > 3)
>  			perf_session__fprintf(session, stdout);
> @@ -1449,6 +1460,8 @@ int cmd_report(int argc, const char **argv)
>  		    parse_branch_mode),
>  	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
>  		    "add last branch records to call history"),
> +	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
> +		    "merge the same event across hybrid core PMUs"),
>  	OPT_STRING(0, "objdump", &objdump_path, "path",
>  		   "objdump binary to use for disassembly and annotations"),
>  	OPT_STRING(0, "addr2line", &addr2line_path, "path",
> @@ -1548,6 +1561,12 @@ int cmd_report(int argc, const char **argv)
>  		report.symbol_filter_str = argv[0];
>  	}
>  
> +	if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
> +		pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
>  	if (disassembler_style) {
>  		annotate_opts.disassembler_style = strdup(disassembler_style);
>  		if (!annotate_opts.disassembler_style)
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index c2562d49be46..3bb3337f1244 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1336,6 +1336,15 @@ static int __cmd_top(struct perf_top *top)
>          if (!target__none(&opts->target))
>  		evlist__enable(top->evlist);
>  
> +	if (symbol_conf.hybrid_merge) {
> +		if (evlist__can_merge_hybrid(top->evlist, /*env=*/NULL)) {
> +			evlist__merge_hybrid(top->evlist, /*env=*/NULL);
> +			evlist__merge_hists_hybrid(top->evlist, false);
> +		} else {
> +			ui__warning("--hybrid-merge: no events to merge across core PMUs\n");
> +		}
> +	}
> +
>  	ret = -1;
>  	if (pthread_create(&thread_process, NULL, process_thread, top)) {
>  		ui__error("Could not create process thread.\n");
> @@ -1491,6 +1500,8 @@ int cmd_top(int argc, const char **argv)
>  	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
>  		     "event selector. use 'perf list' to list available events",
>  		     parse_events_option),
> +	OPT_BOOLEAN(0, "hybrid-merge", &symbol_conf.hybrid_merge,
> +		    "merge the same event across hybrid core PMUs"),
>  	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
>  		     "event filter", parse_filter),
>  	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
> @@ -1679,6 +1690,12 @@ int cmd_top(int argc, const char **argv)
>  	if (argc)
>  		usage_with_options(top_usage, options);
>  
> +	if (symbol_conf.report_hierarchy && symbol_conf.hybrid_merge) {
> +		pr_err("Error: --hierarchy and --hybrid-merge are mutually exclusive.\n");
> +		status = -EINVAL;
> +		goto out_put_evlist;
> +	}
> +
>  	if (disassembler_style) {
>  		annotate_opts.disassembler_style = strdup(disassembler_style);
>  		if (!annotate_opts.disassembler_style) {
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3206929473a2..163652f071c6 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -74,6 +74,7 @@ struct symbol_conf symbol_conf = {
>  	.symfs			= "",
>  	.symfs_layout_flat	= false,
>  	.event_group		= true,
> +	.hybrid_merge		= false,
>  	.inline_name		= true,
>  	.res_sample		= 0,
>  	.addr2line_timeout_ms	= 5 * 1000,
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
