Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA8346A14;
	Mon,  1 Sep 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737914; cv=none; b=vAVPgaOajypxANzHlDL60km5miMKx7eJjuzn50ZXVeM37jGE4XPBpIO2hUTUy6MiHw03CtnGh/BRYjCufgTMooNYdTbZ6aGNL0lyi539jkgCF+N+DraD4s3FfRNiw8pSXS3i87dttodL8faZoaKXcCQ+3XZr+3pOZ4i7XiZrtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737914; c=relaxed/simple;
	bh=gSiXuEAb7a/LqmE+DtueBaORM6s++MMCk7+u/7YFmUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRCspbfYYM1c3+I9r0gB6rGrdb+VUsrMNH5LCUbzLZSpupeTxZKTpCVAiBzEOio0pTa7GUxkMug0gr3IjKZlFHYYUrSkE8rkr6uyxpHGgSEkD1sWHMR66x7vm7NJ6N4/RBajry0GBl/OF4ukisbyLjWqdjtXjhr29goEMnMVBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhHuGE4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhHuGE4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719AEC4CEF0;
	Mon,  1 Sep 2025 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756737914;
	bh=gSiXuEAb7a/LqmE+DtueBaORM6s++MMCk7+u/7YFmUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhHuGE4+SMlBw3aQ42UzR/Z/kT5TrLjjmDQhDX4KdOUxH5g7C/g5614vYgc67ZsjY
	 I/mWJkp4ZkWMoptUJlqRFMAqy8yryIDj9GnjJN7hA05hemJaHt4XzrRrj1kzc+oFk6
	 jogJm/TIEwCoV3pMWPYl/CQS4ygd5llFm66hyJRqW/C2AUxxakdepoVbA50RRAJZhF
	 vr4qO3yb91ydG1uqUV+L6xZc3qz8lHAjijrJ0LRTsrWukaTrP5AXDw5XZsmeqSPR4O
	 h0uPY7gKCCTKuSi2N393IiJb/y+mlajzMpxGDljuy5oDcqrqe2Mx7YH0FSNAAFpZVk
	 SHXJuIySjwdfg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: [RFC PATCH 3/6] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Mon,  1 Sep 2025 23:45:08 +0900
Message-ID: <175673790787.478080.2462229320641296631.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175673787502.478080.3342912952394010967.stgit@devnote2>
References: <175673787502.478080.3342912952394010967.stgit@devnote2>
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
Note that this can not change the type because it does not release and
reserve the hwbp slot based on type.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/Kconfig                         |   10 +++++++++
 arch/x86/Kconfig                     |    1 +
 arch/x86/include/asm/hw_breakpoint.h |    2 ++
 arch/x86/kernel/hw_breakpoint.c      |   11 ++++++++++
 include/linux/hw_breakpoint.h        |    6 ++++++
 kernel/events/hw_breakpoint.c        |   36 ++++++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+)

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
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index bb7c70ad22fe..b3db25eb613f 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -64,6 +64,8 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
 
+bool hw_breakpoint_arch_same_type(struct arch_hw_breakpoint *hw,
+				  struct perf_event_attr *attr);
 extern void
 arch_fill_perf_breakpoint(struct perf_event *bp);
 
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 89135229ed21..7dfc88ff6cd9 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -278,6 +278,17 @@ int arch_bp_generic_fields(int x86_len, int x86_type,
 	return 0;
 }
 
+bool hw_breakpoint_arch_same_type(struct arch_hw_breakpoint *hw,
+				  struct perf_event_attr *attr)
+{
+	int glen, gtype;
+
+	if (arch_bp_generic_fields(hw->len, hw->type, &glen, &gtype) < 0)
+		return false;
+
+	return gtype == attr->bp_type;
+}
+
 /*
  * Check for virtual address in kernel space.
  */
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
index 8ec2cb688903..473a5b76941d 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -887,6 +887,42 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_wide_hw_breakpoint_local - update breakpoint config for local cpu
+ * @bp: the hwbp perf event for this cpu
+ * @attr: the new attribute for @bp
+ *
+ * This does not release and reserve the slot of HWBP, just reuse the current
+ * slot on local CPU. So the users must update the other CPUs by themselves.
+ * Also, since this does not release/reserve the slot, this can not change the
+ * type of the HWBP.
+ * Return err if attr is invalid or the cpu fails to update debug register
+ * for new @attr.
+ */
+#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	int ret;
+
+	if (!hw_breakpoint_arch_same_type(counter_arch_bp(bp), attr))
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

