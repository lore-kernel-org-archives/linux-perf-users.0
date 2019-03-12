From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/30] perf script python: Add Python3 support to exported-sql-viewer.py
Date: Mon, 11 Mar 2019 23:01:49 -0300
Message-ID: <20190312020204.22092-16-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Tony Jones <tonyj@suse.de>, Adrian Hunter <adrian.hunter@intel.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Tony Jones <tonyj@suse.de>

Support both Python2 and Python3 in the exported-sql-viewer.py script.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20190309000518.2438-2-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../scripts/python/exported-sql-viewer.py     | 42 ++++++++++++-------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index afec9479ca7f..e38518cdcbc3 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -88,11 +88,20 @@
 #                                                                              7fab593ea956 48 89 15 3b 13 22 00                            movq  %rdx, 0x22133b(%rip)
 # 8107675243232  2    ls       22011  22011  hardware interrupt     No         7fab593ea956 _dl_start+0x26 (ld-2.19.so) -> ffffffff86a012e0 page_fault ([kernel])
 
+from __future__ import print_function
+
 import sys
 import weakref
 import threading
 import string
-import cPickle
+try:
+	# Python2
+	import cPickle as pickle
+	# size of pickled integer big enough for record size
+	glb_nsz = 8
+except ImportError:
+	import pickle
+	glb_nsz = 16
 import re
 import os
 from PySide.QtCore import *
@@ -102,6 +111,15 @@ from decimal import *
 from ctypes import *
 from multiprocessing import Process, Array, Value, Event
 
+# xrange is range in Python3
+try:
+	xrange
+except NameError:
+	xrange = range
+
+def printerr(*args, **keyword_args):
+	print(*args, file=sys.stderr, **keyword_args)
+
 # Data formatting helpers
 
 def tohex(ip):
@@ -1004,10 +1022,6 @@ class ChildDataItemFinder():
 
 glb_chunk_sz = 10000
 
-# size of pickled integer big enough for record size
-
-glb_nsz = 8
-
 # Background process for SQL data fetcher
 
 class SQLFetcherProcess():
@@ -1066,7 +1080,7 @@ class SQLFetcherProcess():
 				return True
 			if space >= glb_nsz:
 				# Use 0 (or space < glb_nsz) to mean there is no more at the top of the buffer
-				nd = cPickle.dumps(0, cPickle.HIGHEST_PROTOCOL)
+				nd = pickle.dumps(0, pickle.HIGHEST_PROTOCOL)
 				self.buffer[self.local_head : self.local_head + len(nd)] = nd
 			self.local_head = 0
 		if self.local_tail - self.local_head > sz:
@@ -1084,9 +1098,9 @@ class SQLFetcherProcess():
 			self.wait_event.wait()
 
 	def AddToBuffer(self, obj):
-		d = cPickle.dumps(obj, cPickle.HIGHEST_PROTOCOL)
+		d = pickle.dumps(obj, pickle.HIGHEST_PROTOCOL)
 		n = len(d)
-		nd = cPickle.dumps(n, cPickle.HIGHEST_PROTOCOL)
+		nd = pickle.dumps(n, pickle.HIGHEST_PROTOCOL)
 		sz = n + glb_nsz
 		self.WaitForSpace(sz)
 		pos = self.local_head
@@ -1198,12 +1212,12 @@ class SQLFetcher(QObject):
 		pos = self.local_tail
 		if len(self.buffer) - pos < glb_nsz:
 			pos = 0
-		n = cPickle.loads(self.buffer[pos : pos + glb_nsz])
+		n = pickle.loads(self.buffer[pos : pos + glb_nsz])
 		if n == 0:
 			pos = 0
-			n = cPickle.loads(self.buffer[0 : glb_nsz])
+			n = pickle.loads(self.buffer[0 : glb_nsz])
 		pos += glb_nsz
-		obj = cPickle.loads(self.buffer[pos : pos + n])
+		obj = pickle.loads(self.buffer[pos : pos + n])
 		self.local_tail = pos + n
 		return obj
 
@@ -2973,7 +2987,7 @@ class DBRef():
 
 def Main():
 	if (len(sys.argv) < 2):
-		print >> sys.stderr, "Usage is: exported-sql-viewer.py {<database name> | --help-only}"
+		printerr("Usage is: exported-sql-viewer.py {<database name> | --help-only}");
 		raise Exception("Too few arguments")
 
 	dbname = sys.argv[1]
@@ -2986,8 +3000,8 @@ def Main():
 
 	is_sqlite3 = False
 	try:
-		f = open(dbname)
-		if f.read(15) == "SQLite format 3":
+		f = open(dbname, "rb")
+		if f.read(15) == b'SQLite format 3':
 			is_sqlite3 = True
 		f.close()
 	except:
-- 
2.20.1
