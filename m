From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/41] tools lib api fs: Add filename__read_xll function
Date: Fri, 16 Feb 2018 16:17:08 -0300
Message-ID: <20180216191746.11095-4-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding filename__read_xll function to be able to read files with hex
numbers in, which do not have 0x prefix.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180206181813.10943-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/fs.c | 29 ++++++++++++++++++++++-------
 tools/lib/api/fs/fs.h |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index b24afc0e6e81..8b0e4a4315bd 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -315,12 +315,8 @@ int filename__read_int(const char *filename, int *value)
 	return err;
 }
 
-/*
- * Parses @value out of @filename with strtoull.
- * By using 0 for base, the strtoull detects the
- * base automatically (see man strtoull).
- */
-int filename__read_ull(const char *filename, unsigned long long *value)
+static int filename__read_ull_base(const char *filename,
+				   unsigned long long *value, int base)
 {
 	char line[64];
 	int fd = open(filename, O_RDONLY), err = -1;
@@ -329,7 +325,7 @@ int filename__read_ull(const char *filename, unsigned long long *value)
 		return -1;
 
 	if (read(fd, line, sizeof(line)) > 0) {
-		*value = strtoull(line, NULL, 0);
+		*value = strtoull(line, NULL, base);
 		if (*value != ULLONG_MAX)
 			err = 0;
 	}
@@ -338,6 +334,25 @@ int filename__read_ull(const char *filename, unsigned long long *value)
 	return err;
 }
 
+/*
+ * Parses @value out of @filename with strtoull.
+ * By using 16 for base to treat the number as hex.
+ */
+int filename__read_xll(const char *filename, unsigned long long *value)
+{
+	return filename__read_ull_base(filename, value, 16);
+}
+
+/*
+ * Parses @value out of @filename with strtoull.
+ * By using 0 for base, the strtoull detects the
+ * base automatically (see man strtoull).
+ */
+int filename__read_ull(const char *filename, unsigned long long *value)
+{
+	return filename__read_ull_base(filename, value, 0);
+}
+
 #define STRERR_BUFSIZE  128     /* For the buffer size of strerror_r */
 
 int filename__read_str(const char *filename, char **buf, size_t *sizep)
diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
index dda49deefb52..8ebee35a6395 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -30,6 +30,7 @@ FS(bpf_fs)
 
 int filename__read_int(const char *filename, int *value);
 int filename__read_ull(const char *filename, unsigned long long *value);
+int filename__read_xll(const char *filename, unsigned long long *value);
 int filename__read_str(const char *filename, char **buf, size_t *sizep);
 
 int filename__write_int(const char *filename, int value);
-- 
2.14.3
