Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80A2165EA
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292643; cv=none; b=Kw9cUGmxMgWrPQ6PGJpdWje/wjrd2HU1DkvNyVGNP4lVNbPTTpW/nVYNoZoNIOuYwhQWYaPmii6rjxaRcItMTRCsa0EqyK1uI9oGBz82shpUxlxR4RlM+F098HzlcB53ZBQ3GLDKKlMAJVArzwmSLUwa5s7xNaeN/2C5k23clic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292643; c=relaxed/simple;
	bh=wo63J8aoMJPwbJyfmtJRvaeJhv+1yDR2oGQQxP+sIx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjVvRdrgq3mW9fdu4oh3L22NkQSy7tHjGogIqI36ETB8Ik7kokPGKxbVir3tGwk8G5ynTfrk9HslC7yMorXF1Vj7v84fAaQiUnrrjt1RMH8KPKZTRYEFvS76sgGqJqR27PdF7GpaX8ll+w+nSoA44R9G/NyzPP8wLozqN+kkI2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOHTVxRF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOHTVxRF"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38deea72eebso5551586a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784292640; x=1784897440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lSX8U8NY9C2KfUYppo4oUi4enDEGr7YRVa/nQmIFOYc=;
        b=AOHTVxRFD2C4ZCoLftVgQSXL4C8tYjLeV+DDFQaN1TIq9nQZBTHspB9diVmJz399lR
         ZqiI+VtHH3NhMl4IXAoRXUTCVbyGPHAALrg431Gw/jdx592dn2t97k/SFFK6RmNcNDyP
         aeMvNf+k1yHyN/MH/2++nE0QLaf4U6RGzbMiidj4NP44oAc/vzbHNt7eKFMb78PYqvn2
         SayFmiB8v0shEdsk0za9qcnwUdajt2Bt990U+P4kw4Ah10durmp4orOIptoo9R8spKtg
         Udw9P3ENDcYG8bAFd0ZPq/JF2pC7NPj1AKR7JGp1OEvB27NEpqCvaCygeq9ysab8BpZS
         5Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784292640; x=1784897440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSX8U8NY9C2KfUYppo4oUi4enDEGr7YRVa/nQmIFOYc=;
        b=Lbo7les9prZK9hqqySxDRRvYLlWJ8fQcZpypPvO2e5llXDA+zEh2tEhQtsXChvs/D8
         kDceMXx/XKq3VQYc/5yGWsynz6tAM9b5OiTNbd2TclrMaYpwQ4bkD2p2DtRXSUb1fto+
         W3XA8cnEnEsEol+vQH0IizwJJ3mQqABfRje6n3Q2o6BWcvya/6hMT7K/4twYwmnc1yCy
         YpyH2kw0h8t1p4aaD/aSiAKgxZSm+s7C8uiVDfRBkdc7ry4huS3tfcUcgiZeOZxHC30I
         XgrpETxJIQhJi0dUQ6rWa+d7QrRB0Q6NKvYGWie4YdKc1rVkuvNzs+bTHOLS85Nv9UM2
         JL9g==
X-Forwarded-Encrypted: i=1; AHgh+RogoFKXo5hKxdKN250xYKAS0tf9rJ2GJWTEUQHrohgarDLURA35D2WSA80yDKmRVmcheRK20PCPY27UNTEemX+P@vger.kernel.org
X-Gm-Message-State: AOJu0YwRikWuaURF5vpcE96skDKpqI0EDcSMUongXnY2woLgnv2B++Ii
	fjVcLlIHUDgT6OkG6fGUAgtX+cZAyid2BynTiJGNvLCi7JnfWAW/ZnbV
X-Gm-Gg: AfdE7cm55mDbLpZ/s5cZIS3X0tTscZDfWdeOe6UCRCxPij02RuNKLMGo1rYxWlcEIS+
	x0DLVR/Oaj7mFhunAIn2MLhSVqf0365ULkMGEmRFetisBBnQs+jvZXoOVDE6I5DlWir1UkqwkVc
	qYFx2/M0l8eZzz+OA2iS8nyvy6ZbYwi2CnrEwstzi8oM2/GUl7DW3wL2nlLrG6NEogzT7kkyVYI
	f2exBT+Nu2HKeCVzFwH15Czh4W5DR9jofUWxA4u23w9E6ZiLtGY/gzMc+IJH79ADyuaa19TIEPz
	7bfycKSZ/mBKqBNajXUWYnPn81ZJCQfa/Oco3elF9al15JrtcDNFOZwBfoNj9S8R7lF8h9rw1A8
	ai/RBSrUbzHlaMKSvuK5h4x7R1Sn/mxfl85jMaxn3tXmlSVP526hsMvD3xcv0aY0lrZiWnpm9yj
	UuYA==
