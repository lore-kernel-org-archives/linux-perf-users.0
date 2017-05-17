From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf report: always honor callchain order for inlined
 nodes
Date: Wed, 17 May 2017 13:26:45 +0900
Message-ID: <20170517042645.GB32691@danjae.aot.lge.com>
References: <20170516215422.16458-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35992 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdEQE07 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2017 00:26:59 -0400
Content-Disposition: inline
In-Reply-To: <20170516215422.16458-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Tue, May 16, 2017 at 11:54:22PM +0200, Milian Wolff wrote:
> So far, the inlined nodes where only reversed when we built perf
> against libbfd. If that was not available, the addr2line fallback
> code path was missing the inline_list__reverse call.
> 
> Now this is done at the central place inside dso__parse_addr_inlines.

What about changing inline_list__append() instead to honor callchain
order?

	if (ORDER_CALLEE)
		list_add_tail(...);
	else
		list_add(...);

Thanks,
Namhyung


> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/util/srcline.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 62cf42c36955..8df6b29bf984 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -61,6 +61,14 @@ static int inline_list__append(char *filename, char *funcname, int line_nr,
>  	return 0;
>  }
>  
> +static void inline_list__reverse(struct inline_node *node)
> +{
> +	struct inline_list *ilist, *n;
> +
> +	list_for_each_entry_safe_reverse(ilist, n, &node->val, list)
> +		list_move_tail(&ilist->list, &node->val);
> +}
> +
>  #ifdef HAVE_LIBBFD_SUPPORT
>  
>  /*
> @@ -200,14 +208,6 @@ static void addr2line_cleanup(struct a2l_data *a2l)
>  
>  #define MAX_INLINE_NEST 1024
>  
> -static void inline_list__reverse(struct inline_node *node)
> -{
> -	struct inline_list *ilist, *n;
> -
> -	list_for_each_entry_safe_reverse(ilist, n, &node->val, list)
> -		list_move_tail(&ilist->list, &node->val);
> -}
> -
>  static int addr2line(const char *dso_name, u64 addr,
>  		     char **file, unsigned int *line, struct dso *dso,
>  		     bool unwind_inlines, struct inline_node *node)
> @@ -245,11 +245,6 @@ static int addr2line(const char *dso_name, u64 addr,
>  					return 0;
>  			}
>  		}
> -
> -		if ((node != NULL) &&
> -		    (callchain_param.order != ORDER_CALLEE)) {
> -			inline_list__reverse(node);
> -		}
>  	}
>  
>  	if (a2l->found && a2l->filename) {
> @@ -493,12 +488,17 @@ char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
>  struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
>  {
>  	const char *dso_name;
> +	struct inline_node *node;
>  
>  	dso_name = dso__name(dso);
>  	if (dso_name == NULL)
>  		return NULL;
>  
> -	return addr2inlines(dso_name, addr, dso);
> +	node = addr2inlines(dso_name, addr, dso);
> +	if (node && callchain_param.order != ORDER_CALLEE)
> +		inline_list__reverse(node);
> +
> +	return node;
>  }
>  
>  void inline_node__delete(struct inline_node *node)
> -- 
> 2.13.0
> 
