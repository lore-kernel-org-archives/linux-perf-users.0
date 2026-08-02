Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C03280338;
	Sun,  2 Aug 2026 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658715; cv=none; b=Ul5Jb7EX+9bQGwNVg4M7NkDnxMK26j2NWVplbTLWzS1jXlzpAmCaeWDz6xl70pHkAsfcksp85yM3CgRBxGRKclRCFDyYObNazTlSpuY/rk6j/RS9X9qRAvZfqaqQ1ymJ3aZDpYmG9l2ERttMB3GFZU8CblhrbNYvkKw4bA/lfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658715; c=relaxed/simple;
	bh=jixRizPvdcXlYpvqjr8nl5oD3qgJT1PQiqIEHr3UXJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iw9Y3PPEvwocozW4b2e4iI8YxAbfenYb/Sd5RbTa+77gPVzrD9jAWSxRea/8y5L2Rcjb7Ka27Uf/jQmKg7VyaPpJOONiIY53LWfWivfmqFWI1rN3EOdSIVGqVvTfqiCzzd2LrFnkVktiAIFnw8YcTOJhMcWzOvljBaeKu7xDC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkS7XmJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkS7XmJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E7D1F00AC4;
	Sun,  2 Aug 2026 08:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785658712;
	bh=+bKQ9jGZ86fkiuazazVrkevVGniHjeQX6eWxdYJNrqk=;
	h=From:To:Cc:Subject:Date;
	b=XkS7XmJMVGq5t69wnFbHJvHPllIxlRCDs+XUfYLxF3MmBEBXixmawNGUKxyYzlef4
	 qWk7wEVCDbRIq8bMJfqYzuDaA6V4TX9zxSQb5lXTxRDKS8cbCUjrsl/u82cPpiAGIF
	 O4PyshmbB4h/55B6QFj+zFLRSg+1vCUb/Dr4En3cJiIOAnnkH76B7BIqpGTs3vGzfa
	 kCUDN78kYHTXSXVNPObNisv3zzXgTyUJJQxgY6Q1HSG+loFsgpWnjfLne1vKSnyesw
	 NyULG3H83NjZyT6s+54oAYunQBihiJwUlKbj3mnUDLV0xoGUI24J7xiKsXVZ+CLrzb
	 N4c/mbZvP1c+g==
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
Subject: [PATCH v11 00/11] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Sun,  2 Aug 2026 17:18:25 +0900
Message-ID: <178565870538.714490.11309825813968306287.stgit@devnote2>
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

Here is the 11th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on dynamically
allocated objects too.
The previous version is here:

  https://lore.kernel.org/all/178476134787.26117.10094977293012760490.stgit@devnote2/

The major changes in this version is to use Jinchao's new
modify_local_hw_breakpoint_addr() API, add count option support to
wprobe trigger, skip wprobe trigger during another wprobe trigger is
working and rewrite selftests for wprobe trigger with
trace-events-sample module.

Changes in v11:
 - Updated hardware breakpoint modification API:
   - Replaced arch_reinstall_hw_breakpoint() with
     arch_modify_local_hw_breakpoint_addr() and
     modify_local_hw_breakpoint_addr() API.
   - Made DR7 updates NMI safe by using atomic cmpxchg for slot management
     and per-CPU sequence number (cpu_dr7_seq) to detect concurrent NMI
     updates.
 - Refactored wprobe trigger implementation:
   - Updated set_wprobe/clear_wprobe trigger to use
     modify_local_hw_breakpoint_addr().
   - Added tracepoint_synchronize_unregister() in wprobe_unregister_trigger()
     and parse error path.
   - Added NULL check for tw->bp_event in trace_wprobe_update_local() to
     prevent race conditions.
   - Switched trigger data freeing to use event_trigger_data::private_data_free.
   - Added count option support (count=N) for wprobe triggers.
   - Fixed trigger address calculation (cast rec to char *).
   - Added work_pending flag to avoid update conflicts between CPUs.
   - Fixed wprobe_trigger_find_same() to check wprobe_data->clear flag.
   - Update trigger-wprobe*.tc to use trace-events-sample kernel module.
 - Fixed selftest:
   - Updated trigger-wprobe.tc assertion logic for clear_wprobe trigger
     test to check trace log instead of sysfs enable file (which remains 1
     under soft-disable).

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

Jinchao Wang (2):
      x86/hw_breakpoints: Make DR7 updates NMI safe
      x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

Masami Hiramatsu (Google) (9):
      HWBP: Add modify_local_hw_breakpoint_addr() API
      tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
      x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      tracing: wprobe: Add wprobe event trigger
      selftests: ftrace: Add wprobe trigger testcase
      tracing/wprobe: Support BTF typecast in fetchargs
      tracing/wprobe: Support BTF typecast in wprobe trigger command


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  163 ++
 arch/Kconfig                                       |   18 
 arch/x86/Kconfig                                   |    2 
 arch/x86/include/asm/debugreg.h                    |   36 -
 arch/x86/include/asm/hw_breakpoint.h               |    2 
 arch/x86/kernel/cpu/mce/core.c                     |   20 
 arch/x86/kernel/hw_breakpoint.c                    |  125 +-
 arch/x86/kernel/nmi.c                              |   10 
 arch/x86/kernel/traps.c                            |   10 
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   35 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_events_trigger.c                |    2 
 kernel/trace/trace_probe.c                         |   34 
 kernel/trace/trace_probe.h                         |   15 
 kernel/trace/trace_wprobe.c                        | 1392 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    3 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   63 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   21 
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   74 +
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   72 +
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   85 +
 27 files changed, 2156 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
