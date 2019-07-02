From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/43] perf annotate: Add csky support
Date: Mon,  1 Jul 2019 23:26:15 -0300
Message-ID: <20190702022616.1259-43-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-csky@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

This patch add basic arch initialization and instruction associate
support for the csky CPU architecture.

E.g.:

  $ perf annotate --stdio2
  Samples: 161  of event 'cpu-clock:pppH', 4000 Hz, Event count (approx.):
  40250000, [percent: local period]
  test_4() /usr/lib/perf-test/callchain_test
  Percent

              Disassembly of section .text:

              00008420 <test_4>:
            test_4():
                subi  sp, sp, 4
                st.w  r8, (sp, 0x0)
                mov   r8, sp
                subi  sp, sp, 8
                subi  r3, r8, 4
                movi  r2, 0
                st.w  r2, (r3, 0x0)
              ↓ br    2e
  100.00  14:   subi  r3, r8, 4
                ld.w  r2, (r3, 0x0)
                subi  r3, r8, 8
                st.w  r2, (r3, 0x0)
                subi  r3, r8, 4
                ld.w  r3, (r3, 0x0)
                addi  r2, r3, 1
                subi  r3, r8, 4
                st.w  r2, (r3, 0x0)
          2e:   subi  r3, r8, 4
                ld.w  r2, (r3, 0x0)
                lrw   r3, 0x98967f    // 8598 <main+0x28>
                cmplt r3, r2
              ↑ bf    14
                mov   r0, r0
                mov   r0, r0
                mov   sp, r8
                ld.w  r8, (sp, 0x0)
                addi  sp, sp, 4
              ← rts

Signed-off-by: Mao Han <han_mao@c-sky.com>
Acked-by: Guo Ren <guoren@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-csky@vger.kernel.org
Link: http://lkml.kernel.org/r/d874d7782d9acdad5d98f2f5c4a6fb26fbe41c5d.1561531557.git.han_mao@c-sky.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/csky/annotate/instructions.c | 48 ++++++++++++++++++++
 tools/perf/util/annotate.c                   |  5 ++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/perf/arch/csky/annotate/instructions.c

diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/arch/csky/annotate/instructions.c
new file mode 100644
index 000000000000..5337bfb7d5fc
--- /dev/null
+++ b/tools/perf/arch/csky/annotate/instructions.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/compiler.h>
+
+static struct ins_ops *csky__associate_ins_ops(struct arch *arch,
+					       const char *name)
+{
+	struct ins_ops *ops = NULL;
+
+	/* catch all kind of jumps */
+	if (!strcmp(name, "bt") ||
+	    !strcmp(name, "bf") ||
+	    !strcmp(name, "bez") ||
+	    !strcmp(name, "bnez") ||
+	    !strcmp(name, "bnezad") ||
+	    !strcmp(name, "bhsz") ||
+	    !strcmp(name, "bhz") ||
+	    !strcmp(name, "blsz") ||
+	    !strcmp(name, "blz") ||
+	    !strcmp(name, "br") ||
+	    !strcmp(name, "jmpi") ||
+	    !strcmp(name, "jmp"))
+		ops = &jump_ops;
+
+	/* catch function call */
+	if (!strcmp(name, "bsr") ||
+	    !strcmp(name, "jsri") ||
+	    !strcmp(name, "jsr"))
+		ops = &call_ops;
+
+	/* catch function return */
+	if (!strcmp(name, "rts"))
+		ops = &ret_ops;
+
+	if (ops)
+		arch__associate_ins_ops(arch, name, ops);
+	return ops;
+}
+
+static int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+{
+	arch->initialized = true;
+	arch->objdump.comment_char = '/';
+	arch->associate_instruction_ops = csky__associate_ins_ops;
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 2d08c4b62c63..ec7aaf31c2b2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -145,6 +145,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/arc/annotate/instructions.c"
 #include "arch/arm/annotate/instructions.c"
 #include "arch/arm64/annotate/instructions.c"
+#include "arch/csky/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
 #include "arch/s390/annotate/instructions.c"
@@ -163,6 +164,10 @@ static struct arch architectures[] = {
 		.name = "arm64",
 		.init = arm64__annotate_init,
 	},
+	{
+		.name = "csky",
+		.init = csky__annotate_init,
+	},
 	{
 		.name = "x86",
 		.init = x86__annotate_init,
-- 
2.20.1
