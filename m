Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBD4395AE8;
	Tue, 23 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198201; cv=none; b=oMuNIy1ZZKcH9yb2BAwApycX1gZhWeT9n9W0x3puDnUVBlQBjEIp7VkrC99eduhx9C2AFXiCjwE4Vq9WlIZCE832V3tnwuOGyJwerM36Ct1eXY90gBP68wubE6/8izA4et/pD2K2iP9Sk0ZuaXrzoe+9m5HGMBxR8F1dnG7QT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198201; c=relaxed/simple;
	bh=aGGN6gGbdt54kL3yasIE4QzclRvHDZ7GLjSfZHJd1X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nk0byQh/B81vulKPsbPvTQzjOMKxkYP0HovAOR6mi50daeVGd64knXPkWsqxN0xzkkjFJAzQWgWaA4GaBIkN7wjK0/qnH9ThH8qm6Ah1M86Qh3yHeeBZNGuRaWG9SRI34Y0J8KXuOP+eCRejBX/RHdMGFRlJ/KvdLM8PXQfOgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8pnZEJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8pnZEJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC171F00A3D;
	Tue, 23 Jun 2026 07:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198199;
	bh=jcqK+z0WU+M4/VnRRVhzCiLrfeMv3l9IRn/PKLAqAzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H8pnZEJAKwb/kw6yUu1iI866BbwcJM3sK0lv/kyz1gmSxT93dkrw40vuIXfftPQvp
	 WcenBY2nGhZ6rCfBm+xEtrKAGBZomt36jRMBZxSivPXdQ7qt4536VwVdGNhlpdjSa8
	 JVVK98kIQfDzjjOsemfKGmilRwCiNJocxkhP4b/v6BtI53m85/6fvqF58Pjlc0Yx0e
	 wUvvCytzBaUzgudCorVlE0jQj6dQo0DpUawEdRmIs1USurUnxJG2F3EAouMLAkLQLa
	 gaSqtSPQNcx1dMlDpE+FlKN5VSn0fpX7Ei924rWPwKn71x2jxUZK4HuKUo3M3V9r+c
	 lW3OFrdbWGifg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] perf kvm: Factor out kvm_need_default_arch_event()
Date: Tue, 23 Jun 2026 00:03:10 -0700
Message-ID: <20260623070313.55225-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623070313.55225-1-namhyung@kernel.org>
References: <20260623070313.55225-1-namhyung@kernel.org>
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
 tools/perf/builtin-kvm.c                      |  8 +++--
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     | 31 +++----------------
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  | 29 +++--------------
 tools/perf/util/kvm-stat.c                    | 27 ++++++++++++++++
 tools/perf/util/kvm-stat.h                    |  7 +++++
 5 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 394302ebdb161077..acb1d2f8148c7c9b 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2014,9 +2014,11 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 
 	BUG_ON(i + 2 != rec_argc);
 
-	ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
-	if (ret)
-		goto EXIT;
+	if (kvm_need_default_arch_event(argc, argv)) {
+		ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
+		if (ret)
+			goto EXIT;
+	}
 
 	ret = cmd_record(i, rec_argv);
 
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
index 788d216f0852147d..7bef7657a68a3e55 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -7,7 +7,6 @@
 #include "../../../arch/x86/include/uapi/asm/svm.h"
 #include "../../../arch/x86/include/uapi/asm/vmx.h"
 #include "../../../arch/x86/include/uapi/asm/kvm.h"
-#include <subcmd/parse-options.h>
 
 define_exit_reasons_table(vmx_exit_reasons, VMX_EXIT_REASONS);
 define_exit_reasons_table(svm_exit_reasons, SVM_EXIT_REASONS);
@@ -211,38 +210,18 @@ int __cpu_isa_init_x86(struct perf_kvm_stat *kvm, const char *cpuid)
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
+	int ret = 0, j = *argc;
 
 	if (!x86__is_intel_cpu())
 		return 0;
 
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
index 755ab659a05c30f0..5c2d1e57672ae5dd 100644
--- a/tools/perf/util/kvm-stat.c
+++ b/tools/perf/util/kvm-stat.c
@@ -3,6 +3,7 @@
 #include "evsel.h"
 #include "kvm-stat.h"
 #include <dwarf-regs.h>
+#include <subcmd/parse-options.h>
 
 bool kvm_exit_event(struct evsel *evsel)
 {
@@ -268,3 +269,29 @@ int kvm_add_default_arch_event(uint16_t e_machine, int *argc, const char **argv)
 		return 0;
 	}
 }
+
+bool kvm_need_default_arch_event(int argc, const char **argv)
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
index cdbd921a555f4e51..111b02fd0878efc2 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -174,12 +174,19 @@ const char * const *__kvm_skip_events_riscv(void);
 const char * const *__kvm_skip_events_s390(void);
 const char * const *__kvm_skip_events_x86(void);
 
+bool kvm_need_default_arch_event(int argc, const char **argv);
 int kvm_add_default_arch_event(uint16_t e_machine, int *argc, const char **argv);
 int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv);
 int __kvm_add_default_arch_event_x86(int *argc, const char **argv);
 
 #else /* !HAVE_LIBTRACEEVENT */
 
+static inline bool kvm_need_default_arch_event(int argc __maybe_unused,
+					       const char **argv __maybe_unused)
+{
+	return false;
+}
+
 static inline int kvm_add_default_arch_event(uint16_t e_machine __maybe_unused,
 					     int *argc __maybe_unused,
 					     const char **argv __maybe_unused)
-- 
2.54.0

