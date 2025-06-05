Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01B1E5B9F;
	Thu,  5 Jun 2025 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156287; cv=none; b=k/A/lAQOAliG+yybIecF68EMfcZJOxFQw7oimrK3pqVYyA1L2miKXwcYQ2UMV3iNnlxMHtXSSPgjxTtI7jyQzk5+6Jx6+JF3+l8jbx5fNtbnc6jLiIp9L0znvXvJxpZi4WHTlVPqtDiTF0h3vv13q5xBsWysHxsY8okJi77jCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156287; c=relaxed/simple;
	bh=awT3ZUGv1kb6ieEDERjb6HReRwyM1m6fGKwROs/98wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfY6x+KPn9UzLiPtA36k44THsL+Ho/BYiUY7C1p/yxAd48NiM3X2vrH/zmceTenpIn5BrqaRl141UyT8lpjY+312m8Dd+1PgCYpQ/TVYorYWtMcuDSncw/idyUcEph0J7pYA2JXkkfTgt1jYTRb8/unHQFPzphYM1hvWaf/6tEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTb8kdTG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTb8kdTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8ECC4CEEB;
	Thu,  5 Jun 2025 20:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749156287;
	bh=awT3ZUGv1kb6ieEDERjb6HReRwyM1m6fGKwROs/98wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTb8kdTG/6cqxtZpJg1u2SVIrrjBtO7aYAOAdPUSZoq0rfeOS0IrNfiyOQH0NAZNL
	 EuJ234UgbBqq8G62baKtaywO6Ut1vn+VrY7t8SIxweAUKgGy8Al/uhSYJevaz9KB5r
	 m84pviTIuV63HdL/S4u3Qa22gWHgWau+WPEfgUIjPLg6YbGhiMTZ9fNQW4NJhtkPaq
	 KT0MdI5mlfomEtktGGA9feXCs5bjV/vYuyQNJptUUJux9M+P+LaWliH4bgPH60Yek+
	 Y9JMUMKChiQgRmelh7dsVOZmvS/Z56qu8J6p3QgVdP2WA9i7OBepf1xYmt5051122n
	 qSYbkw8BPqvdA==
Date: Thu, 5 Jun 2025 17:44:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/6] perf annotate: Pass annotation_print_data to
 annotaiton_line__write()
Message-ID: <aEIBvIVWmi8vsCHS@x1>
References: <20250601065302.12531-1-namhyung@kernel.org>
 <20250601065302.12531-4-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250601065302.12531-4-namhyung@kernel.org>

There is a typo in the subject: annotaiton_line__write()
                                      ^^

- Arnaldo

