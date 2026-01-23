Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D828347BD9
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146966; cv=none; b=WNA3vUT7C3pwxxp5UjS/U+t3YSbpBJF1wHof8anV2wUbpGxl3zNbwwFxcAwE+aZacMNan4sK6CVD1/kbUvW5b6c72WU1BvtE7vWrSbkpsH+6sF4dJJpSeK2Rb20fGH84lnLXMr5+FmNs6l1NQxLRYsloh5G1pUP/A7tzbmMXSdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146966; c=relaxed/simple;
	bh=FrUeNDP9RlENOEr8FeuMEBFhRxMbeBSlOCR8u9I1EBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkESL82EQSqX2Vuu7NNhAu7pG4ZXgLkJKHvpgm7ctqbbM3h0UNks603av3GoEjUIhhLSuLEJwC4iq1KWPtFxsCBKHGtE9++9+8y1GPyP2yxIF2xQgX7l3+YRPfE3TrqaiOqWgbm2myhdT6X9c/Fs9zSJgpgPoOTOecBs2Bg93f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IVyUtEJ9; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IVyUtEJ9"
Message-ID: <a65cd17e-75a2-4fd3-ae10-bd5b3fe06c4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769146955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bN6fyYGSqekRGbcXbXByEpcRpH0rENbeTj//CFPhLts=;
	b=IVyUtEJ9tgK/guNqoXozHiyvXSHCBJpnqX7HrjSzDCvZqiStsmCC9ReYbUSaLMwlbHrtkc
	LrTzlow47tApsPkTBHxMGyMKzrTt/vJhBor3f24F3LgBJunZ1fB0yBDcKjrzxlwzjrlF6o
	fMHKUmrw8pTvs1maBG+teJqE6VxCqi8=
Date: Fri, 23 Jan 2026 13:42:18 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251217093326.1745307-1-chen.dylane@linux.dev>
 <20251217093326.1745307-3-chen.dylane@linux.dev>
 <CAEf4BzYEsKQxT--=oQELZ7g402FWpEuDEmxcovZXkck+k2U8HQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzYEsKQxT--=oQELZ7g402FWpEuDEmxcovZXkck+k2U8HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/23 08:38, Andrii Nakryiko 写道:
> On Wed, Dec 17, 2025 at 1:34 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> As Alexei noted, get_perf_callchain() return values may be reused
>> if a task is preempted after the BPF program enters migrate disable
>> mode. The perf_callchain_entres has a small stack of entries, and
>> we can reuse it as follows:
>>
>> 1. get the perf callchain entry
>> 2. BPF use...
>> 3. put the perf callchain entry
>>
>> And Peter suggested that get_recursion_context used with preemption
>> disabled, so we should disable preemption at BPF side.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/stackmap.c | 68 +++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 56 insertions(+), 12 deletions(-)
>>
> 
> I took a bit closer look at these changes and I'm a fan of the
> particular implementation, tbh. It's a bit of a maze how all these
> different call chain cases are handled, so I might be missing
> something, but I'd address this a bit differently.
> 
> First, instead of manipulating this obscure rctx as part of interface,
> I'd record rctx inside the perf_callchain_entry itself, and make sure
> that get_callchain_entry does have any output arguments.
> put_callchain_entry() would then accept perf_callchain_entry reference
> and just fetch rctx from inside it.
> 

Hi Andrri,

Try to implement this briefly with code, is my understanding correct?

struct perf_callchain_entry *get_callchain_entry(void)
{
         int cpu;
         int rctx;
         struct perf_callchain_entry *entry;
         struct callchain_cpus_entries *entries;

         rctx = get_recursion_context(this_cpu_ptr(callchain_recursion));
         if (rctx == -1)
                 return NULL;

         entries = rcu_dereference(callchain_cpus_entries);
         if (!entries) {
  
put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
                 return NULL;
         }

         cpu = smp_processor_id();

         entry = ((void *)entries->cpu_entries[cpu]) +
                 (rctx * perf_callchain_entry__sizeof());
         entry->rctx = rctx;

         return entry;
}

void
put_callchain_entry(struct perf_callchain_entry *entry)
{
         put_recursion_context(this_cpu_ptr(callchain_recursion), 
entry->rctx);
}

And then no need rtcx in bpf_get_perf_callchain.

bpf_get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
                        int max_stack, bool crosstask)

Functionally, this seems fine. The only concern is whether the perf 
maintainer will approve it after all, this change involves modifying 
their core interfaces.

Peter, Yonghong, can we do this?

> Then instead of open-coding get_perf_callchain by exposing
> __init_perf_callchain_ctx, __get_perf_callchain_kernel, and
> __get_perf_callchain_user, can't we have __get_perf_callchain() which
> will accept perf_callchain_entry as an input and won't do get/put
> internally. And then existing get_perf_callchain() will just do get +
> __get_perf_callchain + put, while BPF-side code will do it's own get
> (with preemption temporarily disabled), will fetch callstack in one of
> a few possible ways, and then put it (unless callchain_entry is coming
> from outside, that trace_in thing).
> 

