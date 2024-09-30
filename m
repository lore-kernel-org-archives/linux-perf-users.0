Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272D15532E;
	Mon, 30 Sep 2024 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678371; cv=none; b=g2xhriYPvTTSYWjVPwt+zSAnn8EEZmBbe7G+LLo+XMhqusT07gF++tjS60dvFKMNtR5U03Y3oniLpTUN0G/6d8OGlmoqiwQ0lk2GnXTzzlsQ1d0UhTDX0fRa0aSGhObBd+RRdxAsFpv/T8BIg7ye3BX0XH3LVfOQ1RlKICfIaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678371; c=relaxed/simple;
	bh=fiemyF/hfAE5dZX6DgxcWS8/IybMpnKKxC2VhkzqA88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUQl0QTSBQ4wE2HC1nQ88tdBQxpH5nDYOybx6bKLJPi9oqAJcbH04wYcb3ZEkryZHkQdnpWQnmU4Xo9goRxM4EzykIqbe2TRq+lAG2DZ8SCXLdDoxd1Qpm8cyHwqDgDS3MmkfKj4XTOkJbI+36ez4Q5CmITmlZEjBzAv7ekI6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIbzbPtp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIbzbPtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7493C4CECE;
	Mon, 30 Sep 2024 06:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727678371;
	bh=fiemyF/hfAE5dZX6DgxcWS8/IybMpnKKxC2VhkzqA88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIbzbPtpbnHyYbN1X26on0PORp/CgpSUUWyW07cVJkanBwSKq34yHPexa21+b4Ksl
	 r36EUY0TKYuxG3ODYy4obi0l5MNdA2KeTsilq2mPbMN24yqPjq64Qih9usGpGdYcAN
	 muOgD2aA+P6Ko1orSPOlBecWm8+cbMNHhLcFiJaJcVpR9YtdillhZZx9Xy+Oi6JBO0
	 huTohGYc5SjKSh4nCvzkiyUcMCNVK+xxxPGxcjyF8e0dUI2RLQQ4GGP8Lmm+Mdi/Q3
	 qETZqtT4HUW4pHS/1iYr6fli64U+0AxAmLQVayBMP9q+VyEnmSHHEuw/0X1l+zAT57
	 BDjGLdX+gB6Pw==
Date: Sun, 29 Sep 2024 23:39:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/8] perf record --off-cpu: Dump total off-cpu time at
 the end.
Message-ID: <ZvpHocNuQRBehUWp@google.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
 <20240927202736.767941-6-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927202736.767941-6-howardchu95@gmail.com>

On Fri, Sep 27, 2024 at 01:27:33PM -0700, Howard Chu wrote:
> By setting a placeholder sample_type and then writing real data into
> raw_data, we mimic the direct sample method to write data at the end.
> 
> Note that some data serve only as placeholders and will be overwritten
> by the data in raw_data. Additionally, since the IP will be updated in
> evsel__parse_sample(), there is no need to handle it in off_cpu_write().
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_off_cpu.c | 116 +++++++++++++++++++++-------------
>  1 file changed, 72 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index f7233a09ec77..2a1cfd7e0b09 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -138,12 +138,19 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>  	int ncpus = 1, ntasks = 1, ncgrps = 1;
>  	struct strlist *pid_slist = NULL;
>  	struct str_node *pos;
> +	struct evsel *evsel;
>  
>  	if (off_cpu_config(evlist) < 0) {
>  		pr_err("Failed to config off-cpu BPF event\n");
>  		return -1;
>  	}
>  
> +	evsel = evlist__find_evsel_by_str(evlist, OFFCPU_EVENT);
> +	if (evsel == NULL) {
> +		pr_err("%s evsel not found\n", OFFCPU_EVENT);
> +		return -1 ;
> +	}
> +
>  	skel = off_cpu_bpf__open();
>  	if (!skel) {
>  		pr_err("Failed to open off-cpu BPF skeleton\n");
> @@ -259,7 +266,6 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>  	}
>  
>  	if (evlist__first(evlist)->cgrp) {
> -		struct evsel *evsel;
>  		u8 val = 1;
>  
>  		fd = bpf_map__fd(skel->maps.cgroup_filter);
> @@ -280,6 +286,7 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
>  		}
>  	}
>  
> +	skel->bss->sample_type   = OFFCPU_EMBEDDED_SAMPLE_TYPES;

