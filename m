Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E942BDC15
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760939531; cv=none; b=PSI4+p7oS2k209kHOW4Tmmwxx6HBKVcKv/XxWghSKFr9f9pO2ouBY5oAhB0GwfSxNekstlH4XOIYE0s9eWKdK1PAFliJiyeDrzxsyio/DDxKFCzzdS4vvkamtrHpsSDI/9+4MngaRmoQPH9R5frOTL0an4EDu2zWvAhrUNQsy00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760939531; c=relaxed/simple;
	bh=JUpJDQR3IVbpV0Ak3uyxX1Ysi6l/QYP0HVY4pRL7lco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4TTPQh2DbXHFUy5NOUrpFyLQG7cLn5xyK20vAw20nL9kG4flRpjdZzgnGVGtDOvvN6RtN/DV0M7fMwQqiqpZoOeNDD9k8RRBsF3psEN2Skj1lFxmLKzUln8uJ4ZMqlZ77eyccUkbWEYwBgmpbXACiWw/9KG4EEJ5UGThFa4Dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cxqv0CxG; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cxqv0CxG"
Message-ID: <4c35feba-e075-42c1-82c5-5589c16f088e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760939512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjVuQKaiuc0hIwq42aM+do7ZKk3BIqGf7ik88PurFHE=;
	b=cxqv0CxGpcshgrZsY1LRThOa7biRiKqLYaDEXTjBzYZnfvHzsWTz4qgwHhhsseEWin/WhA
	As5h76Kdj/XRZ3iuS2+Svy4pmjAHKZusI7TE1g+r7+bnoAz5HoyWAEiG5fG9G1Px2QCIQw
	xG+omsR0R6oIvo5LHObWFYaqtLlmonY=
