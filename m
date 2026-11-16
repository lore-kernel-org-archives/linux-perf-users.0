Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794806782;
	b=F00KSBgncd/TWGA638FNkj1i7drbsYMd1A4Dx/LF3GTYGHLFvQsZ2EH/fVDPYUFSp7md
	 sliLRNW7wOv6EaiiCm74MlL5D6jW36fJpZBjmVqy1OnT55dE/W/XD6Rx1gMskTJmiW6bO
	 QUgYj/8DGzpiTmzZTsBWOWjyxrDdmXNx6W5GW9CSJar72rx+YcJ+O1nM4CtWdMd9o3Gp/
	 K2Jk1548Fr0dpk1GaaERM19SsVwTmj/rd1YsVgfQWK19jDNEEKmvESqYiLM6v5KkTXFn9
	 Yo8LEP5sOHkdZOzwCe8HEuS/pjdoXPwemljSkIsVjnmS6I5HNiIpmieKE1RItSShrzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794806782;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UbuB1TnXOXpyCifhsF2XAXsTnFr56VW7OXb0jSQBv7E=;
	b=co8Qy35rAmGhTu4NS2XbutwQGTSwT17dlUL6KhjbYdu3vJRsMkcTJtr3VdXJ1DLdCTeP
	 s8verKDzCtIxuICYtSQUBDfbVcirR+Z1M2uerxDKkSW6jrHKApzAHYbgSIP8VGn8jC/GW
	 lXwmIo/b3zVxWlGPM2DZqRF83ZLau5dt7tPY3UowTqZIturulHYw4meF+GTgkjFttQoUa
	 ar7Rkv2XLNvdhL+/3OabSixoDp39qJE9jjyiDyRgU6i+WAlljM/NZok9GQdRDd5be1e20
	 wDmIIe/m78Y1aV9td6Dts5TQEPNFLKDX/I+jGQkPfUr4DjwjypZrJnHL9VVHeEUM1SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQPVuLPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34304606A31C;
	Mon, 16 Nov 2026 05:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQPVuLPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1F31F000C6;
	Mon, 16 Nov 2026 05:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794806781;
	bh=UbuB1TnXOXpyCifhsF2XAXsTnFr56VW7OXb0jSQBv7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQPVuLPH0EFFWAgHbovX8JclS8PNXb7Q9Pr8a6n5pO7U9ThlGu9cBtz7QpWM9vqhE
	 osAJToImB0Mxh4QXM2gW/Hht9N1FlLzPiAStmdoAcu/p6NHh6wib8AXW0pVWBZXrs4
	 FwZTFy7qpZJaQphTDmQprr+4WhxeN4OxSWdQsE+vm5fPnVfBHlAQ9OLtJ7kGSeYVEB
	 fOYXDktY0KcFuAl8pZhc6k4ECdiZ06pZAhabKqVIhjy/OdDpMlesoycEizgHmE2+LK
	 9vlnUka+6Fd4bIPie7bXR5UwN1L68LV7I6HGkqM3DvELS2eUbwPqF2qmgZHtH+oaaq
	 bMP1CWjUs/BAA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
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
	x86@kernel.org
Subject: [PATCH v20 02/11] HWBP: Add modify_local_hw_breakpoint_addr() API
Date: Mon, 16 Nov 2026 14:26:15 +0900
Message-ID: <179480677551.38065.16911166185560694375.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179480675130.38065.3086970856119381693.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
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
index 1163736de1f9..ce6fe06838ea 100644
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
index 58dce0b66179..3c50d5a7e0e8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -248,6 +248,7 @@ config X86
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

