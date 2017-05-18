From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf report: fix memory leak in addr2line when called
 by addr2inlines
Date: Thu, 18 May 2017 18:46:37 +0900
Message-ID: <20170518094637.GE4885@sejong>
References: <20170518083753.14337-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:51876 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755485AbdERKBm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2017 06:01:42 -0400
Content-Disposition: inline
In-Reply-To: <20170518083753.14337-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Thu, May 18, 2017 at 10:37:53AM +0200, Milian Wolff wrote:
> When a filename was found in addr2line it was duplicated via strdup
> but never freed. Now we pass NULL and handle this gracefully in
> addr2line.
> 
> Detected by Valgrind:
> 
> ==16331== 1,680 bytes in 21 blocks are definitely lost in loss record 148 of 220
> ==16331==    at 0x4C2AF1F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==16331==    by 0x672FA69: strdup (in /usr/lib/libc-2.25.so)
> ==16331==    by 0x52769F: addr2line (srcline.c:256)
> ==16331==    by 0x52769F: addr2inlines (srcline.c:294)
> ==16331==    by 0x52769F: dso__parse_addr_inlines (srcline.c:502)
> ==16331==    by 0x574D7A: inline__fprintf (hist.c:41)
> ==16331==    by 0x574D7A: ipchain__fprintf_graph (hist.c:147)
> ==16331==    by 0x57518A: __callchain__fprintf_graph (hist.c:212)
> ==16331==    by 0x5753CF: callchain__fprintf_graph.constprop.6 (hist.c:337)
> ==16331==    by 0x57738E: hist_entry__fprintf (hist.c:628)
> ==16331==    by 0x57738E: hists__fprintf (hist.c:882)
> ==16331==    by 0x44A20F: perf_evlist__tty_browse_hists (builtin-report.c:399)
> ==16331==    by 0x44A20F: report__browse_hists (builtin-report.c:491)
> ==16331==    by 0x44A20F: __cmd_report (builtin-report.c:624)
> ==16331==    by 0x44A20F: cmd_report (builtin-report.c:1054)
> ==16331==    by 0x4A49CE: run_builtin (perf.c:296)
> ==16331==    by 0x4A4CC0: handle_internal_command (perf.c:348)
> ==16331==    by 0x434371: run_argv (perf.c:392)
> ==16331==    by 0x434371: main (perf.c:530)
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/srcline.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> v2:
> - keep behavior of old function when strdup failed
> - set ret to 1 if we found any inline node
> 
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index df051a52393c..5e376d64d59e 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -230,7 +230,10 @@ static int addr2line(const char *dso_name, u64 addr,
>  
>  	bfd_map_over_sections(a2l->abfd, find_address_in_section, a2l);
>  
> -	if (a2l->found && unwind_inlines) {
> +	if (!a2l->found)
> +		return 0;
> +
> +	if (unwind_inlines) {
>  		int cnt = 0;
>  
>  		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
> @@ -243,6 +246,8 @@ static int addr2line(const char *dso_name, u64 addr,
>  							a2l->line, node,
>  							dso) != 0)
>  					return 0;
> +				// found at least one inline frame
> +				ret = 1;
>  			}
>  		}
>  
> @@ -252,14 +257,14 @@ static int addr2line(const char *dso_name, u64 addr,
>  		}
>  	}
>  
> -	if (a2l->found && a2l->filename) {
> -		*file = strdup(a2l->filename);
> -		*line = a2l->line;
> -
> -		if (*file)
> -			ret = 1;
> +	if (file) {
> +		*file = a2l->filename ? strdup(a2l->filename) : NULL;
> +		ret = *file ? 1 : 0;
>  	}
>  
> +	if (line)
> +		*line = a2l->line;
> +
>  	return ret;
>  }
>  
> @@ -278,8 +283,6 @@ void dso__free_a2l(struct dso *dso)
>  static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
>  	struct dso *dso)
>  {
> -	char *file = NULL;
> -	unsigned int line = 0;
>  	struct inline_node *node;
>  
>  	node = zalloc(sizeof(*node));
> @@ -291,7 +294,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
>  	INIT_LIST_HEAD(&node->val);
>  	node->addr = addr;
>  
> -	if (!addr2line(dso_name, addr, &file, &line, dso, TRUE, node))
> +	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node))
>  		goto out_free_inline_node;
>  
>  	if (list_empty(&node->val))
> -- 
> 2.13.0
> 
