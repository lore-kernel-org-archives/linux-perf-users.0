Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B642877E8;
	Thu, 16 Jul 2026 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170339; cv=none; b=NjvQCN7Gk7mene7cSpWPmyW+TwPMzGehlfXX0jQQd3c4yxEowd/9xgWhY6mSezSLYQvjrJJRLp7ymVxHcmbzmOuzkwgOOrERNt2ZRrLLV8BbbCIbWE94ClyjU8c6hMqiuAFIe9/V8eX2V0xYocftSJ9ttog4JscPYMpSzWHjgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170339; c=relaxed/simple;
	bh=GjRFiX3h6ozN+OW3UKhRLTSpJbOCkjI3PxavdmVV2lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TsnS0U12XhQA+Mkrd1jKYOTZubEMo0kwkCv+kl6yLxseuHh/Ntzn0tDbwN5bfIJcpxnjJcQ10MaxbYqHobntloJWqa/36JTdzhQEDPjmpKlUwUrFo7u2Vgi3bNSDRe8hzKv2ehIKqgJuH/wa+X/Ixd11geS3C+dX6xhMCOB9Wz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S95YESOr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S95YESOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FC11F000E9;
	Thu, 16 Jul 2026 02:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784170337;
	bh=TSrkEP7LUnpAbCqC55sU5ke43SY/aziNihnBLjbFOrQ=;
	h=From:To:Cc:Subject:Date;
	b=S95YESOrLm1LSahvYa3tTHt8v+LH2O/Beg+sezqbFM6SUpKZM78F0dgG+qAuTKrwM
	 fFXS4aPYHdU/4PSQH8QTTVRxZVcSI/cQeH/kvsPJoZ8VGv+xjJSkghgTt8wPLl30hD
	 D20+3+5muyYszPkBYdimlt5kcosafyliAATO3DMICbMJaxETMggSsINmqrLMxzIlTE
	 Y/VuyOr2Iszg6jGTDYO2yjd2Fbxds3r3xTzycj5z92AAh9Y8AOkY2I/9EzOFBKVRG6
	 MVmlDMM1QU1SQpy+VapD+ke5lp35yhIaQFOqGGhrLLpJaRnVvCdyx/lfQgTgQ+ZXMb
	 HQq9I/Z7YvoTQ==
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
Subject: [PATCH v8 0/9] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Thu, 16 Jul 2026 11:52:11 +0900
Message-ID: <178417033089.209165.16717079876036408877.stgit@devnote2>
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

Here is the 8th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on a dynamically
allocated objects too.
The previous version is here:

  https://lore.kernel.org/all/178407983818.95826.12714571928538799781.stgit@devnote2/

This version fixes many issues commented by Sashiko. Let me list it up.

[PATCH 1/9] 
      - Include required header files.
      - Use READ_ONCE(tw->addr) in trace handler to safely check dynamically
        updated addresses.
      - Prohibit unsafe perf support by returning -EOPNOTSUPP in
        wprobe_register().
      - Add rollback logic to unregister already-enabled sibling probes if
        registration fails mid-loop.
      - Resolve symbol offsets dynamically in trace_wprobe_show() using
        kallsyms_lookup_name().
      - Fix memory leak of parse_address_spec()'s symbol output in
        __trace_wprobe_create().
      - Print "rw" instead of "x" for read-write type breakpoints in
        trace_wprobe_show().
      - Document the $value fetcharg in wprobetrace.rst.
[PATCH 3/9]
      - Fixed silently test failure path.
[PATCH 5/9]
      - Add missing barrier() on the disable path of setup_hwbp() to prevent
        the compiler from reordering this_cpu_write(cpu_dr7, ...) before
        set_debugreg(dr7, 7).
      - Clear existing slot control and enable bits in cpu_dr7 inside
        setup_hwbp() using __encode_dr7() before setting new ones to prevent
        register state corruption on update/reinstall.
[PATCH 7/9]
      - Parse new attributes into a temporary struct arch_hw_breakpoint
        copy to prevent in-place mutation and corruption on parse error paths.
      - Synchronize logical perf_event attributes by updating
       bp->attr.bp_type and bp->attr.bp_len in modify_wide_hw_breakpoint_local().
[PATCH 8/9]
      - Redesign wprobe_trigger() to be safe in NMI/hardirq contexts by
        deferring register updates to a workqueue via irq_work.
      - Skip trigger execution and increment an atomic missed count
        (tw->missed) if the tracepoint runs in NMI context to prevent
        recursive spinlock deadlocks. (this is currently hidden counter)
      - Prohibit attaching wprobe triggers to kprobe_events by checking
        TRACE_EVENT_FL_KPROBE in wprobe_trigger_cmd_parse().
      - Use call_rcu() in trigger deactivation path and add
        synchronize_rcu() in parse failure path to ensure safe RCU
        lifetime cleanup.
      - Acquire the target tracepoint's module reference via
       trace_event_try_get_ref() to prevent module refcount underflows.
      - Fix event_trigger_data memory leak by properly freeing the
        initial refcount in wprobe_trigger_cmd_parse() on success.
      - Call on_each_cpu() with wait=true in wprobe_work_func() to
        prevent use-after-free during trigger unregistration.
      - Synchronize concurrent wprobe triggers on the same event by
        using a shared raw spinlock (tw->lock).
      - Drop the support of kprobe events (that should be done later).
[PATCH 9/9]
      - Use TMPDIR for making a test file.
      - Ensure the fprobe and target functions exists, if not, exit
        with UNRESOLVED (== skip).

To support kprobe events, we need to check the previous NMI context
or need to use an atomic refcount etc. But that should be another
patch for review.

To support arm64, we need to avoid major pagefault on single-stepping
issue. I think we can solve it with checking whether the address is the
kernel (which must not cause a major page fault), or not.

Usage
-----

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
      x86/hw_breakpoint: Unify breakpoint install/uninstall
      x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint

Masami Hiramatsu (Google) (7):
      tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
      x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      HWBP: Add modify_wide_hw_breakpoint_local() API
      tracing: wprobe: Add wprobe event trigger
      selftests: ftrace: Add wprobe trigger testcase


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  163 +++
 arch/Kconfig                                       |   20 
 arch/x86/Kconfig                                   |    2 
 arch/x86/include/asm/hw_breakpoint.h               |    8 
 arch/x86/kernel/hw_breakpoint.c                    |  151 ++-
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   43 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_probe.c                         |   22 
 kernel/trace/trace_probe.h                         |    8 
 kernel/trace/trace_wprobe.c                        | 1146 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    2 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   69 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   20 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   65 +
 20 files changed, 1703 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
