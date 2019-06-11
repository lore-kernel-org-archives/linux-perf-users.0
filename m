From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/85] perf record: Add support to collect callchains from kernel or user space only
Date: Tue, 11 Jun 2019 15:58:21 -0300
Message-ID: <20190611185911.11645-36-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, yuzhoujian <yuzhoujian@didichuxing.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Milian Wolff <milian.wolff@kdab.com>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

One can just record callchains in the kernel or user space with this new
options.

We can use it together with "--all-kernel" options.

This two options is used just like print_stack(sys) or print_ustack(usr)
for systemtap.

Shown below is the usage of this new option combined with "--all-kernel"
options:

1. Configure all used events to run in kernel space and just collect
   kernel callchains.

  $ perf record -a -g --all-kernel --kernel-callchains

2. Configure all used events to run in kernel space and just collect
   user callchains.

  $ perf record -a -g --all-kernel --user-callchains

Committer notes:

Improved documentation to state that asking for kernel callchains really
is asking for excluding user callchains, and vice versa.

Further mentioned that using both won't get both, but nothing, as both
will be excluded.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1559222962-22891-1-git-send-email-ufo19890607@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 11 +++++++++++
 tools/perf/builtin-record.c              |  4 ++++
 tools/perf/perf.h                        |  2 ++
 tools/perf/util/evsel.c                  |  4 ++++
 4 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index de269430720a..15e0fa87241b 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -490,6 +490,17 @@ Configure all used events to run in kernel space.
 --all-user::
 Configure all used events to run in user space.
 
+--kernel-callchains::
+Collect callchains only from kernel space. I.e. this option sets
+perf_event_attr.exclude_callchain_user to 1.
+
+--user-callchains::
+Collect callchains only from user space. I.e. this option sets
+perf_event_attr.exclude_callchain_kernel to 1.
+
+Don't use both --kernel-callchains and --user-callchains at the same time or no
+callchains will be collected.
+
 --timestamp-filename
 Append timestamp to output file name.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e2c3a585a61e..dca55997934e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2191,6 +2191,10 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN_FLAG(0, "all-user", &record.opts.all_user,
 			 "Configure all used events to run in user space.",
 			 PARSE_OPT_EXCLUSIVE),
+	OPT_BOOLEAN(0, "kernel-callchains", &record.opts.kernel_callchains,
+		    "collect kernel callchains"),
+	OPT_BOOLEAN(0, "user-callchains", &record.opts.user_callchains,
+		    "collect user callchains"),
 	OPT_STRING(0, "clang-path", &llvm_param.clang_path, "clang path",
 		   "clang binary to use for compiling BPF scriptlets"),
 	OPT_STRING(0, "clang-opt", &llvm_param.clang_opt, "clang options",
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index d59dee61b64d..711e009381ec 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -61,6 +61,8 @@ struct record_opts {
 	bool	     record_switch_events;
 	bool	     all_kernel;
 	bool	     all_user;
+	bool	     kernel_callchains;
+	bool	     user_callchains;
 	bool	     tail_synthesize;
 	bool	     overwrite;
 	bool	     ignore_missing_thread;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cc6e7a0dda92..9f3b58071863 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -680,6 +680,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 
 	attr->sample_max_stack = param->max_stack;
 
+	if (opts->kernel_callchains)
+		attr->exclude_callchain_user = 1;
+	if (opts->user_callchains)
+		attr->exclude_callchain_kernel = 1;
 	if (param->record_mode == CALLCHAIN_LBR) {
 		if (!opts->branch_stack) {
 			if (attr->exclude_user) {
-- 
2.20.1
