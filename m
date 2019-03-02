From: Tony Jones <tonyj@suse.de>
Subject: [PATCH v2 2/7] perf script python: add Python3 support to futex-contention.py
Date: Fri,  1 Mar 2019 17:18:58 -0800
Message-ID: <20190302011903.2416-3-tonyj@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302011903.2416-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Support both Python2 and Python3 in the futex-contention.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/futex-contention.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index f221c62e0a10..0c4841acf75d 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -10,6 +10,8 @@
 #
 # Measures futex contention
 
+from __future__ import print_function
+
 import os, sys
 sys.path.append(os.environ['PERF_EXEC_PATH'] + '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 from Util import *
@@ -33,18 +35,18 @@ def syscalls__sys_enter_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
 
 def syscalls__sys_exit_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
 			     nr, ret):
-	if thread_blocktime.has_key(tid):
+	if tid in thread_blocktime:
 		elapsed = nsecs(s, ns) - thread_blocktime[tid]
 		add_stats(lock_waits, (tid, thread_thislock[tid]), elapsed)
 		del thread_blocktime[tid]
 		del thread_thislock[tid]
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	for (tid, lock) in lock_waits:
 		min, max, avg, count = lock_waits[tid, lock]
-		print "%s[%d] lock %x contended %d times, %d avg ns" % \
-			(process_names[tid], tid, lock, count, avg)
+		print("%s[%d] lock %x contended %d times, %d avg ns" %
+			(process_names[tid], tid, lock, count, avg))
 
-- 
2.16.4
