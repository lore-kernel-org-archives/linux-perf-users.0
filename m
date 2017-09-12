From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/41] perf sched timehist: Add pid and tid options
Date: Tue, 12 Sep 2017 12:09:49 -0300
Message-ID: <20170912151029.6612-2-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Add options to only show event for specific pid(s) and tid(s).

Signed-off-by: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/1504288152-19690-1-git-send-email-dsahern@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-sched.txt | 8 ++++++++
 tools/perf/builtin-sched.c              | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index a092a2499e8f..55b67338548e 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -106,6 +106,14 @@ OPTIONS for 'perf sched timehist'
 --max-stack::
 	Maximum number of functions to display in backtrace, default 5.
 
+-p=::
+--pid=::
+	Only show events for given process ID (comma separated list).
+
+-t=::
+--tid=::
+	Only show events for given thread ID (comma separated list).
+
 -s::
 --summary::
     Show only a summary of scheduling by thread with min, max, and average
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 322b4def8411..b7e8812ee80c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3363,6 +3363,10 @@ int cmd_sched(int argc, const char **argv)
 	OPT_STRING(0, "time", &sched.time_str, "str",
 		   "Time span for analysis (start,stop)"),
 	OPT_BOOLEAN(0, "state", &sched.show_state, "Show task state when sched-out"),
+	OPT_STRING('p', "pid", &symbol_conf.pid_list_str, "pid[,pid...]",
+		   "analyze events only for given process id(s)"),
+	OPT_STRING('t', "tid", &symbol_conf.tid_list_str, "tid[,tid...]",
+		   "analyze events only for given thread id(s)"),
 	OPT_PARENT(sched_options)
 	};
 
-- 
2.13.5
