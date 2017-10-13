From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 09/16] perf report: compare symbol name for inlined
 frames when matching
Date: Fri, 13 Oct 2017 10:28:37 -0300
Message-ID: <20171013132837.GM3503@kernel.org>
References: <20171009203310.17362-1-milian.wolff@kdab.com>
 <20171009203310.17362-10-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171009203310.17362-10-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Oct 09, 2017 at 10:33:03PM +0200, Milian Wolff escreveu:
> +++ b/tools/perf/util/callchain.c
> @@ -670,11 +670,11 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
>  				     struct callchain_list *cnode)
>  {
>  	struct symbol *sym = node->sym;
> +	enum match_result match;
>  	u64 left, right;
>  
>  	if (callchain_param.key == CCKEY_SRCLINE) {
> -		enum match_result match = match_chain_strings(cnode->srcline,
> -							      node->srcline);
> +		match = match_chain_strings(cnode->srcline, node->srcline);
>  
>  		/* if no srcline is available, fallback to symbol name */
>  		if (match == MATCH_ERROR && cnode->ms.sym && node->sym)

the above one is unnecessary, as match_result is, at this time, only
used inide that CCKEY_SRCLINE if branch, so I left it out.

> @@ -688,6 +688,13 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
>  	}
>  
>  	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
> +		/* compare inlined frames based on their symbol name because
> +		 * different inlined frames will have the same symbol start
> +		 */
> +		if (cnode->ms.sym->inlined || node->sym->inlined)
> +			return match_chain_strings(cnode->ms.sym->name,
> +						   node->sym->name);
> +

And this clashed with a change by Ravi Bangoria, which I fixed up:

[acme@jouet linux]$ git log -1 --oneline c1fbc0cf81f1c464f5fda322c1104d4bb1da6711
c1fbc0cf81f1 (tag: perf-urgent-for-mingo-4.14-20171005) perf callchain: Compare dsos (as well) for CCKEY_FUNCTION
[acme@jouet linux]$ 

Continuing...

>  		left = cnode->ms.sym->start;
>  		right = sym->start;
>  	} else {
> -- 
> 2.14.2
