From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/40] perf jevents: Make build fail on JSON parse error
Date: Wed, 26 Jul 2017 11:17:28 -0300
Message-ID: <20170726141730.30750-39-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Today, when a JSON file fails parsing the build continues, but there are
no json files built in, which is difficult to debug later.  Make the
build stop on a parse error instead.

v2: Add fixes from Sukadev. Now we handle architectures
    with no JSON events correctly. And fix some stale comments.

Committer note:

Tested by running the cross build container tests, that were all failing
for v1.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170725001638.19990-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/README    |  4 ----
 tools/perf/pmu-events/jevents.c | 21 ++++++++++++++-------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/README b/tools/perf/pmu-events/README
index 1408ade0d773..c2ee3e4417fe 100644
--- a/tools/perf/pmu-events/README
+++ b/tools/perf/pmu-events/README
@@ -85,10 +85,6 @@ users to specify events by their name:
 
 where 'pm_1plus_ppc_cmpl' is a Power8 PMU event.
 
-In case of errors when processing files in the tools/perf/pmu-events/arch
-directory, 'jevents' tries to create an empty mapping file to allow the perf
-build to succeed even if the PMU event aliases cannot be used.
-
 However some errors in processing may cause the perf build to fail.
 
 Mapfile format
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index bd0aabb2bd0f..2350f6099a46 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -822,10 +822,6 @@ static int process_one_file(const char *fpath, const struct stat *sb,
  * PMU event tables (see struct pmu_events_map).
  *
  * Write out the PMU events tables and the mapping table to pmu-event.c.
- *
- * If unable to process the JSON or arch files, create an empty mapping
- * table so we can continue to build/use  perf even if we cannot use the
- * PMU event aliases.
  */
 int main(int argc, char *argv[])
 {
@@ -836,6 +832,7 @@ int main(int argc, char *argv[])
 	const char *arch;
 	const char *output_file;
 	const char *start_dirname;
+	struct stat stbuf;
 
 	prog = basename(argv[0]);
 	if (argc < 4) {
@@ -857,11 +854,17 @@ int main(int argc, char *argv[])
 		return 2;
 	}
 
+	sprintf(ldirname, "%s/%s", start_dirname, arch);
+
+	/* If architecture does not have any event lists, bail out */
+	if (stat(ldirname, &stbuf) < 0) {
+		pr_info("%s: Arch %s has no PMU event lists\n", prog, arch);
+		goto empty_map;
+	}
+
 	/* Include pmu-events.h first */
 	fprintf(eventsfp, "#include \"../../pmu-events/pmu-events.h\"\n");
 
-	sprintf(ldirname, "%s/%s", start_dirname, arch);
-
 	/*
 	 * The mapfile allows multiple CPUids to point to the same JSON file,
 	 * so, not sure if there is a need for symlinks within the pmu-events
@@ -878,6 +881,9 @@ int main(int argc, char *argv[])
 	if (rc && verbose) {
 		pr_info("%s: Error walking file tree %s\n", prog, ldirname);
 		goto empty_map;
+	} else if (rc < 0) {
+		/* Make build fail */
+		return 1;
 	} else if (rc) {
 		goto empty_map;
 	}
@@ -892,7 +898,8 @@ int main(int argc, char *argv[])
 
 	if (process_mapfile(eventsfp, mapfile)) {
 		pr_info("%s: Error processing mapfile %s\n", prog, mapfile);
-		goto empty_map;
+		/* Make build fail */
+		return 1;
 	}
 
 	return 0;
-- 
2.9.4
