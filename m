From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf report: don't crash on invalid maps in `-g srcline`
 mode
Date: Wed, 10 May 2017 15:04:23 +0900
Message-ID: <20170510060423.GB2667@sejong>
References: <20170509205046.21473-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:59018 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdEJGEZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 May 2017 02:04:25 -0400
Content-Disposition: inline
In-Reply-To: <20170509205046.21473-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Tue, May 09, 2017 at 10:50:46PM +0200, Milian Wolff wrote:
> I just hit a segfault when doing `perf report -g srcline`.
> Valgrind pointed me at this code as the culprit:
> 
> ==8359== Invalid read of size 8
> ==8359==    at 0x3096D9: map__rip_2objdump (map.c:430)
> ==8359==    by 0x2FC1A3: match_chain_srcline (callchain.c:645)
> ==8359==    by 0x2FC1A3: match_chain (callchain.c:700)
> ==8359==    by 0x2FC1A3: append_chain (callchain.c:895)
> ==8359==    by 0x2FC1A3: append_chain_children (callchain.c:846)
> ==8359==    by 0x2FF719: callchain_append (callchain.c:944)
> ==8359==    by 0x2FF719: hist_entry__append_callchain (callchain.c:1058)
> ==8359==    by 0x32FA06: iter_add_single_cumulative_entry (hist.c:908)
> ==8359==    by 0x33195C: hist_entry_iter__add (hist.c:1050)
> ==8359==    by 0x258F65: process_sample_event (builtin-report.c:204)
> ==8359==    by 0x30D60C: perf_session__deliver_event (session.c:1310)
> ==8359==    by 0x30D60C: ordered_events__deliver_event (session.c:119)
> ==8359==    by 0x310D12: __ordered_events__flush (ordered-events.c:210)
> ==8359==    by 0x310D12: ordered_events__flush.part.3 (ordered-events.c:277)
> ==8359==    by 0x30DD3C: perf_session__process_user_event (session.c:1349)
> ==8359==    by 0x30DD3C: perf_session__process_event (session.c:1475)
> ==8359==    by 0x30FC3C: __perf_session__process_events (session.c:1867)
> ==8359==    by 0x30FC3C: perf_session__process_events (session.c:1921)
> ==8359==    by 0x25A985: __cmd_report (builtin-report.c:575)
> ==8359==    by 0x25A985: cmd_report (builtin-report.c:1054)
> ==8359==    by 0x2B9A80: run_builtin (perf.c:296)
> ==8359==  Address 0x70 is not stack'd, malloc'd or (recently) free'd
> 
> This patch fixes the issue.
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/util/callchain.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
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
> +	enum match_result ret = MATCH_ERROR;
> +
> +	if (!node->map || !cnode->ms.map)
> +		return ret;

This makes it fall back to function/address matching below if one of
srcline is not available.  But it'll just show many "??:0" entries
IMHO.  Maybe we can use same logic in util/sort.c:cmp_null instead..

Thanks,
Namhyung


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
> -- 
> 2.12.2
> 
