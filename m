From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH] perf report: don't crash on invalid maps in `-g srcline`
 mode
Date: Thu, 11 May 2017 08:13:24 -0500
Message-ID: <0d08c9db-1715-c8b8-950d-9034760499b4@us.ibm.com>
References: <20170509205046.21473-1-milian.wolff@kdab.com>
Reply-To: pc@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170509205046.21473-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>, Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On 05/09/2017 03:50 PM, Milian Wolff wrote:
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 9ab68682c6d0..295f0846fd84 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -642,13 +642,22 @@ static enum match_result match_chain_strings(const char *left,
>  static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
>  					     struct callchain_list *cnode)
>  {
> -	char *left = get_srcline(cnode->ms.map->dso,
> -				 map__rip_2objdump(cnode->ms.map, cnode->ip),
> -				 cnode->ms.sym, true, false);
> -	char *right = get_srcline(node->map->dso,
> -				  map__rip_2objdump(node->map, node->ip),
> -				  node->sym, true, false);
> -	enum match_result ret = match_chain_strings(left, right);
> +	char *left = NULL;
> +	char *right = NULL;

nit: the above two initializations are unnecessary.

> +	enum match_result ret = MATCH_ERROR;
> +
> +	if (!node->map || !cnode->ms.map)
> +		return ret;
> +
> +	left = get_srcline(cnode->ms.map->dso,
> +			   map__rip_2objdump(cnode->ms.map, cnode->ip),
> +			   cnode->ms.sym, true, false);
> +
> +	right = get_srcline(node->map->dso,
> +			    map__rip_2objdump(node->map, node->ip),
> +			    node->sym, true, false);
> +
> +	ret = match_chain_strings(left, right);
> 
>  	free_srcline(left);
>  	free_srcline(right);

PC
