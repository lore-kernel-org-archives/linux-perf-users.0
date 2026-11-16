Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806759;
	b=yzu3D8E+Z6TzamWU2c2OyV26218ScyHcCP3bITCKnWQ7ows77zghDJlbL2USxWevXMMh
	 yp7kMj7z5WFqA4IFhiPkPz3DeqTez4fL4I1RHIHFS/P2JiaUNj5GICMxgh6E2s5p5w656
	 hF/QzmBdoKGTa1pCVsl2QeiR/blEhXfd+w1sSI4NoOQHI+l63b2yn41kjvm7Dxkc372kQ
	 tFUXwFbWL5q5ZRRvkAKhwB71ThFoxWW3fFRx5Z3wzkPTBRhqpL4enYRVTcNp8SMwqH48G
	 63Uuwc8QVcR9SWUruZiJDI6ZBsoQLJviGNX9sVftFX4rV2VAe3j7feBrenuiFBkAMDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806759;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1TRRG836/PhstjI2LzqMCjQ9P8vqxFJS0txPpNicDo0=;
	b=LziY1tpROzsjtQPdRtEEni/i8iaCl7CUZIjm1DZ6W03fGEbBPpJQ3PFp83ws07+3YLn9
	 Np9TrLVKb6XJwVvGRmGf6pQv5/B2gd7OJYtm8OEGTvooFrf4srwUxVTST7AnOuBwDBk4o
	 WV5hQhvo7pTEU1I5QymP/jgANQN0RwmR+MPpbPeHgA/I6/Q2pBDWrE+fwYQ8HTeVG+uCt
	 rV2m9BdOaP/p2waique/cA1P5QP07+BNooQ03l4Pow4fghqVuqV19pf/5UlaauVu6LNXF
	 0m3EWBCEOhI7Bz+qFwy2TZvxio/vr1fhx7zJdcs0AwNnWTeD9xbQ6NEA+9qVcfxx0AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbt89Gzm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFE606A31C;
	Mon, 16 Nov 2026 05:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbt89Gzm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C772D1F000C4;
	Mon, 16 Nov 2026 05:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806758;
	bh=1TRRG836/PhstjI2LzqMCjQ9P8vqxFJS0txPpNicDo0=;
	h=From:To:Cc:Subject:Date;
	b=lbt89Gzmx5vbZyhagLfS6IAcBBNblU+DnrDUonB2OotulJsCrXFWDZN2sQgIWFOae
	 476XJ2h+m5fvgbTMsYlo3Tv4R68fVz9MtM0uQDEzbARmy5GdDg/Cir5gGZQKLL6afk
	 7QYvbbP5wYS2lsn2bLZVAMdpLToRaZTkjIMRrFTUXd10djvSfdI2nTSvXg0vLjOZzk
	 Ue26uOgtoTHQcpN7KF5glIkIk8vQL4znex0MVf5c56AW49wQVVABwf3XpVjsbDVTuq
	 GEoqdiSnZztOqpR7Ht1OQ7ZMaTFjk5A4RFk5VH0rpHxRWXc7XWOT4rZtKzMEUByWft
	 mZM1vVqHW8OOA==
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
Subject: [PATCH v20 00/11] tracing: wprobe: x86: Add wprobe for watchpoint
Date: Mon, 16 Nov 2026 14:25:51 +0900
Message-ID: <179480675130.38065.3086970856119381693.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 20th version of the series for adding new wprobe (watch probe)
which provides memory access tracing event. Moreover, this can be used
via event trigger. Thus it can trace memory access on dynamically
allocated objects too.
The previous version (v19) is here:

  https://lore.kernel.org/all/179101393469.22872.5895666191299551553.stgit@devnote2/

In this version (v20), the series is rebased on the latest probes/core
branch and fixes several wprobe event matching, trigger teardown, and
selftest coverage issues:
- Remove "Assisted-by: LLM" tags from all patches.
- Match and consume the address specification argument in
  trace_wprobe_match() before matching fetchargs so removing a wprobe
  with its full specification works properly, and call
  trace_probe_dump_args() in trace_wprobe_show().
