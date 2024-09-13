Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C3188581;
	Fri, 13 Sep 2024 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268617; cv=none; b=kI49Ermj1n+ZTIMM0A/le3RG8+JG48nlX8ZE0lieffEa4KWqR6t99e01l2LRcxzmJ+wjDcgt3un7tEt14mbmC7wDnnnCFzBKbEETDNZsuOTbx3eP0NFG/GarcUqm5H5hUUL2fo2Q9jW8RmrtDWqzBRy2CPqZMt9ipGqH1Gl1uLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268617; c=relaxed/simple;
	bh=tsAykqBgjsMjkNGrLVTIbkzu74rfQg/Ws7aF1PZ48YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mz19PaLIlV+BY4/272JQuuLqFnLv3Y3+YvXEYdWvXVoEx8S+gh3aCD7Jgem2eBrbQ2vWJikFY/56Xg9h7ZeLal5MYZbrKtXxRMmrv3GAD0iWwmzTFc/pnP8OFyUk2DOwLu1KpjhE+YDQ2zkqnqNvvUxxVCK/kd0xzbKk/mtHkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asmk2gIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asmk2gIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40026C4CEC0;
	Fri, 13 Sep 2024 23:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726268617;
	bh=tsAykqBgjsMjkNGrLVTIbkzu74rfQg/Ws7aF1PZ48YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=asmk2gIM/anizpcSOaB2wk0Je+81T9mfAQTyFGJ23OYJ0lLGCSfmguO/28DyUZgsZ
	 m2xnUDH7jnK1ItpQ435ZLBx213lYgynyCOSlauj/nA3aISG8bBb+RP0AZP642QEf16
	 teyUC1VBO4+JBpzS2sD/BK5YoAJttLuburWHMIvU8OI0KgydPHuZ0UhYlosFNg3QLP
	 JvnoDjP9L4Ir3cfUR+WgBtOnKLv5MlqAt+JYwE7XtiyMWsMmFa0V+I6dSnq2yDFMvO
	 WXD5pc9VGYG8C0MBXhtwZb8L1PSNf4zp6QqJ94yRaOWs+JmTPu6klGFuj+I5O558zd
	 HgxCBuhf5S/SA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH v2 10/11] perf/x86: Add HAVE_PERF_CALLCHAIN_DEFERRED
Date: Sat, 14 Sep 2024 01:02:12 +0200
Message-ID: <2b3be1da18a8a1895762c2f394aa353f227d6543.1726268190.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>
References: <cover.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable deferred user space unwinding on x86.  Frame pointers are still
the default for now.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Kconfig       |  1 +
 arch/x86/events/core.c | 52 +++++++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0b3d7c72b65b..24d9373cc5e6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -265,6 +265,7 @@ config X86
 	select HAVE_PERF_EVENTS_NMI
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PCI
+	select HAVE_PERF_CALLCHAIN_DEFERRED
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e82aadf99d9b..d6ea265d9aa8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2821,8 +2821,8 @@ static unsigned long get_segment_base(unsigned int segment)
 
 #include <linux/compat.h>
 
-static inline int
-perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *entry)
+static int __perf_callchain_user32(struct pt_regs *regs,
+				   struct perf_callchain_entry_ctx *entry)
 {
 	/* 32-bit process in 64-bit kernel. */
 	unsigned long ss_base, cs_base;
@@ -2836,7 +2836,6 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	ss_base = get_segment_base(regs->ss);
 
 	fp = compat_ptr(ss_base + regs->bp);
-	pagefault_disable();
 	while (entry->nr < entry->max_stack) {
 		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
@@ -2849,19 +2848,18 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 		perf_callchain_store(entry, cs_base + frame.return_address);
 		fp = compat_ptr(ss_base + frame.next_frame);
 	}
-	pagefault_enable();
 	return 1;
 }
-#else
-static inline int
-perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *entry)
+#else /* !CONFIG_IA32_EMULATION */
+static int __perf_callchain_user32(struct pt_regs *regs,
+				   struct perf_callchain_entry_ctx *entry)
 {
-    return 0;
+	return 0;
 }
-#endif
+#endif /* CONFIG_IA32_EMULATION */
 
-void
-perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
+static void __perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+				  struct pt_regs *regs, bool atomic)
 {
 	struct user_unwind_state state;
 
@@ -2878,20 +2876,36 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 
 	perf_callchain_store(entry, regs->ip);
 
-	if (!nmi_uaccess_okay())
-		return;
+	if (atomic) {
+		if (!nmi_uaccess_okay())
+			return;
+		pagefault_disable();
+	}
 
-	if (perf_callchain_user32(regs, entry))
-		return;
-
-	pagefault_disable();
+	if (__perf_callchain_user32(regs, entry))
+		goto done;
 
 	for_each_user_frame(&state, USER_UNWIND_TYPE_FP) {
 		if (perf_callchain_store(entry, state.ip))
-			break;
+			goto done;
 	}
 
-	pagefault_enable();
+done:
+	if (atomic)
+		pagefault_enable();
+}
+
+
+void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
+			 struct pt_regs *regs)
+{
+	return __perf_callchain_user(entry, regs, true);
+}
+
+void perf_callchain_user_deferred(struct perf_callchain_entry_ctx *entry,
+				  struct pt_regs *regs)
+{
+	return __perf_callchain_user(entry, regs, false);
 }
 
 /*
-- 
2.46.0

