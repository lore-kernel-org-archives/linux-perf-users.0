Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048843B7749
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293540; cv=none; b=MkqsSIXomsVsPmMgA53dMQ9d0H6061X9xtOYYWpIaiJhr9TjoNeniuxU3c71eQCaK5eo3yY1q7Nl+nTQiGj+9Wc+V3xkRqiCHg/Veq8HqIdunN3CF+pcDWZbEZ45GAzrnm3D/GUbTRtacCO0oAy7FTGQRVxNGKU8gS9JEV4oG3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293540; c=relaxed/simple;
	bh=wH8kkta8OF3VXBXdp1N+NHYfBBuMcPNLtXDApPbZ660=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ha4joDsyXIg1t/nLQL2dsR43jTYqLVpTQDA5K1rOUIjIOtPW3GtBsdbbgP93zU/aUKp6XqfR/Ymp2SvW+aH7Y9mLTO3WQKXr+ckEAnyJWY0KhTwCPcAWs8D/9QIHMSda3bi0L7UpQxho3jxsV9p241B5ILp4N0kHWWwU0BO2m2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwxzabev; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwxzabev"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso4286524a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293537; x=1784898337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/aEQ2n6TvdCBbgIi3sEsUgz+yDJwxM1XgcBftQT7Uys=;
        b=kwxzabevZWoJ0jhsYcePYnV6+2mKaT2a7tIUl/hLsHb4KQ6bwMlyHxFvL/HPbW8Jdf
         odJ+3uM1MSWj8IkgqeEL4YUUkSZXqD9B1BegighR0j0iPP7PVxZj2gE3OjYfMPgWvLQ5
         el3Wunz7i6ElxLi9sQApwORmIrxZiOXg8HnUXiZw693BqHx7X7WjT2x8mi0WTkFW0g68
         yQNV4S5tO/kmbOz/jQ/q6kSaf5w6vunNKmyfnHUyeO+XJTo6Gbd2e7Q0ClFkUjGO0Uld
         Os+4SKuplwMIqe/8yo3oa2dix3ztFGkHaa9j4ue3Q+Yg0zoJfqALpKu1ZbZ0NbW0VHnX
         +LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293537; x=1784898337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/aEQ2n6TvdCBbgIi3sEsUgz+yDJwxM1XgcBftQT7Uys=;
        b=TOfHHDgS8vBQhkl/WBnmvUySVRJfXqU/6RbZvhv2vhiNZ04XUplerDiUClvyPj66PN
         YQ8Xzsmtc7uAtbBzq+ggk0Nm6J8qEMEADFTXSwpKMk6pD5EkRzuU3D2Q6/jxEdaFnqwQ
         2Q8pmfqw7gt/DUaXf7FQJNdqRnJsBqMdo4c1crsgJnyDgXF7b03Klw3KCa3PjYw+fWmk
         7g+9GHCtuUl89CdSRUyUHV/Nf6+fsE/0RZ09nLiqIt6h0tQziZf5E7fs/YUu4k9q8ZmW
         8aT8FvCKfYxbydwuU4D56zI9U8P+80TJYgbQbp5BCyqJRioUZWmizYXjVzh538/9f0RO
         o0Mg==
X-Forwarded-Encrypted: i=1; AHgh+RoixRXhFBpkXapc7XhFICSsbsDzzT0bHB9Yms8nhqap5UHZMwS/O/9GmA+77hIBSEHhQWAbguamSrHNuNe3hj9j@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+pr2r2E5Glw6z16mWWEJ9+86Hy3q34HxQluUmM3193wj+H9D
	ObLb6pxaxQrp8Meg+pDUB/Nauiq6curBx6be0Y9VnYvVsLEpW8XsVvHQ
