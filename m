From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/28] perf pmu: Move *_cpuid_str() weak functions to header.c
Date: Thu, 22 Nov 2018 00:36:11 -0300
Message-ID: <20181122033611.15890-29-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The weak functions, strcmp_cpuid_str() and get_cpuid_str(), are defined
in pmu.c.

Most of the cpuid related functions, including *_cpuid_str()'s
declaration and platform specific definition, are in header.c/h.

To make the declaration and definition of all cpuid related functions in
a consistent place, move the weak functions to header.c.

There is no functional change.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Link: http://lkml.kernel.org/r/20181121164939.13482-1-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 39 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c    | 39 ---------------------------------------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4fd45be95a43..e31f52845e77 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -987,6 +987,45 @@ static int write_group_desc(struct feat_fd *ff,
 	return 0;
 }
 
+/*
+ * Return the CPU id as a raw string.
+ *
+ * Each architecture should provide a more precise id string that
+ * can be use to match the architecture's "mapfile".
+ */
+char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
+{
+	return NULL;
+}
+
+/* Return zero when the cpuid from the mapfile.csv matches the
+ * cpuid string generated on this platform.
+ * Otherwise return non-zero.
+ */
+int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
+{
+	regex_t re;
+	regmatch_t pmatch[1];
+	int match;
+
+	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
+		/* Warn unable to generate match particular string. */
+		pr_info("Invalid regular expression %s\n", mapcpuid);
+		return 1;
+	}
+
+	match = !regexec(&re, cpuid, 1, pmatch, 0);
+	regfree(&re);
+	if (match) {
+		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
+
+		/* Verify the entire string matched. */
+		if (match_len == strlen(cpuid))
+			return 0;
+	}
+	return 1;
+}
+
 /*
  * default get_cpuid(): nothing gets recorded
  * actual implementation must be in arch/$(SRCARCH)/util/header.c
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c660625d7d4b..11a234740632 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -655,45 +655,6 @@ static int is_arm_pmu_core(const char *name)
 	return 0;
 }
 
-/*
- * Return the CPU id as a raw string.
- *
- * Each architecture should provide a more precise id string that
- * can be use to match the architecture's "mapfile".
- */
-char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
-{
-	return NULL;
-}
-
-/* Return zero when the cpuid from the mapfile.csv matches the
- * cpuid string generated on this platform.
- * Otherwise return non-zero.
- */
-int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
-{
-	regex_t re;
-	regmatch_t pmatch[1];
-	int match;
-
-	if (regcomp(&re, mapcpuid, REG_EXTENDED) != 0) {
-		/* Warn unable to generate match particular string. */
-		pr_info("Invalid regular expression %s\n", mapcpuid);
-		return 1;
-	}
-
-	match = !regexec(&re, cpuid, 1, pmatch, 0);
-	regfree(&re);
-	if (match) {
-		size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
-
-		/* Verify the entire string matched. */
-		if (match_len == strlen(cpuid))
-			return 0;
-	}
-	return 1;
-}
-
 static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 {
 	char *cpuid;
-- 
2.14.5
