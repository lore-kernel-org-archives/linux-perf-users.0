Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226B33987F
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176383; cv=none; b=NPgG+Jpz0qUanND3hQ0WwkcBf/9sr3xV622CoEtQnAKt2iAUnSN+/yoqxf3JanzHWyvXSGjvqaTPm6o/v0rnLNQlZBXpiKXiKQYwNg9r1NVLWDBw0FXnoQrfpMIMDWT6jtgK8SHEkpHoOZcc5VmPhDGHYatHvohI0Ra41E01JYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176383; c=relaxed/simple;
	bh=hIxpFNEn4i6RNo/DdPCuatGhf+1ZDRCFurvkNsfgJIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CcH5FrOjjM2dGcyN4bKHvIC5IPNcIuVR0tsVqdmcCpZTlya36PehQOqaakAV9izDJRffiqqnRgIsfc3wmDRM2Nj7sMiNrl60Cs4kyc2JXMkgmuXao5v8kfhZm5L2zG7n4sW5x3Y9dE0NINcTrARilxlEcjMIV6mcjX8hs/JrFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHfS+Ae6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHfS+Ae6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso9650628a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176379; x=1784781179; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myD8RB3VQcJoHmDZRgr6MvaG8bYHft9D919t62PHA48=;
        b=tHfS+Ae6GLWsKYqfWPHBp5YECJFQ6lEPSw09gK1GhH6q3FdJhIPlBYIdL8CcQhswJJ
         aK0yDoH2jOAnoT+SIv4kE9t+YFe5DtoxdBinCNgrQkoQ/hj2bi1TZXYjjTw28OsW7Lbw
         xl9JzPiurHOA14aDDDzF+/7xjVjrBDq+gkPpvWNlioT2rZKwHhZf7d9x2z+k63/8VjZ0
         DTRl25YwGVKR9B+ohHpf+DyBIBLNIQz7rg2EJ0I9EEgD1f4eAcAl2Vmhm0uc6PtrNklu
         NCJxW6cpdkYb+LQX2pTEF7yQURLKpy6MGIexo4JKjE9qyaK7lXsT/lcxByU1vzAYnL82
         HIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176379; x=1784781179;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=myD8RB3VQcJoHmDZRgr6MvaG8bYHft9D919t62PHA48=;
        b=jad0Ewc+q4mdE98ohR+xtLdzzEZf9OHrEvuj0heH/Ax8qZX7KFsZiZytp9jqoOCcgl
         fujmJKA8RNSTnEK9RoHx9EWSzxeZhaItV0hZwTwFESsrK5jY4pXJZn5gIP5xls0gC/om
         aTGpWN8cuewv1vMm8XoHMutAAkI+yqOP+qQI3olTr1OTfZRvcg5KbJLR37teIruOftNf
         Vi0HaPHp8uYuUqEX8tp9FRuDPhsrzPm59SgEVJsS1FauA0+vZI+dj0QzrVecMoRqPgkb
         yxOojaaDxyHT/qDgqyMWibkT8aqT1u5FzJp9eonLrj/ggaoed5jfouyXB7ZQOSQ+uFz1
         npTg==
X-Forwarded-Encrypted: i=1; AHgh+RrtZwwq/W1fUujOUalfNhnwmAUuXlwV4CMs2HDes16CxEq2rzEaXFkuj9QHJUkUXczq/Ii9JLzMypnaeAwySLIp@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOdMn9TNqW0dchIprTWMdl7/hEceMdd92FkcIi06FO9WGT84x
	Rd1loaQvzEKydvf2Ck6dA+DgLFxWI1793G7nXlVGMwO1iNCzbVmp9xFGa3HmxkS2t/RRTOaHEX5
	7SKXA+VqgAw==
