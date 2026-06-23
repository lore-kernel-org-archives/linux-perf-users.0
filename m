Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A0837F8CA;
	Tue, 23 Jun 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242081; cv=none; b=tASow8eEIXXlMK/pvMyvsNhhEfTY0p9UKCEMrk8U3VIg9RyDooOPPVqBUyXVwvt07QjTrjYkrQzSbosNTSx6Oz6uC1hvfCStyVlwVwTucUSEL4aMUKv+56NowU1dyE4PSooXTVFMQwhr625xuGIWiJiuGIELj8WyuY0baChEigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242081; c=relaxed/simple;
	bh=sX1MpHDQ5tHdM//qAAZG3yI3Cv8kS6KaPDMuf5Ci1FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcKwICoyECXE/NzOBlu1yT72UZnUTj64VEunhbLEyhHznij32j4chnEg3Es2MrxmITcTLQIlGlv0bpNM7zlAHdeSzT9Y9YpYyPUv+V204JyymOCJvn9K9UF7rzURcVt5UlFjM7uNCDun76OgYoMxjnQWETDJErD4mB4JJgxR9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTsDw5el; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTsDw5el"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033541F00A3F;
	Tue, 23 Jun 2026 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242080;
	bh=CTRUe4deXf4ov2Rj1bb5/o6ShWLTvklMTFE004HW2BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTsDw5elHsIk5nmvE9wMPkfn+mRf98V4mR2Dn28wDnVzz3qdkcfkoEl3wbnhvOPBo
	 CkCCSJJ3krtqzgKQZampNSs09QUmJS7uu285NP1cE6XRVTdRL+aJ4sGHkNWBjFErQb
	 aYhHWD0cxxs0BpRrzRL8PZho9H9jOMYIdzQE48GKtdLTvmnVeWucFbkfymTYIBECYJ
	 7JKplCsUL+aaajVCUVm9XuEsUYOJKZY5879KF/aHwXr2323KxKPfAevuAkIVXTPAid
	 7FLcMnv7Jx52CTcS8vbKpD2oey/0H0PAv7UlM07vFssBtS+H8gTqSw5QnczK25QyOc
	 +ZAae5qTD/kDQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/6] perf kvm: Factor out kvm_need_default_arch_event()
Date: Tue, 23 Jun 2026 12:14:34 -0700
Message-ID: <20260623191439.3621593-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260623191439.3621593-1-namhyung@kernel.org>
References: <20260623191439.3621593-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kvm_add_default_arch_event() has a similar logic in each arch to
check if there's an existing command line option for events.  Let's
check it in the generic code and remove the duplication.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c                      | 17 +++++---
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     | 31 +++-----------
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  | 34 +++------------
 tools/perf/util/kvm-stat.c                    | 41 +++++++++++++++++++
 tools/perf/util/kvm-stat.h                    |  8 ++++
 5 files changed, 70 insertions(+), 61 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 2c6aef1e13a04cf2..2f00cc1fd1c7cdbd 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -51,6 +51,7 @@
 #include <termios.h>
 #include <semaphore.h>
 #include <signal.h>
+#include <stdlib.h>
 #include <math.h>
 #include <perf/mmap.h>
 
@@ -2014,9 +2015,11 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 
 	BUG_ON(i + 2 != rec_argc);
 
-	ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
-	if (ret)
-		goto EXIT;
+	if (kvm_need_default_arch_event(EM_HOST, argc, argv)) {
+		ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
+		if (ret)
+			goto EXIT;
+	}
 
 	ret = cmd_record(i, rec_argv);
 
@@ -2101,9 +2104,11 @@ static int __cmd_top(int argc, const char **argv)
 
 	BUG_ON(i != argc);
 
-	ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
-	if (ret)
-		goto EXIT;
+	if (kvm_need_default_arch_event(EM_HOST, argc, argv)) {
+		ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
+		if (ret)
+			goto EXIT;
+	}
 
 	ret = cmd_top(i, rec_argv);
 
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
index 96d9c4ae020940f0..8d4133c35c12f14b 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
@@ -9,7 +9,6 @@
 
 #include "book3s_hv_exits.h"
 #include "book3s_hcalls.h"
-#include <subcmd/parse-options.h>
 
 #define NR_TPS 4
 
