Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE61492E5D;
	Mon, 28 Sep 2026 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588877; cv=none; b=N1cxBQZbX7TKGZxr1QHzUeRgJzpVoJHaPtz7gLl1S49Qjd1OuH0R2nWO7WBA/2XsZ3x75NI3hhjME9+WY5CeFFNVPhu2hzEIfsGnAfH47mWzQo/kDNL5Qj+Aff0/dLME3pBXFor9Wd446KjlaXqyAfPsJD4PXvT8MpMkvSo9ulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588877; c=relaxed/simple;
	bh=q7PkhALNI3XxGdSZTeI4Un6SraKJr2UK6q9P9SokdS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPU2Ey+80974RtehYoIrmFXmGMVjzvkfSIxpzZ2NaCrnXpYrxm0N1XsPFozrdggsLBzIFOj537VM4AW5ebheDFZp+kqtwXQf+Y+YPh/GvShNdBzfHsahzNsaGDuTONyvW5exCCrvBCTvrAIf4Kvlj3X9F3jFcRY7XVfOsb5oXdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fy4k2j7G; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fy4k2j7G"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790588867; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YyH6phtw/20Drzo7M6upmH19BdCV6VhIq7/dFxDdeMk=;
	b=Fy4k2j7GMwphUzq6q9tynGC+s8f9H5ItEHk2CjTdg13bEjFjdIaZDBiQlzeexPslZi9vqhxk0WhC5dMnqv5XTFWThFh23LYdyrLZR0sT2z7JdE6axC1beoq8IyrM36eVpHWdXtabCT0BUfubAespsATQ7CxEE2edCIJNC+b7vuw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBlsENs_1790588865;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBlsENs_1790588865 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 17:47:46 +0800
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
Subject: [PATCH 2/2] perf tsc: Replace the compile-time TSC support check with a weak hook
Date: Mon, 28 Sep 2026 17:47:39 +0800
Message-ID: <20260928094739.2605-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928094739.2605-1-cp0613@linux.alibaba.com>
References: <20260928094739.2605-1-cp0613@linux.alibaba.com>
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
architecture, and it can drift apart from the set of architectures that
really provide a counter: util/tsc.c already ships a weak rdtsc() which
an architecture overrides with a strong definition when it has one.

Add a weak arch__rdtsc_supported() next to the weak rdtsc(), let the
test query it instead of the macros, and have x86, arm64 and riscv
override it in the file where they implement rdtsc().  Support is then
declared next to the counter it describes, and a caller can tell a stub
apart from a real counter without keeping its own copy of the macro
list.  This follows the pattern of the other optional per-architecture
hooks in util/ such as get_cpuid_str().

x86 and arm64 keep the same behaviour, and riscv starts running the
subtest because it gained rdtsc() in the previous patch.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/arch/arm64/util/tsc.c    |  5 +++++
 tools/perf/arch/riscv/util/tsc.c    |  5 +++++
 tools/perf/arch/x86/util/tsc.c      |  5 +++++
 tools/perf/tests/perf-time-to-tsc.c | 12 +-----------
 tools/perf/util/tsc.c               |  9 +++++++++
 tools/perf/util/tsc.h               |  1 +
 6 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/arm64/util/tsc.c b/tools/perf/arch/arm64/util/tsc.c
index cc85bd9e73f1..fd7fba50d0a6 100644
--- a/tools/perf/arch/arm64/util/tsc.c
+++ b/tools/perf/arch/arm64/util/tsc.c
@@ -19,3 +19,8 @@ u64 rdtsc(void)
 
 	return val;
 }
+
+bool arch__rdtsc_supported(void)
+{
+	return true;
+}
diff --git a/tools/perf/arch/riscv/util/tsc.c b/tools/perf/arch/riscv/util/tsc.c
index 7cc4710ac38c..312b0c755439 100644
--- a/tools/perf/arch/riscv/util/tsc.c
+++ b/tools/perf/arch/riscv/util/tsc.c
@@ -17,3 +17,8 @@ u64 rdtsc(void)
 
 	return val;
 }
+
+bool arch__rdtsc_supported(void)
+{
+	return true;
+}
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 3a439e4b12d2..6c01e96b5c2e 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -17,6 +17,11 @@ u64 rdtsc(void)
 	return low | ((u64)high) << 32;
 }
 
+bool arch__rdtsc_supported(void)
+{
+	return true;
+}
+
 /*
  * Derive the TSC frequency in Hz from the /proc/cpuinfo, for example:
  * ...
diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index f8f71fdd32b1..c91e22d93b53 100644
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
@@ -49,7 +39,7 @@
 static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
 				  int subtest __maybe_unused)
 {
-	if (!TSC_IS_SUPPORTED) {
+	if (!arch__rdtsc_supported()) {
 		pr_debug("Test not supported on this architecture\n");
 		return TEST_SKIP;
 	}
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index ebf289bf6b9d..815621b1d112 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -113,6 +113,15 @@ u64 __weak rdtsc(void)
 	return 0;
 }
 
+/*
+ * An architecture that implements rdtsc() with a real counter should override
+ * this, so that users of the counter can tell a stub apart from support.
+ */
+bool __weak arch__rdtsc_supported(void)
+{
+	return false;
+}
+
 size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
 {
 	struct perf_record_time_conv *tc = (struct perf_record_time_conv *)event;
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 57ce8449647f..83e76b207365 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -25,6 +25,7 @@ int perf_read_tsc_conversion(const struct perf_event_mmap_page *pc,
 u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
 u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
 u64 rdtsc(void);
+bool arch__rdtsc_supported(void);
 u64 arch_get_tsc_freq(void);
 
 size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
-- 
2.50.1

