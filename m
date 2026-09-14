Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27864A2062;
	Mon, 14 Sep 2026 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390244; cv=none; b=qC4tQN1UeIS3wU8NzPDcWE/1sudr3yrXYygTAjXvcGD4VsezNJ5IShNtgYNNvdByI2vFkolry44HG6Fphck2RSTvckD2Px3jjbX/jlLybOsICSryBV6mCJPTzxgoA55uIO56ZN5/9kfnwIypZSvE0xud3KyDwSa196ijYDP5pnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390244; c=relaxed/simple;
	bh=WSSazbM+fHfaUAOgnSMHO0iUtKbGi34yU9nXSmgXbfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eG0bAHju2rm/E7cDNqRBhmVXM41S8lJfI1S+IprOG4SLY6OkFVbn0ZWqAExOb9PTN9rKsMKJglMGKwORU0Klz4XjRzcRQDH649ICjLAitfEYYcEHJaWEWmv585EG+kPGeMOcrIx+oztu9H6mXpET65XzdeHCRHxVIxKfDswYLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4Tgj0mq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4Tgj0mq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4181F000FF;
	Mon, 14 Sep 2026 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390242;
	bh=jQqBZgRQel9T6CKiVbYZiYgcese2NqaCIfPTKivOYNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4Tgj0mqZvid5KbDjWVKimp/P8Km+HMceQDeuTWBm3vcOJu9HurgxPgax4bRVup9q
	 WnrnZRs2cWqJc2KwE5N71COhGsKDAbhGbRG7ahLcBnfbTKzGUa6L36HEgOOEQ7aJei
	 N3Okv6bBIZG9BzriVwxzMk/ZoDumHzqBa6Ve+QmzciGDSF9yx3FUydCYUJAilqLnUY
	 aK1NLpMzWw+UrolTa0snR2OFZbqB9bKWpaMhbhZtVYE7mea6LASiGSphVdWWcrTGZB
	 BYgBK5muFutF9rEzerMpJ7RG3kACkL/ULci8m+RZPg/Vc17gHVwHoW72yPIdz3zWQV
	 Um50vYOOHeegg==
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
	linux-perf-users@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v16 05/13] HWBP: Add modify_local_hw_breakpoint_addr() API
Date: Mon, 14 Sep 2026 21:50:35 +0900
Message-ID: <178939023566.94750.959822747583037477.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178939017565.94750.9431053336761330458.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
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

Assisted-by: Antigravity:gemini-3.8-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
Changes in v15:
 - Use WRITE_ONCE() for counter_arch_bp(bp)->address and bp->attr.bp_addr
   in both update and rollback paths to prevent data races with concurrent
   readers (e.g. NMI handlers).
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
index 45c657772362..d021bc31ef14 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -474,6 +474,14 @@ config HAVE_MIXED_BREAKPOINTS_REGS
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
index 15fd9ec5ecac..38e29e465022 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -249,6 +249,7 @@ config X86
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
index 789add0c185a..69bfb17b87c4 100644
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
+	WRITE_ONCE(counter_arch_bp(bp)->address, addr);
+	WRITE_ONCE(bp->attr.bp_addr, addr);
+
+	ret = arch_modify_local_hw_breakpoint_addr(bp, addr);
+	if (ret) {
+		WRITE_ONCE(counter_arch_bp(bp)->address, old_addr);
+		WRITE_ONCE(bp->attr.bp_addr, old_addr);
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

