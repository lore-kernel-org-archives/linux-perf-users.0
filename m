Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483E382;
	Fri, 30 May 2025 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640658; cv=none; b=Jy4rmy0NTK2Amr9QO0ayVnuFcoGj739yX0CC17i/3CWHi9eqbzmFD/QGvG1rBjk46LXsDAflGuLoCiANEpevGwd67dUqb8QG9SyYewNwhHl+htFopRLup2gbCk1EGgfyhNmuNOYogw8DSLVdFZTn2Fiwm0h4OtNV28sIIJ86+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640658; c=relaxed/simple;
	bh=XsIFtlVBSH+rDREw64t9rjQmHJXpEwo27PTmMUHngX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh5z3Z85wa0gvBVaP1Lauo4pN2amv6tMltkydKzRmmOk8IB+ZbEmd0uTdRtGOj6fqHIb2VZloQD2d5nGUNO8yLWXQSt62YW5v6H2qEDm8nzO2ZnwfNSHa3BZikAFyDwgLCbNz3R1+9idvnNt5FAC8/1YGKD9rfhr74zW4mCrmUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2NOfzTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2NOfzTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B758C4CEE9;
	Fri, 30 May 2025 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748640657;
	bh=XsIFtlVBSH+rDREw64t9rjQmHJXpEwo27PTmMUHngX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2NOfzTsp9CONrg9oqHLKHL3djYrlOWDChYd4sbQ5iIeuMH5seoSMy5SFV9pn9Uxw
	 eyf3usHfqL46LvJpKy6IYgTD5KTMB5l6hclLABUMMialWiLgHzftJYeW3m5XAt/uz+
	 sS145L/txNsZ/Nsq4UMxa8l6yoE3cI4gQtHkoBUhQGyfEjJLVy+cWsUYb/yeDxLz+/
	 uDcPTkhXY6LCNX41diBqnwd8/tm9zPpJ+4kDaizepWnuM6D3ksSyoZe/Qv/1uAuQVD
	 TLxD9yopnjLbW7df0fSop5TSFoilByF9BmDbPhDaIasX8r86kHjDIlDIm1KDaX8YHc
	 swU/qgB05f2Kg==
Date: Fri, 30 May 2025 14:30:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf trace: Enhance task filtering
Message-ID: <aDojkKOJCgvlgL2x@google.com>
References: <20250530062408.1438861-1-howardchu95@gmail.com>
 <20250530062408.1438861-2-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530062408.1438861-2-howardchu95@gmail.com>

Hi Howard,

