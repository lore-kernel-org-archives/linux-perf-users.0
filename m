Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631F188A18;
	Fri, 17 Jan 2025 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136661; cv=none; b=n4PtVjM57/I28ZKr1cj08n5n2fkFQpbnzlMA0P4QjQiBWTKlESFy56soj481Lw7jXAVpF7bArH8+7Z2pNPA9eDSm7gKdUF63Xlya7iJA5qBKKUHyDDE6efNZMHrc+bs3W5OW508oawx4VSSZ4qxEbrJqIE/nWQ+ZC67+gfl6jhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136661; c=relaxed/simple;
	bh=/8nb1Hi+e5OPNll+e4+06c2wmLI/7xOrSeduMF6Rgqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOvwlA8HLooCmcuE9CswCU3D+ZoK9/xc/6wNlzcHWuIVU6/2U1W5pXXWjnzipwUYVaepzdKv1m5FpB/b4BOKf5AXOC/fzfQiNYUvNGTnRt79l+tAiZWCBLDJ3rHtqXULyAKdopMDPfVZaTaIM3RIAQnr3lzUL7gFSLTZgZ4MINI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OieTG3A7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OieTG3A7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6FAC4CEE0;
	Fri, 17 Jan 2025 17:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737136660;
	bh=/8nb1Hi+e5OPNll+e4+06c2wmLI/7xOrSeduMF6Rgqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OieTG3A7Oq+OjenTXi6Ki3/KMyImZZo1B6Kwq8NMUjgPe9jVnSuyFjVOZ9azPNs40
	 xIE9UQRZXqKxX3HKp9TPV7HqFBCp07kf56/aHcMjUdbrklRFnPemJc2vusyxCIrBPd
	 LV8yrucXAbwT05CXuBhOdA7u0Zr7mPvQTQOSEQwJlwi4LlUqi+Zq50kurSpmhX1p71
	 IWjhehcIRM48xu4vGoCBFDk+r7j/c4iu19c2PBu8p+Ok1zzCZKs0XJ5SAqCqJEhC6g
	 kgO1b3bzFA0rV7OQRh+NpWYDDhOZ+6Mi2JCpzqjTspz/LzisMYN8pQ+cMrKqALXG0I
	 4nYTk7zY/QeHg==
Date: Fri, 17 Jan 2025 09:57:38 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Chen Ni <nichen@iscas.ac.cn>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf annotate: Prefer passing evsel to evsel->core.idx
Message-ID: <Z4qaEsrLSgymjqB5@google.com>
References: <20250106223021.458674-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106223021.458674-1-irogers@google.com>

Hi Ian,

On Mon, Jan 06, 2025 at 02:30:21PM -0800, Ian Rogers wrote:
> An evsel idx may not be stable due to sorting, evlist removal,
> etc. Try to reduce it being part of APIs by explicitly passing the
> evsel in annotate code. Internally the code just reads evsel->core.idx
> so behavior is unchanged.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2. Fix gtk build issue reported by Arnaldo.

