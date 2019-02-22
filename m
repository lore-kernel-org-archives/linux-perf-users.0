From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 08/15] perf script python: add Python3 support to net_dropmonitor.py
Date: Fri, 22 Feb 2019 15:06:12 -0800
Message-ID: <20190222230619.17887-9-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, Tony Jones <tonyj@suse.de>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Neil Horman <nhorman@tuxdriver.com>
List-Id: linux-perf-users.vger.kernel.org

Support both Python2 and Python3 in the net_dropmonitor.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
---
 tools/perf/scripts/python/net_dropmonitor.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index a150164b44a3..212557a02c50 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -1,6 +1,8 @@
 # Monitor the system for dropped packets and proudce a report of drop locations and counts
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -50,19 +52,19 @@ def get_sym(sloc):
 		return (None, 0)
 
 def print_drop_table():
-	print "%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT")
+	print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
 	for i in drop_log.keys():
 		(sym, off) = get_sym(i)
 		if sym == None:
 			sym = i
-		print "%25s %25s %25s" % (sym, off, drop_log[i])
+		print("%25s %25s %25s" % (sym, off, drop_log[i]))
 
 
 def trace_begin():
-	print "Starting trace (Ctrl-C to dump results)"
+	print("Starting trace (Ctrl-C to dump results)")
 
 def trace_end():
-	print "Gathering kallsyms data"
+	print("Gathering kallsyms data")
 	get_kallsyms_table()
 	print_drop_table()
 
-- 
2.20.1
