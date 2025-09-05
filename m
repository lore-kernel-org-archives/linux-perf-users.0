Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C8289824;
	Fri,  5 Sep 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062955; cv=none; b=FZd06XvJl3Mxf1g1Qs7W60x1aIuRcJWkqgGLXUtQhHZuoO/ZJDyVvwyebVOfzjumNeO3n3AIt2cG4QCPUKr7+z7RynHrnU4kvUGxoAagOikFbmRoGHBCixYnynvUbvIilogrTb2P7JfcrI+qkSgUXR1z9ttpBm7cCtJYkotlv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062955; c=relaxed/simple;
	bh=NM4vh7Y6amQgjxH0/DqheIDPbYhjnlxQF3rh5Z5U7/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYs7pbaKeJ/fPVPPaXW5tC1yq4CPW4IpY9aOwAxgFRn2teIY1ZJpORtAp8g7YvjvOBpe3Zc7cggwQCsv5pu7kn13PEvtlxfrTcOmgsuT/OXWZ8Qc7k+iMCSUBXNCfxqt8gV6dC7G9uHlOlmccai4sTFg9Ppqm6bLLfmJeR9TRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkc/llix; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkc/llix"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7725de6b57dso2261321b3a.0;
        Fri, 05 Sep 2025 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757062952; x=1757667752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbWJrrsJi1lQoWWgSTtwrCIE35YEtTJx5WTUVLvwNGE=;
        b=Dkc/llix3jvnD875YFbd3YQ+1Bx/NzCF7N8eF3Fq4QteU0WCv2CVEaHvwr7D5gJfkf
         kcZmlig60E1gqjHkojD7DGHvy5QUXrMHodAFlto78Z2NY1pyJOyURe5N+Dg4eeb/pwxB
         TDz0ycefeoPKPpZCX5v1qv8jDbYQhqxPS5oSWlDbVY5Zw5IJQAOq6xBGUHdd7dUA7IB1
         t9GT3TJKYhEsoS1HIH/FSFlOuGtDgd04xiRVIz5P9VaPx6RWBJcuP9ie78pHfuS40oqA
         6UpobAzhwGojDSwhWa4Zrm4lGcWRuhsOjzSk6xb86gDmv6091GsTD6wivzjMIAZ9xp2X
         +Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062952; x=1757667752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbWJrrsJi1lQoWWgSTtwrCIE35YEtTJx5WTUVLvwNGE=;
        b=iGhOknWxbQXzxKuvNThmRbiZ9KGTgMwnNOisGA/+RjOkxNat8MmcMLXxOm+haHzK9D
         2ZVzexjv2+sabE2mJG/w8O53iX0zf3mXp7/iUoz/UoGYjGeEfGna1LtjK+H7DklQLJtt
         Nov4Zo34+OCNZls/6P5OMPJgNhhADgrqI5oCJ0xY1+eY7CqhzekICTeddXm+ENOWvtEv
         uoc4j7gneWByRcp21HTpfv0T+wtyK1MaEaeS63s3H6jY/CpoOSW/Tz1XLmzqOyS+SWK3
         jAlgdndCC/+/pWzpgR1ojj4YCbXJh7x6J753HaauxOC3AxjnRjkzbFzlbp2dkaKr3sa/
         Kygg==
X-Forwarded-Encrypted: i=1; AJvYcCUMegcuZ4gbc+wkmYt14ORgeALSP8nhYBoj+F9y22t5GN78jrFK5Lj943ibwS8MPV8O0ExrJanxwheeRuvj@vger.kernel.org, AJvYcCWEu/a5WdLW7XBJ8suEbdcXsETw/WyyDTzuuC4n+dC0BJVlRqLpQUnkoT9oxXTMwpOfZoXUKawrMJ+NGccPkzBw0K4y@vger.kernel.org, AJvYcCWMiLxueWBBznIVc2rx9+bmcrqQKILAPvVsSOVs7k+z7etTdPBmWpyo5eaOr87UE18FLM8rVjkFsCE=@vger.kernel.org, AJvYcCWYawRfw3B7A1EvPPdj8zDqD4wMMgKKw8CfhIzh+v3elZO+YBzN3MP/SmxIS5oqoqwxUgasGG3Xxb4Q+iXsbze/lA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4EvvaMxrMtGQSItraHFK2ytHE0AJwsXEIrCud2w0GxAWNVtyu
	UbR693MBZS8GbS+3YbZBNYykqDPy7Q2nj8K1M+jeiDCBZnJcM506tqrh
