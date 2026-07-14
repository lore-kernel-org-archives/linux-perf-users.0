Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05F417BF8
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053943; cv=none; b=LFGJueuO0I9QLbEGqhcDPECQ/Enyo/fbzemkW5w2q0TOz4mZUE1WsddWB/iWh8uAVPe7K2FqdgNhwIez4YIx+ZxwbKJuMVw5c0lfA48iG33u1GnYLawfGDHiee+xpK7FrhgY8hZ31VEsrIT1GGHc2FErqLO8aeiglH7g9gC7Oko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053943; c=relaxed/simple;
	bh=qwHJQSkHR9FiX9eLZJcFQ7+CaEXGbJDg7NFSWEISO8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHLlxv4zVkpAA9uUARRB5MP++krLqBiXzMhJkGXw/Zmd1lIPNwHxlxzq6H5ZZGLTxSYWnoTPqE/2vtNh6hSgQ0kouplCk0+hpkXPwTp+jycBDxxsZbEucgmPOhOq1rhEoHY9gVO2FK7NhKp3Mvxv9TGVcdA6OTMhGaxPyQfOw4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnPa9xbu; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnPa9xbu"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e7632b193so139896785a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053939; x=1784658739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2DejjWbYnVcQ4XXUkfoVFnqVdAcjxTlD3K8bB22eXeE=;
        b=RnPa9xbuls1QpCNB8wPSIG46xMbL0IuXquMY5ZzlF7HORy8c1PfGbLBFvsGu+zo/p9
         K8+Jmbl0GZXmY9Ktz0UM10FCgbIbF30Pmuu9ptlMau1PwUHFggO73fpGlsbrNDGou1hT
         lVfWl9NmvRMKD/oCctu6onxWGAJ612i+A4GNd7OXoULIZ7Ow9VNudh4FcGSME4G2y0es
         HgwwIdLZhL5fKw2qiwYbqnFVckKCYzczy177wAT/kxetJyaZVuo9pkrkJyOpcI6Dydq+
         ep9KKkpSyWa3H1VktpFsNqmL+IE8uEgDnzx0i2/1XPWjUFg2qjjxrljEjXsGvOErEhQs
         1+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053939; x=1784658739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2DejjWbYnVcQ4XXUkfoVFnqVdAcjxTlD3K8bB22eXeE=;
        b=LI7m8fkLPndd3CGxvZBagVIX+PC6H6yk7SkHG8mDsacgFFCdUpvDIjZmLVmpEpCZ/N
         CphHO3cEetGta5DU2/7k+jCIh+Zd+sCXtU2jmTa1GMnXysqT+VqrK7hw7SEwE/G7mqI+
         jp//G8nVKpIbG4deqXsmpZA6R9b7R9gc1vs4Ju5+6DpSJWCK2i/kfuGn6WfutpVexlQZ
         LDYzfYYBQld53ksgSU2TrIydthXAUS4sUzJDFYf+uLgk4mnQeoX/VBwmuQkIImAn6fVd
         Y2WAhQT8q4L4ayCYCidqjdRuDUTdaC+igwQ8JtDfwb6z3q9ew7T5GwVwRQ2yfQKzYkJN
         TJLg==
X-Forwarded-Encrypted: i=1; AHgh+RoeYmSpT+cfM4+tWIVorPNw+KdC51VwtZmBpB9oJxeH+qhXK6/hT8Gm7OrLLXkmr4QwlNUf9Qlt6zojxIgJVS+7@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpFwSMxwsf8McLbSCQL8P1FA1+7Iwuro5tLcB5ngDrppsmgz0
	Q0coKUWsz9KxExcIL5YLRwhWptv5d7E9DfmBrhigLfYRQNJ5x8uDLcRq
X-Gm-Gg: AfdE7ck7ur7t+q/nngHisYSDC4WF8YebR5HCRh9EGRffO9WyMYS8+u/FSwQDl5D0ht3
	hND5xhpvKFmocLfBdmua3zCLU6I0iyT/IqeP+tWOPEAi73kT4h9k2cS221sEHwC6aodBvr3yzZB
	Q4cl+uI4sBVYgiAf+MVyXzETPVGOjtqEay2A4lj1rAMByKKPZTrpeL/UIF8TKplEmU/yYctJvHn
	2R8Erg2BpStkBSsRLMSpj+Tn0Lw+I0tN4XO2zXJ4GRxj+N3ml77eKFgV80biRo3BHDgzASh5v+W
	SANJdgS+HZzB4mQmrz/hNHNQ2Pi1zA+hbZQ2lAzOos3D25pFc7jtDnSMbl9FvX7JP8laiMAyUYY
	O2NJ788jHPX3+sU5eKRxZoUYdIkA/oK0pzqTJfREgGqqTfCD612pTfhtAv0If3Y//Ajj5Z+q2xy
	JNgBS1IkGRg0/8UpOeh1LMimn/FTHQ0WgtcEmIiLdDpWJSsL9/JkA=
