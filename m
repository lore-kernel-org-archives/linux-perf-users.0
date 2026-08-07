Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D035CB60;
	Fri,  7 Aug 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116838; cv=none; b=haib5+NvTmBQVcJgEKO+MVZMx3zc/R6jqcNQDP2hH2NErazT1Sw5ZmFqcjT8L14dRtrxnnV6EeMc2r4KUO1IGHbmH/icoO4BNF/XVMbd7A2N9VmWBjmh+g5RwjwUA632JndWj+syHLL07PVj/wh33GHvovkM+SkCGODNx7dFoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116838; c=relaxed/simple;
	bh=euYEKhSbBzs+uZi0+3GHoLu2oro05xbR5jy/yfF6Olc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfbvcdf8ulacefdvrmDkKCsXLXYLFqPK/Y0ziwQXC28hxGcMxoQ/5GLpWjePRTVWgwaL/S6F75B05BBrgwn7Zp+QTRjNEEK9CBiW7VaUs9gmhnUsVczTohPbIuN97ZvubTIPtDYBt2LuSPK7VGaq5RQ+35Dd98k0gTZpy4wL5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHWTBmIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHWTBmIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED0B1F000E9;
	Fri,  7 Aug 2026 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786116837;
	bh=vONymQCWyu1WL1Kcvjiq5u1LVr57kV2nVV9AjpHIWps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NHWTBmIx5hTk9eR47vpB20yMtSC/b/0Q9K4VIG253hsb8a0mHi/5XnjGHJKyW8b2H
	 XnBEdVxsVHW7RjAaF7G4HzQv0mIlNmpHUm1cEC1Baqmeqg1dsQAdrt8XPe/fAHlrTQ
	 wf7m6FEKrbw6HV56wFFQroSb4Q/seZ39fK1m60+n3M62aAY4PVYs0ZrWFRmR+v681+
	 4y1DwtXnO+HRQdN74bnoesT8OehUu2wIFTxFNNcw1cbVMJDBRuT0IWyBSo0ccANfNO
	 xhjHJ1sYmWfP0apglArncH6+fYwVimdLEWWIzL963/YAPOGKjiUnBpAJhGdHYQJGrQ
	 XfSmfE7+OkCog==
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
Subject: [PATCH v12 03/11] HWBP: Add modify_local_hw_breakpoint_addr() API
Date: Sat,  8 Aug 2026 00:33:51 +0900
Message-ID: <178611683120.237811.15904891776099424430.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178611679753.237811.10190793347982785419.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
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
 arch/Kconfig                  |    8 ++++++++
 arch/x86/Kconfig              |    1 +
 include/linux/hw_breakpoint.h |    6 ++++++
 kernel/events/hw_breakpoint.c |   40 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

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
index 789add0c185a..7d3a7bc050a4 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -888,6 +888,46 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
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

