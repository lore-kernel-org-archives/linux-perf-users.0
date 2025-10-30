Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D052F9998
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791855; cv=none; b=oBAXQ5hoabInWn23GVGrFGmji/IqwkBTCPzYrrPIjUfLOo7GsiOHJwdBhK5V/wpK73cDdoqXQgYksDdY/eJwg5HvdLMY4SBk3Lxh9uDjwsv1HgWWHKCtoz73IIKaDxA9QxwThhnB0kHS5Xta0PzIzq/T1UREjjzcrmu0md96lUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791855; c=relaxed/simple;
	bh=oC9Ig42hWklRcp3NJPqZXoxu09JQxObjX3p/oUGkPV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYCiAjB4/4mqxBQ0pyeEibUozJ8gRTM63+Bxan+D5KMLZK7s07gbKQgzY4q3D8GyuDVfProdDof1ByGKoKpt6BJpSx5PQsJ2gCJn3wbTa7V9whbn17L7d2Hzhlzgj8K2L41SpZ2BHnabwnZM/p6dR4Cw5K0f8F4mIZ1b1kRUj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X9QtkD2P; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X9QtkD2P"
Message-ID: <2dbebe3a-5b96-4076-a3e3-00ae8de990d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761791850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLvjLcI/0DbJGC9Bc0bi6CFAYKKHC4jWpCjENERXsTk=;
	b=X9QtkD2Pe4Zq+yV7u5SP7kxWg9suXEIuWSxXX/Cqm88rD33ASllGFv4Irl77jhnU4j7jGu
	/2mgDdOxQq8KhUF/nWoWrTT7jCbQiOhOZzZ4Y8h1piJo/BSJ5MC8/ioiIxOBeqteaoV3md
	mo5DVcWFR08U4A66r1UUeE0wG1G8tRc=
Date: Thu, 30 Oct 2025 10:36:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] perf: Refactor get_perf_callchain
To: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20251028162502.3418817-2-chen.dylane@linux.dev>
 <a48e281e6912037490270da40f79e45c1ad1e430c8c1cc84c48306106b06113a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <a48e281e6912037490270da40f79e45c1ad1e430c8c1cc84c48306106b06113a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/29 01:09, bot+bpf-ci@kernel.org 写道:
> 
> ```
> commit 59cfc61f83ad4ec998f4242ca000c554e3001b47
> Author: Tao Chen <chen.dylane@linux.dev>
> 
> perf: Refactor get_perf_callchain
> 
> This patch refactors get_perf_callchain() by extracting logic into new
> helper functions to provide more flexible stack-sampling APIs for BPF.
> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index fd1d91017..14a382cad 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -67,6 +67,7 @@ struct perf_callchain_entry_ctx {
>>   	u32				nr;
>>   	short				contexts;
>>   	bool				contexts_maxed;
>> +	bool				add_mark;
>>   };
> 
> [ ... ]
> 
>> @@ -1718,9 +1719,17 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
>>
>>   extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>>   extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
>> +
>> +extern void __init_perf_callchain_ctx(struct perf_callchain_entry_ctx *ctx,
>> +				      struct perf_callchain_entry *entry,
>> +				      u32 max_stack, bool add_mark);
>> +
>> +extern void __get_perf_callchain_kernel(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
>> +extern void __get_perf_callchain_user(struct perf_callchain_entry_ctx *ctx, struct pt_regs *regs);
>> +
>>   extern struct perf_callchain_entry *
>>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -		   u32 max_stack, bool crosstask, bool add_mark);
>> +		   u32 max_stack, bool crosstask);
> 
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 4d53cdd13..e28b35c7e 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>   		max_depth = sysctl_perf_event_max_stack;
>>
>>   	trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -				   false, false);
>> +				   false);
>                                         ^^^^^ removed last parameter
> 
> Previously bpf_get_stackid() passed add_mark=false to get_perf_callchain().
> Now the parameter is gone, but get_perf_callchain() hardcodes add_mark=true
> when calling __init_perf_callchain_ctx(). This means BPF stack traces will
> now include PERF_CONTEXT_KERNEL/PERF_CONTEXT_USER marker values when they
> didn't before.
> 

The entire modification involves changes to two subsystems. To make the 
review easier, the get_perf_callchain has been simply adapted here. In 
the next patch, BPF will no longer use get_perf_callchain, and add_mark 
will be set to false.

> The markers get added by __get_perf_callchain_kernel() and
> __get_perf_callchain_user() when ctx->add_mark is true. These markers are
> sentinel values (-128 for KERNEL, -512 for USER) that appear in the trace
> IP array alongside actual instruction pointers.
> 
>>
>>   	if (unlikely(!trace))
>>   		/* couldn't fetch the stack trace */
>> @@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>   		trace = get_callchain_entry_for_task(task, max_depth);
>>   	else
>>   		trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -					   crosstask, false);
>> +					   crosstask);
>                                                     ^^^^^ same issue here
> 
> Same problem in __bpf_get_stack() which was also passing add_mark=false.
> 
> This changes BPF stack map behavior in user-visible ways:
> 
> 1) bpf_get_stackid() hashes the entire trace->ip[] array including any
>     markers, so identical stacks will now produce different stack IDs.
> 
> 2) bpf_get_stack() copies trace->ip[] directly to userspace buffers,
>     so BPF programs will see marker values mixed with instruction pointers.
> 
> Can BPF tools handle these unexpected marker values? The commit message
> says "The next patch will modify the BPF part" but doesn't explain this
> intermediate behavior change.
> 
>> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
>> index 808c0d7a3..2c36e4906 100644
>> --- a/kernel/events/callchain.c
>> +++ b/kernel/events/callchain.c
> 
> [ ... ]
> 
>>   struct perf_callchain_entry *
>>   get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>> -		   u32 max_stack, bool crosstask, bool add_mark)
>> +		   u32 max_stack, bool crosstask)
>>   {
>>   	struct perf_callchain_entry *entry;
>>   	struct perf_callchain_entry_ctx ctx;
>> -	int rctx, start_entry_idx;
>> +	int rctx;
>>
>>   	/* crosstask is not supported for user stacks */
>>   	if (crosstask && user && !kernel)
>> @@ -232,34 +273,14 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>>   	if (!entry)
>>   		return NULL;
>>
>> -	ctx.entry		= entry;
>> -	ctx.max_stack		= max_stack;
>> -	ctx.nr			= entry->nr = 0;
>> -	ctx.contexts		= 0;
>> -	ctx.contexts_maxed	= false;
>> +	__init_perf_callchain_ctx(&ctx, entry, max_stack, true);
>                                                                  ^^^^
> Here's where add_mark is hardcoded to true for all callers. The old code
> allowed callers to control this via parameter. BPF was passing false,
> perf_callchain() was passing true. Now both get true unconditionally.
> 
> [ ... ]
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7541f6f85..eb0f11059 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -8218,7 +8218,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>>   		return &__empty_callchain;
>>
>>   	callchain = get_perf_callchain(regs, kernel, user,
>> -				       max_stack, crosstask, true);
>> +				       max_stack, crosstask);
>>   	return callchain ?: &__empty_callchain;
>>   }
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `perf: Refactor get_perf_callchain`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18882141979


-- 
Best Regards
Tao Chen
