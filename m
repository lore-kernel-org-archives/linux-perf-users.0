From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/86] perf trace beauty fcntl: Basic 'arg' beautifier
Date: Wed, 19 Jul 2017 11:28:37 -0300
Message-ID: <20170719142950.3747-14-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Sometimes it should be printed as an hex number, like with F_SETLK,
F_SETLKW and F_GETLK, that treat 'arg' as a struct flock pointer, in
other cases it is just an integer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-2gykg6enk7vos6q0m97hkgsg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       |  3 ++-
 tools/perf/trace/beauty/beauty.h |  3 +++
 tools/perf/trace/beauty/fcntl.c  | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a323736043e1..2a894ea7f540 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -660,7 +660,8 @@ static struct syscall_fmt {
 	{ .name	    = "fchownat",   .errmsg = true,
 	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
 	{ .name	    = "fcntl",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_FCNTL_CMD, /* cmd */ },
+	  .arg_scnprintf = { [1] = SCA_FCNTL_CMD, /* cmd */
+			     [2] = SCA_FCNTL_ARG, /* arg */ },
 	  .arg_parm	 = { [1] = &strarrays__fcntl_cmds_arrays, /* cmd */ }, },
 	{ .name	    = "fdatasync",  .errmsg = true, },
 	{ .name	    = "flock",	    .errmsg = true,
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 61aec19e55ec..d76f903bf2ed 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -43,6 +43,9 @@ size_t syscall_arg__scnprintf_long(char *bf, size_t size, struct syscall_arg *ar
 size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_FCNTL_CMD syscall_arg__scnprintf_fcntl_cmd
 
+size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FCNTL_ARG syscall_arg__scnprintf_fcntl_arg
+
 size_t syscall_arg__scnprintf_statx_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STATX_FLAGS syscall_arg__scnprintf_statx_flags
 
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 7e4582c9308e..8a5f58d9eb7c 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -21,3 +21,21 @@ size_t syscall_arg__scnprintf_fcntl_cmd(char *bf, size_t size, struct syscall_ar
 
 	return syscall_arg__scnprintf_strarrays(bf, size, arg);
 }
+
+size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_arg *arg)
+{
+	int cmd = syscall_arg__val(arg, 1);
+
+	/*
+	 * We still don't grab the contents of pointers on entry or exit,
+	 * so just print them as hex numbers
+	 */
+	if (cmd == F_SETLK || cmd == F_SETLKW || cmd == F_GETLK ||
+	    cmd == F_OFD_SETLK || cmd == F_OFD_SETLKW || cmd == F_OFD_GETLK ||
+	    cmd == F_GETOWN_EX || cmd == F_SETOWN_EX ||
+	    cmd == F_GET_RW_HINT || cmd == F_SET_RW_HINT ||
+	    cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT)
+		return syscall_arg__scnprintf_hex(bf, size, arg);
+
+	return syscall_arg__scnprintf_long(bf, size, arg);
+}
-- 
2.9.4
