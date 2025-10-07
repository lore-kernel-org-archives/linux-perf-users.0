Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF52D46AF;
	Tue,  7 Oct 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825431; cv=none; b=Hyhnnzvm/AzKxmudXKaS6hGgkW0NVAwNuZxoIkDTq57jPzcd7ZFZ4Y7IQepjO24lt9oWvdez9mQJ8U1OUhqUsja/RWsPfrx6pHvZ21Gqo8ng7ZsY7CtQqXzr2BJok0wuXP/cu7GJRfEx+PEhwwtLhnMG3ndnJv7nU6VRdcDH4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825431; c=relaxed/simple;
	bh=nPGzjYBI1HjlIWcBgfQv0Umh/q+J1rjt1HgU7kvSewI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7oxE0fDLML1lCgK0Wt+JQtA9udTPKH5FdRwclmqkXfD+m7481wa9DwIzC7BV8oQjR/PhTlh194yDRzlqCY/TSTJf1m2KldhXoYNfimOv2nKUVafjQDMF8vUQr7u5KsaqD49FAuyqfLbG5S+HxCpBkRTtu8cJ3SAtUoQTZPny+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4zC6E71; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4zC6E71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37877C4CEF7;
	Tue,  7 Oct 2025 08:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759825430;
	bh=nPGzjYBI1HjlIWcBgfQv0Umh/q+J1rjt1HgU7kvSewI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4zC6E713AyTg3y04gXQe+GQT9jdo/x6VzJnk6o0NPrSfip+Bzovi2OA0kdP0YY2S
	 A56cCu2uGhGzfa9rw7EGvxLjjN6hij/jO1k292mG95gx20t0IP6JNyp1ab0twGsco2
	 CyYNU+UZWaW2V8mBRcwF6jT0RtQmvF6rtwWHEWWLPjh+xJcuxfafq0eWXvnqCn50p5
	 S0K0yCVKUpRAncTKFMU9Yefj6Gwg08QrPYWzKQ3qqPPEkJdlkFDodRqLlzwa3ogHvB
	 /daO5l6Twrxlfr6GWI9wYnegE/wPDuPsl/cohyj/NLPRft+NaQHAglVoRWQdbgfypi
	 RotR6tnKNDNJQ==
Date: Tue, 7 Oct 2025 17:23:45 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: "Li, Tianyou" <tianyou.li@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, wangyang.guo@intel.com,
	pan.deng@intel.com, zhiguo.zhou@intel.com, jiebin.sun@intel.com,
	thomas.falcon@intel.com, dapeng1.mi@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] perf tools c2c: Add annotation support to perf c2c
 report
Message-ID: <aOTOEcNOiUiEJ9tz@google.com>
References: <aNo-U0KquRbcJam9@google.com>
 <20250930123900.1445017-1-tianyou.li@intel.com>
 <aN9ZiPYyYtr332h_@google.com>
 <9fd778d2-8383-4675-b07d-4d8bdd5cf674@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fd778d2-8383-4675-b07d-4d8bdd5cf674@intel.com>

Hello,

On Fri, Oct 03, 2025 at 07:44:34PM +0800, Li, Tianyou wrote:
> Hi Namhyung,
> 
> Appreciated for your review comments. Sorry for the delayed response. I am
> on National Holiday so check email late. My response inlined for your
> consideration.
> 
> Regards,
> 
> Tianyou
> 
> 
> On 10/3/2025 1:05 PM, Namhyung Kim wrote:
> > Hello,
> > 
> > On Tue, Sep 30, 2025 at 08:39:00PM +0800, Tianyou Li wrote:
> > > Perf c2c report currently specified the code address and source:line
> > > information in the cacheline browser, while it is lack of annotation
> > > support like perf report to directly show the disassembly code for
> > > the particular symbol shared that same cacheline. This patches add
> > > a key 'a' binding to the cacheline browser which reuse the annotation
> > > browser to show the disassembly view for easier analysis of cacheline
> > > contentions. By default, the 'TAB' key navigate to the code address
> > > where the contentions detected.
> > > 
> > > Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> > > Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > > Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
> > > Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
> > > Reviewed-by: Pan Deng <pan.deng@intel.com>
> > > Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
> > > Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> > > ---
[SNIP]
> > > @@ -2980,7 +3056,8 @@ static int setup_coalesce(const char *coalesce, bool no_source)
> > >   	else if (c2c.display == DISPLAY_SNP_PEER)
> > >   		sort_str = "tot_peer";
> > > -	if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
> > > +	/* add 'symbol' sort key to make sure hpp_list->sym get updated */
> > > +	if (asprintf(&c2c.cl_resort, "offset,%s,symbol", sort_str) < 0)
> > I think it's better to just process the input rather than enforcing it.
> > It seems the default value will have 'iaddr' and so 'symbol as well.
> 
> 
> Sorry I am not so clear about 'so symbol as well'. Did you mean we can check
> the 'dim == &dim_iaddr' instead of 'dim == &dim_symbol' to make sure
> hpp_list->sym = 1? If so, do we need to check the coalesce set to default
> 'iaddr' or not, otherwise we need to append the 'iaddr' in addition to the
> user specific one?

