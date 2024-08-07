Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DDC146A60;
	Wed,  7 Aug 2024 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072948; cv=none; b=n6+AXSxAhbTrSBCZCIryY4u6/M0Q9GT34hEHKSkhS3GAbiNvFcD6BlPfdYGJpJSjAIQTdrv48uU5CmRUjYH85uPDd536T/nmalTxidMgo3aLdq+XQlvmhpK8HACCOANXWgQx6GWd35SgfBIZUadwnF4VPc4MLL8FMbHQLmX8krg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072948; c=relaxed/simple;
	bh=kZcvdORm8Z6hdQMsfySGZsXFyez63ONk4Yi0bS6QDN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFCuZq6K95I1s8xxsxC/oLKfrODk+MabnzK+Ps4nRmZmbCUGF23tF+8mrAeBBDrIupk5Kz0y+KYBv2KUZk00/odeulGYWtnN4CkX/8S5plhwP/TC9W/MInTaZOdBDlWoQ/OsYw4+/sRrcpF506wbQkz5Hupd2/uzUH93Jil9+2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFQEKbQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFQEKbQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08E0C32781;
	Wed,  7 Aug 2024 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723072948;
	bh=kZcvdORm8Z6hdQMsfySGZsXFyez63ONk4Yi0bS6QDN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFQEKbQ7CCZWmzBV2yhNHA9DbBIZYG9Pb7c4Ih3tz4UOIfkEKk+d8/dFkZvWeNFul
	 FFqX1INmaqhZBcMU6jr8yqLIbbfmXDUP0Ivmz8Tt1KOouUZiPSIMXjGB3c5avMQFTg
	 1qN2hWNZpVaYFgqQegkoXAK8wuzriHp4xwBOePLz3YSIYLKSUgLrdblh2jmU9Me5h5
	 1ZqZAZxC1j9CkMNzTpkETzFTmR+THiGnMymuHmAIOPBaNBXnIGo4ZHWHkZJRL2V+bx
	 6kNLYxpUTuxXenR3W9x85nOrWbTup0bgFDb6RP7+SukX7Moq9Lxgap+qYO+JD26mEn
	 YymRSgaDC+WTw==
Date: Wed, 7 Aug 2024 16:22:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] perf record --off-cpu: Add --off-cpu-thresh
Message-ID: <ZrQBsmfS-RcXmncw@google.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807153843.3231451-3-howardchu95@gmail.com>

On Wed, Aug 07, 2024 at 11:38:36PM +0800, Howard Chu wrote:
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
>  tools/perf/util/record.h               |  1 +
>  4 files changed, 31 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 72345d1e54b0..60c6fe7b4804 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3133,6 +3133,28 @@ static int record__parse_mmap_pages(const struct option *opt,
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
> +
> +	/* threshold isn't string "0", yet strtoull() returns 0, parsing failed. */
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
> @@ -3326,6 +3348,7 @@ static struct record record = {
>  		.ctl_fd              = -1,
>  		.ctl_fd_ack          = -1,
>  		.synth               = PERF_SYNTH_ALL,
> +		.off_cpu_thresh      = OFF_CPU_THRESH_DEFAULT,

Where is it defined?

Thanks,
Namhyung


>  	},
>  	.tool = {
>  		.sample		= process_sample_event,
> @@ -3560,6 +3583,9 @@ static struct option __record_options[] = {
>  	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
>  	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
>  		   "BPF filter action"),
> +	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "us",
> +		     "Dump off-cpu samples if off-cpu time reaches this threshold. The unit is microseconds. (default: 500000)",
> +		     record__parse_off_cpu_thresh),
>  	OPT_END()
>  };
>  
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index 6af36142dc5a..1e0e454bfb5e 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -272,6 +272,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>  		}
>  	}
>  
> +	skel->bss->offcpu_thresh = opts->off_cpu_thresh * 1000ull;
> +
>  	err = off_cpu_bpf__attach(skel);
>  	if (err) {
>  		pr_err("Failed to attach off-cpu BPF skeleton\n");
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index d877a0a9731f..cca1b6990a57 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -96,6 +96,8 @@ const volatile bool uses_cgroup_v1 = false;
>  
>  int perf_subsys_id = -1;
>  
> +__u64 sample_id, sample_type, offcpu_thresh;
> +
>  /*
>   * Old kernel used to call it task_struct->state and now it's '__state'.
>   * Use BPF CO-RE "ignored suffix rule" to deal with it like below:
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
> 2.45.2
> 