X-Received: from dycue6.prod.google.com ([2002:a05:7300:86:b0:311:54ad:bcad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6456:b0:3c3:719d:dfe4
 with SMTP id adf61e73a8af0-3c3719de4b4mr4647859637.35.1784176378531; Wed, 15
 Jul 2026 21:32:58 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:10 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-2-irogers@google.com>
Subject: [PATCH v3 01/14] perf stat: Introduce core generic print traversal
 engine and header stubs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch introduces the initial infrastructure for decoupling the perf
stat printing API. It declares the struct perf_stat_print_callbacks
interface and the core traversal driver perf_stat__print_cb() inside the
newly created util/stat-print.h and util/stat-print.c files.

The generic traversal driver perf_stat__print_cb() drive traversing the
event lists across all supported cpu aggregation modes (global, die,
socket, cache, cluster, core, thread, none). It implements the clean
display filtering checks (perf_stat__skip_metric_event(), hybrid
wildcard merges) and the basic metrics allowlist filter
(is_basic_shadow_metric()) to keep formatting callbacks decoupled.

This also introduces two format-agnostic shared helpers to centralize
aggregation prefix formatting:
- perf_stat__get_aggr_key(): resolves JSON key names.
- perf_stat__get_aggr_id_char(): formats unified aggregation identifiers.

Adds empty format-specific stubs (perf_stat__print_std, _csv, _json) to
ensure that the new print files link and compile cleanly under
util/Build, without affecting the legacy print path.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/builtin-stat.c         |  96 +++---
 tools/perf/util/Build             |   4 +
 tools/perf/util/stat-display.c    |   6 +-
 tools/perf/util/stat-print-csv.c  |  13 +
 tools/perf/util/stat-print-json.c |  13 +
 tools/perf/util/stat-print-std.c  |  13 +
 tools/perf/util/stat-print.c      | 489 ++++++++++++++++++++++++++++++
 tools/perf/util/stat-print.h      | 133 ++++++++
 tools/perf/util/stat.h            |   2 +
 9 files changed, 722 insertions(+), 47 deletions(-)
 create mode 100644 tools/perf/util/stat-print-csv.c
 create mode 100644 tools/perf/util/stat-print-json.c
 create mode 100644 tools/perf/util/stat-print-std.c
 create mode 100644 tools/perf/util/stat-print.c
 create mode 100644 tools/perf/util/stat-print.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3f685beba384..532856f8be90 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -40,62 +40,64 @@
  *   Jaswinder Singh Rajput <jaswinder@kernel.org>
  */
 
+#include <errno.h>
+#include <inttypes.h>
+#include <locale.h>
+#include <math.h>
+#include <signal.h>
+#include <stdlib.h>
+
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/list_sort.h>
+#include <linux/time64.h>
+#include <linux/zalloc.h>
+#include <sys/prctl.h>
+#include <sys/resource.h>
+#include <sys/stat.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <api/fs/fs.h>
+#include <internal/threadmap.h>
+#include <perf/evlist.h>
+#include <subcmd/parse-options.h>
+
+#include "asm/bug.h"
 #include "builtin.h"
+#include "util/affinity.h"
+#include "util/bpf_counter.h"
 #include "util/cgroup.h"
-#include <subcmd/parse-options.h>
-#include "util/parse-events.h"
-#include "util/pmus.h"
-#include "util/pmu.h"
-#include "util/tool_pmu.h"
+#include "util/color.h"
+#include "util/counts.h"
+#include "util/cpumap.h"
+#include "util/debug.h"
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
-#include "util/debug.h"
-#include "util/color.h"
-#include "util/stat.h"
 #include "util/header.h"
-#include "util/cpumap.h"
-#include "util/thread_map.h"
-#include "util/counts.h"
-#include "util/topdown.h"
+#include "util/intel-tpebs.h"
+#include "util/iostat.h"
+#include "util/metricgroup.h"
+#include "util/parse-events.h"
+#include "util/pfm.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include "util/session.h"
-#include "util/tool.h"
+#include "util/stat-print.h"
+#include "util/stat.h"
 #include "util/string2.h"
-#include "util/metricgroup.h"
 #include "util/synthetic-events.h"
 #include "util/target.h"
+#include "util/thread_map.h"
 #include "util/time-utils.h"
+#include "util/tool.h"
+#include "util/tool_pmu.h"
 #include "util/top.h"
-#include "util/affinity.h"
-#include "util/pfm.h"
-#include "util/bpf_counter.h"
-#include "util/iostat.h"
+#include "util/topdown.h"
 #include "util/util.h"
-#include "util/intel-tpebs.h"
-#include "asm/bug.h"
-
-#include <linux/list_sort.h>
-#include <linux/time64.h>
-#include <linux/zalloc.h>
-#include <api/fs/fs.h>
-#include <errno.h>
-#include <signal.h>
-#include <stdlib.h>
-#include <sys/prctl.h>
-#include <inttypes.h>
-#include <locale.h>
-#include <math.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <linux/err.h>
-
-#include <linux/ctype.h>
-#include <perf/evlist.h>
-#include <internal/threadmap.h>
 
 #ifdef HAVE_BPF_SKEL
 #include "util/bpf_skel/bperf_cgroup.h"
@@ -123,6 +125,7 @@ static struct target target;
 static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
+static bool use_perf_stat_print;
 static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
@@ -1094,7 +1097,10 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	if (quiet)
 		return;
 
-	evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
+	if (use_perf_stat_print)
+		perf_stat__print(evsel_list, &stat_config, &target, ts, argc, argv);
+	else
+		evlist__print_counters(evsel_list, &stat_config, &target, ts, argc, argv);
 }
 
 static volatile sig_atomic_t signr = -1;
@@ -2593,6 +2599,8 @@ int cmd_stat(int argc, const char **argv)
 			"Use with 'percore' event qualifier to show the event "
 			"counts of one hardware thread by sum up total hardware "
 			"threads of same physical core"),
