Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BA42902C;
	Fri, 17 Jul 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298060; cv=none; b=Nk+qRd5j/C90MR/dA5ci55Y+6MdclrjWi1WuwL58hyScR3naHBgF3bXQmsjGw2EpPZlmD6YpqmAidREGp1MOFr0zf8QPGBluvJp4/PdNBQDp9YmXSRQ1XW/vyijWtg/9GiSkJ4vZp9VN84Ioi73p4KKBe1yb2lSLJ2pni5zJqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298060; c=relaxed/simple;
	bh=J650K9ne3sncrKq+oQkVV/WSF5KEgsGoIGhHo+oaUz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zk3oTI+Kog7Mh9lqPwCIEQcYRQL/waYqVki8R3+XTbCqJfb7g5vmYJk5DN9dpuCvOe1MO0Q/TE/7XsDSUErg/yuTzz4DR7OcoEjK0SsIa09j/RAM0GjI4eMRCZxOsV187wCK/Dqwm8lQjMfFVgFMFBjpZpMiAfcrg0ne/k+RL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGHDdDCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGHDdDCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD3B1F000E9;
	Fri, 17 Jul 2026 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298058;
	bh=7L2ZDP7vlMbpdbvrvv+UWPR3u/IcDNhTp0P9f08Qmjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGHDdDCyG7ezyEQ1BDVcoiXURrIc7W1UBh9cNfXS49gG6lj3b4NW5T15KEzMLRu1/
	 mIWi1EKjleLePHOPsWiZGTYwEuHAYy0wuE67Um/KPFGvjf27xl4zw3MC2s3qdFfA2U
	 tYD3urxK8Q3x/jJYpuL1mXb1NT92BSAX2FqFsG5Pz2/MQLd2i3WXFzXiNVupdKhME+
	 Ok+LNRayEGdmKxwyRC05MGN7Q5PFsUpbL4bo8gIsTaUns0KLOguUJYKehRRx6Sqs1A
	 lzHaYVK3XgXBAdQV7PukdwIDXh3v10pI5uGfrwxQ3N0vsGSl44klLIOIyWBXtX5xpk
	 2auzBiVpchYpQ==
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
Subject: [PATCH v9 07/10] HWBP: Add modify_wide_hw_breakpoint_local() API
Date: Fri, 17 Jul 2026 23:20:52 +0900
Message-ID: <178429805249.157981.8923964457350538000.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178429796992.157981.3393977217853767915.stgit@devnote2>
References: <178429796992.157981.3393977217853767915.stgit@devnote2>
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

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
  - Add lockdep_assert_irqs_disabled() to enforce and document the
    interrupt-disabled calling context requirement.
  - Implement state rollback logic in modify_wide_hw_breakpoint_local()
    to prevent inconsistent state on architecture update failure.
 Changes in v8:
  - Parse new attributes into a temporary struct arch_hw_breakpoint
    copy to prevent in-place mutation and corruption on parse error paths.
  - Synchronize logical perf_event attributes by updating
   bp->attr.bp_type and bp->attr.bp_len in modify_wide_hw_breakpoint_local().
 Changes in v7:
  - Update bp->attr.bp_attr so that we can correctly check the
    address on it.
  - Use -EOPNOTSUPP instead of -ENOSYS.
 Changes in v4:
  - Update kerneldoc comment about modify_wide_hw_breakpoint_local
    according to Randy's comment.
 Changes in v2:
  - Check type compatibility by checking slot. (Thanks Jinchao!)
---
 arch/Kconfig                  |   10 +++++++
 arch/x86/Kconfig              |    1 +
 include/linux/hw_breakpoint.h |    6 ++++
 kernel/events/hw_breakpoint.c |   61 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 959aee9568ff..4a87e843bb4c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -467,6 +467,16 @@ config HAVE_POST_BREAKPOINT_HOOK
 	  Select this option if your arch implements breakpoints overflow
 	  handler hooks after the target memory is modified.
 
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
index 6b7e14ef8cfb..588218da8f41 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -247,6 +247,7 @@ config X86
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
 	select HAVE_POST_BREAKPOINT_HOOK
+	select HAVE_REINSTALL_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..6754ffbee9ed 100644
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
+				struct perf_event_attr *attr) { return -EOPNOTSUPP; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c185a..63570a5079bf 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -888,6 +888,67 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
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
+	struct arch_hw_breakpoint info, old_info;
+	unsigned long old_addr;
+	unsigned int old_type, old_len;
+	int ret;
+
+	lockdep_assert_irqs_disabled();
+
+	if (find_slot_idx(bp->attr.bp_type) != find_slot_idx(attr->bp_type))
+		return -EINVAL;
+
+	ret = hw_breakpoint_arch_parse(bp, attr, &info);
+	if (ret)
+		return ret;
+
+	old_info = *counter_arch_bp(bp);
+	old_addr = bp->attr.bp_addr;
+	old_type = bp->attr.bp_type;
+	old_len = bp->attr.bp_len;
+
+	*counter_arch_bp(bp) = info;
+	bp->attr.bp_addr = attr->bp_addr;
+	bp->attr.bp_type = attr->bp_type;
+	bp->attr.bp_len = attr->bp_len;
+
+	ret = arch_reinstall_hw_breakpoint(bp);
+	if (ret) {
+		/* Rollback to the original state */
+		*counter_arch_bp(bp) = old_info;
+		bp->attr.bp_addr = old_addr;
+		bp->attr.bp_type = old_type;
+		bp->attr.bp_len = old_len;
+	}
+
+	return ret;
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

