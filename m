Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18661171C;
	Thu, 26 Sep 2024 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331161; cv=none; b=pxLk3nMKr1Ir7CmKHnFSd1ARpY7A17BT+Z1F7e1Kxc1ASTHztLfSPBo10Eu/DpqIcLHAr5hkSADmFW4a3h2SeCunQzMGROZhjKfrWqWK0JqL/yAxwQRTv3bVsUqIbnL8J23w4ZJPRPBXCGsyo/L+E7cq40j5NmVOnXAaEy+RBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331161; c=relaxed/simple;
	bh=vyhvbMXo1ody6rcBI8E09FjxzCy/zj4ub5XtiAxNTHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e73Ld7do0/4MILBh9L1i9ErGenyF92pnmKDJ/B+27XhgLoZIujLROwsULU308ODr9jRlssUzI0464wx++6CyoSp/mWfZHCclWeUNHqfmkE+Ld15U9sEFf+1qnc2ddVY/rxQe/F43g1xiNvxGm8npw04QYky5gEuJkhc9ziP8kYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2BLsJsk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2BLsJsk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477B7C4CEC5;
	Thu, 26 Sep 2024 06:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727331161;
	bh=vyhvbMXo1ody6rcBI8E09FjxzCy/zj4ub5XtiAxNTHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2BLsJskTeJI1aP1XGCAMyahlW0mF2MaYnOVVHQPCaRkpIBDLeGI1bzkkBdSEkJ4B
	 kS/cGKlT23HLDZ4wdo1Njgc26A2d45DoV9OEfOgzydCWqLhIpQo3mQ3yPvlVFsCe9/
	 QWkHAZOS6JC4+D8FoUGVw/eT4rLFegj5ePGKA27kNmWxv1V83qM5+MRGlF8xoM5lX1
	 QBhfknnYj6ZtK15MXDqhjUlbTtpA3/8iuz8qeLGuIxVHgEYGcCdG6kR0j8ZZyHGK6O
	 oSAxt5cY8EOJSeo5QDe10dneU7WOo+dSXojxHWscs5tLx033Ux+zaC8DlzdFJGqXsr
	 wnQIuGGdLgI5A==
Date: Wed, 25 Sep 2024 23:12:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	irogers@google.com, swapnil.sapkal@amd.com, yu.c.chen@intel.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
	bristot@redhat.com, adrian.hunter@intel.com, james.clark@arm.com,
	kan.liang@linux.intel.com, gautham.shenoy@amd.com,
	kprateek.nayak@amd.com, juri.lelli@redhat.com,
	yangjihong@bytedance.com, void@manifault.com, tj@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH 2/5] perf sched stats: Add record and rawdump support
Message-ID: <ZvT7VkSUpNFKfqge@google.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
 <20240916164722.1838-3-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916164722.1838-3-ravi.bangoria@amd.com>

On Mon, Sep 16, 2024 at 04:47:19PM +0000, Ravi Bangoria wrote:
> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> Define new, perf tool only, sample types and their layouts. Add logic
> to parse /proc/schedstat, convert it to perf sample format and save
> samples to perf.data file with `perf sched stats record` command. Also
> add logic to read perf.data file, interpret schedstat samples and
> print rawdump of samples with `perf script -D`.
> 
> Note that, /proc/schedstat file output is standardized with version
> number. The patch supports v15 but older or newer version can be added
> easily.
> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt      |   2 +
>  tools/lib/perf/Makefile                       |   2 +-
>  tools/lib/perf/include/perf/event.h           |  42 +++
>  .../lib/perf/include/perf/schedstat-cpu-v15.h |  13 +
>  .../perf/include/perf/schedstat-domain-v15.h  |  40 +++
>  tools/perf/builtin-inject.c                   |   2 +
>  tools/perf/builtin-sched.c                    | 222 +++++++++++++++-
>  tools/perf/util/event.c                       |  98 +++++++
>  tools/perf/util/event.h                       |   2 +
>  tools/perf/util/session.c                     |  20 ++
>  tools/perf/util/synthetic-events.c            | 249 ++++++++++++++++++
>  tools/perf/util/synthetic-events.h            |   3 +
>  tools/perf/util/tool.c                        |  20 ++
>  tools/perf/util/tool.h                        |   4 +-
>  14 files changed, 716 insertions(+), 3 deletions(-)
>  create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v15.h
>  create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v15.h
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index fcfb9499ef9c..39c78682ad2e 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -211,6 +211,8 @@ SYNOPSIS
>    struct perf_record_time_conv;
>    struct perf_record_header_feature;
>    struct perf_record_compressed;
> +  struct perf_record_schedstat_cpu;
> +  struct perf_record_schedstat_domain;
>  --
>  
>  DESCRIPTION
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index 3a9b2140aa04..ebbfea891a6a 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -187,7 +187,7 @@ install_lib: libs
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>  
> -HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
> +HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h
>  INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>  
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 37bb7771d914..35be296d68d5 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -457,6 +457,44 @@ struct perf_record_compressed {
>  	char			 data[];
>  };
>  
> +struct perf_record_schedstat_cpu_v15 {
> +#define CPU_FIELD(_type, _name, _ver)		_type _name;
> +#include "schedstat-cpu-v15.h"
> +#undef CPU_FIELD
> +};
> +
> +struct perf_record_schedstat_cpu {
> +	struct perf_event_header header;
> +	__u16			 version;
> +	__u64			 timestamp;
> +	__u32			 cpu;

Can you change the layout to minimize the paddings?  Probably better to
add an explicit field for unused bits.


> +	union {
> +		struct perf_record_schedstat_cpu_v15 v15;
> +	};
> +};
> +
> +struct perf_record_schedstat_domain_v15 {
> +#define DOMAIN_FIELD(_type, _name, _ver)	_type _name;
> +#include "schedstat-domain-v15.h"
> +#undef DOMAIN_FIELD
> +};
> +
> +#define DOMAIN_NAME_LEN		16
> +
> +struct perf_record_schedstat_domain {
> +	struct perf_event_header header;
> +	__u16			 version;
> +	__u64			 timestamp;
> +	__u32			 cpu;
> +	__u16			 domain;

Ditto.

> +	char			 name[DOMAIN_NAME_LEN];
> +	union {
> +		struct perf_record_schedstat_domain_v15 v15;
> +	};
> +	__u16			 nr_cpus;
> +	__u8			 cpu_mask[];
> +};
> +
>  enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_USER_TYPE_START		= 64,
>  	PERF_RECORD_HEADER_ATTR			= 64,
> @@ -478,6 +516,8 @@ enum perf_user_event_type { /* above any possible kernel type */
>  	PERF_RECORD_HEADER_FEATURE		= 80,
>  	PERF_RECORD_COMPRESSED			= 81,
>  	PERF_RECORD_FINISHED_INIT		= 82,
> +	PERF_RECORD_SCHEDSTAT_CPU		= 83,
> +	PERF_RECORD_SCHEDSTAT_DOMAIN		= 84,
>  	PERF_RECORD_HEADER_MAX
>  };
>  
> @@ -518,6 +558,8 @@ union perf_event {
>  	struct perf_record_time_conv		time_conv;
>  	struct perf_record_header_feature	feat;
>  	struct perf_record_compressed		pack;
> +	struct perf_record_schedstat_cpu	schedstat_cpu;
> +	struct perf_record_schedstat_domain	schedstat_domain;
>  };
>  
>  #endif /* __LIBPERF_EVENT_H */
> diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v15.h b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
> new file mode 100644
> index 000000000000..8e4355ee3705
> --- /dev/null
> +++ b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CPU_FIELD
> +CPU_FIELD(__u32, yld_count, v15)
> +CPU_FIELD(__u32, array_exp, v15)
> +CPU_FIELD(__u32, sched_count, v15)
> +CPU_FIELD(__u32, sched_goidle, v15)
> +CPU_FIELD(__u32, ttwu_count, v15)
> +CPU_FIELD(__u32, ttwu_local, v15)
> +CPU_FIELD(__u64, rq_cpu_time, v15)
> +CPU_FIELD(__u64, run_delay, v15)
> +CPU_FIELD(__u64, pcount, v15)
> +#endif

