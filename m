From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/16] perf tools: Make find_vdso_map() more modular
Date: Tue,  8 Jan 2019 16:58:57 -0300
Message-ID: <20190108195910.17726-4-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Chris Healy <cphealy@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kim Phillips <kim.phillips@arm.com>, Lucas Stach <l.stach@pengutronix.de>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Russell King <rmk+kernel@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

In preparation for checking that the vectors page on the ARM
architecture, refactor the find_vdso_map() function to accept finding an
arbitrary string and create a dedicated helper function for that under
util/find-map.c and update the filename to find-map.c and all references
to it: perf-read-vdso.c and util/vdso.c.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20181221034337.26663-2-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                        | 4 ++--
 tools/perf/perf-read-vdso.c                     | 6 +++---
 tools/perf/util/{find-vdso-map.c => find-map.c} | 7 +++----
 tools/perf/util/vdso.c                          | 6 +++---
 4 files changed, 11 insertions(+), 12 deletions(-)
 rename tools/perf/util/{find-vdso-map.c => find-map.c} (71%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2921f829a0f4..0ee6795d82cc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -662,12 +662,12 @@ $(OUTPUT)perf-%: %.o $(PERFLIBS)
 	$(QUIET_LINK)$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 ifndef NO_PERF_READ_VDSO32
-$(OUTPUT)perf-read-vdso32: perf-read-vdso.c util/find-vdso-map.c
+$(OUTPUT)perf-read-vdso32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -m32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
 ifndef NO_PERF_READ_VDSOX32
-$(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-vdso-map.c
+$(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
 	$(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
 endif
 
diff --git a/tools/perf/perf-read-vdso.c b/tools/perf/perf-read-vdso.c
index 8c0ca0cc428f..aaa5210ea84a 100644
--- a/tools/perf/perf-read-vdso.c
+++ b/tools/perf/perf-read-vdso.c
@@ -5,17 +5,17 @@
 #define VDSO__MAP_NAME "[vdso]"
 
 /*
- * Include definition of find_vdso_map() also used in util/vdso.c for
+ * Include definition of find_map() also used in util/vdso.c for
  * building perf.
  */
-#include "util/find-vdso-map.c"
+#include "util/find-map.c"
 
 int main(void)
 {
 	void *start, *end;
 	size_t size, written;
 
-	if (find_vdso_map(&start, &end))
+	if (find_map(&start, &end, VDSO__MAP_NAME))
 		return 1;
 
 	size = end - start;
diff --git a/tools/perf/util/find-vdso-map.c b/tools/perf/util/find-map.c
similarity index 71%
rename from tools/perf/util/find-vdso-map.c
rename to tools/perf/util/find-map.c
index d7823e3508fc..7b2300588ece 100644
--- a/tools/perf/util/find-vdso-map.c
+++ b/tools/perf/util/find-map.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-static int find_vdso_map(void **start, void **end)
+static int find_map(void **start, void **end, const char *name)
 {
 	FILE *maps;
 	char line[128];
@@ -7,7 +7,7 @@ static int find_vdso_map(void **start, void **end)
 
 	maps = fopen("/proc/self/maps", "r");
 	if (!maps) {
-		fprintf(stderr, "vdso: cannot open maps\n");
+		fprintf(stderr, "cannot open maps\n");
 		return -1;
 	}
 
@@ -21,8 +21,7 @@ static int find_vdso_map(void **start, void **end)
 		if (m < 0)
 			continue;
 
-		if (!strncmp(&line[m], VDSO__MAP_NAME,
-			     sizeof(VDSO__MAP_NAME) - 1))
+		if (!strncmp(&line[m], name, strlen(name)))
 			found = 1;
 	}
 
diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
index 741af209b19d..3702cba11d7d 100644
--- a/tools/perf/util/vdso.c
+++ b/tools/perf/util/vdso.c
@@ -18,10 +18,10 @@
 #include "debug.h"
 
 /*
- * Include definition of find_vdso_map() also used in perf-read-vdso.c for
+ * Include definition of find_map() also used in perf-read-vdso.c for
  * building perf-read-vdso32 and perf-read-vdsox32.
  */
-#include "find-vdso-map.c"
+#include "find-map.c"
 
 #define VDSO__TEMP_FILE_NAME "/tmp/perf-vdso.so-XXXXXX"
 
@@ -76,7 +76,7 @@ static char *get_file(struct vdso_file *vdso_file)
 	if (vdso_file->found)
 		return vdso_file->temp_file_name;
 
-	if (vdso_file->error || find_vdso_map(&start, &end))
+	if (vdso_file->error || find_map(&start, &end, VDSO__MAP_NAME))
 		return NULL;
 
 	size = end - start;
-- 
2.20.1