@@ -177,35 +176,15 @@ int __cpu_isa_init_powerpc(struct perf_kvm_stat *kvm)
  */
 int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv)
 {
-	const char **tmp;
-	bool event = false;
-	int i, j = *argc;
+	int j = *argc;
 
-	const struct option event_options[] = {
-		OPT_BOOLEAN('e', "event", &event, NULL),
-		OPT_END()
-	};
-
-	tmp = calloc(j + 1, sizeof(char *));
-	if (!tmp)
+	if (!perf_pmus__have_event("trace_imc", "trace_cycles"))
 		return -EINVAL;
 
-	for (i = 0; i < j; i++)
-		tmp[i] = argv[i];
-
-	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
-	if (!event) {
-		if (perf_pmus__have_event("trace_imc", "trace_cycles")) {
-			argv[j++] = strdup("-e");
-			argv[j++] = strdup("trace_imc/trace_cycles/");
-			*argc += 2;
-		} else {
-			free(tmp);
-			return -EINVAL;
-		}
-	}
+	argv[j++] = strdup("-e");
+	argv[j++] = strdup("trace_imc/trace_cycles/");
+	*argc += 2;
 
-	free(tmp);
 	return 0;
 }
 
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index 788d216f0852147d..46f9a0adcb608aab 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -7,7 +7,6 @@
 #include "../../../arch/x86/include/uapi/asm/svm.h"
 #include "../../../arch/x86/include/uapi/asm/vmx.h"
 #include "../../../arch/x86/include/uapi/asm/kvm.h"
-#include <subcmd/parse-options.h>
 
 define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
 define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
@@ -211,38 +210,15 @@ int __cpu_isa_init_x86(struct perf_kvm_stat *kvm, const char *cpuid)
  */
 int __kvm_add_default_arch_event_x86(int *argc, const char **argv)
 {
-	const char **tmp;
-	bool event = false;
-	int ret = 0, i, j = *argc;
-
-	const struct option event_options[] = {
-		OPT_BOOLEAN('e', "event", &event, NULL),
-		OPT_BOOLEAN(0, "pfm-events", &event, NULL),
-		OPT_END()
-	};
-
-	if (!x86__is_intel_cpu())
-		return 0;
-
-	tmp = calloc(j + 1, sizeof(char *));
-	if (!tmp)
-		return -ENOMEM;
-
-	for (i = 0; i < j; i++)
-		tmp[i] = argv[i];
-
-	parse_options(j, tmp, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
-	if (!event) {
-		argv[j++] = STRDUP_FAIL_EXIT("-e");
-		argv[j++] = STRDUP_FAIL_EXIT("cycles");
-		*argc += 2;
-	}
+	int ret = 0, j = *argc;
+
+	argv[j++] = STRDUP_FAIL_EXIT("-e");
+	argv[j++] = STRDUP_FAIL_EXIT("cycles");
+	*argc += 2;
 
-	free(tmp);
 	return 0;
 
 EXIT:
-	free(tmp);
 	return ret;
 }
 
diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
index 755ab659a05c30f0..c571d2ed711a8345 100644
--- a/tools/perf/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "debug.h"
+#include "env.h"
 #include "evsel.h"
 #include "kvm-stat.h"
 #include <dwarf-regs.h>
+#include <subcmd/parse-options.h>
 
 bool kvm_exit_event(struct evsel *evsel)
 {
@@ -268,3 +270,42 @@ int kvm_add_default_arch_event(uint16_t e_machine, int *argc, const char **argv)
 		return 0;
 	}
 }
+
+bool kvm_need_default_arch_event(uint16_t e_machine, int argc, const char **argv)
+{
+	const char **tmp_argv;
+	bool event = false;
+	int i;
+
+	const struct option event_options[] = {
+		OPT_BOOLEAN('e', "event", &event, NULL),
+		OPT_BOOLEAN(0, "pfm-events", &event, NULL),
+		OPT_END()
+	};
+
+	switch (e_machine) {
+	case EM_PPC:
+	case EM_PPC64:
+		break;
+	case EM_X86_64:
+	case EM_386:
+		if (!x86__is_intel_cpu())
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	/* parse_options() may change the argv, let's make a copy */
+	tmp_argv = calloc(argc + 1, sizeof(char *));
+	if (!tmp_argv)
+		return false;
+
+	for (i = 0; i < argc; i++)
+		tmp_argv[i] = argv[i];
+
+	parse_options(argc, tmp_argv, event_options, NULL, PARSE_OPT_KEEP_UNKNOWN);
+	free(tmp_argv);
+
+	return !event;
+}
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index cdbd921a555f4e51..04f9f3193555972f 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -174,12 +174,20 @@ const char * const *__kvm_skip_events_riscv(void);
 const char * const *__kvm_skip_events_s390(void);
 const char * const *__kvm_skip_events_x86(void);
 
+bool kvm_need_default_arch_event(uint16_t e_machine, int argc, const char **argv);
 int kvm_add_default_arch_event(uint16_t e_machine, int *argc, const char **argv);
 int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv);
 int __kvm_add_default_arch_event_x86(int *argc, const char **argv);
 
 #else /* !HAVE_LIBTRACEEVENT */
 
+static inline bool kvm_need_default_arch_event(uint16_t e_machine __maybe_unused,
+					       int argc __maybe_unused,
+					       const char **argv __maybe_unused)
+{
+	return false;
+}
+
 static inline int kvm_add_default_arch_event(uint16_t e_machine __maybe_unused,
 					     int *argc __maybe_unused,
 					     const char **argv __maybe_unused)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