+		OPT_BOOLEAN(0, "new", &use_perf_stat_print,
+			"use new clean API code for display output"),
 		OPT_BOOLEAN(0, "summary", &stat_config.summary,
 			"print summary for interval mode"),
 		OPT_BOOLEAN(0, "no-csv-summary", &stat_config.no_csv_summary,
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 330311cac550..0cf5bf625664 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -113,6 +113,10 @@ perf-util-y += counts.o
 perf-util-y += stat.o
 perf-util-y += stat-shadow.o
 perf-util-y += stat-display.o
+perf-util-y += stat-print.o
+perf-util-y += stat-print-std.o
+perf-util-y += stat-print-csv.o
+perf-util-y += stat-print-json.o
 perf-util-y += perf_api_probe.o
 perf-util-y += record.o
 perf-util-y += srcline.o
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f94f1324d24a..d71d413e7f31 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -37,7 +37,7 @@
 #define PID_LEN       7
 #define CPUS_LEN      4
 
-static int aggr_header_lens[] = {
+const int aggr_header_lens[] = {
 	[AGGR_CORE] 	= 18,
 	[AGGR_CACHE]	= 22,
 	[AGGR_CLUSTER]	= 20,
@@ -49,7 +49,7 @@ static int aggr_header_lens[] = {
 	[AGGR_GLOBAL] 	= 0,
 };
 
-static const char *aggr_header_csv[] = {
+const char *aggr_header_csv[] = {
 	[AGGR_CORE]	=	"core,ctrs,",
 	[AGGR_CACHE]	=	"cache,ctrs,",
 	[AGGR_CLUSTER]	=	"cluster,ctrs,",
@@ -61,7 +61,7 @@ static const char *aggr_header_csv[] = {
 	[AGGR_GLOBAL]	=	""
 };
 
-static const char *aggr_header_std[] = {
+const char *aggr_header_std[] = {
 	[AGGR_CORE] 	= 	"core",
 	[AGGR_CACHE] 	= 	"cache",
 	[AGGR_CLUSTER]	= 	"cluster",
diff --git a/tools/perf/util/stat-print-csv.c b/tools/perf/util/stat-print-csv.c
new file mode 100644
index 000000000000..ee86d07636ea
--- /dev/null
+++ b/tools/perf/util/stat-print-csv.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "stat-print.h"
+#include <linux/compiler.h>
+
+int perf_stat__print_csv(struct evlist *evlist __maybe_unused,
+			 const struct perf_stat_config *config __maybe_unused,
+			 const struct target *target __maybe_unused,
+			 const struct timespec *ts __maybe_unused,
+			 int argc __maybe_unused,
+			 const char **argv __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/stat-print-json.c b/tools/perf/util/stat-print-json.c
new file mode 100644
index 000000000000..4690c4286fd2
--- /dev/null
+++ b/tools/perf/util/stat-print-json.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "stat-print.h"
+#include <linux/compiler.h>
+
+int perf_stat__print_json(struct evlist *evlist __maybe_unused,
+			  const struct perf_stat_config *config __maybe_unused,
+			  const struct target *target __maybe_unused,
+			  const struct timespec *ts __maybe_unused,
+			  int argc __maybe_unused,
+			  const char **argv __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-print-std.c
new file mode 100644
index 000000000000..a1311f950559
--- /dev/null
+++ b/tools/perf/util/stat-print-std.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "stat-print.h"
+#include <linux/compiler.h>
+
+int perf_stat__print_std(struct evlist *evlist __maybe_unused,
+			 const struct perf_stat_config *config __maybe_unused,
+			 const struct target *target __maybe_unused,
+			 const struct timespec *ts __maybe_unused,
+			 int argc __maybe_unused,
+			 const char **argv __maybe_unused)
+{
+	return 0;
+}
diff --git a/tools/perf/util/stat-print.c b/tools/perf/util/stat-print.c
new file mode 100644
index 000000000000..0fff50dce80b
--- /dev/null
+++ b/tools/perf/util/stat-print.c
@@ -0,0 +1,489 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "stat-print.h"
+
+#include <errno.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <linux/compiler.h>
+
+#include "cpumap.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "expr.h"
+#include "metricgroup.h"
+#include "stat.h"
+#include "thread_map.h"
+#include "tool_pmu.h"
+
+/*
+ * Unified Aggregation Helpers (Shared by STD, CSV, JSON Formats)
+ */
+
+const char *perf_stat__get_aggr_key(const struct perf_stat_config *config,
+				    const struct evsel *evsel)
+{
+	switch (config->aggr_mode) {
+	case AGGR_CORE:
+		return "core";
+	case AGGR_CACHE:
+		return "cache";
+	case AGGR_CLUSTER:
+		return "cluster";
+	case AGGR_DIE:
+		return "die";
+	case AGGR_SOCKET:
+		return "socket";
+	case AGGR_NODE:
+		return "node";
+	case AGGR_NONE:
+		if (evsel->percore && !config->percore_show_thread)
+			return "core";
+		return "cpu";
+	case AGGR_THREAD:
+		return "thread";
+	case AGGR_GLOBAL:
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		return "";
+	}
+}
+
+int perf_stat__get_aggr_id_char(const struct perf_stat_config *config, struct evsel *evsel,
+				struct aggr_cpu_id id, char *buf, size_t buf_size)
+{
+	switch (config->aggr_mode) {
+	case AGGR_CORE:
+		return scnprintf(buf, buf_size, "S%d-D%d-C%d", id.socket, id.die, id.core);
+	case AGGR_CACHE:
+		return scnprintf(buf, buf_size, "S%d-D%d-L%d-ID%d", id.socket, id.die, id.cache_lvl,
+				 id.cache);
+	case AGGR_CLUSTER:
+		return scnprintf(buf, buf_size, "S%d-D%d-CLS%d", id.socket, id.die, id.cluster);
+	case AGGR_DIE:
+		return scnprintf(buf, buf_size, "S%d-D%d", id.socket, id.die);
+	case AGGR_SOCKET:
+		return scnprintf(buf, buf_size, "S%d", id.socket);
+	case AGGR_NODE:
+		return scnprintf(buf, buf_size, "N%d", id.node);
+	case AGGR_NONE:
+		if (evsel->percore && !config->percore_show_thread)
+			return scnprintf(buf, buf_size, "S%d-D%d-C%d", id.socket, id.die, id.core);
+		else if (id.cpu.cpu > -1)
+			return scnprintf(buf, buf_size, "%d", id.cpu.cpu);
+		break;
+	case AGGR_THREAD:
+		return scnprintf(buf, buf_size, "%s-%d",
+				 perf_thread_map__comm(evsel->core.threads, id.thread_idx),
+				 perf_thread_map__pid(evsel->core.threads, id.thread_idx));
+	case AGGR_GLOBAL:
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		break;
+	}
+	buf[0] = '\0';
+	return -1;
+}
+
+/*
+ * Traversal Driver and Calculation Code
+ */
+
+/**
+ * tool_pmu__is_time_event - Check if event is a tool PMU time event.
+ *
+ * Copied from stat-shadow.c to make stat-print.c self-contained.
+ */
+static bool tool_pmu__is_time_event(const struct perf_stat_config *config,
+				    const struct evsel *evsel, int *tool_aggr_idx)
+{
+	enum tool_pmu_event event = evsel__tool_event(evsel);
+	int aggr_idx;
+
+	if (event != TOOL_PMU__EVENT_DURATION_TIME && event != TOOL_PMU__EVENT_USER_TIME &&
+	    event != TOOL_PMU__EVENT_SYSTEM_TIME)
+		return false;
+
+	if (config) {
+		cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+			if (config->aggr_map->map[aggr_idx].cpu.cpu == 0) {
+				*tool_aggr_idx = aggr_idx;
+				return true;
+			}
+		}
+		pr_debug("Unexpected CPU0 missing in aggregation for tool event.\n");
+	}
+	*tool_aggr_idx = 0; /* Assume the first aggregation index works. */
+	return true;
+}
+
+/**
+ * prepare_metric - Collect event values required for a metric.
+ * @config: Perf stat configuration.
+ * @mexp: The metric expression.
+ * @evsel: The associated event selector.
+ * @pctx: Expr parse context to add ID/values to.
+ * @aggr_idx: Aggregation index to read values from.
+ *
+ * Iterates over the events required for the metric expression, reads their
+ * counts for the given aggregation index, and adds them to the expression
+ * parser context.
+ *
+ * Copied and refactored from stat-shadow.c.
+ */
+static int prepare_metric(const struct perf_stat_config *config, const struct metric_expr *mexp,
+			  struct evsel *evsel, struct expr_parse_ctx *pctx, int aggr_idx)
+{
+	struct evsel *const *metric_events = mexp->metric_events;
+	struct metric_ref *metric_refs = mexp->metric_refs;
+	int i;
+
+	for (i = 0; metric_events[i]; i++) {
+		int source_count = 0, tool_aggr_idx;
+		bool is_tool_time =
+			tool_pmu__is_time_event(config, metric_events[i], &tool_aggr_idx);
+		struct perf_stat_evsel *ps = metric_events[i]->stats;
+		char *n;
+		double val;
+
+		/*
+		 * If there are multiple uncore PMUs and we're not reading the
+		 * leader's stats, determine the stats for the appropriate
+		 * uncore PMU.
+		 */
+		if (evsel && evsel->metric_leader && evsel->pmu != evsel->metric_leader->pmu &&
+		    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
+			struct evsel *pos;
+
+			evlist__for_each_entry(evsel->evlist, pos) {
+				if (pos->pmu != evsel->pmu)
+					continue;
+				if (pos->metric_leader != mexp->metric_events[i])
+					continue;
+				ps = pos->stats;
+				source_count = 1;
+				break;
+			}
+		}
+		/* Time events are always on CPU0, the first aggregation index. */
+		if (!ps || !metric_events[i]->supported) {
+			val = NAN;
+			source_count = 0;
+		} else {
+			struct perf_stat_aggr *aggr =
+				&ps->aggr[is_tool_time ? tool_aggr_idx : aggr_idx];
+
+			if (aggr->counts.run == 0) {
+				val = NAN;
+				source_count = 0;
+			} else {
+				val = aggr->counts.val;
+				if (is_tool_time) {
+					/* Convert time event nanoseconds to seconds. */
+					val *= 1e-9;
+				}
+				if (!source_count)
+					source_count = evsel__source_count(metric_events[i]);
+			}
+		}
+		n = strdup(evsel__metric_id(metric_events[i]));
+		if (!n)
+			return -ENOMEM;
+
+		expr__add_id_val_source_count(pctx, n, val, source_count);
+	}
+
+	for (int j = 0; metric_refs && metric_refs[j].metric_name; j++) {
+		int ret = expr__add_ref(pctx, &metric_refs[j]);
+
+		if (ret)
+			return ret;
+	}
+
+	return i;
+}
+
+/**
+ * calculate_and_print_metric - Compute and print a single metric.
+ *
+ * Parses the metric expression, computes the ratio, and calls the print_metric
+ * callback directly with clean parameters.
+ * Returns the return value of the print_metric callback (0 on success, or error).
+ */
+static int calculate_and_print_metric(const struct perf_stat_config *config,
+				      const struct perf_stat_print_callbacks *cb, void *outer_ctx,
+				      struct metric_expr *mexp, struct evsel *evsel, int aggr_idx)
+{
+	const char *metric_name = mexp->metric_name;
+	const char *metric_expr = mexp->metric_expr;
+	const char *metric_threshold = mexp->metric_threshold;
+	const char *metric_unit = mexp->metric_unit;
+	struct evsel *const *metric_events = mexp->metric_events;
+	int runtime = mexp->runtime;
+	struct expr_parse_ctx *pctx;
+	double ratio, scale, threshold;
+	int i;
+	enum metric_threshold_classify thresh = METRIC_THRESHOLD_UNKNOWN;
+	int ret = 0;
+
+	if (!cb->print_metric)
+		return 0;
+
+	pctx = expr__ctx_new();
+	if (!pctx)
+		return -ENOMEM;
+
+	if (config->user_requested_cpu_list)
+		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
+	pctx->sctx.runtime = runtime;
+	pctx->sctx.system_wide = config->system_wide;
+	i = prepare_metric(config, mexp, evsel, pctx, aggr_idx);
+	if (i < 0) {
+		expr__ctx_free(pctx);
+		return i;
+	}
+	if (!metric_events[i]) {
+		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
+			char *unit;
+
+			if (metric_threshold &&
+			    expr__parse(&threshold, pctx, metric_threshold) == 0 &&
+			    !isnan(threshold)) {
+				thresh = fpclassify(threshold) == FP_ZERO ? METRIC_THRESHOLD_GOOD :
+									    METRIC_THRESHOLD_BAD;
+			}
+
+			if (metric_unit && metric_name) {
+				if (perf_pmu__convert_scale(metric_unit, &unit, &scale) >= 0)
+					ratio *= scale;
+
+				ret = cb->print_metric(outer_ctx, config, evsel, aggr_idx,
+						       metric_name, unit, ratio, thresh);
+			} else {
+				ret = cb->print_metric(outer_ctx, config, evsel, aggr_idx,
+						       metric_name ?: (evsel->name ?: ""), NULL,
+						       ratio, thresh);
+			}
+		}
+	}
+
+	expr__ctx_free(pctx);
+	return ret;
+}
+
+/**
+ * perf_stat_print_metricgroup - Traverse metrics for an event.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+static bool is_basic_shadow_metric(const char *name)
+{
+	static const char *const basic_metrics[] = {
+		"insn_per_cycle",   "branch_miss_rate",	      "branch_frequency",
+		"cycles_frequency", "page_faults_per_second", "migrations_per_second",
+		"cs_per_second",    "CPUs_utilized",
+	};
+	for (size_t i = 0; i < ARRAY_SIZE(basic_metrics); i++) {
+		if (!strcmp(basic_metrics[i], name))
+			return true;
+	}
+	return false;
+}
+
+static int perf_stat_print_metricgroup(const struct perf_stat_config *config,
+				       const struct perf_stat_print_callbacks *cb, void *outer_ctx,
+				       struct evsel *evsel, int aggr_idx)
+{
+	struct metric_event *me;
+	struct metric_expr *mexp;
+	struct rblist *metric_events = &evsel->evlist->metric_events;
+	int ret;
+
+	me = metricgroup__lookup(metric_events, evsel, false);
+	if (me == NULL)
+		return 0;
+
+	list_for_each_entry(mexp, &me->head, nd) {
+		if (!config->metric_only &&
+		    (!evsel->default_metricgroup || evsel->default_show_events)) {
+			if (!is_basic_shadow_metric(mexp->metric_name))
+				continue;
+		}
+
+		ret = calculate_and_print_metric(config, cb, outer_ctx, mexp, evsel, aggr_idx);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/**
+ * perf_stat_print_metrics - Entry point for metric calculation & printing.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+static int perf_stat_print_metrics(const struct perf_stat_config *config,
+				   const struct perf_stat_print_callbacks *cb, void *outer_ctx,
+				   struct evsel *evsel, int aggr_idx)
+{
+	if (config->iostat_run) {
+		/* IOSTAT metrics not supported yet in new API */
+		return 0;
+	}
+
+	return perf_stat_print_metricgroup(config, cb, outer_ctx, evsel, aggr_idx);
+}
+
+int perf_stat__print_cb(struct evlist *evlist, const struct perf_stat_config *config,
+			const struct target *target __maybe_unused,
+			const struct timespec *ts __maybe_unused, int argc __maybe_unused,
+			const char **argv __maybe_unused,
+			const struct perf_stat_print_callbacks *cb, void *ctx)
+{
+	struct evsel *counter;
+	int aggr_idx;
+	int ret = 0;
+
+	evlist__uniquify_evsel_names(evlist, config);
+
+	if (cb->print_start) {
+		ret = cb->print_start(ctx, config);
+		if (ret)
+			return ret;
+	}
+
+	switch (config->aggr_mode) {
+	case AGGR_GLOBAL:
+	case AGGR_NONE:
+	case AGGR_SOCKET:
+	case AGGR_DIE:
+	case AGGR_CLUSTER:
+	case AGGR_CACHE:
+	case AGGR_CORE:
+	case AGGR_THREAD:
+	case AGGR_NODE:
+		if (config->aggr_map) {
+			cpu_aggr_map__for_each_idx(aggr_idx, config->aggr_map) {
+				evlist__for_each_entry(evlist, counter) {
+					struct perf_stat_evsel *ps = counter->stats;
+					u64 val = 0, ena = 0, run = 0;
+
+					if (ps && ps->aggr) {
+						val = ps->aggr[aggr_idx].counts.val;
+						ena = ps->aggr[aggr_idx].counts.ena;
+						run = ps->aggr[aggr_idx].counts.run;
+					}
+
+					/* Skip already merged uncore/hybrid events */
+					if (config->aggr_mode != AGGR_NONE) {
+						bool skip_hw = evsel__is_hybrid(counter) ?
+							(config->hybrid_merge &&
+							 counter->first_wildcard_match != NULL) :
+							(counter->first_wildcard_match != NULL);
+
+						if (skip_hw)
+							continue;
+					}
+
+					if (perf_stat__skip_metric_event(counter))
+						continue;
+
+					if (cb->print_event) {
+						double stdev_pct = 0.0;
+
+						if (ps && ps->res_stats.n > 1) {
+							stdev_pct = rel_stddev_stats(
+								stddev_stats(&ps->res_stats), val);
+						}
+						ret = cb->print_event(ctx, config, counter,
+								      aggr_idx, val, ena, run,
+								      stdev_pct);
+						if (ret)
+							goto out;
+					}
+
+					ret = perf_stat_print_metrics(config, cb, ctx, counter,
+								      aggr_idx);
+					if (ret)
+						goto out;
+				}
+			}
+		} else {
+			evlist__for_each_entry(evlist, counter) {
+				struct perf_stat_evsel *ps = counter->stats;
+				u64 val = 0, ena = 0, run = 0;
+
+				if (ps && ps->aggr) {
+					val = ps->aggr[0].counts.val;
+					ena = ps->aggr[0].counts.ena;
+					run = ps->aggr[0].counts.run;
+				}
+
+				/* Skip already merged uncore/hybrid events */
+				if (config->aggr_mode != AGGR_NONE) {
+					bool skip_hw = evsel__is_hybrid(counter) ?
+						(config->hybrid_merge &&
+						 counter->first_wildcard_match != NULL) :
+						(counter->first_wildcard_match != NULL);
+
+					if (skip_hw)
+						continue;
+				}
+
+				if (perf_stat__skip_metric_event(counter))
+					continue;
+
+				if (cb->print_event) {
+					double stdev_pct = 0.0;
+
+					if (ps && ps->res_stats.n > 1) {
+						stdev_pct = rel_stddev_stats(
+							stddev_stats(&ps->res_stats), val);
+					}
+					ret = cb->print_event(ctx, config, counter, 0, val, ena,
+							      run, stdev_pct);
+					if (ret)
+						goto out;
+				}
+
+				ret = perf_stat_print_metrics(config, cb, ctx, counter, 0);
+				if (ret)
+					goto out;
+			}
+		}
+		break;
+	case AGGR_UNSET:
+	case AGGR_MAX:
+	default:
+		fprintf(config->output, "Aggregation mode %d not supported in new API yet\n",
+			config->aggr_mode);
+		break;
+	}
+
+out:
+	if (cb->print_end) {
+		int err = cb->print_end(ctx, config);
+
+		if (!ret)
+			ret = err;
+	}
+
+	return ret;
+}
+
+int perf_stat__print(struct evlist *evlist, const struct perf_stat_config *config,
+		     const struct target *target, const struct timespec *ts, int argc,
+		     const char **argv)
+{
+	if (config->csv_output)
+		return perf_stat__print_csv(evlist, config, target, ts, argc, argv);
+	else if (config->json_output)
+		return perf_stat__print_json(evlist, config, target, ts, argc, argv);
+	else
+		return perf_stat__print_std(evlist, config, target, ts, argc, argv);
+}
diff --git a/tools/perf/util/stat-print.h b/tools/perf/util/stat-print.h
new file mode 100644
index 000000000000..a86414f32584
--- /dev/null
+++ b/tools/perf/util/stat-print.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_STAT_PRINT_H
+#define __PERF_STAT_PRINT_H
+
+#include <linux/types.h>
+
+#include "stat.h"
+
+#define CNTR_NOT_SUPPORTED "<not supported>"
+#define CNTR_NOT_COUNTED "<not counted>"
+
+struct evlist;
+struct perf_stat_config;
+struct target;
+struct timespec;
+struct evsel;
+struct aggr_cpu_id;
+
+extern const int aggr_header_lens[];
+extern const char *aggr_header_csv[];
+extern const char *aggr_header_std[];
+
+/**
+ * struct perf_stat_print_callbacks - Callbacks for rendering perf stat output.
+ *
+ * This structure defines the interface for different output formats (e.g.,
+ * Standard, CSV, JSON) to render the collected performance counter statistics.
+ * The core display logic traverses the events and metrics and calls these
+ * callbacks in a streaming fashion, which build an in-memory DOM tree. The
+ * final rendering and output formatting is executed entirely in print_end.
+ */
+struct perf_stat_print_callbacks {
+	/**
+	 * print_start - Called before any event or metric is printed.
+	 * @ctx: Opaque context pointer passed to the print function.
+	 * @config: Perf stat configuration.
+	 */
+	int (*print_start)(void *ctx, const struct perf_stat_config *config);
+
+	/**
+	 * print_end - Called after all events and metrics have been traversed.
+	 * Executes the actual formatting and printing of the buffered tree.
+	 * @ctx: Opaque context pointer.
+	 * @config: Perf stat configuration.
+	 */
+	int (*print_end)(void *ctx, const struct perf_stat_config *config);
+
+	/**
+	 * print_event - Called to buffer an event (counter) value.
+	 * @ctx: Opaque context pointer.
+	 * @config: Perf stat configuration.
+	 * @evsel: The event selector being printed (mutable for lazy initialization).
+	 * @aggr_idx: Aggregation index in evsel->stats.
+	 * @val: Raw counter value.
+	 * @ena: Enabled time for the counter (for multiplexing).
+	 * @run: Running time for the counter (for multiplexing).
+	 * @stdev_pct: Standard deviation percentage across multiple repeated runs.
+	 *
+	 * Returns 0 on success, or a negative error code (e.g., -ENOMEM) on failure.
+	 */
+	int (*print_event)(void *ctx, const struct perf_stat_config *config, struct evsel *evsel,
+			   int aggr_idx, u64 val, u64 ena, u64 run, double stdev_pct);
+
+	/**
+	 * print_metric - Called to buffer a metric value associated with an event.
+	 * @ctx: Opaque context pointer.
+	 * @config: Perf stat configuration.
+	 * @evsel: The event selector associated with the metric (mutable).
+	 * @aggr_idx: Aggregation index.
+	 * @name: The display name of the metric.
+	 * @unit: The unit of the metric (e.g., "%", "GHz", or NULL).
+	 * @val: The calculated metric value.
+	 * @thresh: Threshold classification (e.g., good, bad) for color coding.
+	 *
+	 * Returns 0 on success, or a negative error code (e.g., -ENOMEM) on failure.
+	 */
+	int (*print_metric)(void *ctx, const struct perf_stat_config *config, struct evsel *evsel,
+			    int aggr_idx, const char *name, const char *unit, double val,
+			    enum metric_threshold_classify thresh);
+};
+
+/**
+ * perf_stat__get_aggr_key - Get the JSON key name for an aggregation mode.
+ */
+const char *perf_stat__get_aggr_key(const struct perf_stat_config *config,
+				    const struct evsel *evsel);
+
+/**
+ * perf_stat__get_aggr_id_char - Get the unified aggregation ID string.
+ *
+ * Returns the formatted string size, or a negative error code on failure.
+ */
+int perf_stat__get_aggr_id_char(const struct perf_stat_config *config, struct evsel *evsel,
+				struct aggr_cpu_id id, char *buf, size_t buf_size);
+
+/**
+ * perf_stat__print_cb - Drive the traversal and call callbacks.
+ *
+ * Defined in stat-print.c. Called by format-specific entry points.
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int perf_stat__print_cb(struct evlist *evlist, const struct perf_stat_config *config,
+			const struct target *target, const struct timespec *ts, int argc,
+			const char **argv, const struct perf_stat_print_callbacks *cb, void *ctx);
+
+/**
+ * perf_stat__print - Entry point for the decoupled print API.
+ *
+ * Defined in stat-print.c. Dispatches to format-specific entry points.
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int perf_stat__print(struct evlist *evlist, const struct perf_stat_config *config,
+		     const struct target *target, const struct timespec *ts, int argc,
+		     const char **argv);
+
+/*
+ * Format-specific entry points, implemented in their respective files.
+ * All return 0 on success, or a negative error code on failure.
+ */
+
+int perf_stat__print_std(struct evlist *evlist, const struct perf_stat_config *config,
+			 const struct target *target, const struct timespec *ts, int argc,
+			 const char **argv);
+
+int perf_stat__print_csv(struct evlist *evlist, const struct perf_stat_config *config,
+			 const struct target *target, const struct timespec *ts, int argc,
+			 const char **argv);
+
+int perf_stat__print_json(struct evlist *evlist, const struct perf_stat_config *config,
+			  const struct target *target, const struct timespec *ts, int argc,
+			  const char **argv);
+
+#endif /* __PERF_STAT_PRINT_H */
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 4bced233d2fc..77873d51786c 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -106,6 +106,8 @@ struct perf_stat_config {
 	bool			 ctl_fd_close;
 	const char		*cgroup_list;
 	unsigned int		topdown_level;
+	bool			 headers_printed;
+	bool			 metric_only_headers_printed;
 };
 
 extern struct perf_stat_config stat_config;
-- 
2.55.0.141.g00534a21ce-goog

