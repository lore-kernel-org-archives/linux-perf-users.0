Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85B30C637;
	Sat,  3 Oct 2026 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013943; cv=none; b=b56J1XUtBulSIndtIVRPGPw+7BVyXrfwu9bY8fHiEIOCJXWQ60jWRQRCOjwXFPugWUFszI/bSwfeyrhI53FtxKClS7iwUmUpC3gu5U/YgVc4TniqykN0mUVBeSEyz3zeJwKi4dQf+4EnXGDaVjuGXxrGTtxhDbQ1czPzISAtsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013943; c=relaxed/simple;
	bh=qXs4ec8X7Jfr6FWfIeJLnc91+vorrQOmDL5fnzQmckI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H2kUhDvLQLbjrFKYfyFx0f2ikdzlNJGvX0n6rVhTGPhi+skrwEhIOz6iWUu9igAX6BBf0wrSaQ7FEoZMJ1PMfCDBhlE6CqnhKbc7SyFTSREqlaLw/1dKTTOmTwtdMulQy6vVTcJYXHccUVJNcqgAvINwxN4HadIx1UQuQ6Vzl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViPVH8iA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViPVH8iA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF121F0089B;
	Sat,  3 Oct 2026 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013941;
	bh=vjFrJpzYgVYdQEAC7rqv0Md0+2oI3F/1nmUN6CCu+HE=;
	h=From:To:Cc:Subject:Date;
	b=ViPVH8iAayq5hguo0W99C1okDHgeYRAXrZ/3Gnf3rBALtKZ7yq+Q6pnVvXVZCWAwN
	 6+yuoDJz5IMEcyFiuiETn0ZQZqZ9u5ctv8fFxyiC35sh4CVmBbPQGnMH0xDpyFmd8Z
	 4iVUplMCb4PDclu+gzEBARE8f9Y2SaGeVgRUlG88biem81I5gVk2wkDlMwjzVO9y/z
	 /L3DrRC8icsbpbab/hO5GJxP3fvBYubVzufk49r/g219V1Hs8iVjQEWu7yBpCxjrhC
	 p90APTCvuXVivoPLvx+IjReQhnjxOJt1JuZ3Td/pi7TGS/0NGpHQV3Gpx9751aaOVJ
	 VMDk6PIdfhBNg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
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
	x86@kernel.org
Subject: [PATCH v19 00/11] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Sat,  3 Oct 2026 16:52:14 +0900
Message-ID: <179101393469.22872.5895666191299551553.stgit@devnote2>
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

Here is the 19th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on dynamically
allocated objects too.
The previous version (v17) is here (It seems v18 failed to send the patch.):

  https://lore.kernel.org/all/179005108298.388919.4535333252892590932.stgit@devnote2/

v19 is just rebased on the latest probes/for-next branch.
In the version 18:
- Dropped MCE related fix because it is merged in -tip tree.
- Dropped the patches related to making DR7 updates NMI-safe (and the
  associated KVM guest debug register isolation patch) because wprobe
  itself does not support updating DR7 in NMI context (wprobe explicitly
  rejects execution in NMI context via in_nmi()). Those patches are still
  valid for KGDB, but not related to wprobe.
- Addressed review comments from Sashiko bot on wprobe triggers, selftests,
  and BTF struct offset resolution:
  - Add register_wide_hw_breakpoint_cpuslocked() API to hw_breakpoint and
    use it under cpus_read_lock() in __register_trace_wprobe() to avoid
    both the CPU hotplug race and lockdep recursive locking warnings.
  - Added early check for in_nmi() in wprobe_trigger() before acquiring
    tw->lock to avoid deadlock if interrupted by an NMI.
  - Always evaluate __wprobe_count_func() under tw->lock in
    wprobe_trigger() to eliminate the TOCTOU race for counted triggers.
  - Added "set_wprobe:<wprobe-event>":README requirement to wprobe trigger
    selftests so they are gracefully skipped if CONFIG_WPROBE_TRIGGERS=n.
  - Added clear_trace in trigger-wprobe-hotplug.tc after taking CPU offline
    to avoid falsely matching events logged prior to offlining.
  - In get_offset_of_field(), clarified that the containing structure/union
    type is checked for kflag (renamed mtype to container with comments) and
    verified that the resolved bit offset is byte-aligned.
