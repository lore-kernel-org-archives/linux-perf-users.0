From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 65/86] perf header: Add PROCESS_STR_FUN macro
Date: Wed, 19 Jul 2017 11:29:29 -0300
Message-ID: <20170719142950.3747-66-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Carrillo-Cisneros <davidcc@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, He Kuang <hekuang@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Carrillo-Cisneros <davidcc@google.com>

Simplify code by adding a macro to handle the common case of processing
header features that are a simple string.

Signed-off-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170718042549.145161-3-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 65 +++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 24e842c02027..3b833f06c4e7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1603,6 +1603,23 @@ static int perf_header__read_build_ids(struct perf_header *header,
 	return err;
 }
 
+/* Macro for features that simply need to read and store a string. */
+#define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
+static int process_##__feat(struct perf_file_section *section __maybe_unused, \
+			    struct perf_header *ph, int fd,		      \
+			    void *data __maybe_unused) \
+{\
+	ph->env.__feat_env = do_read_string(fd, ph); \
+	return ph->env.__feat_env ? 0 : -ENOMEM; \
+}
+
+FEAT_PROCESS_STR_FUN(hostname, hostname);
+FEAT_PROCESS_STR_FUN(osrelease, os_release);
+FEAT_PROCESS_STR_FUN(version, version);
+FEAT_PROCESS_STR_FUN(arch, arch);
+FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
+FEAT_PROCESS_STR_FUN(cpuid, cpuid);
+
 static int process_tracing_data(struct perf_file_section *section __maybe_unused,
 				struct perf_header *ph __maybe_unused,
 				int fd, void *data)
@@ -1620,38 +1637,6 @@ static int process_build_id(struct perf_file_section *section,
 	return 0;
 }
 
-static int process_hostname(struct perf_file_section *section __maybe_unused,
-			    struct perf_header *ph, int fd,
-			    void *data __maybe_unused)
-{
-	ph->env.hostname = do_read_string(fd, ph);
-	return ph->env.hostname ? 0 : -ENOMEM;
-}
-
-static int process_osrelease(struct perf_file_section *section __maybe_unused,
-			     struct perf_header *ph, int fd,
-			     void *data __maybe_unused)
-{
-	ph->env.os_release = do_read_string(fd, ph);
-	return ph->env.os_release ? 0 : -ENOMEM;
-}
-
-static int process_version(struct perf_file_section *section __maybe_unused,
-			   struct perf_header *ph, int fd,
-			   void *data __maybe_unused)
-{
-	ph->env.version = do_read_string(fd, ph);
-	return ph->env.version ? 0 : -ENOMEM;
-}
-
-static int process_arch(struct perf_file_section *section __maybe_unused,
-			struct perf_header *ph,	int fd,
-			void *data __maybe_unused)
-{
-	ph->env.arch = do_read_string(fd, ph);
-	return ph->env.arch ? 0 : -ENOMEM;
-}
-
 static int process_nrcpus(struct perf_file_section *section __maybe_unused,
 			  struct perf_header *ph, int fd,
 			  void *data __maybe_unused)
@@ -1671,22 +1656,6 @@ static int process_nrcpus(struct perf_file_section *section __maybe_unused,
 	return 0;
 }
 
-static int process_cpudesc(struct perf_file_section *section __maybe_unused,
-			   struct perf_header *ph, int fd,
-			   void *data __maybe_unused)
-{
-	ph->env.cpu_desc = do_read_string(fd, ph);
-	return ph->env.cpu_desc ? 0 : -ENOMEM;
-}
-
-static int process_cpuid(struct perf_file_section *section __maybe_unused,
-			 struct perf_header *ph,  int fd,
-			 void *data __maybe_unused)
-{
-	ph->env.cpuid = do_read_string(fd, ph);
-	return ph->env.cpuid ? 0 : -ENOMEM;
-}
-
 static int process_total_mem(struct perf_file_section *section __maybe_unused,
 			     struct perf_header *ph, int fd,
 			     void *data __maybe_unused)
-- 
2.9.4
