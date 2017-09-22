From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/44] perf ui progress: Add ui specific init function
Date: Fri, 22 Sep 2017 11:41:52 -0300
Message-ID: <20170922144220.9411-17-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding ui specific init function allowing to setup the progress bar
width based on current screen scales.

Adding TUI init function to get more grained update of the progress bar.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170908120510.22515-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/progress.c     | 2 ++
 tools/perf/ui/progress.h     | 1 +
 tools/perf/ui/tui/progress.c | 9 +++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
index ae91c8148edf..3e2b5d64c55e 100644
--- a/tools/perf/ui/progress.c
+++ b/tools/perf/ui/progress.c
@@ -34,6 +34,8 @@ void ui_progress__init(struct ui_progress *p, u64 total, const char *title)
 	p->total = total;
 	p->title = title;
 
+	if (ui_progress__ops->init)
+		ui_progress__ops->init(p);
 }
 
 void ui_progress__finish(void)
diff --git a/tools/perf/ui/progress.h b/tools/perf/ui/progress.h
index 717d39d3052b..e5f434a2070b 100644
--- a/tools/perf/ui/progress.h
+++ b/tools/perf/ui/progress.h
@@ -14,6 +14,7 @@ void ui_progress__init(struct ui_progress *p, u64 total, const char *title);
 void ui_progress__update(struct ui_progress *p, u64 adv);
 
 struct ui_progress_ops {
+	void (*init)(struct ui_progress *p);
 	void (*update)(struct ui_progress *p);
 	void (*finish)(void);
 };
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index c4b99008e2c9..f6b8f52aad7e 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -5,6 +5,11 @@
 #include "tui.h"
 #include "../browser.h"
 
+static void __tui_progress__init(struct ui_progress *p)
+{
+	p->next = p->step = p->total / (SLtt_Screen_Cols - 2) ?: 1;
+}
+
 static void tui_progress__update(struct ui_progress *p)
 {
 	int bar, y;
@@ -49,8 +54,8 @@ static void tui_progress__finish(void)
 	pthread_mutex_unlock(&ui__lock);
 }
 
-static struct ui_progress_ops tui_progress__ops =
-{
+static struct ui_progress_ops tui_progress__ops = {
+	.init   = __tui_progress__init,
 	.update = tui_progress__update,
 	.finish = tui_progress__finish,
 };
-- 
2.13.5
