Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947EB71747;
	Mon, 30 Sep 2024 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727677434; cv=none; b=i5y/rqm+Siw9z/515XU4UcfOh/CijvIH+i0Tnuz8RKhCSoCAPPcohC6vM6auTssQRPsqBRWvD8qKkL+pbeyCYEvT88ys8ubZ0/cEKJpsF3DTDO5BgyOXTvFAAT7hHzMQD1o4B0L5qEvmKNESgz5XMpCyZQBkhh1Awkp7JGkwrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727677434; c=relaxed/simple;
	bh=HepOIOMCDgsvZHZcKlC0KyGiSdabdUGtmcbqQPcBFS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+WlHKx4JKNJYoP4X5yV24Ewm1ZtEkkB45xKJjEzkMep8iEu8UKvXELVq6w1yMSH8U48r5mVhfIVsqgoENqt92Z9InVe2PpVlu4R+3Y5XGRZ7Or5PmvDMo9+GNhMcbFDDo1m0VvYv40s0xdqxJLdjk0kR6pbWHa/Q3YVQk13Fu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhwIfoHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhwIfoHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A18AC4CECE;
	Mon, 30 Sep 2024 06:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727677434;
	bh=HepOIOMCDgsvZHZcKlC0KyGiSdabdUGtmcbqQPcBFS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhwIfoHG3FRI1yyFqpH3B9Y1r3dnAmKH2u75fE0TNLpbX9zLJiFaAiEauhdF07kQy
	 TkG65COpbIaY0KXMUbyhoU4DXjfIAyLLsC/sDKsPTtfnvoSvee9mWB3t+X3g0+fopS
	 HqRSgFo1wqrDRWHn111XYj5hvHcBoEjYrD5mOUsZn173SU3oY1Qzd5iPTvRRGXgC36
	 9GIJ5MfVStshkSSv0hquwv7iHfTMp5NvpfR+tqdEoi8K3gJ4PBrJDMLGxCCz5D8QZH
	 zjMHxuWexkPZHrrkNAmim6msoK3ktcVD1E0UF606Mst9y36EIuaOmkRyOobBsB8NQQ
	 qzD4yIC4FsFLw==
Date: Sun, 29 Sep 2024 23:23:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] perf record off-cpu: Dump direct off-cpu samples
 in BPF
Message-ID: <ZvpD-PiP0wKdBL0C@google.com>
References: <20240927202736.767941-1-howardchu95@gmail.com>
 <20240927202736.767941-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927202736.767941-5-howardchu95@gmail.com>

