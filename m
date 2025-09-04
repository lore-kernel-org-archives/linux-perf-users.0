Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F742750E1;
	Thu,  4 Sep 2025 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967743; cv=none; b=TqdfpztQJSIXKOYOcAbbDnUszOBp3Rmnctw3O8YuZibRgdYQtnntHsvfWZ8uUaWgy3U8tnJK4LoFri5ShjeVlx+hXheGBHzNmgA3zBm/qzivyoGz/PYWplVSgfNipgecEgGwGHF8EuIyuxSNsbAJ7ZPJ5GmDlC8aEO1Z3XnV87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967743; c=relaxed/simple;
	bh=FjQXXChF1UqOy7FKRSQjGWQ/hIkkXKXQmcLrd7YhGs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuPWZJtBhCzpWtuABuGsvY2OHFMiEE/wnVfIl2EzhsxJGHPCpxXk2pvPBywV3onay0a9R+gVsX3lG/nuV2QKID4Itnekb+ZmHg6+1pwMhRP2wtpk/E6JOFWxvBR/U+KnAV3dx9fDKDEFotTaajxjY+I4vle2+cJGWizEAZXzxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex3ajPSz; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex3ajPSz"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-724b9ba77d5so8088997b3.3;
        Wed, 03 Sep 2025 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756967740; x=1757572540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvHhcp83qsBQuM6ySHCTxjF66qQvhHoowgPPy8cRsQY=;
        b=Ex3ajPSzUGl9LunxeNMLUIVE5p75r3KpPOBVJ79AXR4W6sJAoNt3vgHyLrjruACrRl
         KDtI60EThbhmpq2fpaGa1F8bZG07QK7EIViFM0bhI3A0YsUJ2X5Xu/NwhYsRnHL4i8OH
         /4Lb2p83OAigGCeuw8T1AbQ/miG1AhIQPQJVPfeISkRdbec1DOLZUA4EDp09GCHp+nv5
         s7IAxi7vjUvouIRlJhCuiSjZ0VytczNUBptz/D8wZKwZyjpx1fF7l5ZfK5HeaLmop4SF
         qioYQTh37w8wTWCaWk1QGWL8Ywfbihy9ANS7eHGh7KKpY7LN8YeiNavgTeqm9CKcu07k
         bp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967740; x=1757572540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvHhcp83qsBQuM6ySHCTxjF66qQvhHoowgPPy8cRsQY=;
        b=R62R7qdaeCrWEEhlKEkVClw4tGBlZhfHRb+7HBSVukFwZ0LPtNPZ6yPFjND4XmsBCJ
         sMCo9OvV2WiXcVsTJQBXW1WfFjadJQ/qTSc3SCdNE9JoDj2XuOmi+WfOpepFMbAAR/vq
         mbaPHxNhH7oBPHxlMpmQ1uWUtkwIQYz4XE7m96ZUIKeSaHVUAEOmeBbVoXQsxuCn+d0N
         9IQuRm7gbWDDGb9lkcNBvCG0/n5u1qtgLxlqC1b94y19zetGbON95dAk8bI5dJWv+PQC
         fR3r+rQK0kuUeahb6+rKqXOV+OkUxDPpEVWXuHRt9xWZNYlu23nnmON7goytD6mEqFvt
         36ow==
X-Forwarded-Encrypted: i=1; AJvYcCUo/R63ufjCEAcFXqfKVkWhnvHMFWv2zpDhje79zpbkaszPkQedaTVcidDc5oVMfzr4kLlWCx0vwkA=@vger.kernel.org, AJvYcCUrHn2v/BMY8enCZ1C3OTit5iiqhyXHDw787zy/dNfvLoDKUSlAkuK5yhqrn7E4nL/hv3nrsEjKO+q8lP1Q@vger.kernel.org, AJvYcCUt+U9HHjNtG7Div+mCCW2L7rYoZ/ykLSwmAifSzmBiGwj0LyQBGw1tBu7efkNrdZupgaO23r/O7mjiW/xgqzzrg8aB@vger.kernel.org, AJvYcCXvr01Bbn3f2s08atPLRFCuDQE/SOp4WwSBDCCh/YbPmMCbTxAYQJP6VogiCjhrRDqni0putGIIqP3uXmxUGewmrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBY70SVK8Oem8KskDkcezhY9ihGDyBW6eFiqS/1x5OGOImsn7p
	l7lUW1WkBFx1UQVjRCshK4YYtZWuwMzc368P+7ocLxt/5QS8E+etQHkCaQJaic82hzcZKw==