X-Gm-Gg: ASbGncsqBjdCCg5Fdpve7aH8lMTquMvPHc9OSgaAGWP8bkvvp+oBRiUksdw3YGm5bpx
	SrtAc5ZmYbuDnvDwHDZm6qp1SaPdukupX16mEHLEB9dLnpWyEmih6c/D3uzAQGkGYNNAu62a6b5
	0Jijp2K4sUGCGXukuLMxf8C2SEnZ3AUvUOJfOPK8YhRed+QNhvY1hMjWXfWREvyuo3ZWuMMX9OI
	83Ol1sL+4uF4JH6t/LSrNLpdTaB70jf2A807F2O1cZH7G3YZmRpKSOhtjB8dWh7o8xCOWpyv0a1
	VyFD4c/KKDRXQG8yKKrzbE9hSePO5C8JiWAXwT9rJLMlXXZeB0VCZtl+zyY22jSdPftoZZQXBE9
	/ts3zZmDdMDUpVth/NhylfUacLe8hb0OcmIGx
X-Google-Smtp-Source: AGHT+IGPJDd0ZbcKmwOmMjvq98qz8SQzZoZzRttT4FvuKGdN6vETbbaK8w6DZAAbiwn1p8ByUXjIUA==
X-Received: by 2002:a05:6a00:1495:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-7723e36282amr26130625b3a.15.1757062952047;
        Fri, 05 Sep 2025 02:02:32 -0700 (PDT)
