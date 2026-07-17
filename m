Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31B3FCB1E
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293666; cv=none; b=bDP63oVAKjOKMNeIXqsAOnxdHvBXU1F5r7SS2KztNsyv9CA0DdvE6Dz0UxaX1rkUJszo2Tm+br1HgC0fadt2cguE94UaRvRqSKev1QoU2EbOFE/oKQYvQ3/MvHYVrYoPhkKdXmB0CJ5ywWO46PAFZ5OJAw9ESuqTWNbN3rQpM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293666; c=relaxed/simple;
	bh=PBhnT9R86+Lgrugmh2xVUA0skBZMR4Bzkwn46FP4ujY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9kqFhzzyBPdzawiokQ2quKeWS34oZAzPZe6LeZbErO/ZqaPjm86S/v/vDXbWnIPnDptmFX6I4jPv6Y2Vvg1CpmjwpkgexKNTQ3fwvEFgVdCXXjM95Rrid1ef9C5D5b7NuOUCxkVfMaltSec6wXMww9oQCqDJ+gbVTEyMT7Zdqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojrEWIK6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojrEWIK6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so4418506a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293664; x=1784898464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YAVyRkTkPaWk8kIYvBYAepg/O4FB7G2KaVbrN0SgkUc=;
        b=ojrEWIK6hQwJGiq4eK8Dloh1pfU5NKHC6nc1v/8eWlLpuQueOENXZIwDFAeTH6tkbb
         TlCbFCAZLea17qbN9TyF1JSEcj7unHzZIgBIJZlMX4Yp5B/+Z0+Tuc2WxJDPFb6S07Fv
         /jv2K2G9OR7lRkdBW7bqTsrBjJgaQ5wdmvqdoI2EEMGACOgqdaLmNItumKF7d/gSbDPq
         Ch/PNjYpqzPGFMiZWlSkO5RwUQAA6XR5Y+hKKbIGjkbfkoJLFzxtmuKXWJWwKMu+3NRQ
         J+ndyPXHmuivQTGwdaeZZAnDn3O1hY790VWF3IGUqZ9prcaT/s54dSr4Pbz7DGgQCeYr
         S/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293664; x=1784898464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAVyRkTkPaWk8kIYvBYAepg/O4FB7G2KaVbrN0SgkUc=;
        b=fyc0qWRo920S/K2I3gJC/7YMhMn+Y1yhPwF3oNirGsWkAF6WAGeRUN7nVkHhw6vBHt
         Bmi6V8WFKDdu9SHMI6w59yp2Iu+CPg+3P6XNn6iIrEMK9d5qOoE3ZjpoBsZtqQG4IHzD
         zkcPL8lQiFK8q97sKIbJ733RKRoPQEuca+gped0ipVrR6nNUiBH3QRY+zNOU8WcT+0bQ
         iEzOcexF+pScln5q02lyAz+9RHd30INiOxoFeLceKVN+VIWjVYqRM57WsGJ+0xFtKXnt
         sbeTLlacIjpoYakjSVeeT7C93zdqHRxS1feS699QJ+DLQlu+WRASfvrq15rwrSY1y/ae
         sEdg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6YhsBozAvA5yQRK3CeXf6LFmTbUCUm/9RlG9RJHVrQYlC8tlJUABFH92ctMjmQxqLfZTtt5fVRy8gGAJ8n94B@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51D5c/Aan3JeTZ77pozdJuC43zayuYkDhO/1AqayHgNwnZuWp
	3eBLI1QVfrkN5uNXRlrbcCMonGU12xua1EjJqkOafEmjgyLVwBnjJ2wT
X-Gm-Gg: AfdE7cmZyYKHNAcilqB2GLL1AYsIcfOVjgAsxDLVwPuHsWmx9rKw9+DwicEQVH5yLak
	+5FwG0utpneUpZPnYnHqypCmvtoQzLuPZHJXOFDh8o6U/4wB02CqFSi7gtVWQYi7g1OCrzE3f8E
	1oEk48AGPtri/9Qngz2EJTgm+ns4lY+CpOKfaD/TVb1UeqwHtzXSb4WhdApzMH2JJJMWyuE+vSR
	nue0OmgIvz5w7aELt+P1Kio/9d3UcqHrTySnV81NFLiZaHOxW9nuTEs7LfbF3u/16zb9m9r08+A
	xrLKqpz1SNixT1QmsDikuriGsWEYDTkubcdUojYmeIwNhwul2d+h50LsfXU40LiP+swuq6Qnxd/
	qJSbCiUosasygDWsBs+iVjeg5/ibEuFHAwikCjxkFUSp/zGBWl0sI3ppO6csF94LDnSxPpeGZeR
	syGCwxailRB1Qf
X-Received: by 2002:a17:90b:3904:b0:387:e0db:bc34 with SMTP id 98e67ed59e1d1-38e4b5793d2mr2622266a91.42.1784293663521;
        Fri, 17 Jul 2026 06:07:43 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29e340esm5521158c88.5.2026.07.17.06.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:07:42 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/13] Documentation/dev-tools: document KWatch
