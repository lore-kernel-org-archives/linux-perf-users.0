Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D832E14C
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369640; cv=none; b=PBHRpujcJMr24ClcKIn7hEhCmtLiuUCH9Xipb7CF8kxWD8NpViggI2HkhP97oDpxUYCJ2tLIL1PQAfouFvLU664xGQ4jZVeyOQDvRZPztC4gM0dJAJi53UdvHoMnW0rGoiqjQU1YQlMFOwKZhIs4a0eUGoYPKFkJiBiM+XM8O4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369640; c=relaxed/simple;
	bh=6WV8h1EC+orIaaE9WRc5xJ7ordXuPKpDaUhfvptIUao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRWHlm7XFZCnoqEC7VlBe7vKfEX+YlcppeL2Fw9pyBOzOtmiN2CPjPoGJU4uHaEotmr+lXS2SKEi0laV7FyLAAM4TWWUi0RyF8EIihifh3SLNDIY7l1/8iLulVNYQ2zb8ycoy/MmmdvV2WeWPv1G2g5V5Wt9yO5HB+0hIGk2eys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL94VQDM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL94VQDM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a79998d35aso15216845ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 01:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770369640; x=1770974440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01FSvLOaY79DNMUile96b8YabfxQ/NF12aIBHZ8DH3k=;
        b=KL94VQDMDde3hRYKdc8vMwHdvKmQQYjqHOUB/GdXNDOQD+4ypzuQaA9GqLTEAmsVcf
         LsDLPrt/yy+CHpI1qoZpKduNsrbuYT0hMJy9Wv/k4VzaFvd9SXGfkKtuOsCLchtYeumV
         xB3cwe6PF0pgfIwf29/wSBYeeZ4xkwdG63AQyQER1EHpa2SRk/78NUfUTDc13gBputM6
         LyxjRlkLS4c9VxDjvSpjaIMmZ9EEi0SzjTQ+LCHBYE5xPiDhSgRIFlwHFesi9SUIE6WG
         pMaV4nJCEQdxMxKQUQJ9EVEY0zfX/gBHzHmKcAOqFil5691IzqyjzBLmAgkQ5wo3cnRO
         HClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770369640; x=1770974440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01FSvLOaY79DNMUile96b8YabfxQ/NF12aIBHZ8DH3k=;
        b=bbKbY6ybDCTk6f4HuoE3LxNy2+xDndv32DHTf+GaXLcEtp+rGNRhQ+Uu6ObjshgVME
         HPsBZf9IBFZcBkxih/7ddvQddMC6YNBLzfj3iDD1nA3AgQEUhoHGBNi5yylvnCS3oXyC
         4cw0QZJA3N6rSxo/+whzgXdh9c0B2fhaFivYaC45hiULSlvhEPbBPQzVQCKy0qrkMQOO
         KQOGG7zLfEDLscH1uwKP6jnG3+jU97RmVtPEXMC1d7VXMF7sTNOanP58Xrbmg+AgfpBK
         juFQrsOb6es+Drdm9Zd9b6NXQ8O3qW9SkYv0aTvB7UNYLFuldYu04o78SQaSmhOMKQSp
         0ThQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV3J5xEEunr9vLF+sHsYLFUDV7Lul40Ef0jj/NMSSego2Zg1COy37BWh9geeoFvjKJimcPEWaP67ALykfTxI0I@vger.kernel.org
X-Gm-Message-State: AOJu0YyZL//GfnUjNxAS7tAH0H1QU3wMYPToqG0Uorj1hIZlHzuLgPpw
	bB4ydmfwMfsbn1ih+pVcGXGalXD9CL3zHmMl3gXDZHspIyx6FeER3qDm
X-Gm-Gg: AZuq6aIDm36HV/SsVD+jT3WRqyuGxMbZXaU5tDJscxxkJiCEQFDf/kEsNCDKhhcd2iB
	UsUfHBpoZ6KZOeLTzSAJIvx6p7g7Rweh43v6Fq3qavOnxSTF7baXB0eYf4fgyDVsF8AAwKdHR19
	gMn+ouPodF5OqgdF5D+nedPL7upIoDUJ0/++qLu84vuPyYGBbVqxmcnRtKPMiY2TqioF27hJjID
	rR1kKHdA6N5R/zG8lknSubb5ZoAqxoipKAP4p4vWIWIdHPP+XPXQk3DN1IB+0mBU0DXnuvpUht9
	OLAj7CtRDis05ita4Mcb7/n/BYiIGGl8hggrl66iotYjZsYokR3Rcokd2C3psk6NQIw8HOu+Yco
	/b0vKOuQp3op/agDIqjUHpIZTXOfQ7Gqnm8GT3rG0fzbDuaRiNYl4ZwSwbMvmztKFjisIMPT9L6
	7OEuAUvB5g
