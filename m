Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0EE15665C;
	Wed,  7 Aug 2024 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074602; cv=none; b=aiYkxm5UEJL6eHv6CBeZq2CHppcldgdoKUEFl0mtn4ye7OaXRnK2fZ/GyoyrIZTuZc4WuvHK94X7qkQlgqx8C5m9CmqWdvAHvcRicix//OhLH2dOXV+Mq4o9XeTAH6MBShZ78CwW+beD4+6/sU7PiYxO60/pIAns/acfepCq3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074602; c=relaxed/simple;
	bh=1Y39yPQtkTDnnt4FA/xzwuldlGxg7krS0BUCu83Fk+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUIwmFrWW74OlmpDdNr6BlacHnPCeIc7T1U5PSBzoMqfwCVWaMDqe0IXWJ+tr6w2Ft9H6jWwVlNcBpnL9ibTlQzzHyhb/flzkrXf4Cs2x+Ou8f69IrnJIT9dHqgqOq52eCChIVWbCv+QaSRgesBYWcWrVpzr9dg2syt/jWuFLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnOpG7jm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnOpG7jm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48114C32781;
	Wed,  7 Aug 2024 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723074601;
	bh=1Y39yPQtkTDnnt4FA/xzwuldlGxg7krS0BUCu83Fk+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnOpG7jm/HLrXv/Ii1iJFHLAlp4tYYBXuDwfnk8+kNK1eJuwP66OXL/p2rqqIt09v
	 aST3ekLNuDL0k8bw+GGX0iVQv/w3kHSmrY+7rbqbBq33NRpTx/al2wJsPIxbOi9Pze
	 HqFVpfH4/YAE3w66tPg89DxNdUsP0vk+HIAQW4JY1BWxyyUuq86B9zh46AqYj2y/Ny
	 mMPpK9dKXQ552FJPnYVyuBnhjKlWgek3FHm8jscAuoqjvpkTSnTsQ+EVtwnvFsivUB
	 /dJh5EAXdWm3xL1F5BCljsXZEBXPCbiLvOHR2HE42NeGjNzmLzBEabOoeJUMi/1jO7
	 04+M2s7fqTYhg==
Date: Wed, 7 Aug 2024 16:49:59 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] perf record off-cpu: Dump direct off-cpu samples
 in BPF
Message-ID: <ZrQIJ9xRg22qALoQ@google.com>
References: <20240807153843.3231451-1-howardchu95@gmail.com>
 <20240807153843.3231451-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807153843.3231451-5-howardchu95@gmail.com>

On Wed, Aug 07, 2024 at 11:38:38PM +0800, Howard Chu wrote:
> Output PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD, PERF_SAMPLE_CALLCHAIN, and
> PERF_SAMPLE_CGROUP in BPF. Ideally, we should only output
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

Isn't it just because your system was idle?

> 
> We need to retrieve PERF_SAMPLE_TID, PERF_SAMPLE_PERIOD,
> PERF_SAMPLE_CALLCHAIN, and PERF_SAMPLE_CGROUP using BPF and output these
> four fields.
> 
> Add perf_event_array map for dumping direct off-cpu samples, but keep
> the at-the-end approach.
> 
> Tons of checking before access, to pass the BPF verifier.
> 
> If off-cpu time (represented as delta) exceeds the off-cpu threshold, do
> output.
> 
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 133 +++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
> 
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> index cca1b6990a57..95cc130bb67e 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -18,6 +18,9 @@
>  #define MAX_STACKS   32
>  #define MAX_ENTRIES  102400
>  
> +#define MAX_CPUS  4096
> +#define MAX_OFFCPU_LEN 128
> +
>  struct tstamp_data {
>  	__u32 stack_id;
>  	__u32 state;
> @@ -32,6 +35,7 @@ struct offcpu_key {
>  	__u64 cgroup_id;
>  };
>  
> +/* for dumping at the end */
>  struct {
>  	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
>  	__uint(key_size, sizeof(__u32));
> @@ -39,6 +43,45 @@ struct {
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
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(__u32));
> +	__uint(max_entries, MAX_CPUS);
> +} offcpu_output SEC(".maps");
> +
> +/* temporary offcpu sample */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct offcpu_data));
> +	__uint(max_entries, 1);
> +} offcpu_payload SEC(".maps");
> +
> +/* temporary stack data */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	__uint(value_size, sizeof(struct stack_data));
> +	__uint(max_entries, 1);
> +} stack_tmp SEC(".maps");
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
> @@ -184,12 +227,75 @@ static inline int can_record(struct task_struct *t, int state)
>  	return 1;
>  }
>  
> +static inline bool check_bounds(int index)
> +{
> +	if (index >= 0 && index < MAX_OFFCPU_LEN)
> +		return true;
> +
> +	return false;
> +}
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
> +			data->array[ip_pos] = data->array[n + 2];

Where is ip_pos set?  I guess we don't need this as we don't update the
SAMPLE_IP here.

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
> +	struct stack_data *stack_tmp_p, *stack_p;
> +	int zero = 0, len = 0;
>  
>  	ts = bpf_ktime_get_ns();
>  
> @@ -199,6 +305,25 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>  	stack_id = bpf_get_stackid(ctx, &stacks,
>  				   BPF_F_FAST_STACK_CMP | BPF_F_USER_STACK);
>  
> +	/* cache stacks */
> +	stack_tmp_p = bpf_map_lookup_elem(&stack_tmp, &zero);
> +	if (stack_tmp_p)
> +		len = bpf_get_stack(ctx, stack_tmp_p->array, MAX_STACKS * sizeof(u64),
> +				    BPF_F_USER_STACK) / sizeof(u64);

Looks redundant, but not sure if we share the stackid..

> +
> +	/*
> +	 * if stacks are successfully collected, cache them to task_storage, they are then
> +	 * dumped if the off-cpu time hits the threshold.
> +	 */
> +	if (len > 0) {
> +		stack_p = bpf_task_storage_get(&stack_cache, prev, NULL,
> +					       BPF_LOCAL_STORAGE_GET_F_CREATE);
> +		if (stack_p) {
> +			for (int i = 0; i < len && i < MAX_STACKS; ++i)
> +				stack_p->array[i] = stack_tmp_p->array[i];
> +		}
> +	}

Why not use the task storage to get the stacktrace directly?

Thanks,
Namhyung

> +
>  	pelem = bpf_task_storage_get(&tstamp, prev, NULL,
>  				     BPF_LOCAL_STORAGE_GET_F_CREATE);
>  	if (!pelem)
> @@ -228,6 +353,14 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
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
> +
>  		/* prevent to reuse the timestamp later */
>  		pelem->timestamp = 0;
>  	}
> -- 
> 2.45.2
> 