X-Gm-Gg: AfdE7cmUt3L4TI3kHWaUlCstQPq63l3P3zIfJ9CfOEF0hiq9RYJ0q/Rfwq7GtTcma7r
	QG8bJ6m6R33FmkBUKK2hyimwvoHR/8aWUhC9I1/EwLh3O/jfY0stugcGejvPB8SZUSKmjqYT/ys
	EZWzpeMWosqvdMMv1/mdwMU9DtTKX4pMxA4SljMlpZQU8VIAK3B9sWJPpykdezTrpvmFJpLuXb1
	2lqcMwl2PR6KaZI9hJUJ1PmAUrrPbmzEHxPQgxwU8wUdQch6ky0xHA98hxc0b55FHAveXjSJYno
	XnZlIy722J2fwAHEyR1O7g+NTP2plM6mpgc11LuqDeewTxwm/JiGbFiUcuLMsU4ixmk3v8+oSaT
	Z1RcOGlMkV//Q25gz4umvceBpAlNEvUC1IZXqK1ziOD5i/v8TxB/ZJgbBVpkfyxT2z+llrhHQHj
	YFuQ==
X-Received: by 2002:a17:90b:278e:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-38e4b454f0bmr2580230a91.12.1784293537053;
        Fri, 17 Jul 2026 06:05:37 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb77csm7739750eec.18.2026.07.17.06.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:05:35 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/13] mm/kwatch: add hardware breakpoint backend
Date: Fri, 17 Jul 2026 09:05:20 -0400
Message-ID: <20260717130520.1902926-1-wangjinchao600@gmail.com>
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

Manage a preallocated pool of wide (per-CPU) perf hardware
breakpoints. All breakpoints are registered up front against a dummy
address; arming a watchpoint only re-points an already-registered
event, so the arm path can run from a kprobe handler.

- kwatch_hwbp_get()/put() claim and release pool entries with
  per-slot cmpxchg, safe for concurrent consumers on any CPU.
- kwatch_hwbp_arm() updates the local CPU synchronously via
  modify_wide_hw_breakpoint_local() and broadcasts asynchronous IPIs
  to the other CPUs. Arm-side IPIs are rate-limited per CPU; disarm
  IPIs are refcounted so an entry is only recycled once every CPU
  has dropped it.
- Hits are reported through the kwatch:kwatch_hit tracepoint with a
  short stack trace: the ftrace ring buffer is usable from NMI-like
  context and survives a subsequent crash, unlike printk.
- A CPU hotplug callback creates/destroys the per-CPU events as CPUs
  come and go.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/trace/events/kwatch.h |  68 ++++++
 mm/kwatch/Makefile            |   2 +-
 mm/kwatch/hwbp.c              | 388 ++++++++++++++++++++++++++++++++++
 3 files changed, 457 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/kwatch.h
 create mode 100644 mm/kwatch/hwbp.c

