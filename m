From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/86] perf trace beauty: Export the pid beautifier for use in more places
Date: Wed, 19 Jul 2017 11:28:50 -0300
Message-ID: <20170719142950.3747-27-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that the beautifiers are being split into multiple source and object
files, we will need more of them exported, do it for the 'pid' one, will
be used to augment the return of some syscalls that may return a 'pid',
such as fcntl(fd, F_GETOWN).

Will also be used for fcntl(fd, F_SETOWN, pid).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-7gr5nt9p5skp4i1w0ja1w272@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h | 3 +++
 tools/perf/trace/beauty/pid.c    | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 790e8307fc6a..9ccf0f323fe5 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -43,6 +43,9 @@ size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg
 size_t syscall_arg__scnprintf_long(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_LONG syscall_arg__scnprintf_long
 
+size_t syscall_arg__scnprintf_pid(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PID syscall_arg__scnprintf_pid
+
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FCNTL_CMD syscall_arg__scnprintf_fcntl_cmd
 
diff --git a/tools/perf/trace/beauty/pid.c b/tools/perf/trace/beauty/pid.c
index 07486ea65ae3..b6d419e16dcf 100644
--- a/tools/perf/trace/beauty/pid.c
+++ b/tools/perf/trace/beauty/pid.c
@@ -1,4 +1,4 @@
-static size_t syscall_arg__scnprintf_pid(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_pid(char *bf, size_t size, struct syscall_arg *arg)
 {
 	int pid = arg->val;
 	struct trace *trace = arg->trace;
@@ -17,5 +17,3 @@ static size_t syscall_arg__scnprintf_pid(char *bf, size_t size, struct syscall_a
 
 	return printed;
 }
-
-#define SCA_PID syscall_arg__scnprintf_pid
-- 
2.9.4
