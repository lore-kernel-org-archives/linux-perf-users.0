Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709432E141;
	Mon,  7 Sep 2026 03:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788752786; cv=none; b=AQbAklBZ2ADUePgOZAEyP62HtbEJ9zgPYhkPgYqyK9Jr+PRLRzQAMAJKsaFL3PCo+bVzcMI9UNRuyh74RmzuGe3rPDxnSTJKTGBDnfJJifHMpkYYyN6lTN38RPWue8vQns3F4Q9VGHz5Jky7zL9IwCFDgmiFnkDof8cNtBrSORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788752786; c=relaxed/simple;
	bh=ch00/ksuu8lGOUK0W5YExKYqkjIFRPfLIYowUfJpPjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cve6qyLBYYcrCrLME8IGeYHTFAkDhKZgVg8vkZoAmjEZq8PCZxzdYzh4ef92dzoVDV2c+sEAO2d28xsWyoICQrzp8K+OTsOq85ot1igywUPXOou0I59dTASqHOS/4N4/g+jaIqXcwfv5TOJr41lTvam0dZ+qjNIyfI1xHDxtQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uaf816x/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uaf816x/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2D01F00A3D;
	Mon,  7 Sep 2026 03:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788752784;
	bh=koE7Z44LNC5qIrlXR4BtT/f2hG193GjiybwxC7/G+Q0=;
	h=From:To:Cc:Subject:Date;
	b=Uaf816x/+/gkp9hdCeJVEoUyRLvPda3tLIfCi55Mp5ylZptPorJkl0xCcg1gFJnqY
	 uGcj8XaaQRs7NwgdXgU4dsV0IL26vEFJthDiZu+TgejjKsnXS7frs9ek4BDqw5dEIM
	 KvBFiLfgSfvcD3JqeTHhdp46SIiFcCBRr4OqilX1gOYvihAbSAjTexl6bxe88xBP7e
	 nio6kNM4D4kZ8AWR140wHNC7KOHnOMlYfnZ6yyMi1vhhx39z35SGurfnbKLqgcvdP5
	 G3FMYE4A1xWj0m3OXB4zI/RmjPn/k+Ec2P3FeYcLsA9tG4j/y1tKSGFGP8LCHz8qGA
	 73fLiBhPRtvdA==
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
Subject: [PATCH v15 00/12] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Mon,  7 Sep 2026 12:46:18 +0900
Message-ID: <178875277830.93794.14247844688761142429.stgit@devnote2>
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

Here is the 15th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on dynamically
allocated objects too.
The previous version is here:

  https://lore.kernel.org/all/178810001186.64882.2161016469449127450.stgit@devnote2/

In this version, previous bugfix patches for BTF kflag resolution and
RCU-protected kprobe blacklist were sent to Linus via probe/fixes, reducing
the series to 12 patches. This version addresses feedbacks from Sashiko on
v14[1], and more local fixes such as x86 debug register manipulation, validates
watched address and natural alignment, tracks missed events on SMP update
failures(*), prevents in-place command string modification during trigger
parsing, adds explicit failure checks in selftests, and documents BTF
typecast and struct offset syntax. I also added Assited-by: tags for this
update.

[1] https://sashiko.dev/#/patchset/178810001186.64882.2161016469449127450.stgit%40devnote2
(*) currently it just increase a missed counter.

Detailed changes are here.

Changes in v15:
 - x86/mce: Move local_db_save() to entry of exc_machine_check_kernel()
   and restore it on early return from mce_check_crashing_cpu() to
   prevent nested #DB on watched variables.
 - x86/hw_breakpoints: Always preserve DR7_FIXED_1 in
   arch_install_hw_breakpoint(), arch_uninstall_hw_breakpoint(), and
   hw_breakpoint_restore() for architectural compliance.
 - x86/hw_breakpoints: Wrap local_db_save() in a cpu_dr7_seq loop to
   detect NMI breakpoint updates and ensure DR7 is disabled before entry.
 - x86/hw_breakpoints: In local_db_restore(), restore DR7_FIXED_1 if
   saved dr7 is 0 and an NMI updated breakpoints, preserving KVM guest
   isolation.
 - x86/hw_breakpoints: Always write "val | DR7_FIXED_1" to hardware DR7
   in local_db_restore() for architectural compliance.
 - x86/hw_breakpoints: Avoid modifying saved dr7 in-place across retry
   loops.
 - x86/hw_breakpoints: Temporarily clear breakpoint enable bit in DR7
   before updating debug address register and re-enable it afterward to
   comply with x86 specification and avoid spurious #DBs.
 - HWBP: Annotate counter_arch_bp(bp)->address and bp->attr.bp_addr with
   WRITE_ONCE() in both update and rollback paths to prevent data races
   with concurrent readers (e.g. NMI handlers).
 - tracing/wprobe: Introduce trace_wprobe_is_valid_addr() to validate
   target address and natural alignment for wprobe length during event
   creation and trigger setup.
 - tracing/wprobe: Initialize irq_work and work immediately after
   allocation in alloc_trace_wprobe() and check tw->work.func in
   free_trace_wprobe() to prevent WARN_ON(!work->func) on early failures.
 - tracing/wprobe: Record SMP local update failures in tw->missed counter
   and expose missed event count as a trailing comment in trigger file.
 - tracing/wprobe: Duplicate field string in wprobe_trigger_typecast_parse()
   to avoid modifying glob in place so tracing_log_err() logs the pristine
   command string.
 - tracing/wprobe: Remove leftover offset and adjust debug print in
   wprobe_trigger_print().
 - tracing/wprobe: Add set_wprobe and clear_wprobe triggers to readme_msg
   in trace.c.
 - tracing/wprobe: Move variable declarations to function entry in
   trace_wprobe_show(), fix tab indentation in trace.c, and wrap lines
   exceeding 100 columns.
 - Documentation: Document BTF typecast in fetchargs and BTF struct
   offset resolution in set_wprobe trigger in wprobetrace.rst.
 - selftests/ftrace: Add explicit failure checks with fail helper across
   trigger-wprobe.tc, trigger-wprobe-btf-typecast.tc, and
   trigger-wprobe-btf-offset.tc.
 - selftests/ftrace: Declare fprobe README requirement in trigger tests
   and trigger file check in trigger-wprobe-syntax-errors.tc requires line.


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

Masami Hiramatsu (Google) (10):
      x86/mce: Fix hardware debug register corruption on task migration
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
 arch/x86/include/asm/debugreg.h                    |   67 +
 arch/x86/include/asm/hw_breakpoint.h               |    2 
 arch/x86/kernel/cpu/mce/core.c                     |   29 
 arch/x86/kernel/hw_breakpoint.c                    |  151 +-
 arch/x86/kernel/nmi.c                              |    7 
 arch/x86/kernel/traps.c                            |   10 
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   48 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |   13 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_events_trigger.c                |    2 
 kernel/trace/trace_probe.c                         |   36 
 kernel/trace/trace_probe.h                         |   22 
 kernel/trace/trace_wprobe.c                        | 1522 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    3 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   63 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   23 
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   85 +
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   85 +
 .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   37 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |  107 +
 28 files changed, 2476 insertions(+), 97 deletions(-)
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
