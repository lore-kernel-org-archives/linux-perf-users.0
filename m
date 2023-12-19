Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E199B1FDE
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Dec 2023 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O99j8a51"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3063119a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Dec 2023 18:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702952555; x=1703557355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9p0315uqpc+n1pOToNiw0hz0iRBomEp4zEeHMgnV+bg=;
        b=O99j8a51X5+hF+FpQuMVGxhFhZm4XbJX0Ef9qOB0SV1Zr+mC4LWoAzTM6R/PEQnbrv
         xouwDccY/zDXkudG0XswFz7lXYWp0a86NbTIBBI0HmvypONUooUFmFBRuR6EQBzAbvSr
         pcR8u5lIBeOHkbggeKfp5d4WD/TpPX1uE62329nR2BvKlIFYS/Iw7dtCnidgEzGNOHlV
         gkUheBML5H3wFYd6f5XI5yE2YMqPC0f9uuzAx7XA6DDBTJDref++X13eu8TcSIhn5ITa
         W6lrQXvUXwnoDcwmDbz5ihSu0A8yJLrlRZoOsduvL9FzqO8p3IfThQaFPiNsqnk8H5Y2
         qBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702952555; x=1703557355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9p0315uqpc+n1pOToNiw0hz0iRBomEp4zEeHMgnV+bg=;
        b=Zt5fVIXpLBQj0IZTcxomJ69zRPF9zgBBxT1WmmfW2488iHBojbwNYV0qsDWNhaiKuB
         hREzn+iFJw5DzzSxwda1haf0r3Ibpp8TDEUFPpuL0UDDlKiJ4zHjqKJuzsgGYju2EWRW
         Nn7Q5Rwu5s8Ab3GAYz7M2JNtl5WzgZD5o+tTQOqq0S8vcDK1rVceRb+2GNlkxj9Omh4t
         oFjWiImYIJkHj73wlZKGEip319mWzmultXMFMVE7yz/8RCxEYE1WFLlo9nu0NMjHSG9g
         RAeK2uQVnVcMzhYfwxyXwkSHck7bJtXmdVwaf3WoarjJgdPYKtARnxrql6lQv2YTezkA
         lqKw==
X-Gm-Message-State: AOJu0Yz1XKvrFk0a6TINxhS+a+LDmFUW7Q1hznwJd0IikNCqS6b4eHzk
	9e0kyClzyVDXGSJx7yhJt0Y=
X-Google-Smtp-Source: AGHT+IEsWG1wWSv2Bht8XTIBKQwnu8RaFftFhLMdkyvRSBMXzm3jAmCm4ziRmR77h7OPqQigyVXDNg==
X-Received: by 2002:a05:6a20:72a0:b0:191:3733:ebaa with SMTP id o32-20020a056a2072a000b001913733ebaamr15853829pzk.50.1702952554945;
        Mon, 18 Dec 2023 18:22:34 -0800 (PST)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b006d36b6c6591sm4827946pff.39.2023.12.18.18.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:22:34 -0800 (PST)
From: chenqiwu <qiwuchen55@gmail.com>
X-Google-Original-From: chenqiwu <qiwu.chen@transsion.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kaleshsingh@google.com,
	ardb@kernel.org
Cc: alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	chenqiwu <qiwu.chen@transsion.com>
Subject: [RESEND v3] arm64: Add USER_STACKTRACE support
Date: Tue, 19 Dec 2023 10:22:29 +0800
Message-Id: <20231219022229.10230-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, userstacktrace is unsupported for ftrace and uprobe
tracers on arm64. This patch uses the perf_callchain_user() code
as blueprint to implement the arch_stack_walk_user() which add
userstacktrace support on arm64.
Meanwhile, we can use arch_stack_walk_user() to simplify the
implementation of perf_callchain_user().
This patch is tested pass with ftrace, uprobe and perf tracers
profiling userstacktrace cases.

changes in v3:
  - update perf_callchain_user() to use arch_stack_walk_user()
    and delete the redundant code as Mark's suggestion in v2.
  - update the commit message.