X-Received: by 2002:a05:620a:460c:b0:92e:6637:d98 with SMTP id af79cd13be357-92ef2b35181mr1396308185a.18.1784053938726;
        Tue, 14 Jul 2026 11:32:18 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5bab293sm1547341685a.18.2026.07.14.11.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:32:17 -0700 (PDT)
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
Subject: [RFC PATCH 08/13] mm/kwatch: add hardware breakpoint backend
Date: Wed, 15 Jul 2026 02:32:06 +0800
Message-ID: <20260714183206.12688-1-wangjinchao600@gmail.com>
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
 include/trace/events/kwatch.h |  57 ++++++
 mm/kwatch/Makefile            |   2 +-
 mm/kwatch/hwbp.c              | 358 ++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/kwatch.h
 create mode 100644 mm/kwatch/hwbp.c

diff --git a/include/trace/events/kwatch.h b/include/trace/events/kwatch.h
new file mode 100644
index 000000000000..edb95405c386
--- /dev/null
+++ b/include/trace/events/kwatch.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kwatch
+
+#if !defined(_TRACE_KWATCH_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KWATCH_H
+
+#include <linux/tracepoint.h>
+#include <linux/ptrace.h>
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
+		__field(unsigned long, ip)
+		__field(unsigned long, sp)
+		__field(unsigned long, addr)
+		__field(u64, time_ns)
+		__field(unsigned int, stack_nr)
+		__array(unsigned long, stack, KWATCH_STACK_DEPTH)
+	),
+
+	TP_fast_assign(
+		unsigned int i;
+
+		__entry->ip = ip;
+		__entry->sp = sp;
+		__entry->addr = addr;
+		__entry->time_ns = time_ns;
+		__entry->stack_nr = min_t(unsigned int, stack_nr,
+					  KWATCH_STACK_DEPTH);
+		for (i = 0; i < __entry->stack_nr; i++)
+			__entry->stack[i] = stack_entries[i];
+	),
+
+	TP_printk("KWatch HIT: time=%llu.%06lu ip=%pS addr=0x%lx%s",
+		  __entry->time_ns / 1000000000ULL,
+		  (unsigned long)((__entry->time_ns / 1000ULL) % 1000000ULL),
+		  (void *)__entry->ip, __entry->addr,
+		  kwatch_trace_print_stack(p, __entry->stack,
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
index 000000000000..19498ba03826
--- /dev/null
+++ b/mm/kwatch/hwbp.c
@@ -0,0 +1,358 @@
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
+static LIST_HEAD(kwatch_all_wp_list);
+static struct kwatch_watchpoint **kwatch_wp_slots;
+static u16 kwatch_wp_nr;
+static DEFINE_MUTEX(kwatch_all_wp_mutex);
+static unsigned long kwatch_dummy_holder __aligned(8);
+static int kwatch_hwbp_cpuhp_state = CPUHP_INVALID;
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
+			 wp->attr.bp_addr, local_clock(),
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
+	err = modify_wide_hw_breakpoint_local(bp, &wp->attr);
+	if (unlikely(err)) {
+		WARN_ONCE(1,
+			  "KWatch: HWBP reinstall failed on CPU%d (err=%d, addr=0x%llx, len=%llu)\n",
+			  cpu, err, wp->attr.bp_addr, wp->attr.bp_len);
+	}
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
+	if (!is_disarm) {
+		u64 now = local_clock();
+		u64 last = this_cpu_read(last_ipi_time);
+
+		if (now - last < 1000000ULL) {
+			put_cpu();
+			return;
+		}
+		this_cpu_write(last_ipi_time, now);
+	}
+	for_each_online_cpu(cpu) {
+		if (cpu == cur_cpu)
+			continue;
+
+		if (is_disarm)
+			atomic_inc(&wp->pending_ipis);
+
+		csd = per_cpu_ptr(is_disarm ? wp->csd_disarm : wp->csd_arm,
+				  cpu);
+		if (smp_call_function_single_async(cpu, csd) && is_disarm)
+			kwatch_hwbp_try_recycle(wp);
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
+int kwatch_hwbp_prealloc(u16 max_watch, enum kwatch_access_type access_type)
+{
+	struct kwatch_watchpoint *wp;
+	int success = 0, cpu;
+	u32 bp_type;
+	int ret;
+
+	switch (access_type) {
+	case KWATCH_ACCESS_X:
+		bp_type = HW_BREAKPOINT_X;
+		break;
+	case KWATCH_ACCESS_R:
+		bp_type = HW_BREAKPOINT_R;
+		break;
+	case KWATCH_ACCESS_RW:
+		bp_type = HW_BREAKPOINT_RW;
+		break;
+	case KWATCH_ACCESS_W:
+	default:
+		bp_type = HW_BREAKPOINT_W;
+		break;
+	}
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
+		wp->attr.bp_type = bp_type;
+
+		wp->event = register_wide_hw_breakpoint(&wp->attr,
+							kwatch_hwbp_handler,
+							wp);
+		if (IS_ERR((void *)wp->event)) {
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