- Do not set EVENT_FILE_FL_SOFT_DISABLED_BIT in wprobe_trigger_free()
  so it follows enable_event semantics and does not prematurely
  silence the watchpoint when removing set_wprobe while clear_wprobe is
  still active.
- Defer trace_event_put_ref() to the private_data_free callback after
  trigger_data_free() synchronization.
- Expand selftest coverage across wprobe dynamic events, triggers, BTF
  typecast fetchargs, and BTF struct offset resolution.

Detailed changes are here.

Changes in v20:
 - Rebase on the latest probes/core branch.
 - Remove "Assisted-by: LLM" tags from all patches.
[04/11]
 - Match and consume the address specification argument in
   trace_wprobe_match() before matching fetchargs so removing a wprobe
   with its full specification works properly.
 - Call trace_probe_dump_args() in trace_wprobe_show() to support
   CONFIG_PROBE_EVENTS_DUMP_FETCHARG.
[06/11]
 - Verify $addr and $value fetchargs in trace output.
 - Add test checks for access modes (r@, rw@), length specifiers,
   symbol offset, and spec-based event removal ('!w:...' and '-:...').
[07/11]
 - Add error_log to requires line in wprobes_syntax_errors.tc.
 - Add testcases for unaligned address (BAD_ACCESS_ADDR) and sibling
   wprobe rejection (WPROBE_NO_SIBLING).
[08/11]
 - Do not set EVENT_FILE_FL_SOFT_DISABLED_BIT in wprobe_trigger_free()
   so it follows enable_event semantics and does not prematurely
   silence the wprobe when removing set_wprobe while clear_wprobe is
   still active.
 - Defer trace_event_put_ref() to private_data_free callback after
   trigger_data_free() synchronization, matching enable_event triggers.
[09/11]
 - Verify events/wprobes/watch/enable transitions to '0*' after
   clear_wprobe fires and to '0' after the trigger is removed.
 - Add test checks for pointer field offset (timer+16), trigger count
   limit (:1), and conditional clear_wprobe:watch:timer+16 in
   trigger-wprobe.tc.
 - Use $arg1 instead of BTF argument 't' in trigger-wprobe.tc and
   trigger-wprobe-hotplug.tc, and drop redundant fprobe README check.
 - Add WPROBE_BAD_FIELD, BAD_DEREF_OFFS, and BAD_IMM test cases to
   trigger-wprobe-syntax-errors.tc.
[10/11]
 - Verify BTF typecast fields (counter= and expires=) in trace output in
   trigger-wprobe-btf-typecast.tc, test direct (STRUCT)$addr->MEMBER and
   (STRUCT)$value->MEMBER typecasts, and verify watch/enable stays '1'
   after removing set_wprobe.
 - Drop redundant fprobe README check in trigger-wprobe-btf-typecast.tc.
[11/11]
 - Verify resolved non-zero BTF offset in trigger file and test
   clear_wprobe with BTF struct offset resolution in
   trigger-wprobe-btf-offset.tc.
 - Drop redundant fprobe README check in trigger-wprobe-btf-offset.tc.

Public branch
-------------
I will push this branch as topic/wprobe-v2 to my tree so that it
can be easily tested.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/wprobe-v2

This is based on linux-trace tree's linux-trace/probes/core.

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
base-commit: 1499a90b5d18ae93d5a8eb47520e7bed1a2b7a0e

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
 kernel/trace/trace_wprobe.c                        | 1743 ++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |    3 
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |   81 +
 .../test.d/dynevent/wprobes_syntax_errors.tc       |   28 
 .../test.d/trigger/trigger-wprobe-btf-offset.tc    |   94 +
 .../test.d/trigger/trigger-wprobe-btf-typecast.tc  |   85 +
 .../test.d/trigger/trigger-wprobe-hotplug.tc       |  150 ++
 .../test.d/trigger/trigger-wprobe-syntax-errors.tc |   40 
 .../ftrace/test.d/trigger/trigger-wprobe.tc        |  135 ++
 25 files changed, 2824 insertions(+), 13 deletions(-)
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
