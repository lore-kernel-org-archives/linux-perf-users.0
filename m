From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/86] perf tests attr: Rename compare_data to data_equal
Date: Wed, 19 Jul 2017 11:29:10 -0300
Message-ID: <20170719142950.3747-47-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The data_equal name fits better to the return value of the function.
It's true when the data is equal.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20170703145030.12903-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index bb671cd1d66a..b03261c6b1ed 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -9,7 +9,7 @@ import logging
 import shutil
 import ConfigParser
 
-def compare_data(a, b):
+def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
     a_list = a.split('|')
     b_list = b.split('|')
@@ -101,7 +101,7 @@ class Event(dict):
             log.debug("      [%s] %s %s" % (t, self[t], other[t]));
             if not self.has_key(t) or not other.has_key(t):
                 return False
-            if not compare_data(self[t], other[t]):
+            if not data_equal(self[t], other[t]):
                 return False
         return True
 
@@ -109,7 +109,7 @@ class Event(dict):
         for t in Event.terms:
             if not self.has_key(t) or not other.has_key(t):
                 continue
-            if not compare_data(self[t], other[t]):
+            if not data_equal(self[t], other[t]):
 		log.warning("expected %s=%s, got %s" % (t, self[t], other[t]))
 
 # Test file description needs to have following sections:
@@ -220,7 +220,7 @@ class Test(object):
 
         log.info("  '%s' ret '%s', expected '%s'" % (cmd, str(ret), str(self.ret)))
 
-        if not compare_data(str(ret), str(self.ret)):
+        if not data_equal(str(ret), str(self.ret)):
             raise Unsup(self)
 
     def compare(self, expect, result):
-- 
2.9.4