Date: Mon, 20 Oct 2025 13:50:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Use per-cpu BPF callchain entry to
 save callchain
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251019170118.2955346-1-chen.dylane@linux.dev>
 <20251019170118.2955346-3-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20251019170118.2955346-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/20 01:01, Tao Chen 写道:
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. Drawing on the per-cpu design of bpf_bprintf_buffers,
> per-cpu BPF callchain entry is used here.
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   kernel/bpf/stackmap.c | 98 ++++++++++++++++++++++++++++++++-----------
>   1 file changed, 74 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 94e46b7f340..3513077c57d 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -31,6 +31,52 @@ struct bpf_stack_map {
>   	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>   };
>   
> +struct bpf_perf_callchain_entry {
> +	u64 nr;
> +	u64 ip[PERF_MAX_STACK_DEPTH];
> +};
> +
> +#define MAX_PERF_CALLCHAIN_PREEMPT 3
> +static DEFINE_PER_CPU(struct bpf_perf_callchain_entry[MAX_PERF_CALLCHAIN_PREEMPT],
> +		      bpf_perf_callchain_entries);
> +static DEFINE_PER_CPU(int, bpf_perf_callchain_preempt_cnt);
> +
> +static int bpf_get_perf_callchain_or_entry(struct perf_callchain_entry **entry,
> +					   struct pt_regs *regs, bool kernel,
> +					   bool user, u32 max_stack, bool crosstack,
> +					   bool add_mark, bool get_callchain)
> +{
> +	struct bpf_perf_callchain_entry *bpf_entry;
> +	struct perf_callchain_entry *perf_entry;
> +	int preempt_cnt;
> +
> +	preempt_cnt = this_cpu_inc_return(bpf_perf_callchain_preempt_cnt);
> +	if (WARN_ON_ONCE(preempt_cnt > MAX_PERF_CALLCHAIN_PREEMPT)) {
> +		this_cpu_dec(bpf_perf_callchain_preempt_cnt);
> +		return -EBUSY;
> +	}
> +
> +	bpf_entry = this_cpu_ptr(&bpf_perf_callchain_entries[preempt_cnt - 1]);
> +	if (!get_callchain) {
> +		*entry = (struct perf_callchain_entry *)bpf_entry;
> +		return 0;
> +	}
> +
> +	perf_entry = get_perf_callchain(regs, (struct perf_callchain_entry *)bpf_entry,
> +					kernel, user, max_stack,
> +					crosstack, add_mark);
> +	*entry = perf_entry;
> +
> +	return 0;
> +}
> +
> +static void bpf_put_perf_callchain(void)
> +{
> +	if (WARN_ON_ONCE(this_cpu_read(bpf_perf_callchain_preempt_cnt) == 0))
> +		return;
> +	this_cpu_dec(bpf_perf_callchain_preempt_cnt);
> +}
> +
>   static inline bool stack_map_use_build_id(struct bpf_map *map)
>   {
>   	return (map->map_flags & BPF_F_STACK_BUILD_ID);
> @@ -192,11 +238,11 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>   {
>   #ifdef CONFIG_STACKTRACE
>   	struct perf_callchain_entry *entry;
> -	int rctx;
> -
> -	entry = get_callchain_entry(&rctx);
> +	int ret;
>   
> -	if (!entry)
> +	ret = bpf_get_perf_callchain_or_entry(&entry, NULL, false, false, 0, false, false,
> +					      false);
> +	if (ret)
>   		return NULL;
>   
>   	entry->nr = stack_trace_save_tsk(task, (unsigned long *)entry->ip,
> @@ -216,7 +262,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>   			to[i] = (u64)(from[i]);
>   	}
>   
> -	put_callchain_entry(rctx);
> +	bpf_put_perf_callchain();

double-put issue here reported by AI, i will fix it.

>   
>   	return entry;
>   #else /* CONFIG_STACKTRACE */
> @@ -305,6 +351,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   	bool user = flags & BPF_F_USER_STACK;
>   	struct perf_callchain_entry *trace;
>   	bool kernel = !user;
> +	int err;
>   
>   	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>   			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
> @@ -314,14 +361,15 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>   	if (max_depth > sysctl_perf_event_max_stack)
>   		max_depth = sysctl_perf_event_max_stack;
>   
> -	trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -				   false, false);
> +	err = bpf_get_perf_callchain_or_entry(&trace, regs, kernel, user, max_depth,
> +					      false, false, true);
> +	if (err)
> +		return err;
>   
> -	if (unlikely(!trace))
> -		/* couldn't fetch the stack trace */
> -		return -EFAULT;
> +	err = __bpf_get_stackid(map, trace, flags);
> +	bpf_put_perf_callchain();
>   
> -	return __bpf_get_stackid(map, trace, flags);
> +	return err;
>   }
>   
>   const struct bpf_func_proto bpf_get_stackid_proto = {
> @@ -443,20 +491,23 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   	if (sysctl_perf_event_max_stack < max_depth)
>   		max_depth = sysctl_perf_event_max_stack;
>   
> -	if (may_fault)
> -		rcu_read_lock(); /* need RCU for perf's callchain below */
> -
>   	if (trace_in)
>   		trace = trace_in;
> -	else if (kernel && task)
> +	else if (kernel && task) {
>   		trace = get_callchain_entry_for_task(task, max_depth);
> -	else
> -		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
> -					   crosstask, false);
> +	} else {
> +		err = bpf_get_perf_callchain_or_entry(&trace, regs, kernel, user, max_depth,
> +						      false, false, true);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (unlikely(!trace))
> +		goto err_fault;
>   
> -	if (unlikely(!trace) || trace->nr < skip) {
> -		if (may_fault)
> -			rcu_read_unlock();
> +	if (trace->nr < skip) {
> +		if (!trace_in)
> +			bpf_put_perf_callchain();
>   		goto err_fault;
>   	}
>   
> @@ -475,9 +526,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>   		memcpy(buf, ips, copy_len);
>   	}
>   
> -	/* trace/ips should not be dereferenced after this point */
> -	if (may_fault)
> -		rcu_read_unlock();
> +	if (!trace_in)
> +		bpf_put_perf_callchain();
>   
>   	if (user_build_id)
>   		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);


-- 
Best Regards
Tao Chen
