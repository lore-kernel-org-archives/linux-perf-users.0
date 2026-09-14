Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A24519B3;
	Mon, 14 Sep 2026 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389720; cv=none; b=FVvnJqu5y67Y3X45CLdny1+pinDw4O+ADW0L6EETFUu3cLQV4C4ke3NnMy1KqLA4Mki8gnQ0+CmtyO5jYxT5Q4XV8zvXf6GcA6x86adShHAryETeAAueu1bWpTCb+8XocvxlhIHZxra+ylZ6ifg4LwWVVbN2ChdqAohzkSbR22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389720; c=relaxed/simple;
	bh=eMNAB5xUxD1KYvN9s9eiB3vxVYtj77kvS2QG+tKkTWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJMYVS1Nd/IuMznxscMCQEd7xwM0raPx8XfvmHjzS91Hchd5jkRWkDrtx4t1GUKROOfNp317ZsnWOTAoK3k+3ZPdtbbRWXQcaYhERrPPIp9voUsFoSBfCahZFIAo0mnM3XdPf8CWyMfFViYxmgX+e6zC1M934WrdNgQm8ma13DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aHcq0NQL; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aHcq0NQL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789389711; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hIAsTxK/GIeXWZKEGVKhB2wTz6FiK3T/cw3O4+RN5Q8=;
	b=aHcq0NQLl/YY/LPYV5LuNhyot+78WLoIWEqhVf3K9dttHMucwpjhnXBlmKqLYQlePOllP5ngPGo+zFmSoeRfXGFnptvF8UG3HHBIm/pFBGAGuD1188LWNpqY7o7fjBoD/Jy6eXfylMj5dSEVTG+F0He5xW/u3d+eCQq7NeOFTj4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0XAwBJDu_1789389705;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XAwBJDu_1789389705 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Sep 2026 20:41:50 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf riscv: Add perf_regs_load and enable the dwarf unwind test
Date: Mon, 14 Sep 2026 20:41:45 +0800
Message-ID: <20260914124145.1257-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

riscv has no arch level perf test: tests/builtin-test.c only picks up
arch_tests[] for x86, arm64 and powerpc64, tests/Build only builds the
generic dwarf unwind test driver for x86, arm, arm64 and powerpc, and
arch/riscv/tests/ did not exist. "Test dwarf unwind" was therefore never
registered on riscv, even though DWARF is the only reliable way to walk a
riscv user stack -- the arch callchain code walks frame pointers only --
and both unwinders already support riscv, elfutils libdw generically and
libunwind through util/libunwind-arch/libunwind-riscv.c.

Add perf_regs_load() and the arch unwind sample helper modelled on the
arm64 ones, and wire riscv into the two gates. The x1..x31 slots of enum
perf_event_riscv_regs match the hardware registers one to one, and
PERF_REG_RISCV_PC is filled with ra so that unwinding starts at the
caller.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

Tested on riscv64 (QEMU virt, kernel 6.18, rv64gcv userspace) with both
the libdw and the libunwind unwinder, and in both callchain orders. All
eight expected frames resolve, including the one in libc:

  # ./perf test -v "dwarf unwind"
   71: Test dwarf unwind                                     : Ok

  got: test__dwarf_unwind 0x555593375c45, expecting test__dwarf_unwind
  got: test_dwarf_unwind__krava_1 0x555593375b7f, expecting test_dwarf_unwind__krava_1
  got: test_dwarf_unwind__krava_2 0x555593375b43, expecting test_dwarf_unwind__krava_2
  got: test_dwarf_unwind__krava_3 0x555593375aff, expecting test_dwarf_unwind__krava_3
  got: bsearch 0x7fff9aad575b, expecting bsearch
  got: test_dwarf_unwind__compare 0x555593375a5d, expecting test_dwarf_unwind__compare
  got: test_dwarf_unwind__thread 0x555593375939, expecting test_dwarf_unwind__thread
  got: test__arch_unwind_sample 0x5555933788a0, expecting test__arch_unwind_sample

The libunwind build links libunwind-riscv.so.8, so the riscv specific
remote unwinder in util/libunwind-arch/libunwind-riscv.c is what runs.

A build with DWARF unwinding disabled was checked too: it still links,
arch_tests[] degrades to the NULL only array, and the test is simply
absent from "perf test list".

 tools/perf/arch/riscv/Build                |  1 +
 tools/perf/arch/riscv/include/arch-tests.h |  9 +++
 tools/perf/arch/riscv/include/perf_regs.h  |  2 +
 tools/perf/arch/riscv/tests/Build          |  4 ++
 tools/perf/arch/riscv/tests/arch-tests.c   | 10 ++++
 tools/perf/arch/riscv/tests/dwarf-unwind.c | 64 ++++++++++++++++++++++
 tools/perf/arch/riscv/tests/regs_load.S    | 58 ++++++++++++++++++++
 tools/perf/tests/Build                     |  2 +-
 tools/perf/tests/builtin-test.c            |  3 +-
 9 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/arch/riscv/include/arch-tests.h
 create mode 100644 tools/perf/arch/riscv/tests/Build
 create mode 100644 tools/perf/arch/riscv/tests/arch-tests.c
 create mode 100644 tools/perf/arch/riscv/tests/dwarf-unwind.c
 create mode 100644 tools/perf/arch/riscv/tests/regs_load.S

