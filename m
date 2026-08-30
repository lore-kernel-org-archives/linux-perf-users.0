Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110BA3B42D8;
	Sun, 30 Aug 2026 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100087; cv=none; b=XC3uYFJfQkAml+lOlMZISay+xixuG74TN3kAHTPIh1erRny3MfCZM2PaQ6gg9sP+pbThbcjkG6EYMAioINaA1w4W8K0mHYWDu9qL8XaxhQCcauBd7nwt6kzv4C5IHEKp7BBVcCjlAosd3F69EO7VdqvhMQ8W/1spoywi9m6LEDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100087; c=relaxed/simple;
	bh=KDWo64rxnlFoU3MXSLOcphSoR6wU4CLCaOrNit4rtBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0OA/6Vm3WYSrT5rchEqbO6cZgVGHZKwNHYCGXlPRc6n4YCTFKX1nIoktbnW/gZ9eG85Yfdy1XYopZg7Q5aWq/Ib2ppMDOU18U5HC/25Oi1q3SWzlTC9DNdi6wUmDhGC0AOOPurB5XE5H4x4apit0FZ3ZluGuAUDN0Q902yJ9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWFGdqUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWFGdqUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C3B1F000E9;
	Sun, 30 Aug 2026 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100082;
	bh=7cOfzoOQRNNCJyTmqw6greWRs3nJNGNH5pii0S6YISI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWFGdqUfFmg0VwDJkcb0XqK0/h+iwUivw9dK+7a6O+Dzuu9eVLUY6FhWZXfcqwjCu
	 Z29kLf4SBnBQcdunm1NX/TWN35XbAEdQUlZ/7ny8CheJj81uwdopIfcr7IhbW464Sx
	 ttjrcXehvTax7UFJmZgSH9gv6y3g24ykZYxcFcjNxfUY/HMIGdciRvvn0nVLAQCaaw
	 si6qJV7f2/xzdTYupX8vkzdUn+ar7TPlwYSnwmTPySe8wCofCQSZ0MmiW4riUXHTOk
	 PdTHj05HdKaedrDC98h2yR01L6/ggyjCS5bumRTjhKtNW/Lhvgw1IBX8b27f4QS66r
	 OEoZULGcoNQbw==
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
Subject: [PATCH v14 06/14] HWBP: Add modify_local_hw_breakpoint_addr() API
Date: Sun, 30 Aug 2026 23:27:57 +0900
Message-ID: <178810007699.64882.3789162690369937099.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178810001186.64882.2161016469449127450.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add modify_local_hw_breakpoint_addr() to update only the watched
address of an installed hardware breakpoint on the local CPU without
releasing and reserving its hardware slot. This is available when the
architecture selects CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR.

The caller must provide an installed local event and a valid address,
and update other CPUs separately.

Link: https://lore.kernel.org/all/f9c49dfa49bdc57ba8c0574bc9981c1e581acf92.1785067572.git.wangjinchao600@gmail.com/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
Changes in v13:
 - Add comment to modify_local_hw_breakpoint_addr() clarifying the early
   update behavior of bp->attr.bp_addr during the NMI race window.
Changes in v12:
 - Update bp->attr.bp_addr and counter_arch_bp(bp)->address before
   calling arch_modify_local_hw_breakpoint_addr() to prevent race
   conditions during interrupt handling.
 - Restore counter_arch_bp(bp)->address and bp->attr.bp_addr if
   arch_modify_local_hw_breakpoint_addr() fails.
Changes in v11:
 - Check return value of arch_modify_local_hw_breakpoint_addr() and
   return error on failure.
 - Update bp->attr.bp_addr and counter_arch_bp(bp)->address only after
   arch modification succeeds.
---
 arch/Kconfig                  |    8 +++++++
 arch/x86/Kconfig              |    1 +
 include/linux/hw_breakpoint.h |    6 +++++
 kernel/events/hw_breakpoint.c |   48 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..bea383408e32 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -457,6 +457,14 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Select this if the architecture can modify the address of an
+	  installed hardware breakpoint on the local CPU without releasing
+	  and reserving its hardware slot.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fd979e0be1f0..33908103d9a0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -247,6 +247,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..bf65c7fffd99 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -81,6 +81,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context);
 
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr);
+
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
@@ -124,6 +127,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
 static inline int
+modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				unsigned long addr) { return -EOPNOTSUPP; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c185a..124074c3d3bc 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -888,6 +888,54 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_local_hw_breakpoint_addr - update a local breakpoint address
+ * @bp: the hwbp perf event for this CPU
+ * @addr: the new address for @bp
+ *
+ * Update only the address of an installed breakpoint on the local CPU without
+ * releasing and reserving its hardware slot. The caller must update other CPUs.
+ * Return 0, or -EOPNOTSUPP if the architecture does not support this operation.
+ *
+ * Note: bp->attr.bp_addr and counter_arch_bp(bp)->address are updated before
+ * modifying hardware registers so that interrupt/NMI handlers and CPU entry
+ * paths observe the new address during the transition. If an NMI hits the old
+ * breakpoint address before the hardware register update finishes, the event
+ * handler will see bp->attr.bp_addr already pointing to @addr. If the
+ * architecture update fails, both are rolled back to the previous address.
+ * Callers must be prepared for this behavior.
+ */
+#ifdef CONFIG_HAVE_MODIFY_LOCAL_HW_BREAKPOINT_ADDR
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr)
+{
+	unsigned long old_addr;
+	int ret;
+
+	lockdep_assert_irqs_disabled();
+
+	old_addr = bp->attr.bp_addr;
+	counter_arch_bp(bp)->address = addr;
+	bp->attr.bp_addr = addr;
+
+	ret = arch_modify_local_hw_breakpoint_addr(bp, addr);
+	if (ret) {
+		counter_arch_bp(bp)->address = old_addr;
+		bp->attr.bp_addr = old_addr;
+		return ret;
+	}
+
+	return 0;
+}
+#else
+int modify_local_hw_breakpoint_addr(struct perf_event *bp,
+				    unsigned long addr)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+EXPORT_SYMBOL_GPL(modify_local_hw_breakpoint_addr);
+
 /**
  * hw_breakpoint_is_used - check if breakpoints are currently used
  *