X-Received: by 2002:a17:90a:e7c1:b0:38d:e28e:a639 with SMTP id 98e67ed59e1d1-38e4b530569mr2235384a91.24.1784292640102;
        Fri, 17 Jul 2026 05:50:40 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dd90fsm7265641eec.22.2026.07.17.05.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 05:50:39 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 00/13] mm/kwatch: dynamic hardware watchpoints for hunting memory corruption
Date: Fri, 17 Jul 2026 08:50:23 -0400
Message-ID: <20260717125023.1895892-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motivation
==========

The hardest memory corruption bugs are the silent ones: a rogue writer
scribbles over a live object through a stale pointer or a race, and
the victim crashes in a code path far away from the culprit. Any
single developer hits such a bug rarely, but across the kernel's code
base and install base they keep arriving, and each one is
disproportionately expensive to localize. The question to answer is
"who wrote to this object, and from where?", and it is hard to get at
with the existing tools:

 - The kernel's own reports - an oops on a clobbered pointer, a
   BUG_ON, a list-corruption warning - fire at the victim's access,
   not at the corrupting write.
 - KASAN/KFENCE catch memory-safety violations: out-of-bounds
   accesses and use-after-free. But they have a blind spot: a
   corrupting write can be fully memory-safe - a *valid* pointer, in
   bounds, to a live object, written just at the wrong time or to the
   wrong place - and then they stay silent by design. And even for
   the bugs they can catch, KASAN's rebuild, overhead and redzones
   change timing and layout enough that racy corruption often no
   longer reproduces.
 - Hardware watchpoints can catch the writer, but they are scarce
   (four slots per CPU on x86), they watch a fixed address, and
   registering/releasing one may sleep, so they cannot be managed
   from atomic context. Each way of using them also has practical
   constraints: the in-kernel API means writing a custom debugging
   patch for each hunt, kgdb needs a debug console and stops the
   whole machine at every interaction, and perf drives watchpoints
   from userspace, so the address must be known before the run.

Design
======

KWatch arms a hardware breakpoint on the exact address a function
invocation is operating on, for exactly as long as that invocation
runs. Four key designs make this work:

1. Hardware breakpoint pool. All breakpoints are preallocated and
   parked on a harmless dummy variable. Arming re-points one at the
   target address, using a small "reinstall" operation added to the
   hw_breakpoint layer; releasing parks it back on the dummy. The
   pool is managed locklessly and the arming path calls no sleeping
   API, so a breakpoint can be armed from whatever context the
   watched function runs in - real NMI excepted - and a hit can
   fire and be handled in any context.

2. Function-scoped watch window. A kretprobe pair opens the window
   at function entry - resolving the target address and arming a
   breakpoint - and closes it on return, releasing the breakpoint.
   A depth setting picks which level of a recursion opens the
   window, and hits are validated against the arming task and
   depth. The window is also what makes the scarce hardware
   affordable: every corruption happens within some execution
   context, so a breakpoint is armed only while that context runs.
   Global variables can also be watched without a window, in a
   time-bounded anchor session.

3. Watch expression engine. At each entry it evaluates the
   configured expression to resolve that invocation's target
   address. The base can be a function argument, the stack pointer,
   a symbol or an absolute address; offsets and pointer
   dereferences chain on top, so heap fields reachable from an
   argument, globals and stack slots are all expressible.

4. Painless deployment. KWatch is fully self-contained and can be
   built as a module, loaded only when a corruption hunt needs it.
   It is just a debugfs entry until a watch is configured; after
   that only the watched function pays the kprobe cost and the
   rest of the system runs at full speed, which keeps KWatch usable
   on busy, highly concurrent systems.

Together: point KWatch at the suspect function and field with a
single debugfs line, reproduce the bug, and the tracepoint reports
the writer - the writing instruction and its stack trace.

A real case: dummy_hcd
======================

Gadget requests were completing through a clobbered req->complete.
Months of KASAN-enabled syzkaller runs produced only downstream
symptoms, with no lead on the root cause. Watching the victim field
with KWatch:

  func_name=usb_gadget_giveback_request watch_expr=arg2+56 \
  watch_len=8