Exposing only __get_perf_callchain will make it much easier for BPF 
callers to understand and use. And following Peter's suggestion, we can 
mark _init_perf_callchain_ctx, __get_perf_callchain_kernel, and 
__get_perf_callchain_user as static, then have __get_perf_callchain 
encapsulate the logic of _init_perf_callchain_ctx, 
__get_perf_callchain_kernel, and __get_perf_callchain_user. What do you 
think？

> It's close to what you are doing, but I don't think anyone likes those
> exposed __init_perf_callchain_ctx + __get_perf_callchain_kernel +
> __get_perf_callchain_user. Can't we avoid that? (and also not sure we
> need add_mark inside the ctx itself, do we?)
> 
> pw-bot: cr
> 
> 
> 
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index da3d328f5c1..3bdd99a630d 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -210,13 +210,14 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>   }
>>
>>   static struct perf_callchain_entry *
>> -get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>> +get_callchain_entry_for_task(int *rctx, struct task_struct *task, u32 max_depth)
>>   {
>>   #ifdef CONFIG_STACKTRACE
>>          struct perf_callchain_entry *entry;
>> -       int rctx;
>>
>> -       entry = get_callchain_entry(&rctx);
>> +       preempt_disable();
>> +       entry = get_callchain_entry(rctx);
>> +       preempt_enable();
>>
>>          if (!entry)
>>                  return NULL;
>> @@ -238,8 +239,6 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>>                          to[i] = (u64)(from[i]);
>>          }
>>
>> -       put_callchain_entry(rctx);
>> -
>>          return entry;
>>   #else /* CONFIG_STACKTRACE */
>>          return NULL;
>> @@ -320,6 +319,34 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>          return id;
>>   }
>>
>> +static struct perf_callchain_entry *
>> +bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool kernel, bool user,
>> +                      int max_stack, bool crosstask)
>> +{
>> +       struct perf_callchain_entry_ctx ctx;
>> +       struct perf_callchain_entry *entry;
>> +
>> +       preempt_disable();
>> +       entry = get_callchain_entry(rctx);
>> +       preempt_enable();
>> +
>> +       if (unlikely(!entry))
>> +               return NULL;
>> +
>> +       __init_perf_callchain_ctx(&ctx, entry, max_stack, false);
>> +       if (kernel)
>> +               __get_perf_callchain_kernel(&ctx, regs);
>> +       if (user && !crosstask)
>> +               __get_perf_callchain_user(&ctx, regs, 0);
>> +
>> +       return entry;
>> +}
>> +
>> +static void bpf_put_perf_callchain(int rctx)
>> +{
>> +       put_callchain_entry(rctx);
>> +}
>> +
>>   BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>             u64, flags)
>>   {
>> @@ -328,20 +355,25 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>          struct perf_callchain_entry *trace;
>>          bool kernel = !user;
>>          u32 max_depth;
>> +       int rctx, ret;
>>
>>          if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>>                                 BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>>                  return -EINVAL;
>>
>>          max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
>> -       trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -                                  false, false, 0);
>> +
>> +       trace = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth,
>> +                                      false);
>>
>>          if (unlikely(!trace))
>>                  /* couldn't fetch the stack trace */
>>                  return -EFAULT;
>>
>> -       return __bpf_get_stackid(map, trace, flags);
>> +       ret = __bpf_get_stackid(map, trace, flags);
>> +       bpf_put_perf_callchain(rctx);
>> +
>> +       return ret;
>>   }
>>
>>   const struct bpf_func_proto bpf_get_stackid_proto = {
>> @@ -435,6 +467,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>          bool kernel = !user;
>>          int err = -EINVAL;
>>          u64 *ips;
>> +       int rctx;
>>
>>          if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>>                                 BPF_F_USER_BUILD_ID)))
>> @@ -467,18 +500,26 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>                  trace = trace_in;
>>                  trace->nr = min_t(u32, trace->nr, max_depth);
>>          } else if (kernel && task) {
>> -               trace = get_callchain_entry_for_task(task, max_depth);
>> +               trace = get_callchain_entry_for_task(&rctx, task, max_depth);
>>          } else {
>> -               trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -                                          crosstask, false, 0);
>> +               trace = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth,
>> +                                              crosstask);
>>          }
>>
>> -       if (unlikely(!trace) || trace->nr < skip) {
>> +       if (unlikely(!trace)) {
>>                  if (may_fault)
>>                          rcu_read_unlock();
>>                  goto err_fault;
>>          }
>>
>> +       if (trace->nr < skip) {
>> +               if (may_fault)
>> +                       rcu_read_unlock();
>> +               if (!trace_in)
>> +                       bpf_put_perf_callchain(rctx);
>> +               goto err_fault;
>> +       }
>> +
>>          trace_nr = trace->nr - skip;
>>          copy_len = trace_nr * elem_size;
>>
>> @@ -497,6 +538,9 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>          if (may_fault)
>>                  rcu_read_unlock();
>>
>> +       if (!trace_in)
>> +               bpf_put_perf_callchain(rctx);
>> +
>>          if (user_build_id)
>>                  stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
>>
>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen
