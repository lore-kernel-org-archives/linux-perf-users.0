From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 087/107] libperf: Adopt the readn()/writen() functions from tools/perf
Date: Mon, 29 Jul 2019 23:55:50 -0300
Message-ID: <20190730025610.22603-88-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the readn()/writen() functions into libperf.

Keep those non-namespaced names because they will be shared only between
perf and libperf.

Again, these are not exported functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-61-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build                  |  1 +
 tools/perf/lib/include/internal/lib.h | 10 ++++++
 tools/perf/lib/lib.c                  | 46 +++++++++++++++++++++++++++
 tools/perf/util/util.c                | 40 -----------------------
 tools/perf/util/util.h                |  4 +--
 5 files changed, 58 insertions(+), 43 deletions(-)
 create mode 100644 tools/perf/lib/include/internal/lib.h
 create mode 100644 tools/perf/lib/lib.c

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 4f78ec0b4e10..c31f1c111f8f 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -5,6 +5,7 @@ libperf-y += evsel.o
 libperf-y += evlist.o
 libperf-y += zalloc.o
 libperf-y += xyarray.o
+libperf-y += lib.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
new file mode 100644
index 000000000000..0b56f1201dc9
--- /dev/null
+++ b/tools/perf/lib/include/internal/lib.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_LIB_H
+#define __LIBPERF_INTERNAL_LIB_H
+
+#include <unistd.h>
+
+ssize_t readn(int fd, void *buf, size_t n);
+ssize_t writen(int fd, const void *buf, size_t n);
+
+#endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/lib/lib.c b/tools/perf/lib/lib.c
new file mode 100644
index 000000000000..2a81819c3b8c
--- /dev/null
+++ b/tools/perf/lib/lib.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <linux/kernel.h>
+#include <internal/lib.h>
+
+static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
+{
+	void *buf_start = buf;
+	size_t left = n;
+
+	while (left) {
+		/* buf must be treated as const if !is_read. */
+		ssize_t ret = is_read ? read(fd, buf, left) :
+					write(fd, buf, left);
+
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret <= 0)
+			return ret;
+
+		left -= ret;
+		buf  += ret;
+	}
+
+	BUG_ON((size_t)(buf - buf_start) != n);
+	return n;
+}
+
+/*
+ * Read exactly 'n' bytes or return an error.
+ */
+ssize_t readn(int fd, void *buf, size_t n)
+{
+	return ion(true, fd, buf, n);
+}
+
+/*
+ * Write exactly 'n' bytes or return an error.
+ */
+ssize_t writen(int fd, const void *buf, size_t n)
+{
+	/* ion does not modify buf. */
+	return ion(false, fd, (void *)buf, n);
+}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index a61535cf1bca..9c3c97697387 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -384,46 +384,6 @@ int copyfile(const char *from, const char *to)
 	return copyfile_mode(from, to, 0755);
 }
 
-static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
-{
-	void *buf_start = buf;
-	size_t left = n;
-
-	while (left) {
-		/* buf must be treated as const if !is_read. */
-		ssize_t ret = is_read ? read(fd, buf, left) :
-					write(fd, buf, left);
-
-		if (ret < 0 && errno == EINTR)
-			continue;
-		if (ret <= 0)
-			return ret;
-
-		left -= ret;
-		buf  += ret;
-	}
-
-	BUG_ON((size_t)(buf - buf_start) != n);
-	return n;
-}
-
-/*
- * Read exactly 'n' bytes or return an error.
- */
-ssize_t readn(int fd, void *buf, size_t n)
-{
-	return ion(true, fd, buf, n);
-}
-
-/*
- * Write exactly 'n' bytes or return an error.
- */
-ssize_t writen(int fd, const void *buf, size_t n)
-{
-	/* ion does not modify buf. */
-	return ion(false, fd, (void *)buf, n);
-}
-
 size_t hex_width(u64 v)
 {
 	size_t n = 1;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index dc7a469921e9..0dab140c6517 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -11,6 +11,7 @@
 #include <stddef.h>
 #include <linux/compiler.h>
 #include <sys/types.h>
+#include <internal/lib.h>
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
@@ -30,9 +31,6 @@ int copyfile_mode(const char *from, const char *to, mode_t mode);
 int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
 int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
 
-ssize_t readn(int fd, void *buf, size_t n);
-ssize_t writen(int fd, const void *buf, size_t n);
-
 size_t hex_width(u64 v);
 
 extern unsigned int page_size;
-- 
2.21.0