Hmm.. you set the sample_type unconditionally which means the embedded
data in the raw area has the fixed format.  Then I think you don't need
the sample_type variable at all.


>  	skel->bss->offcpu_thresh = opts->off_cpu_thresh * 1000;
>  
>  	err = off_cpu_bpf__attach(skel);
> @@ -305,7 +312,8 @@ int off_cpu_write(struct perf_session *session)
>  {
>  	int bytes = 0, size;
>  	int fd, stack;
> -	u64 sample_type, val, sid = 0;
> +	u32 raw_size;
> +	u64 sample_type_off_cpu, sample_type_bpf_output, val, sid = 0, tstamp = OFF_CPU_TIMESTAMP;
>  	struct evsel *evsel;
>  	struct perf_data_file *file = &session->data->file;
>  	struct off_cpu_key prev, key;
> @@ -315,7 +323,6 @@ int off_cpu_write(struct perf_session *session)
>  			.misc = PERF_RECORD_MISC_USER,
>  		},
>  	};
> -	u64 tstamp = OFF_CPU_TIMESTAMP;
>  
>  	skel->bss->enabled = 0;
>  
> @@ -325,15 +332,10 @@ int off_cpu_write(struct perf_session *session)
>  		return 0;
>  	}
>  
> -	sample_type = evsel->core.attr.sample_type;
> -
> -	if (sample_type & ~OFFCPU_SAMPLE_TYPES) {
> -		pr_err("not supported sample type: %llx\n",
> -		       (unsigned long long)sample_type);
> -		return -1;
> -	}
> +	sample_type_off_cpu    = OFFCPU_EMBEDDED_SAMPLE_TYPES;
> +	sample_type_bpf_output = evsel->core.attr.sample_type;
>  
> -	if (sample_type & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
> +	if (sample_type_bpf_output & (PERF_SAMPLE_ID | PERF_SAMPLE_IDENTIFIER)) {
>  		if (evsel->core.id)
>  			sid = evsel->core.id[0];
>  	}
> @@ -344,49 +346,75 @@ int off_cpu_write(struct perf_session *session)
>  
>  	while (!bpf_map_get_next_key(fd, &prev, &key)) {
>  		int n = 1;  /* start from perf_event_header */
> -		int ip_pos = -1;
> +		int i = 0; /* raw data index */
>  
>  		bpf_map_lookup_elem(fd, &key, &val);
>  
> -		if (sample_type & PERF_SAMPLE_IDENTIFIER)
> +		/*
> +		 * Zero-fill some of these fields first, they will be overwritten by the dummy
> +		 * embedded data (in raw_data) below, when parsing the samples. And because embedded
> +		 * data is in BPF output, perf script -F without bpf-output field will not work
> +		 * properly.
> +		 */
> +		if (sample_type_bpf_output & PERF_SAMPLE_IDENTIFIER)
>  			data.array[n++] = sid;
> -		if (sample_type & PERF_SAMPLE_IP) {
> -			ip_pos = n;
> -			data.array[n++] = 0;  /* will be updated */
> -		}
> -		if (sample_type & PERF_SAMPLE_TID)
> -			data.array[n++] = (u64)key.pid << 32 | key.tgid;
> -		if (sample_type & PERF_SAMPLE_TIME)
> -			data.array[n++] = tstamp;
> -		if (sample_type & PERF_SAMPLE_ID)
> -			data.array[n++] = sid;
> -		if (sample_type & PERF_SAMPLE_CPU)
> +		if (sample_type_bpf_output & PERF_SAMPLE_IP)
>  			data.array[n++] = 0;
> -		if (sample_type & PERF_SAMPLE_PERIOD)
> -			data.array[n++] = val;
> -		if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> -			int len = 0;
> -
> -			/* data.array[n] is callchain->nr (updated later) */
> -			data.array[n + 1] = PERF_CONTEXT_USER;
> -			data.array[n + 2] = 0;
> +		if (sample_type_bpf_output & PERF_SAMPLE_TID)
> +			data.array[n++] = 0;

I'm not sure if it works correctly.  You haven't set the callchain
length and 'n' is not updated.

> +		if (sample_type_bpf_output & PERF_SAMPLE_TIME)
> +			data.array[n++] = tstamp; /* we won't overwrite time */
> +		if (sample_type_bpf_output & PERF_SAMPLE_CPU)
> +			data.array[n++] = 0;
> +		if (sample_type_bpf_output & PERF_SAMPLE_PERIOD)
> +			data.array[n++] = 0;
> +		if (sample_type_bpf_output & PERF_SAMPLE_RAW) {
> +			/*
> +			 * the format of raw data is as follows:
> +			 *
> +			 *  [ size ][ data ]
> +			 *  [     data     ]
> +			 *  [     data     ]
> +			 *  [     data     ]
> +			 *  [ data ][ empty]
> +			 *
> +			 */
> +			if (sample_type_off_cpu & PERF_SAMPLE_TID)

As I said, you can get rid of the sample_type_off_cpu check if it's
always true.

Thanks,
Namhyung


> +				off_cpu_raw_data[i++] = (u64)key.pid << 32 | key.tgid;
> +			if (sample_type_off_cpu & PERF_SAMPLE_PERIOD)
> +				off_cpu_raw_data[i++] = val;
> +			if (sample_type_off_cpu & PERF_SAMPLE_CALLCHAIN) {
> +				int len = 0;
> +
> +				/* off_cpu_raw_data[n] is callchain->nr (updated later) */
> +				off_cpu_raw_data[i + 1] = PERF_CONTEXT_USER;
> +				off_cpu_raw_data[i + 2] = 0;
> +
> +				bpf_map_lookup_elem(stack, &key.stack_id, &off_cpu_raw_data[i + 2]);
> +				while (off_cpu_raw_data[i + 2 + len])
> +					len++;
> +
> +				/* update length of callchain */
> +				off_cpu_raw_data[i] = len + 1;
> +
> +				/* calculate sample callchain off_cpu_raw_data length */
> +				i += len + 2;
> +			}
> +			if (sample_type_off_cpu & PERF_SAMPLE_CGROUP)
> +				off_cpu_raw_data[i++] = key.cgroup_id;
>  
> -			bpf_map_lookup_elem(stack, &key.stack_id, &data.array[n + 2]);
> -			while (data.array[n + 2 + len])
> -				len++;
> +			raw_size = i * sizeof(u64) + sizeof(u32); /* 4 empty bytes for alignment */
>  
> -			/* update length of callchain */
> -			data.array[n] = len + 1;
> +			/* raw_size */
> +			memcpy((void *)data.array + n * sizeof(u64), &raw_size, sizeof(raw_size));
>  
> -			/* update sample ip with the first callchain entry */
> -			if (ip_pos >= 0)
> -				data.array[ip_pos] = data.array[n + 2];
> +			/* raw_data */
> +			memcpy((void *)data.array + n * sizeof(u64) + sizeof(u32), off_cpu_raw_data, i * sizeof(u64));
>  
> -			/* calculate sample callchain data array length */
> -			n += len + 2;
> +			n += i + 1;
>  		}
> -		if (sample_type & PERF_SAMPLE_CGROUP)
> -			data.array[n++] = key.cgroup_id;
> +		if (sample_type_bpf_output & PERF_SAMPLE_CGROUP)
> +			data.array[n++] = 0;
>  
>  		size = n * sizeof(u64);
>  		data.hdr.size = size;
> -- 
> 2.43.0
> 
