Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463548834;
	Fri,  5 Sep 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038136; cv=none; b=OVyQRE7asWj0x/h3UuWePiV6ndCrKuvSp1X1f66ILhRVUcoYozSQ4l/ipVgElTtfEVNR2wRxrvHeYR3MqcD5mWyFCzPEzErwyaVehzXWzOu7S8bAZOa3LoZhAKJmTN6XSddyb6hWGJNsu3TuhdZIEnAmsDybvPwibGkJxcublZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038136; c=relaxed/simple;
	bh=z30VTZJ5aKaQiCOWOuSVwE2cczXit4k0uDhBjH6OYx8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Shq6l/6LCr7Qnu6tLNXyEFTOyIXsjbGciwSAvaE6vZjUx/ANvpjMqJyv5uvfvWai7rTBs5KkufLx4gHf1wXC7lMT6N5p1VUHmsC2KKXrjUQj6xRaONS/dxOMeWrQP8qZdkS2lEkXIKb1Wgzj+MqOgvFjxI76tx6jKhZ4nvnJqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP7QnnNl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP7QnnNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DB9C4CEF0;
	Fri,  5 Sep 2025 02:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757038135;
	bh=z30VTZJ5aKaQiCOWOuSVwE2cczXit4k0uDhBjH6OYx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fP7QnnNlx+Jndlhc2tLIADzpQBpZ7s/+vAn13jg7P4/3cOxIdTkVNfQDsysUd1tDH
	 BxKKYWI+Vn0UzJR6tQSSruGDdDkHOOuuWAvf1IBXPkbqBEm2BKN32nUWZBKppXbhdg
	 pHZct0qPLxzy/hDfGFyejgM1T0T/HEUeZq0HCPHLy5Yp3mMfFuX4I5qS160z8R8E6t
	 Urrq08xHiLHWc4A2sAdM2v8+etGgpffkcA7JNjAhU7fQydHPQwFO/Q0rGFry8qI8i6
	 lhxFvyz9UGS0Sc4pco8XpkRFAlXI7IGcVofIjjJOuubXHEsibWMdheHCPLOCke4NKv
	 qA2QBR1gNs4yA==
Date: Fri, 5 Sep 2025 11:08:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] tracing: wprobe: Add wprobe for watchpoint
Message-Id: <20250905110852.2c9a0be5f5e5338f1a00cdd4@kernel.org>
In-Reply-To: <c8a312e9-644a-45e0-8184-6eac8d8f4af1@gmail.com>
References: <175673787502.478080.3342912952394010967.stgit@devnote2>
	<20250902230204.f3e81b03e7f6805caba1b717@kernel.org>
	<c8a312e9-644a-45e0-8184-6eac8d8f4af1@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 14:35:33 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> On 9/2/25 22:02, Masami Hiramatsu (Google) wrote:
> > (Adding Jinchao)
> > 
> > On Mon,  1 Sep 2025 23:44:35 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> >> Hi,
> >>
> >> Here is an RFC series for adding new wprobe (watch probe) which
> >> provides memory access tracing event. Moreover, this can be used via
> >> event trigger. Thus it can trace memory access on a dynamically
> >> allocated objects too.
> > 
> > BTW, this series is on the top of probes/for-next branch in the
> > linux-trace tree.
> > 
> 
> Hi, Masami
> 
> Thanks for including me. I only received the cover letter, so I'm 
> providing my feedback here:

Thanks for your feedback! I'll send v2.

> 
> - trigger_data issue:
>    it appears that the instance being removed is not the same as
>    the one that was originally set.

Did you mean it will free invalid struct event_trigger_data by
wprobe_trigger_free(), or hw_breakpoint instance?

When trace_event_enable_disable(wprobe_data->file, 1, 1) at
wprobe_trigger_cmd_parse(), the trace_wprobe is enabled == call
enable_trace_wprobe(), which eventually call register_wide_hw_breakpoint()
with dummy address. IOW, the (wide)hw_breakpoint is allocated here.

When the trigger is hit, modify_wide_hw_breakpoint_local() is called
for updating local target address on the same hw_breakpoint.
So latter instance should be the same.

> 
>   - the function call issue:
>     `trace_wprobe_update_local()` is called twice, once in the trigger
>     callback and again in `wprobe_work_func`.

Yes, I found it can happen. Maybe I need a cpumask to skip the first one.

> I also noticed that the Watchpoint probe and KStackWatch implementations 
> share very similar logic for managing hardware breakpoints/watchpoints 
> (`hwbp/watch`):
> - `watch_init(unsigned long &place_holder)`
> - `watch_on(struct perf_event_attr *attr)`
> - `watch_off()` (or reset to the `place_holder` value)
> - `watch_uninit()`

Hmm, I agree that we are using hwbp in a similar way but
I think current interface is enough.

> 
> Their primary difference lies in their handler functions, specifically 
> the `perf_overflow_handler_t triggered` callback.
> 
> I believe we could work together to unify this logic. I am open to 
> either approach: I can refactor my watch.c, or you can introduce new 
> helpers. This would help us save duplicated work and review time.

I'm not sure what you mean. Is there any concern to use the same
(current hwbp) interfaces?

Thank you,

> 
> > Thanks,
> > 
> >>
> >> In this version, I reuse Jinchao's arch_reinstall_hw_breakpoint()
> >> patch[1].
> >>
> >> [1] https://lore.kernel.org/all/20250828073311.1116593-6-wangjinchao600@gmail.com/
> >>
> >> The basic usage of this wprobe is similar to other probes;
> >>
> >>    w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+OFFS]> [FETCHARGS]
> >>
> >> This defines a new wprobe event. For example, to trace jiffies update,
> >> you can do;
> >>
> >>   echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
> >>   echo 1 > events/wprobes/my_jiffies/enable
> >>
> >> Moreover, this can be combined with event trigger to trace the memory
> >> accecss on slab objects. The trigger syntax is;
> >>
> >>    set_wprobe:WPROBE_EVENT:FIELD[+ADJUST]
> >>    clear_wprobe:WPROBE_EVENT
> >>
> >> For example, trace the first 8 byte of the dentry data structure passed
> >> to do_truncate() until it is deleted by __dentry_kill().
> >> (Note: all tracefs setup uses '>>' so that it does not kick do_truncate())
> >>
> >>    # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events
> >>
> >>    # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
> >>    # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
> >>
> >>    # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
> >>    # echo 'clear_wprobe:watch' >> events/fprobes/dentry_kill/trigger
> >>
> >>    # echo 1 >> events/fprobes/truncate/enable
> >>    # echo 1 >> events/fprobes/dentry_kill/enable
> >>
> >>    # echo aaa > /tmp/hoge
> >>    # echo bbb > /tmp/hoge
> >>    # echo ccc > /tmp/hoge
> >>    # rm /tmp/hoge
> >>
> >> Then, the trace data will show;
> >>
> >> # tracer: nop
> >> #
> >> # entries-in-buffer/entries-written: 16/16   #P:8
> >> #
> >> #                                _-----=> irqs-off/BH-disabled
> >> #                               / _----=> need-resched
> >> #                              | / _---=> hardirq/softirq
> >> #                              || / _--=> preempt-depth
> >> #                              ||| / _-=> migrate-disable
> >> #                              |||| /     delay
> >> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> >> #    [    7.026136] sh (113) used greatest stack depth: 12912 bytes left
> >>            | |         |   |||||     |         |
> >>                sh-113     [002] .....     7.024402: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
> >>                sh-113     [002] ..Zff     7.024822: watch: (lookup_fast+0xaa/0x150) address=0xffff8880069194b8 value=0x200008
> >>                sh-113     [002] ..Zff     7.024830: watch: (step_into+0x82/0x360) address=0xffff8880069194b8 value=0x200008
> >>                sh-113     [002] ..Zff     7.024834: watch: (step_into+0x9f/0x360) address=0xffff8880069194b8 value=0x200008
> >>                sh-113     [002] ..Zff     7.024839: watch: (path_openat+0xb3a/0xe70) address=0xffff8880069194b8 value=0x200008
> >>                sh-113     [002] ..Zff     7.024843: watch: (path_openat+0xb9a/0xe70) address=0xffff8880069194b8 value=0x200008
> >>                sh-113     [002] .....     7.024847: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880069194b8
> >>                sh-113     [002] ...1.     7.025364: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888006919380
> >>                sh-113     [002] ...1.     7.025511: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069195f0
> >>                rm-118     [003] ...1.     7.027543: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880069194b8
> >>                sh-113     [002] ...2.     7.027825: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044429c0
> >>                sh-113     [002] ...2.     7.027833: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888004442270
> >>
> >>
> >> Thank you,
> >>
> >> ---
> >>
> >> Jinchao Wang (1):
> >>        x86/HWBP: introduce arch_reinstall_hw_breakpoint() for atomic context
> >>
> >> Masami Hiramatsu (Google) (5):
> >>        tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
> >>        HWBP: Add modify_wide_hw_breakpoint_local() API
> >>        tracing: wprobe: Add wprobe event trigger
> >>        selftests: tracing: Add a basic testcase for wprobe
> >>        selftests: tracing: Add syntax testcase for wprobe
> >>
> >>
> >>   Documentation/trace/index.rst                      |    1
> >>   Documentation/trace/wprobetrace.rst                |  129 ++
> >>   arch/Kconfig                                       |   10
> >>   arch/x86/Kconfig                                   |    1
> >>   arch/x86/include/asm/hw_breakpoint.h               |    3
> >>   arch/x86/kernel/hw_breakpoint.c                    |   61 +
> >>   include/linux/hw_breakpoint.h                      |    6
> >>   include/linux/trace_events.h                       |    3
> >>   kernel/events/hw_breakpoint.c                      |   36 +
> >>   kernel/trace/Kconfig                               |   24
> >>   kernel/trace/Makefile                              |    1
> >>   kernel/trace/trace.c                               |    9
> >>   kernel/trace/trace.h                               |    5
> >>   kernel/trace/trace_probe.c                         |   20
> >>   kernel/trace/trace_probe.h                         |    8
> >>   kernel/trace/trace_wprobe.c                        | 1111 ++++++++++++++++++++
> >>   .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   68 +
> >>   .../test.d/dynevent/wprobes_syntax_errors.tc       |   20
> >>   18 files changed, 1513 insertions(+), 3 deletions(-)
> >>   create mode 100644 Documentation/trace/wprobetrace.rst
> >>   create mode 100644 kernel/trace/trace_wprobe.c
> >>   create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
> >>   create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
> >>
> >> --
> >> Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > 
> 
> 
> -- 
> Best regards,
> Jinchao


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
