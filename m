Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC382A1D6;
	Tue,  1 Oct 2024 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742034; cv=none; b=AboorJAYq7L3Y/jqIeTXdOo5ENkblfIB/Iyamui45l8eqzCdTHunwc7JbhK9REeRgEG4FSfPXnOULU7qnQkpUjStjn5irdw9L9+4hn/hxpxLGpVkdOd++sAk53XKKiOaMAQ71wwFZM7bnuQOv7zOx6kzakRu3cy/oz3H0zovh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742034; c=relaxed/simple;
	bh=vJUrEzL1ey5YRE3Aw1gnAesBPqg7rTPF+ARvCNGukDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYF6PmSX3qaR3Go8wbnIV4MN6RPCWKKcdTKDb54RcPWuQnPROnuqaelTWkP35ReephPBMidLzzGmdfwxPT1+daMNpYkVwbpsO1+mkmKOr3Nxjie3WbsqPgmNqjJFo1Ndw6H1qvBrNSDaq2GHSbExJlAkICRyP3TI7dhN8az+Tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beYqo76C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beYqo76C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DBFC4CEC7;
	Tue,  1 Oct 2024 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727742033;
	bh=vJUrEzL1ey5YRE3Aw1gnAesBPqg7rTPF+ARvCNGukDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beYqo76CxCMJhGzTCyQUP3Q/HKA9X0W5DpJjjThmXYAsG/h56a4DF6I89+tINOREm
	 +Uece5kaVbTyQGuraAlOP/aR84xZEt/qeGGyWFYAlTuQjbr+Arvt3SiNhtT4Y1zgmO
	 MQuM+rhYRLFsD7pDNHi6lnShlTHt98/ephLi9h3fVWL05KmtBqEk/6lInfVkVgDH33
	 giiJblyM5dbeRb2HT/lu+3r9lWWjuSqgyyBZdKZvSbA0SSFo/e2IHtbV22mcUYtueT
	 +lc9etUnyAqLlioUwhZM5a6ml9t8+62VgoUhIzOtPVFp4STBs/990wSvOq1DFhsQR1
	 UoRI7UqfSod3w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 6/8] perf tools: Move x86__is_amd_cpu() to util/env.c
Date: Mon, 30 Sep 2024 17:20:25 -0700
Message-ID: <20241001002027.1272889-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
References: <20241001002027.1272889-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can be called from non-x86 platform so let's move it to the general
util directory.  Also add a new helper perf_env__is_x86_amd_cpu() so
that it can be called with an existing perf_env as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/Build |  1 -
 tools/perf/arch/x86/util/env.c | 19 -------------------
 tools/perf/arch/x86/util/env.h |  7 -------
 tools/perf/arch/x86/util/pmu.c |  2 +-
 tools/perf/util/env.c          | 24 ++++++++++++++++++++++++
 tools/perf/util/env.h          |  4 ++++
 6 files changed, 29 insertions(+), 28 deletions(-)
 delete mode 100644 tools/perf/arch/x86/util/env.c
 delete mode 100644 tools/perf/arch/x86/util/env.h

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 2607ed5c42966543..ce6d802a1381c5ab 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -10,7 +10,6 @@ perf-util-y += evlist.o
 perf-util-y += mem-events.o
 perf-util-y += evsel.o
 perf-util-y += iostat.o
-perf-util-y += env.o
 
 perf-util-$(CONFIG_DWARF) += dwarf-regs.o
 perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
deleted file mode 100644
index 3e537ffb1353aab2..0000000000000000
--- a/tools/perf/arch/x86/util/env.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "linux/string.h"
-#include "util/env.h"
-#include "env.h"
-
-bool x86__is_amd_cpu(void)
-{
-	struct perf_env env = { .total_mem = 0, };
-	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
-
-	if (is_amd)
-		goto ret;
-
-	perf_env__cpuid(&env);
-	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
-	perf_env__exit(&env);
-ret:
-	return is_amd >= 1 ? true : false;
-}
diff --git a/tools/perf/arch/x86/util/env.h b/tools/perf/arch/x86/util/env.h
deleted file mode 100644
index d78f080b6b3f889a..0000000000000000
--- a/tools/perf/arch/x86/util/env.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _X86_ENV_H
-#define _X86_ENV_H
-
-bool x86__is_amd_cpu(void);
-
-#endif /* _X86_ENV_H */
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index c3d89d6ba1bf03ad..e0060dac2a9f9242 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -16,7 +16,7 @@
 #include "../../../util/fncache.h"
 #include "../../../util/pmus.h"
 #include "mem-events.h"
-#include "env.h"
+#include "util/env.h"
 
 void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 {
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1edbccfc3281d2b1..470a0156e0722e4e 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -5,6 +5,7 @@
 #include "util/header.h"
 #include "linux/compiler.h"
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include "cgroup.h"
 #include <errno.h>
@@ -625,6 +626,7 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 	return NULL;
 }
 
+
 void perf_env__find_br_cntr_info(struct perf_env *env,
 				 unsigned int *nr,
 				 unsigned int *width)
@@ -639,3 +641,25 @@ void perf_env__find_br_cntr_info(struct perf_env *env,
 					     env->pmu_caps->br_cntr_width;
 	}
 }
+
+bool perf_env__is_x86_amd_cpu(struct perf_env *env)
+{
+	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
+
+	if (is_amd == 0)
+		is_amd = env->cpuid && strstarts(env->cpuid, "AuthenticAMD") ? 1 : -1;
+
+	return is_amd >= 1 ? true : false;
+}
+
+bool x86__is_amd_cpu(void)
+{
+	struct perf_env env = { .total_mem = 0, };
+	bool is_amd;
+
+	perf_env__cpuid(&env);
+	is_amd = perf_env__is_x86_amd_cpu(&env);
+	perf_env__exit(&env);
+
+	return is_amd;
+}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 51b36c36019be666..ae604c4edbb7eb44 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -195,4 +195,8 @@ bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
 void perf_env__find_br_cntr_info(struct perf_env *env,
 				 unsigned int *nr,
 				 unsigned int *width);
+
+bool x86__is_amd_cpu(void);
+bool perf_env__is_x86_amd_cpu(struct perf_env *env);
+
 #endif /* __PERF_ENV_H */
-- 
2.46.1.824.gd892dcdcdd-goog

