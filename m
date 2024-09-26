Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E8183CDF;
	Thu, 26 Sep 2024 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331302; cv=none; b=n1bXN55/R1ASe0BCO8fDNZJE8Lnv598YSuzLS4jfUHak54JfprUv/G53ZOcEvtJ7HT0eUi88t2W5wKLiLWdFMlXFLpO8wYfwGIKXQn3bypYbt41RGyz/oDbT19FtvKAGUZlLvKuUZlePpGl3Ju4qNSx2M7P7tRUKYqDQ+gAqeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331302; c=relaxed/simple;
	bh=PIh0pjjy1l9a+BtzF/0FpC5z0gHFa9Z7fDcDVIaMXyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJd46C9j9FwNh3Ooby+Tri2/ODKJNHa6iy9i0d0lZwLb1lUmS7ANC362Qbp+p5GXYyJkLZC4UbY5UYuOEPBSZ0hWaYPSaqvK+bfSCKsa35f62v8PQcjCeAqKHXxwtovSkREa9yxgTqIApr8r/8Oxobyfa3pGTBemTggzhBrvFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQRlMKyB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQRlMKyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FD3C4CEC5;
	Thu, 26 Sep 2024 06:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727331302;
	bh=PIh0pjjy1l9a+BtzF/0FpC5z0gHFa9Z7fDcDVIaMXyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQRlMKyBqnoSOso0fWnuem/LsOMzYLMl+j7mxRy9QRZJ2td9ufcrTfQS1KNbrPOEl
	 G0/eSe3GBSq4v7xrzcsnlOC/baRoZvHhJ1COXMu9SBZqOy0uMR/4YBlcf+FoZQAwAK
	 XLelyjqydnh5kK+CP+Z9KXVTFKYMRMRo9uchQkoAml/4HDK+upJQMQ+gXMtPLoHr2F
	 1dbjUnC4j/qcKAkIFWcOovt58rCDZPWJ4SPUkpN6ez7jezUsVIxnrAlF0F+OGlefz4
	 V94u481IsPJCHzPM5VW8G0Se+Hg9E1iNVHPB/pkm2YooEgLlubt1zFnrQ2291zU3FC
	 CTGOYDH54lW8g==
Date: Wed, 25 Sep 2024 23:14:59 -0700
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
Subject: Re: [PATCH 3/5] perf sched stats: Add schedstat v16 support
Message-ID: <ZvT74_Sp1bQZvqbO@google.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
 <20240916164722.1838-4-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916164722.1838-4-ravi.bangoria@amd.com>

On Mon, Sep 16, 2024 at 04:47:20PM +0000, Ravi Bangoria wrote:
> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> /proc/schedstat file output is standardized with version number.
> Add support to record and raw dump v16 version layout.

How many difference between v15 and v16?  Can we have it in the same
file with a different version number?

Thanks,
Namhyung

> 
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/lib/perf/Makefile                       |  2 +-
>  tools/lib/perf/include/perf/event.h           | 14 +++++++
>  .../lib/perf/include/perf/schedstat-cpu-v16.h | 13 ++++++
>  .../perf/include/perf/schedstat-domain-v16.h  | 40 +++++++++++++++++++
>  tools/perf/util/event.c                       |  6 +++
>  tools/perf/util/synthetic-events.c            |  6 +++
>  6 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v16.h
>  create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v16.h
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index ebbfea891a6a..de0f4ffd9e16 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -187,7 +187,7 @@ install_lib: libs
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>  
> -HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h
> +HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h schedstat-cpu-v16.h schedstat-domain-v16.h
>  INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>  
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 35be296d68d5..c332d467c9c9 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -463,6 +463,12 @@ struct perf_record_schedstat_cpu_v15 {
>  #undef CPU_FIELD
>  };
>  
> +struct perf_record_schedstat_cpu_v16 {
> +#define CPU_FIELD(_type, _name, _ver)		_type _name;
> +#include "schedstat-cpu-v16.h"
> +#undef CPU_FIELD
> +};
> +
>  struct perf_record_schedstat_cpu {
>  	struct perf_event_header header;
>  	__u16			 version;
> @@ -470,6 +476,7 @@ struct perf_record_schedstat_cpu {
>  	__u32			 cpu;
>  	union {
>  		struct perf_record_schedstat_cpu_v15 v15;
> +		struct perf_record_schedstat_cpu_v16 v16;
>  	};
>  };
>  
> @@ -479,6 +486,12 @@ struct perf_record_schedstat_domain_v15 {
>  #undef DOMAIN_FIELD
>  };
>  
> +struct perf_record_schedstat_domain_v16 {
> +#define DOMAIN_FIELD(_type, _name, _ver)	_type _name;
> +#include "schedstat-domain-v16.h"
> +#undef DOMAIN_FIELD
> +};
> +
>  #define DOMAIN_NAME_LEN		16
>  
>  struct perf_record_schedstat_domain {
> @@ -490,6 +503,7 @@ struct perf_record_schedstat_domain {
>  	char			 name[DOMAIN_NAME_LEN];
>  	union {
>  		struct perf_record_schedstat_domain_v15 v15;
> +		struct perf_record_schedstat_domain_v16 v16;
>  	};
>  	__u16			 nr_cpus;
>  	__u8			 cpu_mask[];
> diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v16.h b/tools/lib/perf/include/perf/schedstat-cpu-v16.h
> new file mode 100644
> index 000000000000..f3a55131a05a
> --- /dev/null
> +++ b/tools/lib/perf/include/perf/schedstat-cpu-v16.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CPU_FIELD
> +CPU_FIELD(__u32, yld_count, v16)
> +CPU_FIELD(__u32, array_exp, v16)
> +CPU_FIELD(__u32, sched_count, v16)
> +CPU_FIELD(__u32, sched_goidle, v16)
> +CPU_FIELD(__u32, ttwu_count, v16)
> +CPU_FIELD(__u32, ttwu_local, v16)
> +CPU_FIELD(__u64, rq_cpu_time, v16)
> +CPU_FIELD(__u64, run_delay, v16)
> +CPU_FIELD(__u64, pcount, v16)
> +#endif /* CPU_FIELD */
> diff --git a/tools/lib/perf/include/perf/schedstat-domain-v16.h b/tools/lib/perf/include/perf/schedstat-domain-v16.h
> new file mode 100644
> index 000000000000..d6ef895c9d32
> --- /dev/null
> +++ b/tools/lib/perf/include/perf/schedstat-domain-v16.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef DOMAIN_FIELD
> +DOMAIN_FIELD(__u32, busy_lb_count, v16)
> +DOMAIN_FIELD(__u32, busy_lb_balanced, v16)
> +DOMAIN_FIELD(__u32, busy_lb_failed, v16)
> +DOMAIN_FIELD(__u32, busy_lb_imbalance, v16)
> +DOMAIN_FIELD(__u32, busy_lb_gained, v16)
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained, v16)
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq, v16)
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg, v16)
> +DOMAIN_FIELD(__u32, idle_lb_count, v16)
> +DOMAIN_FIELD(__u32, idle_lb_balanced, v16)
> +DOMAIN_FIELD(__u32, idle_lb_failed, v16)
> +DOMAIN_FIELD(__u32, idle_lb_imbalance, v16)
> +DOMAIN_FIELD(__u32, idle_lb_gained, v16)
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained, v16)
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq, v16)
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg, v16)
> +DOMAIN_FIELD(__u32, newidle_lb_count, v16)
> +DOMAIN_FIELD(__u32, newidle_lb_balanced, v16)
> +DOMAIN_FIELD(__u32, newidle_lb_failed, v16)
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance, v16)
> +DOMAIN_FIELD(__u32, newidle_lb_gained, v16)
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v16)
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v16)
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v16)
> +DOMAIN_FIELD(__u32, alb_count, v16)
> +DOMAIN_FIELD(__u32, alb_failed, v16)
> +DOMAIN_FIELD(__u32, alb_pushed, v16)
> +DOMAIN_FIELD(__u32, sbe_count, v16)
> +DOMAIN_FIELD(__u32, sbe_balanced, v16)
> +DOMAIN_FIELD(__u32, sbe_pushed, v16)
> +DOMAIN_FIELD(__u32, sbf_count, v16)
> +DOMAIN_FIELD(__u32, sbf_balanced, v16)
> +DOMAIN_FIELD(__u32, sbf_pushed, v16)
> +DOMAIN_FIELD(__u32, ttwu_wake_remote, v16)
> +DOMAIN_FIELD(__u32, ttwu_move_affine, v16)
> +DOMAIN_FIELD(__u32, ttwu_move_balance, v16)
> +#endif /* DOMAIN_FIELD */
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index c9bc8237e3fa..d138e4a5787c 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -566,6 +566,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
>  	if (version == 15) {
>  #include <perf/schedstat-cpu-v15.h>
>  		return size;
> +	} else if (version == 16) {
> +#include <perf/schedstat-cpu-v16.h>
> +		return size;
>  	}
>  #undef CPU_FIELD
>  
> @@ -641,6 +644,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
>  	if (version == 15) {
>  #include <perf/schedstat-domain-v15.h>
>  		return size;
> +	} else if (version == 16) {
> +#include <perf/schedstat-domain-v16.h>
> +		return size;
>  	}
>  #undef DOMAIN_FIELD
>  
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 9d8450b6eda9..73b2492a4cde 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2546,6 +2546,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
>  
>  	if (version == 15) {
>  #include <perf/schedstat-cpu-v15.h>
> +	} else if (version == 16) {
> +#include <perf/schedstat-cpu-v16.h>
>  	}
>  #undef CPU_FIELD
>  
> @@ -2667,6 +2669,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>  
>  	if (version == 15) {
>  #include <perf/schedstat-domain-v15.h>
> +	} else if (version == 16) {
> +#include <perf/schedstat-domain-v16.h>
>  	}
>  #undef DOMAIN_FIELD
>  
> @@ -2709,6 +2713,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
>  
>  	if (!strcmp(line, "version 15\n")) {
>  		version = 15;
> +	} else if (!strcmp(line, "version 16\n")) {
> +		version = 16;
>  	} else {
>  		pr_err("Unsupported /proc/schedstat version: %s", line + 8);
>  		goto out_free_line;
> -- 
> 2.46.0
> 
