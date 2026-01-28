Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58593B28D;
	Wed, 28 Jan 2026 04:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769574113; cv=none; b=FyNHWb/ESHPEgi66mPKLLjLA9M8F/fAJCD59OMlcxGwhPh+GpygVkueaV/VRlvlBZHsd/S4zkXXPauZnT89Ap/xvmsqw+1OfTeBCShxHIGCJUK29d6I8ljOuR0dGWSM5i8mmpyi97BKw2T2nYfrAls7+B/a1o6KR+ObKjjdVECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769574113; c=relaxed/simple;
	bh=fnfSexX3nTY4kLO+8MDEEy+q/XQ/vKO+lDDb4iCUqUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGClKDcQ5Nl+ltZCk8sZI6WKBgz5WwNV3xCnx0WQA5xpfVpwxi7KReJl4zO2h90pt6PddXiEWocK2ZURhJ7YFUmISE1Z8xyXBu6G6A4N9BYyfbRXaTAP2hhLlyYmd+z1z9MiOmWRZ3F9jQSYa2LtL2RdzlrDw0hVOiv1feVUxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnpPYZM/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pnpPYZM/"
Message-ID: <e609a4d6-1b28-4858-8a46-a95f0794bb33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769574105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iLSt35krLeyCU2JfA78lW6/p0Uk0QktVVx4ZqWTJpg=;
	b=pnpPYZM/U4UdfdB0arNcrdbHGEGWUE5OZ6/Je5NY1d0dilTyNRiNqknd1b67oVC70MYezX
	vXqUwqmNKReHfigiJoUCNoOv8Z2ZyvWdbwPrBJZuaJvAv986JqFtXFaQi4P1X1cc5CDrPl
	ZjhusiSky0mKw1OUGm0xVtWV24+18Nk=
Date: Wed, 28 Jan 2026 12:21:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 3/3] bpf: Hold ther perf callchain entry until
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
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-4-chen.dylane@linux.dev>
 <CAEf4BzbubXxLHsO_2aVBG_oYE1Sc9iafLyvcX-PEjcQ7EXWCqA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbubXxLHsO_2aVBG_oYE1Sc9iafLyvcX-PEjcQ7EXWCqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/28 05:35, Andrii Nakryiko 写道:
