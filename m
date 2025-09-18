Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3C2BDC2C;
	Thu, 18 Sep 2025 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177591; cv=none; b=nrTeFZHdCw660Gr6cXcsP9XAKK5QsKPeq6jSZHBFXrEyqCOJ/1MwiDZcnCakBETZ8AKv7H7lkALxMnI+JkyDxstpKHB3/N5o4diRh/9fqkyVLmLZFkzXAfGaflIGjMqMbaKXhxgU0Exr+Jv7n/3dxajqgCvVcRVIO1we4CnGR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177591; c=relaxed/simple;
	bh=4DQkGOOckYLwdUKezTAXLB30+ESsG6GgcdF/9uBmevo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAEzEdBD9+2gOvWuPy9j3l+uxca6bup0lO03U4abyok9j3XsO8ONQVjDX3WV7DJ3w5tHAl66NsbbTvKri3mqd3/iviYEKCL9f0m+zhLo3b/KFRsEut+E8l05YrMr7mhilhLAl8388P+suZvOLIIYC7J9Riy0g04j564gTeaNRfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnIbLJcD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnIbLJcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC76C4CEF1;
	Thu, 18 Sep 2025 06:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758177590;
	bh=4DQkGOOckYLwdUKezTAXLB30+ESsG6GgcdF/9uBmevo=;
	h=From:To:Cc:Subject:Date:From;
	b=EnIbLJcDtLn48gSvMfqtwrwlviPz02wCmwJyIphKrDj0uOnPQ4St+dRSAF3OWkV3F
	 hrC2F8/Tdrv8C0a+sET/c2HqQsKFIoHRF+HwM0uH+YZRHCmiptW52eWFUwsFVamnxN
	 aePVzhCiHSou0EuZ1zqoMc36d/n46J78P6hvC/uGTB0t2E1MqhpF5aSvNeR5JOvyXn
	 tBhy6DdJCdflOhNSmn/NzQofVl2OqdOg/C21Lwm2HGqXA1uwIOLehLgeoiL9aPNp2/
	 OUo8ZEYlXAVp8lvyOtJ4Zdvd1W3jrdfW1jLNs8PwucP0rdbPbLniXmDEABzEh1S5fr
	 +zf/ayo982ajw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [RFC/PATCH 1/2] perf check: Add 'system' subcommand
Date: Wed, 17 Sep 2025 23:39:43 -0700
Message-ID: <20250918063944.16331-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'perf check system' is to check sysctl settings related to perf.
By default it'd print the following output.

  $ perf check system
  perf_event_paranoid  = 2	# non-root can profile user code only
  perf_event_max_stack = 127	# maximum callchain length
  perf_event_mlock_kb  = 516	# maximum ring buffer size (including a header page) for non-root
  nmi_watchdog         = 1	# a hardware PMU counter may be used by the kernel
  kptr_restrict        = 0	# kernel pointers are printed as-is

The -q option suppresses the description.  It can also take command line
argument to match specific items.

  $ perf check system -q nmi
  nmi_watchdog         = 1

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-check.txt |  20 ++++
 tools/perf/builtin-check.c              | 116 +++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index ee92042082f73121..34dccc29d90d2fdf 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'perf check' [<options>]
 'perf check' {feature <feature_list>} [<options>]
+'perf check' {system <setting_list>} [<options>]
 
 DESCRIPTION
 -----------
@@ -22,6 +23,9 @@ compiled-in/built-in or not.
 Also, 'perf check feature' returns with exit status 0 if the feature
 is built-in, otherwise returns with exit status 1.
 
+If the subcommand 'system' is used, then system settins are printed on
+the standard output with explanation.
+
 SUBCOMMANDS
 -----------
 
@@ -69,6 +73,22 @@ SUBCOMMANDS
                 zlib                    /  HAVE_ZLIB_SUPPORT
                 zstd                    /  HAVE_ZSTD_SUPPORT
 
+system::
+
+	Print system settings (sysctl) that affect perf behaviors.
+
+	Example Usage:
+		perf check system
+		perf check system watchdog
+
+	Supported settings:
+		perf_event_paranoid
+		perf_event_max_stack
+		perf_event_mlock_kb
+		nmi_watchdog
+		kptr_restrict
+
+
 OPTIONS
 -------
 -q::
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index b1e205871ab17a77..1c7c6bb5da5ccbf2 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -3,24 +3,30 @@
 #include "color.h"
 #include "util/debug.h"
 #include "util/header.h"
