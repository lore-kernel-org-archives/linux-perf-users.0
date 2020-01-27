From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 2/7] perf tools: Add support for "report" for some spe
 events
Date: Mon, 27 Jan 2020 13:31:29 +0100
Message-ID: <20200127123129.GE1114818@krava>
References: <20200123160734.3775-1-james.clark@arm.com>
 <20200123160734.3775-3-james.clark@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200123160734.3775-3-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <james.clark@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com, linux-perf-users@vger.kernel.org, Tan Xiaojun <tanxiaojun@huawei.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 23, 2020 at 04:07:29PM +0000, James Clark wrote:

SNIP

> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 749d72cd9c7b..b47108599280 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -111,6 +111,22 @@ struct itrace_synth_opts {
>  	int			range_num;
>  };
>  
> +/**
> + * struct arm_spe_synth_opts - ARM SPE tracing synthesis options.
> + * @set: indicates whether or not options have been set
> + * @llc_miss: whether to synthesize last level cache miss events
> + * @tlb_miss: whether to synthesize TLB miss events
> + * @branch_miss: whether to synthesize Branch miss events
> + * @remote_access: whether to synthesize Remote access events
> + */
> +struct arm_spe_synth_opts {
> +	bool			set;
> +	bool			llc_miss;
> +	bool			tlb_miss;
> +	bool			branch_miss;
> +	bool			remote_access;

hum, why don't you add that to itrace_synth_opts instead? seems generic enough

I don't follow the code much, but I assume itrace_synth_opts is generic object,
as it's already used by some of the s390 and x86 code.. also I don't like new
pointer to synth_ops in perf_session

jirka

> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index f76480166d38..cee134d7643f 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -19,6 +19,7 @@ struct thread;
>  
>  struct auxtrace;
>  struct itrace_synth_opts;
> +struct arm_spe_synth_opts;
>  
>  struct perf_session {
>  	struct perf_header	header;
> @@ -26,6 +27,7 @@ struct perf_session {
>  	struct evlist	*evlist;
>  	struct auxtrace		*auxtrace;
>  	struct itrace_synth_opts *itrace_synth_opts;
> +	struct arm_spe_synth_opts *arm_spe_synth_opts;
>  	struct list_head	auxtrace_index;
>  	struct trace_event	tevent;
>  	struct perf_record_time_conv	time_conv;
> -- 
> 2.25.0
> 
