Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABE1E51E0;
	Thu, 18 Sep 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177591; cv=none; b=mOatxCjWZrg0ILWzcY/vZjtcA9AbSF+XdiyRZb9twMvRSLv+hdZE23KBUAVMjUjMRevbrxsacfTWK2AzT4+iWhwKfI4K4nrsFIh+GMetoppvrNVtGqY8zLru5OQuyypYx4OpmgDVUY1YO34C/zpIQDOYR9oPAvqv1q54DZ7Wvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177591; c=relaxed/simple;
	bh=Uo6TpJxLrR0uiCTBNZ9+x7tXF/6TELe+Ig8+Aha82gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDjOyptTF0nE5KIPI7DyWk8oIgAKiJi/gWUDo25RoGoESmBFCmL/EkV5ELP52red6ICR796xHSf/klMORsNNfZ0Ez/KnhwKf5WgJOZdm16/Aigc9QnWwDLsCyntl9iyIUe4xV8LLnwMJ7Fat9p64j6CAB5KZB667Efsc1MpWMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMNuRUEw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMNuRUEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF5BC4CEE7;
	Thu, 18 Sep 2025 06:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758177591;
	bh=Uo6TpJxLrR0uiCTBNZ9+x7tXF/6TELe+Ig8+Aha82gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMNuRUEwQsdYkjiFceeOvKLRKlMz13EYJQBJCd81jo9DS4p+uUsKMnZ+UNr30faEN
	 vFLvGPFc5dc5AnrYMVvmEqiYPJg7amnaZfWurpsV6VeBi6HbqJI5lNTRpceoVKK7Cr
	 JyHc2n+h7YoHdNo/4iLvN/cnAqP3fkQh8w6XxUMhQki77nRplISej1LkWgQz7RvCTq
	 P4JUPWozDLVcAD1E0dCETFk6Xq9b6LSX/rt7USAYCd1ZwXE2ukJG0qoMKdUSo1tAu8
	 t9MWlfNtoa5hiWgT00Vy3Bid4ZyFUwTZxrAKrFH/k4BoObDOj8aPM0LEM6JmgxxJsp
	 v56INXAoMdSbw==
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
Subject: [RFC/PATCH 2/2] perf check: Add 'pmu' subcommand
Date: Wed, 17 Sep 2025 23:39:44 -0700
Message-ID: <20250918063944.16331-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918063944.16331-1-namhyung@kernel.org>
References: <20250918063944.16331-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'perf check pmu' command will show information about PMUs in the
system like below:

  $ perf check pmu | head
  cpu_atom: type = 10
    core PMU: cpus = 16-27
    caps: branches = 32
    caps: max_precise = 3
    caps: pmu_name = alderlake_hybrid
  cpu_core: type = 4
    core PMU: cpus = 0-15
    caps: branches = 32
    caps: max_precise = 3
    caps: pmu_name = alderlake_hybrid

The -q option will make it print the name and type of PMUs only.  It
also takes arguments to show matching PMUs only.

  $ perf check pmu -q uncore
  uncore_arb_0: type = 27
  uncore_arb_1: type = 28
  uncore_cbox_0: type = 15
  uncore_cbox_1: type = 16
  uncore_cbox_2: type = 17
  uncore_cbox_3: type = 18
  uncore_cbox_4: type = 19
  uncore_cbox_5: type = 20
  uncore_cbox_6: type = 21
  uncore_cbox_7: type = 22
  uncore_cbox_8: type = 23
  uncore_cbox_9: type = 24
  uncore_cbox_10: type = 25
  uncore_cbox_11: type = 26
  uncore_clock: type = 29
  uncore_imc_free_running_0: type = 32
  uncore_imc_free_running_1: type = 33
  uncore_imc_0: type = 30
  uncore_imc_1: type = 31

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-check.txt | 12 +++++
 tools/perf/builtin-check.c              | 60 ++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 34dccc29d90d2fdf..2fa007698c0f0814 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'perf check' [<options>]
 'perf check' {feature <feature_list>} [<options>]
 'perf check' {system <setting_list>} [<options>]
+'perf check' {pmu <name_list>} [<options>]
 
 DESCRIPTION
 -----------
