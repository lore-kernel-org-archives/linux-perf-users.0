Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F9E509EFF;
	Tue,  8 Sep 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884499; cv=none; b=Y/EmkDulupa0bu5fmi/YXFAQJMzFHf4r/i26STAH9VTeEINUe9FbzrehG9rAh7GcSce/liesPCg8EDNy+mwfdd+fOrVIC40bUTx2J3mDcq970ISZxWQueIY7MexKxHLaqII/fCMbDz9SH/9k5+WYm+BB9pxxuPniho6nAQ5x20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884499; c=relaxed/simple;
	bh=cbspiTySU5Xc95mjeQSCvVssdm/bSRaYCfNFTKfjdYU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NpO9hE4CTeEokQvFqqxEgtKu4zKRv5/DHlrq3Srd7nozqDVgcatewwUQpY0G4i6Rr8B50wQyVeKNYuKDf1mdyKXwP52jAO/RtQ9FknuXmric4fRf9HiWAClYg62IQXpHGHGhgI4Uguw+p0N49IZmwyWejLVkJ1kJYxe6s/jX5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdUktEPx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdUktEPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6D51F00A3A;
	Tue,  8 Sep 2026 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884497;
	bh=2w7k6CxIZ0/f62QNJxuvis/V6V01ScAJQNFLe+Mfr10=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FdUktEPxfq5YmrtjUnCxeGXDGOHegRgwQxBH/u8EdmZ0tzPGqvSdIKnjfYE7Z9LhT
	 LUYsnzVU9KcIka//w8KqwcCcJXLaT+LMl6TiRDt9Vhp+FpUGGTPg/A4RyjaFMSO1ru
	 E1fk67WKD+Ue1bJHqm1+AHx0Q+tnV5O+mHxJ7JAD1JpSZP53RwCnBgPtWGk5Iv10cl
	 AuZ24rc5sfdFRAn0HfjpIXH7u+SOW6nU3Z/T1ecN6/jK5nG4xdNiyEKXHFVBgp3Pli
	 yWEM6RJ8GPiqBxqtskFJ3hd1Hk9sXvaWPzkcQlM9Kof8A+p1ByqHApzQv1PVbiHALE
	 ax71iAbrz5e+w==
Content-Type: multipart/mixed; boundary="===============6594401824819144872=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cc417e4dba25ded6b33afcdfa4cd4a69de3e9c8ab7ca351c131ae92bc7430d86@mail.kernel.org>
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Scale counters and report cycles per run
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,qmo@kernel.org,linux-perf-users@vger.kernel.org,acme@kernel.org,namhyung@kernel.org
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  8 Sep 2026 16:21:36 +0000 (UTC)

--===============6594401824819144872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 8c2f9255b36d..9e126f3823ad 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c

[ ... ]

> @@ -2182,9 +2199,39 @@ static int profile_parse_metrics(int argc, char **argv)
>  	return selected_cnt;
>  }
>
> +/*
> + * Filter out CPUs that have any selected metric not scheduled for them. This makes sure all
> + * metrics are using the same CPU set, as a result ratio metrics are consistent.
> + */
> +static void profile_filter_cpus(__u32 num_cpu,
> +				struct bpf_perf_event_value vals[MAX_NUM_PROFILE_METRICS][num_cpu],
> +				__u64 *counts)
> +{
> +	__u32 m, cpu, key = 0;
> +
> +	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
> +		if (!metrics[m].selected)
> +			continue;
> +
> +		for (cpu = 0; cpu < num_cpu; cpu++) {
> +			/*
> +			 * CPU has hits, but this metric never scheduled, set counts[cpu] to 0
> +			 * so other metrics ignore this CPU too
> +			 */
> +			if (counts[cpu] && !vals[key][cpu].running) {
> +				p_info("%s not scheduled on CPU %u; excluding %llu runs from all metrics",
> +				       metrics[m].name, cpu, counts[cpu]);
> +				counts[cpu] = 0;
> +			}
> +		}
> +		key++;
> +	}
> +}

[ ... ]

> @@ -2194,38 +2241,61 @@ static void profile_read_values(struct profiler_bpf *obj)
>  	count_map_fd = bpf_map__fd(obj->maps.counts);
>  	if (reading_map_fd < 0 || count_map_fd < 0) {
>  		p_err("failed to get fd for map");
> -		return;
> +		return min(reading_map_fd, count_map_fd);
>  	}
>
>  	err = bpf_map_lookup_elem(count_map_fd, &key, counts);
>  	if (err) {
>  		p_err("failed to read count_map: %s", strerror(errno));
> -		return;
> +		return err;
> +	}
> +
> +	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
> +		if (!metrics[m].selected)
> +			continue;
> +
> +		err = bpf_map_lookup_elem(reading_map_fd, &key, values[key]);
> +		if (err) {
> +			p_err("failed to read reading_map: %s", strerror(errno));
> +			return err;
> +		}
> +		key++;
>  	}
>
>  	profile_total_count = 0;
>  	for (cpu = 0; cpu < num_cpu; cpu++)
>  		profile_total_count += counts[cpu];
>
> +	profile_filter_cpus(num_cpu, values, counts);
> +
> +	profile_valid_count = 0;
> +	for (cpu = 0; cpu < num_cpu; cpu++)
> +		profile_valid_count += counts[cpu];
> +
> +	key = 0;
>  	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
> -		struct bpf_perf_event_value values[num_cpu];
> +		double scale;
>
>  		if (!metrics[m].selected)
>  			continue;
>
> -		err = bpf_map_lookup_elem(reading_map_fd, &key, values);
> -		if (err) {
> -			p_err("failed to read reading_map: %s",
> -			      strerror(errno));
> -			return;
> -		}
>  		for (cpu = 0; cpu < num_cpu; cpu++) {
> -			metrics[m].val.counter += values[cpu].counter;
> -			metrics[m].val.enabled += values[cpu].enabled;
> -			metrics[m].val.running += values[cpu].running;
> +			/* Skip CPUs with no runs or with an unscheduled metric. */
> +			if (!counts[cpu])
> +				continue;
> +
> +			val = &values[key][cpu];
> +
> +			metrics[m].val.enabled += val->enabled;
> +			metrics[m].val.running += val->running;
> +			metrics[m].val.counter += val->counter;
> +			/* Scale counter values to account for perf event multiplexing. */
> +			scale = (double)val->enabled / val->running;
> +			metrics[m].scaled_val += val->counter * scale;
>  		}
>  		key++;
>  	}
> +	return 0;
>  }

