Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8982F616B;
	Sun,  2 Aug 2026 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785658746; cv=none; b=g0GxVP3c2FRm5npKT7ntMovapOLEAKNvYE9Se8UxUs9gZWGL3myJjMuoxCCq9jHWPtEihAXOdIidkf5zIEh2G00/bjlH+alJG2COLm1OMmy31QBc4jxpqgmhlC+XvfmiJbCxy/3jR7LFXEmNHHwFNC9ZA98sUWPTYE/C3H/0qI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785658746; c=relaxed/simple;
	bh=WLSMomGHYuU3/xj6iFrupqQ0v3LAL6oPKQv+ueIKDmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5wNfYGRqkxBqSO9i5Ltgn0+Etq85OvXJtKIrkJ+PC9E7MnuMAZVBteeb1CqyiwpXQKj4wpBppXzn2FBteItXgUiQ+HuwrnyL4rFB7tnUJF+XNJ4BaRGRGyS3S5NjLJ43DmxDjU6wGJjpOSWXCuiRLqyYeZUKnpnwT4Wbb0Jx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju2oTGJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju2oTGJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64CB1F00AC4;
	Sun,  2 Aug 2026 08:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785658745;
	bh=efYS360pd6ZZxxCBl/VvK2sP6q43hqiJMFfCbWEkZZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ju2oTGJhdnvUu8t0fuLMOyx5lSAxE4laeLLdVIgASrcsHvwiy5l4DPMvacgtgle3L
	 V0J0x9KHWS/yyrQvryEGLkb/WcSkLPsDv1AhbS8E4eGDHjNCrS2K4bsZIDzj9f1+dw
	 MDycSl3LpZcivqCFOdqSDT8hFkecSoIynjozfoxbj9kssd1QtI9gvaZfUul4XeF9qD
	 gTj3I6nHqJt2e9MAF0MleW5IXeDb7bXbJiEI70i9MTgkd7cUOW7aaH3TwCONk+C62W
	 2fsSZBdQtd/H1bCRjBA7I1dxMbP8Am2+HE44UswuXiy3DM5yrVB2/mCAvh4SInUV7q
	 92aLJD/b3oJWw==
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
Subject: [PATCH v11 03/11] HWBP: Add modify_local_hw_breakpoint_addr() API
Date: Sun,  2 Aug 2026 17:18:59 +0900
Message-ID: <178565873951.714490.18157944268328517957.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178565870538.714490.11309825813968306287.stgit@devnote2>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
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
Changes in v11:
 - Check return value of arch_modify_local_hw_breakpoint_addr() and
   return error on failure.
 - Update bp->attr.bp_addr and counter_arch_bp(bp)->address only after
   arch modification succeeds.
---
 arch/Kconfig                  |    8 ++++++++
 arch/x86/Kconfig              |    1 +
 include/linux/hw_breakpoint.h |    6 ++++++
 kernel/events/hw_breakpoint.c |   35 +++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

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
index 789add0c185a..3c799c88160c 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -888,6 +888,41 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
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
+	int ret;
+
+	lockdep_assert_irqs_disabled();
+
+	ret = arch_modify_local_hw_breakpoint_addr(bp, addr);
+	if (ret)
+		return ret;
+
+	counter_arch_bp(bp)->address = addr;
+	bp->attr.bp_addr = addr;
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

