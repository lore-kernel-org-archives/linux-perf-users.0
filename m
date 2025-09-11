Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072618DB1F;
	Thu, 11 Sep 2025 00:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551357; cv=none; b=rcMraBJ6GPZ7EbwaxeV8/wr2Xgkst8L1RxOPV6pFULKl7lqn8LxgRBKJGvkXciDL/dYuH9QBjtaR6fs3GtE2xVMJymfOv6mXm4xgiiSj1U4iS9JSAmXq3LyzWG4uIGmUMXaym6uma0rYQoxNaUcgIeisPXThnd2Pi3bxO/05S8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551357; c=relaxed/simple;
	bh=Vf4Tho//sAkZ5cgJAxCmGj3RZ+gVH69Rb+8zVnnbbn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qbpuk3TJTE1TCzRHN/8f7em304RxZqHs7f4lkmRGvNbd3AMVbJtqPBmJEmxmRMc/9f7W7M8Jcj8+p7ueQ/GYAjGXKdsRAW3Qgnq32gLCcjTrTYbEUZHLtKCuW2NfU0JK4J1TynvXC7YbKBf2rRFCZmrc4BHc8nxdjbXxejOQlI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h86up88N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h86up88N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C208AC4CEEB;
	Thu, 11 Sep 2025 00:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551356;
	bh=Vf4Tho//sAkZ5cgJAxCmGj3RZ+gVH69Rb+8zVnnbbn0=;
	h=From:To:Cc:Subject:Date:From;
	b=h86up88NbglTgThzubKSM3CG0SS3fVrbBifieYyKktLNx/Y2Q04+5pGoPaRfpAPPo
	 eHcxmZD04HugH3DS9qvrrGAN9PJ4N/ncUr5EjfELUaT+iDs/Av63xLJkGttMJ51QHJ
	 Sl9OgF0yVzTECaB4jPQW/4FnA1p7gEw5XB65N0MKvbgDRLmn36OTe6PoTX4/ZZTF8v
	 6zCP4Mq3FlPzk6JuU3RObBRp8P/UyhIOYjOuhgyQMuZ8kx00Ie3I9jIhfg3edQTyEt
	 KABuDURcx8nT/frcpsGAL0CLkeH9ivHBeC+KwJdxwkEN66cfZSe+upUVPUFBMjcHqS
	 e2Dlyldam1ABg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 0/7] tracing: wprobe: Add wprobe for watchpoint
Date: Thu, 11 Sep 2025 09:42:30 +0900
Message-ID: <175755135002.153203.324836519360617091.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 3rd version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on a dynamically
allocated objects too.
The previous version is here:

https://lore.kernel.org/all/175708427997.64001.11661389635019507808.stgit@devnote2/

In this version, I fixed to enclose the register-API dependent code in
trace_probe.c with CONFIG_HAVE_FUNCTION_ARG_ACCESS_API, since
CONFIG_WPROBE_EVENTS does not depend on that config but enables common
CONFIG_PROBE_EVENTS[1/7]. And fixed event_trigger_data memory leak bug
and add FIELD option to clear_wprobe trigger[4/7]. Also, fixed a syntax
test error[6/7] and add a new test case for event trigger [7/7].

I'm using Jinchao's arch_reinstall_hw_breakpoint patch[1], but since Peter
pointed that is almost a copy of arch_install_hw_breakpoint, it will be
updated later.

[1] https://lore.kernel.org/all/20250904002126.1514566-6-wangjinchao600@gmail.com/

The basic usage of this wprobe is similar to other probes;

  w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+OFFS]> [FETCHARGS]

This defines a new wprobe event. For example, to trace jiffies update,
you can do;

 echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
 echo 1 > events/wprobes/my_jiffies/enable

Moreover, this can be combined with event trigger to trace the memory
accecss on slab objects. The trigger syntax is;

  set_wprobe:WPROBE_EVENT:FIELD[+OFFSET] [if FILTER]
  clear_wprobe:WPROBE_EVENT[:FIELD[+OFFSET]] [if FILTER]

set_wprobe sets WPROBE_EVENT's watch address on FIELD[+OFFSET].
clear_wprobe clears WPROBE_EVENT's watch address if it is set to
FIELD[+OFFSET]. If FIELD is omitted, forcibly clear the watch address
when trigger event is hit.

