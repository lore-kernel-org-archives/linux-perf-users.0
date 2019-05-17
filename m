From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/73] perf scripts python: exported-sql-viewer.py: Fix error when shrinking / enlarging font
Date: Fri, 17 May 2019 16:35:12 -0300
Message-ID: <20190517193611.4974-15-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fix the following error if shrink / enlarge font is used with the help
window.

  Traceback (most recent call last):
    File "tools/perf/scripts/python/exported-sql-viewer.py", line 2791, in ShrinkFont
      ShrinkFont(win.view)
  AttributeError: 'HelpWindow' object has no attribute 'view'

Committer testing:

Before, matches above output:

  $ python ~acme/libexec/perf-core/scripts/python/exported-sql-viewer.py ~/c/adrian.hunter/simple-retpoline.db
  Traceback (most recent call last):
    File "/home/acme/libexec/perf-core/scripts/python/exported-sql-viewer.py", line 2780, in EnlargeFont
      EnlargeFont(win.view)
  AttributeError: 'HelpWindow' object has no attribute 'view'
  $

After:

No more tracebacks, but the fonts don't get enlarged, which is kinda
frustrating...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190503120828.25326-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index db4655168ab1..fd073e4af8da 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2755,6 +2755,14 @@ class MainWindow(QMainWindow):
 		help_menu = menu.addMenu("&Help")
 		help_menu.addAction(CreateAction("&Exported SQL Viewer Help", "Helpful information", self.Help, self, QKeySequence.HelpContents))
 
+	def Try(self, fn):
+		win = self.mdi_area.activeSubWindow()
+		if win:
+			try:
+				fn(win.view)
+			except:
+				pass
+
 	def Find(self):
 		win = self.mdi_area.activeSubWindow()
 		if win:
@@ -2772,12 +2780,10 @@ class MainWindow(QMainWindow):
 				pass
 
 	def ShrinkFont(self):
-		win = self.mdi_area.activeSubWindow()
-		ShrinkFont(win.view)
+		self.Try(ShrinkFont)
 
 	def EnlargeFont(self):
-		win = self.mdi_area.activeSubWindow()
-		EnlargeFont(win.view)
+		self.Try(EnlargeFont)
 
 	def EventMenu(self, events, reports_menu):
 		branches_events = 0
-- 
2.20.1