On Sat, May 31, 2025 at 11:52:59PM -0700, Namhyung Kim wrote:
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate.c | 13 ++++++++++--
>  tools/perf/util/annotate.c        | 35 +++++++++++++++++--------------
>  tools/perf/util/annotate.h        | 15 +++++++++++--
>  3 files changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index af3e52ce4da62eb9..0057fb485e85aaaf 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -28,6 +28,8 @@ struct annotate_browser {
>  	struct annotation_line	   *selection;
>  	struct arch		   *arch;
>  	struct hist_entry	   *he;
> +	struct debuginfo	   *dbg;
> +	struct evsel		   *evsel;
>  	bool			    searching_backwards;
>  	char			    search_bf[128];
>  };
> @@ -108,12 +110,18 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
>  		.printf			 = annotate_browser__printf,
>  		.write_graph		 = annotate_browser__write_graph,
>  	};
> +	struct annotation_print_data apd = {
> +		.he = ab->he,
> +		.arch = ab->arch,
> +		.evsel = ab->evsel,
> +		.dbg = ab->dbg,
> +	};
>  
>  	/* The scroll bar isn't being used */
>  	if (!browser->navkeypressed)
>  		ops.width += 1;
>  
> -	annotation_line__write(al, notes, &ops);
> +	annotation_line__write(al, notes, &ops, &apd);
>  
>  	if (ops.current_entry)
>  		ab->selection = al;
> @@ -902,7 +910,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  			continue;
>  		}
>  		case 'P':
> -			map_symbol__annotation_dump(ms, evsel);
> +			map_symbol__annotation_dump(ms, evsel, browser->he);
>  			continue;
>  		case 't':
>  			if (symbol_conf.show_total_period) {
> @@ -987,6 +995,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>  			.use_navkeypressed = true,
>  		},
>  		.he = he,
> +		.evsel = evsel,
>  	};
>  	struct dso *dso;
>  	int ret = -1, err;
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 48fac08c4c9502b1..7df726b99541a571 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -765,15 +765,6 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
>  			    struct debuginfo *dbg, struct disasm_line *dl,
>  			    int *type_offset);
>  
> -struct annotation_print_data {
> -	struct hist_entry *he;
> -	struct evsel *evsel;
> -	struct arch *arch;
> -	struct debuginfo *dbg;
> -	u64 start;
> -	int addr_fmt_width;
> -};
> -
>  static int
>  annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
>  		       struct annotation_options *opts, int printed,
> @@ -1230,7 +1221,6 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
>  	struct annotation_print_data apd = {
>  		.he = he,
>  		.evsel = evsel,
> -		.start = map__rip_2objdump(map, sym->start),
>  	};
>  	int printed = 2, queue_len = 0;
>  	int more = 0;
> @@ -1357,7 +1347,8 @@ static void FILE__write_graph(void *fp, int graph)
>  	fputs(s, fp);
>  }
>  
> -static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
> +static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
> +				     struct annotation_print_data *apd)
>  {
>  	struct annotation *notes = symbol__annotation(sym);
>  	struct annotation_write_ops wops = {
> @@ -1374,7 +1365,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
>  	list_for_each_entry(al, &notes->src->source, node) {
>  		if (annotation_line__filter(al))
>  			continue;
> -		annotation_line__write(al, notes, &wops);
> +		annotation_line__write(al, notes, &wops, apd);
>  		fputc('\n', fp);
>  		wops.first_line = false;
>  	}
> @@ -1382,13 +1373,18 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
>  	return 0;
>  }
>  
> -int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
> +int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
> +				struct hist_entry *he)
>  {
>  	const char *ev_name = evsel__name(evsel);
>  	char buf[1024];
>  	char *filename;
>  	int err = -1;
>  	FILE *fp;
> +	struct annotation_print_data apd = {
> +		.he = he,
> +		.evsel = evsel,
> +	};
>  
>  	if (asprintf(&filename, "%s.annotation", ms->sym->name) < 0)
>  		return -1;
> @@ -1404,7 +1400,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
>  
>  	fprintf(fp, "%s() %s\nEvent: %s\n\n",
>  		ms->sym->name, dso__long_name(map__dso(ms->map)), ev_name);
> -	symbol__annotate_fprintf2(ms->sym, fp);
> +	symbol__annotate_fprintf2(ms->sym, fp, &apd);
>  
>  	fclose(fp);
>  	err = 0;
> @@ -1655,6 +1651,10 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
>  	struct symbol *sym = ms->sym;
>  	struct rb_root source_line = RB_ROOT;
>  	struct hists *hists = evsel__hists(evsel);
> +	struct annotation_print_data apd = {
> +		.he = he,
> +		.evsel = evsel,
> +	};
>  	char buf[1024];
>  	int err;
>  
> @@ -1677,7 +1677,7 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel)
>  	hists__scnprintf_title(hists, buf, sizeof(buf));
>  	fprintf(stdout, "%s, [percent: %s]\n%s() %s\n",
>  		buf, percent_type_str(annotate_opts.percent_type), sym->name, dso__long_name(dso));
> -	symbol__annotate_fprintf2(sym, stdout);
> +	symbol__annotate_fprintf2(sym, stdout, &apd);
>  
>  	annotated_source__purge(symbol__annotation(sym)->src);
>  
> @@ -1935,7 +1935,8 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr,
>  }
>  
>  void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> -			    struct annotation_write_ops *wops)
> +			    struct annotation_write_ops *wops,
> +			    struct annotation_print_data *apd)
>  {
>  	bool current_entry = wops->current_entry;
>  	double percent_max = annotation_line__max_percent(al, annotate_opts.percent_type);
> @@ -2112,6 +2113,8 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
>  		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
>  
>  		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width - 3 - printed, bf);
> +
> +		(void)apd;
>  	}
>  
>  }
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 9cd723b8b987db1a..bc195bd0429e039d 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -199,8 +199,18 @@ struct annotation_write_ops {
>  	void (*write_graph)(void *obj, int graph);
>  };
>  
> +struct annotation_print_data {
> +	struct hist_entry *he;
> +	struct evsel *evsel;
> +	struct arch *arch;
> +	struct debuginfo *dbg;
> +	u64 start;
> +	int addr_fmt_width;
> +};
> +
>  void annotation_line__write(struct annotation_line *al, struct annotation *notes,
> -			    struct annotation_write_ops *ops);
> +			    struct annotation_write_ops *ops,
> +			    struct annotation_print_data *apd);
>  
>  int __annotation__scnprintf_samples_period(struct annotation *notes,
>  					   char *bf, size_t size,
> @@ -462,7 +472,8 @@ void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel);
>  void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel);
>  void annotated_source__purge(struct annotated_source *as);
>  
> -int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
> +int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
> +				struct hist_entry *he);
>  
>  bool ui__has_annotation(void);
>  
> -- 
> 2.49.0
