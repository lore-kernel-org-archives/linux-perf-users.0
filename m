From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/36] perf vendor events: Use more flexible pattern matching for CPU identification for mapfile.csv
Date: Wed,  6 Dec 2017 11:41:10 -0300
Message-ID: <20171206144115.15097-32-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, William Cohen <wcohen@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Shriya <shriyak@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: William Cohen <wcohen@redhat.com>

The powerpc cpuid information includes chip revision information.
Changes between chip revisions are usually minor bug fixes and usually
do not affect the operation of the performance monitoring hardware.

The original mapfile.csv matching requires enumerating every possible
cpuid string.  When a new minor chip revision is produced a new entry
has to be added to the mapfile.csv and the code recompiled to allow perf
to have the implementation specific perf events for this new minor
revision.  For users of various distibutions of Linux having to wait for
a new release of the kernel's perf tool to be built with these trivial
patches is inconvenient.

Using regular expressions rather than exactly string matching of the
entire cpuid string allows developers to write mapfile.csv files that do
not require patches and recompiles for each of these minor version
changes.  If special cases need to be made for some particular versions,
they can be placed earlier in the mapfile.csv file before the more
general matches.

Signed-off-by: William Cohen <wcohen@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shriya <shriyak@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20171204145728.16792-1-wcohen@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 12 ++------
 tools/perf/pmu-events/arch/x86/mapfile.csv     |  5 +---
 tools/perf/pmu-events/jevents.c                | 39 +++++++++++++++++++++++++-
 tools/perf/util/pmu.c                          | 20 ++++++++++++-
 4 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index a0f3a11ca19f..229150e7ab7d 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -13,13 +13,5 @@
 #
 
 # Power8 entries
-004b0000,1,power8,core
-004b0201,1,power8,core
-004c0000,1,power8,core
-004d0000,1,power8,core
-004d0100,1,power8,core
-004d0200,1,power8,core
-004c0100,1,power8,core
-004e0100,1,power9,core
-004e0200,1,power9,core
-004e1200,1,power9,core
+004[bcd][[:xdigit:]]{4},1,power8,core
+004e[[:xdigit:]]{4},1,power9,core
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index fe1a2c47cabf..93656f2fd53a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,10 +23,7 @@ GenuineIntel-6-1E,v2,nehalemep,core
 GenuineIntel-6-1F,v2,nehalemep,core
 GenuineIntel-6-1A,v2,nehalemep,core
 GenuineIntel-6-2E,v2,nehalemex,core
-GenuineIntel-6-4E,v24,skylake,core
-GenuineIntel-6-5E,v24,skylake,core
-GenuineIntel-6-8E,v24,skylake,core
-GenuineIntel-6-9E,v24,skylake,core
+GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-37,v13,silvermont,core
 GenuineIntel-6-4D,v13,silvermont,core
 GenuineIntel-6-4C,v13,silvermont,core
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9eb7047bafe4..b578aa26e375 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -116,6 +116,43 @@ static void fixdesc(char *s)
 		*e = 0;
 }
 
+/* Add escapes for '\' so they are proper C strings. */
+static char *fixregex(char *s)
+{
+	int len = 0;
+	int esc_count = 0;
+	char *fixed = NULL;
+	char *p, *q;
+
+	/* Count the number of '\' in string */
+	for (p = s; *p; p++) {
+		++len;
+		if (*p == '\\')
+			++esc_count;
+	}
+
+	if (esc_count == 0)
+		return s;
+
+	/* allocate space for a new string */
+	fixed = (char *) malloc(len + 1);
+	if (!fixed)
+		return NULL;
+
+	/* copy over the characters */
+	q = fixed;
+	for (p = s; *p; p++) {
+		if (*p == '\\') {
+			*q = '\\';
+			++q;
+		}
+		*q = *p;
+		++q;
+	}
+	*q = '\0';
+	return fixed;
+}
+
 static struct msrmap {
 	const char *num;
 	const char *pname;
@@ -648,7 +685,7 @@ static int process_mapfile(FILE *outfp, char *fpath)
 		}
 		line[strlen(line)-1] = '\0';
 
-		cpuid = strtok_r(p, ",", &save);
+		cpuid = fixregex(strtok_r(p, ",", &save));
 		version = strtok_r(NULL, ",", &save);
 		fname = strtok_r(NULL, ",", &save);
 		type = strtok_r(NULL, ",", &save);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8b7c151579c0..57e38fdf0b34 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -12,6 +12,7 @@
 #include <dirent.h>
 #include <api/fs/fs.h>
 #include <locale.h>
+#include <regex.h>
 #include "util.h"
 #include "pmu.h"
 #include "parse-events.h"
@@ -609,14 +610,31 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 
 	i = 0;
 	for (;;) {
+		regex_t re;
+		regmatch_t pmatch[1];
+		int match;
+
 		map = &pmu_events_map[i++];
 		if (!map->table) {
 			map = NULL;
 			break;
 		}
 
-		if (!strcmp(map->cpuid, cpuid))
+		if (regcomp(&re, map->cpuid, REG_EXTENDED) != 0) {
+			/* Warn unable to generate match particular string. */
+			pr_info("Invalid regular expression %s\n", map->cpuid);
 			break;
+		}
+
+		match = !regexec(&re, cpuid, 1, pmatch, 0);
+		regfree(&re);
+		if (match) {
+			size_t match_len = (pmatch[0].rm_eo - pmatch[0].rm_so);
+
+			/* Verify the entire string matched. */
+			if (match_len == strlen(cpuid))
+				break;
+		}
 	}
 	free(cpuid);
 	return map;
-- 
2.13.6