Received: from [127.0.0.1] ([2604:a840:3::10f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2af911sm21018350b3a.23.2025.09.05.02.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 02:02:31 -0700 (PDT)
Message-ID: <bab08c27-cf0a-445e-8071-dac2a0f8c6d1@gmail.com>
Date: Fri, 5 Sep 2025 17:02:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] tracing: wprobe: Add wprobe for watchpoint
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <175673787502.478080.3342912952394010967.stgit@devnote2>
 <20250902230204.f3e81b03e7f6805caba1b717@kernel.org>
 <c8a312e9-644a-45e0-8184-6eac8d8f4af1@gmail.com>
 <20250905110852.2c9a0be5f5e5338f1a00cdd4@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250905110852.2c9a0be5f5e5338f1a00cdd4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 10:08, Masami Hiramatsu (Google) wrote:
> On Thu, 4 Sep 2025 14:35:33 +0800
> Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
>> On 9/2/25 22:02, Masami Hiramatsu (Google) wrote:
>>> (Adding Jinchao)
>>>
>>> On Mon,  1 Sep 2025 23:44:35 +0900
>>> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
>>>
>>>> Hi,
>>>>
>>>> Here is an RFC series for adding new wprobe (watch probe) which
>>>> provides memory access tracing event. Moreover, this can be used via
>>>> event trigger. Thus it can trace memory access on a dynamically
>>>> allocated objects too.
>>>
>>> BTW, this series is on the top of probes/for-next branch in the
>>> linux-trace tree.
>>>
>>
>> Hi, Masami
>>
>> Thanks for including me. I only received the cover letter, so I'm
>> providing my feedback here:
> 
> Thanks for your feedback! I'll send v2.
> 
>>
>> - trigger_data issue:
>>     it appears that the instance being removed is not the same as
>>     the one that was originally set.
> 
> Did you mean it will free invalid struct event_trigger_data by
> wprobe_trigger_free(), or hw_breakpoint instance?
> 
> When trace_event_enable_disable(wprobe_data->file, 1, 1) at
> wprobe_trigger_cmd_parse(), the trace_wprobe is enabled == call
> enable_trace_wprobe(), which eventually call register_wide_hw_breakpoint()
> with dummy address. IOW, the (wide)hw_breakpoint is allocated here.
> 
> When the trigger is hit, modify_wide_hw_breakpoint_local() is called
> for updating local target address on the same hw_breakpoint.
> So latter instance should be the same.
In wprobe_trigger_cmd_parse(), consider removing:
   echo '!set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
The trigger_data passed to event_trigger_unregister() is freshly allocated.
> 
>>
>>    - the function call issue:
>>      `trace_wprobe_update_local()` is called twice, once in the trigger
>>      callback and again in `wprobe_work_func`.
> 
> Yes, I found it can happen. Maybe I need a cpumask to skip the first one.
> 
>> I also noticed that the Watchpoint probe and KStackWatch implementations
>> share very similar logic for managing hardware breakpoints/watchpoints
>> (`hwbp/watch`):
>> - `watch_init(unsigned long &place_holder)`
>> - `watch_on(struct perf_event_attr *attr)`
>> - `watch_off()` (or reset to the `place_holder` value)
>> - `watch_uninit()`
> 
> Hmm, I agree that we are using hwbp in a similar way but
> I think current interface is enough.
> 
>>
>> Their primary difference lies in their handler functions, specifically
>> the `perf_overflow_handler_t triggered` callback.
>>
>> I believe we could work together to unify this logic. I am open to
>> either approach: I can refactor my watch.c, or you can introduce new
>> helpers. This would help us save duplicated work and review time.
> 
> I'm not sure what you mean. Is there any concern to use the same
> (current hwbp) interfaces?
> 
It is not the _current_ HWBP interface, it needs review. We will write
the same logic except for the HWBP interface regarding atomic context
watch switch (addr/type/len) and the process to sync with other CPUs.

The only difference is the HWBP handler.

I am not familiar with the process of how we usually do roughly the
same thing. Maybe I am thinking about it the wrong way; I will look
at it later. > Thank you,
> 
>>
>>> Thanks,
>>>
>>>>
>>>> In this version, I reuse Jinchao's arch_reinstall_hw_breakpoint()
>>>> patch[1].
>>>>
>>>> [1] https://lore.kernel.org/all/20250828073311.1116593-6-wangjinchao600@gmail.com/
>>>>
>>>> The basic usage of this wprobe is similar to other probes;
>>>>
>>>>     w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+OFFS]> [FETCHARGS]
>>>>
>>>> This defines a new wprobe event. For example, to trace jiffies update,
>>>> you can do;
>>>>
>>>>    echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
>>>>    echo 1 > events/wprobes/my_jiffies/enable
>>>>
>>>> Moreover, this can be combined with event trigger to trace the memory
>>>> accecss on slab objects. The trigger syntax is;
>>>>
>>>>     set_wprobe:WPROBE_EVENT:FIELD[+ADJUST]
>>>>     clear_wprobe:WPROBE_EVENT
>>>>
>>>> For example, trace the first 8 byte of the dentry data structure passed
>>>> to do_truncate() until it is deleted by __dentry_kill().
>>>> (Note: all tracefs setup uses '>>' so that it does not kick do_truncate())
>>>>
>>>>     # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events
>>>>
>>>>     # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
>>>>     # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
>>>>
>>>>     # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
>>>>     # echo 'clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger
>>>>
>>>>     # echo 1 >> events/fprobes/truncate/enable
>>>>     # echo 1 >> events/fprobes/dentry_kill/enable
>>>>
>>>>     # echo aaa > /tmp/hoge
>>>>     # echo bbb > /tmp/hoge
>>>>     # echo ccc > /tmp/hoge
>>>>     # rm /tmp/hoge
>>>>
>>>> Then, the trace data will show;
>>>>
>>>> # tracer: nop
>>>> #
>>>> # entries-in-buffer/entries-written: 16/16   #P:8
>>>> #
>>>> #                                _-----=> irqs-off/BH-disabled
>>>> #                               / _----=> need-resched
>>>> #                              | / _---=> hardirq/softirq
>>>> #                              || / _--=> preempt-depth
>>>> #                              ||| / _-=> migrate-disable
>>>> #                              |||| /     delay
>>>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>> #    [    7.026136] sh (113) used greatest stack depth: 12912 bytes left
>>>>             | |         |   |||||     |         |
>>>>                 sh-113     [002] .....     7.024402: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
>>>>                 sh-113     [002] ..Zff     7.024822: watch: (lookup_fast+0xaa/0x150) address=0xffff8880069194b8 value=0x200008
>>>>                 sh-113     [002] ..Zff     7.024830: watch: (step_into+0x82/0x360) address=0xffff8880069194b8 value=0x200008
>>>>                 sh-113     [002] ..Zff     7.024834: watch: (step_into+0x9f/0x360) address=0xffff8880069194b8 value=0x200008
>>>>                 sh-113     [002] ..Zff     7.024839: watch: (path_openat+0xb3a/0xe70) address=0xffff8880069194b8 value=0x200008
>>>>                 sh-113     [002] ..Zff     7.024843: watch: (path_openat+0xb9a/0xe70) address=0xffff8880069194b8 value=0x200008
>>>>                 sh-113     [002] .....     7.024847: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
>>>>                 sh-113     [002] ...1.     7.025364: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888006919380
>>>>                 sh-113     [002] ...1.     7.025511: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069195f0
>>>>                 rm-118     [003] ...1.     7.027543: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069194b8
>>>>                 sh-113     [002] ...2.     7.027825: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044429c0
>>>>                 sh-113     [002] ...2.     7.027833: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888004442270
>>>>
>>>>
>>>> Thank you,
>>>>
>>>> ---
>>>>
>>>> Jinchao Wang (1):
>>>>         x86/HWBP: introduce arch_reinstall_hw_breakpoint() for atomic context
>>>>
>>>> Masami Hiramatsu (Google) (5):
>>>>         tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
>>>>         HWBP: Add modify_wide_hw_breakpoint_local() API
>>>>         tracing: wprobe: Add wprobe event trigger
>>>>         selftests: tracing: Add a basic testcase for wprobe
>>>>         selftests: tracing: Add syntax testcase for wprobe
>>>>
>>>>
>>>>    Documentation/trace/index.rst                      |    1
>>>>    Documentation/trace/wprobetrace.rst                |  129 ++
>>>>    arch/Kconfig                                       |   10
>>>>    arch/x86/Kconfig                                   |    1
>>>>    arch/x86/include/asm/hw_breakpoint.h               |    3
>>>>    arch/x86/kernel/hw_breakpoint.c                    |   61 +
>>>>    include/linux/hw_breakpoint.h                      |    6
>>>>    include/linux/trace_events.h                       |    3
>>>>    kernel/events/hw_breakpoint.c                      |   36 +
>>>>    kernel/trace/Kconfig                               |   24
>>>>    kernel/trace/Makefile                              |    1
>>>>    kernel/trace/trace.c                               |    9
>>>>    kernel/trace/trace.h                               |    5
>>>>    kernel/trace/trace_probe.c                         |   20
>>>>    kernel/trace/trace_probe.h                         |    8
>>>>    kernel/trace/trace_wprobe.c                        | 1111 ++++++++++++++++++++
>>>>    .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   68 +
>>>>    .../test.d/dynevent/wprobes_syntax_errors.tc       |   20
>>>>    18 files changed, 1513 insertions(+), 3 deletions(-)
>>>>    create mode 100644 Documentation/trace/wprobetrace.rst
>>>>    create mode 100644 kernel/trace/trace_wprobe.c
>>>>    create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
>>>>    create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
>>>>
>>>> --
>>>> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>>
>>
>>
>> -- 
>> Best regards,
>> Jinchao
> 
> 


-- 
Best regards,
Jinchao