+#include <api/fs/fs.h>
 #include <tools/config.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
 #include <subcmd/parse-options.h>
 
-static const char * const check_subcommands[] = { "feature", NULL };
+static const char * const check_subcommands[] = { "feature", "system", NULL };
 static struct option check_options[] = {
 	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
 	OPT_END()
 };
 static struct option check_feature_options[] = { OPT_PARENT(check_options) };
+static struct option check_system_options[] = { OPT_PARENT(check_options) };
 
 static const char *check_usage[] = { NULL, NULL };
 static const char *check_feature_usage[] = {
 	"perf check feature <feature_list>",
 	NULL
 };
+static const char *check_system_usage[] = {
+	"perf check system",
+	NULL
+};
 
 #define FEATURE_STATUS(name_, macro_) {    \
 	.name = name_,                     \
@@ -166,6 +172,112 @@ static int subcommand_feature(int argc, const char **argv)
 	return !feature_enabled;
 }
 
+static int read_sysctl_kernel_int(const char *name)
+{
+	char path[128];
+	int value;
+
+	scnprintf(path, sizeof(path), "kernel/%s", name);
+	if (sysctl__read_int(path, &value))
+		return INT_MAX;
+
+	return value;
+}
+
+static const char *system_help_perf_event_paranoid(int value)
+{
+	if (value == 2)
+		return "non-root can profile user code only";
+	if (value == 1)
+		return "non-root can profile kernel and user code";
+	if (value == 0)
+		return "non-root can profile system-wide w/o tracepoints data";
+	if (value < 0)
+		return "no restrictions";
+
+	return "non-root cannot use perf event";
+}
+
+static const char *system_help_perf_event_max_stack(int value __maybe_unused)
+{
+	return "maximum callchain length";
+}
+
+static const char *system_help_perf_event_mlock_kb(int value __maybe_unused)
+{
+	return "maximum ring buffer size (including a header page) for non-root";
+}
+
+static const char *system_help_nmi_watchdog(int value)
+{
+	if (value)
+		return "a hardware PMU counter may be used by the kernel";
+
+	return "perf can use full PMU counters";
+}
+
+static const char *system_help_kptr_restrict(int value)
+{
+	if (value == 0)
+		return "kernel pointers are printed as-is";
+	if (value == 1)
+		return "non-root cannot see the kernel pointers";
+	if (value == 2)
+		return "root may not see some kernel pointers";
+
+	return "unknown value";
+}
+
+/**
+ * Usage: 'perf check system <settings>'
+ *
+ * Show system settings that affect perf behavior.
+ */
+static int subcommand_system(int argc, const char **argv)
+{
+#define PERF_SYSCTL(name) { #name, system_help_##name }
+	struct {
+		const char *name;
+		const char *(*help)(int value);
+	} sysctls[] = {
+		PERF_SYSCTL(perf_event_paranoid),
+		PERF_SYSCTL(perf_event_max_stack),
+		PERF_SYSCTL(perf_event_mlock_kb),
+		PERF_SYSCTL(nmi_watchdog),
+		PERF_SYSCTL(kptr_restrict),
+	};
+#undef PERF_SYSCTL
+
+	argc = parse_options(argc, argv, check_system_options,
+			     check_system_usage, 0);
+
+	for (size_t i = 0; i < ARRAY_SIZE(sysctls); i++) {
+		int value;
+
+		if (argc) {
+			bool found = false;
+
+			/* only show entries match to command line arguments */
+			for (int k = 0; k < argc; k++) {
+				if (strstr(sysctls[i].name, argv[k])) {
+					found = true;
+					break;
+				}
+			}
+			if (!found)
+				continue;
+		}
+
+		value = read_sysctl_kernel_int(sysctls[i].name);
+		printf("%-20s = %d", sysctls[i].name, value);
+		if (!quiet)
+			printf("\t# %s", sysctls[i].help(value));
+		printf("\n");
+	}
+
+	return 0;
+}
+
 int cmd_check(int argc, const char **argv)
 {
 	argc = parse_options_subcommand(argc, argv, check_options,
@@ -176,6 +288,8 @@ int cmd_check(int argc, const char **argv)
 
 	if (strcmp(argv[0], "feature") == 0)
 		return subcommand_feature(argc, argv);
+	if (strcmp(argv[0], "system") == 0)
+		return subcommand_system(argc, argv);
 
 	/* If no subcommand matched above, print usage help */
 	pr_err("Unknown subcommand: %s\n", argv[0]);
-- 
2.51.0