X-Received: by 2002:a17:902:d58a:b0:2a0:f0e5:3f5c with SMTP id d9443c01a7336-2a9521f3f28mr22006825ad.34.1770369639836;
        Fri, 06 Feb 2026 01:20:39 -0800 (PST)
Received: from [0.0.0.0] ([188.253.4.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c50206sm17695615ad.19.2026.02.06.01.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 01:20:39 -0800 (PST)
Message-ID: <9fd7e5ce-a4ac-4354-93f2-8797bb1fb153@gmail.com>
Date: Fri, 6 Feb 2026 17:20:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Tao Chen <chen.dylane@linux.dev>
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
 <bb62bd4f-199e-4907-817f-bc820c9198c9@linux.dev>
 <CAEf4BzZun3amXMpYdBPEy=qZwrY3ZjrKf_qc6tG-b4NJ=-AC7w@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4BzZun3amXMpYdBPEy=qZwrY3ZjrKf_qc6tG-b4NJ=-AC7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2026/2/6 01:34, Andrii Nakryiko 写道:
> On Wed, Feb 4, 2026 at 10:16 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> 在 2026/2/4 09:08, Andrii Nakryiko 写道:
>>> On Sun, Jan 25, 2026 at 11:45 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>
>>>>   From BPF stack map, we want to ensure that the callchain buffer
>>>> will not be overwritten by other preemptive tasks and we also aim
>>>> to reduce the preempt disable interval, Based on the suggestions from Peter
>>>> and Andrrii, export new API __get_perf_callchain and the usage scenarios
>>>> are as follows from BPF side:
>>>>
>>>> preempt_disable()
>>>> entry = get_callchain_entry()
>>>> preempt_enable()
>>>> __get_perf_callchain(entry)
>>>> put_callchain_entry(entry)
>>>>
>>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>> ---
>>>>    include/linux/perf_event.h |  5 +++++
>>>>    kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
>>>>    2 files changed, 27 insertions(+), 12 deletions(-)
>>>>
>>>
>>> Looking at the whole __bpf_get_stack() logic again, why didn't we just
>>> do something like this:
>>>
>>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>>> index da3d328f5c15..80364561611c 100644
>>> --- a/kernel/bpf/stackmap.c
>>> +++ b/kernel/bpf/stackmap.c
>>> @@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
>>> struct task_struct *task,
>>>
>>>           max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
>>>
>>> -       if (may_fault)
>>> -               rcu_read_lock(); /* need RCU for perf's callchain below */
>>> +       if (!trace_in)
>>> +               preempt_disable();
>>>
>>>           if (trace_in) {
>>>                   trace = trace_in;
>>> @@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
>>> struct task_struct *task,
>>>           }
>>>
>>>           if (unlikely(!trace) || trace->nr < skip) {
>>> -               if (may_fault)
>>> -                       rcu_read_unlock();
>>> +               if (!trace_in)
>>> +                       preempt_enable();
>>>                   goto err_fault;
>>>           }
>>>
>>> @@ -494,8 +494,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
>>> struct task_struct *task,
>>>           }
>>>
>>>           /* trace/ips should not be dereferenced after this point */
>>> -       if (may_fault)
>>> -               rcu_read_unlock();
>>> +       if (!trace_in)
>>> +               preempt_enable();
>>>
>>>           if (user_build_id)
>>>                   stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
>>>
>>>
>>> ?
>>>
>>> Build ID parsing is happening after we copied data from perf's
>>> callchain_entry into user-provided memory, so raw callchain retrieval
>>> can be done with preemption disabled, as it's supposed to be brief.
>>> Build ID parsing part which indeed might fault and be much slower will
>>> be done well after that (we even have a comment there saying that
>>> trace/ips should not be touched).
>>>

Hi Andrii,

Building upon your work, I have also added preempt_disable() to 
bpf_get_stackid, and try to reduce the length of preempt section.
Please review, thanks.

https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev

>>> Am I missing something?
>>
>> Yes it looks good for bpf_get_stack, and I also proposed a similar
>> change previously. But Alexei suggested that we should reduce the
>> preemption-disabled section protected in bpf_get_stackid if we do like
>> bpf_get_stack. Maybe we can change it first for bpf_get_stack?
>>
>> https://lore.kernel.org/bpf/20250922075333.1452803-1-chen.dylane@linux.dev/
> 
> This is broken because we are still using trace after you re-enabled
> preemption. We need to keep preemption disabled until we copy captured
> stack trace data from ips into our own memory.
> 
>>
>>>
>>> [...]
>>
>>
>> --
>> Best Regards
>> Tao Chen
> 


-- 
Best Regards
Tao Chen