For example, trace the first 8 byte of the dentry data structure passed
to do_truncate() until it is deleted by __dentry_kill().
(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())

  # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events

  # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
  # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger

  # echo 'f:dentry_kill __dentry_kill dentry=$arg1' >> dynamic_events
  # echo 'clear_wprobe:watch:dentry' >> events/fprobes/dentry_kill/trigger

  # echo 1 >> events/fprobes/truncate/enable
  # echo 1 >> events/fprobes/dentry_kill/enable

  # echo aaa > /tmp/hoge
  # echo bbb > /tmp/hoge
  # echo ccc > /tmp/hoge
  # rm /tmp/hoge

Then, the trace data will show;

# tracer: nop
#
# entries-in-buffer/entries-written: 16/16   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
              sh-113     [004] .....     6.467444: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880044f0fd8
              sh-113     [004] ..Zff     6.468534: watch: (lookup_fast+0xaa/0x150) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] ..Zff     6.468542: watch: (step_into+0x82/0x360) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] ..Zff     6.468547: watch: (step_into+0x9f/0x360) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] ..Zff     6.468553: watch: (path_openat+0xb3a/0xe70) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] ..Zff     6.468557: watch: (path_openat+0xb9a/0xe70) address=0xffff8880044f0fd8 value=0x200080
              sh-113     [004] .....     6.468563: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880044f0fd8
              sh-113     [004] ...1.     6.469826: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044f0ea0
              sh-113     [004] ...1.     6.469859: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044f0d68
              rm-118     [001] ..Zff     6.472360: watch: (lookup_fast+0xaa/0x150) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472366: watch: (step_into+0x82/0x360) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472370: watch: (step_into+0x9f/0x360) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472386: watch: (lookup_fast+0xaa/0x150) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472390: watch: (step_into+0x82/0x360) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472394: watch: (step_into+0x9f/0x360) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472415: watch: (lookup_one_qstr_excl+0x2c/0x150) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472419: watch: (lookup_one_qstr_excl+0xd5/0x150) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472424: watch: (may_delete+0x18/0x200) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472428: watch: (may_delete+0x194/0x200) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] ..Zff     6.472446: watch: (vfs_unlink+0x63/0x1c0) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] d.Z..     6.472528: watch: (dont_mount+0x19/0x30) address=0xffff8880044f0fd8 value=0x200180
              rm-118     [001] ..Zff     6.472533: watch: (vfs_unlink+0x11a/0x1c0) address=0xffff8880044f0fd8 value=0x200180
              rm-118     [001] ..Zff     6.472538: watch: (vfs_unlink+0x12e/0x1c0) address=0xffff8880044f0fd8 value=0x200180
              rm-118     [001] d.Z1.     6.472543: watch: (d_delete+0x61/0xa0) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] d.Z1.     6.472547: watch: (dentry_unlink_inode+0x14/0x110) address=0xffff8880044f0fd8 value=0x200080
              rm-118     [001] d.Z1.     6.472551: watch: (dentry_unlink_inode+0x1e/0x110) address=0xffff8880044f0fd8 value=0x80
              rm-118     [001] d.Z..     6.472563: watch: (fast_dput+0x8d/0x120) address=0xffff8880044f0fd8 value=0x80
              rm-118     [001] ...1.     6.472567: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff8880044f0fd8
              sh-113     [004] ...2.     6.473049: dentry_kill: (__dentry_kill+0x0/0x220) dentry=0xffff888006e383a8

Thank you,

---

Jinchao Wang (1):
      x86/HWBP: introduce arch_reinstall_hw_breakpoint() for atomic context

Masami Hiramatsu (Google) (6):
      tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
      HWBP: Add modify_wide_hw_breakpoint_local() API
      tracing: wprobe: Add wprobe event trigger
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      selftests: ftrace: Add wprobe trigger testcase


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  157 +++
 arch/Kconfig                                       |   10 
 arch/x86/Kconfig                                   |    1 
 arch/x86/include/asm/hw_breakpoint.h               |    1 
 arch/x86/kernel/hw_breakpoint.c                    |   50 +
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   36 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    5 
 kernel/trace/trace_probe.c                         |   22 
 kernel/trace/trace_probe.h                         |    8 
 kernel/trace/trace_wprobe.c                        | 1115 ++++++++++++++++++++
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   68 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   20 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   48 +
 19 files changed, 1582 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