Can we have a single schedstat.h containing both CPU fields and domain
fields?  You might require users to define the macro always and get rid
of the ifdef condition here.

Also is there any macro magic to handle the version number?  I think you
can have the number only (15; without 'v') and compare with input if
needed..

Thanks,
Namhyung


> diff --git a/tools/lib/perf/include/perf/schedstat-domain-v15.h b/tools/lib/perf/include/perf/schedstat-domain-v15.h
> new file mode 100644
> index 000000000000..422e713d617a
> --- /dev/null
> +++ b/tools/lib/perf/include/perf/schedstat-domain-v15.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef DOMAIN_FIELD
> +DOMAIN_FIELD(__u32, idle_lb_count, v15)
> +DOMAIN_FIELD(__u32, idle_lb_balanced, v15)
> +DOMAIN_FIELD(__u32, idle_lb_failed, v15)
> +DOMAIN_FIELD(__u32, idle_lb_imbalance, v15)
> +DOMAIN_FIELD(__u32, idle_lb_gained, v15)
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained, v15)
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq, v15)
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg, v15)
> +DOMAIN_FIELD(__u32, busy_lb_count, v15)
> +DOMAIN_FIELD(__u32, busy_lb_balanced, v15)
> +DOMAIN_FIELD(__u32, busy_lb_failed, v15)
> +DOMAIN_FIELD(__u32, busy_lb_imbalance, v15)
> +DOMAIN_FIELD(__u32, busy_lb_gained, v15)
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained, v15)
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq, v15)
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg, v15)
> +DOMAIN_FIELD(__u32, newidle_lb_count, v15)
> +DOMAIN_FIELD(__u32, newidle_lb_balanced, v15)
> +DOMAIN_FIELD(__u32, newidle_lb_failed, v15)
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance, v15)
> +DOMAIN_FIELD(__u32, newidle_lb_gained, v15)
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v15)
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v15)
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v15)
> +DOMAIN_FIELD(__u32, alb_count, v15)
> +DOMAIN_FIELD(__u32, alb_failed, v15)
> +DOMAIN_FIELD(__u32, alb_pushed, v15)
> +DOMAIN_FIELD(__u32, sbe_count, v15)
> +DOMAIN_FIELD(__u32, sbe_balanced, v15)
> +DOMAIN_FIELD(__u32, sbe_pushed, v15)
> +DOMAIN_FIELD(__u32, sbf_count, v15)
> +DOMAIN_FIELD(__u32, sbf_balanced, v15)
> +DOMAIN_FIELD(__u32, sbf_pushed, v15)
> +DOMAIN_FIELD(__u32, ttwu_wake_remote, v15)
> +DOMAIN_FIELD(__u32, ttwu_move_affine, v15)
> +DOMAIN_FIELD(__u32, ttwu_move_balance, v15)
> +#endif /* DOMAIN_FIELD */
