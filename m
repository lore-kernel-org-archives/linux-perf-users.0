From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 03/13] perf report: create real callchain entries for
 inlined frames
Date: Tue, 19 Sep 2017 14:27:11 +0200
Message-ID: <20170919122711.GA13388@krava>
References: <20170906135501.306-1-milian.wolff@kdab.com>
 <20170906135501.306-4-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170906135501.306-4-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Sep 06, 2017 at 03:54:51PM +0200, Milian Wolff wrote:

SNIP

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

nit, think we prefer the /* */ comment style

jirka
