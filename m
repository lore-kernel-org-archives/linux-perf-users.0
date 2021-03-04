Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7ADC4332B
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 16:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E6364F53
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 16:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhCDQe3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:34:29 -0500
Received: from foss.arm.com ([217.140.110.172]:41126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238073AbhCDQeO (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Mar 2021 11:34:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69E5511D4;
        Thu,  4 Mar 2021 08:33:28 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.51.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 781C23F766;
        Thu,  4 Mar 2021 08:33:23 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>, James Clark <james.clark@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
Subject: [PATCH RESEND WITH CCs v3 4/4] perf tools: determine if LR is the return address
Date:   Thu,  4 Mar 2021 16:32:55 +0000
Message-Id: <20210304163255.10363-4-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210304163255.10363-1-alexandre.truong@arm.com>
References: <20210304163255.10363-1-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On arm64 and frame pointer mode (e.g: perf record --callgraph fp),
use dwarf unwind info to check if the link register is the return
address in order to inject it to the frame pointer stack.

Write the following application:

	int a = 10;

	void f2(void)
	{
		for (int i = 0; i < 1000000; i++)
			a *= a;
	}

	void f1()
	{
		for (int i = 0; i < 10; i++)
			f2();
	}

	int main (void)
	{
		f1();
		return 0;
	}

with the following compilation flags:
	gcc -fno-omit-frame-pointer -fno-inline -O2

The compiler omits the frame pointer for f2 on arm. This is a problem
with any leaf call, for example an application with many different
calls to malloc() would always omit the calling frame, even if it
can be determined.

	./perf record --call-graph fp ./a.out
	./perf report

currently gives the following stack:

0xffffea52f361
_start
__libc_start_main
main
f2

After this change, perf report correctly shows f1() calling f2(),
even though it was missing from the frame pointer unwind:

	./perf report

0xffffea52f361
_start
__libc_start_main
main
f1
f2

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kemeng Shi <shikemeng@huawei.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Al Grant <al.grant@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: Wilco Dijkstra <wilco.dijkstra@arm.com>
---
 tools/perf/util/Build                         |  1 +
 .../util/arm-frame-pointer-unwind-support.c   | 44 +++++++++++++++++++
 .../util/arm-frame-pointer-unwind-support.h   |  7 +++
 tools/perf/util/machine.c                     |  9 ++--
 4 files changed, 58 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/arm-frame-pointer-unwind-support.c
 create mode 100644 tools/perf/util/arm-frame-pointer-unwind-support.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 188521f34347..3b82cb992bce 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,3 +1,4 @@
+perf-y += arm-frame-pointer-unwind-support.o
 perf-y += annotate.o
 perf-y += block-info.o
 perf-y += block-range.o
diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.c b/tools/perf/util/arm-frame-pointer-unwind-support.c
new file mode 100644
index 000000000000..964efd08e72e
--- /dev/null
+++ b/tools/perf/util/arm-frame-pointer-unwind-support.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../arch/arm64/include/uapi/asm/perf_regs.h"
+#include "arch/arm64/include/perf_regs.h"
+#include "event.h"
+#include "arm-frame-pointer-unwind-support.h"
+#include "callchain.h"
+#include "unwind.h"
+
+struct entries {
+	u64 stack[2];
+	size_t length;
+};
+
+static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
+{
+	return callchain_param.record_mode == CALLCHAIN_FP && sample->user_regs.regs
+		&& sample->user_regs.mask == PERF_REGS_MASK;
+}
+
+static int add_entry(struct unwind_entry *entry, void *arg)
+{
+	struct entries *entries = arg;
+
+	entries->stack[entries->length++] = entry->ip;
+	return 0;
+}
+
+u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread)
+{
+	int ret;
+
+	struct entries entries = {{0, 0}, 0};
+
+	if (!get_leaf_frame_caller_enabled(sample))
+		return 0;
+
+	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2);
+
+	if (ret || entries.length != 2)
+		return ret;
+
+	return callchain_param.order == ORDER_CALLER ?
+		entries.stack[0] : entries.stack[1];
+}
diff --git a/tools/perf/util/arm-frame-pointer-unwind-support.h b/tools/perf/util/arm-frame-pointer-unwind-support.h
new file mode 100644
index 000000000000..16dc03fa9abe
--- /dev/null
+++ b/tools/perf/util/arm-frame-pointer-unwind-support.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
+#define __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H
+
+u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread);
+
+#endif /* __PERF_ARM_FRAME_POINTER_UNWIND_SUPPORT_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7f03ffa016b0..dfb72dbc0e2d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -34,6 +34,7 @@
 #include "bpf-event.h"
 #include <internal/lib.h> // page_size
 #include "cgroup.h"
+#include "arm-frame-pointer-unwind-support.h"
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -2671,10 +2672,12 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 	return err;
 }
 
-static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
-		struct thread *thread __maybe_unused)
+static u64 get_leaf_frame_caller(struct perf_sample *sample, struct thread *thread)
 {
-	return 0;
+	if (strncmp(thread->maps->machine->env->arch, "aarch64", 7) == 0)
+		return get_leaf_frame_caller_aarch64(sample, thread);
+	else
+		return 0;
 }
 
 static int thread__resolve_callchain_sample(struct thread *thread,
-- 
2.23.0

