From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/57] perf trace: Honour --max-events in processing syscalls:sys_enter_*
Date: Mon, 21 Oct 2019 10:38:14 -0300
Message-ID: <20191021133834.25998-38-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were doing this only at the sys_exit syscall tracepoint, as for
strace-like we count the pair of sys_enter and sys_exit as one event,
but when asking specifically for a the syscalls:sys_enter_NAME
tracepoint we need to count each of those as an event.

I.e. things like:

  # perf trace --max-events=4 -e syscalls:sys_enter_lseek
     0.000 pool/2242 syscalls:sys_enter_lseek(fd: 14<anon_inode:[timerfd]>, offset: 0, whence: CUR)
     0.034 pool/2242 syscalls:sys_enter_lseek(fd: 15<anon_inode:[timerfd]>, offset: 0, whence: CUR)
     0.051 pool/2242 syscalls:sys_enter_lseek(fd: 16<anon_inode:[timerfd]>, offset: 0, whence: CUR)
  2307.900 sshd/30800 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libsystemd.so.0.25.0>, offset: 9032, whence: SET)
  #

Were going on forever, since we only had sys_enter events.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0ob1dky1a9ijlfrfhxyl40wr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0294b17ed510..1aaf7b28eec4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2727,12 +2727,6 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 			} else {
 				trace__fprintf_tp_fields(trace, evsel, sample, thread, NULL, 0);
 			}
-			++trace->nr_events_printed;
-
-			if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
-				evsel__disable(evsel);
-				evsel__close(evsel);
-			}
 		}
 	}
 
@@ -2743,6 +2737,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+
+	++trace->nr_events_printed;
+
+	if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
+		evsel__disable(evsel);
+		evsel__close(evsel);
+	}
 out:
 	thread__put(thread);
 	return 0;
-- 
2.21.0
