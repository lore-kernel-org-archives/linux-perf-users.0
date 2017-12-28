From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/35] perf utils: Move is_directory() to path.h
Date: Thu, 28 Dec 2017 11:30:04 -0300
Message-ID: <20171228143027.30547-13-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that it can be used more widely, like in the next patch, when it will
be used to fix a bug in 'perf test' handling of dirent.d_type ==
DT_UNKNOWN.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171206174535.25380-1-jolsa@kernel.org
[ Split from a larger patch, removed needless includes in path.h ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 14 +-------------
 tools/perf/util/path.c      | 14 ++++++++++++++
 tools/perf/util/path.h      |  3 +++
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fac6f053e4da..77e47cf39f2c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -26,6 +26,7 @@
 #include "util/string2.h"
 #include "util/thread-stack.h"
 #include "util/time-utils.h"
+#include "util/path.h"
 #include "print_binary.h"
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
@@ -2401,19 +2402,6 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 	return rc;
 }
 
-/* Helper function for filesystems that return a dent->d_type DT_UNKNOWN */
-static int is_directory(const char *base_path, const struct dirent *dent)
-{
-	char path[PATH_MAX];
-	struct stat st;
-
-	sprintf(path, "%s/%s", base_path, dent->d_name);
-	if (stat(path, &st))
-		return 0;
-
-	return S_ISDIR(st.st_mode);
-}
-
 #define for_each_lang(scripts_path, scripts_dir, lang_dirent)		\
 	while ((lang_dirent = readdir(scripts_dir)) != NULL)		\
 		if ((lang_dirent->d_type == DT_DIR ||			\
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index 933f5c6bffb4..ca56ba2dd3da 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <dirent.h>
 #include <unistd.h>
 
 static char bad_path[] = "/bad-path/";
@@ -77,3 +78,16 @@ bool is_regular_file(const char *file)
 
 	return S_ISREG(st.st_mode);
 }
+
+/* Helper function for filesystems that return a dent->d_type DT_UNKNOWN */
+bool is_directory(const char *base_path, const struct dirent *dent)
+{
+	char path[PATH_MAX];
+	struct stat st;
+
+	sprintf(path, "%s/%s", base_path, dent->d_name);
+	if (stat(path, &st))
+		return false;
+
+	return S_ISDIR(st.st_mode);
+}
diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
index 14a254ada7eb..f014f905df50 100644
--- a/tools/perf/util/path.h
+++ b/tools/perf/util/path.h
@@ -2,9 +2,12 @@
 #ifndef _PERF_PATH_H
 #define _PERF_PATH_H
 
+struct dirent;
+
 int path__join(char *bf, size_t size, const char *path1, const char *path2);
 int path__join3(char *bf, size_t size, const char *path1, const char *path2, const char *path3);
 
 bool is_regular_file(const char *file);
+bool is_directory(const char *base_path, const struct dirent *dent);
 
 #endif /* _PERF_PATH_H */
-- 
2.13.6
