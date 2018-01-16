From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/5] perf unwind: Do not look at globals
Date: Tue, 16 Jan 2018 20:49:09 +0100
Message-ID: <20180116194909.GB6183@krava>
References: <20180116142438.19520-1-acme@kernel.org>
 <20180116142438.19520-3-acme@kernel.org>
 <20180116151915.GC17819@krava>
 <20180116153621.GC16107@kernel.org>
 <20180116182650.GE16107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeAPTtO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 14:49:14 -0500
Content-Disposition: inline
In-Reply-To: <20180116182650.GE16107@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Hendrick Brueckner <brueckner@linux.vnet.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>

On Tue, Jan 16, 2018 at 03:26:50PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index c0debc3f79b6..c0815a37fdb5 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2390,9 +2390,10 @@ static int setup_callchain(struct perf_evlist *evlist)
>  	enum perf_call_graph_mode mode = CALLCHAIN_NONE;
>  
>  	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
> -	    (sample_type & PERF_SAMPLE_STACK_USER))
> +	    (sample_type & PERF_SAMPLE_STACK_USER)) {
>  		mode = CALLCHAIN_DWARF;
> -	else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
> +		dwarf_callchain_users = true;
> +	} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
>  		mode = CALLCHAIN_LBR;
>  	else if (sample_type & PERF_SAMPLE_CALLCHAIN)
>  		mode = CALLCHAIN_FP;
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dd4df9a5cd06..6593779224d5 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -338,9 +338,10 @@ static int report__setup_sample_type(struct report *rep)
>  
>  	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
>  		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
> -		    (sample_type & PERF_SAMPLE_STACK_USER))
> +		    (sample_type & PERF_SAMPLE_STACK_USER)) {
>  			callchain_param.record_mode = CALLCHAIN_DWARF;
> -		else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
> +			dwarf_callchain_users = true;
> +		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
>  			callchain_param.record_mode = CALLCHAIN_LBR;
>  		else
>  			callchain_param.record_mode = CALLCHAIN_FP;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c1cce474c0f1..08bc818f371b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2919,9 +2919,10 @@ static void script__setup_sample_type(struct perf_script *script)
>  
>  	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
>  		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
> -		    (sample_type & PERF_SAMPLE_STACK_USER))
> +		    (sample_type & PERF_SAMPLE_STACK_USER)) {
>  			callchain_param.record_mode = CALLCHAIN_DWARF;
> -		else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
> +			dwarf_callchain_users = true;
> +		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
>  			callchain_param.record_mode = CALLCHAIN_LBR;
>  		else
>  			callchain_param.record_mode = CALLCHAIN_FP;
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index ac40e05bcab4..260418969120 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -173,6 +173,7 @@ int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unu
>  	}
>  
>  	callchain_param.record_mode = CALLCHAIN_DWARF;
> +	dwarf_callchain_users = true;
>  
>  	if (init_live_machine(machine)) {
>  		pr_err("Could not init machine\n");
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 082505d08d72..32ef7bdca1cf 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -37,6 +37,15 @@ struct callchain_param callchain_param = {
>  	CALLCHAIN_PARAM_DEFAULT
>  };
>  
> +/*
> + * Are there any events usind DWARF callchains?
> + *
> + * I.e.
> + *
> + * -e cycles/call-graph=dwarf/
> + */
> +bool dwarf_callchain_users;

hum, I don't follow.. this bool seems to mirror the usage of
'param->record_mode = CALLCHAIN_DWARF', whats the difference?

also, the patch title says 'Do not look at globals', while inside you
add new global dwarf_callchain_users and work with it.. what do I miss?

I'll check tomorrow with clean head ;-)

jirka