Unfortunately not.

  ui/gtk/annotate.c: In function 'perf_gtk__get_percent':
  ui/gtk/annotate.c:45:48: error: 'evset' undeclared (first use in this function); did you mean 'evsel'?
     45 |         symhist = annotation__histogram(notes, evset);
        |                                                ^~~~~
  --
  ui/gtk/annotate.c: In function 'perf_gtk__annotate_symbol':
  linux/tools/perf/util/evsel.h:490:70: error: invalid use of undefined type 'struct evlist'
    490 |         for_each_group_evsel_head(_evsel, _leader, &(_leader)->evlist->core.entries)
        |                                                                      ^~
  linux/tools/perf/util/evsel.h:485:46: note: in definition of macro 'for_each_group_evsel_head'
    485 |         (_evsel) && &(_evsel)->core.node != (_head) &&                                  \
        |                                              ^~~~~
  ui/gtk/annotate.c:144:25: note: in expansion of macro 'for_each_group_evsel'
    144 |                         for_each_group_evsel(cur_evsel, evsel__leader(evsel)) {
        |                         ^~~~~~~~~~~~~~~~~~~~
  make[6]: *** [linux/tools/build/Makefile.build:85: ui/gtk/annotate.o] Error 1

Thanks,
Namhyung

> ---
>  tools/perf/builtin-top.c          |  4 ++--
>  tools/perf/ui/browsers/annotate.c |  2 +-
>  tools/perf/ui/gtk/annotate.c      | 15 ++++++++-------
>  tools/perf/util/annotate.c        | 32 +++++++++++++++----------------
>  tools/perf/util/annotate.h        | 20 ++++++++++---------
>  5 files changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 724a79386321..881e6cf26979 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -267,9 +267,9 @@ static void perf_top__show_details(struct perf_top *top)
>  
>  	if (top->evlist->enabled) {
>  		if (top->zero)
> -			symbol__annotate_zero_histogram(symbol, top->sym_evsel->core.idx);
> +			symbol__annotate_zero_histogram(symbol, top->sym_evsel);
>  		else
> -			symbol__annotate_decay_histogram(symbol, top->sym_evsel->core.idx);
> +			symbol__annotate_decay_histogram(symbol, top->sym_evsel);
>  	}
>  	if (more != 0)
>  		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index d7e727345dab..135d6ce88fb3 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -754,7 +754,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  				hbt->timer(hbt->arg);
>  
>  			if (delay_secs != 0) {
> -				symbol__annotate_decay_histogram(sym, evsel->core.idx);
> +				symbol__annotate_decay_histogram(sym, evsel);
>  				hists__scnprintf_title(hists, title, sizeof(title));
>  				annotate_browser__show(&browser->b, title, help);
>  			}
> diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
> index 6da24aa039eb..6db76fadbbee 100644
> --- a/tools/perf/ui/gtk/annotate.c
> +++ b/tools/perf/ui/gtk/annotate.c
> @@ -26,7 +26,7 @@ static const char *const col_names[] = {
>  };
>  
>  static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
> -				 struct disasm_line *dl, int evidx)
> +				 struct disasm_line *dl, const struct evsel *evsel)
>  {
>  	struct annotation *notes;
>  	struct sym_hist *symhist;
> @@ -42,8 +42,8 @@ static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
>  		return 0;
>  
>  	notes = symbol__annotation(sym);
> -	symhist = annotation__histogram(notes, evidx);
> -	entry = annotated_source__hist_entry(notes->src, evidx, dl->al.offset);
> +	symhist = annotation__histogram(notes, evset);
> +	entry = annotated_source__hist_entry(notes->src, evsel, dl->al.offset);
>  	if (entry)
>  		nr_samples = entry->nr_samples;
>  
> @@ -139,16 +139,17 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
>  		gtk_list_store_append(store, &iter);
>  
>  		if (evsel__is_group_event(evsel)) {
> -			for (i = 0; i < evsel->core.nr_members; i++) {
> +			struct evsel *cur_evsel;
> +
> +			for_each_group_evsel(cur_evsel, evsel__leader(evsel)) {
>  				ret += perf_gtk__get_percent(s + ret,
>  							     sizeof(s) - ret,
>  							     sym, pos,
> -							     evsel->core.idx + i);
> +							     cur_evsel);
>  				ret += scnprintf(s + ret, sizeof(s) - ret, " ");
>  			}
>  		} else {
> -			ret = perf_gtk__get_percent(s, sizeof(s), sym, pos,
> -						    evsel->core.idx);
> +			ret = perf_gtk__get_percent(s, sizeof(s), sym, pos, evsel);
>  		}
>  
>  		if (ret)
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 32e15c9f53f3..0d2ea22bd9e4 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -209,7 +209,7 @@ static int __symbol__account_cycles(struct cyc_hist *ch,
>  }
>  
>  static int __symbol__inc_addr_samples(struct map_symbol *ms,
> -				      struct annotated_source *src, int evidx, u64 addr,
> +				      struct annotated_source *src, struct evsel *evsel, u64 addr,
>  				      struct perf_sample *sample)
>  {
>  	struct symbol *sym = ms->sym;
> @@ -228,14 +228,14 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
>  	}
>  
>  	offset = addr - sym->start;
> -	h = annotated_source__histogram(src, evidx);
> +	h = annotated_source__histogram(src, evsel);
>  	if (h == NULL) {
>  		pr_debug("%s(%d): ENOMEM! sym->name=%s, start=%#" PRIx64 ", addr=%#" PRIx64 ", end=%#" PRIx64 ", func: %d\n",
>  			 __func__, __LINE__, sym->name, sym->start, addr, sym->end, sym->type == STT_FUNC);
>  		return -ENOMEM;
>  	}
>  
> -	hash_key = offset << 16 | evidx;
> +	hash_key = offset << 16 | evsel->core.idx;
>  	if (!hashmap__find(src->samples, hash_key, &entry)) {
>  		entry = zalloc(sizeof(*entry));
>  		if (entry == NULL)
> @@ -252,7 +252,7 @@ static int __symbol__inc_addr_samples(struct map_symbol *ms,
>  
>  	pr_debug3("%#" PRIx64 " %s: period++ [addr: %#" PRIx64 ", %#" PRIx64
>  		  ", evidx=%d] => nr_samples: %" PRIu64 ", period: %" PRIu64 "\n",
> -		  sym->start, sym->name, addr, addr - sym->start, evidx,
> +		  sym->start, sym->name, addr, addr - sym->start, evsel->core.idx,
>  		  entry->nr_samples, entry->period);
>  	return 0;
>  }
> @@ -323,7 +323,7 @@ static int symbol__inc_addr_samples(struct map_symbol *ms,
>  	if (sym == NULL)
>  		return 0;
>  	src = symbol__hists(sym, evsel->evlist->core.nr_entries);
> -	return src ? __symbol__inc_addr_samples(ms, src, evsel->core.idx, addr, sample) : 0;
> +	return src ? __symbol__inc_addr_samples(ms, src, evsel, addr, sample) : 0;
>  }
>  
>  static int symbol__account_br_cntr(struct annotated_branch *branch,
> @@ -861,15 +861,14 @@ static void calc_percent(struct annotation *notes,
>  			 s64 offset, s64 end)
>  {
>  	struct hists *hists = evsel__hists(evsel);
> -	int evidx = evsel->core.idx;
> -	struct sym_hist *sym_hist = annotation__histogram(notes, evidx);
> +	struct sym_hist *sym_hist = annotation__histogram(notes, evsel);
>  	unsigned int hits = 0;
>  	u64 period = 0;
>  
>  	while (offset < end) {
>  		struct sym_hist_entry *entry;
>  
> -		entry = annotated_source__hist_entry(notes->src, evidx, offset);
> +		entry = annotated_source__hist_entry(notes->src, evsel, offset);
>  		if (entry) {
>  			hits   += entry->nr_samples;
>  			period += entry->period;
> @@ -1140,15 +1139,14 @@ static void print_summary(struct rb_root *root, const char *filename)
>  
>  static void symbol__annotate_hits(struct symbol *sym, struct evsel *evsel)
>  {
> -	int evidx = evsel->core.idx;
>  	struct annotation *notes = symbol__annotation(sym);
> -	struct sym_hist *h = annotation__histogram(notes, evidx);
> +	struct sym_hist *h = annotation__histogram(notes, evsel);
>  	u64 len = symbol__size(sym), offset;
>  
>  	for (offset = 0; offset < len; ++offset) {
>  		struct sym_hist_entry *entry;
>  
> -		entry = annotated_source__hist_entry(notes->src, evidx, offset);
> +		entry = annotated_source__hist_entry(notes->src, evsel, offset);
>  		if (entry && entry->nr_samples != 0)
>  			printf("%*" PRIx64 ": %" PRIu64 "\n", BITS_PER_LONG / 2,
>  			       sym->start + offset, entry->nr_samples);
> @@ -1178,7 +1176,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel)
>  	const char *d_filename;
>  	const char *evsel_name = evsel__name(evsel);
>  	struct annotation *notes = symbol__annotation(sym);
> -	struct sym_hist *h = annotation__histogram(notes, evsel->core.idx);
> +	struct sym_hist *h = annotation__histogram(notes, evsel);
>  	struct annotation_line *pos, *queue = NULL;
>  	struct annotation_options *opts = &annotate_opts;
>  	u64 start = map__rip_2objdump(map, sym->start);
> @@ -1364,18 +1362,18 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel)
>  	return err;
>  }
>  
> -void symbol__annotate_zero_histogram(struct symbol *sym, int evidx)
> +void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel)
>  {
>  	struct annotation *notes = symbol__annotation(sym);
> -	struct sym_hist *h = annotation__histogram(notes, evidx);
> +	struct sym_hist *h = annotation__histogram(notes, evsel);
>  
>  	memset(h, 0, sizeof(*notes->src->histograms) * notes->src->nr_histograms);
>  }
>  
> -void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
> +void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel)
>  {
>  	struct annotation *notes = symbol__annotation(sym);
> -	struct sym_hist *h = annotation__histogram(notes, evidx);
> +	struct sym_hist *h = annotation__histogram(notes, evsel);
>  	struct annotation_line *al;
>  
>  	h->nr_samples = 0;
> @@ -1385,7 +1383,7 @@ void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
>  		if (al->offset == -1)
>  			continue;
>  
> -		entry = annotated_source__hist_entry(notes->src, evidx, al->offset);
> +		entry = annotated_source__hist_entry(notes->src, evsel, al->offset);
>  		if (entry == NULL)
>  			continue;
>  
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index c6a59aaefdb8..0ba5846dad4d 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -15,6 +15,7 @@
>  #include "hashmap.h"
>  #include "disasm.h"
>  #include "branch.h"
> +#include "evsel.h"
>  
>  struct hist_browser_timer;
>  struct hist_entry;
> @@ -23,7 +24,6 @@ struct map_symbol;
>  struct addr_map_symbol;
>  struct option;
>  struct perf_sample;
> -struct evsel;
>  struct symbol;
>  struct annotated_data_type;
>  
> @@ -373,21 +373,23 @@ static inline u8 annotation__br_cntr_width(void)
>  void annotation__update_column_widths(struct annotation *notes);
>  void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms);
>  
> -static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
> +static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src,
> +							   const struct evsel *evsel)
>  {
> -	return &src->histograms[idx];
> +	return &src->histograms[evsel->core.idx];
>  }
>  
> -static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
> +static inline struct sym_hist *annotation__histogram(struct annotation *notes,
> +						     const struct evsel *evsel)
>  {
> -	return annotated_source__histogram(notes->src, idx);
> +	return annotated_source__histogram(notes->src, evsel);
>  }
>  
>  static inline struct sym_hist_entry *
> -annotated_source__hist_entry(struct annotated_source *src, int idx, u64 offset)
> +annotated_source__hist_entry(struct annotated_source *src, const struct evsel *evsel, u64 offset)
>  {
>  	struct sym_hist_entry *entry;
> -	long key = offset << 16 | idx;
> +	long key = offset << 16 | evsel->core.idx;
>  
>  	if (!hashmap__find(src->samples, key, &entry))
>  		return NULL;
> @@ -449,8 +451,8 @@ enum symbol_disassemble_errno {
>  int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, size_t buflen);
>  
>  int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel);
> -void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
> -void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
> +void symbol__annotate_zero_histogram(struct symbol *sym, struct evsel *evsel);
> +void symbol__annotate_decay_histogram(struct symbol *sym, struct evsel *evsel);
>  void annotated_source__purge(struct annotated_source *as);
>  
>  int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel);
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
