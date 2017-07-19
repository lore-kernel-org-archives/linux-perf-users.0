From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 56/86] perf trace beauty: Export strarray for use in per-object beautifiers
Date: Wed, 19 Jul 2017 11:29:20 -0300
Message-ID: <20170719142950.3747-57-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Like will be done with fcntl(fd, F_GETLEASE, F_RDLCK|F_WRLCK|F_UNLCK)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-3p11bgirtntjfmbixfkz8i2m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 27 +++++++--------------------
 tools/perf/trace/beauty/beauty.h | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 65fa0126e939..0dedce0ca0bb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -283,34 +283,21 @@ static struct perf_evsel *perf_evsel__syscall_newtp(const char *direction, void
 	({ struct syscall_tp *fields = evsel->priv; \
 	   fields->name.pointer(&fields->name, sample); })
 
-struct strarray {
-	int	    offset;
-	int	    nr_entries;
-	const char **entries;
-};
+size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, int val)
+{
+	int idx = val - sa->offset;
 
-#define DEFINE_STRARRAY(array) struct strarray strarray__##array = { \
-	.nr_entries = ARRAY_SIZE(array), \
-	.entries = array, \
-}
+	if (idx < 0 || idx >= sa->nr_entries)
+		return scnprintf(bf, size, intfmt, val);
 
-#define DEFINE_STRARRAY_OFFSET(array, off) struct strarray strarray__##array = { \
-	.offset	    = off, \
-	.nr_entries = ARRAY_SIZE(array), \
-	.entries = array, \
+	return scnprintf(bf, size, "%s", sa->entries[idx]);
 }
 
 static size_t __syscall_arg__scnprintf_strarray(char *bf, size_t size,
 						const char *intfmt,
 					        struct syscall_arg *arg)
 {
-	struct strarray *sa = arg->parm;
-	int idx = arg->val - sa->offset;
-
-	if (idx < 0 || idx >= sa->nr_entries)
-		return scnprintf(bf, size, intfmt, arg->val);
-
-	return scnprintf(bf, size, "%s", sa->entries[idx]);
+	return strarray__scnprintf(arg->parm, bf, size, intfmt, arg->val);
 }
 
 static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 9ccf0f323fe5..f75ef7d0b303 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -1,8 +1,28 @@
 #ifndef _PERF_TRACE_BEAUTY_H
 #define _PERF_TRACE_BEAUTY_H
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 
+struct strarray {
+	int	    offset;
+	int	    nr_entries;
+	const char **entries;
+};
+
+#define DEFINE_STRARRAY(array) struct strarray strarray__##array = { \
+	.nr_entries = ARRAY_SIZE(array), \
+	.entries = array, \
+}
+
+#define DEFINE_STRARRAY_OFFSET(array, off) struct strarray strarray__##array = { \
+	.offset	    = off, \
+	.nr_entries = ARRAY_SIZE(array), \
+	.entries = array, \
+}
+
+size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, int val);
+
 struct trace;
 struct thread;
 
-- 
2.9.4