- Updated all "Assisted-by:" tags across all commits to "Assisted-by: LLM".

Detailed changes are here.

Changes in v18:
 - Drop patch "x86/mce: Fix hardware debug register corruption on task migration"
 - Drop patch "perf/x86, KVM: Prevent host debug register leak into guest OS on NMI".
 - Drop patch "x86/hw_breakpoints: Make DR7 updates NMI safe".
 - Update "Assisted-by:" tags across all commits to "Assisted-by: LLM".
[01/11]
 - Drop perf_guest_in_guest() check and cpu_dr7_seq sequence loop
   since wprobe does not support updating DR7 in NMI context.
[03/11]
 - Add register_wide_hw_breakpoint_cpuslocked() API.
[08/11]
 - Use register_wide_hw_breakpoint_cpuslocked() under cpus_read_lock()
   in __register_trace_wprobe() to avoid CPU hotplug race and lockdep
   recursive locking warnings.
 - Return early on in_nmi() in wprobe_trigger() before taking tw->lock
   to prevent NMI deadlock.
 - Always evaluate __wprobe_count_func() under tw->lock in
   wprobe_trigger() to fix TOCTOU race for counted triggers.
 - Drop redundant in_nmi() check from __wprobe_count_func().
 - Defer data->count decrement to wprobe_trigger() under tw->lock after
   successful hardware update to avoid consuming count on missed triggers
   and prevent counter underflow.
[09/11]
 - Add "set_wprobe:<wprobe-event>":README to requires line in wprobe trigger
   tests so they are skipped if CONFIG_WPROBE_TRIGGERS is disabled.
 - Clear trace buffer after taking CPU offline in trigger-wprobe-hotplug.tc
   to avoid matching watchpoint events logged prior to offlining.
[10/11]
 - Add "set_wprobe:<wprobe-event>":README to requires line in
   trigger-wprobe-btf-typecast.tc so the test is skipped if
   CONFIG_WPROBE_TRIGGERS is disabled.
[11/11]
 - In get_offset_of_field(), rename mtype to container and document that
   it represents the containing structure/union type (handling anonymous
   structures/unions) rather than member's own type.
 - In get_offset_of_field(), verify bit offset is byte-aligned before
   returning byte offset.
 - Add "set_wprobe:<wprobe-event>":README to requires line in
   trigger-wprobe-btf-offset.tc so the test is skipped if
   CONFIG_WPROBE_TRIGGERS is disabled.

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
base-commit: 06e0d3b89da12f24ed5ed434acc8e2cb504f5e4f

Jinchao Wang (1):
      x86/hw_breakpoints: Add arch_modify_local_hw_breakpoint_addr() API

Masami Hiramatsu (Google) (10):
      HWBP: Add modify_local_hw_breakpoint_addr() API
      perf/hw_breakpoint: Add register_wide_hw_breakpoint_cpuslocked() API
      tracing/wprobe: Add wprobe (watchpoint probe) trace event support
      x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
      selftests: tracing: Add wprobe trigger testcases
      tracing/wprobe: Support BTF typecast in fetchargs
      tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  200 ++
 arch/Kconfig                                       |   18 
 arch/x86/Kconfig                                   |    2 
 arch/x86/include/asm/hw_breakpoint.h               |    2 
 arch/x86/kernel/hw_breakpoint.c                    |   51 +
 include/linux/hw_breakpoint.h                      |   15 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   86 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_events_trigger.c                |    2 
 kernel/trace/trace_probe.c                         |   36 
 kernel/trace/trace_probe.h                         |   22 
 kernel/trace/trace_wprobe.c                        | 1707 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    3 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   66 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   23 
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   85 +
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   85 +
 .../test.d/trigger/trigger-wprobe-hotplug.tc       |  153 ++
 .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   37 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |  107 +
 25 files changed, 2731 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-offset.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-btf-typecast.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-hotplug.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe-syntax-errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