On Thu, May 29, 2025 at 11:24:07PM -0700, Howard Chu wrote:
> This patch does two things:
> 1. Add a pids_targeted map, put pids that interest perf trace in.
> 2. Make bpf-output event system-wide.
> 
> Effect 1:
> perf trace doesn't augment threads properly. With the script below:
> 
> Program test_trace_loop.c
> ~~~
>     #include <pthread.h>
>     #include <stdio.h>
>     #include <unistd.h>
>     #include <stdlib.h>
> 
>     #define THREAD_NR 2
> 
>     struct thread_arg {
> 	    int index;
>     };
> 
>     void *func(void *arg) {
> 	    struct thread_arg *t_arg = arg;
> 	    while (1) {
> 		    printf("thread %d running\n", t_arg->index);
> 		    sleep(1);
> 	    }
> 	    return NULL;
>     }
> 
>     int main()
>     {
> 	    pthread_t thread_ids[THREAD_NR];
> 	    struct thread_arg thread_args[THREAD_NR];
> 
> 	    for (int i = 0; i < THREAD_NR; i++) {
> 		    thread_args[i].index = i;
> 		    if (pthread_create(&thread_ids[i], NULL, &func, &thread_args[i])) {
> 			    perror("failed to create thread, exiting\n");
> 			    exit(1);
> 		    }
> 	    }
> 
> 	    while (1) {
> 		    printf("parent sleeping\n");
> 		    sleep(1);
> 	    }
> 
> 	    for (int i = 0; i < THREAD_NR; i++)
> 		    pthread_join(thread_ids[i], NULL);
> 
> 	    return 0;
>     }
> ~~~
> 
> Commands
> ~~~
> $ gcc test_trace_loop.c -o test_trace_loop
> 
> $ ./test_trace_loop &
> [1] 1404183
> 
> $ pstree 1404183 -p
> test_trace_loop(1404183)─┬─{test_trace_loop}(1404185)
>                          └─{test_trace_loop}(1404186)
> 
> $ sudo perf trace -p 1404183 -e *sleep
> ~~~
> 
> Output
> before:
> $ sudo /tmp/perf/perf trace -p 1404183 -e *sleep
>          ? (         ): test_trace_loo/1404186  ... [continued]: clock_nanosleep())                                  = 0
>          ? (         ): test_trace_loo/1404183  ... [continued]: clock_nanosleep())                                  = 0
>      0.119 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: 0x7a86061fde60, rmtp: 0x7a86061fde60)        ...
>          ? (         ): test_trace_loo/1404185  ... [continued]: clock_nanosleep())                                  = 0
>      0.047 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...
>      0.047 (1000.127 ms): test_trace_loo/1404183  ... [continued]: clock_nanosleep())                                  = 0
> 
> explanation: only the parent thread 1404183 got augmented
> 
> after:
> $ sudo /tmp/perf/perf trace -p 1404183 -e *sleep
>          ? (         ): test_trace_loo/1404183  ... [continued]: clock_nanosleep())                                  = 0
>          ? (         ): test_trace_loo/1404186  ... [continued]: clock_nanosleep())                                  = 0
>      0.147 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86061fde60) ...
>          ? (         ): test_trace_loo/1404185  ... [continued]: clock_nanosleep())                                  = 0
>      0.076 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...
>      0.076 (1000.160 ms): test_trace_loo/1404183  ... [continued]: clock_nanosleep())                                  = 0
>      0.147 (1000.090 ms): test_trace_loo/1404186  ... [continued]: clock_nanosleep())                                  = 0
>      2.557 (         ): test_trace_loo/1404185 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86069fee60) ...
>   1000.323 (         ): test_trace_loo/1404186 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7a86061fde60) ...
>      2.557 (1000.129 ms): test_trace_loo/1404185  ... [continued]: clock_nanosleep())                                  = 0
>   1000.384 (         ): test_trace_loo/1404183 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd89091450) ...
> 
> explanation: all threads augmented
> 
> Effect 2: perf trace doesn't collect syscall argument data for *ALL*
> pids, and throw it away anymore. Those uninteresting pids get filtered
> right away. There should be a performance advantage.

Thanks for doing this!

> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c                    | 52 ++++++++++++++++---
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 35 ++++++++++---
>  tools/perf/util/evlist.c                      |  2 +-
>  3 files changed, 73 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 67b557ec3b0d..11620cb40198 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4377,6 +4377,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	unsigned long before;
>  	const bool forks = argc > 0;
>  	bool draining = false;
> +	bool enable_evlist = false;
>  
>  	trace->live = true;
>  
> @@ -4447,6 +4448,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		evlist__set_default_cgroup(trace->evlist, trace->cgroup);
>  
>  create_maps:
> +	if (trace->syscalls.events.bpf_output)
> +		trace->syscalls.events.bpf_output->core.system_wide = true;
> +
>  	err = evlist__create_maps(evlist, &trace->opts.target);
>  	if (err < 0) {
>  		fprintf(trace->output, "Problems parsing the target to trace, check your options!\n");
> @@ -4481,20 +4485,54 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		goto out_error_open;
>  #ifdef HAVE_BPF_SKEL
>  	if (trace->syscalls.events.bpf_output) {
> +		struct perf_evsel *perf_evsel = &trace->syscalls.events.bpf_output->core;
>  		struct perf_cpu cpu;
> +		bool t = true;
> +
> +		enable_evlist = true;
> +		if (trace->opts.target.system_wide)
> +			trace->skel->bss->system_wide = true;
> +		else
> +			trace->skel->bss->system_wide = false;
>  
>  		/*
>  		 * Set up the __augmented_syscalls__ BPF map to hold for each
>  		 * CPU the bpf-output event's file descriptor.
>  		 */
> -		perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
> +		perf_cpu_map__for_each_cpu(cpu, i, perf_evsel->cpus) {
>  			int mycpu = cpu.cpu;
>  
> -			bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
> -					&mycpu, sizeof(mycpu),
> -					xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
> -						       mycpu, 0),
> -					sizeof(__u32), BPF_ANY);
> +			err = bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
> +						   &mycpu, sizeof(mycpu),
> +						   xyarray__entry(perf_evsel->fd, mycpu, 0),
> +						   sizeof(__u32), BPF_ANY);
> +			if (err) {
> +				pr_err("Couldn't set system-wide bpf output perf event fd"
> +				       ", err: %d\n", err);
> +				goto out_disable;
> +			}
> +		}
> +
> +		if (target__has_task(&trace->opts.target)) {
> +			struct perf_thread_map *threads = trace->evlist->core.threads;
> +
> +			for (int thread = 0; thread < perf_thread_map__nr(threads); thread++) {
> +				pid_t pid = perf_thread_map__pid(threads, thread);
> +
> +				err = bpf_map__update_elem(trace->skel->maps.pids_targeted, &pid,
> +							   sizeof(pid), &t, sizeof(t), BPF_ANY);
> +				if (err) {
> +					pr_err("Couldn't set pids_targeted map, err: %d\n", err);
> +					goto out_disable;
> +				}
> +			}
> +		} else if (workload_pid != -1) {
> +			err = bpf_map__update_elem(trace->skel->maps.pids_targeted, &workload_pid,
> +						   sizeof(workload_pid), &t, sizeof(t), BPF_ANY);
> +			if (err) {
> +				pr_err("Couldn't set pids_targeted map for workload, err: %d\n", err);
> +				goto out_disable;
> +			}
>  		}
>  	}
>  
> @@ -4553,7 +4591,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  			goto out_error_mmap;
>  	}
>  
> -	if (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay)
> +	if (enable_evlist || (!target__none(&trace->opts.target) && !trace->opts.target.initial_delay))

