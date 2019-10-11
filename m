From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/69] perf trace: Allocate an array of beautifiers for tracepoint args
Date: Fri, 11 Oct 2019 17:05:09 -0300
Message-ID: <20191011200559.7156-20-acme@kernel.org>
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

This will work similar to the syscall args, we'll allocate an array
of 'struct syscall_arg_fmt' for the tracepoint args and then init them
using the same algorithm used for the defaults for syscall args, i.e.
using its types and sometimes names as hints to find the right scnprintf
routine to beautify them from numbers into strings.

Next step is to stop using libtracevent to printf tracepoints, as we'll
have more beautifiers than int provides, modulo perhaps some plugins.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dcl135relxvf6ljisjg13aqg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d52dd2bad980..aa70602c2808 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1574,6 +1574,19 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	return syscall__set_arg_fmts(sc);
 }
 
+static int perf_evsel__init_tp_arg_scnprintf(struct evsel *evsel)
+{
+	int nr_args = evsel->tp_format->format.nr_fields;
+
+	evsel->priv = calloc(nr_args, sizeof(struct syscall_arg_fmt));
+	if (evsel->priv != NULL) {
+		syscall_arg_fmt__init_array(evsel->priv, evsel->tp_format->format.fields);
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
 static int intcmp(const void *a, const void *b)
 {
 	const int *one = a, *another = b;
@@ -3936,8 +3949,10 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 		if (evsel->priv || !evsel->tp_format)
 			continue;
 
-		if (strcmp(evsel->tp_format->system, "syscalls"))
+		if (strcmp(evsel->tp_format->system, "syscalls")) {
+			perf_evsel__init_tp_arg_scnprintf(evsel);
 			continue;
+		}
 
 		if (perf_evsel__init_syscall_tp(evsel))
 			return -1;
-- 
2.21.0
