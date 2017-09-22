From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/44] perf sched timehist: Add pid and tid options
Date: Fri, 22 Sep 2017 11:41:37 -0300
Message-ID: <20170922144220.9411-2-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbdIVOm4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Sep 2017 10:42:56 -0400
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

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