I meant you have 'iaddr' in the default sort keys and it will include
'symbol' in the output.  So annotation will be enabled by default.

> 
> 
> > 
> > >   		return -ENOMEM;
> > >   	pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
> > > @@ -3006,6 +3083,7 @@ static int perf_c2c__report(int argc, const char **argv)
> > >   	const char *display = NULL;
> > >   	const char *coalesce = NULL;
> > >   	bool no_source = false;
> > > +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
> > >   	const struct option options[] = {
> > >   	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
> > >   		   "file", "vmlinux pathname"),
> > > @@ -3033,6 +3111,12 @@ static int perf_c2c__report(int argc, const char **argv)
> > >   	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
> > >   		    "Enable LBR callgraph stitching approach"),
> > >   	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
> > > +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
> > > +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
> > > +	OPT_STRING(0, "objdump", &objdump_path, "path",
> > > +		   "objdump binary to use for disassembly and annotations"),
> > Please update documentation with the new options.
> 
> 
> Noted, will do in patch v6.
> 
> 
> > 
> > > +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
> > > +		   "addr2line binary to use for line numbers"),
> > Do you really need this?
> 
> 
> In my use scenarios of c2c tool, I did not use this addr2line tool. If this
> was not quite necessary, I will remove it from patch v6.

Yes, please.

