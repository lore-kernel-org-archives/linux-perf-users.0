From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 54/63] perf trace: Move strarrays to beauty.h for further reuse
Date: Tue, 18 Dec 2018 19:07:24 -0300
Message-ID: <20181218220733.15839-55-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll use it in the upcoming arch_prctl() 'code' arg beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6e4tj2fjen8qa73gy4u49vav@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 26 ++++++++++----------------
 tools/perf/trace/beauty/beauty.h | 12 ++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6ba8290a0794..9d30e0f3b7ea 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -386,34 +386,28 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 #define SCA_STRARRAY syscall_arg__scnprintf_strarray
 
-struct strarrays {
-	int		nr_entries;
-	struct strarray **entries;
-};
-
-#define DEFINE_STRARRAYS(array) struct strarrays strarrays__##array = { \
-	.nr_entries = ARRAY_SIZE(array), \
-	.entries = array, \
-}
-
-size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
-					struct syscall_arg *arg)
+size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
-	struct strarrays *sas = arg->parm;
 	int i;
 
 	for (i = 0; i < sas->nr_entries; ++i) {
 		struct strarray *sa = sas->entries[i];
-		int idx = arg->val - sa->offset;
+		int idx = val - sa->offset;
 
 		if (idx >= 0 && idx < sa->nr_entries) {
 			if (sa->entries[idx] == NULL)
 				break;
-			return scnprintf(bf, size, "%s%s", arg->show_string_prefix ? sa->prefix : "", sa->entries[idx]);
+			return scnprintf(bf, size, "%s%s", show_prefix ? sa->prefix : "", sa->entries[idx]);
 		}
 	}
 
-	return scnprintf(bf, size, "%d", arg->val);
+	return scnprintf(bf, size, intfmt, val);
+}
+
+size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
+					struct syscall_arg *arg)
+{
+	return strarrays__scnprintf(arg->parm, bf, size, "%d", arg->show_string_prefix, arg->val);
 }
 
 #ifndef AT_FDCWD
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 1a93d9c626ef..58e734b27958 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,18 @@ size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, boo
 struct trace;
 struct thread;
 
+struct strarrays {
+	int		nr_entries;
+	struct strarray **entries;
+};
+
+#define DEFINE_STRARRAYS(array) struct strarrays strarrays__##array = { \
+	.nr_entries = ARRAY_SIZE(array), \
+	.entries = array, \
+}
+
+size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val);
+
 size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_t size);
 
 extern struct strarray strarray__socket_families;
-- 
2.19.2
