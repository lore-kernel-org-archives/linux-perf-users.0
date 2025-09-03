Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732C2FDC57;
	Wed,  3 Sep 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907457; cv=none; b=hVpd4lwBV0N3ZnjMf37T1nNPAgRvuz+cj3L/AVHlceStjMaydKDl7hmfQXWWlUT0g9p3rlzAcZ8xG1nvmA9X9iuLWUV2rL/4+9bfK4Fqz7jIBRFzUPJ+LI5oprxVhWNXdn4BRCXjGj5p4ae+SZ0GW6/fyedoqGOGmvY32Czoz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907457; c=relaxed/simple;
	bh=TmMoN3jaJXkCxT3acTPJatmykuSFe/MeK6yjMiaO8ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsV1mAz1/0n4/LKGUGIIddbVwBWlgjUQh97WdElyD1aL0Hoqxtfb+mRRRzDBV6h9IuuEtQPluPPfNglwp1pb8vuJER8TkYhEVS7YojQnBwQvcP6ENCO/AW51sHOcr1MczC5iZw9h/bXKsnzKemc89HkCJsgiWELpofjdHPKYFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWweAxY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWweAxY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E036C4CEE7;
	Wed,  3 Sep 2025 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756907457;
	bh=TmMoN3jaJXkCxT3acTPJatmykuSFe/MeK6yjMiaO8ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWweAxY/HYLraUnpWYsClLhoIr4Lq4/tkq4Lh9r+OJysO54au9kPL4cN5EVIJKrkh
	 HY5eb914/FMAzaIQrj4IpSV08mi31Wp1DnOJlazCR1FhXiR4dRMfURWy22/tem0EdY
	 8MwiyFTFLKOwXa/v4YXFFFVB0N7yXNgZpBD96xYNOeqLhQip8c4C28PXxEVptJ25Yx
	 Wk3ezOKcbe5njTfKqwOEP0ZQMof1JIs+Yhvmp2PuOfFj+QApRg1Xouv9LSGlI6XyJf
	 kRMitGSvRZAWwoUYargwclqMnTgiX4OsJPwbFQYXET20CXdDzr8KMJRVEbFJCZlbQx
	 N8HX2GuSdrlNw==
Date: Wed, 3 Sep 2025 10:50:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tianyou Li <tianyou.li@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, wangyang.guo@intel.com,
	pan.deng@intel.com, zhiguo.zhou@intel.com, jiebin.sun@intel.com,
	thomas.falcon@intel.com, dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tools c2c: Add annotation support to perf c2c
 report
Message-ID: <aLhHvWTnxGA-_6Ew@x1>
References: <20250801075158.218441-1-tianyou.li@intel.com>
 <20250819080014.515277-1-tianyou.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819080014.515277-1-tianyou.li@intel.com>

On Tue, Aug 19, 2025 at 04:00:14PM +0800, Tianyou Li wrote:
> Perf c2c report currently specified the code address and source:line
> information in the cacheline browser, while it is lack of annotation
> support like perf report to directly show the disassembly code for
> the particular symbol shared that same cacheline. This patches add
> a key 'a' binding to the cacheline browser which reuse the annotation
> browser to show the disassembly view for easier analysis of cacheline
> contentions. By default, the 'TAB' key navigate to the code address
> where the contentions detected.

There were changes in that codebase recently, can you please consider
rebasing your work?

This is something I really want to see in place, almost did it myself at
some point :-)

Please use what is in:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next

