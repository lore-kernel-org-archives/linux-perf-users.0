Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7F57F73D;
	Wed, 23 Sep 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176952; cv=none; b=PzCB+UPV2i8GXiYrn/Y4rU/J4yqUTLs6RgEmw7FfQm6rwtFxkvIrwCIJy/SYMI47PVqcVc3+Ry4drKAXsf14tivyFQ9lwQh+w5A1wahOD5J3y7+591h23VIF44RgKHo20TJyqG8SuU8YnVUbnLanutslpIqDHovEpMwVkJIR5FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176952; c=relaxed/simple;
	bh=wAWNock21fh69r9WLtcmCQrLPB75x0/Rq0TuxFYrW1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIY/Q6OtVYPA2pv6+idbusXVhado9zyQgw1rmVPdksnpl2bW5YKYcObnSdGDRm4WptEqIIp3zBFX4hCkuKWu2NZy5teCfF21HiYbcomaFVV6GTOo71n5MawipxNQvT7Mwd25ywZxk/FgY5hDIj4gVzt4ITgYq+q3Da+PO1mNYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fi7v9wZK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fi7v9wZK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F751E32;
	Wed, 23 Sep 2026 08:22:25 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAAC53F86F;
	Wed, 23 Sep 2026 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176949; bh=wAWNock21fh69r9WLtcmCQrLPB75x0/Rq0TuxFYrW1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fi7v9wZKt68Wyn8hugJhkzXQR6KS8/k4HG6wXUtfk+gDP0Jg2FyDay/tMmMHq+WlH
	 aYrStO+HiWYnNYQcbBMsYdVaHtHCZc4UE/9aske0GN497M/C7f5qvgk6pMd4dUcwOl
	 Ew/8NmN89urOYHJP6rPSlyujow81zMmBPHI6PSmQ=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:53 +0100
Subject: [PATCH v2 13/14] perf tests: Check CoreSight abort entry and exit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-13-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=5197;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=wAWNock21fh69r9WLtcmCQrLPB75x0/Rq0TuxFYrW1A=;
 b=m6woXg7xSqJIji2Grdy2XHeSakZASnTf9mr9BEZQczxOuS+ZaMnlSCyV2a24jYP+mPB+nzra5
 j9lydkL0C8rALuOwd07WxkhDhYEzdqyFTfJn8q89j1Gk82OHceQ3M2e
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add page_fault_loop to repeatedly discard an anonymous page with
MADV_DONTNEED and read it again. Each demand fault is resolved without
signal delivery, so the load must be retried at the same PC.

For example, an expected int/iret pair is:

  int            5ccadc => ffff800080010c00 insn: 00 00 40 39
  ...
  iret ffff800080012284 =>           5ccadc insn: e0 03 9f d6

The LDRB W0, [X0] at 0x5ccadc faults before completing. After resolving
the page fault, the kernel returns via ERET to the same PC to retry it.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/builtin-test.c                    |  1 +
 .../perf/tests/shell/coresight/abort_entry_exit.sh | 21 ++++++++++++
 tools/perf/tests/tests.h                           |  1 +
 tools/perf/tests/workloads/Build                   |  2 ++
 tools/perf/tests/workloads/page_fault_loop.c       | 37 ++++++++++++++++++++++
 5 files changed, 62 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8eab221f115e75a3ef90be975d4ed0558ceb2b16..1af8dfd45d1a2ff5c3206234cd75fb173e122d88 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -172,6 +172,7 @@ static struct test_workload *workloads[] = {
 	&workload__landlock,
 	&workload__traploop,
 	&workload__branch_not_taken_loop,
+	&workload__page_fault_loop,
 	&workload__inlineloop,
 	&workload__jitdump,
 	&workload__context_switch_loop,
diff --git a/tools/perf/tests/shell/coresight/abort_entry_exit.sh b/tools/perf/tests/shell/coresight/abort_entry_exit.sh
new file mode 100755
index 0000000000000000000000000000000000000000..483cf39b3966e89591d4e06d03a3fc6709fc3dc9
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/abort_entry_exit.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# CoreSight abort entry and exit (exclusive)
+
+# shellcheck source=../lib/coresight_exception.sh
+. "$(dirname "$0")/../lib/coresight_exception.sh"
+
+test_abort_entry_exit()
+{
+	# A demand page fault retries the load at the same PC after resolution.
+	if ! record_trace page_fault_loop; then
+		cat "$tmpdir/record.log"
+		echo "Failed to record the page fault workload"
+		return 1
+	fi
+	decode_trace || return 1
+	check_exception_pairs "int" "iret" 0 || return 1
+}
+
+setup_exception_test || exit $?
+test_abort_entry_exit
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 0a61129b31ab6997616f7d04d29af73961f4f861..0fc02c5b060133ef27b80de5c868d798d65a7c53 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -247,6 +247,7 @@ DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
 DECLARE_WORKLOAD(traploop);
 DECLARE_WORKLOAD(branch_not_taken_loop);
+DECLARE_WORKLOAD(page_fault_loop);
 DECLARE_WORKLOAD(inlineloop);
 DECLARE_WORKLOAD(jitdump);
 DECLARE_WORKLOAD(context_switch_loop);
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index ca22a82073ed08de5d4a27d0a3b33ddcba2e3f3e..e18fdaa6fd1927ed406e703a7ecbcc19a111caf3 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -10,6 +10,7 @@ perf-test-y += datasym.o
 perf-test-y += landlock.o
 perf-test-y += traploop.o
 perf-test-y += branch_not_taken_loop.o
+perf-test-y += page_fault_loop.o
 perf-test-y += inlineloop.o
 perf-test-y += jitdump.o
 perf-test-y += context_switch_loop.o
@@ -27,6 +28,7 @@ CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_branch_not_taken_loop.o = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_page_fault_loop.o  = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_inlineloop.o       = -g -O2
 CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/page_fault_loop.c b/tools/perf/tests/workloads/page_fault_loop.c
new file mode 100644
index 0000000000000000000000000000000000000000..4afbc4ab0a55400360facdc3a99ea5a5a9d52596
--- /dev/null
+++ b/tools/perf/tests/workloads/page_fault_loop.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <stdio.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include "../tests.h"
+
+static int page_fault_loop(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	size_t size = getpagesize();
+	char *page;
+	int ret = 1;
+
+	page = mmap(NULL, size, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (page == MAP_FAILED) {
+		perror("mmap");
+		return 1;
+	}
+
+	for (int i = 0; i < 256; i++) {
+		/* Drop the PTE so the kernel must resolve a fault on each read. */
+		if (madvise(page, size, MADV_DONTNEED)) {
+			perror("madvise");
+			goto out;
+		}
+		if (READ_ONCE(*page)) {
+			fprintf(stderr, "Anonymous page is not zero-filled\n");
+			goto out;
+		}
+	}
+	ret = 0;
+out:
+	munmap(page, size);
+	return ret;
+}
+
+DEFINE_WORKLOAD(page_fault_loop);

-- 
2.34.1