X-Gm-Gg: ASbGncvaLVNQ9U1gT0v4oVscIwwxsU8gEzfSABynnQGX1hEQd/vyfH+dGTPBmVxPyYp
	J37Md/uIy7hyzMv5/XUU1R526z8Cm5myc4G8e3kV+YmLCk57ck6DCYITUnpQIMtBIWqWL/FRG1r
	BXP6dEuLOhJQ9cXyHoPHqbmapiSeanxonIaGv044xROM84wYONVMlf58ywMWadEmIe0QPGrOjC5
	1D+a3ZGOsAXT3N1qUU/IXwrie0AxbJOBLaJCygOhJHI2aglsL4h2UZZZdMiBC6l+p2vELN7iNEf
	fKX0g6ZZT9I/HvTlIWD31cEGQP1IMUONXhPyFtYtEt5fCjk3NaJhXLFqMQHYhVvD1/PcQpeAvR0
	j/eKQo/MNQCUu8Jt24NqD256iL91ywg==
X-Google-Smtp-Source: AGHT+IGgecQvCGBex5+3I/10iJMKBk/eFdZyo6YsgGfzzsbsYSr06jzNjj+3YbrxoGZBlyvsgEyYmQ==
X-Received: by 2002:a05:690c:6f0f:b0:71b:d6a0:9771 with SMTP id 00721157ae682-722764052d2mr219807807b3.20.1756967740504;
        Wed, 03 Sep 2025 23:35:40 -0700 (PDT)
