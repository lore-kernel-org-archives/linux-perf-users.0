From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 01/13] perf report: remove code to handle inline
 frames from browsers
Date: Mon, 18 Sep 2017 13:56:19 +0200
Message-ID: <20170918115619.GA7595@krava>
References: <20170906135501.306-1-milian.wolff@kdab.com>
 <20170906135501.306-2-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170906135501.306-2-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Sep 06, 2017 at 03:54:49PM +0200, Milian Wolff wrote:
> The follow-up commits will make inline frames first-class citizens
> in the callchain, thereby obsoleting all of this special code.

so you're removing all the inline callchain implementation
in this patch and adding it back in following patches?

any chance you could change it gradualy? it's hard to track
in review if you added everything that you removed ;-)

jirka

> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/ui/browsers/hists.c  | 180 +++-------------------------------------
>  tools/perf/ui/stdio/hist.c      |  77 +----------------
>  tools/perf/util/evsel_fprintf.c |  32 -------
>  tools/perf/util/hist.c          |   5 --
>  tools/perf/util/sort.h          |   1 -
>  5 files changed, 13 insertions(+), 282 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 13dfb0a0bdeb..3a433f370e7f 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -154,57 +154,9 @@ static void callchain_list__set_folding(struct callchain_list *cl, bool unfold)
>  	cl->unfolded = unfold ? cl->has_children : false;
>  }
>  
> -static struct inline_node *inline_node__create(struct map *map, u64 ip)
> -{
> -	struct dso *dso;
> -	struct inline_node *node;
> -
> -	if (map == NULL)
> -		return NULL;
> -
> -	dso = map->dso;
> -	if (dso == NULL)
> -		return NULL;
> -
> -	node = dso__parse_addr_inlines(dso,
> -				       map__rip_2objdump(map, ip));
> -
> -	return node;
> -}
> -
> -static int inline__count_rows(struct inline_node *node)
> -{
> -	struct inline_list *ilist;
> -	int i = 0;
> -
> -	if (node == NULL)
> -		return 0;
> -
> -	list_for_each_entry(ilist, &node->val, list) {
> -		if ((ilist->filename != NULL) || (ilist->funcname != NULL))
> -			i++;
> -	}
> -
> -	return i;
> -}
> -
> -static int callchain_list__inline_rows(struct callchain_list *chain)
> -{
> -	struct inline_node *node;
> -	int rows;
> -
> -	node = inline_node__create(chain->ms.map, chain->ip);
> -	if (node == NULL)
> -		return 0;
> -
> -	rows = inline__count_rows(node);
> -	inline_node__delete(node);
> -	return rows;
> -}
> -
>  static int callchain_node__count_rows_rb_tree(struct callchain_node *node)
>  {
> -	int n = 0, inline_rows;
> +	int n = 0;
>  	struct rb_node *nd;
>  
>  	for (nd = rb_first(&node->rb_root); nd; nd = rb_next(nd)) {
> @@ -215,12 +167,6 @@ static int callchain_node__count_rows_rb_tree(struct callchain_node *node)
>  		list_for_each_entry(chain, &child->val, list) {
>  			++n;
>  
> -			if (symbol_conf.inline_name) {
> -				inline_rows =
> -					callchain_list__inline_rows(chain);
> -				n += inline_rows;
> -			}
> -
>  			/* We need this because we may not have children */
>  			folded_sign = callchain_list__folded(chain);
>  			if (folded_sign == '+')
> @@ -272,7 +218,7 @@ static int callchain_node__count_rows(struct callchain_node *node)
>  {
>  	struct callchain_list *chain;
>  	bool unfolded = false;
> -	int n = 0, inline_rows;
> +	int n = 0;
>  
>  	if (callchain_param.mode == CHAIN_FLAT)
>  		return callchain_node__count_flat_rows(node);
> @@ -281,10 +227,6 @@ static int callchain_node__count_rows(struct callchain_node *node)
>  
>  	list_for_each_entry(chain, &node->val, list) {
>  		++n;
> -		if (symbol_conf.inline_name) {
> -			inline_rows = callchain_list__inline_rows(chain);
> -			n += inline_rows;
> -		}
>  
>  		unfolded = chain->unfolded;
>  	}
> @@ -432,19 +374,6 @@ static void hist_entry__init_have_children(struct hist_entry *he)
>  	he->init_have_children = true;
>  }
>  
> -static void hist_entry_init_inline_node(struct hist_entry *he)
> -{
> -	if (he->inline_node)
> -		return;
> -
> -	he->inline_node = inline_node__create(he->ms.map, he->ip);
> -
> -	if (he->inline_node == NULL)
> -		return;
> -
> -	he->has_children = true;
> -}
> -
>  static bool hist_browser__toggle_fold(struct hist_browser *browser)
>  {
>  	struct hist_entry *he = browser->he_selection;
> @@ -476,12 +405,8 @@ static bool hist_browser__toggle_fold(struct hist_browser *browser)
>  
>  		if (he->unfolded) {
>  			if (he->leaf)
> -				if (he->inline_node)
> -					he->nr_rows = inline__count_rows(
> -							he->inline_node);
> -				else
> -					he->nr_rows = callchain__count_rows(
> -							&he->sorted_chain);
> +				he->nr_rows = callchain__count_rows(
> +						&he->sorted_chain);
>  			else
>  				he->nr_rows = hierarchy_count_rows(browser, he, false);
>  
> @@ -841,71 +766,6 @@ static bool hist_browser__check_dump_full(struct hist_browser *browser __maybe_u
>  
>  #define LEVEL_OFFSET_STEP 3
>  
> -static int hist_browser__show_inline(struct hist_browser *browser,
> -				     struct inline_node *node,
> -				     unsigned short row,
> -				     int offset)
> -{
> -	struct inline_list *ilist;
> -	char buf[1024];
> -	int color, width, first_row;
> -
> -	first_row = row;
> -	width = browser->b.width - (LEVEL_OFFSET_STEP + 2);
> -	list_for_each_entry(ilist, &node->val, list) {
> -		if ((ilist->filename != NULL) || (ilist->funcname != NULL)) {
> -			color = HE_COLORSET_NORMAL;
> -			if (ui_browser__is_current_entry(&browser->b, row))
> -				color = HE_COLORSET_SELECTED;
> -
> -			if (callchain_param.key == CCKEY_ADDRESS ||
> -			    callchain_param.key == CCKEY_SRCLINE) {
> -				if (ilist->filename != NULL)
> -					scnprintf(buf, sizeof(buf),
> -						  "%s:%d (inline)",
> -						  ilist->filename,
> -						  ilist->line_nr);
> -				else
> -					scnprintf(buf, sizeof(buf), "??");
> -			} else if (ilist->funcname != NULL)
> -				scnprintf(buf, sizeof(buf), "%s (inline)",
> -					  ilist->funcname);
> -			else if (ilist->filename != NULL)
> -				scnprintf(buf, sizeof(buf),
> -					  "%s:%d (inline)",
> -					  ilist->filename,
> -					  ilist->line_nr);
> -			else
> -				scnprintf(buf, sizeof(buf), "??");
> -
> -			ui_browser__set_color(&browser->b, color);
> -			hist_browser__gotorc(browser, row, 0);
> -			ui_browser__write_nstring(&browser->b, " ",
> -				LEVEL_OFFSET_STEP + offset);
> -			ui_browser__write_nstring(&browser->b, buf, width);
> -			row++;
> -		}
> -	}
> -
> -	return row - first_row;
> -}
> -
> -static size_t show_inline_list(struct hist_browser *browser, struct map *map,
> -			       u64 ip, int row, int offset)
> -{
> -	struct inline_node *node;
> -	int ret;
> -
> -	node = inline_node__create(map, ip);
> -	if (node == NULL)
> -		return 0;
> -
> -	ret = hist_browser__show_inline(browser, node, row, offset);
> -
> -	inline_node__delete(node);
> -	return ret;
> -}
> -
>  static int hist_browser__show_callchain_list(struct hist_browser *browser,
>  					     struct callchain_node *node,
>  					     struct callchain_list *chain,
> @@ -917,7 +777,7 @@ static int hist_browser__show_callchain_list(struct hist_browser *browser,
>  	char bf[1024], *alloc_str;
>  	char buf[64], *alloc_str2;
>  	const char *str;
> -	int inline_rows = 0, ret = 1;
> +	int ret = 1;
>  
>  	if (arg->row_offset != 0) {
>  		arg->row_offset--;
> @@ -954,12 +814,7 @@ static int hist_browser__show_callchain_list(struct hist_browser *browser,
>  	free(alloc_str);
>  	free(alloc_str2);
>  
> -	if (symbol_conf.inline_name) {
> -		inline_rows = show_inline_list(browser, chain->ms.map,
> -					       chain->ip, row + 1, offset);
> -	}
> -
> -	return ret + inline_rows;
> +	return ret;
>  }
>  
>  static bool check_percent_display(struct rb_node *node, u64 parent_total)
> @@ -1383,12 +1238,6 @@ static int hist_browser__show_entry(struct hist_browser *browser,
>  		folded_sign = hist_entry__folded(entry);
>  	}
>  
> -	if (symbol_conf.inline_name &&
> -	    (!entry->has_children)) {
> -		hist_entry_init_inline_node(entry);
> -		folded_sign = hist_entry__folded(entry);
> -	}
> -
>  	if (row_offset == 0) {
>  		struct hpp_arg arg = {
>  			.b		= &browser->b,
> @@ -1420,8 +1269,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
>  			}
>  
>  			if (first) {
> -				if (symbol_conf.use_callchain ||
> -					symbol_conf.inline_name) {
> +				if (symbol_conf.use_callchain) {
>  					ui_browser__printf(&browser->b, "%c ", folded_sign);
>  					width -= 2;
>  				}
> @@ -1463,15 +1311,11 @@ static int hist_browser__show_entry(struct hist_browser *browser,
>  			.is_current_entry = current_entry,
>  		};
>  
> -		if (entry->inline_node)
> -			printed += hist_browser__show_inline(browser,
> -					entry->inline_node, row, 0);
> -		else
> -			printed += hist_browser__show_callchain(browser,
> -					entry, 1, row,
> -					hist_browser__show_callchain_entry,
> -					&arg,
> -					hist_browser__check_output_full);
> +		printed += hist_browser__show_callchain(browser,
> +				entry, 1, row,
> +				hist_browser__show_callchain_entry,
> +				&arg,
> +				hist_browser__check_output_full);
>  	}
>  
>  	return printed;
> diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
> index 8bdb7a500181..b6b9baac0e3b 100644
> --- a/tools/perf/ui/stdio/hist.c
> +++ b/tools/perf/ui/stdio/hist.c
> @@ -21,64 +21,6 @@ static size_t callchain__fprintf_left_margin(FILE *fp, int left_margin)
>  	return ret;
>  }
>  
> -static size_t inline__fprintf(struct map *map, u64 ip, int left_margin,
> -			      int depth, int depth_mask, FILE *fp)
> -{
> -	struct dso *dso;
> -	struct inline_node *node;
> -	struct inline_list *ilist;
> -	int ret = 0, i;
> -
> -	if (map == NULL)
> -		return 0;
> -
> -	dso = map->dso;
> -	if (dso == NULL)
> -		return 0;
> -
> -	node = dso__parse_addr_inlines(dso,
> -				       map__rip_2objdump(map, ip));
> -	if (node == NULL)
> -		return 0;
> -
> -	list_for_each_entry(ilist, &node->val, list) {
> -		if ((ilist->filename != NULL) || (ilist->funcname != NULL)) {
> -			ret += callchain__fprintf_left_margin(fp, left_margin);
> -
> -			for (i = 0; i < depth; i++) {
> -				if (depth_mask & (1 << i))
> -					ret += fprintf(fp, "|");
> -				else
> -					ret += fprintf(fp, " ");
> -				ret += fprintf(fp, "          ");
> -			}
> -
> -			if (callchain_param.key == CCKEY_ADDRESS ||
> -			    callchain_param.key == CCKEY_SRCLINE) {
> -				if (ilist->filename != NULL)
> -					ret += fprintf(fp, "%s:%d (inline)",
> -						       ilist->filename,
> -						       ilist->line_nr);
> -				else
> -					ret += fprintf(fp, "??");
> -			} else if (ilist->funcname != NULL)
> -				ret += fprintf(fp, "%s (inline)",
> -					       ilist->funcname);
> -			else if (ilist->filename != NULL)
> -				ret += fprintf(fp, "%s:%d (inline)",
> -					       ilist->filename,
> -					       ilist->line_nr);
> -			else
> -				ret += fprintf(fp, "??");
> -
> -			ret += fprintf(fp, "\n");
> -		}
> -	}
> -
> -	inline_node__delete(node);
> -	return ret;
> -}
> -
>  static size_t ipchain__fprintf_graph_line(FILE *fp, int depth, int depth_mask,
>  					  int left_margin)
>  {
> @@ -137,9 +79,6 @@ static size_t ipchain__fprintf_graph(FILE *fp, struct callchain_node *node,
>  	fputc('\n', fp);
>  	free(alloc_str);
>  
> -	if (symbol_conf.inline_name)
> -		ret += inline__fprintf(chain->ms.map, chain->ip,
> -				       left_margin, depth, depth_mask, fp);
>  	return ret;
>  }
>  
> @@ -314,13 +253,6 @@ static size_t callchain__fprintf_graph(FILE *fp, struct rb_root *root,
>  
>  			if (++entries_printed == callchain_param.print_limit)
>  				break;
> -
> -			if (symbol_conf.inline_name)
> -				ret += inline__fprintf(chain->ms.map,
> -						       chain->ip,
> -						       left_margin,
> -						       0, 0,
> -						       fp);
>  		}
>  		root = &cnode->rb_root;
>  	}
> @@ -600,7 +532,6 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
>  {
>  	int ret;
>  	int callchain_ret = 0;
> -	int inline_ret = 0;
>  	struct perf_hpp hpp = {
>  		.buf		= bf,
>  		.size		= size,
> @@ -622,13 +553,7 @@ static int hist_entry__fprintf(struct hist_entry *he, size_t size,
>  		callchain_ret = hist_entry_callchain__fprintf(he, total_period,
>  							      0, fp);
>  
> -	if (callchain_ret == 0 && symbol_conf.inline_name) {
> -		inline_ret = inline__fprintf(he->ms.map, he->ip, 0, 0, 0, fp);
> -		ret += inline_ret;
> -		if (inline_ret > 0)
> -			ret += fprintf(fp, "\n");
> -	} else
> -		ret += callchain_ret;
> +	ret += callchain_ret;
>  
>  	return ret;
>  }
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index 583f3a602506..f2c6c5ee11e8 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -169,38 +169,6 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (!print_oneline)
>  				printed += fprintf(fp, "\n");
>  
> -			if (symbol_conf.inline_name && node->map) {
> -				struct inline_node *inode;
> -
> -				addr = map__rip_2objdump(node->map, node->ip),
> -				inode = dso__parse_addr_inlines(node->map->dso, addr);
> -
> -				if (inode) {
> -					struct inline_list *ilist;
> -
> -					list_for_each_entry(ilist, &inode->val, list) {
> -						if (print_arrow)
> -							printed += fprintf(fp, " <-");
> -
> -						/* IP is same, just skip it */
> -						if (print_ip)
> -							printed += fprintf(fp, "%c%16s",
> -									   s, "");
> -						if (print_sym)
> -							printed += fprintf(fp, " %s",
> -									   ilist->funcname);
> -						if (print_srcline)
> -							printed += fprintf(fp, "\n  %s:%d",
> -									   ilist->filename,
> -									   ilist->line_nr);
> -						if (!print_oneline)
> -							printed += fprintf(fp, "\n");
> -					}
> -
> -					inline_node__delete(inode);
> -				}
> -			}
> -
>  			if (symbol_conf.bt_stop_list &&
>  			    node->sym &&
>  			    strlist__has_entry(symbol_conf.bt_stop_list,
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index e60d8d8ea4c2..b0fa9c217e1c 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1141,11 +1141,6 @@ void hist_entry__delete(struct hist_entry *he)
>  		zfree(&he->mem_info);
>  	}
>  
> -	if (he->inline_node) {
> -		inline_node__delete(he->inline_node);
> -		he->inline_node = NULL;
> -	}
> -
>  	zfree(&he->stat_acc);
>  	free_srcline(he->srcline);
>  	if (he->srcfile && he->srcfile[0])
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index f36dc4980a6c..507d096aee4e 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -129,7 +129,6 @@ struct hist_entry {
>  	};
>  	char			*srcline;
>  	char			*srcfile;
> -	struct inline_node	*inline_node;
>  	struct symbol		*parent;
>  	struct branch_info	*branch_info;
>  	struct hists		*hists;
> -- 
> 2.14.1
> 