- Arnaldo
 
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
> Reviewed-by: Pan Deng <pan.deng@intel.com>
> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> ---
>  tools/perf/builtin-annotate.c     |   2 +-
>  tools/perf/builtin-c2c.c          | 124 ++++++++++++++++++++++++++++--
>  tools/perf/ui/browsers/annotate.c |  30 ++++++--
>  tools/perf/ui/browsers/hists.c    |   2 +-
>  tools/perf/util/annotate.c        |   2 +-
>  tools/perf/util/annotate.h        |   4 +-
>  tools/perf/util/hist.h            |   6 +-
>  7 files changed, 153 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 5d57d2913f3d..8c896fbe76b7 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
>  			/* skip missing symbols */
>  			nd = rb_next(nd);
>  		} else if (use_browser == 1) {
> -			key = hist_entry__tui_annotate(he, evsel, NULL);
> +			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_IP);
>  
>  			switch (key) {
>  			case -1:
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 9e9ff471ddd1..f753ec50b967 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -45,6 +45,8 @@
>  #include "pmus.h"
>  #include "string2.h"
>  #include "util/util.h"
> +#include "util/symbol.h"
> +#include "util/annotate.h"
>  
>  struct c2c_hists {
>  	struct hists		hists;
> @@ -62,6 +64,7 @@ struct compute_stats {
>  
>  struct c2c_hist_entry {
>  	struct c2c_hists	*hists;
> +	struct evsel		*evsel;
>  	struct c2c_stats	 stats;
>  	unsigned long		*cpuset;
>  	unsigned long		*nodeset;
> @@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
>  	return hists;
>  }
>  
> +static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
> +				struct evsel *evsel)
> +{
> +	c2c_he->evsel = evsel;
> +}
> +
>  static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
>  			    struct perf_sample *sample)
>  {
> @@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  
>  	c2c_he__set_cpu(c2c_he, sample);
>  	c2c_he__set_node(c2c_he, sample);
> +	c2c_he__set_evsel(c2c_he, evsel);
>  
>  	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>  	ret = hist_entry__append_callchain(he, sample);
> @@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  
>  		c2c_he__set_cpu(c2c_he, sample);
>  		c2c_he__set_node(c2c_he, sample);
> +		c2c_he__set_evsel(c2c_he, evsel);
>  
>  		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>  		ret = hist_entry__append_callchain(he, sample);
> @@ -2606,6 +2617,28 @@ c2c_cacheline_browser__new(struct hists *hists, struct hist_entry *he)
>  	return browser;
>  }
>  
> +static int perf_c2c__toggle_annotation(struct hist_browser *browser)
> +{
> +	struct hist_entry *he = browser->he_selection;
> +	struct symbol *sym = NULL;
> +	struct c2c_hist_entry *c2c_he = NULL;
> +
> +	if (!he) {
> +		ui_browser__help_window(&browser->b, "No entry selected for annotation");
> +		return 0;
> +	}
> +	sym = (&he->ms)->sym;
> +
> +	if (sym == NULL) {
> +		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
> +		return 0;
> +	}
> +
> +	symbol__hists(sym, 0);
> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
> +	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, he->ip);
> +}
> +
>  static int perf_c2c__browse_cacheline(struct hist_entry *he)
>  {
>  	struct c2c_hist_entry *c2c_he;
> @@ -2617,6 +2650,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>  	" ENTER         Toggle callchains (if present) \n"
>  	" n             Toggle Node details info \n"
>  	" s             Toggle full length of symbol and source line columns \n"
> +	" a             Toggle annotation view \n"
>  	" q             Return back to cacheline list \n";
>  
>  	if (!he)
> @@ -2651,6 +2685,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>  			c2c.node_info = (c2c.node_info + 1) % 3;
>  			setup_nodes_header();
>  			break;
> +		case 'a':
> +			perf_c2c__toggle_annotation(browser);
> +			break;
>  		case 'q':
>  			goto out;
>  		case '?':
> @@ -2989,6 +3026,11 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>  	return 0;
>  }
>  
> +static bool perf_c2c__has_annotation(void)
> +{
> +	return use_browser == 1;
> +}
> +
>  static int perf_c2c__report(int argc, const char **argv)
>  {
>  	struct itrace_synth_opts itrace_synth_opts = {
> @@ -3006,6 +3048,8 @@ static int perf_c2c__report(int argc, const char **argv)
>  	const char *display = NULL;
>  	const char *coalesce = NULL;
>  	bool no_source = false;
> +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
> +
>  	const struct option options[] = {
>  	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>  		   "file", "vmlinux pathname"),
> @@ -3033,6 +3077,12 @@ static int perf_c2c__report(int argc, const char **argv)
>  	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>  		    "Enable LBR callgraph stitching approach"),
>  	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
> +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
> +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
> +	OPT_STRING(0, "objdump", &objdump_path, "path",
> +		   "objdump binary to use for disassembly and annotations"),
> +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
> +		   "addr2line binary to use for line numbers"),
>  	OPT_PARENT(c2c_options),
>  	OPT_END()
>  	};
> @@ -3040,6 +3090,12 @@ static int perf_c2c__report(int argc, const char **argv)
>  	const char *output_str, *sort_str = NULL;
>  	struct perf_env *env;
>  
> +	annotation_options__init();
> +
> +	err = hists__init();
> +	if (err < 0)
> +		goto out;
> +
>  	argc = parse_options(argc, argv, options, report_c2c_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  	if (argc)
> @@ -3052,6 +3108,36 @@ static int perf_c2c__report(int argc, const char **argv)
>  	if (c2c.stats_only)
>  		c2c.use_stdio = true;
>  
> +	/**
> +	 * Annotation related options
> +	 * disassembler_style, objdump_path, addr2line_path
> +	 * are set in the c2c_options, so we can use them here.
> +	 */
> +	if (disassembler_style) {
> +		annotate_opts.disassembler_style = strdup(disassembler_style);
> +		if (!annotate_opts.disassembler_style) {
> +			err = -ENOMEM;
> +			pr_err("Failed to allocate memory for annotation options\n");
> +			goto out;
> +		}
> +	}
> +	if (objdump_path) {
> +		annotate_opts.objdump_path = strdup(objdump_path);
> +		if (!annotate_opts.objdump_path) {
> +			err = -ENOMEM;
> +			pr_err("Failed to allocate memory for annotation options\n");
> +			goto out;
> +		}
> +	}
> +	if (addr2line_path) {
> +		symbol_conf.addr2line_path = strdup(addr2line_path);
> +		if (!symbol_conf.addr2line_path) {
> +			err = -ENOMEM;
> +			pr_err("Failed to allocate memory for annotation options\n");
> +			goto out;
> +		}
> +	}
> +
>  	err = symbol__validate_sym_arguments();
>  	if (err)
>  		goto out;
> @@ -3126,6 +3212,38 @@ static int perf_c2c__report(int argc, const char **argv)
>  	if (err)
>  		goto out_mem2node;
>  
> +	if (c2c.use_stdio)
> +		use_browser = 0;
> +	else
> +		use_browser = 1;
> +
> +	/*
> +	 * Only in the TUI browser we are doing integrated annotation,
> +	 * so don't allocate extra space that won't be used in the stdio
> +	 * implementation.
> +	 */
> +	if (perf_c2c__has_annotation()) {
> +		int ret = symbol__annotation_init();
> +
> +		if (ret < 0)
> +			goto out_mem2node;
> +		/*
> +		 * For searching by name on the "Browse map details".
> +		 * providing it only in verbose mode not to bloat too
> +		 * much struct symbol.
> +		 */
> +		if (verbose > 0) {
> +			/*
> +			 * XXX: Need to provide a less kludgy way to ask for
> +			 * more space per symbol, the u32 is for the index on
> +			 * the ui browser.
> +			 * See symbol__browser_index.
> +			 */
> +			symbol_conf.priv_size += sizeof(u32);
> +		}
> +		annotation_config__init();
> +	}
> +
>  	if (symbol__init(env) < 0)
>  		goto out_mem2node;
>  
> @@ -3135,11 +3253,6 @@ static int perf_c2c__report(int argc, const char **argv)
>  		goto out_mem2node;
>  	}
>  
> -	if (c2c.use_stdio)
> -		use_browser = 0;
> -	else
> -		use_browser = 1;
> -
>  	setup_browser(false);
>  
>  	err = perf_session__process_events(session);
> @@ -3210,6 +3323,7 @@ static int perf_c2c__report(int argc, const char **argv)
>  out_session:
>  	perf_session__delete(session);
>  out:
> +	annotation_options__exit();
>  	return err;
>  }
>  
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 183902dac042..7eb659c76b53 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -557,7 +557,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>  	target_ms.map = ms->map;
>  	target_ms.sym = dl->ops.target.sym;
>  	annotation__unlock(notes);
> -	symbol__tui_annotate(&target_ms, evsel, hbt);
> +	symbol__tui_annotate(&target_ms, evsel, hbt, NO_INITIAL_IP);
>  	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
>  	ui_browser__show_title(&browser->b, title);
>  	return true;
> @@ -814,6 +814,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  
>  	annotate_browser__calc_percent(browser, evsel);
>  
> +	if (browser->curr_hot == NULL && browser->selection) {
> +		disasm_rb_tree__insert(browser, browser->selection);
> +		browser->curr_hot = rb_last(&browser->entries);
> +	}
> +
>  	if (browser->curr_hot) {
>  		annotate_browser__set_rb_top(browser, browser->curr_hot);
>  		browser->b.navkeypressed = false;
> @@ -1033,27 +1038,28 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  }
>  
>  int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -			     struct hist_browser_timer *hbt)
> +			     struct hist_browser_timer *hbt, u64 init_ip)
>  {
> -	return symbol__tui_annotate(ms, evsel, hbt);
> +	return symbol__tui_annotate(ms, evsel, hbt, init_ip);
>  }
>  
>  int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> -			     struct hist_browser_timer *hbt)
> +			     struct hist_browser_timer *hbt, u64 init_ip)
>  {
>  	/* reset abort key so that it can get Ctrl-C as a key */
>  	SLang_reset_tty();
>  	SLang_init_tty(0, 0, 0);
>  	SLtty_set_suspend_state(true);
>  
> -	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
> +	return map_symbol__tui_annotate(&he->ms, evsel, hbt, init_ip);
>  }
>  
>  int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -			 struct hist_browser_timer *hbt)
> +			 struct hist_browser_timer *hbt, u64 init_ip)
>  {
>  	struct symbol *sym = ms->sym;
>  	struct annotation *notes = symbol__annotation(sym);
> +	struct disasm_line *dl = NULL;
>  	struct annotate_browser browser = {
>  		.b = {
>  			.refresh = annotate_browser__refresh,
> @@ -1093,6 +1099,18 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>  		}
>  	}
>  
> +	/*
> +	 * If init_ip is set, it means that there should be a line
> +	 * intentionally selected, not based on the percentages
> +	 * which caculated by the event sampling. In this case, we
> +	 * convey this information into the browser selection, where
> +	 * the selection in other cases should be empty.
> +	 */
> +	if (init_ip != NO_INITIAL_IP) {
> +		dl = find_disasm_line(sym, init_ip, false);
> +		browser.selection = &dl->al;
> +	}
> +
>  	ui_helpline__push("Press ESC to exit");
>  
>  	browser.b.width = notes->src->widths.max_line_len;
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index d9d3fb44477a..eec1b5c12a28 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2484,7 +2484,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>  	else
>  		evsel = hists_to_evsel(browser->hists);
>  
> -	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
> +	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt, NO_INITIAL_IP);
>  	he = hist_browser__selected_entry(browser);
>  	/*
>  	 * offer option to annotate the other branch source or target
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0dd475a744b6..682100196134 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2544,7 +2544,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>  	return 0;
>  }
>  
> -static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>  					    bool allow_update)
>  {
>  	struct disasm_line *dl;
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 8b5131d257b0..c4c897745698 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -170,6 +170,8 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
>  	return al ? container_of(al, struct disasm_line, al) : NULL;
>  }
>  
> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
> +					    bool allow_update);
>  /*
>   * Is this offset in the same function as the line it is used?
>   * asm functions jump to other functions, for instance.
> @@ -473,7 +475,7 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel);
>  
>  #ifdef HAVE_SLANG_SUPPORT
>  int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -			 struct hist_browser_timer *hbt);
> +			 struct hist_browser_timer *hbt, u64 init_ip);
>  #else
>  static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
>  				struct evsel *evsel  __maybe_unused,
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 70438d03ca9c..aca1e3151bcc 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -713,11 +713,13 @@ struct block_hist {
>  #include "../ui/keysyms.h"
>  void attr_to_script(char *buf, struct perf_event_attr *attr);
>  
> +#define NO_INITIAL_IP 0
> +
>  int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
> -			     struct hist_browser_timer *hbt);
> +			     struct hist_browser_timer *hbt, u64 init_ip);
>  
>  int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> -			     struct hist_browser_timer *hbt);
> +			     struct hist_browser_timer *hbt, u64 init_ip);
>  
>  int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
>  			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
> -- 
> 2.47.1
> 
