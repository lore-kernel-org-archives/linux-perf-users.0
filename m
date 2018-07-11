From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/14] perf script python: Fix dict reference counting
Date: Wed, 11 Jul 2018 16:43:04 -0400
Message-ID: <20180711204305.12924-14-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Janne Huttunen <janne.huttunen@nokia.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jaroslav Skarvada <jskarvad@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Janne Huttunen <janne.huttunen@nokia.com>

The dictionaries are attached to the parameter tuple that steals the
references and takes care of releasing them when appropriate.  The code
should not decrement the reference counts explicitly.  E.g. if libpython
has been built with reference debugging enabled, the superfluous DECREFs
will trigger this error when running perf script:

  Fatal Python error: Objects/tupleobject.c:238 object at
  0x7f10f2041b40 has negative ref count -1
  Aborted (core dumped)

If the reference debugging is not enabled, the superfluous DECREFs might
cause the dict objects to be silently released while they are still in
use. This may trigger various other assertions or just cause perf
crashes and/or weird and unexpected data changes in the stored Python
objects.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jaroslav Skarvada <jskarvad@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1531133990-17485-1-git-send-email-janne.huttunen@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8b2eb6dbff4d..bc32e57d17be 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -908,14 +908,11 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	if (_PyTuple_Resize(&t, n) == -1)
 		Py_FatalError("error resizing Python tuple");
 
-	if (!dict) {
+	if (!dict)
 		call_object(handler, t, handler_name);
-	} else {
+	else
 		call_object(handler, t, default_handler_name);
-		Py_DECREF(dict);
-	}
 
-	Py_XDECREF(all_entries_dict);
 	Py_DECREF(t);
 }
 
@@ -1235,7 +1232,6 @@ static void python_process_general_event(struct perf_sample *sample,
 
 	call_object(handler, t, handler_name);
 
-	Py_DECREF(dict);
 	Py_DECREF(t);
 }
 
-- 
2.14.4