> 
> 
> > 
> > >   	OPT_PARENT(c2c_options),
> > >   	OPT_END()
> > >   	};
> > > @@ -3040,6 +3124,12 @@ static int perf_c2c__report(int argc, const char **argv)
> > >   	const char *output_str, *sort_str = NULL;
> > >   	struct perf_env *env;
> > > +	annotation_options__init();
> > > +
> > > +	err = hists__init();
> > > +	if (err < 0)
> > > +		goto out;
> > > +
> > >   	argc = parse_options(argc, argv, options, report_c2c_usage,
> > >   			     PARSE_OPT_STOP_AT_NON_OPTION);
> > >   	if (argc)
> > > @@ -3052,6 +3142,36 @@ static int perf_c2c__report(int argc, const char **argv)
> > >   	if (c2c.stats_only)
> > >   		c2c.use_stdio = true;
> > > +	/**
> > > +	 * Annotation related options
> > > +	 * disassembler_style, objdump_path, addr2line_path
> > > +	 * are set in the c2c_options, so we can use them here.
> > > +	 */
> > > +	if (disassembler_style) {
> > > +		annotate_opts.disassembler_style = strdup(disassembler_style);
> > > +		if (!annotate_opts.disassembler_style) {
> > > +			err = -ENOMEM;
> > > +			pr_err("Failed to allocate memory for annotation options\n");
> > > +			goto out;
> > > +		}
> > > +	}
> > > +	if (objdump_path) {
> > > +		annotate_opts.objdump_path = strdup(objdump_path);
> > > +		if (!annotate_opts.objdump_path) {
> > > +			err = -ENOMEM;
> > > +			pr_err("Failed to allocate memory for annotation options\n");
> > > +			goto out;
> > > +		}
> > > +	}
> > > +	if (addr2line_path) {
> > > +		symbol_conf.addr2line_path = strdup(addr2line_path);
> > > +		if (!symbol_conf.addr2line_path) {
> > > +			err = -ENOMEM;
> > > +			pr_err("Failed to allocate memory for annotation options\n");
> > > +			goto out;
> > > +		}
> > > +	}
> > > +
> > >   	err = symbol__validate_sym_arguments();
> > >   	if (err)
> > >   		goto out;
> > > @@ -3126,6 +3246,38 @@ static int perf_c2c__report(int argc, const char **argv)
> > >   	if (err)
> > >   		goto out_mem2node;
> > > +	if (c2c.use_stdio)
> > > +		use_browser = 0;
> > > +	else
> > > +		use_browser = 1;
> > > +
> > > +	/*
> > > +	 * Only in the TUI browser we are doing integrated annotation,
> > > +	 * so don't allocate extra space that won't be used in the stdio
> > > +	 * implementation.
> > > +	 */
> > > +	if (perf_c2c__has_annotation(NULL)) {
> > > +		int ret = symbol__annotation_init();
> > > +
> > > +		if (ret < 0)
> > > +			goto out_mem2node;
> > > +		/*
> > > +		 * For searching by name on the "Browse map details".
> > > +		 * providing it only in verbose mode not to bloat too
> > > +		 * much struct symbol.
> > > +		 */
> > > +		if (verbose > 0) {
> > > +			/*
> > > +			 * XXX: Need to provide a less kludgy way to ask for
> > > +			 * more space per symbol, the u32 is for the index on
> > > +			 * the ui browser.
> > > +			 * See symbol__browser_index.
> > > +			 */
> > > +			symbol_conf.priv_size += sizeof(u32);
> > > +		}
> > > +		annotation_config__init();
> > > +	}
> > > +
> > >   	if (symbol__init(env) < 0)
> > >   		goto out_mem2node;
> > > @@ -3135,11 +3287,6 @@ static int perf_c2c__report(int argc, const char **argv)
> > >   		goto out_mem2node;
> > >   	}
> > > -	if (c2c.use_stdio)
> > > -		use_browser = 0;
> > > -	else
> > > -		use_browser = 1;
> > > -
> > >   	setup_browser(false);
> > >   	err = perf_session__process_events(session);
> > > @@ -3210,6 +3357,7 @@ static int perf_c2c__report(int argc, const char **argv)
> > >   out_session:
> > >   	perf_session__delete(session);
> > >   out:
> > > +	annotation_options__exit();
> > >   	return err;
> > >   }
> > > diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> > > index 8fe699f98542..a9d56e67454d 100644
> > > --- a/tools/perf/ui/browsers/annotate.c
> > > +++ b/tools/perf/ui/browsers/annotate.c
> > > @@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
> > >   	target_ms.map = ms->map;
> > >   	target_ms.sym = dl->ops.target.sym;
> > >   	annotation__unlock(notes);
> > > -	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
> > > +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_AL_ADDR);
> > >   	/*
> > >   	 * The annotate_browser above changed the title with the target function
> > > @@ -864,6 +864,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
> > >   	const char *help = "Press 'h' for help on key bindings";
> > >   	int delay_secs = hbt ? hbt->refresh : 0;
> > >   	char *br_cntr_text = NULL;
> > > +	u64 init_al_addr = NO_INITIAL_AL_ADDR;
> > >   	char title[256];
> > >   	int key;
> > > @@ -873,6 +874,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
> > >   	annotate_browser__calc_percent(browser, evsel);
> > > +	/* the selection are intentionally even not from the sample percentage */
> > > +	if (browser->entries.rb_node == NULL && browser->selection) {
> > > +		init_al_addr = sym->start + browser->selection->offset;
> > > +		disasm_rb_tree__insert(browser, browser->selection);
> > > +		browser->curr_hot = rb_last(&browser->entries);
> > > +	}
> > > +
> > >   	if (browser->curr_hot) {
> > >   		annotate_browser__set_rb_top(browser, browser->curr_hot);
> > >   		browser->b.navkeypressed = false;
> > > @@ -973,6 +981,18 @@ static int annotate_browser__run(struct annotate_browser *browser,
> > >   				ui_helpline__puts(help);
> > >   			annotate__scnprintf_title(hists, title, sizeof(title));
> > >   			annotate_browser__show(browser, title, help);
> > > +			/* Previous RB tree may not valid, need refresh according to new entries*/
> > > +			if (init_al_addr != NO_INITIAL_AL_ADDR) {
> > > +				struct disasm_line *dl = find_disasm_line(sym, init_al_addr, true);
> > > +
> > > +				browser->curr_hot = NULL;
> > > +				browser->entries.rb_node = NULL;
> > > +				if (dl != NULL) {
> > > +					disasm_rb_tree__insert(browser, &dl->al);
> > > +					browser->curr_hot = rb_last(&browser->entries);
> > > +				}
> > > +				nd = browser->curr_hot;
> > > +			}
> > Can you please split annotate changes from c2c change?  I think you can
> > start with annotation support in c2c.  And add INITIAL_ADDR later so
> > that we can discuss the issue separately.  Maybe we don't need the ADDR
> > change.  Do you have any concrete usecase where default annotate is not
> > enough for c2c?
> 
> 
> Sure, I will split the patch into 2 patches. I use c2c extensively for my
> day-to-day performance work, the INITIAL_ADDR would be very helpful to
> located to the code where the iaddr was indicated in the cacheline browser.
> Otherwise, probably I need to copy the iaddr from the cacheline browser, get
> into the annotation browser, press 'o' to show the view with addresses in
> disassemble view, and manually find the iaddr match since the search only
> match string for disassembly code. The code highlight with INITIAL_ADDR
> would quickly allow me to navigate the contended lines of code from
> different functions showed in the cacheline browser, plus with  's' and 'T',
> I can get to the point more conveniently.
> 
> 
> Agreed to discuss it separately, looking forward to hearing your thoughts.

Thanks for your understanding!
Namhyung

