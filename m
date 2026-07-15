Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6CC2E8897;
	Wed, 15 Jul 2026 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079846; cv=none; b=CDonKda7DgsGsR1el1Yuc6Ezk1DMeuNb0D04+4QrjF7ShQ1wgJA7Zi50fLHCTwFji3pXSph+5czI7t2PJM32vhbDluzgv6SxyqIFZJT997tNO1U5M26gDY3s4nbm/T0R6O/yXQsJhEVpvae3pJINUHZb3I97z4hG6UTqcSQGcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079846; c=relaxed/simple;
	bh=HdJ16PbWwtziGIxqJSkxrG3R0YrasbU4/9EtLdT7PvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uLeGzybYMNr7JS6/NwFLQUnt7j+qxeGQtv4LVVlirRfIcZWbwyOHDe0lKCKdjOJ1uX3140gVcDqKeUQ44Wt+7iybs5SARclBHpBJ1VMdOpHwraElXC7FYE72qcTP42LlGcbVMWHQtSlcrypZZdcEgnmfCiASw35Ko8tbcqe9ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwscs4xH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwscs4xH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570081F000E9;
	Wed, 15 Jul 2026 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079845;
	bh=/9dm46gWhRkyn2A6l+59OoIXgM8MWHtfOTJR//oBE58=;
	h=From:To:Cc:Subject:Date;
	b=nwscs4xHRgRMQwuQzxvjuGNNadEa+vbWFbBbO6CuIWLWKKr/ShU3N026fnFw//cQ4
	 DGrMCtQc38oxeBdbW0fPOJsuFBisp5wtONp9ibO7vqMpvsJ0VR+T5Wc2FggAWQZBT+
	 hm6Ok3gZxAy2q+xNx2h7yAo19FRbx6prXF+yzNeoAO1379OIdmWAhIzFu/PdoBU/6m
	 6P1/PnZgO49sWH5TMK2i6a09pgZfBVzUWTGY5mm0m8v4D+cjHQZXJ+wIba7HeJAHea
	 DgHDGGZq+XHCeHv23S5ATZDTfaxyhEMIbwjsdvEBD7WciSq4mreH1BjoVwqt5ko55G
	 5TnwP3P3EbUqw==
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
Subject: [PATCH v7 00/10] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Wed, 15 Jul 2026 10:43:58 +0900
Message-ID: <178407983818.95826.12714571928538799781.stgit@devnote2>
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

Here is the 7th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on a dynamically
allocated objects too.
The previous version is here:

  https://lore.kernel.org/all/176960933881.182525.11984731584313026309.stgit@devnote2/

This version is rebased on top of probes/for-next branch, fold IS_ERR_PCPU
fix and fix some checkpatch.pl related issue (not all, some of them seems
wrong warnings). 
Other updates:
 - Fix a race on wprobe handler using bp->attr.bp_addr instead of tw->addr.
 - Fix modify_wide_hw_breakpoint_local() to update bp->attr.bp_addr.
 - Return -EOPNOTSUPP instead of -ENOSYS. (that is not a syscall function)
 - Update test script to use dentry_kill instead of __dentry_kill.

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

Jinchao Wang (2):
      x86/hw_breakpoint: Unify breakpoint install/uninstall
      x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint

Masami Hiramatsu (Google) (8):
      tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
      x86: hw_breakpoint: Add a kconfig to clarify when a breakpoint fires
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      tracing: wprobe: Use a new seq_print_ip_sym_offset() wrapper
      HWBP: Add modify_wide_hw_breakpoint_local() API
      tracing: wprobe: Add wprobe event trigger
      selftests: ftrace: Add wprobe trigger testcase


 Documentation/trace/index.rst                      |    1 
 Documentation/trace/wprobetrace.rst                |  158 +++
 arch/Kconfig                                       |   20 
 arch/x86/Kconfig                                   |    2 
 arch/x86/include/asm/hw_breakpoint.h               |    8 
 arch/x86/kernel/hw_breakpoint.c                    |  148 ++-
 include/linux/hw_breakpoint.h                      |    6 
 include/linux/trace_events.h                       |    3 
 kernel/events/hw_breakpoint.c                      |   39 +
 kernel/trace/Kconfig                               |   24 
 kernel/trace/Makefile                              |    1 
 kernel/trace/trace.c                               |    9 
 kernel/trace/trace.h                               |    5 
 kernel/trace/trace_probe.c                         |   22 
 kernel/trace/trace_probe.h                         |    8 
 kernel/trace/trace_wprobe.c                        | 1108 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    2 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   68 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   20 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |   48 +
 20 files changed, 1635 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-wprobe.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
