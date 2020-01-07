From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Date: Tue, 7 Jan 2020 13:51:31 +0100
Message-ID: <20200107125131.GZ2844@hirez.programming.kicks-ass.net>
References: <20191223060759.841176-1-namhyung@kernel.org>
 <20191223060759.841176-2-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191223060759.841176-2-namhyung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Stephane Eranian <eranian@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Dec 23, 2019 at 03:07:51PM +0900, Namhyung Kim wrote:

> @@ -7564,6 +7567,105 @@ void perf_event_namespaces(struct task_struct *task)
>  			NULL);
>  }
>  
> +/*
> + * cgroup tracking
> + */
> +#ifdef CONFIG_CGROUPS
> +

<snip>

> +
> +#endif
> +
>  /*
>   * mmap tracking
>   */

> @@ -12581,6 +12685,12 @@ static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
>  	kfree(jc);
>  }
>  
> +static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
> +{
> +	perf_event_cgroup(css->cgroup);
> +	return 0;
> +}
> +
>  static int __perf_cgroup_move(void *info)
>  {
>  	struct task_struct *task = info;
> @@ -12602,6 +12712,7 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
>  struct cgroup_subsys perf_event_cgrp_subsys = {
>  	.css_alloc	= perf_cgroup_css_alloc,
>  	.css_free	= perf_cgroup_css_free,
> +	.css_online	= perf_cgroup_css_online,
>  	.attach		= perf_cgroup_attach,
>  	/*
>  	 * Implicitly enable on dfl hierarchy so that perf events can

CONFIG_CGROUPS vs CONFIG_CGROUP_PERF ?

Other than that, I see nothing wrong here.
