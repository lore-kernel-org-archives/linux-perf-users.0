From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/86] perf trace beauty: Export the "int" and "hex" syscall arg formatters
Date: Wed, 19 Jul 2017 11:28:34 -0300
Message-ID: <20170719142950.3747-11-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The most basic ones, for pointers, unaugmented fds, etc, to be used
in the initial fcntl 'arg' beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-g0lugj4vv6p4jtge32hid6q6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 10 ++--------
 tools/perf/trace/beauty/beauty.h |  6 ++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 40bc0a326096..9e171401b664 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -392,22 +392,16 @@ static size_t syscall_arg__scnprintf_close_fd(char *bf, size_t size,
 
 #define SCA_CLOSE_FD syscall_arg__scnprintf_close_fd
 
-static size_t syscall_arg__scnprintf_hex(char *bf, size_t size,
-					 struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return scnprintf(bf, size, "%#lx", arg->val);
 }
 
-#define SCA_HEX syscall_arg__scnprintf_hex
-
-static size_t syscall_arg__scnprintf_int(char *bf, size_t size,
-					 struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return scnprintf(bf, size, "%d", arg->val);
 }
 
-#define SCA_INT syscall_arg__scnprintf_int
-
 static const char *bpf_cmd[] = {
 	"MAP_CREATE", "MAP_LOOKUP_ELEM", "MAP_UPDATE_ELEM", "MAP_DELETE_ELEM",
 	"MAP_GET_NEXT_KEY", "PROG_LOAD",
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 6fbac0c8120d..d085aacecd49 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -31,6 +31,12 @@ unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
 
+size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_HEX syscall_arg__scnprintf_hex
+
+size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_INT syscall_arg__scnprintf_int
+
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FCNTL_CMD syscall_arg__scnprintf_fcntl_cmd
 
-- 
2.9.4
