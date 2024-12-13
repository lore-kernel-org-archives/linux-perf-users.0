Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DA27715;
	Fri, 13 Dec 2024 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734055122; cv=none; b=DH3/fi6hb4/XXNL4Upu8fycoGR3Py8L5r2d8qL9P4LyHR2fDBFFi0LP8WzEz9LaUV9tnBw1SefvFJcCVui6xkVdZc++eAbf5yEa78Bzu5vp2tn1SH5Oc/ALjPti5tsCE85NeEHb1Pjeal9a8YyD5OVdETJA8Opg4zYx2UsKSFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734055122; c=relaxed/simple;
	bh=2q5aAnyDml+6z3V7SV7EY5YIUtY8cnXL6EDDvBgB2YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeGR1oINrP3uzTWtnxe0NZjpysxo+VG7zMdQFJkEGQbhbaxAd+HA+SLpq/y6XPTewM05DNq33LAxat4QgBYlukSf3S7mo9L4n1d8+bdAlUE6W5xgIBmukH3H0EUs4FOs8mkJ4Tvmi0guw44EErube9BbKJO4lzllnp1ePaNexuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKd8cD/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKd8cD/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FD2C4CECE;
	Fri, 13 Dec 2024 01:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734055121;
	bh=2q5aAnyDml+6z3V7SV7EY5YIUtY8cnXL6EDDvBgB2YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKd8cD/8qsqTeTHK9DgR8/03CAcdVmMhosMCTjrWbf3+COji8IZfA5V08jAg1Q/JT
	 79yPlW3nZuHT/lKNWXs2T2JfGVka2mIEHtlbkxHZNpeLfpo1RDpxB/Zje67nmfuO9L
	 kfGKCOasgXg1VV7IdmH3EU5+aRLuplD0kS4krAjXskRiVONBWyjgXEZhol5jcuUdAh
	 evwqWuHdC0YwWWFePhxk3GIxv/arWWvwvzIBpdHkJwiFSk+Ze3B72RZFLzzSSbFWIJ
	 QwdKy+DcY5XwY7iSDf/mRVU2ki7ysHrdZZ35jCAV7Mq2cV8wkAJhgzcxRiNfmjnQ+/
	 8tijQboVyr+Pw==
Date: Thu, 12 Dec 2024 17:58:39 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v13 09/10] perf record --off-cpu: Add --off-cpu-thresh
 option
Message-ID: <Z1uUz6sU90IQQAyp@google.com>
References: <20241212232717.232507-1-howardchu95@gmail.com>
 <20241212232717.232507-10-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212232717.232507-10-howardchu95@gmail.com>

On Thu, Dec 12, 2024 at 03:27:16PM -0800, Howard Chu wrote:
> Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
> the unit is milliseconds. Default value is 500ms.
> 
> Example:
> 
>   perf record --off-cpu --off-cpu-thresh 824
> 
> The example above collects off-cpu samples where the off-cpu time is
> longer than 824ms
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-2-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  9 ++++++++
>  tools/perf/builtin-record.c              | 26 ++++++++++++++++++++++++
>  tools/perf/util/bpf_off_cpu.c            |  3 +++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c   |  2 +-
>  tools/perf/util/off_cpu.h                |  1 +
>  tools/perf/util/record.h                 |  1 +
>  6 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 242223240a08..f3ac4c739d5f 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -829,6 +829,15 @@ filtered through the mask provided by -C option.
>  	only, as of now.  So the applications built without the frame
>  	pointer might see bogus addresses.
>  
> +	off-cpu profiling consists two types of samples: direct samples, which
> +	share the same behavior as regular samples, and the accumulated
> +	samples, stored in BPF stack trace map, presented after all the regular
> +	samples.
> +
> +--off-cpu-thresh::
> +	Once a task's off-cpu time reaches this threshold (in milliseconds), it
> +	generates a direct off-cpu sample. The default is 500ms.
> +
>  --setup-filter=<action>::
>  	Prepare BPF filter to be used by regular users.  The action should be
>  	either "pin" or "unpin".  The filter can be used after it's pinned.
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 0b637cea4850..62183a6857f2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3147,6 +3147,28 @@ static int record__parse_mmap_pages(const struct option *opt,
>  	return ret;
>  }
>  
> +static int record__parse_off_cpu_thresh(const struct option *opt,
> +					const char *str,
> +					int unset __maybe_unused)
> +{
> +	struct record_opts *opts = opt->value;
> +	char *endptr;
> +	u64 off_cpu_thresh_ms; // converted to us for potential future improvements

I'm not sure about the future, but we now have the option in msec and
convert it to usec, and finally BPF uses nsec.  Is the usec conversion
really needed?  Maybe we can just use nsec internally.

Thanks,
Namhyung

> +
> +	if (!str)
> +		return -EINVAL;
> +
> +	off_cpu_thresh_ms = strtoull(str, &endptr, 10);
> +
> +	/* the threshold isn't string "0", yet strtoull() returns 0, parsing failed */
> +	if (*endptr || (off_cpu_thresh_ms == 0 && strcmp(str, "0")))
> +		return -EINVAL;
> +	else
> +		opts->off_cpu_thresh_us = off_cpu_thresh_ms * USEC_PER_MSEC;
> +
> +	return 0;
> +}
> +
>  void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
>  {
>  }
> @@ -3340,6 +3362,7 @@ static struct record record = {
>  		.ctl_fd              = -1,
>  		.ctl_fd_ack          = -1,
>  		.synth               = PERF_SYNTH_ALL,
> +		.off_cpu_thresh_us   = OFFCPU_THRESH,
>  	},
>  };
>  
> @@ -3562,6 +3585,9 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
>  	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
>  		   "BPF filter action"),
> +	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "ms",
> +		     "Dump off-cpu samples if off-cpu time exceeds this threshold (in milliseconds). (Default: 500ms)",
> +		     record__parse_off_cpu_thresh),
>  	OPT_END()
>  };
>  
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index 2e7e4ae43ffc..c3ac19393c0f 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -14,6 +14,7 @@
>  #include "util/strlist.h"
>  #include <bpf/bpf.h>
>  #include <internal/xyarray.h>
> +#include <linux/time64.h>
>  
>  #include "bpf_skel/off_cpu.skel.h"
>  
> @@ -286,6 +287,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>  		}
>  	}
>  
> +	skel->bss->offcpu_thresh_ns = opts->off_cpu_thresh_us * NSEC_PER_USEC;
> +
>  	err = off_cpu_bpf__attach(skel);
>  	if (err) {
>  		pr_err("Failed to attach off-cpu BPF skeleton\n");
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index 77fdc9e81db3..aae63d999abb 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -123,7 +123,7 @@ const volatile bool uses_cgroup_v1 = false;
>  
>  int perf_subsys_id = -1;
>  
> -__u64 offcpu_thresh_ns = 500000000ull;
> +__u64 offcpu_thresh_ns;
>  
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index 2a4b7f9b2c4c..f07ab2e36317 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -16,6 +16,7 @@ struct record_opts;
>  			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
>  			      PERF_SAMPLE_CGROUP)
>  
> +#define OFFCPU_THRESH 500000ull
>  
>  #ifdef HAVE_BPF_SKEL
>  int off_cpu_prepare(struct evlist *evlist, struct target *target,
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index a6566134e09e..2ca74add26c0 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -79,6 +79,7 @@ struct record_opts {
>  	int	      synth;
>  	int	      threads_spec;
>  	const char    *threads_user_spec;
> +	u64	      off_cpu_thresh_us;
>  };
>  
>  extern const char * const *record_usage;
> -- 
> 2.43.0
> 