diff --git a/tools/perf/arch/riscv/Build b/tools/perf/arch/riscv/Build
index e63eabc2c8f4..12ebc65ea7a3 100644
--- a/tools/perf/arch/riscv/Build
+++ b/tools/perf/arch/riscv/Build
@@ -1 +1,2 @@
 perf-util-y += util/
+perf-test-y += tests/
diff --git a/tools/perf/arch/riscv/include/arch-tests.h b/tools/perf/arch/riscv/include/arch-tests.h
new file mode 100644
index 000000000000..2b3834a5ddbb
--- /dev/null
+++ b/tools/perf/arch/riscv/include/arch-tests.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_TESTS_H
+#define ARCH_TESTS_H
+
+struct test_suite;
+
+extern struct test_suite *arch_tests[];
+
+#endif
diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
index af7a1b47bf66..30cfd3f63eb5 100644
--- a/tools/perf/arch/riscv/include/perf_regs.h
+++ b/tools/perf/arch/riscv/include/perf_regs.h
@@ -8,6 +8,8 @@
 #include <linux/types.h>
 #include "../../../../arch/riscv/include/uapi/asm/perf_regs.h"
 
+void perf_regs_load(u64 *regs);
+
 #define PERF_REGS_MASK	((1ULL << PERF_REG_RISCV_MAX) - 1)
 #define PERF_REGS_MAX	PERF_REG_RISCV_MAX
 
diff --git a/tools/perf/arch/riscv/tests/Build b/tools/perf/arch/riscv/tests/Build
new file mode 100644
index 000000000000..bd15c6bbc1b2
--- /dev/null
+++ b/tools/perf/arch/riscv/tests/Build
@@ -0,0 +1,4 @@
+perf-test-y += regs_load.o
+perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+
+perf-test-y += arch-tests.o
diff --git a/tools/perf/arch/riscv/tests/arch-tests.c b/tools/perf/arch/riscv/tests/arch-tests.c
new file mode 100644
index 000000000000..756706a09609
--- /dev/null
+++ b/tools/perf/arch/riscv/tests/arch-tests.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+struct test_suite *arch_tests[] = {
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+	&suite__dwarf_unwind,
+#endif
+	NULL,
+};
diff --git a/tools/perf/arch/riscv/tests/dwarf-unwind.c b/tools/perf/arch/riscv/tests/dwarf-unwind.c
new file mode 100644
index 000000000000..e981b21f918d
--- /dev/null
+++ b/tools/perf/arch/riscv/tests/dwarf-unwind.c
@@ -0,0 +1,64 @@
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
+		struct thread *thread, u64 *regs)
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
+	map = maps__find(thread__maps(thread), (u64)sp);
+	if (!map) {
+		pr_debug("failed to get stack map\n");
+		free(buf);
+		return -1;
+	}
+
+	stack_size = map__end(map) - sp;
+	map__put(map);
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
+	struct regs_dump *regs = perf_sample__user_regs(sample);
+	u64 *buf;
+
+	buf = calloc(PERF_REGS_MAX, sizeof(u64));
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
index 000000000000..703bbf3374a6
--- /dev/null
+++ b/tools/perf/arch/riscv/tests/regs_load.S
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+
+/*
+ * Fill the u64 array 'regs' at the slots of enum perf_event_riscv_regs:
+ * x1..x31 map one-to-one onto PERF_REG_RISCV_RA..PERF_REG_RISCV_T6, and the
+ * stride stays 8 bytes on RV32 because the slots are u64 and the caller
+ * zeroes them.
+ *
+ * PERF_REG_RISCV_PC is filled with ra, the return address of the call to
+ * this function, so that unwinding starts at the caller rather than here.
+ */
+
+#if __riscv_xlen == 64
+#define REG_S	sd
+#else
+#define REG_S	sw
+#endif
+
+#define STR_REG(r)	REG_S x##r, 8 * r(a0)
+
+	.text
+	.type perf_regs_load,%function
+SYM_FUNC_START(perf_regs_load)
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
+	REG_S ra, 0(a0)
+	ret
+SYM_FUNC_END(perf_regs_load)
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 66944a4f4968..c457504e052d 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -72,7 +72,7 @@ perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
 
-ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4d0784b16723..a0478dd3e9cc 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -67,7 +67,8 @@ static const char *workload_control;
  * dependent on the initialization, as such GCC with LTO complains of
  * conflicting definitions with a weak symbol.
  */
-#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__) || \
+	defined(__powerpc64__) || defined(__riscv)
 extern struct test_suite *arch_tests[];
 #else
 static struct test_suite *arch_tests[] = {
-- 
2.50.1

