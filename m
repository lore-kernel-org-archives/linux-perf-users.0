Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF800259CB5;
	Fri, 25 Apr 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592974; cv=none; b=NQQuqOq45HVGXYavZsb7QX6XiMeGcZiMP2N7P3VQdK8tyzUi5x0T9NeZB6B1Dopv41ncw/sixuj0BXEm3XuCBe5eQYkX95e9AMY7GMvqX7pJWQ7obgDrAx99i+FU/7QzITHnhyJrZLGayTH2hB9OUe8RM95nwfrQO/NXAawGzmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592974; c=relaxed/simple;
	bh=7I11mP3w18vX4htds3yiDDbcRgMIVKdNKXayRuKw4cg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=vAgPW7CjUWmlTpGRKOI0vdbrNSZCaky9DvHRuO+hefT6h6d+2uoC4OIMyB4vg8JnH08K/j/iVtOTCJxL53DMbJXbfmGvy3cM97kifMp/+ygSwpGxtOOc9h+DB3Oq4EmGY4E+eMt0chbZjkp1FnNiBSj4nragOT+WqfAPWixwlfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0E5C4CEEC;
	Fri, 25 Apr 2025 14:56:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u8KVI-0000000HShs-1yT4;
	Fri, 25 Apr 2025 10:58:12 -0400
Message-ID: <20250425145812.324131816@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 25 Apr 2025 10:54:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
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
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v6 04/18] perf/x86: Rename and move get_segment_base() and make it global
References: <20250425145422.132820147@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_segment_base() will be used by the unwind_user code, so make it
global and rename it so it doesn't conflict with a KVM function of the
same name.

As the function is no longer specific to perf, move it to ptrace.c as that
seems to be a better location for a generic function like this.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/events/core.c        | 44 ++++-------------------------------
 arch/x86/include/asm/ptrace.h |  2 ++
 arch/x86/kernel/ptrace.c      | 38 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 85eb0eb1b284..524a59d9c2c4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -42,6 +42,7 @@
 #include <asm/ldt.h>
 #include <asm/unwind.h>
 #include <asm/uprobes.h>
+#include <asm/ptrace.h>
 #include <asm/ibt.h>
 
 #include "perf_event.h"
@@ -2807,41 +2808,6 @@ valid_user_frame(const void __user *fp, unsigned long size)
 	return __access_ok(fp, size);
 }
 
-static unsigned long get_segment_base(unsigned int segment)
-{
-	struct desc_struct *desc;
-	unsigned int idx = segment >> 3;
-
-	if ((segment & SEGMENT_TI_MASK) == SEGMENT_LDT) {
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-		struct ldt_struct *ldt;
-
-		/*
-		 * If we're not in a valid context with a real (not just lazy)
-		 * user mm, then don't even try.
-		 */
-		if (!nmi_uaccess_okay())
-			return 0;
-
-		/* IRQs are off, so this synchronizes with smp_store_release */
-		ldt = smp_load_acquire(&current->mm->context.ldt);
-		if (!ldt || idx >= ldt->nr_entries)
-			return 0;
-
-		desc = &ldt->entries[idx];
-#else
-		return 0;
-#endif
-	} else {
-		if (idx >= GDT_ENTRIES)
-			return 0;
-
-		desc = raw_cpu_ptr(gdt_page.gdt) + idx;
-	}
-
-	return get_desc_base(desc);
-}
-
 #ifdef CONFIG_UPROBES
 /*
  * Heuristic-based check if uprobe is installed at the function entry.
@@ -2898,8 +2864,8 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	if (user_64bit_mode(regs))
 		return 0;
 
-	cs_base = get_segment_base(regs->cs);
-	ss_base = get_segment_base(regs->ss);
+	cs_base = segment_base_address(regs->cs);
+	ss_base = segment_base_address(regs->ss);
 
 	fp = compat_ptr(ss_base + regs->bp);
 	pagefault_disable();
@@ -3018,11 +2984,11 @@ static unsigned long code_segment_base(struct pt_regs *regs)
 		return 0x10 * regs->cs;
 
 	if (user_mode(regs) && regs->cs != __USER_CS)
-		return get_segment_base(regs->cs);
+		return segment_base_address(regs->cs);
 #else
 	if (user_mode(regs) && !user_64bit_mode(regs) &&
 	    regs->cs != __USER32_CS)
-		return get_segment_base(regs->cs);
+		return segment_base_address(regs->cs);
 #endif
 	return 0;
 }
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 50f75467f73d..59357ec98e52 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -314,6 +314,8 @@ static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 	return !(regs->flags & X86_EFLAGS_IF);
 }
 
+unsigned long segment_base_address(unsigned int segment);
+
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
 extern const char *regs_query_register_name(unsigned int offset);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 095f04bdabdc..81353a09701b 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -41,6 +41,7 @@
 #include <asm/syscall.h>
 #include <asm/fsgsbase.h>
 #include <asm/io_bitmap.h>
+#include <asm/mmu_context.h>
 
 #include "tls.h"
 
@@ -339,6 +340,43 @@ static int set_segment_reg(struct task_struct *task,
 
 #endif	/* CONFIG_X86_32 */
 
+unsigned long segment_base_address(unsigned int segment)
+{
+	struct desc_struct *desc;
+	unsigned int idx = segment >> 3;
+
+	lockdep_assert_irqs_disabled();
+
+	if ((segment & SEGMENT_TI_MASK) == SEGMENT_LDT) {
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+		struct ldt_struct *ldt;
+
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return 0;
+
+		/* IRQs are off, so this synchronizes with smp_store_release */
+		ldt = smp_load_acquire(&current->mm->context.ldt);
+		if (!ldt || idx >= ldt->nr_entries)
+			return 0;
+
+		desc = &ldt->entries[idx];
+#else
+		return 0;
+#endif
+	} else {
+		if (idx >= GDT_ENTRIES)
+			return 0;
+
+		desc = raw_cpu_ptr(gdt_page.gdt) + idx;
+	}
+
+	return get_desc_base(desc);
+}
+
 static unsigned long get_flags(struct task_struct *task)
 {
 	unsigned long retval = task_pt_regs(task)->flags;
-- 
2.47.2


