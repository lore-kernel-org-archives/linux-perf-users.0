From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/14] perf scripts python: Add Python 3 support to EventClass.py
Date: Wed, 11 Jul 2018 16:42:57 -0400
Message-ID: <20180711204305.12924-7-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Herton Krzesinski <herton@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Support both Python 2 and Python 3 in EventClass.py. ``print`` is now a
function rather than a statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a73aac-e0734bdc-dcab-4c61-8333-d8be97524aa0-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
index 81a56cd2b3c1..21a7a1298094 100755
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
@@ -8,6 +8,7 @@
 # PerfEvent is the base class for all perf event sample, PebsEvent
 # is a HW base Intel x86 PEBS event, and user could add more SW/HW
 # event classes based on requirements.
+from __future__ import print_function
 
 import struct
 
@@ -44,7 +45,8 @@ class PerfEvent(object):
                 PerfEvent.event_num += 1
 
         def show(self):
-                print "PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" % (self.name, self.symbol, self.comm, self.dso)
+                print("PMU event: name=%12s, symbol=%24s, comm=%8s, dso=%12s" %
+                      (self.name, self.symbol, self.comm, self.dso))
 
 #
 # Basic Intel PEBS (Precise Event-based Sampling) event, whose raw buffer
-- 
2.14.4
