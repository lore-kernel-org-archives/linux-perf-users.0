From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/14] perf scripts python: Add Python 3 support to SchedGui.py
Date: Wed, 11 Jul 2018 16:42:54 -0400
Message-ID: <20180711204305.12924-4-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jeremy Cline <jeremy@jcline.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Herton Krzesinski <herton@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jeremy Cline <jeremy@jcline.org>

Fix a single syntax error in SchedGui.py to support both Python 2 and
Python 3. This should have no functional change.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/0100016341a72d26-75729663-fe55-4309-8c9b-302e065ed2f1-000000@email.amazonses.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
index fdd92f699055..cac7b2542ee8 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
@@ -11,7 +11,7 @@
 try:
 	import wx
 except ImportError:
-	raise ImportError, "You need to install the wxpython lib for this script"
+	raise ImportError("You need to install the wxpython lib for this script")
 
 
 class RootFrame(wx.Frame):
-- 
2.14.4
