From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 8/9] perf top: Add --all-cgroups option
Date: Wed, 8 Jan 2020 23:24:58 +0100
Message-ID: <20200108222458.GF12995@krava>
References: <20200107133501.327117-1-namhyung@kernel.org>
 <20200107133501.327117-9-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200107133501.327117-9-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jan 07, 2020 at 10:35:00PM +0900, Namhyung Kim wrote:
> The --all-cgroups option is to enable cgroup profiling support.  It
> tells kernel to record CGROUP events in the ring buffer so that perf
> report can identify task/cgroup association later.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-top.txt | 4 ++++
>  tools/perf/builtin-top.c              | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 5596129a71cf..c75507f50071 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -266,6 +266,10 @@ Default is to monitor all CPUS.
>  	Record events of type PERF_RECORD_NAMESPACES and display it with the
>  	'cgroup_id' sort key.
>  
> +--cgroup::
> +	Record events of type PERF_RECORD_CGROUP and display it with the
> +	'cgroup' sort key.

should be '--all-cgroups' ?

anyway, we dont have '--cgroups', why not use just this?

jirka

> +
>  --switch-on EVENT_NAME::
>  	Only consider events after this event is found.
>  
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 795e353de095..f6256c533b09 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1244,6 +1244,8 @@ static int __cmd_top(struct perf_top *top)
>  
>  	if (opts->record_namespaces)
>  		top->tool.namespace_events = true;
> +	if (opts->record_cgroup)
> +		top->tool.cgroup_events = true;
>  
>  	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
>  						&top->session->machines.host,
> @@ -1251,6 +1253,11 @@ static int __cmd_top(struct perf_top *top)
>  	if (ret < 0)
>  		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
>  
> +	ret = perf_event__synthesize_cgroups(&top->tool, perf_event__process,
> +					     &top->session->machines.host);
> +	if (ret < 0)
> +		pr_debug("Couldn't synthesize cgroup events.\n");
> +
>  	machine__synthesize_threads(&top->session->machines.host, &opts->target,
>  				    top->evlist->core.threads, false,
>  				    top->nr_threads_synthesize);
> @@ -1539,6 +1546,8 @@ int cmd_top(int argc, const char **argv)
>  			"number of thread to run event synthesize"),
>  	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
>  		    "Record namespaces events"),
> +	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
> +		    "Record cgroup events"),
>  	OPTS_EVSWITCH(&top.evswitch),
>  	OPT_END()
>  	};
> -- 
> 2.24.1.735.g03f4e72817-goog
> 
