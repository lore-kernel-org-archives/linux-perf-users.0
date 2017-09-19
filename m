From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 03/13] perf report: create real callchain entries for
 inlined frames
Date: Tue, 19 Sep 2017 14:27:19 +0200
Message-ID: <20170919122719.GB13388@krava>
References: <20170906135501.306-1-milian.wolff@kdab.com>
 <20170906135501.306-4-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbdISM1W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Sep 2017 08:27:22 -0400
Content-Disposition: inline
In-Reply-To: <20170906135501.306-4-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Wed, Sep 06, 2017 at 03:54:51PM +0200, Milian Wolff wrote:

SNIP

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

could you please split the patch at least into
above 'adding related inline_node tree managing functions + append_inlines'

and below 'struct inline_list' changes

not sure the 'struct symbol::inlined' could be separated,
I'd take it as a bonus and nice gesture to reviewers ;-)

thanks,
jirka


> diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
> index 7b52ba88676e..0d2aca92e8c7 100644
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
> @@ -17,18 +18,28 @@ void free_srcline(char *srcline);
>  #define SRCLINE_UNKNOWN  ((char *) "??:0")
>  
>  struct inline_list {
> -	char			*filename;
> -	char			*funcname;
> -	unsigned int		line_nr;
> +	struct symbol		*symbol;
> +	char			*srcline;
>  	struct list_head	list;
>  };
>  
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
> index 2bd6a1f01a1c..8f072c28b6d3 100644
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
> 2.14.1
> 
