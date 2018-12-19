From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 35/63] perf trace: Allow specifying a set of events to
 add in perfconfig
Date: Wed, 19 Dec 2018 17:40:24 +0900
Message-ID: <20181219084024.GA18068@danjae.aot.lge.com>
References: <20181218220733.15839-1-acme@kernel.org>
 <20181218220733.15839-36-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218220733.15839-36-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,

On Tue, Dec 18, 2018 at 07:07:05PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To add augmented_raw_syscalls to the events speficied by the user, or be
> the only one if no events were specified by the user, one can add this
> to perfconfig:
> 
>   # cat ~/.perfconfig
>   [trace]
> 	  add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
>   #
> 
> I.e. pre-compile the augmented_raw_syscalls.c BPF program and make it
> always load, this way:
> 
>   # perf trace -e open* cat /etc/passwd > /dev/null
>      0.000 ( 0.013 ms): cat/31557 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
>      0.035 ( 0.007 ms): cat/31557 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
>      0.353 ( 0.009 ms): cat/31557 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
>      0.424 ( 0.006 ms): cat/31557 openat(dfd: CWD, filename: /etc/passwd) = 3
>   #
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-0lgj7vh64hg3ce44gsmvj7ud@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Documentation/perf-config.txt |  8 ++++++++
>  tools/perf/builtin-trace.c               | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
> index 661b1fb3f8ba..423cb41f6e3f 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -521,6 +521,14 @@ diff.*::
>  		Possible values are 'delta', 'delta-abs', 'ratio' and
>  		'wdiff'.  Default is 'delta'.
>  
> +trace.*::
> +	trace.add_events::
> +		Allows adding a set of events to add to the ones specified
> +		by the user, or use as a default one if none was specified.
> +		The initial use case is to add augmented_raw_syscalls.o to
> +		activate the 'perf trace' logic that looks for syscall
> +		pointer contents after the normal tracepoint payload.
> +
>  SEE ALSO
>  --------
>  linkperf:perf[1]
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 096380e8c213..d754a74aef46 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -22,6 +22,7 @@
>  #include "builtin.h"
>  #include "util/cgroup.h"
>  #include "util/color.h"
> +#include "util/config.h"
>  #include "util/debug.h"
>  #include "util/env.h"
>  #include "util/event.h"
> @@ -3523,6 +3524,21 @@ static void trace__set_bpf_map_syscalls(struct trace *trace)
>  	trace->syscalls.map = bpf__find_map_by_name("syscalls");
>  }
>  
> +static int trace__config(const char *var, const char *value, void *arg)
> +{
> +	int err = 0;
> +
> +	if (!strcmp(var, "trace.add_events")) {
> +		struct trace *trace = arg;
> +		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
> +					       "event selector. use 'perf list' to list available events",
> +					       parse_events_option);
> +		err = parse_events_option(&o, value, 0);

It's a bit strange to use parse_events_option() here IMHO.  Why not
using parse_events() instead?

Thanks,
Namhyung


> +	}
> +
> +	return err;
> +}
> +
>  int cmd_trace(int argc, const char **argv)
>  {
>  	const char *trace_usage[] = {
> @@ -3645,6 +3661,10 @@ int cmd_trace(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	err = perf_config(trace__config, &trace);
> +	if (err)
> +		goto out;
> +
>  	argc = parse_options_subcommand(argc, argv, trace_options, trace_subcommands,
>  				 trace_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>  
> -- 
> 2.19.2
> 
