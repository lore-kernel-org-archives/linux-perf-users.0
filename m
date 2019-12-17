From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/12] perf hists browser: Generalize the do_zoom_dso() function
Date: Tue, 17 Dec 2019 11:48:21 -0300
Message-ID: <20191217144828.2460-6-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll use it to provide a top level hotkey to zoom into the kernel dso
directly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ae9cjel6v05wjnz9r6z77b6x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a4413d983216..8aba1aeea0eb 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2530,11 +2530,8 @@ add_thread_opt(struct hist_browser *browser, struct popup_action *act,
 	return 1;
 }
 
-static int
-do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
+static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map)
 {
-	struct map *map = act->ms.map;
-
 	if (!hists__has(browser->hists, dso) || map == NULL)
 		return 0;
 
@@ -2556,6 +2553,12 @@ do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
 	return 0;
 }
 
+static int
+do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
+{
+	return hists_browser__zoom_map(browser, act->ms.map);
+}
+
 static int
 add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 	    char **optstr, struct map *map)
-- 
2.21.0
