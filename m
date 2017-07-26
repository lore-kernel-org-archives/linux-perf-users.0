From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/40] perf trace: Use the syscall_fmt formatters without a tracepoint
Date: Wed, 26 Jul 2017 11:16:56 -0300
Message-ID: <20170726141730.30750-7-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Previously we only used the syscall_fmt when we had sc->tp_format set,
i.e. when we found the (enter, exit) pair in tracefs/events/syscalls/.

But we really only need to use what is in sc->arg_fmt to apply the arg
beautifiers to the syscall argument values, so do it.

With this we will be able to provide formatters to the "clone" syscall,
which doesn't have entries in tracefs/events/syscalls/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-y41nl41jrayjo5ucnde2peix@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 54 +++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1c5238af6d14..fc4d33a6aa58 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1350,12 +1350,32 @@ unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx)
 	return __syscall_arg__val(arg->args, idx);
 }
 
+static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
+				     struct syscall_arg *arg, unsigned long val)
+{
+	if (sc->arg_fmt && sc->arg_fmt[arg->idx].scnprintf) {
+		arg->val = val;
+		if (sc->arg_fmt[arg->idx].parm)
+			arg->parm = sc->arg_fmt[arg->idx].parm;
+		return sc->arg_fmt[arg->idx].scnprintf(bf, size, arg);
+	}
+	return scnprintf(bf, size, "%ld", val);
+}
+
 static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 				      unsigned char *args, struct trace *trace,
 				      struct thread *thread)
 {
 	size_t printed = 0;
 	unsigned long val;
+	u8 bit = 1;
+	struct syscall_arg arg = {
+		.args	= args,
+		.idx	= 0,
+		.mask	= 0,
+		.trace  = trace,
+		.thread = thread,
+	};
 	struct thread_trace *ttrace = thread__priv(thread);
 
 	/*
@@ -1367,14 +1387,6 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 	if (sc->args != NULL) {
 		struct format_field *field;
-		u8 bit = 1;
-		struct syscall_arg arg = {
-			.args	= args,
-			.idx	= 0,
-			.mask	= 0,
-			.trace  = trace,
-			.thread = thread,
-		};
 
 		for (field = sc->args; field;
 		     field = field->next, ++arg.idx, bit <<= 1) {
@@ -1398,15 +1410,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			printed += scnprintf(bf + printed, size - printed,
 					     "%s%s: ", printed ? ", " : "", field->name);
-			if (sc->arg_fmt && sc->arg_fmt[arg.idx].scnprintf) {
-				arg.val = val;
-				if (sc->arg_fmt[arg.idx].parm)
-					arg.parm = sc->arg_fmt[arg.idx].parm;
-				printed += sc->arg_fmt[arg.idx].scnprintf(bf + printed, size - printed, &arg);
-			} else {
-				printed += scnprintf(bf + printed, size - printed,
-						     "%ld", val);
-			}
+			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
 		}
 	} else if (IS_ERR(sc->tp_format)) {
 		/*
@@ -1414,14 +1418,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 		 * may end up not having any args, like with gettid(), so only
 		 * print the raw args when we didn't manage to read it.
 		 */
-		int i = 0;
-
-		while (i < 6) {
-			val = __syscall_arg__val(args, i);
+		while (arg.idx < 6) {
+			if (arg.mask & bit)
+				goto next_arg;
+			val = syscall_arg__val(&arg, arg.idx);
 			printed += scnprintf(bf + printed, size - printed,
-					     "%sarg%d: %ld",
-					     printed ? ", " : "", i, val);
-			++i;
+					     "%sarg%d: ", printed ? ", " : "", arg.idx);
+			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
+next_arg:
+			++arg.idx;
+			bit <<= 1;
 		}
 	}
 
-- 
2.9.4
