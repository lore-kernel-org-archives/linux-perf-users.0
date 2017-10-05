From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 12/15] perf report: cache failed lookups of inlined
 frames
Date: Thu, 5 Oct 2017 12:43:38 +0900
Message-ID: <20171005034338.GC19141@danjae.aot.lge.com>
References: <20171001143100.19988-1-milian.wolff@kdab.com>
 <20171001143100.19988-13-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171001143100.19988-13-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

On Sun, Oct 01, 2017 at 04:30:57PM +0200, Milian Wolff wrote:
> When no inlined frames could be found for a given address,
> we did not store this information anywhere. That means we
> potentially do the costly inliner lookup repeatedly for
> cases where we know it can never succeed.
> 
> This patch makes dso__parse_addr_inlines always return a
> valid inline_node. It will be empty when no inliners are
> found. This enables us to cache the empty list in the DSO,
> thereby improving the performance when many addresses
> fail to find the inliners.
> 
> For my trivial example, the performance impact is already
> quite significant:
> 
> Before:
> 
> ~~~~~
>  Performance counter stats for 'perf report --stdio --inline -g srcline -s srcline' (5 runs):
> 
>         594.804032      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.07% )
>                 53      context-switches          #    0.089 K/sec                    ( +-  4.09% )
>                  0      cpu-migrations            #    0.000 K/sec                    ( +-100.00% )
>              5,687      page-faults               #    0.010 M/sec                    ( +-  0.02% )
>      2,300,918,213      cycles                    #    3.868 GHz                      ( +-  0.09% )
>      4,395,839,080      instructions              #    1.91  insn per cycle           ( +-  0.00% )
>        939,177,205      branches                  # 1578.969 M/sec                    ( +-  0.00% )
>         11,824,633      branch-misses             #    1.26% of all branches          ( +-  0.10% )
> 
>        0.596246531 seconds time elapsed                                          ( +-  0.07% )
> ~~~~~
> 
> After:
> 
> ~~~~~
>  Performance counter stats for 'perf report --stdio --inline -g srcline -s srcline' (5 runs):
> 
>         113.111405      task-clock (msec)         #    0.990 CPUs utilized            ( +-  0.89% )
>                 29      context-switches          #    0.255 K/sec                    ( +- 54.25% )
>                  0      cpu-migrations            #    0.000 K/sec
>              5,380      page-faults               #    0.048 M/sec                    ( +-  0.01% )
>        432,378,779      cycles                    #    3.823 GHz                      ( +-  0.75% )
>        670,057,633      instructions              #    1.55  insn per cycle           ( +-  0.01% )
>        141,001,247      branches                  # 1246.570 M/sec                    ( +-  0.01% )
>          2,346,845      branch-misses             #    1.66% of all branches          ( +-  0.19% )
> 
>        0.114222393 seconds time elapsed                                          ( +-  1.19% )
> ~~~~~
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---

[SNIP]

> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 69241d805275..26d9954dc19e 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -353,17 +353,8 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
>  	INIT_LIST_HEAD(&node->val);
>  	node->addr = addr;
>  
> -	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node, sym))
> -		goto out_free_inline_node;
> -
> -	if (list_empty(&node->val))
> -		goto out_free_inline_node;
> -
> -	return node;
> -
> -out_free_inline_node:
> -	inline_node__delete(node);
> -	return NULL;
> +	addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node, sym);
> +        return node;

Whitespace demanged.

Also please use 'true' instead of 'TRUE' for consistency (I know this
is not your fault).

Thanks,
Namhyung


>  }
>  
>  #else /* HAVE_LIBBFD_SUPPORT */
> @@ -480,11 +471,6 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
>  out:
>  	pclose(fp);
>  
> -	if (list_empty(&node->val)) {
> -		inline_node__delete(node);
> -		return NULL;
> -	}
> -
>  	return node;
>  }
>  
> -- 
> 2.14.2
> 
