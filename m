Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C961F2C34;
	Tue, 23 Sep 2025 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590251; cv=none; b=E/lp1AXhGoTR8h71enllK98VfP6CLZmO23EaLwFzSDZj9c92VWz90SGRiOK0XLLgW3SLfLbfekIHz+CUu+3XslnByZJnkCXxyaiod9c/tcyULgxP3A9x9IJavBHqXDY3VXSqTcgHN0Y2zsydmfq2BOwWSObv6CTEc9cZUUxYGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590251; c=relaxed/simple;
	bh=gpI38ZxVfLy7m/MvVBoM/0OoLn3CKGWk0bp/xqaT5HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7exYBFgxdL+nyzgf6YX96Ijg6FEOSjiUzCVCN+cxiwPPvmVt6liqD1L66Av6KgCsLOzUdZsCOmPv2tfXIvKd5mXd+82X47RV61GUZAH5t0fX/rQsnUPwW/WViZLOe6bKayi5PKY+x+tTUqYcsMCaFb+r4slIiOjhb8ZKFneVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR1oAhjs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR1oAhjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3132DC4CEF0;
	Tue, 23 Sep 2025 01:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758590250;
	bh=gpI38ZxVfLy7m/MvVBoM/0OoLn3CKGWk0bp/xqaT5HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FR1oAhjsKvGksHYp+NMhQ7g97Rq4dNIEzpMLKAsABojoMxTBN2fsLzQQzJ6YyAero
	 qXiWBovO5gGEeQRQ5ckydGhK90zkD4Je8G5KWirx/5K09+jGulB0tvaPK7d2T7cMcL
	 vGIqW1lj2fI5eu2vq2DdZjRtAE3pEyo49FUZJm8ze+U6itWf/ME7i7i/q2BRt1k7fi
	 LTOaWxhBMSQUNrzJEToHTx3w0wMmixM5HZ9qiiO9DVl46LJ6BRWLpp9vueeyrB8yFT
	 gvTAHps7/QNOR+6vZnV1Q8LYOozFmgtSpvlnpEGhMsz4rw8efJ/vZ96BCmmlDtBy8x
	 xHbttB3QrZSkw==
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
Subject: [PATCH v5 4/8] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Tue, 23 Sep 2025 10:17:25 +0900
Message-ID: <175859024493.374439.1819132909164325600.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175859019940.374439.7398451124225791618.stgit@devnote2>
References: <175859019940.374439.7398451124225791618.stgit@devnote2>
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

Add modify_wide_hw_breakpoint_local() arch-wide interface which allows
hwbp users to update watch address on-line. This is available if the
arch supports CONFIG_HAVE_REINSTALL_HW_BREAKPOINT.
Note that this allows to change the type only for compatible types,
because it does not release and reserve the hwbp slot based on type.
For instance, you can not change HW_BREAKPOINT_W to HW_BREAKPOINT_X.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v4:
  - Update kerneldoc comment about modify_wide_hw_breakpoint_local
    according to Randy's comment.
 Changes in v2:
  - Check type compatibility by checking slot. (Thanks Jinchao!)
---
 arch/Kconfig                  |   10 ++++++++++
 arch/x86/Kconfig              |    1 +
 include/linux/hw_breakpoint.h |    6 ++++++
 kernel/events/hw_breakpoint.c |   37 +++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..e4787fc814df 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_REINSTALL_HW_BREAKPOINT
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Depending on the arch implementation of hardware breakpoints,
+	  some of them are able to update the breakpoint configuration
+	  without release and reserve the hardware breakpoint register.
+	  What configuration is able to update depends on hardware and
+	  software implementation.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..49d4ce2af94c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -247,6 +247,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_REINSTALL_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..ea373f2587f8 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -81,6 +81,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context);
 
+extern int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+					   struct perf_event_attr *attr);
+
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
@@ -124,6 +127,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
 static inline int
+modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				struct perf_event_attr *attr) { return -ENOSYS; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8ec2cb688903..5ee1522a99c9 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -887,6 +887,43 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_wide_hw_breakpoint_local - update breakpoint config for local CPU
+ * @bp: the hwbp perf event for this CPU
+ * @attr: the new attribute for @bp
+ *
+ * This does not release and reserve the slot of a HWBP; it just reuses the
+ * current slot on local CPU. So the users must update the other CPUs by
+ * themselves.
+ * Also, since this does not release/reserve the slot, this can not change the
+ * type to incompatible type of the HWBP.
+ * Return err if attr is invalid or the CPU fails to update debug register
+ * for new @attr.
+ */
+#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	int ret;
+
+	if (find_slot_idx(bp->attr.bp_type) != find_slot_idx(attr->bp_type))
+		return -EINVAL;
+
+	ret = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
+	if (ret)
+		return ret;
+
+	return arch_reinstall_hw_breakpoint(bp);
+}
+#else
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+EXPORT_SYMBOL_GPL(modify_wide_hw_breakpoint_local);
+
 /**
  * hw_breakpoint_is_used - check if breakpoints are currently used
  *

