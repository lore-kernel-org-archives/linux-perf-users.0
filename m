From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 6/7] perf report: mark inlined frames in output by "
 (inlined)" suffix
Date: Mon, 22 May 2017 21:48:18 +0900
Message-ID: <20170522124818.GE20009@sejong>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
 <20170518193411.22380-7-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:33916 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756362AbdEVMsV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2017 08:48:21 -0400
Content-Disposition: inline
In-Reply-To: <20170518193411.22380-7-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Thu, May 18, 2017 at 09:34:10PM +0200, Milian Wolff wrote:
> The original patch that introduced inline frame output in the
> various browsers used this suffix already. The new centralized
> approach that uses fake symbols for inlined frames was missing
> this approach so far.
> 
> Instead of changing the symbol name itself, we only print the
> suffix where needed. This allows us to efficiently lookup
> the symbol for a given name without first having to append the
> suffix before the lookup.

You also need to do same thing for hist_entry__sym_snprintf().

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
>  tools/perf/util/callchain.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 211ed3713fac..4350c7ceaca1 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1061,11 +1061,15 @@ char *callchain_list__sym_name(struct callchain_list *cl,
>  	int printed;
>  
>  	if (cl->ms.sym) {
> +		const char *inlined = cl->ms.sym->inlined ? " (inlined)" : "";
> +
>  		if (show_srcline && cl->srcline)
> -			printed = scnprintf(bf, bfsize, "%s %s",
> -					cl->ms.sym->name, cl->srcline);
> +			printed = scnprintf(bf, bfsize, "%s %s%s",
> +					    cl->ms.sym->name, cl->srcline,
> +					    inlined);
>  		else
> -			printed = scnprintf(bf, bfsize, "%s", cl->ms.sym->name);
> +			printed = scnprintf(bf, bfsize, "%s%s",
> +					    cl->ms.sym->name, inlined);
>  	} else
>  		printed = scnprintf(bf, bfsize, "%#" PRIx64, cl->ip);
>  
> -- 
> 2.13.0
> 