caught the writer in the act:

  kwatch_hit: KWatch HIT: time=370.399836 ip=memcpy+0xc/0x30
              addr=0xffff888109cf5218
   => usb_ep_queue+0xf1/0x3c0
   => raw_process_ep_io+0x5e4/0xd80
   => raw_ioctl+0x251c/0x41c0
   => __se_sys_ioctl+0xfc/0x170
   => do_syscall_64+0x174/0x580
   => entry_SYSCALL_64_after_hwframe+0x77/0x7f

on the same request that crashed an instant later - the crash RIP was
the just-written garbage value. Root cause: dummy_queue()'s single
shared fifo_req is struct-copied over while dummy_timer() is
mid-giveback. A fix based on this diagnosis has been picked up
into the USB tree [1] - KWatch's part was answering who clobbers
the pointer, and from where.

Series layout
=============

Patches 1-4: a minimal "reinstall" operation for hw_breakpoint.
Re-pointing an already-installed breakpoint from a kprobe handler is
not possible with the current API (register/unregister may sleep and
rebalances constraints); reinstall lets the arch rewrite a slot it
already owns, and modify_wide_hw_breakpoint_local() exposes that for
the local CPU - cross-CPU propagation is the caller's job (KWatch
uses async IPIs). Patch 4 is Masami Hiramatsu's work, carried
verbatim from his current wprobe series.

Patches 5-11: KWatch itself, in mm/kwatch/ (patch 7 exports
stack_trace_save_regs() for the modular build).

Patches 12-13: KUnit tests and documentation.

Testing
=======

The dummy_hcd hunt above exercised the function-window path against
a live reproducer. Global watching, session auto-stop and the KUnit
parser suite were verified end to end under QEMU on x86_64. Both
KWATCH=y and KWATCH=m build.

arm64
=====

This RFC deliberately targets x86 only. On arm64 the watchpoint
exception fires before the access, so the arch must single-step over
hits, and today it only does that for the default overflow handler.
Rather than hardcoding a KWatch hook into arm64 core code, I plan a
follow-up that adds a generic way for in-kernel breakpoint consumers
to request stepping, and arm64 support on top of it (a prototype
exists).

Changes in v2
=============

Addressing Steven Rostedt's review and the Sashiko AI review findings
on v1 [2]:

