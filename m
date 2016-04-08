From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf trace: Add support for printing call chains on
 sys_exit events.
Date: Fri, 8 Apr 2016 14:57:54 -0300
Message-ID: <20160408175754.GB25165@kernel.org>
References: <1460115255-17648-1-git-send-email-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50786 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbcDHR57 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 8 Apr 2016 13:57:59 -0400
Content-Disposition: inline
In-Reply-To: <1460115255-17648-1-git-send-email-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>

Em Fri, Apr 08, 2016 at 01:34:15PM +0200, Milian Wolff escreveu:
> Now, one can print the call chain for every encountered sys_exit
> event, e.g.:

You mixed up multiple changes in one single patch, I'll break it down
while testing, and before pushing upstream.

- Arnaldo
 
>     $ perf trace -e nanosleep --call-graph dwarf path/to/ex_sleep
>     1005.757 (1000.090 ms): ex_sleep/13167 nanosleep(...) = 0
>                     20379e syscall_slow_exit_work ([kernel.kallsyms])
>                     203bc4 syscall_return_slowpath ([kernel.kallsyms])
>                     797248 int_ret_from_sys_call ([kernel.kallsyms])
>                 7f3991cd2600 __nanosleep (/usr/lib/libc-2.23.so)
>                 7f39926ab08d [unknown] (/usr/lib/libQt5Core.so.5.6.0)
>                 7f39925fe1bb QThread::sleep (/usr/lib/libQt5Core.so.5.6.0)
>                 5614801e4a2d main (path/to/ex_sleep)
>                 7f3991c3b710 __libc_start_main (/usr/lib/libc-2.23.so)
>                 5614801e4aa9 _start (path/to/ex_sleep)
> 
> Note that it is advised to increase the number of mmap pages to
> prevent event losses when using this new feature. Often, adding
> `-m 10M` to the `perf trace` invocation is enough.
> 
> This feature is also available in strace when built with libunwind
> via `strace -k`. Performance wise, this solution is much better:
> 
>     $ time find path/to/linux &> /dev/null
> 
>     real    0m0.051s
>     user    0m0.013s
>     sys     0m0.037s
> 
>     $ time perf trace -m 800M --call-graph dwarf find path/to/linux &> /dev/null
> 
>     real    0m2.624s
>     user    0m1.203s
>     sys     0m1.333s
> 
>     $ time strace -k find path/to/linux  &> /dev/null
> 
>     real    0m35.398s
>     user    0m10.403s
>     sys     0m23.173s
> 
> Note that it is currently not possible to configure the print output.
> Adding such a feature, similar to what is available in `perf script`
> via its `--fields` knob can be added later on.
> 
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/builtin-script.c |  4 ++--
>  tools/perf/builtin-trace.c  | 27 +++++++++++++++++++++++++++
>  tools/perf/util/session.c   | 39 +++++++++++++++++++++------------------
>  tools/perf/util/session.h   |  3 ++-
>  4 files changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 3770c3d..e79d6f1 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -580,7 +580,7 @@ static void print_sample_bts(struct perf_sample *sample,
>  			}
>  		}
>  		perf_evsel__print_ip(evsel, sample, al, print_opts,
> -				     scripting_max_stack);
> +				     scripting_max_stack, stdout);
>  	}
>  
>  	/* print branch_to information */
> @@ -790,7 +790,7 @@ static void process_event(struct perf_script *script,
>  
>  		perf_evsel__print_ip(evsel, sample, al,
>  				     output[attr->type].print_ip_opts,
> -				     scripting_max_stack);
> +				     scripting_max_stack, stdout);
>  	}
>  
>  	if (PRINT_FIELD(IREGS))
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d309f45..f3b5e07 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -34,6 +34,7 @@
>  #include "trace-event.h"
>  #include "util/parse-events.h"
>  #include "util/bpf-loader.h"
> +#include "util/callchain.h"
>  
>  #include <libaudit.h>
>  #include <stdlib.h>
> @@ -2161,6 +2162,23 @@ signed_print:
>  		goto signed_print;
>  
>  	fputc('\n', trace->output);
> +
> +	if (sample->callchain) {
> +		struct addr_location al;
> +		/* TODO: user-configurable print_opts */
> +		unsigned int print_opts = PRINT_IP_OPT_IP
> +					| PRINT_IP_OPT_SYM
> +					| PRINT_IP_OPT_DSO;
> +
> +		if (machine__resolve(trace->host, &al, sample) < 0) {
> +			pr_err("problem processing %d event, skipping it.\n",
> +			    event->header.type);
> +			err = -1;
> +			goto out_put;
> +		}
> +		perf_evsel__print_ip(evsel, sample, &al, print_opts,
> +				     scripting_max_stack, trace->output);
> +	}
>  out:
>  	ttrace->entry_pending = false;
>  	err = 0;
> @@ -3225,6 +3243,9 @@ int cmd_trace(int argc, const char **argv, const char *prefix __maybe_unused)
>  		     "Trace pagefaults", parse_pagefaults, "maj"),
>  	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
>  	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
> +	OPT_CALLBACK(0, "call-graph", &trace.opts,
> +		     "record_mode[,record_size]", record_callchain_help,
> +		     &record_parse_callchain_opt),
>  	OPT_UINTEGER(0, "proc-map-timeout", &trace.opts.proc_map_timeout,
>  			"per thread proc mmap processing timeout in ms"),
>  	OPT_END()
> @@ -3252,6 +3273,12 @@ int cmd_trace(int argc, const char **argv, const char *prefix __maybe_unused)
>  		trace.opts.sample_time = true;
>  	}
>  
> +	if (trace.opts.callgraph_set) {
> +		symbol_conf.use_callchain = true;
> +		callchain_param.enabled = true;
> +		symbol__init(NULL);
> +	}
> +
>  	if (trace.evlist->nr_entries > 0)
>  		evlist__set_evsel_handler(trace.evlist, trace__event_handler);
>  
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index ef37055..bbac0ef 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1955,7 +1955,8 @@ struct perf_evsel *perf_session__find_first_evtype(struct perf_session *session,
>  
>  void perf_evsel__print_ip(struct perf_evsel *evsel, struct perf_sample *sample,
>  			  struct addr_location *al,
> -			  unsigned int print_opts, unsigned int stack_depth)
> +			  unsigned int print_opts, unsigned int stack_depth,
> +			  FILE *fp)
>  {
>  	struct callchain_cursor_node *node;
>  	int print_ip = print_opts & PRINT_IP_OPT_IP;
> @@ -1992,33 +1993,35 @@ void perf_evsel__print_ip(struct perf_evsel *evsel, struct perf_sample *sample,
>  				goto next;
>  
>  			if (print_ip)
> -				printf("%c%16" PRIx64, s, node->ip);
> +				fprintf(fp, "%c%16" PRIx64, s, node->ip);
>  
>  			if (node->map)
>  				addr = node->map->map_ip(node->map, node->ip);
>  
>  			if (print_sym) {
> -				printf(" ");
> +				fprintf(fp, " ");
>  				if (print_symoffset) {
>  					node_al.addr = addr;
>  					node_al.map  = node->map;
> -					symbol__fprintf_symname_offs(node->sym, &node_al, stdout);
> +					symbol__fprintf_symname_offs(node->sym,
> +								     &node_al,
> +								     fp);
>  				} else
> -					symbol__fprintf_symname(node->sym, stdout);
> +					symbol__fprintf_symname(node->sym, fp);
>  			}
>  
>  			if (print_dso) {
> -				printf(" (");
> -				map__fprintf_dsoname(node->map, stdout);
> -				printf(")");
> +				fprintf(fp, " (");
> +				map__fprintf_dsoname(node->map, fp);
> +				fprintf(fp, ")");
>  			}
>  
>  			if (print_srcline)
>  				map__fprintf_srcline(node->map, addr, "\n  ",
> -						     stdout);
> +						     fp);
>  
>  			if (!print_oneline)
> -				printf("\n");
> +				fprintf(fp, "\n");
>  
>  			stack_depth--;
>  next:
> @@ -2030,25 +2033,25 @@ next:
>  			return;
>  
>  		if (print_ip)
> -			printf("%16" PRIx64, sample->ip);
> +			fprintf(fp, "%16" PRIx64, sample->ip);
>  
>  		if (print_sym) {
> -			printf(" ");
> +			fprintf(fp, " ");
>  			if (print_symoffset)
>  				symbol__fprintf_symname_offs(al->sym, al,
> -							     stdout);
> +							     fp);
>  			else
> -				symbol__fprintf_symname(al->sym, stdout);
> +				symbol__fprintf_symname(al->sym, fp);
>  		}
>  
>  		if (print_dso) {
> -			printf(" (");
> -			map__fprintf_dsoname(al->map, stdout);
> -			printf(")");
> +			fprintf(fp, " (");
> +			map__fprintf_dsoname(al->map, fp);
> +			fprintf(fp, ")");
>  		}
>  
>  		if (print_srcline)
> -			map__fprintf_srcline(al->map, al->addr, "\n  ", stdout);
> +			map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
>  	}
>  }
>  
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index f96fc9e8c..0ee3d9d 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -106,7 +106,8 @@ struct perf_evsel *perf_session__find_first_evtype(struct perf_session *session,
>  
>  void perf_evsel__print_ip(struct perf_evsel *evsel, struct perf_sample *sample,
>  			  struct addr_location *al,
> -			  unsigned int print_opts, unsigned int stack_depth);
> +			  unsigned int print_opts, unsigned int stack_depth,
> +			  FILE *fp);
>  
>  int perf_session__cpu_bitmap(struct perf_session *session,
>  			     const char *cpu_list, unsigned long *cpu_bitmap);
> -- 
> 2.8.0
