From: Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 5/8] perf scripts python: Add Python 3 support to EventClass.py
Date: Tue, 8 May 2018 21:27:48 +0000
Message-ID: <0100016341a73aac-e0734bdc-dcab-4c61-8333-d8be97524aa0-000000@email.amazonses.com>
References: <cover.1525811971.git.jeremy@jcline.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525811971.git.jeremy@jcline.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, "Herton R . Krzesinski" <herton@redhat.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>
List-Id: linux-perf-users.vger.kernel.org

Support both Python 2 and Python 3 in EventClass.py. ``print`` is now a
function rather than a statement. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 .../python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py       | 4 +++-
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
2.17.0
