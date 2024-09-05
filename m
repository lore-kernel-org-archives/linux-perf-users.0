Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35411B2EE8;
	Thu,  5 Sep 2024 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567874; cv=none; b=NYn71DAm50BxMWSWW+SI/rEVahB2MjhwI8I/m0H1xfnKyTXbMAWiNvp+Nh2XMqv3zzjC4aw7SBxPACXsbWlIpy6lVAYfrvoTdOtyedfc33BRG99TAGUg3g+4367QFF8QsCxEVVwf7BsRIY+SF9VPVFYEQE4qd/BaODjXbx0Kkac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567874; c=relaxed/simple;
	bh=MUj8CTCtB4NLF/yrO1JxR1Didkl0TCC5awQMA0iC0QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU4yS01Me+XRdKnP13wDF7yaC7vBg6mG7/U7V0EEHAoP53kc6Kn2nurVIxLJGsAjojQMWU2cpB9bPFI62DGEuTFHY9gpnERrIoutzTc4UX0QfjZLWux6ehk5JBxKW6JXYMIFL3YzDKiP6lqL0SljF5AU05IjiYe1VrbVNcvTMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTlJ4epj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTlJ4epj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0316C4CECA;
	Thu,  5 Sep 2024 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567874;
	bh=MUj8CTCtB4NLF/yrO1JxR1Didkl0TCC5awQMA0iC0QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTlJ4epjDeOCuLaCiQHvKPNwHmzmEMXFhYXZyXFQwbVyK97lGJXA6FvB1WIWJ8+NF
	 hPDkuALifMeCfA5O8walBtDQo65JyREZX8XOrVpZiFkcPUQuaaNMhOym8LSbbccTej
	 HT4sech2LiYI/ILOTtSjGF0wC8X/7nU4D0u+lW2rqNHOMq9rYVl1IaMSyqUmHtOO7w
	 n005d1CdHNEm3M5lPv++QwGOtNCOCIDr5ytmWQ92J8YjYOJj8Vw2OTrEfAeYspk1mV
	 lxs5haWCwxgwWTy6m82u64bolSh4/Ug3YsIBLUIWt+2OtQkdzWRF/A5zejUDHWbBX6
	 7l+FjczqUBq8w==
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
Subject: [PATCH 08/10] perf tools: Move x86__is_amd_cpu() to util/env.c
Date: Thu,  5 Sep 2024 13:24:24 -0700
Message-ID: <20240905202426.2690105-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905202426.2690105-1-namhyung@kernel.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
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
index a459374d0a1a1dc8..6965f3d498e327cc 100644
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
@@ -624,3 +625,25 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 	free(cap_eq);
 	return NULL;
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
index 2a2c37cc40b7828e..573ad9823d16d5cf 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -192,4 +192,8 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 			     const char *cap);
 
 bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
+
+bool x86__is_amd_cpu(void);
+bool perf_env__is_x86_amd_cpu(struct perf_env *env);
+
 #endif /* __PERF_ENV_H */
-- 
2.46.0.469.g59c65b2a67-goog

