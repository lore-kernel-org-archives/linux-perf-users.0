From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 11/16] perf intel-pt: Add support for synthesizing
 callchains for regular events
Date: Thu, 16 Apr 2020 12:14:43 -0300
Message-ID: <20200416151443.GA2650@kernel.org>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-12-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200401101613.6201-12-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Apr 01, 2020 at 01:16:08PM +0300, Adrian Hunter escreveu:
> Currently, callchains can be synthesized only for synthesized events.
> Support also synthesizing callchains for regular events.

This is super cool, I wonder if we shouldn't do it automatically or just
adding a new type of callchains, i.e.:

	perf record --call-graph pt uname

Should take care of all the details, i.e. do the extra steps below
behind the scenes.

Possibly even find out that the workload specified was built with
-fomit-frame-pointers, that the hardware has Intel PT and do all behind
the scenes for:

	perf record -g uname

Alternatively we could take some less seemingly far fetched approach and
make this configurable via:

	perf config call-graph.record-mode=pt

What do you think?

- Arnaldo
 
> Example:
> 
>  # perf record --kcore --aux-sample -e '{intel_pt//,cycles}' -c 10000 uname
>  Linux
>  [ perf record: Woken up 3 times to write data ]
>  [ perf record: Captured and wrote 0.532 MB perf.data ]
>  # perf script --itrace=Ge | head -20
>  uname  4864 2419025.358181:      10000     cycles:
>         ffffffffbba56965 apparmor_bprm_committing_creds+0x35 ([kernel.kallsyms])
>         ffffffffbc400cd5 __indirect_thunk_start+0x5 ([kernel.kallsyms])
>         ffffffffbba07422 security_bprm_committing_creds+0x22 ([kernel.kallsyms])
>         ffffffffbb89805d install_exec_creds+0xd ([kernel.kallsyms])
>         ffffffffbb90d9ac load_elf_binary+0x3ac ([kernel.kallsyms])
> 
>  uname  4864 2419025.358185:      10000     cycles:
>         ffffffffbba56db0 apparmor_bprm_committed_creds+0x20 ([kernel.kallsyms])
>         ffffffffbc400cd5 __indirect_thunk_start+0x5 ([kernel.kallsyms])
>         ffffffffbba07452 security_bprm_committed_creds+0x22 ([kernel.kallsyms])
>         ffffffffbb89809a install_exec_creds+0x4a ([kernel.kallsyms])
>         ffffffffbb90d9ac load_elf_binary+0x3ac ([kernel.kallsyms])
> 
>  uname  4864 2419025.358189:      10000     cycles:
>         ffffffffbb86fdf6 vma_adjust_trans_huge+0x6 ([kernel.kallsyms])
>         ffffffffbb821660 __vma_adjust+0x160 ([kernel.kallsyms])
>         ffffffffbb897be7 shift_arg_pages+0x97 ([kernel.kallsyms])
>         ffffffffbb897ed9 setup_arg_pages+0x1e9 ([kernel.kallsyms])
>         ffffffffbb90d9f2 load_elf_binary+0x3f2 ([kernel.kallsyms])
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/intel-pt.c | 68 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index db25c77d82f3..a659b4a1b3f2 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -124,6 +124,8 @@ struct intel_pt {
>  
>  	struct range *time_ranges;
>  	unsigned int range_cnt;
> +
> +	struct ip_callchain *chain;
>  };
>  
>  enum switch_state {
> @@ -868,6 +870,45 @@ static u64 intel_pt_ns_to_ticks(const struct intel_pt *pt, u64 ns)
>  		pt->tc.time_mult;
>  }
>  
> +static struct ip_callchain *intel_pt_alloc_chain(struct intel_pt *pt)
> +{
> +	size_t sz = sizeof(struct ip_callchain);
> +
> +	/* Add 1 to callchain_sz for callchain context */
> +	sz += (pt->synth_opts.callchain_sz + 1) * sizeof(u64);
> +	return zalloc(sz);
> +}
> +
> +static int intel_pt_callchain_init(struct intel_pt *pt)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(pt->session->evlist, evsel) {
> +		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> +			evsel->synth_sample_type |= PERF_SAMPLE_CALLCHAIN;
> +	}
> +
> +	pt->chain = intel_pt_alloc_chain(pt);
> +	if (!pt->chain)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void intel_pt_add_callchain(struct intel_pt *pt,
> +				   struct perf_sample *sample)
> +{
> +	struct thread *thread = machine__findnew_thread(pt->machine,
> +							sample->pid,
> +							sample->tid);
> +
> +	thread_stack__sample_late(thread, sample->cpu, pt->chain,
> +				  pt->synth_opts.callchain_sz + 1, sample->ip,
> +				  pt->kernel_start);
> +
> +	sample->callchain = pt->chain;
> +}
> +
>  static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
>  						   unsigned int queue_nr)
>  {
> @@ -880,11 +921,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
>  		return NULL;
>  
>  	if (pt->synth_opts.callchain) {
> -		size_t sz = sizeof(struct ip_callchain);
> -
> -		/* Add 1 to callchain_sz for callchain context */
> -		sz += (pt->synth_opts.callchain_sz + 1) * sizeof(u64);
> -		ptq->chain = zalloc(sz);
> +		ptq->chain = intel_pt_alloc_chain(pt);
>  		if (!ptq->chain)
>  			goto out_free;
>  	}
> @@ -1992,7 +2029,8 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
>  	if (!(state->type & INTEL_PT_BRANCH))
>  		return 0;
>  
> -	if (pt->synth_opts.callchain || pt->synth_opts.thread_stack)
> +	if (pt->synth_opts.callchain || pt->synth_opts.add_callchain ||
> +	    pt->synth_opts.thread_stack)
>  		thread_stack__event(ptq->thread, ptq->cpu, ptq->flags, state->from_ip,
>  				    state->to_ip, ptq->insn_len,
>  				    state->trace_nr);
> @@ -2639,6 +2677,11 @@ static int intel_pt_process_event(struct perf_session *session,
>  	if (err)
>  		return err;
>  
> +	if (event->header.type == PERF_RECORD_SAMPLE) {
> +		if (pt->synth_opts.add_callchain && !sample->callchain)
> +			intel_pt_add_callchain(pt, sample);
> +	}
> +
>  	if (event->header.type == PERF_RECORD_AUX &&
>  	    (event->aux.flags & PERF_AUX_FLAG_TRUNCATED) &&
>  	    pt->synth_opts.errors) {
> @@ -2710,6 +2753,7 @@ static void intel_pt_free(struct perf_session *session)
>  	session->auxtrace = NULL;
>  	thread__put(pt->unknown_thread);
>  	addr_filters__exit(&pt->filts);
> +	zfree(&pt->chain);
>  	zfree(&pt->filter);
>  	zfree(&pt->time_ranges);
>  	free(pt);
> @@ -3348,6 +3392,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  		    !session->itrace_synth_opts->inject) {
>  			pt->synth_opts.branches = false;
>  			pt->synth_opts.callchain = true;
> +			pt->synth_opts.add_callchain = true;
>  		}
>  		pt->synth_opts.thread_stack =
>  				session->itrace_synth_opts->thread_stack;
> @@ -3380,14 +3425,22 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  		pt->branches_filter |= PERF_IP_FLAG_RETURN |
>  				       PERF_IP_FLAG_TRACE_BEGIN;
>  
> -	if (pt->synth_opts.callchain && !symbol_conf.use_callchain) {
> +	if ((pt->synth_opts.callchain || pt->synth_opts.add_callchain) &&
> +	    !symbol_conf.use_callchain) {
>  		symbol_conf.use_callchain = true;
>  		if (callchain_register_param(&callchain_param) < 0) {
>  			symbol_conf.use_callchain = false;
>  			pt->synth_opts.callchain = false;
> +			pt->synth_opts.add_callchain = false;
>  		}
>  	}
>  
> +	if (pt->synth_opts.add_callchain) {
> +		err = intel_pt_callchain_init(pt);
> +		if (err)
> +			goto err_delete_thread;
> +	}
> +
>  	err = intel_pt_synth_events(pt, session);
>  	if (err)
>  		goto err_delete_thread;
> @@ -3410,6 +3463,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  	return 0;
>  
>  err_delete_thread:
> +	zfree(&pt->chain);
>  	thread__zput(pt->unknown_thread);
>  err_free_queues:
>  	intel_pt_log_disable();
> -- 
> 2.17.1
> 

-- 

- Arnaldo