On Fri, Sep 27, 2024 at 01:27:32PM -0700, Howard Chu wrote:
> Add perf_event_array map for dumping direct off-cpu samples, but keep
> the at-the-end approach.
> 
> Tons of checking before access, to pass the BPF verifier.
> 
> If off-cpu time (represented as delta) exceeds the off-cpu threshold, do
> output.
> 
> Output PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD, PERF_SAMPLE_CALLCHAIN, and
> PERF_SAMPLE_CGROUP in bpf_perf_event_output().
> 
> Ideally, we should only output
> PERF_SAMPLE_PERIOD (off-cpu time) and PERF_SAMPLE_CALLCHAIN (sched_in
> process's callchain). One only needs to set PERF_SAMPLE_TID and
> PERF_SAMPLE_CGROUP, and perf_event will do everything for us.
> 
> But in reality, that's not the case. Setting PERF_SAMPLE_TID will mostly
> give us TID of 0. We might get the correct TID for offcpu-time event
> from time to time, but it is really rare.
>          swapper       0 [000] offcpu-time:  /
>         :1321819 1321819 [002] offcpu-time:  /user.slice/user-1000.slice/session-2.scope
>          swapper       0 [001] offcpu-time:  /
>          swapper       0 [003] offcpu-time:  /
> 
> And setting PERF_SAMPLE_CGROUP doesn't work properly either.
>     tmux: server    3701 [003] offcpu-time:  /
>     blueman-tray    1064 [001] offcpu-time:  /
>             bash 1350867 [001] offcpu-time:  /
>             bash 1350844 [000] offcpu-time:  /
> 
> We need to retrieve PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD,
> PERF_SAMPLE_CALLCHAIN, and PERF_SAMPLE_CGROUP using BPF and output these
> four fields.
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 112 +++++++++++++++++++++++++
>  tools/perf/util/off_cpu.h              |   8 +-
>  2 files changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index e2a887228fd9..c42d0e2d91d8 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -19,6 +19,7 @@
>  #define MAX_ENTRIES  102400
>  
>  #define MAX_CPUS  4096
> +#define MAX_OFFCPU_LEN 128

I guess it's too big as you only collect stack and a few more data.

>  
>  struct tstamp_data {
>  	__u32 stack_id;
> @@ -34,6 +35,7 @@ struct offcpu_key {
>  	__u64 cgroup_id;
>  };
>  
> +/* for dumping at the end */
>  struct {
>  	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
>  	__uint(key_size, sizeof(__u32));
> @@ -41,6 +43,14 @@ struct {
>  	__uint(max_entries, MAX_ENTRIES);
>  } stacks SEC(".maps");
>  
> +struct offcpu_data {
> +	u64 array[MAX_OFFCPU_LEN];
> +};
> +
> +struct stack_data {
> +	u64 array[MAX_STACKS];
> +};
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>  	__uint(key_size, sizeof(__u32));
> @@ -48,6 +58,22 @@ struct {
>  	__uint(max_entries, MAX_CPUS);
>  } offcpu_output SEC(".maps");
>  
> +/* temporary offcpu sample */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct offcpu_data));
> +	__uint(max_entries, 1);
> +} offcpu_payload SEC(".maps");
> +
> +/* cached stack per task storage */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct stack_data);
> +} stack_cache SEC(".maps");
> +
>  struct {
>  	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>  	__uint(map_flags, BPF_F_NO_PREALLOC);
> @@ -194,12 +220,75 @@ static inline int can_record(struct task_struct *t, int state)
>  	return 1;
>  }
>  
> +static inline bool check_bounds(int index)
> +{
> +	if (index < 0 || index >= MAX_OFFCPU_LEN)
> +		return false;
> +
> +	return true;
> +}

Likewise, we may get rid of the bound check entirely as it's always
guaranteed.