@@ -26,6 +27,9 @@ is built-in, otherwise returns with exit status 1.
 If the subcommand 'system' is used, then system settins are printed on
 the standard output with explanation.
 
+If the subcommand 'pmu' is used, then available PMU information is printed
+on the standard output with explanation.
+
 SUBCOMMANDS
 -----------
 
@@ -88,6 +92,14 @@ SUBCOMMANDS
 		nmi_watchdog
 		kptr_restrict
 
+pmu::
+
+	Print PMU information available in the system.
+
+	Example Usage:
+		perf check pmu
+		perf check pmu <name>
+
 
 OPTIONS
 -------
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 1c7c6bb5da5ccbf2..f3d034a94b1227c7 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -3,6 +3,8 @@
 #include "color.h"
 #include "util/debug.h"
 #include "util/header.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include <api/fs/fs.h>
 #include <tools/config.h>
 #include <stdbool.h>
@@ -10,13 +12,14 @@
 #include <string.h>
 #include <subcmd/parse-options.h>
 
-static const char * const check_subcommands[] = { "feature", "system", NULL };
+static const char * const check_subcommands[] = { "feature", "system", "pmu", NULL };
 static struct option check_options[] = {
 	OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or messages"),
 	OPT_END()
 };
 static struct option check_feature_options[] = { OPT_PARENT(check_options) };
 static struct option check_system_options[] = { OPT_PARENT(check_options) };
+static struct option check_pmu_options[] = { OPT_PARENT(check_options) };
 
 static const char *check_usage[] = { NULL, NULL };
 static const char *check_feature_usage[] = {
@@ -27,6 +30,10 @@ static const char *check_system_usage[] = {
 	"perf check system",
 	NULL
 };
+static const char *check_pmu_usage[] = {
+	"perf check pmu",
+	NULL
+};
 
 #define FEATURE_STATUS(name_, macro_) {    \
 	.name = name_,                     \
@@ -278,6 +285,55 @@ static int subcommand_system(int argc, const char **argv)
 	return 0;
 }
 
+/**
+ * Usage: 'perf check pmu <names>'
+ *
+ * Show PMU information.
+ */
+static int subcommand_pmu(int argc, const char **argv)
+{
+	struct perf_pmu *pmu = NULL;
+	struct perf_pmu_caps *caps;
+
+	argc = parse_options(argc, argv, check_pmu_options, check_pmu_usage, 0);
+
+	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+		if (argc) {
+			bool found = false;
+
+			/* only show entries match to command line arguments */
+			for (int k = 0; k < argc; k++) {
+				if (strstr(pmu->name, argv[k])) {
+					found = true;
+					break;
+				}
+			}
+			if (!found)
+				continue;
+		}
+
+		printf("%s: type = %u\n", pmu->name, pmu->type);
+		if (quiet)
+			continue;
+
+		if (pmu->is_core || pmu->is_uncore) {
+			printf("  %score PMU", pmu->is_uncore ? "un" : "");
+			if (!perf_cpu_map__is_empty(pmu->cpus)) {
+				printf(": %s = ", pmu->is_core ? "cpus" : "cpumask");
+				cpu_map__fprintf(pmu->cpus, stdout);
+			} else {
+				printf("\n");
+			}
+		}
+
+		perf_pmu__caps_parse(pmu);
+		list_for_each_entry(caps, &pmu->caps, list) {
+			printf("  caps: %s = %s\n", caps->name, caps->value);
+		}
+	}
+	return 0;
+}
+
 int cmd_check(int argc, const char **argv)
 {
 	argc = parse_options_subcommand(argc, argv, check_options,
@@ -290,6 +346,8 @@ int cmd_check(int argc, const char **argv)
 		return subcommand_feature(argc, argv);
 	if (strcmp(argv[0], "system") == 0)
 		return subcommand_system(argc, argv);
+	if (strcmp(argv[0], "pmu") == 0)
+		return subcommand_pmu(argc, argv);
 
 	/* If no subcommand matched above, print usage help */
 	pr_err("Unknown subcommand: %s\n", argv[0]);
-- 
2.51.0

