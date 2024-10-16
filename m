Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F481B2185;
	Wed, 16 Oct 2024 06:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059846; cv=none; b=Iotk+i61nKlSp/FApvYUGmySFqj0VUwtwsa+avnQmBMs3ZRjknsBCo68uQtaF67Fu8o13mATwLddQT22l0pwnml2aMuFTcS+las+s09DP2K+J0DLHg9wcHhQFeOPiRwFwQBOgYtjGIltows2t7Uiv53GpVO8pJM5eVga+7j9GEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059846; c=relaxed/simple;
	bh=4u2/7ezE+cWeue94azvuOtqAysSTt8l2h1qfZ+QYrIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXOmlyFlRs6ybVJkEUCnjRu3+tFDLHfehIRVh7xfu99241I5P2y6B5VA8eiZKsbgt3AG8ir9liRWu4lth5y8lBXV4sS6XX1LrqOiKWU4GV5kuoevT+S/PlNG4lNQ2WfmgH5RQ864LbBgmvrak8Z8iST9Ej5GUMFXcFcGvMpIuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhIMjroL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhIMjroL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2612C4CED5;
	Wed, 16 Oct 2024 06:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059845;
	bh=4u2/7ezE+cWeue94azvuOtqAysSTt8l2h1qfZ+QYrIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhIMjroLvSPwuDMpwrlguEJ9DcyquTNOp4sCqoLmfnh98y7GD6RqOVdg2U1iucbMl
	 PqvMbGP9lMvOGOFSOFbHo5gtwtGkwF/ZeX5n7v1RjPAm9+IPFmtINp7Th9ab1sjwOl
	 xez+Ve9+FVOHyOC4bb848Kc4hn8bxuJbpqS3/XD6YTmhg688QuDUCa8sYYdRu63r5i
	 EhYOtLVwcK2yoJGjpVoFBFOno5OAgh4/CiSxkDoWy1MRCfyXzfGRKQ5BgLl/bu17cP
	 HN639cH8V1m8MLraPsnrZs1S3uUbDH1fHDfTSCIMygFGvyDwtqakSSSo9dTuIKzO0f
	 oIbpeNvFvzU9w==
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
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v5 6/9] perf tools: Move x86__is_amd_cpu() to util/env.c
Date: Tue, 15 Oct 2024 23:23:56 -0700
Message-ID: <20241016062359.264929-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241016062359.264929-1-namhyung@kernel.org>
References: <20241016062359.264929-1-namhyung@kernel.org>
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

Acked-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/Build |  1 -
 tools/perf/arch/x86/util/env.c | 19 -------------------
 tools/perf/arch/x86/util/env.h |  7 -------
 tools/perf/arch/x86/util/pmu.c |  2 +-
 tools/perf/util/env.c          | 23 +++++++++++++++++++++++
 tools/perf/util/env.h          |  4 ++++
 6 files changed, 28 insertions(+), 28 deletions(-)
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
index 1edbccfc3281d2b1..ccb4640266428947 100644
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
@@ -639,3 +640,25 @@ void perf_env__find_br_cntr_info(struct perf_env *env,
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
2.47.0.rc1.288.g06298d1525-goog

