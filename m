From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 20/69] perf trace: Move some scnprintf methods from syscall to syscall_arg_fmt
Date: Fri, 11 Oct 2019 17:05:10 -0300
Message-ID: <20191011200559.7156-21-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since all they operate on is on a syscall_arg_fmt instance, so move them
to allow use it from the upcoming tracepoint fprintf routine.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ynttrs1l75f0x9tk67spd7jd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index aa70602c2808..82d39ef43d9c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1715,22 +1715,22 @@ static size_t syscall__scnprintf_name(struct syscall *sc, char *bf, size_t size,
  * as mount 'flags' argument that needs ignoring some magic flag, see comment
  * in tools/perf/trace/beauty/mount_flags.c
  */
-static unsigned long syscall__mask_val(struct syscall *sc, struct syscall_arg *arg, unsigned long val)
+static unsigned long syscall_arg_fmt__mask_val(struct syscall_arg_fmt *fmt, struct syscall_arg *arg, unsigned long val)
 {
-	if (sc->arg_fmt && sc->arg_fmt[arg->idx].mask_val)
-		return sc->arg_fmt[arg->idx].mask_val(arg, val);
+	if (fmt && fmt->mask_val)
+		return fmt->mask_val(arg, val);
 
 	return val;
 }
 
-static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
-				     struct syscall_arg *arg, unsigned long val)
+static size_t syscall_arg_fmt__scnprintf_val(struct syscall_arg_fmt *fmt, char *bf, size_t size,
+					     struct syscall_arg *arg, unsigned long val)
 {
-	if (sc->arg_fmt && sc->arg_fmt[arg->idx].scnprintf) {
+	if (fmt && fmt->scnprintf) {
 		arg->val = val;
-		if (sc->arg_fmt[arg->idx].parm)
-			arg->parm = sc->arg_fmt[arg->idx].parm;
-		return sc->arg_fmt[arg->idx].scnprintf(bf, size, arg);
+		if (fmt->parm)
+			arg->parm = fmt->parm;
+		return fmt->scnprintf(bf, size, arg);
 	}
 	return scnprintf(bf, size, "%ld", val);
 }
@@ -1776,7 +1776,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			 * Some syscall args need some mask, most don't and
 			 * return val untouched.
 			 */
-			val = syscall__mask_val(sc, &arg, val);
+			val = syscall_arg_fmt__mask_val(&sc->arg_fmt[arg.idx], &arg, val);
 
 			/*
  			 * Suppress this argument if its value is zero and
@@ -1797,7 +1797,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
+			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
+								  bf + printed, size - printed, &arg, val);
 		}
 	} else if (IS_ERR(sc->tp_format)) {
 		/*
@@ -1812,7 +1813,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (printed)
 				printed += scnprintf(bf + printed, size - printed, ", ");
 			printed += syscall__scnprintf_name(sc, bf + printed, size - printed, &arg);
-			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
+			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx], bf + printed, size - printed, &arg, val);
 next_arg:
 			++arg.idx;
 			bit <<= 1;
-- 
2.21.0
