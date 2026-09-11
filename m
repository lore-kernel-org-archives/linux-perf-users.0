Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28133C0A02
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111675; cv=none; b=gYUYl10MwThXHtqfc672IzpYNKfEQnPHWdw0zru6Wi0FTCUo+ijYkQ+JnsYPCztMCO8lxmli2sYc+MJFKab+hgDA6loy7x0p+GuKhNnmY6XAh5BZAj0JLJiJOnpPaqxErFRGddbjzH3/miLd0BVLWzSNbxaHRudUha22fiucbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111675; c=relaxed/simple;
	bh=tlKXicP68mvDD8epUYHfxWJsPL4pCrrhzzFZISH5/wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A827jt7P4UuHWrCaxk8PfDjrx/xHDsx+nOVyud/h9DpUfDYWLFTnb+Qf3bSFsN1xfc5VimhT+d1ALhn87xiDY/U+odYZ0lpB3fNMXzq8IhwVObvEQ9DOkASt4gJVovdZ9tG1p4+62P4aQaleAsVHzNhRtrt0kHb94l69DoEBf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVnA8FMY; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVnA8FMY"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c2c368cb3bso471964b6e.3
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789111672; x=1789716472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sk5Zw3zB+tKbZjukRzXRoZkYqPkXDjjNC32OYp6g6yE=;
        b=XVnA8FMYbWFYOxFm+mNVfsi1dQ7KcFLqtPj7UtFP82K09HftBoXskkWslAB9oxVAsl
         34LiYvsy5RyRga900ujMq9umJOKNKlfm14tj2UuVLmhqqu0v6GGGwX+2b4LaGqhuyr/X
         NKFGfoBdaCeDE4E1OZ4O0hJNzeX1WXVjKCLKtbaylZAGLWrLKVtBlm/Qx8fIoWLNv66D
         AoqtzB2LezQ7oS3b0O8mty/Oknsr/uuqry+h9Lu+I+CCzBAb0UBjoRUEAx5uffDQ1Agn
         wi30WjokuDm6HyDuebAEqac3V2l0Ly6yPgTfIgXlJodEJ06kAH+86tS6lrOPrRhqjBSt
         D6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789111672; x=1789716472;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sk5Zw3zB+tKbZjukRzXRoZkYqPkXDjjNC32OYp6g6yE=;
        b=kdd4JQZqTnMtq2pR+Jpbhigyv6N2Zu/G9BPiSv4uxpN6NkObHvK6mnmhH1La6fPKrN
         a/emm1Qc928FKa1cnN3zOrJPwcqLtQdSKIHtftwACFAQRe4bVxwdoAjBDLMQEjZVAkYL
         xVNKqNvVBQnds2GeoXZNqlkwlB8ZJ9mRVxFzfUqgsr2SVDKTxh7mRvsHP3FQMAFdac7N
         AJ8HZ3PwlO5AYW/tSrrM/6vLb/mb3SfjQKgmEx3BIfYm0m8dFxNTFuWRJWi4j6frsD25
         kbbYWa3VdPit3NVhqe0mQ+ptdftA9/kf1TRMycx03vi5xmBY91LOVMEtHXe+MDkGhDeq
         ha0A==
X-Forwarded-Encrypted: i=1; AKwUvBx+7GPkLlg63wkf/ND6aiOPBoNtKO+T+fjsj7TnrMNDMK/jAjfoAuaeQ1bIprnTSFkCJ2mhsLZK8LLDhY5p/QpQ@vger.kernel.org
X-Gm-Message-State: AFuF++ksAq9Rf6eK0FSeOq7rqXWjlOTneEIv+WzQdsZo4m1xMgxTMxW+
	WSB4T/O6knlzhhcMW6ctdbN5Vi4OynwzdxOpYngw9ZtDWZDzR1ZRMDmd
X-Gm-Gg: AYBFou2uNBA7fjEq/5yPtMhsQttHqGpyozYiPeLIY4c65uyt6VW+sor+6wQ0SPCBriN
	yd20alVwSr5I82CP5a/kQ2vq3hC95kMtTLIi1CrRxq7OLb5vKvZy4JyX69IaHDHOgCzHfhdTWxH
	zQiM3nq/MNrNMLBNPBpL3tEp5zFI6oUmMjSGLExwIUpJ3bl4dkO5nZ31kDqNT9QIMd6M0v8Hc05
	ZvwCFyzKSF6npTc6kO/vptUJDLUyEo89phlGdDffsFDPTIHDxhNCx4obPxh+6AwWn18j9Xl30Nk
	gKbLNCT3CZ0N7eB5CfYSRluqdPpMmXl4tXluXoNNYR10SSXbx5U8tDa+6YPPJiLmC+2V1CnD+1T
	6zXHBydbn85jz0zfIdopEqsQijxW0LLzBkqTWRsl6zWQRVfn8tbWo6CVxIIX47C5TqPMYxDApcm
	Jz4a5RPTeDuhx89F5/1HwTEUg59oKlpKPTSKwqA3k9mkXCJ0UyBXSoyX660n7SMN2uqaK/NoMl
