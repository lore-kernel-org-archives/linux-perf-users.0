Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605F02FA0DB;
	Fri,  2 Jan 2026 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767392927; cv=none; b=NVM6etSvNOlrOWeslC4iryz9f+iImERlf9AtnTEPQonUPs/c9DzO8CqWIjnRPU2ptXYkY1n2w+Urigkep7LBZSvvmJDDhYS539ogEmwph3Lra6Zaws9kGD0XRrH/FKBRZbrcwZUqJsSHSoOvwpdoMHfgWmZqvhv9UZPtZbXQd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767392927; c=relaxed/simple;
	bh=9JpciJvoaO4yRdvOdy3XQHc/UZmMuASJ8tJZ9jvZDtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANur+xogzApAK+lTHERwsjpvwBN7+t8VPO1QVHfrhCbOebHal0DLFX6+p8CMwVZmOCrHgaemS5uHE8zMkIVI/O6T2TitlvWKCQYOSZfPT8WJwQX+1+LBHiZ8RmGWN90AsDnyQ8DrxkanAz/9pBWRJTjumLqjtu92VpW5O0O8jgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4R0L2Mm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4R0L2Mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6777FC116B1;
	Fri,  2 Jan 2026 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767392926;
	bh=9JpciJvoaO4yRdvOdy3XQHc/UZmMuASJ8tJZ9jvZDtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4R0L2MmssSv4sNlAOCbLyHttiG0oNphFGdZOiv9+wa4uOML0XUkTcDunAQrmlch0
	 QgG3L3DXYU/HosqmYm+0/5CmikdinWSh7nPVWJ8ZjDt9dO8lWxM5YBj8KQUJIzv7Zt
	 FStVfZ4ZUDci/dI4HsVOjSmzizGMzm9rHmTMOgwpaPvSHHoJxG9FdGbGs/585CqoX5
	 SEsldx8t5Qjb+PjkvytDEml5ZanpUwJCfFreLto+fo/rLFSQMFky8javMivdu2Jwqd
	 5IOnH/c3zvL4K7Rs5xISWh4oXHGLISAP4/szygx/ZxfDtVs0ynlSS32jDuhxq0LVm9
	 7kIC9dlkaC2Ug==
Date: Fri, 2 Jan 2026 14:28:43 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	santosh.shukla@amd.com, sandipan.das@amd.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH RESEND v4 05/11] perf sched stats: Add schedstat v16
 support
Message-ID: <aVhGm6L2mnecKYHU@google.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
 <20250909114227.58802-6-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909114227.58802-6-swapnil.sapkal@amd.com>

On Tue, Sep 09, 2025 at 11:42:21AM +0000, Swapnil Sapkal wrote:
> /proc/schedstat file output is standardized with version number.
> Add support to record and raw dump v16 version layout.

It'd be great if you could write a brief description what's changed in
v16 (and v17 in the next commit).

Thanks,
Namhyung

> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/lib/perf/Makefile                     |   2 +-
>  tools/lib/perf/include/perf/event.h         |  14 ++
>  tools/lib/perf/include/perf/schedstat-v16.h | 146 ++++++++++++++++++++
>  tools/perf/util/event.c                     |   6 +
>  tools/perf/util/synthetic-events.c          |   6 +
>  5 files changed, 173 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 9fa28e512ca8..965e066fd780 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -179,7 +179,7 @@ install_lib: libs
>  		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>  
>  HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
> -HDRS += schedstat-v15.h
> +HDRS += schedstat-v15.h schedstat-v16.h
>  INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>  
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 7ed7bae73b55..4c38a58e19c3 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -489,6 +489,12 @@ struct perf_record_schedstat_cpu_v15 {
>  #undef CPU_FIELD
>  };
>  
> +struct perf_record_schedstat_cpu_v16 {
> +#define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)		_type _name
> +#include "schedstat-v16.h"
> +#undef CPU_FIELD
> +};
> +
>  struct perf_record_schedstat_cpu {
>  	struct perf_event_header header;
>  	__u64			 timestamp;
> @@ -498,6 +504,7 @@ struct perf_record_schedstat_cpu {
>  	char			 __pad[2];
>  	union {
>  		struct perf_record_schedstat_cpu_v15 v15;
> +		struct perf_record_schedstat_cpu_v16 v16;
>  	};
>  };
>  
> @@ -507,6 +514,12 @@ struct perf_record_schedstat_domain_v15 {
>  #undef DOMAIN_FIELD
>  };
>  
> +struct perf_record_schedstat_domain_v16 {
> +#define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)		_type _name
> +#include "schedstat-v16.h"
> +#undef DOMAIN_FIELD
> +};
> +
>  #define DOMAIN_NAME_LEN		16
>  
>  struct perf_record_schedstat_domain {
> @@ -517,6 +530,7 @@ struct perf_record_schedstat_domain {
>  	__u16			 domain;
>  	union {
>  		struct perf_record_schedstat_domain_v15 v15;
> +		struct perf_record_schedstat_domain_v16 v16;
>  	};
>  };
>  
> diff --git a/tools/lib/perf/include/perf/schedstat-v16.h b/tools/lib/perf/include/perf/schedstat-v16.h
> new file mode 100644
> index 000000000000..3462b79c29af
> --- /dev/null
> +++ b/tools/lib/perf/include/perf/schedstat-v16.h
> @@ -0,0 +1,146 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CPU_FIELD
> +CPU_FIELD(__u32, yld_count, "sched_yield() count",
> +	  "%11u", false, yld_count, v16);
> +CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
> +	  "%11u", false, array_exp, v16);
> +CPU_FIELD(__u32, sched_count, "schedule() called",
> +	  "%11u", false, sched_count, v16);
> +CPU_FIELD(__u32, sched_goidle, "schedule() left the processor idle",
> +	  "%11u", true, sched_count, v16);
> +CPU_FIELD(__u32, ttwu_count, "try_to_wake_up() was called",
> +	  "%11u", false, ttwu_count, v16);
> +CPU_FIELD(__u32, ttwu_local, "try_to_wake_up() was called to wake up the local cpu",
> +	  "%11u", true, ttwu_count, v16);
> +CPU_FIELD(__u64, rq_cpu_time, "total runtime by tasks on this processor (in jiffies)",
> +	  "%11llu", false, rq_cpu_time, v16);
> +CPU_FIELD(__u64, run_delay, "total waittime by tasks on this processor (in jiffies)",
> +	  "%11llu", true, rq_cpu_time, v16);
> +CPU_FIELD(__u64, pcount, "total timeslices run on this cpu",
> +	  "%11llu", false, pcount, v16);
> +#endif /* CPU_FIELD */
> +
> +#ifdef DOMAIN_FIELD
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category busy> ");
> +#endif
> +DOMAIN_FIELD(__u32, busy_lb_count,
> +	     "load_balance() count on cpu busy", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, busy_lb_balanced,
> +	     "load_balance() found balanced on cpu busy", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, busy_lb_failed,
> +	     "load_balance() move task failed on cpu busy", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance,
> +	     "imbalance sum on cpu busy", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, busy_lb_gained,
> +	     "pull_task() count on cpu busy", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v16);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD(busy_lb_success_count, "load_balance() success count on cpu busy", "%11u",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v16);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD(busy_lb_avg_pulled,
> +		  "avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v16);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category idle> ");
> +#endif
> +DOMAIN_FIELD(__u32, idle_lb_count,
> +	     "load_balance() count on cpu idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, idle_lb_balanced,
> +	     "load_balance() found balanced on cpu idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, idle_lb_failed,
> +	     "load_balance() move task failed on cpu idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance,
> +	     "imbalance sum on cpu idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, idle_lb_gained,
> +	     "pull_task() count on cpu idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v16);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD(idle_lb_success_count, "load_balance() success count on cpu idle", "%11u",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v16);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD(idle_lb_avg_pulled,
> +		  "avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v16);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category newidle> ");
> +#endif
> +DOMAIN_FIELD(__u32, newidle_lb_count,
> +	     "load_balance() count on cpu newly idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_balanced,
> +	     "load_balance() found balanced on cpu newly idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_failed,
> +	     "load_balance() move task failed on cpu newly idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance,
> +	     "imbalance sum on cpu newly idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_gained,
> +	     "pull_task() count on cpu newly idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
> +	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
> +	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v16);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
> +	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v16);
> +#ifdef DERIVED_CNT_FIELD
> +DERIVED_CNT_FIELD(newidle_lb_success_count,
> +		  "load_balance() success count on cpu newly idle", "%11u",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v16);
> +#endif
> +#ifdef DERIVED_AVG_FIELD
> +DERIVED_AVG_FIELD(newidle_lb_avg_count,
> +		  "avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v16);
> +#endif
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category active_load_balance()> ");
> +#endif
> +DOMAIN_FIELD(__u32, alb_count,
> +	     "active_load_balance() count", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, alb_failed,
> +	     "active_load_balance() move task failed", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, alb_pushed,
> +	     "active_load_balance() successfully moved a task", "%11u", false, v16);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbe_count,
> +	     "sbe_count is not used", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, sbe_balanced,
> +	     "sbe_balanced is not used", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, sbe_pushed,
> +	     "sbe_pushed is not used", "%11u", false, v16);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
> +#endif
> +DOMAIN_FIELD(__u32, sbf_count,
> +	     "sbf_count is not used", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, sbf_balanced,
> +	     "sbf_balanced is not used", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, sbf_pushed,
> +	     "sbf_pushed is not used", "%11u", false, v16);
> +#ifdef DOMAIN_CATEGORY
> +DOMAIN_CATEGORY(" <Wakeup Info> ");
> +#endif
> +DOMAIN_FIELD(__u32, ttwu_wake_remote,
> +	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, ttwu_move_affine,
> +	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v16);
> +DOMAIN_FIELD(__u32, ttwu_move_balance,
> +	     "try_to_wake_up() started passive balancing", "%11u", false, v16);
> +#endif /* DOMAIN_FIELD */
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 41fb942ef701..88a5dad240ac 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -584,6 +584,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
>  	if (version == 15) {
>  #include <perf/schedstat-v15.h>
>  		return size;
> +	} else if (version == 16) {
> +#include <perf/schedstat-v16.h>
> +		return size;
>  	}
>  #undef CPU_FIELD
>  
> @@ -603,6 +606,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
>  	if (version == 15) {
>  #include <perf/schedstat-v15.h>
>  		return size;
> +	} else if (version == 16) {
> +#include <perf/schedstat-v16.h>
> +		return size;
>  	}
>  #undef DOMAIN_FIELD
>  
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 01135d80fde5..499c819bb8ff 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2567,6 +2567,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
>  
>  	if (version == 15) {
>  #include <perf/schedstat-v15.h>
> +	} else if (version == 16) {
> +#include <perf/schedstat-v16.h>
>  	}
>  #undef CPU_FIELD
>  
> @@ -2620,6 +2622,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>  
>  	if (version == 15) {
>  #include <perf/schedstat-v15.h>
> +	} else if (version == 16) {
> +#include <perf/schedstat-v16.h>
>  	}
>  #undef DOMAIN_FIELD
>  
> @@ -2661,6 +2665,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
>  
>  	if (!strcmp(line, "version 15\n")) {
>  		version = 15;
> +	} else if (!strcmp(line, "version 16\n")) {
> +		version = 16;
>  	} else {
>  		pr_err("Unsupported %s version: %s", path, line + 8);
>  		goto out_free_line;
> -- 
> 2.43.0
> 
