Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D383F106B
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186427; cv=none; b=nf4Uo1+TGXtF3Yfs1D2+JoFtA7ih6kpTIWcpKmwPWbbGqRqGWL+67VMKe9S7YGV5D3q/1vtlTTmk8MkcIQ+rPgaQ/NzHz6wIn2hOpfayAr14gQCYdXWUTa40p/5G2T+RCKD/m4fu/26Ftrs++q0j9muTrKpSZgPichphsS61ItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186427; c=relaxed/simple;
	bh=089I/0w5O2mY7ntMLWGuQuxYXW20XG8wn6vtUu+D5Cs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bu6rOsz5EOVq9Nrv8lsGXtSX0rv6uAJIDa8F6q2Y1ikegtHgZRFwyOrIa6nk4vPXLulgkmVIf0m22neuVYHfE3KW9lKW9B0rb21seSP93sRmIXhKEFcOzZBK12FpwwqTtzFgWOCeyn21GdbKIGa23YLQLBA4zjGHpSoXj5NOGNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qOySyFWJ; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOySyFWJ"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3552883bd19so868613eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792186411; x=1792791211; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7dOwQ0+596MswX1I7fxa9q8t+wFeSJGqATiAjgxCMYw=;
        b=qOySyFWJFH08vzjh0m8u82Svo//FxWuxrNsb/ehlroFc2Ypx/gZh3gmh7RjbsmnDfx
         H99oo+Z8uaf0qvCZNMbprM50TmiHFMYThmsHrpUae20g3IDbUAzmSBMUe1CiFY6wcdsm
         2GMYAZ7BkQCsA/AiUQ+J66tDC1zjJnMSjyoMoNTt7nR3n40Bvf6KmC0EXaWIsHywFUaA
         rcS1ezBIQpsLlag2eDyRXCydKFbJmHnJC4jdeAXuv4GWLiHOYnh7VJq0HuKwnC/D8GR8
         gYr/M5ETB4y95KFImrtf2ZIgGmNkrygtsn99Gi+CxCwJ8z5ff6cA4DKtmnfmKwiIF/aJ
         aguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186411; x=1792791211;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7dOwQ0+596MswX1I7fxa9q8t+wFeSJGqATiAjgxCMYw=;
        b=qTcn3ksIdBvk6NNgvK6bVc9LatFvrHHOL0W4Lvxesh/8i64wD4rV2/2rSzeWSW5q/1
         wSCG25gpDIyMDO7ZmxnGXkI0TMQV/1xmI6lcvYl/I9pkGyQ92h34k24s/X6kuaGukoBt
         BQsVZbjOayWf4FfNUVzbBXGZk5uREJAORcZ0gGgXYAPv9D1z6an09Dm8ZSl0wyMbKliL
         2jfXhX50sVCvlMtEx/PRd4qCuLEGuwPCgxfzNCojMhT8dnjM2clUSYVZvvpLeB8nHGZp
         TnRFEWPYGXZk2fn5ZMYDOr7H0XMjkUXbEJQinxWUERMx+qG6PrvmVOvLMmbZ7429WOTo
         lBhw==
X-Gm-Message-State: AFq9FYKGR5kFSy56sV7n0I1eEXEt4IJrmM0bOVVNa1E/F+Mcs4I5TUFm
	WNkVYIH84Txq1nmav6wqlrtPx6R0iWsuVrSPjPncuyrOGCLTQQ0/nBxYvQVITopA0pQvLalVcDL
	0/bg2KP6XEw==
X-Received: from dybb27.prod.google.com ([2002:a05:693c:609b:b0:353:7c89:d664])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1621:b0:35d:4185:5395
 with SMTP id 5a478bee46e88-361a185f188mr1376340eec.16.1792186409079; Fri, 16
 Oct 2026 14:33:29 -0700 (PDT)
Date: Fri, 16 Oct 2026 14:32:58 -0700
In-Reply-To: <20261016213258.945737-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016213258.945737-3-irogers@google.com>
Subject: [RFC PATCH v1 2/2] perf sysinfo: Add sysinfo subcommand,
 documentation, and test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the 'perf sysinfo' subcommand to display and probe PMUs and system
performance monitoring capabilities on the running system or from a
perf.data file.

For each PMU, 'perf sysinfo' reports static attributes (type,
core/uncore/software/auxtrace/drm/hwmon/tool classification, CPUs,
capabilities, sysfs formats, event counts, and memory profiling events)
as well as probed runtime capabilities in text or JSON format, followed
by a system-wide summary of core features, memory and PCIe/IO bus
bandwidth monitoring, total events and metrics, pipeline metric
drill-down levels, and an overall system rating.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build                          |    1 +
 tools/perf/Documentation/perf-sysinfo.txt |  109 ++
 tools/perf/Documentation/perf.txt         |    2 +-
 tools/perf/builtin-help.c                 |    3 +-
 tools/perf/builtin-sysinfo.c              | 1958 +++++++++++++++++++++
 tools/perf/builtin.h                      |    1 +
 tools/perf/perf.c                         |    1 +
 tools/perf/tests/shell/sysinfo.sh         |   71 +
 8 files changed, 2144 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-sysinfo.txt
 create mode 100644 tools/perf/builtin-sysinfo.c
 create mode 100755 tools/perf/tests/shell/sysinfo.sh

diff --git a/tools/perf/Build b/tools/perf/Build
index dcba5ba55206..8a3f6071fa40 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -13,6 +13,7 @@ perf-y += builtin-list.o
 perf-y += builtin-record.o
 perf-y += builtin-report.o
 perf-y += builtin-stat.o
+perf-y += builtin-sysinfo.o
 perf-y += builtin-top.o
 perf-y += builtin-script.o
 perf-y += builtin-kvm.o
diff --git a/tools/perf/Documentation/perf-sysinfo.txt b/tools/perf/Documentation/perf-sysinfo.txt
new file mode 100644
index 000000000000..4fc5fe229060
--- /dev/null
+++ b/tools/perf/Documentation/perf-sysinfo.txt
@@ -0,0 +1,109 @@
+perf-sysinfo(1)
+===============
+
+NAME
+----
+perf-sysinfo - Display and probe PMU and system performance monitoring information
+
+SYNOPSIS
+--------
+[verse]
+'perf sysinfo' [<options>] [pmu_glob ...]
+
+DESCRIPTION
+-----------
+This command displays a summary of the performance monitoring capabilities of
+the current system or a perf.data file, including core PMU features (precise
+sampling, branch stack sampling, user-space counter reading, memory profiling,
+and hardware AUX trace PMUs), memory and PCIe/IO interconnect bus bandwidth
+monitoring support, total events and metrics, pipeline metric drill-down levels
+discovered via '<metric>_group' hierarchies, and an overall system rating.
+
+When '-p'/'--pmus' is specified (or when PMU filter globs, '-v'/'--verbose',
+'-a'/'--all', or '-j'/'--json' are given), it also displays detailed
+information for each PMU, including its perf_event_attr type, kind (core,
+uncore, software, auxtrace, tool, hwmon, drm), CPUs/cpumask, capabilities,
+sysfs format bitfields, event counts, and memory profiling events.
+
+When run on a live system (without '-i'/'--input' and with probing enabled),
+it also actively probes the kernel via 'perf_event_open' to determine:
+- Supported modes (counting, interrupt-based sampling, branch_stack sampling)
+- Supported precise sampling levels, skid semantics, and empirically measured
+  branch instruction skid (minimum, maximum, average instructions from the
+  branch and 'PERF_RECORD_MISC_EXACT_IP' ratio) at each supported precision
+  level:
+  0 ('SAMPLE_IP' can have arbitrary skid), ':p' / 1 ('SAMPLE_IP' must have
+  constant skid), ':pp' / 2 ('SAMPLE_IP' requested to have 0 skid), and
+  ':ppp' / 3 ('SAMPLE_IP' must have 0 skid, or uses randomization to avoid
+  sample shadowing effects)
+- Supported 'perf_event_sample_format' sample types ('ip', 'tid', 'time',
+  'addr', 'read', 'callchain', 'id', 'cpu', 'period', 'stream_id', 'raw',
+  'branch_stack', 'regs_user', 'stack_user', 'weight', 'data_src',
+  'identifier', 'transaction', 'regs_intr', 'phys_addr', 'aux', 'cgroup',
+  'data_page_size', 'code_page_size', 'weight_struct')
+- Supported user and interrupt registers for 'PERF_SAMPLE_REGS_USER' and
+  'PERF_SAMPLE_REGS_INTR'
+- Supported memory profiling events ('ldlat-loads', 'ldlat-stores', 'mem-ldst')
+  and their supported memory sample types ('data_src', 'addr', 'weight', etc.)
+- Supported privilege/exclusion modifiers ('exclude_user', 'exclude_kernel',
+  'exclude_hv', 'exclude_idle', 'exclude_host', 'exclude_guest')
+- Supported execution features ('leader_sampling', 'sw_grouping', 'inherit',
+  'sample_freq', 'write_backward', 'callchain', 'data_src', 'weight',
+  'pinned', 'exclusive', 'format_lost', 'auto_counter_reload',
+  'aux_start_paused', 'aux_pause', 'aux_resume', 'aux_sample', 'user_rdpmc',
+  'user_time', 'user_time_zero', 'user_time_short') and hardware counter
+  bit-width ('pmc_width') when user-space counter reading is supported
+- Maximum event group size accepted by 'perf_event_open' and maximum
+  simultaneously active counters in a group without multiplexing
+
+At the end of the text output, a summary section reports overall core PMU
+capabilities (including hardware AUX trace PMUs), memory and PCIe/IO
+interconnect bus bandwidth monitoring support, total events and metrics, and
+pipeline metric drill-down levels discovered via '<metric>_group' hierarchies.
+
+By default, numbered uncore PMU instances sharing a common prefix are collapsed
+into a single entry showing the instance count, unless '-v'/'--verbose' is
+specified.
+
+OPTIONS
+-------
+-i::
+--input=::
+	Input file name to read PMU information from (e.g. perf.data).
+
+-f::
+--force::
+	Don't complain, do it (when reading input perf.data file).
+
+-o::
+--output=::
+	Output file name.
+
+-p::
+--pmus::
+	Display detailed information for each PMU in addition to the system
+	summary.
+
+-j::
+--json::
+	Encode PMU information as JSON.
+
+-a::
+--all::
+-v::
+--verbose::
+	Display all PMUs including all similar PMUs with alphanumeric suffixes
+	instead of collapsing numbered uncore PMU instances.
+
+--probe::
+--no-probe::
+	Enable or disable active kernel probing of PMU capabilities on the live
+	system (default: enabled).
+
+--debug::
+	Enable debugging output.
+
+SEE ALSO
+--------
+linkperf:perf-list[1], linkperf:perf-evlist[1], linkperf:perf-stat[1],
+linkperf:perf-record[1]
diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index cbcc2e4d557e..0890dd5a1794 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -92,5 +92,5 @@ linkperf:perf-help[1], linkperf:perf-inject[1],
 linkperf:perf-intel-pt[1], linkperf:perf-iostat[1], linkperf:perf-kallsyms[1],
 linkperf:perf-kmem[1], linkperf:perf-kvm[1], linkperf:perf-lock[1],
 linkperf:perf-mem[1], linkperf:perf-probe[1], linkperf:perf-sched[1],
