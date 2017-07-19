From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/86] perf trace beauty: Introduce syscall arg beautifier for long integers
Date: Wed, 19 Jul 2017 11:28:35 -0300
Message-ID: <20170719142950.3747-12-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used in the fcntl arg beautifier, that nowadays formats as '%ld'
because there is no explicit arg beautifier attached, but as we will
have to first decide what beautifier to use (i.e. it may be a pointer,
etc) then we need to have this exported as a separate beautifier to be
called from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-d7bfs3m8m70j3zckeam0kk5d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 5 +++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9e171401b664..a323736043e1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -402,6 +402,11 @@ size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg
 	return scnprintf(bf, size, "%d", arg->val);
 }
 
+size_t syscall_arg__scnprintf_long(char *bf, size_t size, struct syscall_arg *arg)
+{
+	return scnprintf(bf, size, "%ld", arg->val);
+}
+
 static const char *bpf_cmd[] = {
 	"MAP_CREATE", "MAP_LOOKUP_ELEM", "MAP_UPDATE_ELEM", "MAP_DELETE_ELEM",
 	"MAP_GET_NEXT_KEY", "PROG_LOAD",
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index d085aacecd49..61aec19e55ec 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -37,6 +37,9 @@ size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_INT syscall_arg__scnprintf_int
 
+size_t syscall_arg__scnprintf_long(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_LONG syscall_arg__scnprintf_long
+
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FCNTL_CMD syscall_arg__scnprintf_fcntl_cmd
 
-- 
2.9.4