Does this correctly handle the case where one metric is never scheduled
on any CPU?

The CPU-set filter in profile_filter_cpus() zeroes counts[cpu] for every
CPU where any selected metric has running == 0:

    if (counts[cpu] && !vals[key][cpu].running) {
        p_info("%s not scheduled on CPU %u; ...");
        counts[cpu] = 0;
    }

The aggregation loop then skips those CPUs for all metrics:

    for (cpu = 0; cpu < num_cpu; cpu++) {
        if (!counts[cpu])
            continue;
        ...
        metrics[m].val.counter += val->counter;
        ...
        metrics[m].scaled_val += val->counter * scale;
    }

If a selected metric is never scheduled on any CPU (the scenario this
series targets - commit 44f919dd1fbc describes profiling iTLB misses on
a long-running program with a full PMU), then every CPU with counts[cpu]
!= 0 gets zeroed.

For example, `bpftool prog profile <prog> cycles itlb_misses`:

  * profile_valid_count becomes 0
  * cycles' val.counter and scaled_val stay 0 even though the cycles
    event was measured correctly on every CPU
  * plain output prints "run_cnt 51397" followed by "0 cycles" and
    "0 itlb_misses" with no ratio column

Before this patch the same run reported the real cycles count and 0 for
itlb_misses, so the healthy metric's data is lost.

In JSON mode there is no diagnostic at all. The p_info() call in
profile_filter_cpus() returns immediately when json_output is set, so
a consumer sees run_cnt=51397 with value=0, value_scaled=0, enabled=0,
running=0, and only run_cnt_valid=0 as a hint.

The commit message scopes the change to ratios ("Use the same CPU set
for derived ratios"), and the .rst says "all metric values exclude that
CPU so that ratios use a consistent CPU set" but neither documents that
a single unscheduled metric collapses the whole report to zeros, and
JSON gives no warning.

Would it make sense to exclude only the affected metric, or keep the raw
per-metric aggregation intact and restrict only the ratio denominators?

> @@ -2250,24 +2322,34 @@ static void profile_print_readings_json(void)
>
>  static void profile_print_readings_plain(void)
>  {
> -	__u32 m;
> +	__u32 i;
>
>  	printf("\n%18llu %-20s\n", profile_total_count, "run_cnt");
> -	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
> -		struct bpf_perf_event_value *val = &metrics[m].val;
> +	for (i = 0; i < ARRAY_SIZE(metrics); i++) {
> +		struct profile_metric *m = &metrics[i];
> +		struct bpf_perf_event_value *val = &m->val;
>  		int r;
> +		__u64 ratio;
>
> -		if (!metrics[m].selected)
> +		if (!m->selected)
>  			continue;
> -		printf("%18llu %-20s", val->counter, metrics[m].name);
> +		printf("%18llu %-20s", m->scaled_val, m->name);
>
> -		r = metrics[m].ratio_metric - 1;
> -		if (r >= 0 && metrics[r].selected &&
> -		    metrics[r].val.counter > 0) {
> +		r = m->ratio_metric;
> +		switch (r) {
> +		case METRIC_RUN_CNT:
> +			ratio = profile_valid_count;
> +			break;
> +		case METRIC_NONE:
> +			ratio = 0;
> +			break;
> +		default:
> +			ratio = metrics[r].scaled_val;
> +		}
> +		if (ratio) {
>  			printf("# %8.2f %-30s",
> -			       val->counter * metrics[m].ratio_mul /
> -			       metrics[r].val.counter,
> -			       metrics[m].ratio_desc);
> +			       m->scaled_val * m->ratio_mul / ratio,
> +			       m->ratio_desc);
>  		} else {
>  			printf("%-41s", "");
>  		}

Plain output prints profile_total_count as "run_cnt" but the new "cycles
per run" column divides by profile_valid_count, and profile_valid_count
is never printed in plain mode (it is only exposed as the JSON
run_cnt_valid field).

Whenever profile_filter_cpus() excludes at least one CPU the two differ,
so the displayed numbers cannot be reconciled. The user sees run_cnt and
a scaled cycles value, and "# <x> cycles per run" where
x != cycles/run_cnt, with no way to see the denominator that was
actually used.

The only signal is the p_info() lines on stderr, which are easy to miss
when stdout is redirected and are suppressed entirely under --json.

Would it make sense to print the valid run count in plain mode (as JSON
now does) or label the ratio with the CPU set it was computed over?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34246064212
--===============6594401824819144872==--