I guess target__none() should not call evlist__enable() here.


>  		evlist__enable(evlist);
>  
>  	if (forks)
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index e4352881e3fa..e517eec7290b 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -26,6 +26,7 @@
>  #define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
>  
>  #define MAX_CPUS  4096
> +#define MAX_PIDS  4096
>  
>  /* bpf-output associated map */
>  struct __augmented_syscalls__ {
> @@ -113,6 +114,15 @@ struct pids_filtered {
>  	__uint(max_entries, 64);
>  } pids_filtered SEC(".maps");
>  
> +volatile bool system_wide;
> +
> +struct pids_targeted {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__type(key, pid_t);
> +	__type(value, bool);
> +	__uint(max_entries, MAX_PIDS);
> +} pids_targeted SEC(".maps");
> +
>  struct augmented_args_payload {
>  	struct syscall_enter_args args;
>  	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
> @@ -145,6 +155,11 @@ struct beauty_payload_enter_map {
>  	__uint(max_entries, 1);
>  } beauty_payload_enter_map SEC(".maps");
>  
> +static pid_t getpid(void)
> +{
> +	return bpf_get_current_pid_tgid();
> +}
> +
>  static inline struct augmented_args_payload *augmented_args_payload(void)
>  {
>  	int key = 0;
> @@ -418,14 +433,18 @@ int sys_enter_nanosleep(struct syscall_enter_args *args)
>  	return 1; /* Failure: don't filter */
>  }
>  
> -static pid_t getpid(void)
> +static bool filter_pid(void)
>  {
> -	return bpf_get_current_pid_tgid();
> -}
> +	if (system_wide)
> +		return false;

Doesn't it need to check CPU list when -C option is used?

>  
> -static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
> -{
> -	return bpf_map_lookup_elem(pids, &pid) != NULL;
> +	pid_t pid = getpid();
> +
> +	if (bpf_map_lookup_elem(&pids_targeted, &pid) &&
> +	    !bpf_map_lookup_elem(&pids_filtered, &pid))

Can we just use a single map for this purpose?

Thanks,
Namhyung


> +		return false;
> +
> +	return true;
>  }
>  
>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
> @@ -534,7 +553,7 @@ int sys_enter(struct syscall_enter_args *args)
>  	 * initial, non-augmented raw_syscalls:sys_enter payload.
>  	 */
>  
> -	if (pid_filter__has(&pids_filtered, getpid()))
> +	if (filter_pid())
>  		return 0;
>  
>  	augmented_args = augmented_args_payload();
> @@ -560,7 +579,7 @@ int sys_exit(struct syscall_exit_args *args)
>  {
>  	struct syscall_exit_args exit_args;
>  
> -	if (pid_filter__has(&pids_filtered, getpid()))
> +	if (filter_pid())
>  		return 0;
>  
>  	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index dcd1130502df..7b5837c6e6bb 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1012,7 +1012,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
>  	if (!threads)
>  		return -1;
>  
> -	if (target__uses_dummy_map(target) && !evlist__has_bpf_output(evlist))
> +	if (target__uses_dummy_map(target))
>  		cpus = perf_cpu_map__new_any_cpu();
>  	else
>  		cpus = perf_cpu_map__new(target->cpu_list);
> -- 
> 2.45.2
> 
