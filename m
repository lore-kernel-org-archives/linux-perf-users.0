From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/86] perf trace: Beautify linux specific fcntl commands
Date: Wed, 19 Jul 2017 11:28:28 -0300
Message-ID: <20170719142950.3747-5-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were only beautifying (transforming from an integer to its name) the
non-linux specific fcntl syscall cmd args, fix it:

Before:

  # perf trace -e fcntl -p 2472
     0.000 ( 0.017 ms): gnome-terminal/2472 fcntl(fd: 55, cmd: 1030) = 56
  ^C#

After:

  # trace -e fcntl -p 2472
     0.000 ( 0.015 ms): gnome-terminal/2472 fcntl(fd: 55, cmd: DUPFD_CLOEXEC) = 56
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-zigsxruk4wbfn8iylboy9wzo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 57 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cfe1858ed074..431ef70067ed 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -64,6 +64,10 @@
 # define O_CLOEXEC		02000000
 #endif
 
+#ifndef F_LINUX_SPECIFIC_BASE
+# define F_LINUX_SPECIFIC_BASE	1024
+#endif
+
 struct trace {
 	struct perf_tool	tool;
 	struct syscalltbl	*sctbl;
@@ -317,6 +321,38 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 #define SCA_STRARRAY syscall_arg__scnprintf_strarray
 
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
+static size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
+					       struct syscall_arg *arg)
+{
+	struct strarrays *sas = arg->parm;
+	int i;
+
+	for (i = 0; i < sas->nr_entries; ++i) {
+		struct strarray *sa = sas->entries[i];
+		int idx = arg->val - sa->offset;
+
+		if (idx >= 0 && idx < sa->nr_entries) {
+			if (sa->entries[idx] == NULL)
+				break;
+			return scnprintf(bf, size, "%s", sa->entries[idx]);
+		}
+	}
+
+	return scnprintf(bf, size, "%d", arg->val);
+}
+
+#define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
+
 #if defined(__i386__) || defined(__x86_64__)
 /*
  * FIXME: Make this available to all arches as soon as the ioctl beautifier
@@ -413,6 +449,20 @@ static const char *fcntl_cmds[] = {
 };
 static DEFINE_STRARRAY(fcntl_cmds);
 
+static const char *fcntl_linux_specific_cmds[] = {
+	"SETLEASE", "GETLEASE", "NOTIFY", [5] =	"CANCELLK", "DUPFD_CLOEXEC",
+	"SETPIPE_SZ", "GETPIPE_SZ", "ADD_SEALS", "GET_SEALS",
+};
+
+static DEFINE_STRARRAY_OFFSET(fcntl_linux_specific_cmds, F_LINUX_SPECIFIC_BASE);
+
+static struct strarray *fcntl_cmds_arrays[] = {
+	&strarray__fcntl_cmds,
+	&strarray__fcntl_linux_specific_cmds,
+};
+
+static DEFINE_STRARRAYS(fcntl_cmds_arrays);
+
 static const char *rlimit_resources[] = {
 	"CPU", "FSIZE", "DATA", "STACK", "CORE", "RSS", "NPROC", "NOFILE",
 	"MEMLOCK", "AS", "LOCKS", "SIGPENDING", "MSGQUEUE", "NICE", "RTPRIO",
@@ -613,8 +663,8 @@ static struct syscall_fmt {
 	{ .name	    = "fchownat",   .errmsg = true,
 	  .arg_scnprintf = { [0] = SCA_FDAT, /* fd */ }, },
 	{ .name	    = "fcntl",	    .errmsg = true,
-	  .arg_scnprintf = { [1] = SCA_STRARRAY, /* cmd */ },
-	  .arg_parm	 = { [1] = &strarray__fcntl_cmds, /* cmd */ }, },
+	  .arg_scnprintf = { [1] = SCA_STRARRAYS, /* cmd */ },
+	  .arg_parm	 = { [1] = &strarrays__fcntl_cmds_arrays, /* cmd */ }, },
 	{ .name	    = "fdatasync",  .errmsg = true, },
 	{ .name	    = "flock",	    .errmsg = true,
 	  .arg_scnprintf = { [1] = SCA_FLOCK, /* cmd */ }, },
@@ -1356,7 +1406,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
  			 */
 			if (val == 0 &&
 			    !(sc->arg_scnprintf &&
-			      sc->arg_scnprintf[arg.idx] == SCA_STRARRAY &&
+			      (sc->arg_scnprintf[arg.idx] == SCA_STRARRAY ||
+			       sc->arg_scnprintf[arg.idx] == SCA_STRARRAYS) &&
 			      sc->arg_parm[arg.idx]))
 				continue;
 
-- 
2.9.4
