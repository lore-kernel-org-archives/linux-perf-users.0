From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/86] perf trace beauty: Allow accessing syscall args values in a syscall arg formatter
Date: Wed, 19 Jul 2017 11:28:33 -0300
Message-ID: <20170719142950.3747-10-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For instance, fcntl's upcoming 'arg' formatter needs to look at the
'cmd' value to decide how to format its value, sometimes it is a file
flags, sometimes an fd, a pointer to a structure, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-2tw2jfaqm48dtw8a4addghze@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 23 ++++++++++++++++-------
 tools/perf/trace/beauty/beauty.h | 13 +++++++++++++
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b7f79dea3c44..40bc0a326096 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1369,19 +1369,32 @@ static int trace__validate_ev_qualifier(struct trace *trace)
  * variable to read it. Most notably this avoids extended load instructions
  * on unaligned addresses
  */
+static unsigned long __syscall_arg__val(unsigned char *args, u8 idx)
+{
+	unsigned long val;
+	unsigned char *p = args + sizeof(unsigned long) * idx;
+
+	memcpy(&val, p, sizeof(val));
+	return val;
+}
+
+unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx)
+{
+	return __syscall_arg__val(arg->args, idx);
+}
 
 static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 				      unsigned char *args, struct trace *trace,
 				      struct thread *thread)
 {
 	size_t printed = 0;
-	unsigned char *p;
 	unsigned long val;
 
 	if (sc->args != NULL) {
 		struct format_field *field;
 		u8 bit = 1;
 		struct syscall_arg arg = {
+			.args	= args,
 			.idx	= 0,
 			.mask	= 0,
 			.trace  = trace,
@@ -1393,9 +1406,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (arg.mask & bit)
 				continue;
 
-			/* special care for unaligned accesses */
-			p = args + sizeof(unsigned long) * arg.idx;
-			memcpy(&val, p, sizeof(val));
+			val = syscall_arg__val(&arg, arg.idx);
 
 			/*
  			 * Suppress this argument if its value is zero and
@@ -1431,9 +1442,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 		int i = 0;
 
 		while (i < 6) {
-			/* special care for unaligned accesses */
-			p = args + sizeof(unsigned long) * i;
-			memcpy(&val, p, sizeof(val));
+			val = __syscall_arg__val(args, i);
 			printed += scnprintf(bf + printed, size - printed,
 					     "%sarg%d: %ld",
 					     printed ? ", " : "", i, val);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index ce01079d8422..6fbac0c8120d 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -6,8 +6,19 @@
 struct trace;
 struct thread;
 
+/**
+ * @val: value of syscall argument being formatted
+ * @args: All the args, use syscall_args__val(arg, nth) to access one
+ * @thread: tid state (maps, pid, tid, etc)
+ * @trace: 'perf trace' internals: all threads, etc
+ * @parm: private area, may be an strarray, for instance
+ * @idx: syscall arg idx (is this the first?)
+ * @mask: a syscall arg may mask another arg, see syscall_arg__scnprintf_futex_op
+ */
+
 struct syscall_arg {
 	unsigned long val;
+	unsigned char *args;
 	struct thread *thread;
 	struct trace  *trace;
 	void	      *parm;
@@ -15,6 +26,8 @@ struct syscall_arg {
 	u8	      mask;
 };
 
+unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
+
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
 
-- 
2.9.4
