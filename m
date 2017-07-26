From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/40] perf trace: Allow specifying names to syscall arguments formatters
Date: Wed, 26 Jul 2017 11:16:59 -0300
Message-ID: <20170726141730.30750-10-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For tracepointless syscalls, like clone, otherwise get them from the
tracepoint's /format file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ml5qvv1w5k96ghwhxpzzsmm3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e1988d08911d..6664293584df 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -604,6 +604,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 struct syscall_arg_fmt {
 	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
 	void	   *parm;
+	const char *name;
 	bool	   show_zero;
 };
 
@@ -1349,6 +1350,15 @@ unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx)
 	return val;
 }
 
+static size_t syscall__scnprintf_name(struct syscall *sc, char *bf, size_t size,
+				      struct syscall_arg *arg)
+{
+	if (sc->arg_fmt && sc->arg_fmt[arg->idx].name)
+		return scnprintf(bf, size, "%s: ", sc->arg_fmt[arg->idx].name);
+
+	return scnprintf(bf, size, "arg%d: ", arg->idx);
+}
+
 static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
 				     struct syscall_arg *arg, unsigned long val)
 {
@@ -1421,8 +1431,9 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (arg.mask & bit)
 				goto next_arg;
 			val = syscall_arg__val(&arg, arg.idx);
-			printed += scnprintf(bf + printed, size - printed,
-					     "%sarg%d: ", printed ? ", " : "", arg.idx);
+			if (printed)
+				printed += scnprintf(bf + printed, size - printed, ", ");
+			printed += syscall__scnprintf_name(sc, bf + printed, size - printed, &arg);
 			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
 next_arg:
 			++arg.idx;
-- 
2.9.4