Tested-by: chenqiwu <qiwu.chen@transsion.com>
Signed-off-by: chenqiwu <qiwu.chen@transsion.com>
---
 arch/arm64/Kconfig                 |   1 +
 arch/arm64/kernel/perf_callchain.c | 118 +---------------------------
 arch/arm64/kernel/stacktrace.c     | 120 +++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 114 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..4c5066f88dd2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -255,6 +255,7 @@ config ARM64
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
+	select USER_STACKTRACE_SUPPORT
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 6d157f32187b..e8ed5673f481 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -10,94 +10,12 @@
 
 #include <asm/pointer_auth.h>
 
-struct frame_tail {
-	struct frame_tail	__user *fp;
-	unsigned long		lr;
-} __attribute__((packed));
-
-/*
- * Get the return address for a single stackframe and return a pointer to the
- * next frame tail.
- */
-static struct frame_tail __user *
-user_backtrace(struct frame_tail __user *tail,
-	       struct perf_callchain_entry_ctx *entry)
-{
-	struct frame_tail buftail;
-	unsigned long err;
-	unsigned long lr;
-
-	/* Also check accessibility of one struct frame_tail beyond */
-	if (!access_ok(tail, sizeof(buftail)))
-		return NULL;
-
-	pagefault_disable();
-	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
-	pagefault_enable();
-
-	if (err)
-		return NULL;
-
-	lr = ptrauth_strip_user_insn_pac(buftail.lr);
-
-	perf_callchain_store(entry, lr);
-
-	/*
-	 * Frame pointers should strictly progress back up the stack
-	 * (towards higher addresses).
-	 */
-	if (tail >= buftail.fp)
-		return NULL;
-
-	return buftail.fp;
-}
-
-#ifdef CONFIG_COMPAT
-/*
- * The registers we're interested in are at the end of the variable
- * length saved register structure. The fp points at the end of this
- * structure so the address of this struct is:
- * (struct compat_frame_tail *)(xxx->fp)-1
- *
- * This code has been adapted from the ARM OProfile support.
- */
-struct compat_frame_tail {
-	compat_uptr_t	fp; /* a (struct compat_frame_tail *) in compat mode */
-	u32		sp;
-	u32		lr;
-} __attribute__((packed));
-
-static struct compat_frame_tail __user *
-compat_user_backtrace(struct compat_frame_tail __user *tail,
-		      struct perf_callchain_entry_ctx *entry)
+static bool callchain_trace(void *data, unsigned long pc)
 {
-	struct compat_frame_tail buftail;
-	unsigned long err;
-
-	/* Also check accessibility of one struct frame_tail beyond */
-	if (!access_ok(tail, sizeof(buftail)))
-		return NULL;
-
-	pagefault_disable();
-	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
-	pagefault_enable();
-
-	if (err)
-		return NULL;
-
-	perf_callchain_store(entry, buftail.lr);
-
-	/*
-	 * Frame pointers should strictly progress back up the stack
-	 * (towards higher addresses).
-	 */
-	if (tail + 1 >= (struct compat_frame_tail __user *)
-			compat_ptr(buftail.fp))
-		return NULL;
+	struct perf_callchain_entry_ctx *entry = data;
 
-	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
+	return perf_callchain_store(entry, pc) == 0;
 }
-#endif /* CONFIG_COMPAT */
 
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
@@ -107,35 +25,7 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 		return;
 	}
 
