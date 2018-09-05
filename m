From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 73/77] perf trace: Introduce syscall__augmented_args() method
Date: Wed,  5 Sep 2018 19:04:36 -0300
Message-ID: <20180905220440.20256-74-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That will be used by trace__sys_enter when we start combining the
augmented syscalls:sys_enter_FOO + syscalls:sys_exit_FOO.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-iiseo3s0qbf9i3rzn8k597bv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c106189f4066..12356deb6046 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1677,6 +1677,17 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_evsel *evsel,
 	return printed;
 }
 
+static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size)
+{
+	void *augmented_args = NULL;
+
+	*augmented_args_size = sample->raw_size - sc->args_size;
+	if (*augmented_args_size > 0)
+		augmented_args = sample->raw_data + sc->args_size;
+
+	return augmented_args;
+}
+
 static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample)
@@ -1762,10 +1773,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
-	augmented_args_size = sample->raw_size - sc->args_size;
-	if (augmented_args_size > 0)
-		augmented_args = sample->raw_data + sc->args_size;
-
+	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
-- 
2.14.4