X-Received: by 2002:a05:6809:344:20b0:4c3:6d05:18b2 with SMTP id 5614622812f47-4c36d051ba9mr1617046b6e.21.1789111671795;
        Fri, 11 Sep 2026 00:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c3314b1b12sm1546853b6e.7.2026.09.11.00.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 00:27:50 -0700 (PDT)
Message-ID: <307d6fd5-a8fa-4777-b513-9a8cce46f38a@gmail.com>
Date: Fri, 11 Sep 2026 15:27:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/12] tracing: wprobe: x86: Add wprobe for watchpoint
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <178875277830.93794.14247844688761142429.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/7/2026 11:46 AM, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is the 15th version of the series for adding new wprobe (watch probe)
> which provides memory access tracing event. Moreover, this can be used
> via event trigger. Thus it can trace memory access on dynamically
> allocated objects too.
> The previous version is here:
> 
>   https://lore.kernel.org/all/178810001186.64882.2161016469449127450.stgit@devnote2/
> 
> In this version, previous bugfix patches for BTF kflag resolution and
> RCU-protected kprobe blacklist were sent to Linus via probe/fixes, reducing
> the series to 12 patches. This version addresses feedbacks from Sashiko on
> v14[1], and more local fixes such as x86 debug register manipulation, validates
> watched address and natural alignment, tracks missed events on SMP update
> failures(*), prevents in-place command string modification during trigger
> parsing, adds explicit failure checks in selftests, and documents BTF
> typecast and struct offset syntax. I also added Assited-by: tags for this
> update.
> 
> [1] https://sashiko.dev/#/patchset/178810001186.64882.2161016469449127450.stgit%40devnote2
> (*) currently it just increase a missed counter.
> 
> Detailed changes are here.
> 
> Changes in v15:
>  - x86/mce: Move local_db_save() to entry of exc_machine_check_kernel()
>    and restore it on early return from mce_check_crashing_cpu() to
>    prevent nested #DB on watched variables.
>  - x86/hw_breakpoints: Always preserve DR7_FIXED_1 in
>    arch_install_hw_breakpoint(), arch_uninstall_hw_breakpoint(), and
>    hw_breakpoint_restore() for architectural compliance.
>  - x86/hw_breakpoints: Wrap local_db_save() in a cpu_dr7_seq loop to
>    detect NMI breakpoint updates and ensure DR7 is disabled before entry.
>  - x86/hw_breakpoints: In local_db_restore(), restore DR7_FIXED_1 if
>    saved dr7 is 0 and an NMI updated breakpoints, preserving KVM guest
>    isolation.
>  - x86/hw_breakpoints: Always write "val | DR7_FIXED_1" to hardware DR7
>    in local_db_restore() for architectural compliance.
>  - x86/hw_breakpoints: Avoid modifying saved dr7 in-place across retry
>    loops.
>  - x86/hw_breakpoints: Temporarily clear breakpoint enable bit in DR7
>    before updating debug address register and re-enable it afterward to
>    comply with x86 specification and avoid spurious #DBs.
>  - HWBP: Annotate counter_arch_bp(bp)->address and bp->attr.bp_addr with
>    WRITE_ONCE() in both update and rollback paths to prevent data races
>    with concurrent readers (e.g. NMI handlers).
>  - tracing/wprobe: Introduce trace_wprobe_is_valid_addr() to validate
>    target address and natural alignment for wprobe length during event
>    creation and trigger setup.
>  - tracing/wprobe: Initialize irq_work and work immediately after
>    allocation in alloc_trace_wprobe() and check tw->work.func in
>    free_trace_wprobe() to prevent WARN_ON(!work->func) on early failures.
>  - tracing/wprobe: Record SMP local update failures in tw->missed counter
>    and expose missed event count as a trailing comment in trigger file.
>  - tracing/wprobe: Duplicate field string in wprobe_trigger_typecast_parse()
>    to avoid modifying glob in place so tracing_log_err() logs the pristine
>    command string.
>  - tracing/wprobe: Remove leftover offset and adjust debug print in
>    wprobe_trigger_print().
>  - tracing/wprobe: Add set_wprobe and clear_wprobe triggers to readme_msg
>    in trace.c.
>  - tracing/wprobe: Move variable declarations to function entry in
>    trace_wprobe_show(), fix tab indentation in trace.c, and wrap lines
>    exceeding 100 columns.
>  - Documentation: Document BTF typecast in fetchargs and BTF struct
>    offset resolution in set_wprobe trigger in wprobetrace.rst.
>  - selftests/ftrace: Add explicit failure checks with fail helper across
>    trigger-wprobe.tc, trigger-wprobe-btf-typecast.tc, and
>    trigger-wprobe-btf-offset.tc.
>  - selftests/ftrace: Declare fprobe README requirement in trigger tests
>    and trigger file check in trigger-wprobe-syntax-errors.tc requires line.
> 
> 
> Public branch
> -------------
> I will push this branch as topic/wprobe-v2 to my tree so that it
> can be easily tested.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/wprobe-v2
> 
> This is based on linux-trace tree's linux-trace/probes/fixes.
> 
> Usage
> -----
> 
> The basic usage of this wprobe is similar to other probes;
> 
>   w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+|-OFFS]>[:LEN] [FETCHARGS]
> 
> This defines a new wprobe event. For example, to trace jiffies update,
> you can do;
> 
>  echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
>  echo 1 > events/wprobes/my_jiffies/enable
> 
> Moreover, this can be combined with event trigger to trace the memory
> access on slab objects. The trigger syntax is;
> 
>   set_wprobe:WPROBE_EVENT:FIELD[+|-OFFSET][:COUNT] [if FILTER]
>   clear_wprobe:WPROBE_EVENT[:FIELD[+|-OFFSET][:COUNT]] [if FILTER]
> 
> set_wprobe sets WPROBE_EVENT's watch address on FIELD[+|-OFFSET].
> clear_wprobe clears WPROBE_EVENT's watch address if it is set to
> FIELD[+|-OFFSET]. If FIELD is omitted, forcibly clear the watch address
> when trigger event is hit.
> 
> For example, trace the first 8 byte of the dentry data structure passed
> to do_truncate() until it is deleted by dentry_kill().
> (Note: all tracefs setup uses '>>' so that it does not kick do_truncate())
> 
>   # echo 'w:watch rw@-1:8 address=$addr value=+0($addr)' > dynamic_events
> 
>   # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
>   # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger
> 
>   # echo 'f:dentry_kill dentry_kill dentry=$arg1' >> dynamic_events
>   # echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger
> 
>   # echo 1 >> events/fprobes/truncate/enable
>   # echo 1 >> events/fprobes/dentry_kill/enable
> 
>   # echo aaa > /tmp/hoge
>   # echo bbb > /tmp/hoge
>   # echo ccc > /tmp/hoge
>   # rm /tmp/hoge
> 
> Then, the trace data will show;
> 
>  # tracer: nop
>  #
>  # entries-in-buffer/entries-written: 32/32   #P:8
>  #
>  #                                _-----=> irqs-off/BH-disabled
>  #                               / _----=> need-resched
>  #                              | / _---=> hardirq/softirq
>  #                              || / _--=> preempt-depth
>  #                              ||| / _-=> migrate-disable
>  #                              |||| /     delay
>  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>  #              | |         |   |||||     |         |
>                sh-107     [004] ...1.     9.990418: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618
>                sh-107     [004] ...1.     9.990914: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b3de78
>                sh-107     [004] ...1.     9.993175: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049ddd40
>                sh-107     [004] .....     9.995198: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880048083a8
>                sh-107     [004] ...1.     9.995389: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db998
>                sh-107     [004] ..Zff     9.997503: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
>                sh-107     [004] ..Zff     9.997509: watch: (path_openat+0x211/0xda0) address=0xffff8880048083a8 value=0x8200080
>                sh-107     [004] ..Zff     9.997514: watch: (path_openat+0xa56/0xda0) address=0xffff8880048083a8 value=0x8200080
>                sh-107     [004] ..Zff     9.997518: watch: (path_openat+0xae2/0xda0) address=0xffff8880048083a8 value=0x8200080
>                sh-107     [004] .....     9.997521: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880048083a8
>                sh-107     [004] ...1.     9.997582: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004808270
>                sh-107     [004] ...1.     9.999365: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db728
>                sh-107     [004] ...1.     9.999388: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b1c000
>                rm-113     [005] ..Zff    10.000965: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] ..Zff    10.000971: watch: (path_lookupat+0x97/0x1e0) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] ..Zff    10.000984: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] ..Zff    10.000988: watch: (path_lookupat+0x97/0x1e0) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] ..Zff    10.001010: watch: (lookup_one_qstr_excl+0x28/0x140) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] ..Zff    10.001014: watch: (lookup_one_qstr_excl+0xd1/0x140) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] ..Zff    10.001018: watch: (may_delete_dentry+0x1c/0x200) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] ..Zff    10.001021: watch: (may_delete_dentry+0x195/0x200) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] ..Zff    10.001031: watch: (vfs_unlink+0x5e/0x260) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] d.Z..    10.001067: watch: (d_make_discardable+0x1b/0x40) address=0xffff8880048083a8 value=0x8200080
>                rm-113     [005] d.Z..    10.001071: watch: (d_make_discardable+0x29/0x40) address=0xffff8880048083a8 value=0x200080
>                rm-113     [005] ...1.    10.001072: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880048083a8
>                rm-113     [005] ...1.    10.001218: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880048083a8
>                sh-107     [004] ...1.    10.001416: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db110
>                sh-107     [004] ...1.    10.001444: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db248
>                sh-107     [004] ...1.    10.001500: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618
>                sh-107     [004] ...1.    10.002067: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b41e78
>                sh-107     [004] ...1.    10.904920: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b41e78
>                sh-107     [004] ...1.    10.905129: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618
> 
> 
> Thank you,
> 
> ---
> base-commit: 0c4256196b3a105307e2235fbfd85e768bbcdd0f
> 
> Jinchao Wang (2):
>       x86/hw_breakpoints: Make DR7 updates NMI safe
>       x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API
> 
> Masami Hiramatsu (Google) (10):
>       x86/mce: Fix hardware debug register corruption on task migration
>       HWBP: Add modify_local_hw_breakpoint_addr() API
>       tracing/wprobe: Add wprobe (watchpoint probe) trace event support
>       x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
>       selftests: tracing: Add a basic testcase for wprobe
>       selftests: tracing: Add syntax testcase for wprobe
>       tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
>       selftests: tracing: Add wprobe trigger testcase
>       tracing/wprobe: Support BTF typecast in fetchargs
>       tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger
> 
> 
>  Documentation/trace/index.rst                      |    1 
>  Documentation/trace/wprobetrace.rst                |  200 +++
>  arch/Kconfig                                       |   18 
>  arch/x86/Kconfig                                   |    2 
>  arch/x86/include/asm/debugreg.h                    |   67 +
>  arch/x86/include/asm/hw_breakpoint.h               |    2 
>  arch/x86/kernel/cpu/mce/core.c                     |   29 
>  arch/x86/kernel/hw_breakpoint.c                    |  151 +-
>  arch/x86/kernel/nmi.c                              |    7 
>  arch/x86/kernel/traps.c                            |   10 
>  include/linux/hw_breakpoint.h                      |    6 
>  include/linux/trace_events.h                       |    3 
>  kernel/events/hw_breakpoint.c                      |   48 +
>  kernel/trace/Kconfig                               |   24 
>  kernel/trace/Makefile                              |    1 
>  kernel/trace/trace.c                               |   13 
>  kernel/trace/trace.h                               |    6 
>  kernel/trace/trace_events_trigger.c                |    2 
>  kernel/trace/trace_probe.c                         |   36 
>  kernel/trace/trace_probe.h                         |   22 
>  kernel/trace/trace_wprobe.c                        | 1522 ++++++++++++++++++++
>  tools/testing/selftests/ftrace/config              |    3 
>  .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   63 +
>  .../test.d/dynevent/wprobes_syntax_errors.tc       |   23 
>  .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   85 +
>  .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   85 +
>  .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   37 
>  .../ftrace/test.d/trigger/trigger-wprobe.tc        |  107 +
>  28 files changed, 2476 insertions(+), 97 deletions(-)
>  create mode 100644 Documentation/trace/wprobetrace.rst
>  create mode 100644 kernel/trace/trace_wprobe.c
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax-errors.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
Hi Masami,

I see the watch address update currently goes irq_work -> workqueue ->
on_each_cpu().  I would like to discuss that path.

The race window wprobe may be used to watch can be very narrow --
sometimes it lives entirely inside a single function -- and the trigger
does not always run in in_task() context.  The current path defers the
update to a work item, so by the time the debug registers are updated the
window may already be gone.

Now that we have modify_local_hw_breakpoint_addr(), the trigger could arm
the local CPU directly and use smp_call_function_single_async() for the
remote ones.  That should improve the overlap between the watch and the window.

What do you think?

Thanks,
Jinchao
