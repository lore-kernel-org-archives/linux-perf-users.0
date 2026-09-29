Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B037B402;
	Tue, 29 Sep 2026 03:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653311; cv=none; b=BpyVs+kS7fsYi5kCR5zEp8BREcgo4QwzFak/AVM0OMWLcg4SpW4usb++jCdXA8CDLqn6DH7znMVHXuVmgax+/jOa/vgfgV3TfgL3ETJy3awBaxKhX8yMXME/tzFs12HdTFKTIhjDXqoRldnV/cHQ76+wueNeLQT0YnyWCErMFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653311; c=relaxed/simple;
	bh=Sv4kNgWFVauDHzIZndXBBIo0WOYGvyV2zfjl1tValFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1GGfIz8srIuXGP8N3HGZvCaX6gX7iSbdDkLoAzN1SatnSQl2l2/1ypO5bS7Y4XmT/NoxkRehQGDoJ4x6e3mYa4EJk3I+nX+YJFWEUlRIh7N7Dn9rxwqPREAZRvXdSKVAYpFX1wskatUioZnS2RdlzLeP3Sy/9ta124fa9yXRj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FucF6+HY; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FucF6+HY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790653302; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cxgSoOlX1qoO+V9gQu3kRbObk1n3POX5OUlcjG8xVss=;
	b=FucF6+HYzwBRvjkN5wHoRPp+2MZ4CEGRvWmSM4vQH81PTE8SL3LV9rvroWu1ZnHYwTHEFr3kVzObXS8WPMdSA7RcQHRzL+lUQaYbafYGvtr/I4lmnWH5CCcK+q8D2hvzlU+nTozbKqkziF+0iKjuP7iCrnEBJ8Di4flQPITgUKA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBrsVAL_1790653299;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBrsVAL_1790653299 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 11:41:40 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: acme@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	leo.yan@linux.dev,
	john.g.garry@oracle.com,
	will@kernel.org,
	mike.leach@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	guoren@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf tsc: Declare TSC support from the build system
Date: Tue, 29 Sep 2026 11:41:33 +0800
Message-ID: <20260929034133.2153-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929034133.2153-1-cp0613@linux.alibaba.com>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "TSC support" subtest of the "Convert perf time to TSC" test decides
whether the architecture is covered by matching compiler macros for
x86_64, i386 and arm64.  That list has to be edited for every new
architecture and can drift apart from the set of architectures that really
provide a counter.

Declare the capability where the implementation is, following the
PERF_HAVE_JITDUMP pattern: an architecture with a usable counter sets
PERF_HAVE_RDTSC in its arch Makefile, Makefile.config turns it into
-DHAVE_RDTSC, and the test keys off that.

x86 and arm64 keep the same behaviour, riscv starts running the subtest
where the previous patch defines rdtsc().

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
Changes in v2:
- Declare the capability through the build system instead of a weak
  arch__rdtsc_supported() hook.

 tools/perf/Makefile.config          |  4 ++++
 tools/perf/arch/arm64/Makefile      |  1 +
 tools/perf/arch/riscv/Makefile      |  1 +
 tools/perf/arch/x86/Makefile        |  1 +
 tools/perf/tests/perf-time-to-tsc.c | 19 ++++---------------
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4d5993da9f94..f1b3bf208231 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -618,6 +618,10 @@ ifdef PERF_HAVE_JITDUMP
   endif
 endif
 
+ifeq ($(PERF_HAVE_RDTSC),1)
+  CFLAGS += -DHAVE_RDTSC
+endif
+
 ifeq ($(SRCARCH),powerpc)
   ifndef NO_LIBDW
     CFLAGS += -DHAVE_SKIP_CALLCHAIN_IDX
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 44cc3f023318..b9cd559065d6 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
+PERF_HAVE_RDTSC := 1
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index 44cc3f023318..8036bf55da8e 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
+PERF_HAVE_RDTSC := $(IS_64_BIT)
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 44cc3f023318..b9cd559065d6 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
+PERF_HAVE_RDTSC := 1
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index f8f71fdd32b1..feb8063f8b59 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -22,16 +22,6 @@
 #include "tests.h"
 #include "util/sample.h"
 
-/*
- * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.  Just
- * enable the test for x86_64/i386 and Arm64 archs.
- */
-#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
-#define TSC_IS_SUPPORTED 1
-#else
-#define TSC_IS_SUPPORTED 0
-#endif
-
 #define CHECK__(x) {				\
 	while ((x) < 0) {			\
 		pr_debug(#x " failed!\n");	\
@@ -49,11 +39,10 @@
 static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
 				  int subtest __maybe_unused)
 {
-	if (!TSC_IS_SUPPORTED) {
-		pr_debug("Test not supported on this architecture\n");
-		return TEST_SKIP;
-	}
-
+#ifndef HAVE_RDTSC
+	pr_debug("Test not supported on this architecture\n");
+	return TEST_SKIP;
+#endif
 	return TEST_OK;
 }
 
-- 
2.50.1

