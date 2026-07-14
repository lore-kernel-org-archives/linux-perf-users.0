Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2165A43D4F5
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054059; cv=none; b=qKR0V5OxFAw8BbE4ejBpU688x4hPePoRk2gas09ScHVz+ct12yKGOOhTLGX4NSfxjUes9xH6a7hity83s4eoP3eS98Krz1zvoWT/yL40/l6mgtJDqldZ77IuFjXGq/W4/WzKOkY3WaVe+4FnO1rD1llk2qx05fXWYwcSQNz7GLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054059; c=relaxed/simple;
	bh=8cvRcaXstSBGACqv7boyM3j+NafF3PmGmAgbjgb8q7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFwdCCfoDbh5AD6ze0hd9c9Uex3YSO58TO5PkbO0EZu3rySXuMWpcgKNc1ZFyPoXq6Sghq9V3rPK9wYA9RX3aZFx4ZBHHFD5axyv+e9Yho+nU9d9Y+HRoSbjxldHLw3vfI3+FOdOKs2PzBaoBBFSA8ZH9k5oXtqnaos+7Fe0158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foCLSVWX; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foCLSVWX"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90327237340so9742726d6.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784054056; x=1784658856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZmmWwuvjQogVDd2VSBmXRJatjjzPeEuGhwyiPs8S0po=;
        b=foCLSVWXdPwvHUeaP27bBBA6R4RmiWlhOM2uSSf6ntCmhrE7CqfT/pZVCfBzTcD2hd
         wvF2siy4RsrAO6RvPJiIE64AeWOhyJhG140FOTW7RhrEqSXIUOQawMgUVDqdNRN16Lrv
         3PyQhPy3JdKmVFRgT1FtMsIDzvKIcBnQ7HHaqQhqGBNMguQBdvuCQ1hlBCK4TjNe1G6B
         sJ3fMsWNlgjXO4lVmZWjmoh5AYZ6ufLjltGW0pJMmEwTiGwTy1JGjq1rhP/389d5a583
         cgs8KiTBj0W6VV0Js8A9Kmm+JXCtcpWmv6SqItwqtjxQ6qFP2mC2o2bDoL52igvYsd0S
         6J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054056; x=1784658856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZmmWwuvjQogVDd2VSBmXRJatjjzPeEuGhwyiPs8S0po=;
        b=Xrx/jKi9iT1Fp2pFphX/0uqFaob7erRCBq7x/+dlNePNbYtZbORlQidch+lDzEKmmx
         Yw5dVPVhIIBRgXSUmtHKMeOMkeI8Qk3HlIQez4s9/8LL4/U4MnwYly/rn/XcS7CoCp50
         IQ+pdmOnQNJCygI0LGLmv3F+xG4r4jIiaS88DScx7sGa7sk4N6hJUANMcdllRtd+7/ym
         4Ghb+S+g9nujxIlJuvXHqdY+3ZZYzFYONFk7+Jb2YwpuJRZ5sfP2KCJWrrdLMFBBxAFT
         +J5yogA4l8dyzSbdkCSwZdCYiALBrulSKF4vT1eNwbvRa7eLlTDZIQXEb0pPxtssBfpo
         pdwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrH8HVkemjC116QsRIZ0BnMrgKGFNpMUJUhn5nFPoafF0UWBZrl6c1GrU/bt5g7qHM9lLcw+kIykQynXNJVaD8E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jqfwzlAOw6FnjTGCPsOnnkHe18AGJF86VMpz/abrsD3BfkYR
	moyKoXFfqjlfclWUYFGu8uHn1H91UMLYef5RBE1wu3MBFWHRtpgVSq6F
X-Gm-Gg: AfdE7ckJycpMP1tMFG1zMXnOUJLb1RNNfsdzNWyP7OfTQ34ghZ+cMKGIT2CUlFCuQfu
	DjmVFRKrJzwh1iJ2xOW9ra+jRIqfiTA7PRN0oz5qy6EDEzaGXGmRktD9pdK3fbDNjSF2jVE0rEo
	qK2LHx8FV9r8R4f5RxNbKx9zd64q11frUbROE+nIFVIrOW0nX7N+cpuVVGIquNG1JrxXpLYJZSG
	L+7xzs/LxJmPFbnT1hEyPR0I3WswDTE3hKeOS/mVXrvIjBmNi9mfLVqmVd6DNfpyg8zVcyaZSoc
	91CbjiLPSCVVn0WgWdvWrC793UCnukuIe9c2Sx7kI+b2KreAmjiY7ZyKZtjy6fzrS6sJfky43De
	hUE7o2lUHEnMzAPKBNxkYecb7yqbZKEwK2yL+TJMhcj5/l7xr824NUQBF+FzBuHI2dsnLeL01VX
	hH/OtvCmUisZeNbd/hak1eFH18DFxhjroUJazpxhOsvR99Pjaz+ag=
X-Received: by 2002:a05:6214:19ce:b0:8f1:77b7:9bdc with SMTP id 6a1803df08f44-90413e0a5bfmr163102536d6.1.1784054055852;
        Tue, 14 Jul 2026 11:34:15 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd82csm174180826d6.35.2026.07.14.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:34:14 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 13/13] Documentation/dev-tools: document KWatch
Date: Wed, 15 Jul 2026 02:33:56 +0800
Message-ID: <20260714183356.13109-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
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
 Documentation/dev-tools/kwatch.rst | 193 +++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)
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
index 000000000000..8ead0beb06b6
--- /dev/null
+++ b/Documentation/dev-tools/kwatch.rst
@@ -0,0 +1,193 @@
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
+``access_type``     0 = write (default), 1 = read, 2 = read/write,
+                    3 = execute.
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
+    convention),
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
+* If the target address cannot be resolved at arming time (for example a
+  ``get_kernel_nofault()`` failure on a swapped or unmapped page), the
+  watchpoint is not armed for that invocation.
+* Offsets in watch expressions are static; dynamic indexing such as
+  ``arg1->ptr[arg2]`` is not supported.
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

