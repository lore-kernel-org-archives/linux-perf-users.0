From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/44] perf ui progress: Add size info into progress bar
Date: Fri, 22 Sep 2017 11:41:53 -0300
Message-ID: <20170922144220.9411-18-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding the size values '[current/total]' into progress bar, to show more
detailed progress of data reading.

Adding new ui_progress__init_size function to specify we want to display
the size.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170908120510.22515-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/progress.c     |  4 +++-
 tools/perf/ui/progress.h     | 11 ++++++++++-
 tools/perf/ui/tui/progress.c | 23 ++++++++++++++++++++++-
 tools/perf/util/session.c    |  2 +-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/progress.c b/tools/perf/ui/progress.c
index 3e2b5d64c55e..7ade387d511c 100644
--- a/tools/perf/ui/progress.c
+++ b/tools/perf/ui/progress.c
@@ -27,12 +27,14 @@ void ui_progress__update(struct ui_progress *p, u64 adv)
 	}
 }
 
-void ui_progress__init(struct ui_progress *p, u64 total, const char *title)
+void __ui_progress__init(struct ui_progress *p, u64 total,
+			 const char *title, bool size)
 {
 	p->curr = 0;
 	p->next = p->step = total / 16 ?: 1;
 	p->total = total;
 	p->title = title;
+	p->size  = size;
 
 	if (ui_progress__ops->init)
 		ui_progress__ops->init(p);
diff --git a/tools/perf/ui/progress.h b/tools/perf/ui/progress.h
index e5f434a2070b..fbaa1507ebfe 100644
--- a/tools/perf/ui/progress.h
+++ b/tools/perf/ui/progress.h
@@ -8,9 +8,18 @@ void ui_progress__finish(void);
 struct ui_progress {
 	const char *title;
 	u64 curr, next, step, total;
+	bool size;
 };
 
-void ui_progress__init(struct ui_progress *p, u64 total, const char *title);
+void __ui_progress__init(struct ui_progress *p, u64 total,
+			 const char *title, bool size);
+
+#define ui_progress__init(p, total, title) \
+	__ui_progress__init(p, total, title, false)
+
+#define ui_progress__init_size(p, total, title) \
+	__ui_progress__init(p, total, title, true)
+
 void ui_progress__update(struct ui_progress *p, u64 adv);
 
 struct ui_progress_ops {
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index f6b8f52aad7e..68f6144ea603 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -1,8 +1,10 @@
+#include <linux/kernel.h>
 #include "../cache.h"
 #include "../progress.h"
 #include "../libslang.h"
 #include "../ui.h"
 #include "tui.h"
+#include "units.h"
 #include "../browser.h"
 
 static void __tui_progress__init(struct ui_progress *p)
@@ -10,8 +12,22 @@ static void __tui_progress__init(struct ui_progress *p)
 	p->next = p->step = p->total / (SLtt_Screen_Cols - 2) ?: 1;
 }
 
+static int get_title(struct ui_progress *p, char *buf, size_t size)
+{
+	char buf_cur[20];
+	char buf_tot[20];
+	int ret;
+
+	ret  = unit_number__scnprintf(buf_cur, sizeof(buf_cur), p->curr);
+	ret += unit_number__scnprintf(buf_tot, sizeof(buf_tot), p->total);
+
+	return ret + scnprintf(buf, size, "%s [%s/%s]",
+			       p->title, buf_cur, buf_tot);
+}
+
 static void tui_progress__update(struct ui_progress *p)
 {
+	char buf[100], *title = (char *) p->title;
 	int bar, y;
 	/*
 	 * FIXME: We should have a per UI backend way of showing progress,
@@ -23,13 +39,18 @@ static void tui_progress__update(struct ui_progress *p)
 	if (p->total == 0)
 		return;
 
+	if (p->size) {
+		get_title(p, buf, sizeof(buf));
+		title = buf;
+	}
+
 	ui__refresh_dimensions(false);
 	pthread_mutex_lock(&ui__lock);
 	y = SLtt_Screen_Rows / 2 - 2;
 	SLsmg_set_color(0);
 	SLsmg_draw_box(y, 0, 3, SLtt_Screen_Cols);
 	SLsmg_gotorc(y++, 1);
-	SLsmg_write_string((char *)p->title);
+	SLsmg_write_string(title);
 	SLsmg_fill_region(y, 1, 1, SLtt_Screen_Cols - 2, ' ');
 	SLsmg_set_color(HE_COLORSET_SELECTED);
 	bar = ((SLtt_Screen_Cols - 2) * p->curr) / p->total;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a7ebd9fe8e40..ceac0848469d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1847,7 +1847,7 @@ static int __perf_session__process_events(struct perf_session *session,
 	if (data_offset + data_size < file_size)
 		file_size = data_offset + data_size;
 
-	ui_progress__init(&prog, file_size, "Processing events...");
+	ui_progress__init_size(&prog, file_size, "Processing events...");
 
 	mmap_size = MMAP_SIZE;
 	if (mmap_size > file_size) {
-- 
2.13.5
