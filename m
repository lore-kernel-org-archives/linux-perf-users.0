From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5 03/15] perf tools script: Filter COMM/FORK/.. events
 by CPU
Date: Mon, 11 Mar 2019 13:32:35 +0100
Message-ID: <20190311123235.GB26829@krava>
References: <20190309055628.21617-1-andi@firstfloor.org>
 <20190309055628.21617-4-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190309055628.21617-4-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 08, 2019 at 09:56:16PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The --cpu option only filtered samples. Filter other perf events,
> such as COMM, FORK, SWITCH by the CPU too.
> 
> Reported-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> v2: Only filter printf output
> ---
>  tools/perf/builtin-script.c | 62 +++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index fbc440bdf880..f6b5b19b3307 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2053,9 +2053,11 @@ static int process_comm_event(struct perf_tool *tool,
>  		sample->tid = event->comm.tid;
>  		sample->pid = event->comm.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
>  				   PERF_RECORD_COMM, stdout);
> -	perf_event__fprintf(event, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}

looks like this is all same code, and could be put
into a function, but it can be done later

thanks,
jirka

>  	ret = 0;
>  out:
>  	thread__put(thread);
> @@ -2089,9 +2091,11 @@ static int process_namespaces_event(struct perf_tool *tool,
>  		sample->tid = event->namespaces.tid;
>  		sample->pid = event->namespaces.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_NAMESPACES, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_NAMESPACES, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	ret = 0;
>  out:
>  	thread__put(thread);
> @@ -2123,9 +2127,11 @@ static int process_fork_event(struct perf_tool *tool,
>  		sample->tid = event->fork.tid;
>  		sample->pid = event->fork.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_FORK, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_FORK, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  
>  	return 0;
> @@ -2153,9 +2159,11 @@ static int process_exit_event(struct perf_tool *tool,
>  		sample->tid = event->fork.tid;
>  		sample->pid = event->fork.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_EXIT, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_EXIT, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  
>  	if (perf_event__process_exit(tool, event, sample, machine) < 0)
>  		err = -1;
> @@ -2189,9 +2197,11 @@ static int process_mmap_event(struct perf_tool *tool,
>  		sample->tid = event->mmap.tid;
>  		sample->pid = event->mmap.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_MMAP, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_MMAP, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2221,9 +2231,11 @@ static int process_mmap2_event(struct perf_tool *tool,
>  		sample->tid = event->mmap2.tid;
>  		sample->pid = event->mmap2.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_MMAP2, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_MMAP2, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2248,9 +2260,11 @@ static int process_switch_event(struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_SWITCH, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_SWITCH, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2271,9 +2285,11 @@ process_lost_event(struct perf_tool *tool,
>  	if (thread == NULL)
>  		return -1;
>  
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_LOST, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_LOST, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> -- 
> 2.20.1
> 