> +
> +static inline int copy_stack(struct stack_data *from,
> +			     struct offcpu_data *to, int n)
> +{
> +	int max_stacks = MAX_STACKS, len = 0;
> +
> +	if (!from)
> +		return len;
> +
> +	for (int i = 0; i < max_stacks && from->array[i]; ++i) {
> +		if (check_bounds(n + 2 + i)) {
> +			to->array[n + 2 + i] = from->array[i];
> +			++len;
> +		}
> +	}
> +	return len;
> +}
> +
> +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *key,
> +			struct stack_data *stack_p, __u64 delta, __u64 timestamp)
> +{
> +	int size, n = 0, ip_pos = -1, len = 0;
> +
> +	if (sample_type & PERF_SAMPLE_TID && check_bounds(n))

You didn't set the sample_type yet.  Is it intentional?


> +		data->array[n++] = (u64)key->tgid << 32 | key->pid;
> +	if (sample_type & PERF_SAMPLE_PERIOD && check_bounds(n))
> +		data->array[n++] = delta;
> +	if (sample_type & PERF_SAMPLE_CALLCHAIN && check_bounds(n + 2)) {
> +		/* data->array[n] is callchain->nr (updated later) */
> +		data->array[n + 1] = PERF_CONTEXT_USER;
> +		data->array[n + 2] = 0;
> +
> +		len = copy_stack(stack_p, data, n);
> +
> +		/* update length of callchain */
> +		data->array[n] = len + 1;
> +
> +		/* update sample ip with the first callchain entry */
> +		if (ip_pos >= 0)

You don't set the ip_pos, just remove this part and let userspace handle
it later.


> +			data->array[ip_pos] = data->array[n + 2];
> +
> +		/* calculate sample callchain data->array length */
> +		n += len + 2;
> +	}
> +	if (sample_type & PERF_SAMPLE_CGROUP && check_bounds(n))
> +		data->array[n++] = key->cgroup_id;
> +
> +	size = n * sizeof(u64);
> +	if (size >= 0 && size <= MAX_OFFCPU_LEN * sizeof(u64))
> +		bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_CPU, data, size);
> +
> +	return 0;
> +}
> +
>  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  			struct task_struct *next, int state)
>  {
>  	__u64 ts;
>  	__u32 stack_id;
>  	struct tstamp_data *pelem;
> +	struct stack_data *stack_p;
> +	int zero = 0;
>  
>  	ts = bpf_ktime_get_ns();
>  
> @@ -209,6 +298,21 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  	stack_id = bpf_get_stackid(ctx, &stacks,
>  				   BPF_F_FAST_STACK_CMP | BPF_F_USER_STACK);
>  
> +	/*
> +	 * if stacks are successfully collected, cache them to task_storage, they are then
> +	 * dumped if the off-cpu time hits the threshold.
> +	 */
> +	if (stack_id > 0) {
> +		stack_p = bpf_task_storage_get(&stack_cache, prev, NULL,
> +					       BPF_LOCAL_STORAGE_GET_F_CREATE);

Can you just add a new field in the tstamp map instead?


> +		if (stack_p) {
> +			/* to pass the clang result unused warning */
> +			int __attribute__((unused)) len;
> +			len = bpf_get_stack(ctx, stack_p->array, MAX_STACKS * sizeof(u64),
> +					    BPF_F_USER_STACK) / sizeof(u64);

I think you can move to the next task if it failed to get the stack
trace.


> +		}
> +	}
> +
>  	pelem = bpf_task_storage_get(&tstamp, prev, NULL,
>  				     BPF_LOCAL_STORAGE_GET_F_CREATE);
>  	if (!pelem)
> @@ -238,6 +342,14 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  		else
>  			bpf_map_update_elem(&off_cpu, &key, &delta, BPF_ANY);
>  
> +		if (delta >= offcpu_thresh) {
> +			struct offcpu_data *data = bpf_map_lookup_elem(&offcpu_payload, &zero);
> +
> +			stack_p = bpf_task_storage_get(&stack_cache, next, NULL, 0);
> +			if (data && stack_p)
> +				off_cpu_dump(ctx, data, &key, stack_p, delta, pelem->timestamp);
> +		}

I think you should either dump the data directly or save it in the
off_cpu map.  Otherwise the time is accounted twice.

Thanks,
Namhyung

> +
>  		/* prevent to reuse the timestamp later */
>  		pelem->timestamp = 0;
>  	}
> diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
> index 357231cb1c38..eaf7be92472d 100644
> --- a/tools/perf/util/off_cpu.h
> +++ b/tools/perf/util/off_cpu.h
> @@ -15,9 +15,15 @@ struct record_opts;
>  #define OFFCPU_SAMPLE_TYPES  (PERF_SAMPLE_IDENTIFIER | PERF_SAMPLE_IP | \
>  			      PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
>  			      PERF_SAMPLE_ID | PERF_SAMPLE_CPU | \
> -			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_CALLCHAIN | \
> +			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
>  			      PERF_SAMPLE_CGROUP)
>  
> +/*
> + * for embedded data to overwrite the original sample, duplicated sample types
> + * must be set in the original OFFCPU_SAMPLE_TYPES, except for callchain.
> + */
> +#define OFFCPU_EMBEDDED_SAMPLE_TYPES  (PERF_SAMPLE_TID | PERF_SAMPLE_PERIOD | \
> +				       PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_CGROUP)
>  
>  #ifdef HAVE_BPF_SKEL
>  int off_cpu_prepare(struct evlist *evlist, struct target *target,
> -- 
> 2.43.0
> 
