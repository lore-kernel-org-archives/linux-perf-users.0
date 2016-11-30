From: Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH 2/2] perf annotate: AArch64 support
Date: Wed, 30 Nov 2016 09:23:44 -0600
Message-ID: <20161130092344.012e18e3e623bea395162f95@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752845AbcK3PXr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Nov 2016 10:23:47 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Chris Ryder <chris.ryder@arm.com>, Pawel Moll <pawel.moll@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org

This is a regex converted version from the original:

	https://lkml.org/lkml/2016/5/19/461

Add basic support to recognise AArch64 assembly. This allows perf to
identify AArch64 instructions that branch to other parts within the
same function, thereby properly annotating them.

Rebased onto new cross-arch annotation bits:

	https://lkml.org/lkml/2016/11/25/546

Sample output:

security_file_permission  vmlinux
  5.80 │    ← ret                                                            ▒
       │70:   ldr    w0, [x21,#68]                                           ▒
  4.44 │    ↓ tbnz   d0                                                      ▒
       │      mov    w0, #0x24                       // #36                  ▒
  1.37 │      ands   w0, w22, w0                                             ▒
       │    ↑ b.eq   60                                                      ▒
  1.37 │    ↓ tbnz   e4                                                      ▒
       │      mov    w19, #0x20000                   // #131072              ▒
  1.02 │    ↓ tbz    ec                                                      ▒
       │90:┌─→ldr    x3, [x21,#24]                                           ▒
  1.37 │   │  add    x21, x21, #0x10                                         ▒
       │   │  mov    w2, w19                                                 ▒
  1.02 │   │  mov    x0, x21                                                 ▒
       │   │  mov    x1, x3                                                  ▒
  1.71 │   │  ldr    x20, [x3,#48]                                           ▒
       │   │→ bl     __fsnotify_parent                                       ▒
  0.68 │   │↑ cbnz   60                                                      ▒
       │   │  mov    x2, x21                                                 ▒
  1.37 │   │  mov    w1, w19                                                 ▒
       │   │  mov    x0, x20                                                 ▒
  0.68 │   │  mov    w5, #0x0                        // #0                   ▒
       │   │  mov    x4, #0x0                        // #0                   ▒
  1.71 │   │  mov    w3, #0x1                        // #1                   ▒
       │   │→ bl     fsnotify                                                ▒
  1.37 │   │↑ b      60                                                      ▒
       │d0:│  mov    w0, #0x0                        // #0                   ▒
       │   │  ldp    x19, x20, [sp,#16]                                      ▒
       │   │  ldp    x21, x22, [sp,#32]                                      ▒
       │   │  ldp    x29, x30, [sp],#48                                      ▒
       │   │← ret                                                            ▒
       │e4:│  mov    w19, #0x10000                   // #65536               ▒
       │   └──b      90                                                      ◆
       │ec:   brk    #0x800                                                  ▒
Press 'h' for help on key bindings

Signed-off-by: Chris Ryder <chris.ryder@arm.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 tools/perf/arch/arm64/annotate/instructions.c | 62 +++++++++++++++++++++++++++
 tools/perf/util/annotate.c                    |  5 +++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/perf/arch/arm64/annotate/instructions.c

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
new file mode 100644
index 0000000..44eafd6
--- /dev/null
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -0,0 +1,62 @@
+#include <sys/types.h>
+#include <regex.h>
+
+struct arm64_annotate {
+	regex_t call_insn,
+		jump_insn;
+};
+
+static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
+{
+	struct arm64_annotate *arm = arch->priv;
+	struct ins_ops *ops;
+	regmatch_t match[2];
+
+	if (!regexec(&arm->jump_insn, name, 2, match, 0))
+		ops = &jump_ops;
+	else if (!regexec(&arm->call_insn, name, 2, match, 0))
+		ops = &call_ops;
+	else if (!strcmp(name, "ret"))
+		ops = &ret_ops;
+	else
+		return NULL;
+
+	arch__associate_ins_ops(arch, name, ops);
+	return ops;
+}
+
+static int arm64__annotate_init(struct arch *arch)
+{
+	struct arm64_annotate *arm;
+	int err;
+
+	if (arch->initialized)
+		return 0;
+
+	arm = zalloc(sizeof(*arm));
+	if (!arm)
+		return -1;
+
+	/* bl, blr */
+	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
+	if (err)
+		goto out_free_arm;
+	/* b, b.cond, br, cbz/cbnz, tbz/tbnz */
+	err = regcomp(&arm->jump_insn, "^[ct]?br?\\.?(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl)?n?z?$",
+		      REG_EXTENDED);
+	if (err)
+		goto out_free_call;
+
+	arch->initialized = true;
+	arch->priv	  = arm;
+	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
+	arch->objdump.comment_char	  = ';';
+	arch->objdump.skip_functions_char = '+';
+	return 0;
+
+out_free_call:
+	regfree(&arm->call_insn);
+out_free_arm:
+	free(arm);
+	return -1;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3e34ee0..76b8bbf 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -105,6 +105,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 }
 
 #include "arch/arm/annotate/instructions.c"
+#include "arch/arm64/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
 
@@ -114,6 +115,10 @@ static struct arch architectures[] = {
 		.init = arm__annotate_init,
 	},
 	{
+		.name = "arm64",
+		.init = arm64__annotate_init,
+	},
+	{
 		.name = "x86",
 		.instructions = x86__instructions,
 		.nr_instructions = ARRAY_SIZE(x86__instructions),
-- 
2.10.2