Tracepoint (Steven Rostedt's review):
 - u64 field first, count last, and the stack trace is a dynamic
   array sized to the captured depth (also fixes leaking the
   uninitialized tail of the fixed array).
 - div_u64 in TP_printk for 32-bit builds.

Scope:
 - Drop access_type: KWatch now always watches for writes. It is a
   corruption localizer, and write is the one type that matters for
   that job.

hw_breakpoint prerequisites (patches 2-4):
 - Restore the compiler barrier before the cpu_dr7 update on the
   disable path, lost in the install/uninstall unification.
 - Always push the AMD DR address mask, so a reinstall from a masked
   range breakpoint to an exact one clears the stale mask.
 - Patch 4 updated to Masami's latest version (wprobe v8): parse into
   a temporary arch_hw_breakpoint to keep error paths side-effect
   free, sync the logical bp->attr fields, -EOPNOTSUPP over -ENOSYS.

Runtime fixes:
 - Rate-limit only the cross-CPU arm broadcast, never the local
   re-point; suppressed broadcasts are counted and reported as
   arm_ipi_suppressed (was: a rate-limited arm skipped the local CPU
   too, missing the current window entirely).
 - The hit handler reports the per-CPU breakpoint address instead of
   the shared attribute another CPU may be re-pointing concurrently.
 - Release the context slot claimed by an entry that races the
   register/epoch-publish window (slot leak).
 - Clamp the context pool size to [256, 32768]: a u16 request above
   32768 wrapped roundup_pow_of_two() to zero.
 - nmi_rejected and arm_ipi_suppressed are session-scoped now.
 - The anchor thread sleeps in TASK_IDLE so a long session no longer
   inflates loadavg.
 - The debugfs read path takes the control mutex against concurrent
   writes and auto-stop.

Kconfig / tests / docs:
 - depends on KPROBES/KRETPROBES/STACKTRACE instead of select.
 - KWATCH_KUNIT_TEST now explicitly depends on KWATCH=y; the parser
   test gets a width-appropriate literal for 32-bit.
 - Document that argN bases are only meaningful at function entry,
   the IPI rate-limit consequences, and best-effort cleanup when a
   task dies abnormally inside the watched function.

Relationship to KStackWatch
===========================

KWatch grew out of KStackWatch [3], an earlier tool aimed at stack
corruption only, and has been substantially reworked since. The
hw_breakpoint prerequisites are carried over from that series.

Major changes since the KStackWatch v8 posting:

 - The watch expression engine widens the watchable range from the
   stack to any address expressible via function arguments, globals
   or stack addresses plus pointer dereference chains.
 - The task_struct and scheduler hooks are gone; KWatch is now fully
   self-contained, as described above.
 - A time-bounded anchor session was added for watching global
   variables (duration=N, auto-stop on expiry).
 - Hits are reported through a tracepoint carrying a stack trace
   instead of printk: safe in NMI-like contexts, and recoverable
   after a crash (ftrace_dump_on_oops, kdump, pstore).
 - Invocations in real NMI(-like) context are detected and rejected,
   with a visible nmi_rejected counter.
 - arm64 support and the auto-canary, profiling and test-module
   extras were dropped from this series to keep it reviewable.

Feedback on the design, the implementation or the usage is welcome;
if you are staring at a corruption that the existing tools cannot
attribute, give KWatch a try, or simply Cc me - I am glad to help.

[1] https://lore.kernel.org/all/20260714064829.172098-1-wangjinchao600@gmail.com/
[2] https://lore.kernel.org/all/20260714182243.10687-1-wangjinchao600@gmail.com/
[3] https://lore.kernel.org/all/20251110163634.3686676-1-wangjinchao600@gmail.com/

Jinchao Wang (12):
  arch: add HAVE_REINSTALL_HW_BREAKPOINT
  x86/hw_breakpoint: Unify breakpoint install/uninstall
  x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
  mm/kwatch: add watch expression parser and dereference engine
  mm/kwatch: add lockless per-task context pool
  stacktrace: export stack_trace_save_regs()
  mm/kwatch: add hardware breakpoint backend
  mm/kwatch: add probe lifecycle runtime
  mm/kwatch: add anchor thread for global watchpoints
  mm/kwatch: add debugfs control plane
  mm/kwatch: add KUnit tests for the watch expression parser
  Documentation/dev-tools: document KWatch

Masami Hiramatsu (Google) (1):
  HWBP: Add modify_wide_hw_breakpoint_local() API

 Documentation/dev-tools/index.rst    |   1 +
 Documentation/dev-tools/kwatch.rst   | 207 ++++++++++++++
 MAINTAINERS                          |   8 +
 arch/Kconfig                         |  10 +
 arch/x86/Kconfig                     |   1 +
 arch/x86/include/asm/hw_breakpoint.h |   8 +
 arch/x86/kernel/hw_breakpoint.c      | 163 ++++++-----
 include/linux/hw_breakpoint.h        |   6 +
 include/trace/events/kwatch.h        |  68 +++++
 kernel/events/hw_breakpoint.c        |  43 +++
 kernel/stacktrace.c                  |   2 +
 mm/Kconfig                           |   1 +
 mm/Makefile                          |   1 +
 mm/kwatch/.kunitconfig               |   9 +
 mm/kwatch/Kconfig                    |  28 ++
 mm/kwatch/Makefile                   |   4 +
 mm/kwatch/anchor.c                   |  85 ++++++
 mm/kwatch/core.c                     | 324 ++++++++++++++++++++++
 mm/kwatch/deref.c                    | 174 ++++++++++++
 mm/kwatch/deref_test.c               | 146 ++++++++++
 mm/kwatch/hwbp.c                     | 388 +++++++++++++++++++++++++++
 mm/kwatch/kwatch.h                   | 101 +++++++
 mm/kwatch/probe.c                    | 275 +++++++++++++++++++
 mm/kwatch/task_ctx.c                 | 125 +++++++++
 24 files changed, 2115 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/dev-tools/kwatch.rst
 create mode 100644 include/trace/events/kwatch.h
 create mode 100644 mm/kwatch/.kunitconfig
 create mode 100644 mm/kwatch/Kconfig
 create mode 100644 mm/kwatch/Makefile
 create mode 100644 mm/kwatch/anchor.c
 create mode 100644 mm/kwatch/core.c
 create mode 100644 mm/kwatch/deref.c
 create mode 100644 mm/kwatch/deref_test.c
 create mode 100644 mm/kwatch/hwbp.c
 create mode 100644 mm/kwatch/kwatch.h
 create mode 100644 mm/kwatch/probe.c
 create mode 100644 mm/kwatch/task_ctx.c

-- 
2.53.0