-	perf_callchain_store(entry, regs->pc);
-
-	if (!compat_user_mode(regs)) {
-		/* AARCH64 mode */
-		struct frame_tail __user *tail;
-
-		tail = (struct frame_tail __user *)regs->regs[29];
-
-		while (entry->nr < entry->max_stack &&
-		       tail && !((unsigned long)tail & 0x7))
-			tail = user_backtrace(tail, entry);
-	} else {
-#ifdef CONFIG_COMPAT
-		/* AARCH32 compat mode */
-		struct compat_frame_tail __user *tail;
-
-		tail = (struct compat_frame_tail __user *)regs->compat_fp - 1;
-
-		while ((entry->nr < entry->max_stack) &&
-			tail && !((unsigned long)tail & 0x3))
-			tail = compat_user_backtrace(tail, entry);
-#endif
-	}
-}
-
-static bool callchain_trace(void *data, unsigned long pc)
-{
-	struct perf_callchain_entry_ctx *entry = data;
-	return perf_callchain_store(entry, pc) == 0;
+	arch_stack_walk_user(callchain_trace, entry, regs);
 }
 
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 17f66a74c745..7f9ab5a37096 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -240,3 +240,123 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
+
+/*
+ * The struct defined for userspace stack frame in AARCH64 mode.
+ */
+struct frame_tail {
+	struct frame_tail	__user *fp;
+	unsigned long		lr;
+} __attribute__((packed));
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static struct frame_tail __user *
+unwind_user_frame(struct frame_tail __user *tail, void *cookie,
+	       stack_trace_consume_fn consume_entry)
+{
+	struct frame_tail buftail;
+	unsigned long err;
+	unsigned long lr;
+
+	/* Also check accessibility of one struct frame_tail beyond */
+	if (!access_ok(tail, sizeof(buftail)))
+		return NULL;
+
+	pagefault_disable();
+	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
+	pagefault_enable();
+
+	if (err)
+		return NULL;
+
+	lr = ptrauth_strip_user_insn_pac(buftail.lr);
+
+	if (!consume_entry(cookie, lr))
+		return NULL;
+
+	/*
+	 * Frame pointers should strictly progress back up the stack
+	 * (towards higher addresses).
+	 */
+	if (tail >= buftail.fp)
+		return NULL;
+
+	return buftail.fp;
+}
+
+#ifdef CONFIG_COMPAT
+/*
+ * The registers we're interested in are at the end of the variable
+ * length saved register structure. The fp points at the end of this
+ * structure so the address of this struct is:
+ * (struct compat_frame_tail *)(xxx->fp)-1
+ *
+ * This code has been adapted from the ARM OProfile support.
+ */
+struct compat_frame_tail {
+	compat_uptr_t	fp; /* a (struct compat_frame_tail *) in compat mode */
+	u32		sp;
+	u32		lr;
+} __attribute__((packed));
+
+static struct compat_frame_tail __user *
+unwind_compat_user_frame(struct compat_frame_tail __user *tail, void *cookie,
+				stack_trace_consume_fn consume_entry)
+{
+	struct compat_frame_tail buftail;
+	unsigned long err;
+
+	/* Also check accessibility of one struct frame_tail beyond */
+	if (!access_ok(tail, sizeof(buftail)))
+		return NULL;
+
+	pagefault_disable();
+	err = __copy_from_user_inatomic(&buftail, tail, sizeof(buftail));
+	pagefault_enable();
+
+	if (err)
+		return NULL;
+
+	if (!consume_entry(cookie, buftail.lr))
+		return NULL;
+
+	/*
+	 * Frame pointers should strictly progress back up the stack
+	 * (towards higher addresses).
+	 */
+	if (tail + 1 >= (struct compat_frame_tail __user *)
+			compat_ptr(buftail.fp))
+		return NULL;
+
+	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
+}
+#endif /* CONFIG_COMPAT */
+
+
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+					const struct pt_regs *regs)
+{
+	if (!consume_entry(cookie, regs->pc))
+		return;
+
+	if (!compat_user_mode(regs)) {
+		/* AARCH64 mode */
+		struct frame_tail __user *tail;
+
+		tail = (struct frame_tail __user *)regs->regs[29];
+		while (tail && !((unsigned long)tail & 0x7))
+			tail = unwind_user_frame(tail, cookie, consume_entry);
+	} else {
+#ifdef CONFIG_COMPAT
+		/* AARCH32 compat mode */
+		struct compat_frame_tail __user *tail;
+
+		tail = (struct compat_frame_tail __user *)regs->compat_fp - 1;
+		while (tail && !((unsigned long)tail & 0x3))
+			tail = unwind_compat_user_frame(tail, cookie, consume_entry);
+#endif
+	}
+}
-- 
2.25.1

