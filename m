Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BAC07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 23:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABFE560FD8
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 23:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhGEX26 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 19:28:58 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58827 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhGEX25 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 19:28:57 -0400
Received: (Authenticated sender: edwin@etorok.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id F3EAA200009;
        Mon,  5 Jul 2021 23:26:16 +0000 (UTC)
From:   =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edwin@etorok.net>
To:     linux-riscv@lists.infradead.org
Cc:     =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edwin@etorok.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Fabian Hemmer <copy@copy.sh>,
        Remi Bernon <rbernon@codeweavers.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] tools/perf/arch/riscv: add libdw unwind test
Date:   Tue,  6 Jul 2021 00:25:24 +0100
Message-Id: <20210705232524.4024832-5-edwin@etorok.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210705232524.4024832-1-edwin@etorok.net>
References: <20210705232524.4024832-1-edwin@etorok.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Based on arm64/tests, adapted to RISC-V

Tested that it passes on HiFive Unmatched:
```
root@unmatched:~# perf test unwind
72: DWARF unwind                                                    : Ok
```

Depends on commits:
commit 92f29febffc8 ("perf tests: Consolidate test__arch_unwind_sample
                      declaration")
commit ce23ffdfb58d ("tools/perf: add riscv perf_regs.h to
                      check_headers.sh")

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Rob Herring <robh@kernel.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Fabian Hemmer <copy@copy.sh>
Cc: Remi Bernon <rbernon@codeweavers.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Edwin Török <edwin@etorok.net>
---
 tools/perf/arch/riscv/Build                |  1 +
 tools/perf/arch/riscv/include/arch-tests.h | 12 +++++
 tools/perf/arch/riscv/include/perf_regs.h  |  2 +
 tools/perf/arch/riscv/tests/Build          |  4 ++
 tools/perf/arch/riscv/tests/arch-tests.c   | 16 ++++++
 tools/perf/arch/riscv/tests/dwarf-unwind.c | 63 ++++++++++++++++++++++
 tools/perf/arch/riscv/tests/regs_load.S    | 45 ++++++++++++++++
 tools/perf/tests/Build                     |  2 +-
 8 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/riscv/include/arch-tests.h
 create mode 100644 tools/perf/arch/riscv/tests/Build
 create mode 100644 tools/perf/arch/riscv/tests/arch-tests.c
 create mode 100644 tools/perf/arch/riscv/tests/dwarf-unwind.c
 create mode 100644 tools/perf/arch/riscv/tests/regs_load.S

diff --git a/tools/perf/arch/riscv/Build b/tools/perf/arch/riscv/Build
index e4e5f33c84d8..a7dd46a5b678 100644
--- a/tools/perf/arch/riscv/Build
+++ b/tools/perf/arch/riscv/Build
@@ -1 +1,2 @@
 perf-y += util/
+perf-y += tests/
diff --git a/tools/perf/arch/riscv/include/arch-tests.h b/tools/perf/arch/riscv/include/arch-tests.h
new file mode 100644
index 000000000000..90ec4c8cb880
--- /dev/null
+++ b/tools/perf/arch/riscv/include/arch-tests.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_TESTS_H
+#define ARCH_TESTS_H
+
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+struct thread;
+struct perf_sample;
+#endif
+
+extern struct test arch_tests[];
+
+#endif
diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
index 6b02a767c918..e22c51078a59 100644
--- a/tools/perf/arch/riscv/include/perf_regs.h
+++ b/tools/perf/arch/riscv/include/perf_regs.h
@@ -8,6 +8,8 @@
 #include <linux/types.h>
 #include <asm/perf_regs.h>
 
+void perf_regs_load(u64 *regs);
+
 #define PERF_REGS_MASK	((1ULL << PERF_REG_RISCV_MAX) - 1)
 #define PERF_REGS_MAX	PERF_REG_RISCV_MAX
 #if __riscv_xlen == 64
diff --git a/tools/perf/arch/riscv/tests/Build b/tools/perf/arch/riscv/tests/Build
new file mode 100644
index 000000000000..3526ab0af9f9
--- /dev/null
+++ b/tools/perf/arch/riscv/tests/Build
@@ -0,0 +1,4 @@
+perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
+perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+
+perf-y += arch-tests.o
diff --git a/tools/perf/arch/riscv/tests/arch-tests.c b/tools/perf/arch/riscv/tests/arch-tests.c
new file mode 100644
index 000000000000..5b1543c98022
--- /dev/null
+++ b/tools/perf/arch/riscv/tests/arch-tests.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+struct test arch_tests[] = {
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+	{
+		.desc = "DWARF unwind",
+		.func = test__dwarf_unwind,
+	},
+#endif
+	{
+		.func = NULL,
+	},
+};
diff --git a/tools/perf/arch/riscv/tests/dwarf-unwind.c b/tools/perf/arch/riscv/tests/dwarf-unwind.c
new file mode 100644
index 000000000000..4792ecdb23c3
--- /dev/null
+++ b/tools/perf/arch/riscv/tests/dwarf-unwind.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include "perf_regs.h"
+#include "thread.h"
+#include "map.h"
+#include "maps.h"
+#include "event.h"
+#include "debug.h"
+#include "tests/tests.h"
+
+#define STACK_SIZE 8192
+
+static int sample_ustack(struct perf_sample *sample,
+			 struct thread *thread, u64 *regs)
+{
+	struct stack_dump *stack = &sample->user_stack;
+	struct map *map;
+	unsigned long sp;
+	u64 stack_size, *buf;
+
+	buf = malloc(STACK_SIZE);
+	if (!buf) {
+		pr_debug("failed to allocate sample uregs data\n");
+		return -1;
+	}
+
+	sp = (unsigned long) regs[PERF_REG_RISCV_SP];
+
+	map = maps__find(thread->maps, (u64)sp);
+	if (!map) {
+		pr_debug("failed to get stack map\n");
+		free(buf);
+		return -1;
+	}
+
+	stack_size = map->end - sp;
+	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
+
+	memcpy(buf, (void *) sp, stack_size);
+	stack->data = (char *) buf;
+	stack->size = stack_size;
+	return 0;
+}
+
+int test__arch_unwind_sample(struct perf_sample *sample,
+		struct thread *thread)
+{
+	struct regs_dump *regs = &sample->user_regs;
+	u64 *buf;
+
+	buf = calloc(1, sizeof(u64) * PERF_REGS_MAX);
+	if (!buf) {
+		pr_debug("failed to allocate sample uregs data\n");
+		return -1;
+	}
+
+	perf_regs_load(buf);
+	regs->abi  = PERF_SAMPLE_REGS_ABI;
+	regs->regs = buf;
+	regs->mask = PERF_REGS_MASK;
+
+	return sample_ustack(sample, thread, buf);
+}
diff --git a/tools/perf/arch/riscv/tests/regs_load.S b/tools/perf/arch/riscv/tests/regs_load.S
new file mode 100644
index 000000000000..a603baa4f0f8
--- /dev/null
+++ b/tools/perf/arch/riscv/tests/regs_load.S
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+
+.text
+.type perf_regs_load,%function
+
+#define STR_REG(r)	sd x##r, (__riscv_xlen/8 * r)(a0)
+#define PC	0
+
+/* Must match order in perf_regs.h */
+SYM_FUNC_START(perf_regs_load)
+	sd ra, PC(a0) # skip call to this function
+	STR_REG(1)
+	STR_REG(2)
+	STR_REG(3)
+	STR_REG(4)
+	STR_REG(5)
+	STR_REG(6)
+	STR_REG(7)
+	STR_REG(8)
+	STR_REG(9)
+	STR_REG(10)
+	STR_REG(11)
+	STR_REG(12)
+	STR_REG(13)
+	STR_REG(14)
+	STR_REG(15)
+	STR_REG(16)
+	STR_REG(17)
+	STR_REG(18)
+	STR_REG(19)
+	STR_REG(20)
+	STR_REG(21)
+	STR_REG(22)
+	STR_REG(23)
+	STR_REG(24)
+	STR_REG(25)
+	STR_REG(26)
+	STR_REG(27)
+	STR_REG(28)
+	STR_REG(29)
+	STR_REG(30)
+	STR_REG(31)
+	ret
+SYM_FUNC_END(perf_regs_load)
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 650aec19d490..77ac9add4ed8 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -93,7 +93,7 @@ $(OUTPUT)tests/llvm-src-relocation.c: tests/bpf-script-test-relocation.c tests/B
 	$(Q)sed -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/g' $< >> $@
 	$(Q)echo ';' >> $@
 
-ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
-- 
2.31.1

