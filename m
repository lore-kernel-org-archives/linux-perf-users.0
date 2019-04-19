From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/7] perf top: Always sample time to satisfy needs of use of ordered queuing
Date: Fri, 19 Apr 2019 09:30:23 -0300
Message-ID: <20190419123029.11328-2-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Bastian Beischer <bastian.beischer@rwth-aachen.de>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Bastian reported broken 'perf top -p PID' command, it won't display any
data.

The problem is that for -p option we monitor single thread, so we don't
enable time in samples, because it's not needed.

However since commit 16c66bc167cc we use ordered queues to stash data
plus later commits added logic for dropping samples in case there's big
load and we don't keep up. All this needs timestamp for sample. Enabling
it unconditionally for perf top.

Reported-by: Bastian Beischer <bastian.beischer@rwth-aachen.de>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: bastian beischer <bastian.beischer@rwth-aachen.de>
Fixes: 16c66bc167cc ("perf top: Add processing thread")
Link: http://lkml.kernel.org/r/20190415125333.27160-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1999d6533d12..fbbb0da43abb 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1377,6 +1377,7 @@ int cmd_top(int argc, const char **argv)
 			 * */
 			.overwrite	= 0,
 			.sample_time	= true,
+			.sample_time_set = true,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
-- 
2.20.1