-linkperf:perf-script[1], linkperf:perf-test[1],
+linkperf:perf-script[1], linkperf:perf-sysinfo[1], linkperf:perf-test[1],
 linkperf:perf-trace[1], linkperf:perf-version[1]
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 5bbdb4d9b9c0..fbab4b77761b 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -329,6 +329,7 @@ void list_common_cmds_help(void)
 		{"report", "Read perf.data (created by perf record) and display the profile"},
 		{"script", "Read perf.data (created by perf record) and display trace output"},
 		{"stat", "Run a command and gather performance counter statistics"},
+		{"sysinfo", "Display and probe PMU and system performance monitoring information"},
 		{"test", "Runs sanity tests."},
 		{"top", "System profiling tool."},
 		{"version", "display the version of perf binary"},
@@ -485,7 +486,7 @@ int cmd_help(int argc, const char **argv)
 	};
 	const char * const builtin_help_subcommands[] = {
 		"buildid-cache", "buildid-list", "diff", "evlist", "help", "list",
-		"record", "report", "bench", "stat", "timechart", "top", "annotate",
+		"record", "report", "bench", "stat", "sysinfo", "timechart", "top", "annotate",
 		"script", "sched", "kallsyms", "kmem", "lock", "kvm", "test", "inject", "mem", "data",
 #ifdef HAVE_LIBELF_SUPPORT
 		"probe",
diff --git a/tools/perf/builtin-sysinfo.c b/tools/perf/builtin-sysinfo.c
new file mode 100644
index 000000000000..8bc13f3dedb0
--- /dev/null
+++ b/tools/perf/builtin-sysinfo.c
@@ -0,0 +1,1958 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * builtin-sysinfo.c
+ *
+ * Builtin sysinfo command: Display and probe PMU and system performance
+ * monitoring information in a system or a perf.data file.
+ */
+#include "builtin.h"
+
+#include "util/color.h"
+#include "util/cpumap.h"
+#include "util/data.h"
+#include "util/debug.h"
+#include "util/evlist.h"
+#include "util/evsel.h"
+#include "util/header.h"
+#include "util/mem-events.h"
+#include "util/metricgroup.h"
+#include "util/perf_regs.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
+#include "util/session.h"
+#include "util/strbuf.h"
+#include "util/string2.h"
+#include "util/strlist.h"
+#include "util/tool.h"
+
+#include <dwarf-regs.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/perf_event.h>
+#include <linux/zalloc.h>
+#include <subcmd/pager.h>
+#include <subcmd/parse-options.h>
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <strings.h>
+
+static const char *pmu_type_desc(u32 type)
+{
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+		return "PERF_TYPE_HARDWARE";
+	case PERF_TYPE_SOFTWARE:
+		return "PERF_TYPE_SOFTWARE";
+	case PERF_TYPE_TRACEPOINT:
+		return "PERF_TYPE_TRACEPOINT";
+	case PERF_TYPE_HW_CACHE:
+		return "PERF_TYPE_HW_CACHE";
+	case PERF_TYPE_RAW:
+		return "PERF_TYPE_RAW";
+	case PERF_TYPE_BREAKPOINT:
+		return "PERF_TYPE_BREAKPOINT";
+	default:
+		if (type <= PERF_PMU_TYPE_PE_END)
+			return "dynamic";
+		if (type <= PERF_PMU_TYPE_DRM_END)
+			return "drm";
+		if (type <= PERF_PMU_TYPE_HWMON_END)
+			return "hwmon";
+		if (type == PERF_PMU_TYPE_TOOL)
+			return "tool";
+		return "fake";
+	}
+}
+
+static const char *format_config_name(int config)
+{
+	static const char * const config_names[PERF_PMU_FORMAT_VALUE_CONFIG_END] = {
+		[PERF_PMU_FORMAT_VALUE_CONFIG]  = "config",
+		[PERF_PMU_FORMAT_VALUE_CONFIG1] = "config1",
+		[PERF_PMU_FORMAT_VALUE_CONFIG2] = "config2",
+		[PERF_PMU_FORMAT_VALUE_CONFIG3] = "config3",
+		[PERF_PMU_FORMAT_VALUE_CONFIG4] = "config4",
+	};
+
+	if (config >= 0 && config < PERF_PMU_FORMAT_VALUE_CONFIG_END)
+		return config_names[config];
+	return "config?";
+}
+
+static bool pmu_matches_filters(const struct perf_pmu *pmu,
+				int argc, const char **argv)
+{
+	if (argc <= 0)
+		return true;
+
+	for (int i = 0; i < argc; i++) {
+		const char *pat = argv[i];
+
+		if (perf_pmu__wildcard_match(pmu, pat))
+			return true;
+		if (pmu->name && (strglobmatch(pmu->name, pat) || !strcmp(pmu->name, pat)))
+			return true;
+		if (pmu->alias_name &&
+		    (strglobmatch(pmu->alias_name, pat) || !strcmp(pmu->alias_name, pat)))
+			return true;
+		if (pmu->name) {
+			size_t base_len = pmu_name_len_no_suffix(pmu->name);
+
+			if (strlen(pat) == base_len && !strncmp(pmu->name, pat, base_len))
+				return true;
+		}
+	}
+	return false;
+}
+
+static void json_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	strbuf_setlen(buf, 0);
+	for (size_t fmt_pos = 0; fmt_pos < strlen(fmt); fmt_pos++) {
+		switch (fmt[fmt_pos]) {
+		case '%':
+			fmt_pos++;
+			switch (fmt[fmt_pos]) {
+			case 's': {
+				const char *s = va_arg(args, const char*);
+
+				strbuf_addstr(buf, s);
+				break;
+			}
+			case 'S': {
+				const char *s = va_arg(args, const char*);
+
+				for (size_t s_pos = 0; s[s_pos] != '\0'; s_pos++) {
+					switch (s[s_pos]) {
+					case '\n':
+						strbuf_addstr(buf, "\\n");
+						break;
+					case '\r':
+						strbuf_addstr(buf, "\\r");
+						break;
+					case '\t':
+						strbuf_addstr(buf, "\\t");
+						break;
+					case '\\':
+						fallthrough;
+					case '\"':
+						strbuf_addch(buf, '\\');
+						fallthrough;
+					default:
+						strbuf_addch(buf, s[s_pos]);
+						break;
+					}
+				}
+				break;
+			}
+			default:
+				strbuf_addch(buf, '%');
+				strbuf_addch(buf, fmt[fmt_pos]);
+				break;
+			}
+			break;
+		default:
+			strbuf_addch(buf, fmt[fmt_pos]);
+			break;
+		}
+	}
+	va_end(args);
+	fputs(buf->buf, fp);
+}
+
+struct print_format_state {
+	FILE *fp;
+	struct strbuf *buf;
+	bool json;
+	int count;
+};
+
+static int print_format_cb(void *vstate, const char *name, int config,
+			   const unsigned long *bits)
+{
+	struct print_format_state *state = vstate;
+	char bits_buf[128];
+
+	if (!bits)
+		return 0;
+
+	bitmap_scnprintf((unsigned long *)bits, PERF_PMU_FORMAT_BITS,
+			 bits_buf, sizeof(bits_buf));
+
+	if (state->json) {
+		char spec[160];
+
+		if (state->count == 0)
+			fprintf(state->fp, ",\n\t\"Formats\": {\n");
+
+		snprintf(spec, sizeof(spec), "%s:%s",
+			 format_config_name(config), bits_buf);
+		json_escape_fprintf(state->fp, state->buf, "%s\t\t\"%S\": \"%S\"",
+				    state->count > 0 ? ",\n" : "",
+				    name, spec);
+	} else {
+		if (state->count == 0)
+			fprintf(state->fp, "  Formats: ");
+
+		fprintf(state->fp, "%s%s (%s:%s)",
+			state->count > 0 ? ", " : "",
+			name, format_config_name(config), bits_buf);
+	}
+	state->count++;
+	return 0;
+}
+
+static bool evsel_matches_pmu(const struct evsel *evsel,
+			      const struct perf_pmu *pmu, bool show_all)
+{
+	struct perf_pmu *ev_pmu = evsel__find_pmu(evsel);
+	const char *ev_pmu_name;
+
+	if (ev_pmu == pmu)
+		return true;
+
+	if (ev_pmu) {
+		if (!show_all && !pmu->is_core && pmu->name && ev_pmu->name) {
+			size_t base_len = pmu_name_len_no_suffix(pmu->name);
+
+			if (pmu_name_len_no_suffix(ev_pmu->name) == base_len &&
+			    !strncmp(pmu->name, ev_pmu->name, base_len))
+				return true;
+		}
+		return false;
+	}
+
+	ev_pmu_name = evsel__pmu_name(evsel);
+	if (ev_pmu_name && pmu->name) {
+		if (!strcmp(ev_pmu_name, pmu->name))
+			return true;
+		if (!show_all && !pmu->is_core) {
+			size_t base_len = pmu_name_len_no_suffix(pmu->name);
+
+			if (pmu_name_len_no_suffix(ev_pmu_name) == base_len &&
+			    !strncmp(pmu->name, ev_pmu_name, base_len))
+				return true;
+		}
+	}
+	return false;
+}
+
+static void print_recorded_events(FILE *fp, struct strbuf *buf,
+				  const struct perf_pmu *pmu,
+				  const struct perf_session *session,
+				  bool show_all, bool json)
+{
+	struct strlist *ev_names;
+	struct str_node *pos;
+	struct evsel *evsel;
+	size_t count = 0;
+
+	if (!session || !session->evlist)
+		return;
+
+	ev_names = strlist__new(NULL, NULL);
+	if (!ev_names)
+		return;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		if (evsel_matches_pmu(evsel, pmu, show_all))
+			strlist__add(ev_names, evsel__name(evsel));
+	}
+
+	if (strlist__empty(ev_names)) {
+		strlist__delete(ev_names);
+		return;
+	}
+
+	if (json) {
+		fprintf(fp, ",\n\t\"RecordedEvents\": [");
+		strlist__for_each_entry(pos, ev_names) {
+			json_escape_fprintf(fp, buf, "%s\"%S\"",
+					    count > 0 ? ", " : "", pos->s);
+			count++;
+		}
+		fprintf(fp, "]");
+	} else {
+		fprintf(fp, "  Recorded events: ");
+		strlist__for_each_entry(pos, ev_names) {
+			fprintf(fp, "%s%s", count > 0 ? ", " : "", pos->s);
+			count++;
+		}
+		fputc('\n', fp);
+	}
+
+	strlist__delete(ev_names);
+}
+
+static const struct {
+	u64 bit;
+	const char *name;
+} sample_type_names[] = {
+	{ PERF_SAMPLE_IP,		"ip" },
+	{ PERF_SAMPLE_TID,		"tid" },
+	{ PERF_SAMPLE_TIME,		"time" },
+	{ PERF_SAMPLE_ADDR,		"addr" },
+	{ PERF_SAMPLE_READ,		"read" },
+	{ PERF_SAMPLE_CALLCHAIN,	"callchain" },
+	{ PERF_SAMPLE_ID,		"id" },
+	{ PERF_SAMPLE_CPU,		"cpu" },
+	{ PERF_SAMPLE_PERIOD,		"period" },
+	{ PERF_SAMPLE_STREAM_ID,	"stream_id" },
+	{ PERF_SAMPLE_RAW,		"raw" },
+	{ PERF_SAMPLE_BRANCH_STACK,	"branch_stack" },
+	{ PERF_SAMPLE_REGS_USER,	"regs_user" },
+	{ PERF_SAMPLE_STACK_USER,	"stack_user" },
+	{ PERF_SAMPLE_WEIGHT,		"weight" },
+	{ PERF_SAMPLE_DATA_SRC,		"data_src" },
+	{ PERF_SAMPLE_IDENTIFIER,	"identifier" },
+	{ PERF_SAMPLE_TRANSACTION,	"transaction" },
+	{ PERF_SAMPLE_REGS_INTR,	"regs_intr" },
+	{ PERF_SAMPLE_PHYS_ADDR,	"phys_addr" },
+	{ PERF_SAMPLE_AUX,		"aux" },
+	{ PERF_SAMPLE_CGROUP,		"cgroup" },
+	{ PERF_SAMPLE_DATA_PAGE_SIZE,	"data_page_size" },
+	{ PERF_SAMPLE_CODE_PAGE_SIZE,	"code_page_size" },
+	{ PERF_SAMPLE_WEIGHT_STRUCT,	"weight_struct" },
+};
+
+static const char *precise_level_desc(int lvl)
+{
+	switch (lvl) {
+	case 0:
+		return "0 - SAMPLE_IP can have arbitrary skid";
+	case 1:
+		return "1 - SAMPLE_IP must have constant skid";
+	case 2:
+		return "2 - SAMPLE_IP requested to have 0 skid";
+	case 3:
+		return "3 - SAMPLE_IP must have 0 skid, or uses randomization";
+	default:
+		return "unknown";
+	}
+}
+
+static void print_precise_levels(FILE *fp, const struct perf_pmu *pmu,
+				 unsigned int precise_mask,
+				 int max_precise, bool json)
+{
+	static const char * const pnames[] = { "", ":p", ":pp", ":ppp" };
+	bool need_sep = false;
+
+	if (json) {
+		fprintf(fp, ",\n\t\t\"PreciseLevels\": [");
+		for (int lvl = 1; lvl <= 3; lvl++) {
+			if (precise_mask & (1u << lvl)) {
+				fprintf(fp, "%s\"%s\"",
+					need_sep ? ", " : "", pnames[lvl]);
+				need_sep = true;
+			}
+		}
+		fprintf(fp, "]");
+		return;
+	}
+
+	fprintf(fp, "    Precise sampling: ");
+	if (precise_mask == 0) {
+		if (perf_pmu__is_software(pmu)) {
+			color_fprintf(fp, PERF_COLOR_GREEN, "always precise");
+			fprintf(fp, " (software event, SAMPLE_IP has 0 skid)\n");
+		} else {
+			color_fprintf(fp, PERF_COLOR_RED, "not supported");
+			fprintf(fp, " (%s)\n", precise_level_desc(0));
+		}
+		return;
+	}
+
+	for (int lvl = 1; lvl <= 3; lvl++) {
+		if (precise_mask & (1u << lvl)) {
+			if (need_sep)
+				fprintf(fp, ", ");
+			color_fprintf(fp, PERF_COLOR_GREEN, "%s", pnames[lvl]);
+			fprintf(fp, " (%s)", precise_level_desc(lvl));
+			need_sep = true;
+		}
+	}
+	fprintf(fp, " (max_precise: ");
+	color_fprintf(fp, PERF_COLOR_GREEN, "%d", max_precise);
+	fprintf(fp, ")\n");
+}
+
+static void print_measured_skid(FILE *fp, const struct perf_pmu *pmu, bool json)
+{
+	static const char * const lvl_keys[] = { "0", ":p", ":pp", ":ppp" };
+	static const char * const lvl_labels[] = {
+		"level 0 (no :p)",
+		"level 1 (:p)",
+		"level 2 (:pp)",
+		"level 3 (:ppp)",
+	};
+	const typeof(pmu->probed) *p = &pmu->probed;
+	bool any = false;
+	bool first = true;
+
+	for (int lvl = 0; lvl <= 3; lvl++) {
+		if (p->skid[lvl].measured) {
+			any = true;
+			break;
+		}
+	}
+	if (!any)
+		return;
+
+	if (json)
+		fprintf(fp, ",\n\t\t\"MeasuredSkid\": {\n");
+	else
+		fprintf(fp, "    Measured branch skid (instructions from branch):\n");
+
+	for (int lvl = 0; lvl <= 3; lvl++) {
+		if (!p->skid[lvl].measured)
+			continue;
+		if (json) {
+			fprintf(fp,
+				"%s\t\t\t\"%s\": { \"Samples\": %d, \"ExactIp\": %d, \"MinInsn\": %d, \"MaxInsn\": %d, \"AvgInsn\": %.1f }",
+				first ? "" : ",\n",
+				lvl_keys[lvl],
+				p->skid[lvl].samples,
+				p->skid[lvl].exact_samples,
+				p->skid[lvl].min_skid,
+				p->skid[lvl].max_skid,
+				p->skid[lvl].avg_skid);
+		} else {
+			const char *skid_color = PERF_COLOR_YELLOW;
+
+			if (p->skid[lvl].max_skid == 0)
+				skid_color = PERF_COLOR_GREEN;
+			else if (p->skid[lvl].max_skid <= 2)
+				skid_color = PERF_COLOR_CYAN;
+
+			fprintf(fp, "      %-15s: ", lvl_labels[lvl]);
+			color_fprintf(fp, skid_color, "min %d, max %d, avg %.1f",
+				      p->skid[lvl].min_skid,
+				      p->skid[lvl].max_skid,
+				      p->skid[lvl].avg_skid);
+			fprintf(fp, " (%d/%d exact_ip)\n",
+				p->skid[lvl].exact_samples,
+				p->skid[lvl].samples);
+		}
+		first = false;
+	}
+
+	if (json)
+		fprintf(fp, "\n\t\t}");
+}
+
+static void print_sample_type_list(FILE *fp, u64 mask, bool json)
+{
+	bool need_sep = false;
+
+	for (size_t x = 0; x < ARRAY_SIZE(sample_type_names); x++) {
+		if (!(mask & sample_type_names[x].bit))
+			continue;
+		if (json)
+			fprintf(fp, "%s\"%s\"", need_sep ? ", " : "", sample_type_names[x].name);
+		else
+			fprintf(fp, "%s%s", need_sep ? ", " : "", sample_type_names[x].name);
+		need_sep = true;
+	}
+	if (!json && !need_sep)
+		fprintf(fp, "none");
+}
+
+static void print_probed_regs(FILE *fp, struct strbuf *buf, const char *label,
+			      u64 mask, int abi, u64 simd_mask, u64 pred_mask,
+			      bool intr, bool json)
+{
+	const char *last_name = NULL;
+	bool need_sep = false;
+
+	if (!mask && !simd_mask && !pred_mask)
+		return;
+
+	if (json)
+		fprintf(fp, ",\n\t\t\"%s\": [", label);
+	else
+		fprintf(fp, "    %s: ", label);
+
+	for (int reg = 0; reg < 64; reg++) {
+		const char *name;
+
+		if (!(mask & BIT_ULL(reg)))
+			continue;
+		name = perf_reg_name(reg, EM_HOST, EF_HOST, abi);
+		if (!name || !strcmp(name, "unknown"))
+			continue;
+		if (last_name && !strcmp(last_name, name))
+			continue;
+		last_name = name;
+
+		if (json) {
+			json_escape_fprintf(fp, buf, "%s\"%S\"",
+					    need_sep ? ", " : "", name);
+		} else {
+			fprintf(fp, "%s%s", need_sep ? ", " : "", name);
+		}
+		need_sep = true;
+	}
+
+	for (int is_pred = 0; is_pred <= 1; is_pred++) {
+		bool pred = is_pred != 0;
+		u64 cmask = pred ? pred_mask : simd_mask;
+
+		for (int reg_c = 0; reg_c < 64; reg_c++) {
+			const char *cname;
+			u16 qwords = 0;
+			u64 bitmap;
+			char reg_range[64];
+
+			if (!(cmask & BIT_ULL(reg_c)))
+				continue;
+			cname = perf_simd_reg_class_name(EM_HOST, reg_c, pred);
+			bitmap = intr ?
+				perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+								       &qwords, pred) :
+				perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+								       &qwords, pred);
+			if (!cname || !bitmap)
+				continue;
+			snprintf(reg_range, sizeof(reg_range), "%s0-%d",
+				 cname, fls64(bitmap) - 1);
+			if (json) {
+				json_escape_fprintf(fp, buf, "%s\"%S\"",
+						    need_sep ? ", " : "", reg_range);
+			} else {
+				fprintf(fp, "%s%s", need_sep ? ", " : "", reg_range);
+			}
+			need_sep = true;
+		}
+	}
+
+	if (json)
+		fprintf(fp, "]");
+	else
+		fputc('\n', fp);
+}
+
+static void print_mem_events_static(FILE *fp, struct strbuf *buf,
+				    const struct perf_pmu *pmu, bool json)
+{
+	bool first = true;
+
+	if (!pmu->mem_events)
+		return;
+
+	perf_pmu__mem_events_init_pmu((struct perf_pmu *)pmu);
+
+	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		struct perf_mem_event *e = perf_pmu__mem_events_ptr((struct perf_pmu *)pmu, j);
+		char ev_buf[256];
+		const char *s;
+
+		if (!e || !e->tag || !e->supported)
+			continue;
+		s = perf_pmu__mem_events_name((struct perf_pmu *)pmu, j,
+					      ev_buf, sizeof(ev_buf));
+		if (!s)
+			continue;
+
+		if (json) {
+			if (first)
+				fprintf(fp, ",\n\t\"MemoryEvents\": {\n");
+			json_escape_fprintf(fp, buf, "%s\t\t\"%S\": \"%S\"",
+					    first ? "" : ",\n", e->tag, s);
+		} else {
+			if (first)
+				fprintf(fp, "  Memory events: ");
+			fprintf(fp, "%s%s (%s)", first ? "" : ", ", e->tag, s);
+		}
+		first = false;
+	}
+
+	if (!first) {
+		if (json)
+			fprintf(fp, "\n\t}");
+		else
+			fputc('\n', fp);
+	}
+}
+
+static void print_pmu_json(FILE *fp, const struct perf_pmu *pmu,
+			   const struct perf_session *session, bool show_all)
+{
+	struct strbuf buf;
+	size_t num_instances = show_all ? 1 : perf_pmu__num_duplicates(pmu);
+	char display_name[128];
+	size_t total_events;
+	struct print_format_state format_state = {
+		.fp = fp,
+		.buf = &buf,
+		.json = true,
+		.count = 0,
+	};
+
+	strbuf_init(&buf, 0);
+
+	if (num_instances > 1) {
+		size_t base_len = pmu_name_len_no_suffix(pmu->name ?: "");
+
+		snprintf(display_name, sizeof(display_name), "%.*s",
+			 (int)base_len, pmu->name ?: "");
+	} else {
+		snprintf(display_name, sizeof(display_name), "%s", pmu->name ?: "");
+	}
+
+	fprintf(fp, "{\n");
+	json_escape_fprintf(fp, &buf, "\t\"Unit\": \"%S\"", display_name);
+	if (pmu->name)
+		json_escape_fprintf(fp, &buf, ",\n\t\"FullName\": \"%S\"", pmu->name);
+	fprintf(fp, ",\n\t\"Instances\": %zu", num_instances);
+	if (pmu->alias_name)
+		json_escape_fprintf(fp, &buf, ",\n\t\"Alias\": \"%S\"", pmu->alias_name);
+	if (pmu->id)
+		json_escape_fprintf(fp, &buf, ",\n\t\"Identifier\": \"%S\"", pmu->id);
+	if (pmu->type != PERF_PMU_TYPE_FAKE) {
+		fprintf(fp, ",\n\t\"Type\": %u", pmu->type);
+		json_escape_fprintf(fp, &buf, ",\n\t\"TypeDesc\": \"%S\"",
+				    pmu_type_desc(pmu->type));
+	}
+	fprintf(fp, ",\n\t\"IsCore\": %s", pmu->is_core ? "true" : "false");
+	fprintf(fp, ",\n\t\"IsUncore\": %s", pmu->is_uncore ? "true" : "false");
+	fprintf(fp, ",\n\t\"IsSoftware\": %s", perf_pmu__is_software(pmu) ? "true" : "false");
+	fprintf(fp, ",\n\t\"Auxtrace\": %s", pmu->auxtrace ? "true" : "false");
+	fprintf(fp, ",\n\t\"Selectable\": %s", pmu->selectable ? "true" : "false");
+
+	if (pmu->cpus) {
+		char cpus_buf[256];
+		int nr_cpus = perf_cpu_map__nr(pmu->cpus);
+
+		cpu_map__snprint(pmu->cpus, cpus_buf, sizeof(cpus_buf));
+		if (cpus_buf[0]) {
+			json_escape_fprintf(fp, &buf, ",\n\t\"CPUs\": \"%S\"", cpus_buf);
+			fprintf(fp, ",\n\t\"NrCPUs\": %d", nr_cpus);
+		}
+	}
+
+	perf_pmu__caps_parse((struct perf_pmu *)pmu);
+	if (!list_empty(&pmu->caps)) {
+		struct perf_pmu_caps *cap;
+		bool first = true;
+
+		fprintf(fp, ",\n\t\"Capabilities\": {\n");
+		list_for_each_entry(cap, &pmu->caps, list) {
+			json_escape_fprintf(fp, &buf, "%s\t\t\"%S\": \"%S\"",
+					    first ? "" : ",\n",
+					    cap->name, cap->value);
+			first = false;
+		}
+		fprintf(fp, "\n\t}");
+	}
+
+	perf_pmu__for_each_format((struct perf_pmu *)pmu, &format_state, print_format_cb);
+	if (format_state.count > 0)
+		fprintf(fp, "\n\t}");
+
+	total_events = perf_pmu__num_events((struct perf_pmu *)pmu);
+	if (total_events > 0) {
+		size_t sysfs_events = pmu->sysfs_aliases;
+		size_t json_events = total_events > sysfs_events ? total_events - sysfs_events : 0;
+
+		fprintf(fp, ",\n\t\"Events\": {\n");
+		fprintf(fp, "\t\t\"Total\": %zu,\n", total_events);
+		fprintf(fp, "\t\t\"Sysfs\": %zu,\n", sysfs_events);
+		fprintf(fp, "\t\t\"Json\": %zu\n", json_events);
+		fprintf(fp, "\t}");
+	}
+
+	print_mem_events_static(fp, &buf, pmu, /*json=*/true);
+	print_recorded_events(fp, &buf, pmu, session, show_all, /*json=*/true);
+
+	if (pmu->probed.checked) {
+		const typeof(pmu->probed) *p = &pmu->probed;
+
+		fprintf(fp, ",\n\t\"Probed\": {\n");
+		fprintf(fp, "\t\t\"OpenSupported\": %s",
+			p->open_supported ? "true" : "false");
+		if (p->open_supported) {
+			bool need_sep = false;
+			const struct {
+				bool supported;
+				const char *name;
+			} excl[] = {
+				{ p->exclude_user,   "exclude_user" },
+				{ p->exclude_kernel, "exclude_kernel" },
+				{ p->exclude_hv,     "exclude_hv" },
+				{ p->exclude_idle,   "exclude_idle" },
+				{ p->exclude_host,   "exclude_host" },
+				{ p->exclude_guest,  "exclude_guest" },
+			};
+
+			if (p->probe_event) {
+				json_escape_fprintf(fp, &buf,
+						    ",\n\t\t\"ProbeEvent\": \"%S\"",
+						    p->probe_event);
+			}
+			fprintf(fp, ",\n\t\t\"Counting\": %s",
+				p->can_count ? "true" : "false");
+			fprintf(fp, ",\n\t\t\"Sampling\": %s",
+				p->can_sample ? "true" : "false");
+			fprintf(fp, ",\n\t\t\"BranchStack\": %s",
+				p->can_branch_stack ? "true" : "false");
+			if (p->can_sample) {
+				if (!pmu->auxtrace) {
+					const char *pdesc = (p->max_precise == 0 &&
+							     perf_pmu__is_software(pmu)) ?
+						"software event - SAMPLE_IP has 0 skid" :
+						precise_level_desc(p->max_precise);
+
+					fprintf(fp, ",\n\t\t\"MaxPrecise\": %d", p->max_precise);
+					json_escape_fprintf(fp, &buf,
+							    ",\n\t\t\"MaxPreciseDesc\": \"%S\"",
+							    pdesc);
+					print_precise_levels(fp, pmu, p->precise_mask,
+							     p->max_precise, /*json=*/true);
+
+					print_measured_skid(fp, pmu, /*json=*/true);
+				}
+
+				fprintf(fp, ",\n\t\t\"SampleTypes\": [");
+				print_sample_type_list(fp, p->sample_types, /*json=*/true);
+				fprintf(fp, "]");
+			}
+
+			print_probed_regs(fp, &buf, "UserRegisters",
+					  p->user_regs_mask, p->user_regs_abi,
+					  p->user_simd_mask, p->user_pred_mask,
+					  /*intr=*/false, /*json=*/true);
+			print_probed_regs(fp, &buf, "IntrRegisters",
+					  p->intr_regs_mask, p->intr_regs_abi,
+					  p->intr_simd_mask, p->intr_pred_mask,
+					  /*intr=*/true, /*json=*/true);
+
+			if (p->mem_events_mask) {
+				need_sep = false;
+				fprintf(fp, ",\n\t\t\"MemoryEvents\": [");
+				for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+					struct perf_mem_event *e =
+						perf_pmu__mem_events_ptr((struct perf_pmu *)pmu, j);
+
+					if (e && e->tag && (p->mem_events_mask & (1u << j))) {
+						json_escape_fprintf(fp, &buf, "%s\"%S\"",
+								    need_sep ? ", " : "",
+								    e->tag);
+						need_sep = true;
+					}
+				}
+				fprintf(fp, "]");
+
+				fprintf(fp, ",\n\t\t\"MemorySampleTypes\": [");
+				print_sample_type_list(fp, p->mem_sample_types, /*json=*/true);
+				fprintf(fp, "]");
+			}
+
+			need_sep = false;
+			fprintf(fp, ",\n\t\t\"ExcludeModifiers\": [");
+			for (size_t x = 0; x < ARRAY_SIZE(excl); x++) {
+				if (excl[x].supported) {
+					fprintf(fp, "%s\"%s\"",
+						need_sep ? ", " : "",
+						excl[x].name);
+					need_sep = true;
+				}
+			}
+			fprintf(fp, "]");
+
+			{
+				const struct {
+					bool supported;
+					const char *name;
+				} feats[] = {
+					{ p->can_leader_sampling,  "leader_sampling" },
+					{ p->can_sw_grouping,      "sw_grouping" },
+					{ p->can_inherit,          "inherit" },
+					{ p->can_freq,             "sample_freq" },
+					{ p->can_write_backward,   "write_backward" },
+					{ p->can_callchain,        "callchain" },
+					{ p->can_data_src,         "data_src" },
+					{ p->can_weight,           "weight" },
+					{ p->can_pinned,           "pinned" },
+					{ p->can_exclusive,        "exclusive" },
+					{ p->can_format_lost,      "format_lost" },
+					{ p->can_acr,              "auto_counter_reload" },
+					{ p->can_aux_start_paused, "aux_start_paused" },
+					{ p->can_aux_pause,        "aux_pause" },
+					{ p->can_aux_resume,       "aux_resume" },
+					{ p->can_aux_sample,       "aux_sample" },
+					{ p->can_user_rdpmc,       "user_rdpmc" },
+					{ p->can_user_time,        "user_time" },
+					{ p->can_user_time_zero,   "user_time_zero" },
+					{ p->can_user_time_short,  "user_time_short" },
+				};
+
+				need_sep = false;
+				fprintf(fp, ",\n\t\t\"Features\": [");
+				for (size_t x = 0; x < ARRAY_SIZE(feats); x++) {
+					if (feats[x].supported) {
+						fprintf(fp, "%s\"%s\"",
+							need_sep ? ", " : "",
+							feats[x].name);
+						need_sep = true;
+					}
+				}
+				fprintf(fp, "]");
+			}
+
+			if (pmu->auxtrace) {
+				const struct {
+					bool supported;
+					const char *name;
+				} aux_acts[] = {
+					{ p->can_aux_start_paused, "aux_start_paused" },
+					{ p->can_aux_pause,        "aux_pause" },
+					{ p->can_aux_resume,       "aux_resume" },
+					{ p->can_aux_sample,       "aux_sample" },
+				};
+
+				need_sep = false;
+				fprintf(fp, ",\n\t\t\"AuxActions\": [");
+				for (size_t x = 0; x < ARRAY_SIZE(aux_acts); x++) {
+					if (aux_acts[x].supported) {
+						fprintf(fp, "%s\"%s\"",
+							need_sep ? ", " : "",
+							aux_acts[x].name);
+						need_sep = true;
+					}
+				}
+				fprintf(fp, "]");
+			}
+
+			if (p->can_user_rdpmc && p->pmc_width > 0)
+				fprintf(fp, ",\n\t\t\"PmcWidth\": %u", p->pmc_width);
+
+			fprintf(fp, ",\n\t\t\"UserRdpmc\": {\n");
+			fprintf(fp, "\t\t\t\"Available\": %s,\n",
+				p->rdpmc_available ? "true" : "false");
+			fprintf(fp, "\t\t\t\"Enabled\": %s,\n",
+				p->can_user_rdpmc ? "true" : "false");
+			fprintf(fp, "\t\t\t\"Working\": %s",
+				p->rdpmc_works ? "true" : "false");
+			if (p->rdpmc_available && p->pmc_width > 0)
+				fprintf(fp, ",\n\t\t\t\"PmcWidth\": %u", p->pmc_width);
+			if (p->rdpmc_sysfs >= 0)
+				fprintf(fp, ",\n\t\t\t\"Sysfs\": %d", p->rdpmc_sysfs);
+			fprintf(fp, "\n\t\t}");
+
+			fprintf(fp, ",\n\t\t\"MaxGroupSize\": %d",
+				p->max_group_size);
+			fprintf(fp, ",\n\t\t\"MaxGroupSizeCapped\": %s",
+				p->max_group_capped ? "true" : "false");
+			fprintf(fp, ",\n\t\t\"MaxActiveGroupSize\": %d",
+				p->max_active_group_size);
+			fprintf(fp, ",\n\t\t\"MaxActiveGroupSizeCapped\": %s",
+				p->max_active_capped ? "true" : "false");
+			if (p->max_gp_group_size > 0) {
+				fprintf(fp, ",\n\t\t\"MaxGpGroupSize\": %d",
+					p->max_gp_group_size);
+				fprintf(fp, ",\n\t\t\"MaxActiveGpGroupSize\": %d",
+					p->max_active_gp_group_size);
+			}
+		} else {
+			json_escape_fprintf(fp, &buf, ",\n\t\t\"Error\": \"%S\"",
+					    strerror(p->open_err));
+		}
+		fprintf(fp, "\n\t}");
+	}
+
+	fprintf(fp, "\n}");
+	strbuf_release(&buf);
+}
+
+static void print_pmu_text(FILE *fp, const struct perf_pmu *pmu,
+			   const struct perf_session *session, bool show_all)
+{
+	size_t num_instances = show_all ? 1 : perf_pmu__num_duplicates(pmu);
+	char display_name[128];
+	const char *kind_sep = "";
+	size_t total_events;
+	struct print_format_state format_state = {
+		.fp = fp,
+		.buf = NULL,
+		.json = false,
+		.count = 0,
+	};
+
+	if (num_instances > 1) {
+		size_t base_len = pmu_name_len_no_suffix(pmu->name ?: "");
+
+		snprintf(display_name, sizeof(display_name), "%.*s",
+			 (int)base_len, pmu->name ?: "");
+	} else {
+		snprintf(display_name, sizeof(display_name), "%s", pmu->name ?: "");
+	}
+
+	color_fprintf(fp, PERF_COLOR_BOLD, "%s", display_name);
+	fprintf(fp, " (");
+	if (pmu->type != PERF_PMU_TYPE_FAKE) {
+		fprintf(fp, "type: %u [%s]", pmu->type, pmu_type_desc(pmu->type));
+		kind_sep = ", ";
+	}
+	if (pmu->is_core) {
+		fprintf(fp, "%s", kind_sep);
+		color_fprintf(fp, PERF_COLOR_GREEN, "core");
+		kind_sep = ", ";
+	}
+	if (pmu->is_uncore) {
+		fprintf(fp, "%s", kind_sep);
+		color_fprintf(fp, PERF_COLOR_CYAN, "uncore");
+		kind_sep = ", ";
+	}
+	if (perf_pmu__is_software(pmu)) {
+		fprintf(fp, "%s", kind_sep);
+		color_fprintf(fp, PERF_COLOR_BLUE, "software");
+		kind_sep = ", ";
+	}
+	if (pmu->auxtrace) {
+		fprintf(fp, "%s", kind_sep);
+		color_fprintf(fp, PERF_COLOR_MAGENTA, "auxtrace");
+		kind_sep = ", ";
+	}
+	if (pmu->selectable) {
+		fprintf(fp, "%sselectable", kind_sep);
+		kind_sep = ", ";
+	}
+	fprintf(fp, "):\n");
+
+	if (num_instances > 1 || (pmu->name && strcmp(pmu->name, display_name) != 0))
+		fprintf(fp, "  Instances: %zu (first: %s)\n", num_instances, pmu->name);
+	if (pmu->alias_name)
+		fprintf(fp, "  Alias: %s\n", pmu->alias_name);
+	if (pmu->id)
+		fprintf(fp, "  Identifier: %s\n", pmu->id);
+	if (pmu->cpus) {
+		char cpus_buf[256];
+		int nr_cpus = perf_cpu_map__nr(pmu->cpus);
+
+		cpu_map__snprint(pmu->cpus, cpus_buf, sizeof(cpus_buf));
+		if (cpus_buf[0]) {
+			if (nr_cpus > 0)
+				fprintf(fp, "  CPUs: %s (%d %s)\n",
+					cpus_buf, nr_cpus,
+					nr_cpus == 1 ? "CPU" : "CPUs");
+			else
+				fprintf(fp, "  CPUs: %s\n", cpus_buf);
+		}
+	}
+
+	perf_pmu__caps_parse((struct perf_pmu *)pmu);
+	if (!list_empty(&pmu->caps)) {
+		struct perf_pmu_caps *cap;
+		bool first = true;
+
+		fprintf(fp, "  Capabilities: ");
+		list_for_each_entry(cap, &pmu->caps, list) {
+			fprintf(fp, "%s%s=%s", first ? "" : ", ", cap->name, cap->value);
+			first = false;
+		}
+		fputc('\n', fp);
+	}
+
+	perf_pmu__for_each_format((struct perf_pmu *)pmu, &format_state, print_format_cb);
+	if (format_state.count > 0)
+		fputc('\n', fp);
+
+	total_events = perf_pmu__num_events((struct perf_pmu *)pmu);
+	if (total_events > 0) {
+		size_t sysfs_events = pmu->sysfs_aliases;
+		size_t json_events = total_events > sysfs_events ? total_events - sysfs_events : 0;
+
+		fprintf(fp, "  Events: %zu total (%zu sysfs, %zu json)\n",
+			total_events, sysfs_events, json_events);
+	}
+
+	print_mem_events_static(fp, NULL, pmu, /*json=*/false);
+	print_recorded_events(fp, NULL, pmu, session, show_all, /*json=*/false);
+
+	if (pmu->probed.checked) {
+		const typeof(pmu->probed) *p = &pmu->probed;
+
+		if (!p->open_supported) {
+			fprintf(fp, "  Probed capabilities: ");
+			if (p->open_err == EACCES && pmu->name &&
+			    !strcmp(pmu->name, "kprobe")) {
+				color_fprintf(fp, PERF_COLOR_YELLOW,
+					      "unavailable (%s; requires CAP_PERFMON or CAP_SYS_ADMIN)",
+					      strerror(p->open_err));
+			} else if (p->open_err == EACCES && pmu->name &&
+				   !strcmp(pmu->name, "uprobe")) {
+				color_fprintf(fp, PERF_COLOR_YELLOW,
+					      "unavailable (%s; requires CAP_SYS_ADMIN)",
+					      strerror(p->open_err));
+			} else {
+				color_fprintf(fp, PERF_COLOR_YELLOW, "unavailable (%s)",
+					      strerror(p->open_err));
+			}
+			fputc('\n', fp);
+		} else {
+			const char *sep = "";
+			const struct {
+				bool supported;
+				const char *name;
+			} excl[] = {
+				{ p->exclude_user,   "exclude_user" },
+				{ p->exclude_kernel, "exclude_kernel" },
+				{ p->exclude_hv,     "exclude_hv" },
+				{ p->exclude_idle,   "exclude_idle" },
+				{ p->exclude_host,   "exclude_host" },
+				{ p->exclude_guest,  "exclude_guest" },
+			};
+
+			fprintf(fp, "  Probed capabilities (event: ");
+			color_fprintf(fp, PERF_COLOR_CYAN, "%s",
+				      p->probe_event ?: "default");
+			fprintf(fp, "):\n");
+			fprintf(fp, "    Modes: ");
+			if (p->can_count) {
+				fprintf(fp, "%s", sep);
+				color_fprintf(fp, PERF_COLOR_GREEN, "counting");
+				sep = ", ";
+			}
+			if (p->can_sample) {
+				fprintf(fp, "%s", sep);
+				color_fprintf(fp, PERF_COLOR_GREEN, "sampling");
+				sep = ", ";
+			}
+			if (p->can_branch_stack) {
+				fprintf(fp, "%s", sep);
+				color_fprintf(fp, PERF_COLOR_GREEN, "branch_stack");
+				sep = ", ";
+			}
+			if (*sep == '\0')
+				color_fprintf(fp, PERF_COLOR_RED, "none");
+			fputc('\n', fp);
+
+			if (p->can_sample) {
+				if (!pmu->auxtrace) {
+					print_precise_levels(fp, pmu, p->precise_mask,
+							     p->max_precise, /*json=*/false);
+
+					print_measured_skid(fp, pmu, /*json=*/false);
+				}
+
+				fprintf(fp, "    Sample types: ");
+				print_sample_type_list(fp, p->sample_types, /*json=*/false);
+				fputc('\n', fp);
+			}
+
+			print_probed_regs(fp, NULL, "User registers",
+					  p->user_regs_mask, p->user_regs_abi,
+					  p->user_simd_mask, p->user_pred_mask,
+					  /*intr=*/false, /*json=*/false);
+			print_probed_regs(fp, NULL, "Intr registers",
+					  p->intr_regs_mask, p->intr_regs_abi,
+					  p->intr_simd_mask, p->intr_pred_mask,
+					  /*intr=*/true, /*json=*/false);
+
+			if (p->mem_events_mask) {
+				sep = "";
+				fprintf(fp, "    Memory events (probed): ");
+				for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+					struct perf_mem_event *e =
+						perf_pmu__mem_events_ptr((struct perf_pmu *)pmu, j);
+
+					if (e && e->tag && (p->mem_events_mask & (1u << j))) {
+						fprintf(fp, "%s%s", sep, e->tag);
+						sep = ", ";
+					}
+				}
+				if (p->mem_sample_types) {
+					fprintf(fp, " (sample types: ");
+					print_sample_type_list(fp, p->mem_sample_types,
+							       /*json=*/false);
+					fprintf(fp, ")");
+				}
+				fputc('\n', fp);
+			}
+
+			sep = "";
+			fprintf(fp, "    Exclusion modifiers: ");
+			for (size_t x = 0; x < ARRAY_SIZE(excl); x++) {
+				if (excl[x].supported) {
+					fprintf(fp, "%s%s", sep, excl[x].name);
+					sep = ", ";
+				}
+			}
+			if (*sep == '\0')
+				fprintf(fp, "none");
+			fputc('\n', fp);
+
+			{
+				const struct {
+					bool supported;
+					const char *name;
+				} feats[] = {
+					{ p->can_leader_sampling,  "leader_sampling" },
+					{ p->can_sw_grouping,      "sw_grouping" },
+					{ p->can_inherit,          "inherit" },
+					{ p->can_freq,             "sample_freq" },
+					{ p->can_write_backward,   "write_backward" },
+					{ p->can_callchain,        "callchain" },
+					{ p->can_data_src,         "data_src" },
+					{ p->can_weight,           "weight" },
+					{ p->can_pinned,           "pinned" },
+					{ p->can_exclusive,        "exclusive" },
+					{ p->can_format_lost,      "format_lost" },
+					{ p->can_acr,              "auto_counter_reload" },
+					{ p->can_aux_start_paused, "aux_start_paused" },
+					{ p->can_aux_pause,        "aux_pause" },
+					{ p->can_aux_resume,       "aux_resume" },
+					{ p->can_aux_sample,       "aux_sample" },
+					{ p->can_user_rdpmc,       "user_rdpmc" },
+					{ p->can_user_time,        "user_time" },
+					{ p->can_user_time_zero,   "user_time_zero" },
+					{ p->can_user_time_short,  "user_time_short" },
+				};
+
+				sep = "";
+				fprintf(fp, "    Features: ");
+				for (size_t x = 0; x < ARRAY_SIZE(feats); x++) {
+					if (feats[x].supported) {
+						fprintf(fp, "%s%s", sep, feats[x].name);
+						sep = ", ";
+					}
+				}
+				if (*sep == '\0')
+					fprintf(fp, "none");
+				fputc('\n', fp);
+			}
+
+			if (pmu->auxtrace) {
+				const struct {
+					bool supported;
+					const char *name;
+				} aux_acts[] = {
+					{ p->can_aux_start_paused, "aux_start_paused" },
+					{ p->can_aux_pause,        "aux_pause" },
+					{ p->can_aux_resume,       "aux_resume" },
+					{ p->can_aux_sample,       "aux_sample" },
+				};
+
+				sep = "";
+				fprintf(fp, "    AUX actions: ");
+				for (size_t x = 0; x < ARRAY_SIZE(aux_acts); x++) {
+					if (aux_acts[x].supported) {
+						fprintf(fp, "%s%s", sep, aux_acts[x].name);
+						sep = ", ";
+					}
+				}
+				if (*sep == '\0')
+					fprintf(fp, "none");
+				fputc('\n', fp);
+			}
+
+			if (pmu->is_core || p->rdpmc_available) {
+				fprintf(fp, "    User space counter reading (rdpmc): ");
+				if (!p->rdpmc_available) {
+					color_fprintf(fp, PERF_COLOR_RED, "not supported");
+					fputc('\n', fp);
+				} else {
+					color_fprintf(fp, PERF_COLOR_GREEN, "available");
+					fprintf(fp, ", ");
+					color_fprintf(fp,
+						      p->can_user_rdpmc ?
+						      PERF_COLOR_GREEN : PERF_COLOR_YELLOW,
+						      "%s",
+						      p->can_user_rdpmc ? "enabled" : "disabled");
+					if (p->rdpmc_sysfs >= 0)
+						fprintf(fp, " (sysfs: %d)", p->rdpmc_sysfs);
+					if (p->can_user_rdpmc) {
+						fprintf(fp, ", ");
+						color_fprintf(fp,
+							      p->rdpmc_works ?
+							      PERF_COLOR_GREEN : PERF_COLOR_RED,
+							      "%s",
+							      p->rdpmc_works ?
+							      "working" : "read failed");
+					}
+					if (p->pmc_width > 0)
+						fprintf(fp, " (width: %u bits)", p->pmc_width);
+					fputc('\n', fp);
+				}
+			}
+
+			fprintf(fp, "    Max event group size: %s%d (active: %s%d)\n",
+				p->max_group_capped ? ">=" : "",
+				p->max_group_size,
+				p->max_active_capped ? ">=" : "",
+				p->max_active_group_size);
+			if (p->max_gp_group_size > 0 &&
+			    (p->max_gp_group_size != p->max_group_size ||
+			     p->max_active_gp_group_size != p->max_active_group_size)) {
+				fprintf(fp, "    Max GP event group size: %s%d (active: %s%d)\n",
+					p->max_gp_group_capped ? ">=" : "",
+					p->max_gp_group_size,
+					p->max_active_gp_capped ? ">=" : "",
+					p->max_active_gp_group_size);
+			}
+		}
+	}
+}
+
+static int process_header_feature(const struct perf_tool *tool,
+				  struct perf_session *session,
+				  union perf_event *event)
+{
+	int ret = perf_event__process_feature(tool, session, event);
+
+	if (ret == 0 && event->header.size == sizeof(struct perf_record_header_feature) &&
+	    (int)event->feat.feat_id >= session->header.last_feat) {
+		session_done = 1;
+	}
+	return ret;
+}
+
+static int process_sample_stop(const struct perf_tool *tool __maybe_unused,
+			       union perf_event *event __maybe_unused,
+			       struct perf_sample *sample __maybe_unused,
+			       struct machine *machine __maybe_unused)
+{
+	session_done = 1;
+	return 0;
+}
+
+#define MAX_SUMMARY_METRICS 2048
+#define MAX_DRILLDOWN_LEVELS 16
+
+struct summary_metric_item {
+	char *pmu;
+	char *name;
+	char *groups;
+	int level;
+	bool has_children;
+	bool has_parent;
+};
+
+struct summary_metrics_state {
+	struct strlist *metrics;
+	struct strlist *groups;
+	struct summary_metric_item items[MAX_SUMMARY_METRICS];
+	size_t nr_items;
+};
+
+static bool group_list_has_token(const char *groups, const char *token)
+{
+	size_t tok_len;
+	const char *p;
+
+	if (!groups || !token || !*token)
+		return false;
+	tok_len = strlen(token);
+	p = groups;
+	while (*p) {
+		const char *semi = strchr(p, ';');
+		size_t len = semi ? (size_t)(semi - p) : strlen(p);
+
+		if (len == tok_len && !strncmp(p, token, len))
+			return true;
+		if (!semi)
+			break;
+		p = semi + 1;
+	}
+	return false;
+}
+
+static int collect_summary_metric_cb(const struct pmu_metric *pm,
+				     const struct pmu_metrics_table *table __maybe_unused,
+				     void *vdata)
+{
+	struct summary_metrics_state *st = vdata;
+
+	if (pm->metric_name)
+		strlist__add(st->metrics, pm->metric_name);
+
+	if (pm->metric_group) {
+		char *copy = strdup(pm->metric_group);
+		char *tok, *saveptr = NULL;
+
+		if (copy) {
+			for (tok = strtok_r(copy, ";", &saveptr); tok;
+			     tok = strtok_r(NULL, ";", &saveptr)) {
+				if (*tok)
+					strlist__add(st->groups, tok);
+			}
+			free(copy);
+		}
+	}
+
+	if (pm->metric_name) {
+		const char *pmu_name = pm->pmu ?: "cpu";
+		struct summary_metric_item *existing = NULL;
+
+		for (size_t i = 0; i < st->nr_items; i++) {
+			if (st->items[i].pmu && st->items[i].name &&
+			    !strcmp(st->items[i].pmu, pmu_name) &&
+			    !strcmp(st->items[i].name, pm->metric_name)) {
+				existing = &st->items[i];
+				break;
+			}
+		}
+		if (!existing && st->nr_items < MAX_SUMMARY_METRICS) {
+			existing = &st->items[st->nr_items++];
+			existing->pmu = strdup(pmu_name);
+			existing->name = strdup(pm->metric_name);
+			existing->groups = strdup(pm->metric_group ?: "");
+		} else if (existing && pm->metric_group && existing->groups &&
+			   !strstr(existing->groups, pm->metric_group)) {
+			char *merged = NULL;
+
+			if (asprintf(&merged, "%s;%s", existing->groups, pm->metric_group) > 0) {
+				free(existing->groups);
+				existing->groups = merged;
+			}
+		}
+	}
+	return 0;
+}
+
+static int compute_metric_drilldown(struct summary_metrics_state *st,
+				    int level_counts[MAX_DRILLDOWN_LEVELS],
+				    char *level_labels[MAX_DRILLDOWN_LEVELS])
+{
+	int max_level = 0;
+
+	memset(level_counts, 0, sizeof(int) * MAX_DRILLDOWN_LEVELS);
+	memset(level_labels, 0, sizeof(char *) * MAX_DRILLDOWN_LEVELS);
+
+	for (size_t i = 0; i < st->nr_items; i++) {
+		char child_grp[256];
+
+		if (!st->items[i].name || !st->items[i].pmu)
+			continue;
+		snprintf(child_grp, sizeof(child_grp), "%s_group", st->items[i].name);
+		if (!strlist__has_entry(st->groups, child_grp))
+			continue;
+
+		for (size_t j = 0; j < st->nr_items; j++) {
+			if (i == j || !st->items[j].groups || !st->items[j].pmu)
+				continue;
+			if (strcmp(st->items[i].pmu, st->items[j].pmu) != 0)
+				continue;
+			if (group_list_has_token(st->items[j].groups, child_grp)) {
+				st->items[i].has_children = true;
+				st->items[j].has_parent = true;
+			}
+		}
+	}
+
+	for (size_t i = 0; i < st->nr_items; i++) {
+		if (st->items[i].has_children && !st->items[i].has_parent) {
+			st->items[i].level = 1;
+			max_level = 1;
+		}
+	}
+
+	for (int d = 1; d < MAX_DRILLDOWN_LEVELS - 1; d++) {
+		bool progress = false;
+
+		for (size_t i = 0; i < st->nr_items; i++) {
+			char child_grp[256];
+
+			if (st->items[i].level != d || !st->items[i].has_children)
+				continue;
+			snprintf(child_grp, sizeof(child_grp), "%s_group", st->items[i].name);
+			for (size_t j = 0; j < st->nr_items; j++) {
+				if (i == j || !st->items[j].groups || !st->items[j].pmu)
+					continue;
+				if (strcmp(st->items[i].pmu, st->items[j].pmu) != 0)
+					continue;
+				if (group_list_has_token(st->items[j].groups, child_grp) &&
+				    st->items[j].level < d + 1) {
+					st->items[j].level = d + 1;
+					if (d + 1 > max_level)
+						max_level = d + 1;
+					progress = true;
+				}
+			}
+		}
+		if (!progress)
+			break;
+	}
+
+	for (int d = 1; d <= max_level; d++) {
+		struct str_node *pos;
+		const char *best_label = NULL;
+		int best_hits = 0;
+		int total_at_d = 0;
+
+		for (size_t i = 0; i < st->nr_items; i++) {
+			if (st->items[i].level == d)
+				total_at_d++;
+		}
+		level_counts[d] = total_at_d;
+
+		strlist__for_each_entry(pos, st->groups) {
+			const char *g = pos->s;
+			size_t glen = strlen(g);
+			int hits_in_d = 0;
+			bool in_other_d = false;
+
+			if (!strcasecmp(g, "Default") || !strcasecmp(g, "Summary") ||
+			    (glen > 6 && !strcmp(g + glen - 6, "_group")))
+				continue;
+
+			for (size_t i = 0; i < st->nr_items; i++) {
+				if (!st->items[i].groups || st->items[i].level == 0)
+					continue;
+				if (group_list_has_token(st->items[i].groups, g)) {
+					if (st->items[i].level == d)
+						hits_in_d++;
+					else
+						in_other_d = true;
+				}
+			}
+
+			if (!in_other_d &&
+			    (hits_in_d > best_hits ||
+			     (hits_in_d == best_hits && best_label &&
+			      strlen(g) > strlen(best_label)))) {
+				best_hits = hits_in_d;
+				best_label = g;
+			}
+		}
+
+		if (best_label && best_hits * 2 >= total_at_d)
+			level_labels[d] = strdup(best_label);
+	}
+
+	return max_level;
+}
+
+static bool is_mem_bw_pmu_name(const char *name)
+{
+	if (!name)
+		return false;
+	return strstarts(name, "uncore_imc") ||
+	       strstarts(name, "uncore_mc") ||
+	       strstarts(name, "uncore_edc") ||
+	       strstarts(name, "uncore_mchbm") ||
+	       strstarts(name, "amd_df") ||
+	       strstarts(name, "amd_umc") ||
+	       strstarts(name, "arm_dmc") ||
+	       strstarts(name, "dmc620") ||
+	       strstarts(name, "arm_cmn") ||
+	       strstr(name, "ddrc") != NULL ||
+	       strstr(name, "ddr") != NULL ||
+	       !strcmp(name, "hv_24x7") ||
+	       strstarts(name, "nest_mc");
+}
+
+static bool is_io_bw_pmu_name(const char *name)
+{
+	if (!name)
+		return false;
+	return strstarts(name, "uncore_iio") ||
+	       strstarts(name, "uncore_irp") ||
+	       strstarts(name, "uncore_pcie") ||
+	       strstarts(name, "uncore_upi") ||
+	       strstarts(name, "uncore_qpi") ||
+	       strstarts(name, "uncore_m2pcie") ||
+	       strstarts(name, "uncore_m3upi") ||
+	       strstarts(name, "uncore_arb") ||
+	       strstarts(name, "cxl") ||
+	       strstarts(name, "amd_iommu") ||
+	       strstarts(name, "amd_xgmi") ||
+	       strstarts(name, "arm_smmu") ||
+	       strstr(name, "pcie") != NULL ||
+	       strstarts(name, "dwc_rootport") ||
+	       strstarts(name, "cci") ||
+	       strstarts(name, "ccn");
+}
+
+static void print_strlist_color(FILE *fp, const char *color, struct strlist *list)
+{
+	struct str_node *pos;
+	bool first = true;
+
+	strlist__for_each_entry(pos, list) {
+		if (!first)
+			fprintf(fp, ", ");
+		color_fprintf(fp, color, "%s", pos->s);
+		first = false;
+	}
+}
+
+static void add_pmu_display_name(struct strlist *list, const struct perf_pmu *pmu)
+{
+	size_t num_inst = perf_pmu__num_duplicates(pmu);
+	char buf[128];
+
+	if (!pmu->name)
+		return;
+	if (num_inst > 1) {
+		size_t base_len = pmu_name_len_no_suffix(pmu->name);
+
+		snprintf(buf, sizeof(buf), "%.*s", (int)base_len, pmu->name);
+		strlist__add(list, buf);
+	} else {
+		strlist__add(list, pmu->name);
+	}
+}
+
+static void print_system_summary(FILE *fp, const struct perf_session *session,
+				 bool probed, bool leading_newline)
+{
+	const struct pmu_metrics_table *mtable;
+	struct perf_pmu *pmu = NULL;
+	struct strlist *core_pmus = strlist__new(NULL, NULL);
+	struct strlist *mem_bw_pmus = strlist__new(NULL, NULL);
+	struct strlist *io_bw_pmus = strlist__new(NULL, NULL);
+	struct strlist *aux_pmus = strlist__new(NULL, NULL);
+	struct strlist *missing = strlist__new(NULL, NULL);
+	struct summary_metrics_state *mstate = zalloc(sizeof(*mstate));
+	int level_counts[MAX_DRILLDOWN_LEVELS];
+	char *level_labels[MAX_DRILLDOWN_LEVELS];
+	int max_drill_lvl = 0;
+	bool has_sw_sampling = false;
+	bool core_can_sample = false;
+	bool core_precise = false;
+	int max_precise = 0;
+	bool core_rdpmc = false;
+	bool core_branch_stack = false;
+	int max_br_depth = 0;
+	bool core_mem_events = false;
+	bool core_leader_sampling = false;
+	size_t total_pmus = 0, total_events = 0, total_sysfs_events = 0, total_json_events = 0;
+	size_t nr_core, nr_metrics, nr_groups;
+
+	if (!mstate)
+		goto out_free;
+	mstate->metrics = strlist__new(NULL, NULL);
+	mstate->groups = strlist__new(NULL, NULL);
+
+	if (!core_pmus || !mem_bw_pmus || !io_bw_pmus || !aux_pmus ||
+	    !missing || !mstate->metrics || !mstate->groups)
+		goto out_free;
+
+	while ((pmu = perf_pmus__scan_skip_duplicates(pmu)) != NULL) {
+		size_t pmu_events = perf_pmu__num_events(pmu);
+		size_t sysfs_ev = pmu->sysfs_aliases;
+		size_t json_ev = pmu_events > sysfs_ev ? pmu_events - sysfs_ev : 0;
+
+		total_pmus++;
+		total_events += pmu_events;
+		total_sysfs_events += sysfs_ev;
+		total_json_events += json_ev;
+
+		if (pmu->is_core) {
+			struct perf_pmu_caps *br_cap;
+
+			add_pmu_display_name(core_pmus, pmu);
+			perf_pmu__caps_parse(pmu);
+			br_cap = perf_pmu__get_cap(pmu, "branches");
+			if (br_cap && br_cap->value) {
+				int depth = atoi(br_cap->value);
+
+				if (depth > max_br_depth)
+					max_br_depth = depth;
+			}
+			if (probed && pmu->probed.checked && pmu->probed.open_supported) {
+				if (pmu->probed.can_sample)
+					core_can_sample = true;
+				if (pmu->probed.max_precise > 0) {
+					core_precise = true;
+					if (pmu->probed.max_precise > max_precise)
+						max_precise = pmu->probed.max_precise;
+				}
+				if (pmu->probed.can_user_rdpmc)
+					core_rdpmc = true;
+				if (pmu->probed.can_branch_stack)
+					core_branch_stack = true;
+				if (pmu->probed.mem_events_mask)
+					core_mem_events = true;
+				if (pmu->probed.can_leader_sampling)
+					core_leader_sampling = true;
+			} else {
+				core_can_sample = true;
+				if (pmu->max_precise > 0) {
+					core_precise = true;
+					if (pmu->max_precise > max_precise)
+						max_precise = pmu->max_precise;
+				}
+				if (max_br_depth > 0)
+					core_branch_stack = true;
+				if (pmu->mem_events)
+					core_mem_events = true;
+			}
+		} else if (pmu->type == PERF_TYPE_SOFTWARE) {
+			if (!probed || !pmu->probed.checked || pmu->probed.can_sample)
+				has_sw_sampling = true;
+		}
+
+		if (pmu->auxtrace)
+			add_pmu_display_name(aux_pmus, pmu);
+		if (is_mem_bw_pmu_name(pmu->name))
+			add_pmu_display_name(mem_bw_pmus, pmu);
+		if (is_io_bw_pmu_name(pmu->name))
+			add_pmu_display_name(io_bw_pmus, pmu);
+	}
+
+	if (session && session->header.env.arch && session->header.env.cpuid)
+		mtable = find_core_metrics_table(session->header.env.arch,
+						 session->header.env.cpuid);
+	else
+		mtable = pmu_metrics_table__find();
+
+	metricgroup__for_each_metric(mtable, collect_summary_metric_cb, mstate);
+	max_drill_lvl = compute_metric_drilldown(mstate, level_counts, level_labels);
+
+	nr_core = strlist__nr_entries(core_pmus);
+	nr_metrics = strlist__nr_entries(mstate->metrics);
+	nr_groups = strlist__nr_entries(mstate->groups);
+
+	if (leading_newline)
+		fputc('\n', fp);
+	color_fprintf(fp, PERF_COLOR_BOLD, "Summary:");
+	fputc('\n', fp);
+	if (nr_core == 0) {
+		const char *sw_desc = has_sw_sampling ?
+			"minimal system; sampling only via software timer events" :
+			"no sampling support detected";
+
+		color_fprintf(fp, PERF_COLOR_BOLD, "  Core PMUs:");
+		fprintf(fp, " ");
+		color_fprintf(fp, PERF_COLOR_RED, "none");
+		fprintf(fp, " (%s)\n", sw_desc);
+		strlist__add(missing, "hardware core PMU");
+	} else {
+		color_fprintf(fp, PERF_COLOR_BOLD, "  Core PMUs (%zu%s):", nr_core,
+			      nr_core > 1 ? ", hybrid" : "");
+		fprintf(fp, " ");
+		print_strlist_color(fp, PERF_COLOR_GREEN, core_pmus);
+		fputc('\n', fp);
+
+		color_fprintf(fp, PERF_COLOR_BOLD, "  Core features:");
+		fputc('\n', fp);
+		fprintf(fp, "    Interrupt-based sampling: ");
+		color_fprintf(fp, core_can_sample ? PERF_COLOR_GREEN : PERF_COLOR_RED,
+			      "%s", core_can_sample ? "supported" : "missing");
+		fputc('\n', fp);
+		if (!core_can_sample)
+			strlist__add(missing, "core interrupt sampling");
+
+		fprintf(fp, "    Precise event sampling: ");
+		if (core_precise) {
+			color_fprintf(fp, PERF_COLOR_GREEN, "supported");
+			fprintf(fp, " (max_precise: %d [%s])\n",
+				max_precise, precise_level_desc(max_precise));
+		} else {
+			color_fprintf(fp, PERF_COLOR_RED, "missing");
+			fprintf(fp, " (%s)\n", precise_level_desc(0));
+			strlist__add(missing, "precise event sampling (PEBS/IBS/SPE)");
+		}
+
+		fprintf(fp, "    Branch stack sampling (LBR/BRBE): ");
+		if (core_branch_stack) {
+			color_fprintf(fp, PERF_COLOR_GREEN, "supported");
+			if (max_br_depth > 0)
+				fprintf(fp, " (depth: %d branches)\n", max_br_depth);
+			else
+				fputc('\n', fp);
+		} else {
+			color_fprintf(fp, PERF_COLOR_RED, "missing");
+			fputc('\n', fp);
+			strlist__add(missing, "hardware branch stack sampling (LBR/BRBE)");
+		}
+
+		if (probed) {
+			fprintf(fp, "    User-space counter reading (rdpmc): ");
+			color_fprintf(fp, core_rdpmc ? PERF_COLOR_GREEN : PERF_COLOR_YELLOW,
+				      "%s", core_rdpmc ? "supported" : "missing/disabled");
+			fputc('\n', fp);
+			if (!core_rdpmc)
+				strlist__add(missing, "user-space counter reading (rdpmc)");
+
+			fprintf(fp, "    Leader sampling: ");
+			color_fprintf(fp,
+				      core_leader_sampling ? PERF_COLOR_GREEN : PERF_COLOR_RED,
+				      "%s",
+				      core_leader_sampling ? "supported" : "missing");
+			fputc('\n', fp);
+		}
+
+		fprintf(fp, "    Memory profiling events (DATA_SRC): ");
+		color_fprintf(fp, core_mem_events ? PERF_COLOR_GREEN : PERF_COLOR_RED,
+			      "%s", core_mem_events ? "supported" : "missing");
+		fputc('\n', fp);
+		if (!core_mem_events)
+			strlist__add(missing, "memory load/store profiling events");
+
+		fprintf(fp, "    Hardware AUX trace PMUs: ");
+		if (!strlist__empty(aux_pmus)) {
+			print_strlist_color(fp, PERF_COLOR_GREEN, aux_pmus);
+			fputc('\n', fp);
+		} else {
+			color_fprintf(fp, PERF_COLOR_RED, "missing");
+			fputc('\n', fp);
+			strlist__add(missing, "hardware AUX trace PMU");
+		}
+	}
+
+	color_fprintf(fp, PERF_COLOR_BOLD, "  Bus & uncore monitoring:");
+	fputc('\n', fp);
+	fprintf(fp, "    Memory bandwidth PMUs: ");
+	if (!strlist__empty(mem_bw_pmus)) {
+		print_strlist_color(fp, PERF_COLOR_GREEN, mem_bw_pmus);
+		fputc('\n', fp);
+	} else {
+		color_fprintf(fp, PERF_COLOR_RED, "missing");
+		fputc('\n', fp);
+		strlist__add(missing, "memory bus bandwidth PMUs");
+	}
+
+	fprintf(fp, "    PCIe / IO interconnect bandwidth PMUs: ");
+	if (!strlist__empty(io_bw_pmus)) {
+		print_strlist_color(fp, PERF_COLOR_GREEN, io_bw_pmus);
+		fputc('\n', fp);
+	} else {
+		color_fprintf(fp, PERF_COLOR_RED, "missing");
+		fputc('\n', fp);
+		strlist__add(missing, "PCIe/IO interconnect bandwidth PMUs");
+	}
+
+	color_fprintf(fp, PERF_COLOR_BOLD, "  Events & metrics:");
+	fputc('\n', fp);
+	fprintf(fp, "    Available events: %zu total (%zu sysfs, %zu json) across %zu PMUs\n",
+		total_events, total_sysfs_events, total_json_events, total_pmus);
+	if (nr_metrics == 0) {
+		fprintf(fp, "    Available metrics: ");
+		color_fprintf(fp, PERF_COLOR_RED, "none");
+		fprintf(fp, " (missing JSON metrics)\n");
+		strlist__add(missing, "multi-level pipeline drill-down and JSON metrics");
+	} else {
+		const char *tier = (max_drill_lvl >= 2) ? "advanced" : "minimal";
+		const char *tier_col = (max_drill_lvl >= 2) ?
+				       PERF_COLOR_GREEN : PERF_COLOR_YELLOW;
+
+		fprintf(fp, "    Available metrics: %zu metrics in %zu groups (",
+			nr_metrics, nr_groups);
+		color_fprintf(fp, tier_col, "%s", tier);
+		fprintf(fp, ")\n");
+		if (max_drill_lvl > 0) {
+			fprintf(fp, "    Metric drill-down levels (%d): ", max_drill_lvl);
+			for (int d = 1; d <= max_drill_lvl; d++) {
+				if (d > 1)
+					fprintf(fp, ", ");
+				color_fprintf(fp, PERF_COLOR_CYAN, "L%d", d);
+				if (level_labels[d])
+					fprintf(fp, " (%s: %d metrics)",
+						level_labels[d], level_counts[d]);
+				else
+					fprintf(fp, " (%d metrics)", level_counts[d]);
+			}
+			fputc('\n', fp);
+		} else {
+			fprintf(fp, "    Metric drill-down levels: ");
+			color_fprintf(fp, PERF_COLOR_YELLOW, "none");
+			fprintf(fp, " (flat metrics only)\n");
+		}
+		if (max_drill_lvl < 2) {
+			strlist__add(missing,
+				     "multi-level pipeline drill-down metrics (<metric>_group)");
+		}
+	}
+
+	color_fprintf(fp, PERF_COLOR_BOLD, "  System rating:");
+	if (nr_core == 0) {
+		const char *min_desc =
+			"no hardware core PMU; profiling limited to software timer events";
+
+		fprintf(fp, " ");
+		color_fprintf(fp, PERF_COLOR_RED, "Minimal");
+		fprintf(fp, " (%s)\n", min_desc);
+	} else if (core_precise && core_branch_stack && (!probed || core_rdpmc) &&
+		   !strlist__empty(mem_bw_pmus) && max_drill_lvl >= 2) {
+		const char *core_adv = "precise sampling, branch stack (LBR), user rdpmc";
+		const char *sys_adv = "bus PMUs, and metric drill-down";
+
+		fprintf(fp, " ");
+		color_fprintf(fp, PERF_COLOR_GREEN, "Advanced");
+		fprintf(fp, " (core PMU with %s, %s)\n", core_adv, sys_adv);
+	} else if (core_can_sample &&
+		   (core_precise || core_branch_stack || max_drill_lvl >= 1)) {
+		const char *std_desc =
+			"core PMU with hardware sampling and partial advanced features or metrics";
+
+		fprintf(fp, " ");
+		color_fprintf(fp, PERF_COLOR_CYAN, "Standard");
+		fprintf(fp, " (%s)\n", std_desc);
+	} else {
+		const char *bas_desc =
+			"core PMU with basic counting/sampling only; missing advanced features";
+
+		fprintf(fp, " ");
+		color_fprintf(fp, PERF_COLOR_YELLOW, "Basic");
+		fprintf(fp, " (%s)\n", bas_desc);
+	}
+
+	if (!strlist__empty(missing)) {
+		color_fprintf(fp, PERF_COLOR_BOLD, "  Missing baseline features:");
+		fprintf(fp, " ");
+		print_strlist_color(fp, PERF_COLOR_RED, missing);
+		fputc('\n', fp);
+	}
+
+	for (int d = 1; d <= max_drill_lvl; d++)
+		free(level_labels[d]);
+
+out_free:
+	strlist__delete(core_pmus);
+	strlist__delete(mem_bw_pmus);
+	strlist__delete(io_bw_pmus);
+	strlist__delete(aux_pmus);
+	strlist__delete(missing);
+	if (mstate) {
+		for (size_t i = 0; i < mstate->nr_items; i++) {
+			free(mstate->items[i].pmu);
+			free(mstate->items[i].name);
+			free(mstate->items[i].groups);
+		}
+		strlist__delete(mstate->metrics);
+		strlist__delete(mstate->groups);
+		free(mstate);
+	}
+}
+
+int cmd_sysinfo(int argc, const char **argv)
+{
+	bool json = false;
+	bool show_pmus = false;
+	bool show_all = false;
+	bool force = false;
+	bool do_probe = true;
+	const char *output_path = NULL;
+	const char *input_name = NULL;
+	FILE *fp = stdout;
+	struct perf_data data = {
+		.mode = PERF_DATA_MODE_READ,
+	};
+	struct perf_tool tool;
+	struct perf_session *session = NULL;
+	struct perf_pmu *pmu = NULL;
+	size_t pmu_idx = 0;
+	int ret = 0;
+	const struct option sysinfo_options[] = {
+		OPT_STRING('i', "input", &input_name, "file",
+			   "Input perf.data file name to read PMUs from"),
+		OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
+		OPT_STRING('o', "output", &output_path, "file", "output file name"),
+		OPT_BOOLEAN('p', "pmus", &show_pmus,
+			    "Display detailed information for each PMU"),
+		OPT_BOOLEAN('j', "json", &json, "JSON encode PMU information"),
+		OPT_BOOLEAN('v', "verbose", &show_all,
+			    "Show all similar PMUs with alphanumeric suffixes"),
+		OPT_BOOLEAN('a', "all", &show_all,
+			    "Show all similar PMUs with alphanumeric suffixes"),
+		OPT_BOOLEAN(0, "probe", &do_probe,
+			    "Probe PMU capabilities on live system (default: on)"),
+		OPT_INCR(0, "debug", &verbose, "Enable debugging output"),
+		OPT_END()
+	};
+	const char * const sysinfo_usage[] = {
+		"perf sysinfo [<options>] [pmu_glob ...]",
+		NULL
+	};
+
+	argc = parse_options(argc, argv, sysinfo_options, sysinfo_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (show_all || json || argc > 0)
+		show_pmus = true;
+
+	if (output_path) {
+		perf_use_color_default = 0;
+		fp = fopen(output_path, "w");
+		if (!fp) {
+			pr_err("Failed to open output file '%s': %m\n", output_path);
+			return -1;
+		}
+	} else {
+		setup_pager();
+	}
+
+	if (input_name) {
+		data.path = input_name;
+		data.force = force;
+
+		perf_tool__init(&tool, /*ordered_events=*/false);
+		tool.attr = perf_event__process_attr;
+		tool.feature = process_header_feature;
+		tool.sample = process_sample_stop;
+
+		session = perf_session__new(&data, &tool);
+		if (IS_ERR(session)) {
+			ret = PTR_ERR(session);
+			pr_err("Error opening %s: %s\n", input_name, strerror(-ret));
+			goto out_close;
+		}
+
+		if (data.is_pipe)
+			perf_session__process_events(session);
+
+		ret = perf_pmus__read_from_env(&session->header.env);
+		if (ret) {
+			pr_err("Failed to read PMU information from %s: %s\n",
+			       input_name, strerror(-ret));
+			goto out_session;
+		}
+	}
+
+	if (json)
+		fputs("[", fp);
+
+	while ((pmu = show_all ? perf_pmus__scan(pmu) :
+				 perf_pmus__scan_skip_duplicates(pmu)) != NULL) {
+		if (!pmu_matches_filters(pmu, argc, argv))
+			continue;
+
+		if (do_probe && !input_name &&
+		    (show_pmus || pmu->is_core || pmu->type == PERF_TYPE_SOFTWARE))
+			perf_pmu__probe(pmu);
+
+		if (!show_pmus)
+			continue;
+
+		if (json) {
+			if (pmu_idx > 0)
+				fputs(",\n", fp);
+			else
+				fputs("\n", fp);
+			print_pmu_json(fp, pmu, session, show_all);
+		} else {
+			if (pmu_idx > 0)
+				fputc('\n', fp);
+			print_pmu_text(fp, pmu, session, show_all);
+		}
+		pmu_idx++;
+	}
+
+	if (json)
+		fputs(pmu_idx > 0 ? "\n]\n" : "]\n", fp);
+	else if (argc == 0)
+		print_system_summary(fp, session, do_probe && !input_name,
+				     pmu_idx > 0);
+
+out_session:
+	if (session)
+		perf_session__delete(session);
+out_close:
+	if (output_path && fp)
+		fclose(fp);
+	return ret;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index e0b430821abc..28e85c054468 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -37,6 +37,7 @@ int cmd_list(int argc, const char **argv);
 int cmd_record(int argc, const char **argv);
 int cmd_report(int argc, const char **argv);
 int cmd_stat(int argc, const char **argv);
+int cmd_sysinfo(int argc, const char **argv);
 int cmd_timechart(int argc, const char **argv);
 int cmd_top(int argc, const char **argv);
 int cmd_script(int argc, const char **argv);
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index d60bc929c257..a6fab1e6eb1c 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -112,6 +112,7 @@ static const struct cmd_struct commands[] = {
 	{ "report",	cmd_report,	0 },
 	{ "bench",	cmd_bench,	0 },
 	{ "stat",	cmd_stat,	0 },
+	{ "sysinfo",	cmd_sysinfo,	0 },
 	{ "timechart",	cmd_timechart,	0 },
 	{ "top",	cmd_top,	0 },
 	{ "annotate",	cmd_annotate,	0 },
diff --git a/tools/perf/tests/shell/sysinfo.sh b/tools/perf/tests/shell/sysinfo.sh
new file mode 100755
index 000000000000..40e90af6dca2
--- /dev/null
+++ b/tools/perf/tests/shell/sysinfo.sh
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf sysinfo tests
+
+set -e
+
+shelldir=$(dirname "$0")
+. "${shelldir}"/lib/setup_python.sh
+
+sysinfo_output=$(mktemp /tmp/__perf_test.sysinfo_output.XXXXX)
+perf_data=$(mktemp /tmp/__perf_test.sysinfo.perf.data.XXXXX)
+
+cleanup() {
+  rm -f "${sysinfo_output}" "${perf_data}" "${perf_data}.old"
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_sysinfo_default() {
+  echo "Default perf sysinfo output test"
+  perf sysinfo -o "${sysinfo_output}"
+  grep -q "^Summary:" "${sysinfo_output}"
+  grep -q "System rating:" "${sysinfo_output}"
+  perf sysinfo --pmus -o "${sysinfo_output}"
+  grep -q "^software (" "${sysinfo_output}"
+  grep -q "^Summary:" "${sysinfo_output}"
+  echo "Default perf sysinfo output test [Success]"
+}
+
+test_sysinfo_json() {
+  echo "Json perf sysinfo output test"
+  perf sysinfo -j -o "${sysinfo_output}"
+  $PYTHON -m json.tool "${sysinfo_output}" /dev/null
+  echo "Json perf sysinfo output test [Success]"
+}
+
+test_sysinfo_filter() {
+  echo "Filtered perf sysinfo output test"
+  perf sysinfo -o "${sysinfo_output}" software
+  grep -q "^software (" "${sysinfo_output}"
+  grep -q "Sample types:.*ip" "${sysinfo_output}"
+  grep -q "User registers:" "${sysinfo_output}"
+  grep -q "Intr registers:" "${sysinfo_output}"
+  grep -q "Features:.*leader_sampling" "${sysinfo_output}"
+  grep -q "Features:.*sw_grouping" "${sysinfo_output}"
+  echo "Filtered perf sysinfo output test [Success]"
+}
+
+test_sysinfo_perf_data() {
+  echo "perf.data perf sysinfo test"
+  perf record -e software/cpu-clock/u -o "${perf_data}" -- true 2>/dev/null
+  perf sysinfo -i "${perf_data}" -o "${sysinfo_output}"
+  grep -q "^Summary:" "${sysinfo_output}"
+  perf sysinfo --pmus -i "${perf_data}" -o "${sysinfo_output}"
+  grep -q "software" "${sysinfo_output}"
+  perf sysinfo -i "${perf_data}" -j -o "${sysinfo_output}"
+  $PYTHON -m json.tool "${sysinfo_output}" /dev/null
+  echo "perf.data perf sysinfo test [Success]"
+}
+
+test_sysinfo_default
+test_sysinfo_json
+test_sysinfo_filter
+test_sysinfo_perf_data
+cleanup
+exit 0
-- 
2.56.0.212.g129ede20d9-goog

