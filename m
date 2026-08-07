Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E3280331;
	Fri,  7 Aug 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116805; cv=none; b=drgMhb3l+oHPPBWNEvl1/rvsAFz7JS9fd6kbnmWuSIJBFYxOKDH15E7rgX4bqt/K5Z8xDXIOYo6q31IujTSYgYu8qjlJ1rM9LdBF9kQu8QKGFdzqjGpc+ufTZ/09axPX82HQTyUZAkKk34iG77qLnBVWk7mqVOQn7400Lymp5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116805; c=relaxed/simple;
	bh=7Ku3pasvjzjXsRxVr+HfHLFub3sMwuMg4SaK7sxmLk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FxuJMZN48U3q5J4unN2x9qkXBwW2Vl6DPK+ZvipGyoouIczHFR4wc4GkKh6HAwUNZ3aoPDLiMF87M3Vyp4zLvXhleY/3qL7oLADGBe1lZksqQDArT3Q3njTYA0nsClTKQaHQxaB7w2wEED1MuUkKb32je12W3GHVpiV5N8kWBu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKBi6B3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKBi6B3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8371F00A3A;
	Fri,  7 Aug 2026 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116804;
	bh=tAH5rbzhabQyHIHTxImciFbY+7vaUKx8v4aPJFy3PKY=;
	h=From:To:Cc:Subject:Date;
	b=nKBi6B3uysNr/n/Phh1w5etGUsWR6jyuwZY2UN1Y3dlicLfcq/0k8siXl6p8SCSvx
	 Neqty11B5JV+SgDzlH3dB86ueHE14t8267Sxt90cjIwBbqpT49daiYIInC2Lh9Vk2T
	 Kmo5BuieyhRS2ehDKTY+/7dqzDdkwJirzwIawY71PBsy6v8DQsXSVKcfPgdJfBKQ7p
	 /7Ik3xAtEU9m+LmFJXE5vec+jUjR0NjGNjbat5n33A4+z6AcOzmYj9EHNXs2KeWgdH
	 0VllDi75wMHWKSNDULilkSSGPZ3rdmc4PBKHJDozjQDP52ep4ShaxhX+82GVMIBIx4
	 Mj0eKocWAtlfw==
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
Subject: [PATCH v12 00/11] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Sat,  8 Aug 2026 00:33:17 +0900
Message-ID: <178611679753.237811.10190793347982785419.stgit@devnote2>
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

Here is the 12th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on dynamically
allocated objects too.
The previous version is here:

  https://lore.kernel.org/all/178565870538.714490.11309825813968306287.stgit@devnote2/

This version fixes circular lock issue, remove nmi_dr7/nmi_dr7_seq, NULL
pointer access issue, and add more error parse logs etc. See below for more
details.

Changes in v12:
 - HWBP: Save and restore old address on arch_modify_local_hw_breakpoint_addr()
   failure to prevent internal state corruption.
 - x86/hw_breakpoints: Use stack variables dr7 and dr7_seq directly in
   exc_nmi() and remove redundant per-CPU nmi_dr7 and nmi_dr7_seq variables.
 - tracing/wprobe: Fix comment typo ('b' -> 'w'), remove dead 'ret = 0'
   initialization, and update RST documentation notation to SYMBOL[[+|-]OFFS].
 - tracing/wprobe: Add more error logging to wprobe event and wprobe triggers.
 - tracing/wprobe: Fix circular lock dependency in wprobe_trigger_cmd_parse() by
   removing dyn_event_ops_mutex locking and trace_probe_log_* calls in trigger
   parsing.
 - tracing/wprobe: Add event_trigger_init() call prior to event_trigger_register()
   in wprobe_trigger_cmd_parse() to increment trigger reference count and
   prevent memory use-after-free.
 - tracing/wprobe: Use WRITE_ONCE() when modifying tw->addr to pair with
   READ_ONCE(), add missing braces in wprobe_trigger_print(), and initialize
   tw->addr only after trace_event_enable_disable() succeeds.
 - tracing/wprobe: Fix NULL pointer dereference on empty trigger parameter
   strings and preserve colon delimiter for caret position error logging in
   ftrace_errlog_check.
 - tracing/wprobe: Refactor field parsing logic into wprobe_trigger_field_parse(),
   and remove unused variable count_str.
 - selftests/tracing: Add NO_ARG_BODY syntax error testcase in
   wprobe_syntax_errors.tc.
 - selftests/ftrace: Add trigger-wprobe-syntax-errors.tc for verifying wprobe
   trigger syntax error logging against "wprobe_trigger".


Public branch
-------------
I will push this branch as topic/wprobe-v2 to my tree so that it
can be easily tested.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/wprobe-v2

This is based on linux-trace tree's probes/for-next.

Usage
-----

The basic usage of this wprobe is similar to other probes;

  w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+OFFS]> [FETCHARGS]

This defines a new wprobe event. For example, to trace jiffies update,
you can do;

 echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
 echo 1 > events/wprobes/my_jiffies/enable

Moreover, this can be combined with event trigger to trace the memory
access on slab objects. The trigger syntax is;

  set_wprobe:WPROBE_EVENT:FIELD[+OFFSET] [if FILTER]
  clear_wprobe:WPROBE_EVENT[:FIELD[+OFFSET]] [if FILTER]

set_wprobe sets WPROBE_EVENT's watch address on FIELD[+OFFSET].
clear_wprobe clears WPROBE_EVENT's watch address if it is set to
FIELD[+OFFSET]. If FIELD is omitted, forcibly clear the watch address
when trigger event is hit.

For example, trace the first 8 byte of the dentry data structure passed
to do_truncate() until it is deleted by dentry_kill().
(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())

  # echo 'w:watch rw@0:8 address=$addr value=+0($addr)' > dynamic_events

  # echo 'f:truncate do_truncate dentry=$arg2' >> dynamic_events
  # echo 'set_wprobe:watch:dentry' >> events/fprobes/truncate/trigger

  # echo 'f:dentry_kill dentry_kill dentry=$arg1' >> dynamic_events
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
 # entries-in-buffer/entries-written: 32/32   #P:8
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
               sh-107     [004] ...1.     9.990418: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618
               sh-107     [004] ...1.     9.990914: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b3de78
               sh-107     [004] ...1.     9.993175: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049ddd40
               sh-107     [004] .....     9.995198: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880048083a8
               sh-107     [004] ...1.     9.995389: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db998
               sh-107     [004] ..Zff     9.997503: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
               sh-107     [004] ..Zff     9.997509: watch: (path_openat+0x211/0xda0) address=0xffff8880048083a8 value=0x8200080
               sh-107     [004] ..Zff     9.997514: watch: (path_openat+0xa56/0xda0) address=0xffff8880048083a8 value=0x8200080
               sh-107     [004] ..Zff     9.997518: watch: (path_openat+0xae2/0xda0) address=0xffff8880048083a8 value=0x8200080
               sh-107     [004] .....     9.997521: truncate: (do_truncate+0x4/0x120) dentry=0xffff8880048083a8
               sh-107     [004] ...1.     9.997582: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004808270
               sh-107     [004] ...1.     9.999365: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db728
               sh-107     [004] ...1.     9.999388: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b1c000
               rm-113     [005] ..Zff    10.000965: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] ..Zff    10.000971: watch: (path_lookupat+0x97/0x1e0) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] ..Zff    10.000984: watch: (lookup_fast+0xaa/0x150) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] ..Zff    10.000988: watch: (path_lookupat+0x97/0x1e0) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] ..Zff    10.001010: watch: (lookup_one_qstr_excl+0x28/0x140) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] ..Zff    10.001014: watch: (lookup_one_qstr_excl+0xd1/0x140) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] ..Zff    10.001018: watch: (may_delete_dentry+0x1c/0x200) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] ..Zff    10.001021: watch: (may_delete_dentry+0x195/0x200) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] ..Zff    10.001031: watch: (vfs_unlink+0x5e/0x260) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] d.Z..    10.001067: watch: (d_make_discardable+0x1b/0x40) address=0xffff8880048083a8 value=0x8200080
               rm-113     [005] d.Z..    10.001071: watch: (d_make_discardable+0x29/0x40) address=0xffff8880048083a8 value=0x200080
               rm-113     [005] ...1.    10.001072: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880048083a8
               rm-113     [005] ...1.    10.001218: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880048083a8
               sh-107     [004] ...1.    10.001416: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db110
               sh-107     [004] ...1.    10.001444: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff8880049db248
               sh-107     [004] ...1.    10.001500: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618
               sh-107     [004] ...1.    10.002067: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b41e78
               sh-107     [004] ...1.    10.904920: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004b41e78
               sh-107     [004] ...1.    10.905129: dentry_kill: (dentry_kill+0x0/0x2c0) dentry=0xffff888004ad6618


Thank you,

---
base-commit: 54f133c6178d06b169dceae18cc92c4945933b8c

Jinchao Wang (2):
      x86/hw_breakpoints: Make DR7 updates NMI safe
      x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

Masami Hiramatsu (Google) (9):
      HWBP: Add modify_local_hw_breakpoint_addr() API
      tracing/wprobe: Add wprobe (watchpoint probe) trace event support
      x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
      selftests: ftrace: Add wprobe trigger testcase
      tracing/wprobe: Support BTF typecast in fetchargs
      tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  168 ++
 arch/Kconfig                                       |   18 
 arch/x86/Kconfig                                   |    2 
 arch/x86/include/asm/debugreg.h                    |   36 
 arch/x86/include/asm/hw_breakpoint.h               |    2 
 arch/x86/kernel/cpu/mce/core.c                     |   20 
 arch/x86/kernel/hw_breakpoint.c                    |  125 +-
 arch/x86/kernel/nmi.c                              |    7 
 arch/x86/kernel/traps.c                            |   10 
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   40 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_dynevent.h                      |    1 
 kernel/trace/trace_events_trigger.c                |    2 
 kernel/trace/trace_probe.c                         |   36 
 kernel/trace/trace_probe.h                         |   22 
 kernel/trace/trace_wprobe.c                        | 1450 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    3 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   63 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   22 
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   74 +
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   72 +
 .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   31 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   85 +
 29 files changed, 2261 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax-errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
