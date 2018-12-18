From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 50/63] perf trace: Show NULL when syscall pointer args are 0
Date: Tue, 18 Dec 2018 19:07:20 -0300
Message-ID: <20181218220733.15839-51-acme@kernel.org>
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

Matching strace's output format. The 'format' file for the syscall
tracepoints have an indication if the arg is a pointer, with some
exceptions like 'mmap' that has its first arg as an 'unsigned long', so
use a heuristic using the argument name, i.e. if it contains the 'addr'
substring, format it with the pointer formatter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ddghemr8qrm6i0sb8awznbze@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 28 ++++++++++++----------------
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 35d8fbe47ee4..6ba8290a0794 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -444,6 +444,13 @@ size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg
 	return scnprintf(bf, size, "%#lx", arg->val);
 }
 
+size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg)
+{
+	if (arg->val == 0)
+		return scnprintf(bf, size, "NULL");
+	return syscall_arg__scnprintf_hex(bf, size, arg);
+}
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return scnprintf(bf, size, "%d", arg->val);
@@ -660,7 +667,7 @@ static struct syscall_fmt {
 	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* brk */ }, }, },
+	  .arg = { [0] = { .scnprintf = SCA_PTR, /* brk */ }, }, },
 	{ .name     = "clock_gettime",
 	  .arg = { [0] = STRARRAY(clk_id, clockid), }, },
 	{ .name	    = "clone",	    .errpid = true, .nr_args = 5,
@@ -738,17 +745,12 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "mknodat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
-	{ .name	    = "mlock",
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
-	{ .name	    = "mlockall",
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
 	{ .name	    = "mmap",	    .hexret = true,
 /* The standard mmap maps to old_mmap on s390x */
 #if defined(__s390x__)
 	.alias = "old_mmap",
 #endif
-	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* addr */ },
-		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
+	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
 	{ .name	    = "mount",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
@@ -760,13 +762,7 @@ static struct syscall_fmt {
 	{ .name	    = "mq_unlink",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* u_name */ }, }, },
 	{ .name	    = "mremap",	    .hexret = true,
-	  .arg = { [0] = { .scnprintf = SCA_HEX,	  /* addr */ },
-		   [3] = { .scnprintf = SCA_MREMAP_FLAGS, /* flags */ },
-		   [4] = { .scnprintf = SCA_HEX,	  /* new_addr */ }, }, },
-	{ .name	    = "munlock",
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
-	{ .name	    = "munmap",
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
+	  .arg = { [3] = { .scnprintf = SCA_MREMAP_FLAGS, /* flags */ }, }, },
 	{ .name	    = "name_to_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "newfstatat",
@@ -1350,8 +1346,8 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 			  strcmp(field->name, "path") == 0 ||
 			  strcmp(field->name, "pathname") == 0))
 			sc->arg_fmt[idx].scnprintf = SCA_FILENAME;
-		else if (field->flags & TEP_FIELD_IS_POINTER)
-			sc->arg_fmt[idx].scnprintf = syscall_arg__scnprintf_hex;
+		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
+			sc->arg_fmt[idx].scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)
 			sc->arg_fmt[idx].scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index ac25b6410bc8..1a93d9c626ef 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -98,6 +98,9 @@ size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
 size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_HEX syscall_arg__scnprintf_hex
 
+size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PTR syscall_arg__scnprintf_ptr
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_INT syscall_arg__scnprintf_int
 
-- 
2.19.2
