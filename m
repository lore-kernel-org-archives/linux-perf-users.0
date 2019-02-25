From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/37] perf script python: Add Python3 support to stackcollapse.py
Date: Mon, 25 Feb 2019 18:20:32 -0300
Message-ID: <20190225212035.24781-35-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the stackcollapse.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com> <pbonzini@redhat.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-12-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