diff --git a/include/trace/events/kwatch.h b/include/trace/events/kwatch.h
new file mode 100644
index 000000000000..8a2ec6811ad4
--- /dev/null
+++ b/include/trace/events/kwatch.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kwatch
+
+#if !defined(_TRACE_KWATCH_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KWATCH_H
+
+#include <linux/tracepoint.h>
+#include <linux/ptrace.h>
+#include <linux/math64.h>
+
+#define KWATCH_STACK_DEPTH 8
+
+struct trace_seq;
+const char *kwatch_trace_print_stack(struct trace_seq *p,
+				     const unsigned long *stack,
+				     unsigned int nr);
+
+TRACE_EVENT(kwatch_hit,
+	TP_PROTO(unsigned long ip, unsigned long sp, unsigned long addr,
+		 u64 time_ns,
+		 unsigned long *stack_entries, unsigned int stack_nr),
+	TP_ARGS(ip, sp, addr, time_ns, stack_entries, stack_nr),
+
+	TP_STRUCT__entry(
+		/*
+		 * time_ns first: u64 leading the entry avoids a 4-byte hole
+		 * after the unsigned-long fields on 32-bit. stack_nr trails
+		 * the fixed fields for the same reason; the stack is a
+		 * dynamic array sized to what was actually captured, so a
+		 * short trace neither wastes space nor leaks uninitialized
+		 * tail slots.
+		 */
+		__field(u64, time_ns)
+		__field(unsigned long, ip)
+		__field(unsigned long, sp)
+		__field(unsigned long, addr)
+		__dynamic_array(unsigned long, stack,
+				min_t(unsigned int, stack_nr, KWATCH_STACK_DEPTH))
+		__field(unsigned int, stack_nr)
+	),
+
+	TP_fast_assign(
+		unsigned long *stack = __get_dynamic_array(stack);
+		unsigned int i;
+
+		__entry->time_ns = time_ns;
+		__entry->ip = ip;
+		__entry->sp = sp;
+		__entry->addr = addr;
+		__entry->stack_nr = min_t(unsigned int, stack_nr,
+					  KWATCH_STACK_DEPTH);
+		for (i = 0; i < __entry->stack_nr; i++)
+			stack[i] = stack_entries[i];
+	),
+
+	TP_printk("KWatch HIT: time=%llu.%06u ip=%pS addr=0x%lx%s",
+		  div_u64(__entry->time_ns, 1000000000ULL),
+		  (unsigned int)(div_u64(__entry->time_ns, 1000ULL) % 1000000ULL),
+		  (void *)__entry->ip, __entry->addr,
+		  kwatch_trace_print_stack(p, __get_dynamic_array(stack),
+					   __entry->stack_nr))
+);
+
+#endif /* _TRACE_KWATCH_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index cc6574df0d68..b2bc3003c89b 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
-kwatch-y := deref.o task_ctx.o
+kwatch-y := deref.o task_ctx.o hwbp.o
diff --git a/mm/kwatch/hwbp.c b/mm/kwatch/hwbp.c
new file mode 100644
index 000000000000..d1e93754cce8
--- /dev/null
+++ b/mm/kwatch/hwbp.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpuhotplug.h>
+#include <linux/ftrace.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/sched/clock.h>
+#include <linux/irqflags.h>
+#include <linux/kallsyms.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/stacktrace.h>
+#include <linux/trace_seq.h>
+#include <linux/workqueue.h>
+
+#include "kwatch.h"
+
+/* Minimum spacing between cross-CPU arm broadcasts, per CPU. */
+#define KWATCH_ARM_IPI_MIN_INTERVAL_NS	1000000ULL
+
+static LIST_HEAD(kwatch_all_wp_list);
+static struct kwatch_watchpoint **kwatch_wp_slots;
+static u16 kwatch_wp_nr;
+static DEFINE_MUTEX(kwatch_all_wp_mutex);
+static unsigned long kwatch_dummy_holder __aligned(8);
+static int kwatch_hwbp_cpuhp_state = CPUHP_INVALID;
+static atomic_long_t kwatch_arm_ipi_suppressed;
+
+unsigned long kwatch_hwbp_arm_ipi_suppressed(void)
+{
+	return atomic_long_read(&kwatch_arm_ipi_suppressed);
+}
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/kwatch.h>
+
+/*
+ * Render the saved stack like the ftrace built-in stacktrace / dump_stack()
+ * style. Symbol resolution runs at trace read time, not in the hit path.
+ */
+const char *kwatch_trace_print_stack(struct trace_seq *p,
+				     const unsigned long *stack,
+				     unsigned int nr)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	unsigned int i;
+
+	for (i = 0; i < nr; i++)
+		trace_seq_printf(p, "\n => %pS", (void *)stack[i]);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+static void kwatch_hwbp_handler(struct perf_event *bp,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
+{
+	struct kwatch_watchpoint *wp = bp->overflow_handler_context;
+	unsigned long stack_entries[KWATCH_STACK_DEPTH];
+	unsigned int stack_nr;
+
+	if (!kwatch_probe_validate_hit(regs, wp->arm_tsk))
+		return;
+
+	stack_nr = stack_trace_save_regs(regs, stack_entries, KWATCH_STACK_DEPTH, 2);
+	trace_kwatch_hit(instruction_pointer(regs), kernel_stack_pointer(regs),
+			 bp->attr.bp_addr, local_clock(),
+			 stack_entries, stack_nr);
+}
+
+static void kwatch_hwbp_arm_local(void *info)
+{
+	struct kwatch_watchpoint *wp = info;
+	struct perf_event *bp;
+	unsigned long flags;
+	int cpu, err;
+
+	local_irq_save(flags);
+
+	cpu = smp_processor_id();
+	bp = per_cpu(*wp->event, cpu);
+
+	if (unlikely(!bp))
+		goto out;
+
+	kwatch_probe_mute(true);
+	barrier();
+
+	/*
+	 * On success this also updates the per-CPU bp->attr, so the hit
+	 * handler reports what THIS CPU is watching instead of the shared
+	 * wp->attr, which another CPU may be re-pointing.
+	 */
+	err = modify_wide_hw_breakpoint_local(bp, &wp->attr);
+	if (unlikely(err))
+		WARN_ONCE(1,
+			  "KWatch: HWBP reinstall failed on CPU%d (err=%d, addr=0x%llx, len=%llu)\n",
+			  cpu, err, wp->attr.bp_addr, wp->attr.bp_len);
+
+	barrier();
+	kwatch_probe_mute(false);
+
+out:
+	local_irq_restore(flags);
+}
+
+static inline void kwatch_hwbp_try_recycle(struct kwatch_watchpoint *wp)
+{
+	if (atomic_dec_and_test(&wp->pending_ipis)) {
+		if (!READ_ONCE(wp->teardown))
+			atomic_set_release(&wp->in_use, 0);
+
+		atomic_dec(&wp->refcount);
+	}
+}
+
+static void kwatch_hwbp_disarm_local(void *info)
+{
+	struct kwatch_watchpoint *wp = info;
+
+	kwatch_hwbp_arm_local(info);
+	kwatch_hwbp_try_recycle(wp);
+}
+
+static int kwatch_hwbp_cpu_online(unsigned int cpu)
+{
+	struct perf_event_attr attr;
+	struct kwatch_watchpoint *wp;
+	struct perf_event *bp;
+
+	mutex_lock(&kwatch_all_wp_mutex);
+	list_for_each_entry(wp, &kwatch_all_wp_list, list) {
+		attr = wp->attr;
+		attr.bp_addr = (unsigned long)&kwatch_dummy_holder;
+		bp = perf_event_create_kernel_counter(&attr, cpu, NULL,
+						      kwatch_hwbp_handler, wp);
+		if (IS_ERR(bp)) {
+			pr_warn("%s failed to create watch on CPU %d: %ld\n",
+				__func__, cpu, PTR_ERR(bp));
+			continue;
+		}
+		per_cpu(*wp->event, cpu) = bp;
+	}
+	mutex_unlock(&kwatch_all_wp_mutex);
+	return 0;
+}
+
+static int kwatch_hwbp_cpu_offline(unsigned int cpu)
+{
+	struct kwatch_watchpoint *wp;
+	struct perf_event *bp;
+
+	mutex_lock(&kwatch_all_wp_mutex);
+	list_for_each_entry(wp, &kwatch_all_wp_list, list) {
+		bp = per_cpu(*wp->event, cpu);
+		if (bp) {
+			unregister_hw_breakpoint(bp);
+			per_cpu(*wp->event, cpu) = NULL;
+		}
+	}
+	mutex_unlock(&kwatch_all_wp_mutex);
+	return 0;
+}
+
+int kwatch_hwbp_get(struct kwatch_watchpoint **out_wp)
+{
+	struct kwatch_watchpoint *wp;
+	int i;
+
+	/*
+	 * Per-slot cmpxchg claim: safe for concurrent consumers on any CPU,
+	 * unlike llist_del_first() which requires a single consumer.
+	 */
+	for (i = 0; i < kwatch_wp_nr; i++) {
+		wp = kwatch_wp_slots[i];
+		if (atomic_read(&wp->in_use))
+			continue;
+		if (atomic_cmpxchg(&wp->in_use, 0, 1) == 0) {
+			atomic_inc(&wp->refcount);
+			*out_wp = wp;
+			return 0;
+		}
+	}
+	return -EBUSY;
+}
+
+void kwatch_hwbp_arm(struct kwatch_watchpoint *wp, unsigned long addr, u16 len)
+{
+	static DEFINE_PER_CPU(u64, last_ipi_time);
+	int cur_cpu;
+	call_single_data_t *csd;
+	int cpu;
+	bool is_disarm = (addr == (unsigned long)&kwatch_dummy_holder);
+	bool skip_remote = false;
+
+	wp->attr.bp_addr = addr;
+	wp->attr.bp_len = len;
+
+	if (!is_disarm)
+		wp->arm_tsk = current;
+
+	/* ensure attr update visible to other cpu before sending IPI */
+	smp_wmb();
+
+	atomic_set(&wp->pending_ipis, 1);
+	cur_cpu = get_cpu();
+
+	/*
+	 * Rate-limit only the cross-CPU broadcast, never the local re-point.
+	 * Arming the current CPU is free and must always reflect this window;
+	 * only the remote IPI fan-out is throttled to keep a hot function from
+	 * storming every CPU. A suppressed broadcast means remote CPUs keep
+	 * watching the previous address for that window (a missed remote-CPU
+	 * writer is possible) - hence the visible counter, and why kwatch
+	 * targets low-frequency functions. Disarm is never throttled: the
+	 * slot must always be released.
+	 */
+	if (!is_disarm) {
+		u64 now = local_clock();
+		u64 last = this_cpu_read(last_ipi_time);
+
+		if (now - last < KWATCH_ARM_IPI_MIN_INTERVAL_NS) {
+			atomic_long_inc(&kwatch_arm_ipi_suppressed);
+			skip_remote = true;
+		} else {
+			this_cpu_write(last_ipi_time, now);
+		}
+	}
+
+	if (!skip_remote) {
+		for_each_online_cpu(cpu) {
+			if (cpu == cur_cpu)
+				continue;
+
+			if (is_disarm)
+				atomic_inc(&wp->pending_ipis);
+
+			csd = per_cpu_ptr(is_disarm ? wp->csd_disarm : wp->csd_arm,
+					  cpu);
+			/*
+			 * The arm path ignores a -EBUSY return: a wp has a single
+			 * owner (claimed via kwatch_hwbp_get(), held until exit)
+			 * and is armed once per window, and the per-CPU csd queue
+			 * is FIFO, so this window's csd_arm cannot still be pending
+			 * from a prior window (its disarm, queued later, gates the
+			 * wp's reuse). Do not "fix" this into a retry.
+			 */
+			if (smp_call_function_single_async(cpu, csd) && is_disarm)
+				kwatch_hwbp_try_recycle(wp);
+		}
+	}
+	put_cpu();
+
+	if (is_disarm)
+		kwatch_hwbp_disarm_local(wp);
+	else
+		kwatch_hwbp_arm_local(wp);
+}
+
+int kwatch_hwbp_put(struct kwatch_watchpoint *wp)
+{
+	kwatch_hwbp_arm(wp, (unsigned long)&kwatch_dummy_holder,
+			sizeof(unsigned long));
+
+	return 0;
+}
+
+void kwatch_hwbp_free(void)
+{
+	struct kwatch_watchpoint *wp, *tmp;
+
+	kwatch_wp_nr = 0;
+	kfree(kwatch_wp_slots);
+	kwatch_wp_slots = NULL;
+
+	if (kwatch_hwbp_cpuhp_state != CPUHP_INVALID) {
+		cpuhp_remove_state_nocalls(kwatch_hwbp_cpuhp_state);
+		kwatch_hwbp_cpuhp_state = CPUHP_INVALID;
+	}
+
+	mutex_lock(&kwatch_all_wp_mutex);
+	list_for_each_entry_safe(wp, tmp, &kwatch_all_wp_list, list) {
+		list_del(&wp->list);
+
+		WRITE_ONCE(wp->teardown, true);
+		atomic_dec(&wp->refcount);
+
+		/* Wait for all async IPIs to finish */
+		while (atomic_read(&wp->refcount) > 0)
+			cpu_relax();
+
+		unregister_wide_hw_breakpoint(wp->event);
+		free_percpu(wp->csd_arm);
+		free_percpu(wp->csd_disarm);
+		kfree(wp);
+	}
+	mutex_unlock(&kwatch_all_wp_mutex);
+}
+
+int kwatch_hwbp_prealloc(u16 max_watch)
+{
+	struct kwatch_watchpoint *wp;
+	int success = 0, cpu;
+	int ret;
+
+	atomic_long_set(&kwatch_arm_ipi_suppressed, 0);
+
+	while (!max_watch || success < max_watch) {
+		wp = kzalloc_obj(*wp);
+		if (!wp)
+			break;
+
+		wp->csd_arm = alloc_percpu(call_single_data_t);
+		wp->csd_disarm = alloc_percpu(call_single_data_t);
+		if (!wp->csd_arm || !wp->csd_disarm) {
+			free_percpu(wp->csd_arm);
+			free_percpu(wp->csd_disarm);
+			kfree(wp);
+			break;
+		}
+
+		for_each_possible_cpu(cpu) {
+			INIT_CSD(per_cpu_ptr(wp->csd_arm, cpu),
+				 kwatch_hwbp_arm_local, wp);
+			INIT_CSD(per_cpu_ptr(wp->csd_disarm, cpu),
+				 kwatch_hwbp_disarm_local, wp);
+		}
+
+		wp->teardown = false;
+
+		hw_breakpoint_init(&wp->attr);
+		wp->attr.bp_addr = (unsigned long)&kwatch_dummy_holder;
+		wp->attr.bp_len = sizeof(unsigned long);
+		/* kwatch localizes corruption: it always watches for writes. */
+		wp->attr.bp_type = HW_BREAKPOINT_W;
+
+		wp->event = register_wide_hw_breakpoint(&wp->attr,
+							kwatch_hwbp_handler,
+							wp);
+		if (IS_ERR_PCPU(wp->event)) {
+			free_percpu(wp->csd_arm);
+			free_percpu(wp->csd_disarm);
+			kfree(wp);
+			break;
+		}
+
+		atomic_set(&wp->refcount, 1);
+
+		mutex_lock(&kwatch_all_wp_mutex);
+		list_add(&wp->list, &kwatch_all_wp_list);
+		mutex_unlock(&kwatch_all_wp_mutex);
+		success++;
+	}
+
+	if (!success)
+		return -EBUSY;
+
+	/*
+	 * A fresh prealloc must start from an empty slot array; warn if a
+	 * previous session was not torn down, since refilling without a reset
+	 * would index past the freshly sized array.
+	 */
+	WARN_ON_ONCE(kwatch_wp_slots || kwatch_wp_nr);
+	kwatch_wp_nr = 0;
+
+	kwatch_wp_slots = kcalloc(success, sizeof(*kwatch_wp_slots),
+				  GFP_KERNEL);
+	if (!kwatch_wp_slots) {
+		kwatch_hwbp_free();
+		return -ENOMEM;
+	}
+	mutex_lock(&kwatch_all_wp_mutex);
+	list_for_each_entry(wp, &kwatch_all_wp_list, list)
+		kwatch_wp_slots[kwatch_wp_nr++] = wp;
+	mutex_unlock(&kwatch_all_wp_mutex);
+
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "kwatch:online",
+					kwatch_hwbp_cpu_online,
+					kwatch_hwbp_cpu_offline);
+	if (ret < 0) {
+		kwatch_hwbp_free();
+		return ret;
+	}
+
+	kwatch_hwbp_cpuhp_state = ret;
+	return 0;
+}
-- 
2.53.0

