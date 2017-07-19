From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 45/86] perf tests attr: Make compare_data global
Date: Wed, 19 Jul 2017 11:29:09 -0300
Message-ID: <20170719142950.3747-46-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Making compare_data global, so it could be used outside
the Test class scope to compare command results.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.py | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index cdf21a9d0c35..bb671cd1d66a 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -9,6 +9,20 @@ import logging
 import shutil
 import ConfigParser
 
+def compare_data(a, b):
+    # Allow multiple values in assignment separated by '|'
+    a_list = a.split('|')
+    b_list = b.split('|')
+
+    for a_item in a_list:
+        for b_item in b_list:
+            if (a_item == b_item):
+                return True
+            elif (a_item == '*') or (b_item == '*'):
+                return True
+
+    return False
+
 class Fail(Exception):
     def __init__(self, test, msg):
         self.msg = msg
@@ -82,26 +96,12 @@ class Event(dict):
         self.add(base)
         self.add(data)
 
-    def compare_data(self, a, b):
-        # Allow multiple values in assignment separated by '|'
-        a_list = a.split('|')
-        b_list = b.split('|')
-
-        for a_item in a_list:
-            for b_item in b_list:
-                if (a_item == b_item):
-                    return True
-                elif (a_item == '*') or (b_item == '*'):
-                    return True
-
-        return False
-
     def equal(self, other):
         for t in Event.terms:
             log.debug("      [%s] %s %s" % (t, self[t], other[t]));
             if not self.has_key(t) or not other.has_key(t):
                 return False
-            if not self.compare_data(self[t], other[t]):
+            if not compare_data(self[t], other[t]):
                 return False
         return True
 
@@ -109,7 +109,7 @@ class Event(dict):
         for t in Event.terms:
             if not self.has_key(t) or not other.has_key(t):
                 continue
-            if not self.compare_data(self[t], other[t]):
+            if not compare_data(self[t], other[t]):
 		log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
 
 # Test file description needs to have following sections:
@@ -218,9 +218,9 @@ class Test(object):
               self.perf, self.command, tempdir, self.args)
         ret = os.WEXITSTATUS(os.system(cmd))
 
-        log.info("  '%s' ret %d " % (cmd, ret))
+        log.info("  '%s' ret '%s', expected '%s'" % (cmd, str(ret), str(self.ret)))
 
-        if ret != int(self.ret):
+        if not compare_data(str(ret), str(self.ret)):
             raise Unsup(self)
 
     def compare(self, expect, result):
-- 
2.9.4
