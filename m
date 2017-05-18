From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf report: do not drop last inlined frame
Date: Thu, 18 May 2017 18:55:38 +0900
Message-ID: <20170518095538.GG4885@sejong>
References: <20170518083822.14568-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:42151 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754344AbdERKPO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 May 2017 06:15:14 -0400
Content-Disposition: inline
In-Reply-To: <20170518083822.14568-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, kernel-team@lge.com

On Thu, May 18, 2017 at 10:38:22AM +0200, Milian Wolff wrote:
> The very last inlined frame, i.e. the one furthest away from the
> non-inlined frame, was silently dropped. This is apparent when
> comparing the output of `perf script` and `addr2line`:
> 
> ~~~~~~
> $ perf script --inline
> ...
> a.out 26722 80836.309329:      72425 cycles:
>                    21493 __hypot_finite (/usr/lib/libm-2.25.so)
>                      a4a std::abs<double> (inline) (/tmp/a.out)
>                      a4a std::_Norm_helper<true>::_S_do_it<double> (inline) (/tmp/a.out)
>                      a4a std::norm<double> (inline) (/tmp/a.out)
>                      a4a main (/tmp/a.out)
>                    20510 __libc_start_main (/usr/lib/libc-2.25.so)
>                      bd9 _start (/tmp/a.out)
> 
> $ addr2line -a -f -i -e /tmp/a.out a4a | c++filt
> 0x0000000000000a4a
> std::__complex_abs(doublecomplex )
> /usr/include/c++/6.3.1/complex:589
> double std::abs<double>(std::complex<double> const&)
> /usr/include/c++/6.3.1/complex:597
> double std::_Norm_helper<true>::_S_do_it<double>(std::complex<double> const&)
> /usr/include/c++/6.3.1/complex:654
> double std::norm<double>(std::complex<double> const&)
> /usr/include/c++/6.3.1/complex:664
> main
> /tmp/inlining.cpp:14
> ~~~~~
> 
> Note how `std::__complex_abs` is missing from the `perf script`
> output. This is similarly showing up in `perf report`. The patch
> here fixes this issue, and the output becomes:
> 
> ~~~~~
> a.out 26722 80836.309329:      72425 cycles:
>                    21493 __hypot_finite (/usr/lib/libm-2.25.so)
>                     ace3 hypot (/usr/lib/libm-2.25.so)

Why is the 'hypot' missing in the above perf script output?  Is it
another problem?

Thanks,
Namhyung


>                      a4a std::__complex_abs (inline) (/tmp/a.out)
>                      a4a std::abs<double> (inline) (/tmp/a.out)
>                      a4a std::_Norm_helper<true>::_S_do_it<double> (inline) (/tmp/a.out)
>                      a4a std::norm<double> (inline) (/tmp/a.out)
>                      a4a main (/tmp/a.out)
>                    20510 __libc_start_main (/usr/lib/libc-2.25.so)
>                      bd9 _start (/tmp/a.out)
> ~~~~~
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/util/srcline.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> v2:
> - rebase against patch fixing memleak in addr2lines
> 
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index bbba9c69cfec..168285d37cd2 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -203,6 +203,16 @@ static void addr2line_cleanup(struct a2l_data *a2l)
>  
>  #define MAX_INLINE_NEST 1024
>  
> +static int inline_list__append_dso_a2l(struct dso *dso,
> +				       struct inline_node *node)
> +{
> +	struct a2l_data *a2l = dso->a2l;
> +	char *funcname = a2l->funcname ? strdup(a2l->funcname) : NULL;
> +	char *filename = a2l->filename ? strdup(a2l->filename) : NULL;
> +
> +	return inline_list__append(filename, funcname, a2l->line, node, dso);
> +}
> +
>  static int addr2line(const char *dso_name, u64 addr,
>  		     char **file, unsigned int *line, struct dso *dso,
>  		     bool unwind_inlines, struct inline_node *node)
> @@ -231,15 +241,15 @@ static int addr2line(const char *dso_name, u64 addr,
>  	if (unwind_inlines) {
>  		int cnt = 0;
>  
> +		if (node && inline_list__append_dso_a2l(dso, node))
> +			return 0;
> +
>  		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
>  					     &a2l->funcname, &a2l->line) &&
>  		       cnt++ < MAX_INLINE_NEST) {
>  
>  			if (node != NULL) {
> -				if (inline_list__append(strdup(a2l->filename),
> -							strdup(a2l->funcname),
> -							a2l->line, node,
> -							dso) != 0)
> +				if (inline_list__append_dso_a2l(dso, node))
>  					return 0;
>  				// found at least one inline frame
>  				ret = 1;
> -- 
> 2.13.0
> 
