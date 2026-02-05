Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6040350D58
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770272210; cv=none; b=JAOrP8I1OqPXFtOJeRyqoXnskvPY/vskiUGgSFsIOfCWScC//WX2AvQOWEV2KgfoVdYI7VagJESCtBOKlF6EkG1Si+ZSqbaqTMmZ1kFk/1NITyAeQxMje88C5M9RSDwM+kA9yUksO6WGH5YhgJYbMLixWxTIVcIu54zgCK213gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770272210; c=relaxed/simple;
	bh=1E0SciJXPE1yk0JplcHeLfrSOybe1RyO+x/hgHdc36s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsj/HBv6i1aD1mBOcTLjm46q/xY+l1/pEQDm8vXxS8PpVUr7KJcQ7sPVyIZuCWnuPQ237/Z506R3g89QLVikyn+eqt18DXLO5CKLX5Y+JeITmiZBtF1rVNCp/1FTmJTsIrcpetol0yYW62BYAOUBrFCReLCK0ZxtUtBi5S6cE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FCO30Irs; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FCO30Irs"
Message-ID: <bb62bd4f-199e-4907-817f-bc820c9198c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770272197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/viAndT9HhD0mSIQB8owUDsdQG9Eoq6fTAbljN9WxIk=;
	b=FCO30Irs/PYDEVCeiiQEiLTHieTIlC4Jw6iZB5c2Wr21SySKIIoTvkjdnYKAsQ79URKSGb
	sa2bxUWdku0q3AHIa0wZr+jBfj6bWLU9gKupkn/3YBq81WCzGC9ZDkq+A/l4+EKPwdK/Em
	1XLmEVzL6oSSiNVCxktTGBr2iJzdgBQ=
Date: Thu, 5 Feb 2026 14:16:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
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
 <20260126074331.815684-3-chen.dylane@linux.dev>
 <CAEf4BzYMJfQN+0SwzBM-DhREHwZ54TwA6GUtFv9=xret9pzXrQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzYMJfQN+0SwzBM-DhREHwZ54TwA6GUtFv9=xret9pzXrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/2/4 09:08, Andrii Nakryiko 写道:
> On Sun, Jan 25, 2026 at 11:45 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>>  From BPF stack map, we want to ensure that the callchain buffer
>> will not be overwritten by other preemptive tasks and we also aim
>> to reduce the preempt disable interval, Based on the suggestions from Peter
>> and Andrrii, export new API __get_perf_callchain and the usage scenarios
>> are as follows from BPF side:
>>
>> preempt_disable()
>> entry = get_callchain_entry()
>> preempt_enable()
>> __get_perf_callchain(entry)
>> put_callchain_entry(entry)
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   include/linux/perf_event.h |  5 +++++
>>   kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
>>   2 files changed, 27 insertions(+), 12 deletions(-)
>>
> 
> Looking at the whole __bpf_get_stack() logic again, why didn't we just
> do something like this:
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..80364561611c 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> struct task_struct *task,
> 
>          max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
> 
> -       if (may_fault)
> -               rcu_read_lock(); /* need RCU for perf's callchain below */
> +       if (!trace_in)
> +               preempt_disable();
> 
>          if (trace_in) {
>                  trace = trace_in;
> @@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> struct task_struct *task,
>          }
> 
>          if (unlikely(!trace) || trace->nr < skip) {
> -               if (may_fault)
> -                       rcu_read_unlock();
> +               if (!trace_in)
> +                       preempt_enable();
>                  goto err_fault;
>          }
> 
> @@ -494,8 +494,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> struct task_struct *task,
>          }
> 
>          /* trace/ips should not be dereferenced after this point */
> -       if (may_fault)
> -               rcu_read_unlock();
> +       if (!trace_in)
> +               preempt_enable();
> 
>          if (user_build_id)
>                  stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
> 
> 
> ?
> 
> Build ID parsing is happening after we copied data from perf's
> callchain_entry into user-provided memory, so raw callchain retrieval
> can be done with preemption disabled, as it's supposed to be brief.
> Build ID parsing part which indeed might fault and be much slower will
> be done well after that (we even have a comment there saying that
> trace/ips should not be touched).
> 
> Am I missing something?

Yes it looks good for bpf_get_stack, and I also proposed a similar 
change previously. But Alexei suggested that we should reduce the 
preemption-disabled section protected in bpf_get_stackid if we do like 
bpf_get_stack. Maybe we can change it first for bpf_get_stack?

https://lore.kernel.org/bpf/20250922075333.1452803-1-chen.dylane@linux.dev/

> 
> [...]


-- 
Best Regards
Tao Chen
