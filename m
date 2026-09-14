Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BC488206;
	Mon, 14 Sep 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390185; cv=none; b=Iv6tfJ3CmIPBylKIgBx54srnfsx2jSoDMJoDiWToHRfgsFDa9DhHwAW/OaixKsx8Azx7BBIND23e7dfmSMtGhi5pM7e0nubTvRrMBrRN3j6SwAqF5vYOGM/hup68a7K2gnUrNzZ1xmoqUJsH2/8qWpuMlPQuFVELDbKWMBtch34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390185; c=relaxed/simple;
	bh=Ah86zB4RVG+uIcN/elJO/E+NDlTnoyUMVKuIh5hvPTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LImO4FFSBjWrxdErFqf5TEMIaIcNDrzkHWS04HfYt4tF4aMuEvdAJ80hZ/iMsb/sAW++lCQ6kzmEBblhio20Y13GR7oMBC3onGYNynb2Kq2B4Yt4+bWUDLqKOiDsUQ3zdJLCoJElSviFGpoke9hFSR+/BUzf448qJHVM2lqWMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6Qu9Faj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6Qu9Faj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752061F000FF;
	Mon, 14 Sep 2026 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390182;
	bh=R9SUF4YQKVjWUn2HUkixZwwzY6UDTVcqegX2kFC3irY=;
	h=From:To:Cc:Subject:Date;
	b=g6Qu9Faj/tlq3eoW4PI1bM2X7wyAqvuegbjwBQ1pvdh8nLGngWR2G8pky7SyE6r5D
	 Kmu5jOMjosFg2xLxA8jOqvBE/G2D8LOYzgd33AMqStVuSHA4cBvO00Aw+dWmDSzn8z
	 yZ63LBgBnTdpq1NGTnYttaMZbkSI64Kxv6xg2G9MSBYdQfuu4LfVSx826I/WWvCMKH
	 MGRrKOHsOdsXORdDlk1aOWRLP3k22BvRzn3g9k7ioq2JQm76E6LrwIMDBuQotuL3Yh
	 i4l4NNy0Zk8YtyaXSHSXzizfxLJmDcyIBluVPZP3B1NMl0EnEpjzpJDPy1XeENM9OH
	 6G/wd/aNC3AcQ==
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
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v16 00/13] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Mon, 14 Sep 2026 21:49:35 +0900
Message-ID: <178939017565.94750.9431053336761330458.stgit@devnote2>
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

Here is the 16th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on dynamically
allocated objects too.
The previous version is here:

  https://lore.kernel.org/all/178875277830.93794.14247844688761142429.stgit@devnote2/

In this version, a new patch is added to prevent host DR7 debug register
leaks into KVM guest OSes upon NMI, isolating guest debug state with a
dedicated per-CPU flag (cpu_dr_in_guest) and memory barriers.
Furthermore, this version addresses reviewer feedback on v15:
- Removed hypervisor check in local_db_save() so all paths go through the
  sequence retry loop, preventing race windows on return instructions.
- Fixed arch_modify_local_hw_breakpoint_addr() to clear the breakpoint
  enable bit in shadow cpu_dr7 before touching hardware DR7, preventing
  intervening NMIs from prematurely re-enabling breakpoints and triggering
  spurious #DB exceptions.
- Updated wprobe triggers to program local debug registers directly when
  a trigger fires, eliminating workqueue latency on the local CPU, while
  kicking irq_work only for other CPUs.
- Corrected "unlimited" count keyword matching in clear_wprobe and removed
  the non-existent wprobe_events file from readme_msg.

Detailed changes are here.

Changes in v16:
[02/13]
 - Newly added to prevent host DR7 debug register leak into guest OS
   on NMI using a cpu_dr_in_guest per-CPU flag.
[03/13]
 - In local_db_save(), remove the hypervisor check so all paths go
   through the sequence retry loop.
 - Check cpu_dr7_seq before clearing hardware DR7 and reload from shadow
   cpu_dr7 on sequence retry to avoid clobbering NMI breakpoint updates.
 - In local_db_restore(), restore from shadow cpu_dr7 whenever
   cpu_dr7_seq changed instead of evaluating dr7 ? cpu_dr7 : 0.
