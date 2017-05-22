From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 7/7] perf script: mark inlined frames and do not print
 DSO for them
Date: Mon, 22 May 2017 21:11:58 +0900
Message-ID: <20170522121158.GC20009@sejong>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
 <20170518193411.22380-8-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:37510 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdEVMMB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2017 08:12:01 -0400
Content-Disposition: inline
In-Reply-To: <20170518193411.22380-8-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Thu, May 18, 2017 at 09:34:11PM +0200, Milian Wolff wrote:
> Instead of showing the (repeated) DSO name of the non-inlined
> frame, we now show the "(inlined)" suffix instead.
> 
> Before:
>                    214f7 __hypot_finite (/usr/lib/libm-2.25.so)
>                     ace3 hypot (/usr/lib/libm-2.25.so)
>                          std::__complex_abs (/home/milian/projects/src/perf-tests/inlining)
>                          std::abs<double> (/home/milian/projects/src/perf-tests/inlining)
>                          std::_Norm_helper<true>::_S_do_it<double> (/home/milian/projects/src/perf-tests/inlining)
>                          std::norm<double> (/home/milian/projects/src/perf-tests/inlining)
>                      a4a main (/home/milian/projects/src/perf-tests/inlining)
>                    20510 __libc_start_main (/usr/lib/libc-2.25.so)
>                      bd9 _start (/home/milian/projects/src/perf-tests/inlining)
> 
> After:
>                    214f7 __hypot_finite (/usr/lib/libm-2.25.so)
>                     ace3 hypot (/usr/lib/libm-2.25.so)
>                          std::__complex_abs (inlined)
>                          std::abs<double> (inlined)
>                          std::_Norm_helper<true>::_S_do_it<double> (inlined)
>                          std::norm<double> (inlined)

Shouldn't they have 'a4a' too?

Thanks,
Namhyung


>                      a4a main (/home/milian/projects/src/perf-tests/inlining)
>                    20510 __libc_start_main (/usr/lib/libc-2.25.so)
>                      bd9 _start (/home/milian/projects/src/perf-tests/inlining)
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/util/evsel_fprintf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index f2c6c5ee11e8..5b9e89257aa7 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -157,7 +157,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  				}
>  			}
>  
> -			if (print_dso) {
> +			if (print_dso && (!node->sym || !node->sym->inlined)) {
>  				printed += fprintf(fp, " (");
>  				printed += map__fprintf_dsoname(node->map, fp);
>  				printed += fprintf(fp, ")");
> @@ -166,6 +166,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
>  			if (print_srcline)
>  				printed += map__fprintf_srcline(node->map, addr, "\n  ", fp);
>  
> +			if (node->sym && node->sym->inlined)
> +				printed += fprintf(fp, " (inlined)");
> +
>  			if (!print_oneline)
>  				printed += fprintf(fp, "\n");
>  
> -- 
> 2.13.0
> 
