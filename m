Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F613FD72;
	Thu, 12 Dec 2024 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037415; cv=none; b=akcoiFrLQaTZuIsdfBBqEudiSg1iJmMOJ40/issl3j2edh79qLo3r0s3g0qw2v4rBiV9PSWs6KlzcL+2iJClqATZJpeaUW29oLjAQiX7a3XUalhqF81iQVF5VkbEwzeNozZBmie38f21UcTOCXOSkFSjrNLRx+zZYYYZlaq31D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037415; c=relaxed/simple;
	bh=RncyA5wIcNFTU3uBJEU/wdJvFZiGq9Ga1iSEqfbdaJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAR9TcQOfuIY3SudIIozLU0nUhqDB2MLokV+eIQoMxloR8ibzpDmp0Ft/WoUFPtnd9BPpgeqAe0YnTSNmvEjQzgzSdTYvjPmj/z/PxIGOcLQ11JMcaCttQPQwhuSvMfZliauaP3DXjrZoOKvvj4tTLa1zCLGPZavBWj2grLO4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9RjlnDm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9RjlnDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D23C4CECE;
	Thu, 12 Dec 2024 21:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734037414;
	bh=RncyA5wIcNFTU3uBJEU/wdJvFZiGq9Ga1iSEqfbdaJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9RjlnDmYma+jBnGTweFkRAPRLNZC0LLAVLfIoY1mOSn6t3Nx3bZM/U5OGTkcEI6l
	 cmdbVO7TBg6Y2F2qSXezQDVbmv9fLRughpK/ppNqdOBJWq9Qzpn3ZqzMnkLEXOGEOj
	 t6ENxpqV3t0y3ixcZSh+Nyxenc2Jw/Nz3Orl2m5CvoSPOnaT1ipBdO2b3H2JrW60r3
	 LzX5vqNhEtzMCY7POt/TxEnsambWx3UsLYZQvI1457FD2AtLetjJJPGZ4qlYGdnj7d
	 BHau5WL1XwMEOR0tNrEs1TU4Z1yn/VpUme3Cn1pUMqFaE+leCKJmOPoaAiVryYKmg/
	 P6BQPn0xgeVCg==
Date: Thu, 12 Dec 2024 13:03:33 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v12 04/10] perf record --off-cpu: Dump off-cpu samples in
 BPF
Message-ID: <Z1tPpZ7HHaF8g4PQ@google.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
 <20241212022420.1035999-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212022420.1035999-5-howardchu95@gmail.com>

Hello,

On Wed, Dec 11, 2024 at 06:24:14PM -0800, Howard Chu wrote:
> Collect tid, period, callchain, and cgroup id and dump them when off-cpu
> time threshold is reached.
> 
> We don't collect the off-cpu time twice (the delta), it's either in
> direct samples, or accumulated samples that are dumped at the end of
> perf.data.
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20241108204137.2444151-6-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 86 ++++++++++++++++++++++++--
>  1 file changed, 81 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index c87132e01eb3..aae63d999abb 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -19,11 +19,17 @@
>  #define MAX_ENTRIES  102400
>  
>  #define MAX_CPUS  4096
> +#define MAX_OFFCPU_LEN 37
> +
> +struct stack {
> +	u64 array[MAX_STACKS];
> +};
>  
>  struct tstamp_data {
>  	__u32 stack_id;
>  	__u32 state;
>  	__u64 timestamp;
> +	struct stack stack;
>  };
>  
>  struct offcpu_key {
> @@ -41,6 +47,10 @@ struct {
>  	__uint(max_entries, MAX_ENTRIES);
>  } stacks SEC(".maps");
>  
> +struct offcpu_data {
> +	u64 array[MAX_OFFCPU_LEN];
> +};
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>  	__uint(key_size, sizeof(__u32));
> @@ -48,6 +58,13 @@ struct {
>  	__uint(max_entries, MAX_CPUS);
>  } offcpu_output SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct offcpu_data));
> +	__uint(max_entries, 1);
> +} offcpu_payload SEC(".maps");
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>  	__uint(map_flags, BPF_F_NO_PREALLOC);
> @@ -194,6 +211,47 @@ static inline int can_record(struct task_struct *t, int state)
>  	return 1;
>  }
>  
> +static inline int copy_stack(struct stack *from, struct offcpu_data *to, int n)
> +{
> +	int len = 0;
> +
> +	for (int i = 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
> +		to->array[n + 2 + i] = from->array[i];
> +
> +	return len;
> +}
> +
> +/**
> + * off_cpu_dump - dump off-cpu samples to ring buffer
> + * @data: payload for dumping off-cpu samples
> + * @key: off-cpu data
> + * @stack: stack trace of the task before being scheduled out
> + *
> + * If the threshold of off-cpu time is reached, acquire tid, period, callchain, and cgroup id
> + * information of the task, and dump it as a raw sample to perf ring buffer
> + */
> +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *key,
> +			struct stack *stack, __u64 delta)
> +{
> +	int n = 0, len = 0;
> +
> +	data->array[n++] = (u64)key->tgid << 32 | key->pid;
> +	data->array[n++] = delta;
> +
> +	/* data->array[n] is callchain->nr (updated later) */
> +	data->array[n + 1] = PERF_CONTEXT_USER;
> +	data->array[n + 2] = 0;
> +	len = copy_stack(stack, data, n);
> +
> +	/* update length of callchain */
> +	data->array[n] = len + 1;
> +	n += len + 2;
> +
> +	data->array[n++] = key->cgroup_id;
> +
> +	return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_CPU, data, n * sizeof(u64));
> +}
> +
>  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  			struct task_struct *next, int state)
>  {
> @@ -218,6 +276,16 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  	pelem->state = state;
>  	pelem->stack_id = stack_id;
>  
> +	/*
> +	 * If stacks are successfully collected by bpf_get_stackid(), collect them once more
> +	 * in task_storage for direct off-cpu sample dumping
> +	 */
> +	if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS * sizeof(u64), BPF_F_USER_STACK)) {
> +		/*
> +		 * This empty if block is used to avoid 'result unused warning' from bpf_get_stack().
> +		 * If the collection fails, continue with the logic for the next task.
> +		 */
> +	}
>  next:
>  	pelem = bpf_task_storage_get(&tstamp, next, NULL, 0);
>  
> @@ -232,11 +300,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  		__u64 delta = ts - pelem->timestamp;
>  		__u64 *total;
>  
> -		total = bpf_map_lookup_elem(&off_cpu, &key);
> -		if (total)
> -			*total += delta;
> -		else
> -			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
> +		if (delta >= offcpu_thresh_ns) {

It seems offcpu_thresh_ns is not defined at this moment.  You can use
a hard-coded value with a comment for now.

Thanks,
Namhyung


> +			int zero = 0;
> +			struct offcpu_data *data = bpf_map_lookup_elem(&offcpu_payload, &zero);
> +
> +			if (data)
> +				off_cpu_dump(ctx, data, &key, &pelem->stack, delta);
> +		} else {
> +			total = bpf_map_lookup_elem(&off_cpu, &key);
> +			if (total)
> +				*total += delta;
> +			else
> +				bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
> +		}
>  
>  		/* prevent to reuse the timestamp later */
>  		pelem->timestamp = 0;
> -- 
> 2.43.0
> 
