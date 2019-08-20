From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/17] perf ui: Introduce non-interactive ui__info_window() function
Date: Tue, 20 Aug 2019 16:27:29 -0300
Message-ID: <20190820192733.19180-14-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Sometimes we want just to print a message on the center of the screen,
like in 'perf top' while we wait for the minimum amount of samples to be
collected before sorting and showing them.

Also expose __ui__info_window() as an optimization for cases where such
message is to be printed while holding the ui lock.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uat0f89vfwl2w52kv9wzwd8a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/tui/util.c | 23 +++++++++++++++--------
 tools/perf/ui/util.h     |  2 ++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 5d65ea8b6496..1163df8b6f06 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -162,8 +162,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 	return key;
 }
 
-int ui__question_window(const char *title, const char *text,
-			const char *exit_msg, int delay_secs)
+void __ui__info_window(const char *title, const char *text, const char *exit_msg)
 {
 	int x, y;
 	int max_len = 0, nr_lines = 0;
@@ -185,8 +184,6 @@ int ui__question_window(const char *title, const char *text,
 		t = sep + 1;
 	}
 
-	pthread_mutex_lock(&ui__lock);
-
 	max_len += 2;
 	nr_lines += 2;
 	if (exit_msg)
@@ -206,19 +203,29 @@ int ui__question_window(const char *title, const char *text,
 	max_len -= 2;
 	SLsmg_write_wrapped_string((unsigned char *)text, y, x,
 				   nr_lines, max_len, 1);
-	SLsmg_gotorc(y + nr_lines - 2, x);
-	SLsmg_write_nstring((char *)" ", max_len);
-	SLsmg_gotorc(y + nr_lines - 1, x);
 	if (exit_msg) {
 		SLsmg_gotorc(y + nr_lines - 2, x);
 		SLsmg_write_nstring((char *)" ", max_len);
 		SLsmg_gotorc(y + nr_lines - 1, x);
 		SLsmg_write_nstring((char *)exit_msg, max_len);
 	}
-	SLsmg_refresh();
+}
 
+void ui__info_window(const char *title, const char *text)
+{
+	pthread_mutex_lock(&ui__lock);
+	__ui__info_window(title, text, NULL);
+	SLsmg_refresh();
 	pthread_mutex_unlock(&ui__lock);
+}
 
+int ui__question_window(const char *title, const char *text,
+			const char *exit_msg, int delay_secs)
+{
+	pthread_mutex_lock(&ui__lock);
+	__ui__info_window(title, text, exit_msg);
+	SLsmg_refresh();
+	pthread_mutex_unlock(&ui__lock);
 	return ui__getch(delay_secs);
 }
 
diff --git a/tools/perf/ui/util.h b/tools/perf/ui/util.h
index 5e44223b56fa..40891942f465 100644
--- a/tools/perf/ui/util.h
+++ b/tools/perf/ui/util.h
@@ -8,6 +8,8 @@ int ui__getch(int delay_secs);
 int ui__popup_menu(int argc, char * const argv[]);
 int ui__help_window(const char *text);
 int ui__dialog_yesno(const char *msg);
+void __ui__info_window(const char *title, const char *text, const char *exit_msg);
+void ui__info_window(const char *title, const char *text);
 int ui__question_window(const char *title, const char *text,
 			const char *exit_msg, int delay_secs);
 
-- 
2.21.0