> On Sun, Jan 25, 2026 at 11:46 PM Tao Chen <chen.dylane@linux.dev> wrote:
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
>>   kernel/bpf/stackmap.c | 55 ++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 47 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index e77dcdc2164..6bdee6cc05f 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -215,7 +215,9 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>>   #ifdef CONFIG_STACKTRACE
>>          struct perf_callchain_entry *entry;
>>
>> +       preempt_disable();
>>          entry = get_callchain_entry();
>> +       preempt_enable();
> 
> pass perf_callchain_entry as input argument, to keep similar approach
> to __get_perf_callchain, see below
> 
>>
>>          if (!entry)
>>                  return NULL;
>> @@ -237,14 +239,40 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
>>                          to[i] = (u64)(from[i]);
>>          }
>>
>> -       put_callchain_entry(entry);
>> -
>>          return entry;
>>   #else /* CONFIG_STACKTRACE */
>>          return NULL;
>>   #endif
>>   }
>>
>> +static struct perf_callchain_entry *
>> +bpf_get_perf_callchain(struct pt_regs *regs, bool kernel, bool user, int max_stack,
>> +                      bool crosstask)
>> +{
> 
> I don't really like having this wrapper, it feels like the flow will
> be cleaner and easier to follow if we modify the code as suggested
> below
> 

Ok, will use it directly.
>> +       struct perf_callchain_entry *entry;
>> +       int ret;
>> +
>> +       preempt_disable();
>> +       entry = get_callchain_entry();
>> +       preempt_enable();
> 
> I'd actually consider having __get_callchain_entry() that does what
> get_callchain_entry() does right now under assumption that
> preemption/migration is disabled, and then make get_callchain_entry do
> preempt_disable + fetch entry + preevent_enable + return entry dance.
> 

in v4, YongHong suggested add preempt_disable in get_callchain_entry,
but Peter suggested that do it from BPF side, so maybe keeping the 
existing method is a compromise.

> This will simplify the flow here to just with no explicit
> preempt_{disable,enable} visible. Either way all of this has
> assumption that we are staying on the same CPU throughout (so at the
> very least we need to have migration disabled)
> 
> entry = get_callchain_entry();
> __get_perf_callchain(entry, ...);
> put_callchain_entry();
> 
> 
> BTW, is there a way to assert that either preemption or migration is
> currently disabled? I think both get_callchain_entry and
> put_callchain_entry would benefit from that
> 
> pw-bot: cr
> 
> 
>> +
>> +       if (unlikely(!entry))
>> +               return NULL;
>> +
>> +       ret = __get_perf_callchain(entry, regs, kernel, user, max_stack, crosstask, false, 0);
>> +       if (ret) {
>> +               put_callchain_entry(entry);
>> +               return NULL;
>> +       }
>> +
>> +       return entry;
>> +}
>> +
>> +static void bpf_put_perf_callchain(struct perf_callchain_entry *entry)
>> +{
>> +       put_callchain_entry(entry);
>> +}
>> +
>>   static long __bpf_get_stackid(struct bpf_map *map,
>>                                struct perf_callchain_entry *trace, u64 flags)
>>   {
>> @@ -327,20 +355,23 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
>>          struct perf_callchain_entry *trace;
>>          bool kernel = !user;
>>          u32 max_depth;
>> +       int ret;
>>
>>          if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>>                                 BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
>>                  return -EINVAL;
>>
>>          max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
>> -       trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -                                  false, false, 0);
>> +       trace = bpf_get_perf_callchain(regs, kernel, user, max_depth, false);
>>
>>          if (unlikely(!trace))
>>                  /* couldn't fetch the stack trace */
>>                  return -EFAULT;
>>
>> -       return __bpf_get_stackid(map, trace, flags);
>> +       ret = __bpf_get_stackid(map, trace, flags);
>> +       bpf_put_perf_callchain(trace);
> 
> Just as above, I think get_callchain_entry + __get_perf_callchain +
> put_callchain_entry is better, IMO
> 
>> +
>> +       return ret;
>>   }
>>
>>   const struct bpf_func_proto bpf_get_stackid_proto = {
>> @@ -468,13 +499,19 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>          } else if (kernel && task) {
>>                  trace = get_callchain_entry_for_task(task, max_depth);
>>          } else {
>> -               trace = get_perf_callchain(regs, kernel, user, max_depth,
>> -                                          crosstask, false, 0);
>> +               trace = bpf_get_perf_callchain(regs, kernel, user, max_depth, crosstask);
>>          }
> 
> with the above suggestions this will be a pretty streamlined:
> 
> trace = trace_in ?: get_callchain_entry();
> if (!trace)
>      goto err_fault;
> 
> if (trace_in) {
>      trace->nr = ...
>      err = 0
> } else if (kernel && task) {
>      err = get_callchain_entry_for_task(trace, ...);
> } else {
>      err = __get_perf_callchain(trace, ...);
> }
> if (err)
>      goto clear;
> 

This code looks much cleaner, i will change it, thanks.

> ... proceed as before, we have our stack trace inside trace ...
> 
> for successful and failed paths (you'll have to duplicate this logic):
> 
> if (trace != trace_in)
>      put_callchain_entry(trace);
> 
>>
>> -       if (unlikely(!trace) || trace->nr < skip) {
>> +       if (unlikely(!trace)) {
> 
> this condition cannot happen: we either get trace_in != NULL or we get
> it using __get_callchain_entry and then validate it's not NULL
> earlier, so drop this condition
>

will remove it.

>> +               if (may_fault)
>> +                       rcu_read_unlock();
>> +               goto err_fault;
>> +       }
>> +       if (trace->nr < skip) {
>>                  if (may_fault)
>>                          rcu_read_unlock();
>> +               if (!trace_in)
>> +                       bpf_put_perf_callchain(trace);
> 
> do this clean up in one place, behind the new goto label? it's a bit
> too easy to miss this, IMO
> 

ok, will do.

>>                  goto err_fault;
>>          }
>>
>> @@ -495,6 +532,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>>          /* trace/ips should not be dereferenced after this point */
>>          if (may_fault)
>>                  rcu_read_unlock();
> 
> now that I looked at this code, I feel like we don't really need this
> rcu_read_{lock,unlock}() dance (even though I added it in the first
> place). I this RCU was supposed to be need to keep
> perf_callchain_entry alive long enough, but for BPF this is guaranteed
> because either BPF stack map will keep them alive by delaying
> put_callchain_buffer() until freeing time (after RCU Tasks Trace + RCU
> grace periods), or for bpf_get_stack/bpf_get_task_stack, BPF program
> itself will hold these buffers alive again, until freeing time which
> is delayed until after RCU Tasks Trace + RCU grace period.

It seems so, for both, put_callchain_buffer is always called at the end, 
which ensures it won't be released during use, i will remove it as a new
patch.

> 
> Please send this clean up as the first patch in the series so we can
> review and ack this separately. Thanks!
> 
>> +       if (!trace_in)
>> +               bpf_put_perf_callchain(trace);
>>
>>          if (user_build_id)
>>                  stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen
