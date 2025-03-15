Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F0C53BE;
	Sat, 15 Mar 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005649; cv=none; b=Pa07ewCWP2SyHt80gi8c6+aH8nr6XaUVio8JAW0mLzs3KwhjshaCfjQZWk2BU6srww54tM/DAb8MVtR1dulLwGcWL2QWCShsOQ5E7cPu+qM0mxR6noFyN1O2uonvjpQcp58oJ+3hLosajc7oU7i2pyAeaHRD/oR5qcnELzBqpTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005649; c=relaxed/simple;
	bh=TNSdDBcGM3JyZzxbjoqECyoKrN7mYTergGEKrQjnPxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo9yUNyU9WF9kB4eDUbbHjuFIrlDDhv7uZsV3w/mH0SIrRyg9Ovkp9UMLLIY9nQCxaAPjo1j9e6Vu+spZlDf/34WKT6cKvqy4nOcYG9Cc8quCOezqP9gc1I3rgk63e1QnNNzTPfj+V1a545/XTtHlBkstyIEs41YmQNpjlBmhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKlw+IyL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKlw+IyL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB1DC4CEE3;
	Sat, 15 Mar 2025 02:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742005649;
	bh=TNSdDBcGM3JyZzxbjoqECyoKrN7mYTergGEKrQjnPxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKlw+IyLB+6wXCtVSyExNDCytb6Fi/Hue/AhlffPegicPne4tRygnZZorFTIoR7N1
	 t3gbvqz5zAKJJQZSKnAVDAfZpm2BWudi4Lb7q+Qo2XTlZDGb0nv8e1FBKoGLYOx1Wc
	 zZeFYF7MXsR/ynpoet+lCf/kojYa9tFOwcrexINFjBNWBlhIPEs19heTEJnXm5pbUy
	 1MMN3GKug03Ip8P/xjn0BBZTLX5wMUqV8K9rsIz2e4ZzvTYAQQFl8SX0ayuYpHqtIC
	 qwhEJcalLx0lvDXJpV04Y0PoZV6LpJtlc20KUHJ2GBUAAZTgqXJr2Vu1kmlT2+dwqk
	 BqTyKNsZnkPpQ==
Date: Fri, 14 Mar 2025 19:27:26 -0700
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
	tj@kernel.org, sshegde@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com
Subject: Re: [PATCH v3 3/8] perf sched stats: Add schedstat v17 support
Message-ID: <Z9Tljo_cyid7NCgV@google.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <20250311120230.61774-4-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311120230.61774-4-swapnil.sapkal@amd.com>

On Tue, Mar 11, 2025 at 12:02:25PM +0000, Swapnil Sapkal wrote:
> /proc/schedstat file output is standardized with version number.
> Add support to record and raw dump v17 version layout.
> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/lib/perf/Makefile                     |  2 +-
>  tools/lib/perf/include/perf/event.h         | 14 +++++
>  tools/lib/perf/include/perf/schedstat-v17.h | 61 +++++++++++++++++++++
>  tools/perf/util/event.c                     |  6 ++
>  tools/perf/util/synthetic-events.c          | 15 +++++
>  5 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index d0506a13a97f..30712ce8b6b1 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -174,7 +174,7 @@ install_lib: libs
>  		$(call do_install_mkdir,$(libdir_SQ)); \
>  		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>  
> -HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h schedstat-v16.h
> +HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-v15.h schedstat-v16.h schedstat-v17.h

Please put them in a separate line like

HDRS += schedstat-v15.h schedstat-v16.h schedstat-v17.h

Thanks,
Namhyung


>  INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>  
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index 8ef70799e070..0d1983ad9a41 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -469,12 +469,19 @@ struct perf_record_schedstat_cpu_v16 {
>  #undef CPU_FIELD
>  };
>  
> +struct perf_record_schedstat_cpu_v17 {
> +#define CPU_FIELD(_type, _name, _ver)		_type _name
> +#include "schedstat-v17.h"
> +#undef CPU_FIELD
> +};
> +
>  struct perf_record_schedstat_cpu {
>  	struct perf_event_header header;
>  	__u64			 timestamp;
>  	union {
>  		struct perf_record_schedstat_cpu_v15 v15;
>  		struct perf_record_schedstat_cpu_v16 v16;
> +		struct perf_record_schedstat_cpu_v17 v17;
>  	};
>  	__u32			 cpu;
>  	__u16			 version;
> @@ -492,6 +499,12 @@ struct perf_record_schedstat_domain_v16 {
>  #undef DOMAIN_FIELD
>  };
>  
> +struct perf_record_schedstat_domain_v17 {
> +#define DOMAIN_FIELD(_type, _name, _ver)	_type _name
> +#include "schedstat-v17.h"
> +#undef DOMAIN_FIELD
> +};
> +
>  #define DOMAIN_NAME_LEN		16
>  
>  struct perf_record_schedstat_domain {
> @@ -504,6 +517,7 @@ struct perf_record_schedstat_domain {
>  	union {
>  		struct perf_record_schedstat_domain_v15 v15;
>  		struct perf_record_schedstat_domain_v16 v16;
> +		struct perf_record_schedstat_domain_v17 v17;
>  	};
>  	__u16			 nr_cpus;
>  	__u8			 cpu_mask[];
> diff --git a/tools/lib/perf/include/perf/schedstat-v17.h b/tools/lib/perf/include/perf/schedstat-v17.h
> new file mode 100644
> index 000000000000..851d4f1f4ecb
> --- /dev/null
> +++ b/tools/lib/perf/include/perf/schedstat-v17.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifdef CPU_FIELD
> +CPU_FIELD(__u32, yld_count, v17);
> +CPU_FIELD(__u32, array_exp, v17);
> +CPU_FIELD(__u32, sched_count, v17);
> +CPU_FIELD(__u32, sched_goidle, v17);
> +CPU_FIELD(__u32, ttwu_count, v17);
> +CPU_FIELD(__u32, ttwu_local, v17);
> +CPU_FIELD(__u64, rq_cpu_time, v17);
> +CPU_FIELD(__u64, run_delay, v17);
> +CPU_FIELD(__u64, pcount, v17);
> +#endif
> +
> +#ifdef DOMAIN_FIELD
> +DOMAIN_FIELD(__u32, busy_lb_count, v17);
> +DOMAIN_FIELD(__u32, busy_lb_balanced, v17);
> +DOMAIN_FIELD(__u32, busy_lb_failed, v17);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance_load, v17);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance_util, v17);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance_task, v17);
> +DOMAIN_FIELD(__u32, busy_lb_imbalance_misfit, v17);
> +DOMAIN_FIELD(__u32, busy_lb_gained, v17);
> +DOMAIN_FIELD(__u32, busy_lb_hot_gained, v17);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyq, v17);
> +DOMAIN_FIELD(__u32, busy_lb_nobusyg, v17);
> +DOMAIN_FIELD(__u32, idle_lb_count, v17);
> +DOMAIN_FIELD(__u32, idle_lb_balanced, v17);
> +DOMAIN_FIELD(__u32, idle_lb_failed, v17);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance_load, v17);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance_util, v17);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance_task, v17);
> +DOMAIN_FIELD(__u32, idle_lb_imbalance_misfit, v17);
> +DOMAIN_FIELD(__u32, idle_lb_gained, v17);
> +DOMAIN_FIELD(__u32, idle_lb_hot_gained, v17);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyq, v17);
> +DOMAIN_FIELD(__u32, idle_lb_nobusyg, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_count, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_balanced, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_failed, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance_load, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance_util, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance_task, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_imbalance_misfit, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_gained, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v17);
> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v17);
> +DOMAIN_FIELD(__u32, alb_count, v17);
> +DOMAIN_FIELD(__u32, alb_failed, v17);
> +DOMAIN_FIELD(__u32, alb_pushed, v17);
> +DOMAIN_FIELD(__u32, sbe_count, v17);
> +DOMAIN_FIELD(__u32, sbe_balanced, v17);
> +DOMAIN_FIELD(__u32, sbe_pushed, v17);
> +DOMAIN_FIELD(__u32, sbf_count, v17);
> +DOMAIN_FIELD(__u32, sbf_balanced, v17);
> +DOMAIN_FIELD(__u32, sbf_pushed, v17);
> +DOMAIN_FIELD(__u32, ttwu_wake_remote, v17);
> +DOMAIN_FIELD(__u32, ttwu_move_affine, v17);
> +DOMAIN_FIELD(__u32, ttwu_move_balance, v17);
> +#endif
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 64f81e7b7f70..d09c3c99ab48 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -569,6 +569,9 @@ size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
>  	} else if (version == 16) {
>  #include <perf/schedstat-v16.h>
>  		return size;
> +	} else if (version == 17) {
> +#include <perf/schedstat-v17.h>
> +		return size;
>  	}
>  #undef CPU_FIELD
>  
> @@ -647,6 +650,9 @@ size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
>  	} else if (version == 16) {
>  #include <perf/schedstat-v16.h>
>  		return size;
> +	} else if (version == 17) {
> +#include <perf/schedstat-v17.h>
> +		return size;
>  	}
>  #undef DOMAIN_FIELD
>  
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index e9dc1e14cfea..fad0c472f297 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2551,6 +2551,8 @@ static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version
>  #include <perf/schedstat-v15.h>
>  	} else if (version == 16) {
>  #include <perf/schedstat-v16.h>
> +	} else if (version == 17) {
> +#include <perf/schedstat-v17.h>
>  	}
>  #undef CPU_FIELD
>  
> @@ -2589,6 +2591,7 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>  	int nr_cpus_avail = perf_env__nr_cpus_avail(&env);
>  	struct perf_record_schedstat_domain *ds;
>  	union perf_event *event;
> +	size_t d_name_len = 0;
>  	char *d_name = NULL;
>  	size_t cpu_mask_len = 0;
>  	char *cpu_mask = NULL;
> @@ -2604,6 +2607,12 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>  		return NULL;
>  
>  	ch = io__get_dec(io, &d_num);
> +	if (version >= 17) {
> +		if (io__getdelim(io, &d_name, &d_name_len, ' ') < 0 || !d_name_len)
> +			return NULL;
> +		d_name[d_name_len - 1] = '\0';
> +		d_name_len--;
> +	}
>  
>  	if (io__getdelim(io, &cpu_mask, &cpu_mask_len, ' ') < 0 || !cpu_mask_len)
>  		goto out;
> @@ -2650,6 +2659,7 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>  		low = !low;
>  	}
>  
> +	free(d_name);
>  	free(cpu_mask);
>  
>  #define DOMAIN_FIELD(_type, _name, _ver)				\
> @@ -2665,6 +2675,8 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>  #include <perf/schedstat-v15.h>
>  	} else if (version == 16) {
>  #include <perf/schedstat-v16.h>
> +	} else if (version == 17) {
> +#include <perf/schedstat-v17.h>
>  	}
>  #undef DOMAIN_FIELD
>  
> @@ -2676,6 +2688,7 @@ static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 vers
>  out_cpu_mask:
>  	free(cpu_mask);
>  out:
> +	free(d_name);
>  	return NULL;
>  }
>  
> @@ -2709,6 +2722,8 @@ int perf_event__synthesize_schedstat(const struct perf_tool *tool,
>  		version = 15;
>  	} else if (!strcmp(line, "version 16\n")) {
>  		version = 16;
> +	} else if (!strcmp(line, "version 17\n")) {
> +		version = 17;
>  	} else {
>  		pr_err("Unsupported %s version: %s", path, line + 8);
>  		goto out_free_line;
> -- 
> 2.43.0
> 
