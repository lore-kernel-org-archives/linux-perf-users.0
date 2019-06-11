From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/85] perf scripts python: exported-sql-viewer.py: Select find text when find bar is activated
Date: Tue, 11 Jun 2019 15:58:11 -0300
Message-ID: <20190611185911.11645-26-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The user probably wants to replace the find text, so select the find
text when the find bar is activated.

That is fairly standard behaviour for search text entry.

Entering text will replace the current text, but using edit keys
(arrows, home, end etc) cancels the selection and enables editing.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-23-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/exported-sql-viewer.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 94489cf2ce0e..6e7934f2ac9a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -400,6 +400,7 @@ class FindBar():
 
 	def Activate(self):
 		self.bar.show()
+		self.textbox.lineEdit().selectAll()
 		self.textbox.setFocus()
 
 	def Deactivate(self):
-- 
2.20.1
