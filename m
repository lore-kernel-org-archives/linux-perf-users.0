From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 11/15] perf script python: add Python3 support to stackcollapse.py
Date: Fri, 22 Feb 2019 15:06:15 -0800
Message-ID: <20190222230619.17887-12-tonyj@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222230619.17887-1-tonyj@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, Tony Jones <tonyj@suse.de>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Support both Python2 and Python3 in the stackcollapse.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/perf/scripts/python/stackcollapse.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
index 1697b5e18c96..5e703efaddcc 100755
--- a/tools/perf/scripts/python/stackcollapse.py
+++ b/tools/perf/scripts/python/stackcollapse.py
@@ -19,6 +19,8 @@
 # Written by Paolo Bonzini <pbonzini@redhat.com>
 # Based on Brendan Gregg's stackcollapse-perf.pl script.
 
+from __future__ import print_function
+
 import os
 import sys
 from collections import defaultdict
@@ -120,7 +122,6 @@ def process_event(param_dict):
     lines[stack_string] = lines[stack_string] + 1
 
 def trace_end():
-    list = lines.keys()
-    list.sort()
+    list = sorted(lines)
     for stack in list:
-        print "%s %d" % (stack, lines[stack])
+        print("%s %d" % (stack, lines[stack]))
-- 
2.20.1
