From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 3/7] perf report: create real callchain entries for
 inlined frames
Date: Mon, 22 May 2017 21:19:46 +0900
Message-ID: <20170522121946.GD20009@sejong>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
 <20170518193411.22380-4-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:38325 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbdEVMTu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2017 08:19:50 -0400
Content-Disposition: inline
In-Reply-To: <20170518193411.22380-4-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Thu, May 18, 2017 at 09:34:07PM +0200, Milian Wolff wrote:
> +
> +	if (strcmp(funcname, base_sym->name) == 0) {
> +		// reuse the real, existing symbol

I don't know whether it's required by coding style guide but please
use C-style block comment if possible (especially for multiline comments).


> +		inline_sym = base_sym;
> +	} else {
> +		// create a fake symbol for the inline frame
> +		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
> +					 base_sym ? base_sym->end : 0,
> +					 base_sym ? base_sym->binding : 0,
> +					 funcname);
> +		if (inline_sym)
> +			inline_sym->inlined = 1;
> +	}
> +
> +	free(demangled);
> +
> +	return inline_sym;
> +}
> +
>  static int inline_list__append_dso_a2l(struct dso *dso,
> -				       struct inline_node *node)
> +				       struct inline_node *node,
> +				       struct symbol *sym)
>  {
>  	struct a2l_data *a2l = dso->a2l;
> -	char *funcname = a2l->funcname ? strdup(a2l->funcname) : NULL;
>  	char *filename = a2l->filename ? strdup(a2l->filename) : NULL;
> +	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
>  
> -	return inline_list__append(filename, funcname, a2l->line, node, dso);
> +	return inline_list__append(inline_sym, filename, a2l->line, node);
>  }
>  
>  static int addr2line(const char *dso_name, u64 addr,
>  		     char **file, unsigned int *line, struct dso *dso,
> -		     bool unwind_inlines, struct inline_node *node)
> +		     bool unwind_inlines, struct inline_node *node,
> +		     struct symbol *sym)
>  {
>  	int ret = 0;
>  	struct a2l_data *a2l = dso->a2l;
> @@ -241,7 +264,7 @@ static int addr2line(const char *dso_name, u64 addr,
>  	if (unwind_inlines) {
>  		int cnt = 0;
>  
> -		if (node && inline_list__append_dso_a2l(dso, node))
> +		if (node && inline_list__append_dso_a2l(dso, node, sym))
>  			return 0;
>  
>  		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
> @@ -249,7 +272,7 @@ static int addr2line(const char *dso_name, u64 addr,
>  		       cnt++ < MAX_INLINE_NEST) {
>  
>  			if (node != NULL) {
> -				if (inline_list__append_dso_a2l(dso, node))
> +				if (inline_list__append_dso_a2l(dso, node, sym))
>  					return 0;
>  				// found at least one inline frame
>  				ret = 1;
> @@ -281,7 +304,7 @@ void dso__free_a2l(struct dso *dso)
>  }
>  
>  static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
> -	struct dso *dso)
> +	struct dso *dso, struct symbol *sym)
>  {
>  	struct inline_node *node;
>  
> @@ -294,7 +317,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
>  	INIT_LIST_HEAD(&node->val);
>  	node->addr = addr;
>  
> -	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node))
> +	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node, sym))
>  		goto out_free_inline_node;
>  
>  	if (list_empty(&node->val))
> @@ -334,7 +357,8 @@ static int addr2line(const char *dso_name, u64 addr,
>  		     char **file, unsigned int *line_nr,
>  		     struct dso *dso __maybe_unused,
>  		     bool unwind_inlines __maybe_unused,
> -		     struct inline_node *node __maybe_unused)
> +		     struct inline_node *node __maybe_unused,
> +		     struct symbol *sym __maybe_unused)
>  {
>  	FILE *fp;
>  	char cmd[PATH_MAX];
> @@ -374,7 +398,7 @@ void dso__free_a2l(struct dso *dso __maybe_unused)
>  }
>  
>  static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
> -	struct dso *dso __maybe_unused)
> +	struct dso *dso __maybe_unused, struct symbol *sym)
>  {
>  	FILE *fp;
>  	char cmd[PATH_MAX];
> @@ -407,8 +431,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
>  			goto out;
>  		}
>  
> -		if (inline_list__append(filename, NULL, line_nr, node,
> -					NULL) != 0)
> +		if (inline_list__append(sym, filename, line_nr, node) != 0)
>  			goto out;
>  
>  		filename = NULL;
> @@ -448,7 +471,8 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
>  	if (dso_name == NULL)
>  		goto out;
>  
> -	if (!addr2line(dso_name, addr, &file, &line, dso, unwind_inlines, NULL))
> +	if (!addr2line(dso_name, addr, &file, &line, dso,
> +		       unwind_inlines, NULL, sym))
>  		goto out;
>  
>  	if (asprintf(&srcline, "%s:%u",
> @@ -494,7 +518,8 @@ char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
>  	return __get_srcline(dso, addr, sym, show_sym, show_addr, false);
>  }
>  
> -struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
> +struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
> +					    struct symbol *sym)
>  {
>  	const char *dso_name;
>  
> @@ -502,7 +527,7 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
>  	if (dso_name == NULL)
>  		return NULL;
>  
> -	return addr2inlines(dso_name, addr, dso);
> +	return addr2inlines(dso_name, addr, dso, sym);
>  }
>  
>  void inline_node__delete(struct inline_node *node)
> @@ -512,9 +537,62 @@ void inline_node__delete(struct inline_node *node)
>  	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
>  		list_del_init(&ilist->list);
>  		zfree(&ilist->filename);
> -		zfree(&ilist->funcname);
> +		// only the inlined symbols are owned by the list
> +		if (ilist->symbol && ilist->symbol->inlined)
> +			symbol__delete(ilist->symbol);
>  		free(ilist);
>  	}
>  
>  	free(node);
>  }
> +
> +void inlines__tree_insert(struct rb_root *tree, struct inline_node *inlines)
> +{
> +	struct rb_node **p = &tree->rb_node;
> +	struct rb_node *parent = NULL;
> +	const u64 addr = inlines->addr;
> +	struct inline_node *i;
> +
> +	while (*p != NULL) {
> +		parent = *p;
> +		i = rb_entry(parent, struct inline_node, rb_node);
> +		if (addr < i->addr)
> +			p = &(*p)->rb_left;
> +		else
> +			p = &(*p)->rb_right;
> +	}
> +	rb_link_node(&inlines->rb_node, parent, p);
> +	rb_insert_color(&inlines->rb_node, tree);
> +}
> +
> +struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr)
> +{
> +	struct rb_node *n = tree->rb_node;
> +
> +	while (n) {
> +		struct inline_node *i = rb_entry(n, struct inline_node,
> +						 rb_node);
> +
> +		if (addr < i->addr)
> +			n = n->rb_left;
> +		else if (addr > i->addr)
> +			n = n->rb_right;
> +		else
> +			return i;
> +	}
> +
> +	return NULL;
> +}
> +
> +void inlines__tree_delete(struct rb_root *tree)
> +{
> +	struct inline_node *pos;
> +	struct rb_node *next = rb_first(tree);
> +
> +	while (next) {
> +		pos = rb_entry(next, struct inline_node, rb_node);
> +		next = rb_next(&pos->rb_node);
> +		rb_erase(&pos->rb_node, tree);
> +		inline_node__delete(pos);
> +	}
> +}
> diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
> index 7b52ba88676e..ad9726987b80 100644
> --- a/tools/perf/util/srcline.h
> +++ b/tools/perf/util/srcline.h
> @@ -2,6 +2,7 @@
>  #define PERF_SRCLINE_H
>  
>  #include <linux/list.h>
> +#include <linux/rbtree.h>
>  #include <linux/types.h>
>  
>  struct dso;
> @@ -17,8 +18,8 @@ void free_srcline(char *srcline);
>  #define SRCLINE_UNKNOWN  ((char *) "??:0")
>  
>  struct inline_list {
> +	struct symbol		*symbol;
>  	char			*filename;
> -	char			*funcname;
>  	unsigned int		line_nr;
>  	struct list_head	list;
>  };
> @@ -26,9 +27,20 @@ struct inline_list {
>  struct inline_node {
>  	u64			addr;
>  	struct list_head	val;
> +	struct rb_node		rb_node;
>  };
>  
> -struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr);
> +// parse inlined frames for the given address
> +struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
> +					    struct symbol *sym);
> +// free resources associated to the inline node list
>  void inline_node__delete(struct inline_node *node);
>  
> +// insert the inline node list into the DSO, which will take ownership
> +void inlines__tree_insert(struct rb_root *tree, struct inline_node *inlines);
> +// find previously inserted inline node list
> +struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr);
> +// delete all nodes within the tree of inline_node s
> +void inlines__tree_delete(struct rb_root *tree);
> +
>  #endif /* PERF_SRCLINE_H */
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index f0b08810d7fa..b358570ce615 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -59,6 +59,7 @@ struct symbol {
>  	u8		binding;
>  	u8		idle:1;
>  	u8		ignore:1;
> +	u8		inlined:1;
>  	u8		arch_sym;
>  	char		name[0];
>  };
> -- 
> 2.13.0
> 
