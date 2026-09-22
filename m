Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366E30ACEE;
	Tue, 22 Sep 2026 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051092; cv=none; b=axuLl9lBnQ+eqFx4Hzwwg7KsfzS4KFUAAqgBnDA8s61VGTBgDlHDNIjW1qYnRcUpLBWY2B0pqydxVSUuMPSEChCarF3gd4LBhBL64DVhdp+5KvU93iWdepbYT+RUIb3XnQwwlUlASNBChWoJz3eh9ZMD+eaVgQ7wwTboy3fTz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051092; c=relaxed/simple;
	bh=i4MkXm/yV1H7XWzWv4Q5RGrm4Zfxy7GnBIxBDDXo1q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwr+eXGbk/4b/WpZvT3iQu5X5fvi/VcsvlLcztVVWUHZDuzDloKl4IUJRJ6q2RzH6LsjkViD1+DffPLVQQw5Kz4BZTUAiHYRb9NlB7WZbSePK2N11WZR2ri2wtTEGblRhzX1aM/EEdAkTq3zcoe520j49I3WHOfxAYnotPsdV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYDthqLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYDthqLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058DE1F000FF;
	Tue, 22 Sep 2026 04:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051090;
	bh=n+bBSkNpi/kRS/hZysyRlmZaIh8zDYpB3ak/PpuETes=;
	h=From:To:Cc:Subject:Date;
	b=RYDthqLDkeCIqovfS0Gk0fcOkqxyxPMgPP/e7rViG1Bo47PJa4sdGKgT8EP+hS1/U
	 Bwp+F82cFsR+CcLTrFcW5b1QCrDqRFyQAYp7kQ+OtoV2LNj8MpN/X1uG3vBmCEvL5L
	 eN0ryc60F7DQSfjCG7ZD/QUlCtcV7ia1t8DhIPH6lnI2hAdTJONpXyFj/k5UX1t0YJ
	 V3Nl4F2VTY9vnIRyNFflWlYWjqjcoDP5RWWXp6sbAJzyNLi/aViMIkh/xLFleAs6J1
	 qMz8hQ2UwnJcxSixRXrFkxTrog/FCe4OgDIH2mQw4J6JPAodDplXImtRC4PCuAh3f1
	 h/sNzQyzmZuDw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>
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
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v17 00/13] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Tue, 22 Sep 2026 13:24:43 +0900
Message-ID: <179005108298.388919.4535333252892590932.stgit@devnote2>
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

Here is the 17th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on dynamically
allocated objects too.
The previous version is here:

  https://lore.kernel.org/all/178939017565.94750.9431053336761330458.stgit@devnote2/

In this version, we address review feedback on KVM x86 debug register
isolation and wprobe triggers:
- Replaced the ad-hoc cpu_dr_in_guest flag with a generic
  perf_guest_in_guest() helper by adding an .in_guest callback to
  perf_guest_info_callbacks. KVM implements this using its existing
  vcpu->mode (IN_GUEST_MODE / EXITING_GUEST_MODE), requiring zero
  additional per-entry/exit state writes.

  (Sean, is this what you meant? I think we can also update the
  perf_guest_state() to check a new state flag, but that may need
  to update other callers.)

- Added dynamic CPU hotplug callbacks to handle CPU offline and online
  events so breakpoints are cleanly unregistered and reinstalled on
  hotplugged CPUs, serialized with cpus_read_lock(). Added a selftest
  (trigger-wprobe-hotplug.tc) to verify this behavior.
- Handled environmental watchpoint exhaustion in add_remove_wprobe.tc
  using exit_unresolved.
- Restored EVENT_FILE_FL_SOFT_DISABLED_BIT in wprobe_trigger_free() to
  prevent wprobe tracepoint leaks upon trigger unregistration.
- Checked trace_find_event_field() before skipping fields named
  "unlimited" in clear_wprobe trigger parsing.
- Added tracepoint_synchronize_unregister() before freeing trigger data.
- Implemented __wprobe_count_func() and wprobe_count_func() wrapper to
  consolidate precondition checks, update tw->missed on failure, and
  update the local hardware breakpoint before updating tw->addr.

Detailed changes are here.

Changes in v17:
[02/13]
 - Drop changes to local_db_save() and local_db_restore().
 - Drop cpu_dr_in_guest per-CPU flag.
 - Introduce .in_guest callback in perf_guest_info_callbacks and
   perf_guest_in_guest() helper to query vcpu->mode.
 - In arch_install_hw_breakpoint(), check perf_guest_in_guest().
[03/13]
 - Drop cpu_dr_in_guest checks in local_db_save(), local_db_restore(),
   and within_cpu_entry().
[04/13]
 - In arch_modify_local_hw_breakpoint_addr(), check
   perf_guest_in_guest() instead of cpu_dr_in_guest.
[08/13]
 - Catch failures when enabling wprobe and call exit_unresolved
   in case hardware watchpoints are exhausted.
[10/13]
 - Add dynamic CPU hotplug callbacks to handle CPU offline/online
   events and serialize wprobe_work_func() with cpus_read_lock().
 - Restore EVENT_FILE_FL_SOFT_DISABLED_BIT in wprobe_trigger_free()
   to prevent wprobe event leaks when triggers are removed.
 - Check whether trigger event has "unlimited" field before skipping
   "unlimited" in clear_wprobe trigger parsing.
 - Call tracepoint_synchronize_unregister() before freeing trigger
   data via data->cmd_ops->free() on registration failure.
 - Implement __wprobe_count_func() helper to consolidate precondition
   checks, optimize shared work_pending logic, and update tw->missed
   when trigger preconditions fail in wprobe_count_func().
 - In wprobe_trigger(), only check __wprobe_count_func() if trigger is
   uncounted, and update local breakpoint before committing tw->addr.
[11/13]
 - Add trigger-wprobe-hotplug.tc to verify wprobe triggers across
   CPU offline and online transitions.

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
      perf/x86, KVM: Prevent host debug register leak into guest OS on NMI
      HWBP: Add modify_local_hw_breakpoint_addr() API
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
 arch/x86/include/asm/debugreg.h                    |   68 +
 arch/x86/include/asm/hw_breakpoint.h               |    2 
 arch/x86/kernel/cpu/mce/core.c                     |   29 
 arch/x86/kernel/hw_breakpoint.c                    |  158 +-
 arch/x86/kernel/nmi.c                              |    7 
 arch/x86/kernel/traps.c                            |   10 
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/perf_event.h                         |    9 
 include/linux/trace_events.h                       |    3 
 kernel/events/core.c                               |    5 
 kernel/events/hw_breakpoint.c                      |   48 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_events_trigger.c                |    2 
 kernel/trace/trace_probe.c                         |   36 
 kernel/trace/trace_probe.h                         |   22 
 kernel/trace/trace_wprobe.c                        | 1668 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    3 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   66 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   23 
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   85 +
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   85 +
 .../test.d/trigger/trigger-wprobe-hotplug.tc       |  150 ++
 .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   37 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |  107 +
 virt/kvm/kvm_main.c                                |   12 
 32 files changed, 2805 insertions(+), 97 deletions(-)
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
