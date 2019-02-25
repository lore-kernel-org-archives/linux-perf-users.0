From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/37] perf script python: Add Python3 support to powerpc-hcalls.py
Date: Mon, 25 Feb 2019 18:20:30 -0300
Message-ID: <20190225212035.24781-33-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the powerpc-hcalls.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-10-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/powerpc-hcalls.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 00e0e7476e55..8b78dc790adb 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -4,6 +4,8 @@
 #
 # Hypervisor call statisics
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -149,7 +151,7 @@ hcall_table = {
 }
 
 def hcall_table_lookup(opcode):
-	if (hcall_table.has_key(opcode)):
+	if (opcode in hcall_table):
 		return hcall_table[opcode]
 	else:
 		return opcode
@@ -157,8 +159,8 @@ def hcall_table_lookup(opcode):
 print_ptrn = '%-28s%10s%10s%10s%10s'
 
 def trace_end():
-	print print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)')
-	print '-' * 68
+	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
+	print('-' * 68)
 	for opcode in output:
 		h_name = hcall_table_lookup(opcode)
 		time = output[opcode]['time']
@@ -166,14 +168,14 @@ def trace_end():
 		min_t = output[opcode]['min']
 		max_t = output[opcode]['max']
 
-		print print_ptrn % (h_name, cnt, min_t, max_t, time/cnt)
+		print(print_ptrn % (h_name, cnt, min_t, max_t, time//cnt))
 
 def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 			opcode, retval):
-	if (d_enter.has_key(cpu) and d_enter[cpu].has_key(opcode)):
+	if (cpu in d_enter and opcode in d_enter[cpu]):
 		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
 
-		if (output.has_key(opcode)):
+		if (opcode in output):
 			output[opcode]['time'] += diff
 			output[opcode]['cnt'] += 1
 			if (output[opcode]['min'] > diff):
@@ -190,11 +192,11 @@ def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 
 		del d_enter[cpu][opcode]
 #	else:
-#		print "Can't find matching hcall_enter event. Ignoring sample"
+#		print("Can't find matching hcall_enter event. Ignoring sample")
 
 def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
 			 callchain, opcode):
-		if (d_enter.has_key(cpu)):
+		if (cpu in d_enter):
 			d_enter[cpu][opcode] = nsecs(sec, nsec)
 		else:
 			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
-- 
2.20.1
