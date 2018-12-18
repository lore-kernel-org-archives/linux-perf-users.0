From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/63] perf trace: Allow configuring if zeroed syscall args should be printed
Date: Tue, 18 Dec 2018 19:07:06 -0300
Message-ID: <20181218220733.15839-37-acme@kernel.org>
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

The default so far, since we show argument names followed by its values,
was to make the output more compact by suppressing most zeroed args.

Make this configurable so that users can choose what best suit their
needs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-q0gxws02ygodh94o0hzim5xd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 2 ++
 tools/perf/builtin-trace.c               | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 423cb41f6e3f..b55bd16c77fe 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -528,6 +528,8 @@ trace.*::
 		The initial use case is to add augmented_raw_syscalls.o to
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
+	trace.show_zeros::
+		Do not suppress syscall arguments that are equal to zero.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d754a74aef46..4d97bdac205c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	bool			show_zeros;
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
@@ -1598,6 +1599,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
  			 * strarray for it.
  			 */
 			if (val == 0 &&
+			    !trace->show_zeros &&
 			    !(sc->arg_fmt &&
 			      (sc->arg_fmt[arg.idx].show_zero ||
 			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
@@ -3526,14 +3528,16 @@ static void trace__set_bpf_map_syscalls(struct trace *trace)
 
 static int trace__config(const char *var, const char *value, void *arg)
 {
+	struct trace *trace = arg;
 	int err = 0;
 
 	if (!strcmp(var, "trace.add_events")) {
-		struct trace *trace = arg;
 		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+	} else if (!strcmp(var, "trace.show_zeros")) {
+		trace->show_zeros = perf_config_bool(var, value);
 	}
 
 	return err;
-- 
2.19.2
