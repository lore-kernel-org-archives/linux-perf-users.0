From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/19] perf trace beauty: Implement pid_fd beautifier
Date: Fri,  3 Nov 2017 10:55:00 -0300
Message-ID: <20171103135503.4921-17-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andrey Vagin <avagin@openvz.org>, Cyrill Gorcunov <gorcunov@openvz.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One that given a pid and a fd, will try to get the path for that fd.
Will be used in the upcoming kcmp's KCMP_FILE beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrey Vagin <avagin@openvz.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-7ketygp2dvs9h13wuakfncws@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 17 +++++++++++++++++
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c373f9a3e4a9..0c1461416ef1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -988,6 +988,23 @@ size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
 	return printed;
 }
 
+size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_t size)
+{
+        size_t printed = scnprintf(bf, size, "%d", fd);
+	struct thread *thread = machine__find_thread(trace->host, pid, pid);
+
+	if (thread) {
+		const char *path = thread__fd_path(thread, fd, trace);
+
+		if (path)
+			printed += scnprintf(bf + printed, size - printed, "<%s>", path);
+
+		thread__put(thread);
+	}
+
+        return printed;
+}
+
 static size_t syscall_arg__scnprintf_close_fd(char *bf, size_t size,
 					      struct syscall_arg *arg)
 {
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index b29f94ef5d6a..365bb6fecc1c 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <sys/types.h>
 
 struct strarray {
 	int	    offset;
@@ -26,6 +27,8 @@ size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const cha
 struct trace;
 struct thread;
 
+size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_t size);
+
 /**
  * @val: value of syscall argument being formatted
  * @args: All the args, use syscall_args__val(arg, nth) to access one
-- 
2.13.6
