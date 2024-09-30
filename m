Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796813D881;
	Mon, 30 Sep 2024 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674820; cv=none; b=uRS5+XgGKJHuYYubpYHcK2RrY3baW5WAtEbuxwlEHEuv5jgl7FqtWthn6ObHpjdOKYQTvXo/vRKqTF01KQLEh3Fn8ZaS4zNxR3b9d51MFJcGBHYjxDf7qDlLIzDMXhb15yM7fd200zgSFo40iUEN82Lyt0WMNm0hzbpXGoRDIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674820; c=relaxed/simple;
	bh=73ua3ebCJFBwUFZlCvtMIQ/sfiZmDsqsyODFb2ktLlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=su5Pg3SLUVH6Q0Tv5xP0wYRTRjvrr99ju0Rl1NbbXJQ+YkNMSxm6iCilO7v29UEf+DeGZjtmiVJk6tF0Hi+bvK3g9u3rQEiGRwdI9LfKvnzlRS9oGFr9X7M1s+72uOulCSyuiIBB3/QKPxbN0tgG8I+xkNWiBaC2MMpxk1vJGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBT6T+67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBT6T+67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04F4C4CECE;
	Mon, 30 Sep 2024 05:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727674819;
	bh=73ua3ebCJFBwUFZlCvtMIQ/sfiZmDsqsyODFb2ktLlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBT6T+67aVzJZd2Kg1UTB+42YafTzmzy3zwt3fdcV3rYWVqr650TqeN0QB6syIwUB
	 1RoD5dnsGrqQHtS1rTZuYO1DZfrwi9kv9GQklunO8iq08xOhXznfxMTFhAzvnv0GvG
	 1zDMZWa0iD1G5rQwLVl/a3PVjFA5nlNlh3InbCpizAdBHPmoYr4CWIKuZ7U+aXsW1f
	 O7beiIQ7XMXg8I5RkL6JYyBLLNntA3zxqWxqOuUA9Ic1vvjD7HI1PEc6psbmbt2kuS
	 sH2/tOiGC0h4Q6mOQPcsoK/sUXj66S2diJ0DOKWiY8wRckq4FVq8LMvf0JBnMTQkmA
	 5V1eDRgo2tJrg==
Date: Sun, 29 Sep 2024 22:40:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] perf record --off-cpu: Add --off-cpu-thresh
Message-ID: <Zvo5weauCaaKQQ8b@google.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
 <20240927202736.767941-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927202736.767941-3-howardchu95@gmail.com>

On Fri, Sep 27, 2024 at 01:27:30PM -0700, Howard Chu wrote:
> Add the --off-cpu-thresh argument to specify the off-cpu time threshold.
> If the off-cpu time exceeds this threshold, dump the off-cpu data
> directly.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-record.c            | 26 ++++++++++++++++++++++++++
>  tools/perf/util/bpf_off_cpu.c          |  2 ++
>  tools/perf/util/bpf_skel/off_cpu.bpf.c |  2 ++
>  tools/perf/util/off_cpu.h              |  2 ++
>  tools/perf/util/record.h               |  1 +
>  5 files changed, 33 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index adbaf80b398c..bd53fb3c98ec 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3149,6 +3149,28 @@ static int record__parse_mmap_pages(const struct option *opt,
>  	return ret;
>  }
>  
> +static int record__parse_off_cpu_thresh(const struct option *opt,
> +					const char *str,
> +					int unset __maybe_unused)
> +{
> +	struct record_opts *opts = opt->value;
> +	char *endptr;
> +	u64 off_cpu_thresh;
> +
> +	if (!str)
> +		return -EINVAL;
> +
> +	off_cpu_thresh = strtoul(str, &endptr, 10);

Do you mean strtoull() ?


> +
> +	/* threshold isn't string "0", yet strtoull() returns 0, parsing failed */
> +	if (*endptr || (off_cpu_thresh == 0 && strcmp(str, "0")))
> +		return -EINVAL;
> +	else
> +		opts->off_cpu_thresh = off_cpu_thresh;
> +
> +	return 0;
> +}
> +
>  void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
>  {
>  }
> @@ -3342,6 +3364,7 @@ static struct record record = {
>  		.ctl_fd              = -1,
>  		.ctl_fd_ack          = -1,
>  		.synth               = PERF_SYNTH_ALL,
> +		.off_cpu_thresh      = OFF_CPU_THRESH_DEFAULT,
>  	},
>  };
>  
> @@ -3564,6 +3587,9 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
>  	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
>  		   "BPF filter action"),
> +	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
> +		     "Dump off-cpu samples if off-cpu time reaches this threshold. The unit is microsecond (default: 500000)",
> +		     record__parse_off_cpu_thresh),
>  	OPT_END()
>  };
>  
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index a590a8ac1f9d..eaef643f50e3 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -272,6 +272,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>  		}
>  	}
>  
> +	skel->bss->offcpu_thresh = opts->off_cpu_thresh * 1000;
> +
>  	err = off_cpu_bpf__attach(skel);
>  	if (err) {
>  		pr_err("Failed to attach off-cpu BPF skeleton\n");
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index c152116df72f..5ea320aa9a53 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -97,6 +97,8 @@ const volatile bool uses_cgroup_v1 = false;
>  
>  int perf_subsys_id = -1;
>  
> +__u64 sample_id, sample_type, offcpu_thresh;

The sample_id and sample_type aren't used in the patch.

Thanks,
Namhyung

> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index 2dd67c60f211..357231cb1c38 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -10,6 +10,8 @@ struct record_opts;
>  
>  #define OFFCPU_EVENT  "offcpu-time"
>  
> +#define OFF_CPU_THRESH_DEFAULT 500000ull
> +
>  #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
>  			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
>  			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> index a6566134e09e..3c11416e6627 100644
> --- a/tools/perf/util/record.h
> +++ b/tools/perf/util/record.h
> @@ -79,6 +79,7 @@ struct record_opts {
>  	int	      synth;
>  	int	      threads_spec;
>  	const char    *threads_user_spec;
> +	u64	      off_cpu_thresh;
>  };
>  
>  extern const char * const *record_usage;
> -- 
> 2.43.0
> 
