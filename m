From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/15] perf config: Document missing config options
Date: Fri, 28 Feb 2020 11:00:09 -0300
Message-ID: <20200228140014.1236-11-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Changbin Du <changbin.du@intel.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Song Liu <songliubraving@fb.com>, Taeung Song <treeze.taeung@gmail.com>, Thomas Richter <tmricht@linux.ibm.com>, Yisheng Xie <xieyisheng1@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

While documenting annotate.show_nr_samples config option, I found many
other config options missing in perf-config documentation. Add them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-9-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 9dae0df3ab7e..8ead55593984 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -518,6 +518,12 @@ top.*::
 		column by default.
 		The default is 'true'.
 
+	top.call-graph::
+		This is identical to 'call-graph.record-mode', except it is
+		applicable only for 'top' subcommand. This option ONLY setup
+		the unwind method. To enable 'perf top' to actually use it,
+		the command line option -g must be specified.
+
 man.*::
 	man.viewer::
 		This option can assign a tool to view manual pages when 'help'
@@ -545,6 +551,16 @@ record.*::
 		But if this option is 'no-cache', it will not update the build-id cache.
 		'skip' skips post-processing and does not update the cache.
 
+	record.call-graph::
+		This is identical to 'call-graph.record-mode', except it is
+		applicable only for 'record' subcommand. This option ONLY setup
+		the unwind method. To enable 'perf record' to actually use it,
+		the command line option -g must be specified.
+
+	record.aio::
+		Use 'n' control blocks in asynchronous (Posix AIO) trace writing
+		mode ('n' default: 1, max: 4).
+
 diff.*::
 	diff.order::
 		This option sets the number of columns to sort the result.
@@ -594,6 +610,11 @@ trace.*::
 		"libbeauty", the default, to use the same argument beautifiers used in the
 		strace-like sys_enter+sys_exit lines.
 
+ftrace.*::
+	ftrace.tracer::
+		Can be used to select the default tracer. Possible values are
+		'function' and 'function_graph'.
+
 llvm.*::
 	llvm.clang-path::
 		Path to clang. If omit, search it from $PATH.
@@ -638,6 +659,29 @@ scripts.*::
 	The script gets the same options passed as a full perf script,
 	in particular -i perfdata file, --cpu, --tid
 
+convert.*::
+
+	convert.queue-size::
+		Limit the size of ordered_events queue, so we could control
+		allocation size of perf data files without proper finished
+		round events.
+
+intel-pt.*::
+
+	intel-pt.cache-divisor::
+
+	intel-pt.mispred-all::
+		If set, Intel PT decoder will set the mispred flag on all
+		branches.
+
+auxtrace.*::
+
+	auxtrace.dumpdir::
+		s390 only. The directory to save the auxiliary trace buffer
+		can be changed using this option. Ex, auxtrace.dumpdir=/tmp.
+		If the directory does not exist or has the wrong file type,
+		the current directory is used.
+
 SEE ALSO
 --------
 linkperf:perf[1]
-- 
2.21.1
