From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Date: Fri, 20 Dec 2019 10:36:13 +0100
Message-ID: <20191220093613.GD2844@hirez.programming.kicks-ass.net>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-3-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191220043253.3278951-3-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Dec 20, 2019 at 01:32:46PM +0900, Namhyung Kim wrote:
> The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
> in the sample.  It will add a 64-bit id to identify current cgroup and
> it's the file handle in the cgroup file system.  Userspace should use
> this information with PERF_RECORD_CGROUP event to match which cgroup
> it belongs.
> 
> I put it before PERF_SAMPLE_AUX for simplicity since it just needs a
> 64-bit word.  But if we want bigger samples, I can work on that
> direction too.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---

> @@ -6895,6 +6901,18 @@ void perf_prepare_sample(struct perf_event_header *header,
>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		data->phys_addr = perf_virt_to_phys(data->addr);
>  
> +	if (sample_type & PERF_SAMPLE_CGROUP) {
> +		u64 cgrp_id = 0;
> +#ifdef CONFIG_CGROUP_PERF
> +		struct cgroup *cgrp;
> +
> +		/* protected by RCU */
> +		cgrp = task_css_check(current, perf_event_cgrp_id, 1)->cgroup;
> +		cgrp_id = cgroup_id(cgrp);
> +#endif
> +		data->cgroup = cgrp_id;
> +	}

Would it make more sense to refuse SAMPLE_CGROUP if !CGROUP_PERF?
