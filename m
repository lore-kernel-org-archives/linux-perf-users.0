From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v4 14/15] perf report: use srcline from callchain for
 hist entries
Date: Thu, 5 Oct 2017 13:08:29 +0900
Message-ID: <20171005040829.GA1584@danjae.aot.lge.com>
References: <20171001143100.19988-1-milian.wolff@kdab.com>
 <20171001143100.19988-15-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:45429 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbdJEEKm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Oct 2017 00:10:42 -0400
Content-Disposition: inline
In-Reply-To: <20171001143100.19988-15-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kernel-team@lge.com

On Sun, Oct 01, 2017 at 04:30:59PM +0200, Milian Wolff wrote:
> This also removes the symbol name from the srcline column,
> more on this below.
> 
> This ensures we use the correct srcline, which could originate
> from a potentially inlined function. The hist entries used to
> query for the srcline based purely on the IP, which leads to
> wrong results for inlined entries.

Yep, AFAICS current srcline returns the first entry in a inline-chain
and the srcfile (sort key) returns the last.  I think we need to make
it consistent.  It seems this patch fix it when --inline option is
used, but I guess the --no-inline case still has the problem.

Thanks,
Namhyung


> 
> Before:
> 
> ~~~~~
> perf report --inline -s srcline -g none --stdio
> ...
> # Children      Self  Source:Line
> # ........  ........  ..................................................................................................................................
> #
>     94.23%     0.00%  __libc_start_main+18446603487898210537
>     94.23%     0.00%  _start+41
>     44.58%     0.00%  main+100
>     44.58%     0.00%  std::_Norm_helper<true>::_S_do_it<double>+100
>     44.58%     0.00%  std::__complex_abs+100
>     44.58%     0.00%  std::abs<double>+100
>     44.58%     0.00%  std::norm<double>+100
>     36.01%     0.00%  hypot+18446603487892193300
>     25.81%     0.00%  main+41
>     25.81%     0.00%  std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator()+41
>     25.81%     0.00%  std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> >+41
>     25.75%    25.75%  random.h:143
>     18.39%     0.00%  main+57
>     18.39%     0.00%  std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator()+57
>     18.39%     0.00%  std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> >+57
>     13.80%    13.80%  random.tcc:3330
>      5.64%     0.00%  ??:0
>      4.13%     4.13%  __hypot_finite+163
>      4.13%     0.00%  __hypot_finite+18446603487892193443
> ...
> ~~~~~
> 
> After:
> 
> ~~~~~
> perf report --inline -s srcline -g none --stdio
> ...
> # Children      Self  Source:Line
> # ........  ........  ...........................................
> #
>     94.30%     1.19%  main.cpp:39
>     94.23%     0.00%  __libc_start_main+18446603487898210537
>     94.23%     0.00%  _start+41
>     48.44%     1.70%  random.h:1823
>     48.44%     0.00%  random.h:1814
>     46.74%     2.53%  random.h:185
>     44.68%     0.10%  complex:589
>     44.68%     0.00%  complex:597
>     44.68%     0.00%  complex:654
>     44.68%     0.00%  complex:664
>     40.61%    13.80%  random.tcc:3330
>     36.01%     0.00%  hypot+18446603487892193300
>     26.81%     0.00%  random.h:151
>     26.81%     0.00%  random.h:332
>     25.75%    25.75%  random.h:143
>      5.64%     0.00%  ??:0
>      4.13%     4.13%  __hypot_finite+163
>      4.13%     0.00%  __hypot_finite+18446603487892193443
> ...
> ~~~~~
> 
> Note that this change removes the symbol from the source:line
> hist column. If this information is desired, users should
> explicitly query for it if needed. I.e. run this command
> instead:
> 
> ~~~~~
> perf report --inline -s sym,srcline -g none --stdio
> ...
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 1K of event 'cycles:uppp'
> # Event count (approx.): 1381229476
> #
> # Children      Self  Symbol                                                                                                                               Source:Line
> # ........  ........  ...................................................................................................................................  ...........................................
> #
>     94.30%     1.19%  [.] main                                                                                                                             main.cpp:39
>     94.23%     0.00%  [.] __libc_start_main                                                                                                                __libc_start_main+18446603487898210537
>     94.23%     0.00%  [.] _start                                                                                                                           _start+41
>     48.44%     0.00%  [.] std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)  random.h:1814
>     48.44%     0.00%  [.] std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)  random.h:1823
>     46.74%     0.00%  [.] std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inlined)  random.h:185
>     44.68%     0.00%  [.] std::_Norm_helper<true>::_S_do_it<double> (inlined)                                                                              complex:654
>     44.68%     0.00%  [.] std::__complex_abs (inlined)                                                                                                     complex:589
>     44.68%     0.00%  [.] std::abs<double> (inlined)                                                                                                       complex:597
>     44.68%     0.00%  [.] std::norm<double> (inlined)                                                                                                      complex:664
>     39.80%    13.59%  [.] std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> >               random.tcc:3330
>     36.01%     0.00%  [.] hypot                                                                                                                            hypot+18446603487892193300
>     26.81%     0.00%  [.] std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul> (inlined)                                                        random.h:151
>     26.81%     0.00%  [.] std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>::operator() (inlined)                                 random.h:332
>     25.75%     0.00%  [.] std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul, 0ul, true, true>::__calc (inlined)                                     random.h:143
>     25.19%    25.19%  [.] std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> >               random.h:143
>      4.13%     4.13%  [.] __hypot_finite                                                                                                                   __hypot_finite+163
>      4.13%     0.00%  [.] __hypot_finite                                                                                                                   __hypot_finite+18446603487892193443
> ...
> ~~~~~
> 
> Compared to the old behavior, this reduces duplication in the output.
> Before we used to print the symbol name in the srcline column even
> when the sym column was explicitly requested. I.e. the output was:
> 
> ~~~~~
> perf report --inline -s sym,srcline -g none --stdio
> ...
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 1K of event 'cycles:uppp'
> # Event count (approx.): 1381229476
> #
> # Children      Self  Symbol                                                                                                                               Source:Line
> # ........  ........  ...................................................................................................................................  ..................................................................................................................................
> #
>     94.23%     0.00%  [.] __libc_start_main                                                                                                                __libc_start_main+18446603487898210537
>     94.23%     0.00%  [.] _start                                                                                                                           _start+41
>     44.58%     0.00%  [.] main                                                                                                                             main+100
>     44.58%     0.00%  [.] std::_Norm_helper<true>::_S_do_it<double> (inlined)                                                                              std::_Norm_helper<true>::_S_do_it<double>+100
>     44.58%     0.00%  [.] std::__complex_abs (inlined)                                                                                                     std::__complex_abs+100
>     44.58%     0.00%  [.] std::abs<double> (inlined)                                                                                                       std::abs<double>+100
>     44.58%     0.00%  [.] std::norm<double> (inlined)                                                                                                      std::norm<double>+100
>     36.01%     0.00%  [.] hypot                                                                                                                            hypot+18446603487892193300
>     25.81%     0.00%  [.] main                                                                                                                             main+41
>     25.81%     0.00%  [.] std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inlined)  std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator()+41
>     25.81%     0.00%  [.] std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)  std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> >+41
>     25.69%    25.69%  [.] std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> >               random.h:143
>     18.39%     0.00%  [.] main                                                                                                                             main+57
>     18.39%     0.00%  [.] std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator() (inlined)  std::__detail::_Adaptor<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>, double>::operator()+57
>     18.39%     0.00%  [.] std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > (inlined)  std::uniform_real_distribution<double>::operator()<std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> >+57
>     13.80%    13.80%  [.] std::generate_canonical<double, 53ul, std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul> >               random.tcc:3330
>      4.13%     4.13%  [.] __hypot_finite                                                                                                                   __hypot_finite+163
>      4.13%     0.00%  [.] __hypot_finite                                                                                                                   __hypot_finite+18446603487892193443
> ...
> ~~~~~
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/util/callchain.c | 1 +
>  tools/perf/util/event.c     | 1 +
>  tools/perf/util/hist.c      | 2 ++
>  tools/perf/util/symbol.h    | 1 +
>  4 files changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 48d2869025b3..1b82225b96c3 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1065,6 +1065,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
>  {
>  	al->map = node->map;
>  	al->sym = node->sym;
> +	al->srcline = node->srcline;
>  	if (node->map)
>  		al->addr = node->map->map_ip(node->map, node->ip);
>  	else
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 10366b87d0b5..2c651dc4fcda 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1503,6 +1503,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>  	al->sym = NULL;
>  	al->cpu = sample->cpu;
>  	al->socket = -1;
> +	al->srcline = NULL;
>  
>  	if (al->cpu >= 0) {
>  		struct perf_env *env = machine->env;
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index b0fa9c217e1c..25d143053ab5 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -596,6 +596,7 @@ __hists__add_entry(struct hists *hists,
>  			.map	= al->map,
>  			.sym	= al->sym,
>  		},
> +		.srcline = al->srcline ? strdup(al->srcline) : NULL,
>  		.socket	 = al->socket,
>  		.cpu	 = al->cpu,
>  		.cpumode = al->cpumode,
> @@ -950,6 +951,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
>  			.map = al->map,
>  			.sym = al->sym,
>  		},
> +		.srcline = al->srcline ? strdup(al->srcline) : NULL,
>  		.parent = iter->parent,
>  		.raw_data = sample->raw_data,
>  		.raw_size = sample->raw_size,
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 8f072c28b6d3..a2aec8048bb1 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -209,6 +209,7 @@ struct addr_location {
>  	struct thread *thread;
>  	struct map    *map;
>  	struct symbol *sym;
> +	const char    *srcline;
>  	u64	      addr;
>  	char	      level;
>  	u8	      filtered;
> -- 
> 2.14.2
> 