Received: from [127.0.0.1] ([2a12:a301:1000::20f3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a82d94b4sm19469427b3.6.2025.09.03.23.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 23:35:40 -0700 (PDT)
Message-ID: <c8a312e9-644a-45e0-8184-6eac8d8f4af1@gmail.com>
Date: Thu, 4 Sep 2025 14:35:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] tracing: wprobe: Add wprobe for watchpoint
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
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <20250902230204.f3e81b03e7f6805caba1b717@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 22:02, Masami Hiramatsu (Google) wrote:
> (Adding Jinchao)
> 
> On Mon,  1 Sep 2025 23:44:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> Hi,
>>
>> Here is an RFC series for adding new wprobe (watch probe) which
>> provides memory access tracing event. Moreover, this can be used via
>> event trigger. Thus it can trace memory access on a dynamically
>> allocated objects too.
> 
> BTW, this series is on the top of probes/for-next branch in the
> linux-trace tree.
> 

Hi, Masami

Thanks for including me. I only received the cover letter, so I'm 
providing my feedback here:

- trigger_data issue:
   it appears that the instance being removed is not the same as
   the one that was originally set.

  - the function call issue:
    `trace_wprobe_update_local()` is called twice, once in the trigger
    callback and again in `wprobe_work_func`.


I also noticed that the Watchpoint probe and KStackWatch implementations 
share very similar logic for managing hardware breakpoints/watchpoints 
(`hwbp/watch`):
- `watch_init(unsigned long &place_holder)`
- `watch_on(struct perf_event_attr *attr)`
- `watch_off()` (or reset to the `place_holder` value)
- `watch_uninit()`

Their primary difference lies in their handler functions, specifically 
the `perf_overflow_handler_t triggered` callback.

I believe we could work together to unify this logic. I am open to 
either approach: I can refactor my watch.c, or you can introduce new 
helpers. This would help us save duplicated work and review time.

> Thanks,
> 
>>
>> In this version, I reuse Jinchao's arch_reinstall_hw_breakpoint()
>> patch[1].
>>
>> [1] https://lore.kernel.org/all/20250828073311.1116593-6-wangjinchao600@gmail.com/
>>
>> The basic usage of this wprobe is similar to other probes;
>>
>>    w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+OFFS]> [FETCHARGS]
>>
>> This defines a new wprobe event. For example, to trace jiffies update,
>> you can do;
>>
>>   echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
>>   echo 1 > events/wprobes/my_jiffies/enable
>>
>> Moreover, this can be combined with event trigger to trace the memory
>> accecss on slab objects. The trigger syntax is;
>>
>>    set_wprobe:WPROBE_EVENT:FIELD[+ADJUST]
>>    clear_wprobe:WPROBE_EVENT
>>
>> For example, trace the first 8 byte of the dentry data structure passed
>> to do_truncate() until it is deleted by __dentry_kill().
>> (Note: all tracefs setup uses '>>' so that it does not kick do_truncate())
>>
>>    # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events
>>
>>    # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
>>    # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
>>
>>    # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
>>    # echo 'clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger
>>
>>    # echo 1 >> events/fprobes/truncate/enable
>>    # echo 1 >> events/fprobes/dentry_kill/enable
>>
>>    # echo aaa > /tmp/hoge
>>    # echo bbb > /tmp/hoge
>>    # echo ccc > /tmp/hoge
>>    # rm /tmp/hoge
>>
>> Then, the trace data will show;
>>
>> # tracer: nop
>> #
>> # entries-in-buffer/entries-written: 16/16   #P:8
>> #
>> #                                _-----=> irqs-off/BH-disabled
>> #                               / _----=> need-resched
>> #                              | / _---=> hardirq/softirq
>> #                              || / _--=> preempt-depth
>> #                              ||| / _-=> migrate-disable
>> #                              |||| /     delay
>> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>> #    [    7.026136] sh (113) used greatest stack depth: 12912 bytes left
>>            | |         |   |||||     |         |
>>                sh-113     [002] .....     7.024402: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
>>                sh-113     [002] ..Zff     7.024822: watch: (lookup_fast+0xaa/0x150) address=0xffff8880069194b8 value=0x200008
>>                sh-113     [002] ..Zff     7.024830: watch: (step_into+0x82/0x360) address=0xffff8880069194b8 value=0x200008
>>                sh-113     [002] ..Zff     7.024834: watch: (step_into+0x9f/0x360) address=0xffff8880069194b8 value=0x200008
>>                sh-113     [002] ..Zff     7.024839: watch: (path_openat+0xb3a/0xe70) address=0xffff8880069194b8 value=0x200008
>>                sh-113     [002] ..Zff     7.024843: watch: (path_openat+0xb9a/0xe70) address=0xffff8880069194b8 value=0x200008
>>                sh-113     [002] .....     7.024847: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
>>                sh-113     [002] ...1.     7.025364: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888006919380
>>                sh-113     [002] ...1.     7.025511: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069195f0
>>                rm-118     [003] ...1.     7.027543: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069194b8
>>                sh-113     [002] ...2.     7.027825: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044429c0
>>                sh-113     [002] ...2.     7.027833: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888004442270
>>
>>
>> Thank you,
>>
>> ---
>>
>> Jinchao Wang (1):
>>        x86/HWBP: introduce arch_reinstall_hw_breakpoint() for atomic context
>>
>> Masami Hiramatsu (Google) (5):
>>        tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
>>        HWBP: Add modify_wide_hw_breakpoint_local() API
>>        tracing: wprobe: Add wprobe event trigger
>>        selftests: tracing: Add a basic testcase for wprobe
>>        selftests: tracing: Add syntax testcase for wprobe
>>
>>
>>   Documentation/trace/index.rst                      |    1
>>   Documentation/trace/wprobetrace.rst                |  129 ++
>>   arch/Kconfig                                       |   10
>>   arch/x86/Kconfig                                   |    1
>>   arch/x86/include/asm/hw_breakpoint.h               |    3
>>   arch/x86/kernel/hw_breakpoint.c                    |   61 +
>>   include/linux/hw_breakpoint.h                      |    6
>>   include/linux/trace_events.h                       |    3
>>   kernel/events/hw_breakpoint.c                      |   36 +
>>   kernel/trace/Kconfig                               |   24
>>   kernel/trace/Makefile                              |    1
>>   kernel/trace/trace.c                               |    9
>>   kernel/trace/trace.h                               |    5
>>   kernel/trace/trace_probe.c                         |   20
>>   kernel/trace/trace_probe.h                         |    8
>>   kernel/trace/trace_wprobe.c                        | 1111 ++++++++++++++++++++
>>   .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   68 +
>>   .../test.d/dynevent/wprobes_syntax_errors.tc       |   20
>>   18 files changed, 1513 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/trace/wprobetrace.rst
>>   create mode 100644 kernel/trace/trace_wprobe.c
>>   create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
>>   create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
>>
>> --
>> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 


-- 
Best regards,
Jinchao
