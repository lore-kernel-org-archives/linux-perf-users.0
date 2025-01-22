Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576C15F41F;
	Wed, 22 Jan 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513117; cv=none; b=Dr5XGTQewrPoIXn0tfKvDwbjADbpLroTESgVB4BhdlTCRELbl3myD/qtFX0mvAJOXYQ8JRJFrzmtori8MqyexG7+gm89tCvXsYuKpp7b+yXcWoZOFoiF9vCR9n+0jmAW+Mr8eo1NaZul33R/M18E8MpIkxYgATeXP6QrAOefJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513117; c=relaxed/simple;
	bh=tsZz8mO1UEv9uF6j2/ReT4Uu/+oVkcBzPEhAei4uj+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYiHcVzHrpaXDEQXXq6A7ZqDGaiY6eKkzDZUSCBwvXNi/bZtm8hUlAvOt/zOOHA/3lKx8oB/NholetnlOXcqb8wSzr8TNlMlAQ8Z/dcXy+LHQSiQr5WksOJsL6AJTNyUzSRxeed/l3lCZeLPg7pwftFKA5W51QuTHZ9QECxmhmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAPosJho; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAPosJho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E57C4CEE2;
	Wed, 22 Jan 2025 02:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513116;
	bh=tsZz8mO1UEv9uF6j2/ReT4Uu/+oVkcBzPEhAei4uj+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAPosJhopwYKNSB+WzO5fg+A5xPSTuwQ/StQkmyd/1ZACtjE+XLJ2WboxPFKaHnCE
	 L3Uymp7EZNPOBtr0l5tnkQZhshvhKh1SDeZLI/46lfTxVR1MNNYR92nqfwup90rEj+
	 yiSNNfKmZOQnlAxiNN8ZLlLGoW1b3aod87P3EmnXH0zBUCx9JfP9cdRimiQoD9C7NY
	 bQWAVOx6rpgcKptQK3JkMEGqbeHu7xtLmI8pOG4J5O6J6o7sw2iRWaEaVJechx+qax
	 zw1lppZYfsnAZZACN4wmysr66HFUt7RQcpuEWnGRrm0M7dx3rwpOahrjDZHVFbBG38
	 7O0V07JHHPZTw==
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
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 05/39] x86/asm: Avoid emitting DWARF CFI for non-VDSO
Date: Tue, 21 Jan 2025 18:30:57 -0800
Message-ID: <0c6c20d81164ba1dd375465f31bd51a8e1af164d.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was decided years ago that .cfi_* annotations aren't maintainable in
the kernel.  They were replaced by objtool unwind hints.  For the kernel
proper, ensure the CFI_* macros don't do anything.

On the other hand the VDSO library *does* use them, so user space can
unwind through it.

Make sure these macros only work for VDSO.  They aren't actually being
used outside of VDSO anyway, so there's no functional change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/dwarf2.h | 51 ++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 430fca13bb56..b195b3c8677e 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -6,6 +6,15 @@
 #warning "asm/dwarf2.h should be only included in pure assembly files"
 #endif
 
+#ifdef BUILD_VDSO
+
+	/*
+	 * For the vDSO, emit both runtime unwind information and debug
+	 * symbols for the .dbg file.
+	 */
+
+	.cfi_sections .eh_frame, .debug_frame
+
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
 #define CFI_DEF_CFA		.cfi_def_cfa
@@ -21,21 +30,31 @@
 #define CFI_UNDEFINED		.cfi_undefined
 #define CFI_ESCAPE		.cfi_escape
 
-#ifndef BUILD_VDSO
-	/*
-	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
-	 * The latter we currently just discard since we don't do DWARF
-	 * unwinding at runtime.  So only the offline DWARF information is
-	 * useful to anyone.  Note we should not use this directive if we
-	 * ever decide to enable DWARF unwinding at runtime.
-	 */
-	.cfi_sections .debug_frame
-#else
-	 /*
-	  * For the vDSO, emit both runtime unwind information and debug
-	  * symbols for the .dbg file.
-	  */
-	.cfi_sections .eh_frame, .debug_frame
-#endif
+#else /* !BUILD_VDSO */
+
+/*
+ * On x86, these macros aren't used outside VDSO.  As well they shouldn't be:
+ * they're fragile and very difficult to maintain.
+ */
+
+.macro nocfi args:vararg
+.endm
+
+#define CFI_STARTPROC		nocfi
+#define CFI_ENDPROC		nocfi
+#define CFI_DEF_CFA		nocfi
+#define CFI_DEF_CFA_REGISTER	nocfi
+#define CFI_DEF_CFA_OFFSET	nocfi
+#define CFI_ADJUST_CFA_OFFSET	nocfi
+#define CFI_OFFSET		nocfi
+#define CFI_REL_OFFSET		nocfi
+#define CFI_REGISTER		nocfi
+#define CFI_RESTORE		nocfi
+#define CFI_REMEMBER_STATE	nocfi
+#define CFI_RESTORE_STATE	nocfi
+#define CFI_UNDEFINED		nocfi
+#define CFI_ESCAPE		nocfi
+
+#endif /* !BUILD_VDSO */
 
 #endif /* _ASM_X86_DWARF2_H */
-- 
2.48.1

