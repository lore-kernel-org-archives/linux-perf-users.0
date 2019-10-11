From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/69] perf trace: Enclose all events argument lists with ()
Date: Fri, 11 Oct 2019 17:05:13 -0300
Message-ID: <20191011200559.7156-24-acme@kernel.org>
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

So that they look a bit like normal strace-like syscall enter+exit
lines.

They will look even more when we switch from using libtraceevent's
tep_print_event() routine in favour of using all the perf beautifiers
used by the strace-like syscall enter+exit lines.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-y4fcej6v6u1m644nbxd2r4pg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b3fb208cbd30..297aeaa9f69d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2450,7 +2450,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		 */
 	}
 
-	fprintf(trace->output, "%s:", evsel->name);
+	fprintf(trace->output, "%s(", evsel->name);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		bpf_output__fprintf(trace, sample);
@@ -2470,7 +2470,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	}
 
 newline:
-	fprintf(trace->output, "\n");
+	fprintf(trace->output, ")\n");
 
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
-- 
2.21.0