[04/13]
 - Clear breakpoint in shadow cpu_dr7 before setting hardware DR7 in
   arch_modify_local_hw_breakpoint_addr() to prevent spurious #DB
   exceptions from intervening NMIs.
 - Reject modifying local breakpoints with -EBUSY while cpu_dr_in_guest
   is set.
[06/13]
 - Remove non-existent wprobe_events file description from readme_msg
   in kernel/trace/trace.c.
[10/13]
 - Immediately update the hardware breakpoint on the local CPU via
   trace_wprobe_update_local() in wprobe_trigger() to avoid workqueue
   latency, and only kick irq_work for other CPUs.
 - Skip redundant updates in trace_wprobe_update_local() if
   bp->attr.bp_addr already matches the target address.
 - Use strcmp() instead of strncmp() for "unlimited" in
   wprobe_trigger_cmd_parse() to avoid misinterpreting field names
   starting with "unlimited" as the count keyword.
 - Normalize "unlimited" and "count=" parameters before creating
   trigger data.

Public branch
-------------
I will push this branch as topic/wprobe-v2 to my tree so that it
can be easily tested.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/wprobe-v2

This is based on linux-trace tree's linux-trace/probes/fixes.

Usage
-----

The basic usage of this wprobe is similar to other probes;

  w:[GRP/][EVENT] [r|w|rw]@<ADDRESS|SYMBOL[+|-OFFS]>[:LEN] [FETCHARGS]

This defines a new wprobe event. For example, to trace jiffies update,
you can do;

 echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
 echo 1 > events/wprobes/my_jiffies/enable

Moreover, this can be combined with event trigger to trace the memory
access on slab objects. The trigger syntax is;

  set_wprobe:WPROBE_EVENT:FIELD[+|-OFFSET][:COUNT] [if FILTER]
  clear_wprobe:WPROBE_EVENT[:FIELD[+|-OFFSET][:COUNT]] [if FILTER]

set_wprobe sets WPROBE_EVENT's watch address on FIELD[+|-OFFSET].
clear_wprobe clears WPROBE_EVENT's watch address if it is set to
FIELD[+|-OFFSET]. If FIELD is omitted, forcibly clear the watch address
when trigger event is hit.

For example, trace the first 8 byte of the dentry data structure passed
to do_truncate() until it is deleted by dentry_kill().
(Note: all tracefs setup uses '>>' so that it does not kick do_truncate())

  # echo 'w:watch rw@-1:8 address=$addr value=+0($addr)' > dynamic_events

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
base-commit: 0c4256196b3a105307e2235fbfd85e768bbcdd0f

Jinchao Wang (2):
      x86/hw_breakpoints: Make DR7 updates NMI safe
      x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

Masami Hiramatsu (Google) (11):
      x86/mce: Fix hardware debug register corruption on task migration
      KVM: x86: Prevent host DR7 debug register leak into guest OS on NMI
      HWBP: Add modify_local_hw_breakpoint_addr() API
      tracing/wprobe: Add wprobe (watchpoint probe) trace event support
      x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
      selftests: tracing: Add wprobe trigger testcase
      tracing/wprobe: Support BTF typecast in fetchargs
      tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  200 +++
 arch/Kconfig                                       |   18 
 arch/x86/Kconfig                                   |    2 
 arch/x86/include/asm/debugreg.h                    |   79 +
 arch/x86/include/asm/hw_breakpoint.h               |    2 
 arch/x86/kernel/cpu/mce/core.c                     |   29 
 arch/x86/kernel/hw_breakpoint.c                    |  166 ++
 arch/x86/kernel/nmi.c                              |    7 
 arch/x86/kernel/traps.c                            |   10 
 arch/x86/kvm/x86.c                                 |    7 
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   48 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_events_trigger.c                |    2 
 kernel/trace/trace_probe.c                         |   36 
 kernel/trace/trace_probe.h                         |   22 
 kernel/trace/trace_wprobe.c                        | 1541 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    3 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   63 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   23 
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   85 +
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   85 +
 .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   37 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |  107 +
 29 files changed, 2526 insertions(+), 96 deletions(-)
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