Date: Fri, 17 Jul 2026 09:07:26 -0400
Message-ID: <20260717130726.1904101-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe what KWatch is for, how it compares with KASAN and KFENCE,
the debugfs configuration interface, the watch expression syntax,
how to read hits from the trace buffer (including after a crash),
and the current limitations.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 Documentation/dev-tools/index.rst  |   1 +
 Documentation/dev-tools/kwatch.rst | 207 +++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+)
 create mode 100644 Documentation/dev-tools/kwatch.rst

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 59cbb77b33ff..f4c748da63db 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -30,6 +30,7 @@ Documentation/process/debugging/index.rst
    ubsan
    kmemleak
    kcsan
+   kwatch
    lkmm/index
    kfence
    kselftest
diff --git a/Documentation/dev-tools/kwatch.rst b/Documentation/dev-tools/kwatch.rst
new file mode 100644
index 000000000000..e58f3185ebbd
--- /dev/null
+++ b/Documentation/dev-tools/kwatch.rst
@@ -0,0 +1,207 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+KWatch - Kernel Memory Watchpoint Tool
+======================================
+
+Overview
+========
+
+KWatch is a runtime-configurable debugging tool for locating kernel memory
+corruption. It arms hardware breakpoints (watchpoints) on a target address
+while a chosen function is executing, and reports the exact instruction that
+touches the watched memory, together with a stack trace, through a
+tracepoint.
+
+Unlike shadow-memory sanitizers, KWatch does not detect invalid accesses in
+general; it answers a narrower but common question during corruption hunts:
+"who writes to this address?". This includes in-bounds logical overwrites
+that KASAN cannot see, because the rogue writer modifies valid memory
+through a valid pointer, just at the wrong time or with the wrong data.
+
+Comparison with other tools:
+
+* KASAN detects out-of-bounds and use-after-free accesses, but reports the
+  symptom (the invalid access), not the writer that corrupted the data
+  earlier. It requires a rebuild and has significant CPU and memory
+  overhead, and its redzones perturb memory layout, which can hide
+  timing-sensitive bugs.
+* KFENCE is a low-overhead sampling detector for slab objects; it cannot be
+  pointed at one specific address.
+* Hardware breakpoints via kgdb or perf can watch an address, but only a
+  fixed one, system-wide, for the whole run. KWatch resolves the address
+  dynamically at function entry (for example "argument 2 of this function,
+  plus offset 8, dereferenced once") and disarms it again at function exit,
+  so short-lived and per-invocation objects can be watched too.
+
+KWatch has near-zero overhead while armed: the watched function pays for
+one kprobe/kretprobe pair plus programming of the debug registers; the rest
+of the system runs at full speed.
+
+Requirements
+============
+
+* ``CONFIG_KWATCH=y`` or ``m``. The Kconfig symbol depends on
+  ``CONFIG_PERF_EVENTS``, ``CONFIG_DEBUG_FS`` and an architecture that
+  provides ``HAVE_REINSTALL_HW_BREAKPOINT`` (currently x86 only).
+* Resolving symbol names in watch expressions requires ``CONFIG_KWATCH=y``
+  (built-in); a module can only watch absolute hexadecimal addresses.
+
+Usage
+=====
+
+KWatch is configured through a single debugfs file::
+
+    /sys/kernel/debug/kwatch/config
+
+Writing a configuration string starts a watch session (stopping any previous
+one); reading the file shows the active configuration and hit-rejection
+counters. The configuration is a whitespace-separated list of ``key=value``
+tokens:
+
+=================== ==========================================================
+Key                 Meaning
+=================== ==========================================================
+``func_name``       Function whose execution opens the watch window.
+``func_offset``     Instruction offset inside ``func_name`` at which the
+                    watchpoint is armed (default 0 = function entry).
+``watch_expr``      Expression describing the address to watch (see below).
+``watch_len``       Watched length in bytes: 1, 2, 4 or 8 (default 8).
+``depth``           Recursion depth at which the window opens (default 0).
+``max_watch``       Number of hardware watchpoints to preallocate
+                    (default 4).
+``max_concurrency`` Maximum number of tasks concurrently inside the watch
+                    window (default 256).
+``duration``        For global watches: seconds until automatic stop.
+=================== ==========================================================
+
+Watch expressions
+-----------------
+
+The address to watch is computed at function entry from::
+
+    watch_expr={base}[+-offset][->[+-]offset]...
+
+* ``base`` is one of:
+
+  - ``arg1`` ... ``arg6``: a function argument (register calling
+    convention). These are only meaningful at function entry, i.e. with
+    ``func_offset`` unset; combining ``argN`` with ``func_offset`` reads
+    the argument registers mid-function, where they no longer hold the
+    original arguments,
+  - ``stack``: the kernel stack pointer at the probe point,
+  - an absolute hexadecimal address, e.g. ``0xffffffff81234567``,
+  - a global symbol name (built-in KWatch only).
+
+* ``+offset`` / ``-offset`` adjusts the current address.
+* ``->offset`` loads the pointer stored at the current address (via
+  ``get_kernel_nofault()``) and then applies the offset. Up to four chain
+  elements are supported; offsets must be explicit (``->`` alone is
+  rejected).
+
+Given::
+
+    struct some_struct {
+        struct some_struct *ptr;    /* offset 0 */
+        int num;                    /* offset 8 */
+    };
+
+    void target_function(struct some_struct *arg1);
+
+typical expressions are:
+
+=========================== ==============================================
+Expression                  Watches
+=========================== ==============================================
+``watch_expr=arg1``         ``&arg1->ptr`` (the pointer field itself)
+``watch_expr=arg1+8``       ``&arg1->num``
+``watch_expr=arg1->0``      ``&arg1->ptr->ptr`` (one dereference)
+``watch_expr=arg1->8``      ``&arg1->ptr->num``
+``watch_expr=0xffff...+8``  absolute address plus 8
+=========================== ==============================================
+
+Example: catch whoever overwrites ``arg1->num`` of a function while that
+function runs::
+
+    echo "func_name=target_function watch_expr=arg1+8 watch_len=4" \
+        > /sys/kernel/debug/kwatch/config
+
+Watching global variables
+-------------------------
+
+A global variable has no natural function window. When ``duration`` is
+given without ``func_name``, KWatch starts an internal anchor kernel thread
+that sleeps inside a dummy function, and uses that function as the window::
+
+    echo "watch_expr=jiffies_wobble duration=60 watch_len=8" \
+        > /sys/kernel/debug/kwatch/config
+
+The session tears itself down when the duration expires.
+
+Reading hits
+------------
+
+Hits are emitted as the ``kwatch:kwatch_hit`` tracepoint, which is safe in
+NMI-like contexts where printk is not. Each event carries the timestamp,
+the instruction pointer, the watched address and a short stack trace::
+
+    echo 1 > /sys/kernel/debug/tracing/events/kwatch/kwatch_hit/enable
+    cat /sys/kernel/debug/tracing/trace_pipe
+
+If the corruption crashes the machine, the ring buffer can still be
+recovered:
+
+* ``echo 1 > /proc/sys/kernel/ftrace_dump_on_oops`` (or the
+  ``ftrace_dump_on_oops`` boot parameter) dumps the buffer to the console
+  on an oops.
+* With kdump, the buffer is present in the vmcore and can be read with
+  ``crash> trace``.
+* ``CONFIG_PSTORE_FTRACE`` persists it across reboots on supported
+  platforms.
+
+Limitations
+===========
+
+* Functions that run in a genuine NMI(-like) context are rejected at
+  function entry; rejected invocations never open a watch window and are
+  counted in the ``nmi_rejected`` field of the config file. Watching
+  functions reachable from NMI handlers is out of scope.
+* The number of concurrent watchpoints is bounded by the CPU's debug
+  registers (typically 4).
+* Cross-CPU re-arming of a watchpoint is rate-limited per CPU: the local
+  CPU is always re-pointed, but the broadcast to other CPUs is throttled
+  so a very hot watched function cannot storm the system with IPIs. While
+  a broadcast is suppressed the other CPUs keep watching the previous
+  address, so a writer that runs on another CPU during that window can be
+  missed; the number of suppressed broadcasts is reported in the
+  ``arm_ipi_suppressed`` field of the config file. KWatch therefore
+  targets functions that are entered at a moderate rate.
+* If the target address cannot be resolved at arming time (for example a
+  ``get_kernel_nofault()`` failure on a swapped or unmapped page), the
+  watchpoint is not armed for that invocation.
+* Offsets in watch expressions are static; dynamic indexing such as
+  ``arg1->ptr[arg2]`` is not supported.
+* If a task is torn down while still inside the watched function without
+  the function returning (an oops or BUG in the window, which abandons the
+  stack), its watch window is not closed until the session stops. This is
+  the same best-effort cleanup that applies to every resource a task holds
+  when it dies abnormally. Do not target the task-exit path itself.
+* arm64 is not yet supported: stepping over a hit that has a custom
+  overflow handler needs a generic mechanism in the arch code, which is
+  planned as a follow-up series.
+
+Implementation notes
+====================
+
+The implementation lives in ``mm/kwatch/`` and is split into a control
+plane (``core.c``, the debugfs interface), an execution plane (``probe.c``
+and ``deref.c``: kprobe/kretprobe window management and address
+resolution), and a resource plane (``hwbp.c`` and ``task_ctx.c``).
+
+Hardware watchpoints are preallocated as perf events on every CPU and
+re-pointed at hit time with ``modify_wide_hw_breakpoint_local()``, a new
+hw_breakpoint API that updates the breakpoint on the local CPU without
+releasing its slot; other CPUs are updated by asynchronous IPIs. Per-task
+window state is kept in a fixed-size, lockless open-addressing array
+claimed with ``cmpxchg()``, so the hit path performs no allocation and
+takes no locks, which keeps it safe in atomic and NMI-like contexts.
-- 
2.53.0

