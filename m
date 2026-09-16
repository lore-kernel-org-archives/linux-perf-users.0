Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EA4EE85B;
	Wed, 16 Sep 2026 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559308; cv=none; b=tCTb47L+GFQhdZ3OHbFMrGfEQnYjdr/HFa/wG8KT+0qzKY+oThnLn5nsS2Tj/gv3Qb0sThXrvd/Tu1kqo1rtlHv9ri16iKVRIKpZpUeSgK7Z9wHjITgYuomnKWHbt34b3ikis5HdYWCLhFpAYajqK4eFlB733KPoZbsD++/qZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559308; c=relaxed/simple;
	bh=Bd2K/rqZn6g+lgvp2xT3sh0Dn+kx24gKxAFoEyZyDew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1f5Y3G7TN0rIXxKhqutblH4QluSLzlUluNDBH5DA7vbs6TNgTMzfZINRsHXnT1a2m805MMTVONR7WIiAoSsB7sLpJo8ov0SYI6VGM4NIzo0Tq+Sbuu0MMPFhhfAI59ltO/6mzZNeNxwEQPr86zw/34YK+PL6f+nL+G4dmfuO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qgaa5A1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgaa5A1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5080F1F0089A;
	Wed, 16 Sep 2026 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559293;
	bh=tyorP+8dHgC23zrQXtgg7WR8CCFWQiokgDbNUQmf/Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qgaa5A1oUz06cT0sFlHxJw7+Jz3oHbg+DlY8R13PiESL03LZFJZGQ2fF+AZxQHGsh
	 jhkXSrEhzP4UwCmOf13hu5/FA/T34VDu/HNldv7sN1RxxJgWOmOI6LK4ZadiPxqecJ
	 ZKBtRS5jTxAKqymbAP4107STm+eFNYZ7YOdmbmQ/0ASjX7rZLdpTe9OGWGkN005cF5
	 hnJygoFtRUZ1p5y+RgivZXEli4nMe35tNXuY320WFKgukk1eTFgDfYm+y6lKROOLCN
	 P21Qp1OJuv3qhwRFr4nlFRGWVpUETt1ZapkdAO8khPUOtH4BkqfyL5NNnhG0g3tQtY
	 FsDQQ6flhJ8Dw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/12] perf debuginfo: Show the debuginfod fetch progress and keys in the TUI
Date: Wed, 16 Sep 2026 08:47:32 -0300
Message-ID: <20260916114740.48230-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916114740.48230-1-acme@kernel.org>
References: <20260916114740.48230-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The stdio only fetch UI left a fetch in progress in the TUI with
nothing on screen, indistinguishable from perf being stuck, with no way
out of it: the browser thread is the one doing the fetch, so it draws a
window over itself with the fetch progress and drains the 's'/'d' keys
from the input queue it owns, via the new ui__key_pending()/
ui__key_read()/ui__progress_window()/ui__progress_window_end()
primitives declared in ui/util.h and implemented in ui/tui/util.c, with
inline no-ops for builds without slang, keeping callers free of #ifdefs:
slang stays behind the ui/ layer, as the plan is to reduce the number of
libraries perf needs to build, or swap slang for something else, such as
ncurses, at some point.  No terminal settings or signal dispositions are
touched in that case: the terminal is the TUI's own and so are the
SIGINT/SIGTERM handlers, that restore it before exiting.

The text in the window is word wrapped to the available columns, so
that constrained terminals, such as a smartphone running termux, get
all of it, including the 'd' option hint, instead of having the tail of
the long progress line cropped; the title line is written without
padding, so that the box border characters fill the rest of it.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |   9 +-
 tools/perf/Documentation/perf-top.txt    |   5 +-
 tools/perf/ui/tui/util.c                 | 177 +++++++++++++++++++++++
 tools/perf/ui/util.h                     |  42 ++++++
 tools/perf/util/debuginfo.c              |  64 ++++++--
 5 files changed, 277 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 0a821490d6a0f895..0a4f61283b9542f7 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -378,10 +378,11 @@ OPTIONS
 	'd' skips it and disables debuginfod for the rest of the
 	session, writing core.debuginfod=false to the configuration
 	file so that it stays disabled in the next runs too; in the
-	stdio interface the progress is a line on stderr.  It is
-	disabled as well when the local build-id cache is turned off,
-	e.g. "buildid.dir" set to /dev/null, as that asks for fetched
-	files not to be kept on the box.
+	stdio interface the progress is a line on stderr, in the TUI a
+	window over the browser.  It is disabled as well when the local
+	build-id cache is turned off, e.g. "buildid.dir" set to
+	/dev/null, as that asks for fetched files not to be kept on the
+	box.
 
 --kallsyms=<file>::
         kallsyms pathname
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index f38b54267125cb08..3ab8121480175b51 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -95,8 +95,9 @@ Default is to monitor all CPUS.
 	disables debuginfod for the rest of the session, writing
 	core.debuginfod=false to the configuration file so that it
 	stays disabled in the next runs too; in the stdio interface the
-	progress is a line on stderr.  Disabled as well when the
-	build-id cache is off, e.g. "buildid.dir" set to /dev/null.
+	progress is a line on stderr, in the TUI a window over the
+	browser.  Disabled as well when the build-id cache is off, e.g.
+	"buildid.dir" set to /dev/null.
 
 --kallsyms=<file>::
 	kallsyms pathname
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index e4d322ce0b54cbc6..c3274b92b0e22d73 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <sys/ttydefaults.h>
+#include <linux/kernel.h>
 
 #include "../browser.h"
 #include "../keysyms.h"
@@ -11,6 +12,7 @@
 #include "../ui.h"
 #include "../util.h"
 #include "../libslang.h"
+#include "units.h"
 
 static void ui_browser__argv_write(struct ui_browser *browser,
 				   void *entry, int row)
@@ -272,3 +274,178 @@ struct perf_error_ops perf_tui_eops = {
 	.error		= perf_tui__error,
 	.warning	= perf_tui__warning,
 };
+
+/*
+ * The debuginfod fetch progress window, drawn over the browser while a
+ * fetch that can be big, such as the vmlinux for a kernel profiled on
+ * another machine, is in progress: with nothing on screen the browser
+ * looks hung, which is what makes users interrupt perf, see
+ * util/debuginfo.c, that polls the 's'/'d' keys with ui__key_pending()
+ * /ui__key_read().
+ *
+ * The client calls the progress callback at every write chunk, so only
+ * redraw when the fetched bytes change: a resize is picked up by the
+ * ui__refresh_dimensions() on the next redraw, and taking the window
+ * down erases exactly the rows it was drawn at, saved at draw time.
+ *
+ * The text is word wrapped to the available columns: constrained
+ * terminals, such as a smartphone running termux, have far fewer of
+ * them and would crop the tail of a long line, hiding the 'd' option,
+ * leaving no visible way out of the fetch.
+ */
+#define PROGRESS_WINDOW_MAX_LINES 12
+
+static bool progress_window__shown;
+static char progress_window__bytes[64];
+static int progress_window__y, progress_window__rows;
+
+/*
+ * Word wrap @text, on spaces, into lines of at most @width characters,
+ * breaking words that don't fit whole, returning the number of lines.
+ */
+static int progress_window__wrap(const char *text, int width,
+				 char lines[PROGRESS_WINDOW_MAX_LINES][256])
+{
+	int nr_lines = 0;
+	const char *p = text;
+
+	while (*p && nr_lines < PROGRESS_WINDOW_MAX_LINES) {
+		char *line = lines[nr_lines++];
+		int len = 0;
+		bool space = false;
+
+		line[0] = '\0';
+		while (*p) {
+			const char *word;
+			int wlen, avail;
+
+			while (*p == ' ' || *p == '\n')
+				++p;
+			if (*p == '\0')
+				break;
+			word = p;
+			while (*p && *p != ' ' && *p != '\n')
+				++p;
+			wlen = p - word;
+			avail = width - len - (space ? 1 : 0);
+			if (wlen > avail) {
+				if (len > 0) {
+					p = word;
+					break;
+				}
+				if (avail > 0) {
+					/* The word doesn't fit whole */
+					memcpy(line, word, avail);
+					len = avail;
+					line[len] = '\0';
+					p = word + avail;
+				}
+				break;
+			}
+			if (space)
+				line[len++] = ' ';
+			memcpy(line + len, word, wlen);
+			len += wlen;
+			line[len] = '\0';
+			space = true;
+		}
+	}
+
+	return nr_lines;
+}
+
+void ui__progress_window(const char *title, const char *text,
+			 u64 fetched, u64 total)
+{
+	static char lines[PROGRESS_WINDOW_MAX_LINES][256];
+	char buf_cur[20], buf_tot[20], bytes[64];
+	size_t len;
+	int y, height, nr_lines, inner, i;
+
+	if (use_browser != 1)
+		return;
+
+	unit_number__scnprintf(buf_cur, sizeof(buf_cur), fetched);
+	if (total) {
+		unit_number__scnprintf(buf_tot, sizeof(buf_tot), total);
+		scnprintf(bytes, sizeof(bytes), "  %s / %s fetched",
+			  buf_cur, buf_tot);
+	} else {
+		scnprintf(bytes, sizeof(bytes),
+			  "  %s fetched, size unknown", buf_cur);
+	}
+
+	if (progress_window__shown && !strcmp(bytes, progress_window__bytes))
+		return;
+
+	scnprintf(progress_window__bytes, sizeof(progress_window__bytes),
+		  "%s", bytes);
+	progress_window__shown = true;
+
+	ui__refresh_dimensions(false);
+	mutex_lock(&ui__lock);
+	inner = SLtt_Screen_Cols - 2;
+	if (inner > 255)
+		inner = 255;
+	nr_lines = progress_window__wrap(text, inner, lines);
+	height = nr_lines + 3;
+
+	SLsmg_set_color(0);
+	if (progress_window__rows)
+		SLsmg_fill_region(progress_window__y, 0, progress_window__rows,
+				  SLtt_Screen_Cols, ' ');
+	y = (SLtt_Screen_Rows - height) / 2;
+	if (y < 0)
+		y = 0;
+	progress_window__y = y;
+	progress_window__rows = height;
+
+	SLsmg_draw_box(y, 0, height, SLtt_Screen_Cols);
+	SLsmg_gotorc(y++, 1);
+	len = strlen(title);
+	if (len > (size_t)inner)
+		len = inner;
+	SLsmg_write_nchars(title, len);
+	for (i = 0; i < nr_lines; i++, y++) {
+		SLsmg_gotorc(y, 1);
+		SLsmg_write_nstring(lines[i], SLtt_Screen_Cols - 2);
+	}
+	SLsmg_gotorc(y, 1);
+	SLsmg_write_nstring(bytes, SLtt_Screen_Cols - 2);
+	SLsmg_refresh();
+	mutex_unlock(&ui__lock);
+}
+
+void ui__progress_window_end(void)
+{
+	if (!progress_window__shown || use_browser != 1)
+		return;
+
+	progress_window__shown = false;
+	progress_window__bytes[0] = '\0';
+
+	mutex_lock(&ui__lock);
+	SLsmg_set_color(0);
+	SLsmg_fill_region(progress_window__y, 0, progress_window__rows,
+			  SLtt_Screen_Cols, ' ');
+	progress_window__rows = 0;
+	SLsmg_refresh();
+	mutex_unlock(&ui__lock);
+}
+
+/*
+ * The keys typed while the fetch blocks the thread that runs the
+ * browser are in the TUI input queue: nobody else is reading it, the
+ * browser is the thread doing the fetch, so the progress callback in
+ * util/debuginfo.c can drain it through these, that keep slang behind
+ * the ui/ layer.
+ */
+bool ui__key_pending(void)
+{
+	return use_browser == 1 && SLang_input_pending(0) > 0;
+}
+
+int ui__key_read(void)
+{
+	return SLang_getkey();
+}
diff --git a/tools/perf/ui/util.h b/tools/perf/ui/util.h
index e30cea807564f92f..053240ea9dfa6fc0 100644
--- a/tools/perf/ui/util.h
+++ b/tools/perf/ui/util.h
@@ -2,9 +2,51 @@
 #ifndef _PERF_UI_UTIL_H_
 #define _PERF_UI_UTIL_H_ 1
 
+#include <stdbool.h>
 #include <stdarg.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
 
 int ui__getch(int delay_secs);
+
+/*
+ * The TUI owns the terminal and its input queue, so the rest of perf
+ * asks the ui/ layer for progress display and for the keys typed while
+ * it is not reading them, instead of touching slang or stdin directly:
+ * slang stays behind these, as the plan is to reduce the number of
+ * libraries perf needs to build, or swap slang for something else,
+ * such as ncurses, at some point.
+ *
+ * ui__progress_window() draws and updates a window over the browser
+ * telling that a long operation, for now the debuginfod fetch in
+ * util/debuginfo.c, is in progress, with @fetched/@total as the bytes
+ * fetched so far and the total when known, 0 otherwise, while
+ * ui__progress_window_end() takes the window down.  The keys typed
+ * while the fetch blocks the browser are drained with
+ * ui__key_pending()/ui__key_read().
+ */
+#ifndef HAVE_SLANG_SUPPORT
+/*
+ * Without the TUI there is no browser to draw over and no input queue
+ * owned by a UI: the stdio progress and keys for the debuginfod fetch
+ * live in util/debuginfo.c, so these are no-ops, keeping callers free
+ * of #ifdefs.
+ */
+static inline bool ui__key_pending(void) { return false; }
+static inline int ui__key_read(void) { return -1; }
+static inline void ui__progress_window(const char *title __maybe_unused,
+				       const char *text __maybe_unused,
+				       u64 fetched __maybe_unused,
+				       u64 total __maybe_unused) {}
+static inline void ui__progress_window_end(void) {}
+#else /* HAVE_SLANG_SUPPORT */
+bool ui__key_pending(void);
+int ui__key_read(void);
+void ui__progress_window(const char *title, const char *text,
+			 u64 fetched, u64 total);
+void ui__progress_window_end(void);
+#endif /* HAVE_SLANG_SUPPORT */
+
 int ui__popup_menu(int argc, char * const argv[], int *keyp);
 int ui__help_window(const char *text);
 int ui__dialog_yesno(const char *msg);
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index e2066fce2450c6fb..a111ddc4731309c0 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -151,11 +151,14 @@ struct debuginfo *debuginfo__new(const char *path)
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 /*
- * use_browser tells whether a full screen UI, the TUI for now, owns
- * the terminal and its input queue: the fetch progress and the
- * skip/disable keys below are stdio only when it doesn't.
+ * The TUI side of the fetch interaction is behind the ui/ layer: slang
+ * stays in ui/tui/, callers ask for pending keys and for the fetch
+ * progress window with the ui__ primitives in ui/util.h, implemented in
+ * ui/tui/util.c for the slang TUI and as no-ops in builds without it.
  */
 #include "ui/ui.h"
+#include "ui/util.h"
+#include "ui/helpline.h"
 
 static bool debuginfod_progress_started;
 static bool debuginfod_fetch_cancelled;
@@ -176,11 +179,15 @@ static void debuginfod_signal_handler(int sig)
 
 /*
  * Say that the fetch in progress was skipped, and where disabling it
- * lands.
+ * lands: the stdio case prints on stderr, the TUI shows it on its
+ * helpline, as the window with the fetch progress goes away with it.
  */
 static void debuginfod__skipped(const char *msg)
 {
-	fprintf(stderr, "\n%s\n", msg);
+	if (use_browser > 0)
+		ui_helpline__puts(msg);
+	else
+		fprintf(stderr, "\n%s\n", msg);
 }
 
 /*
@@ -193,7 +200,8 @@ static void debuginfod__skipped(const char *msg)
  * write core.debuginfod=false to the configuration file, the same
  * rewrite 'perf config' does, the comments are not preserved as the
  * config set carries just the key-value pairs, pointing at
- * 'perf config' when that rewrite can't be done.
+ * 'perf config' when that rewrite can't be done.  Shared by the stdio
+ * and the TUI fetch UIs.
  */
 static void debuginfod__cancel_key(int key)
 {
@@ -229,6 +237,16 @@ static void debuginfod__poll_cancel_keys(void)
 		debuginfod__cancel_key(ch);
 }
 
+/*
+ * The TUI fetch UI: the browser thread is the one doing the fetch, so
+ * its input queue has the keys typed while it was busy, drain those.
+ */
+static void debuginfod__tui_poll_cancel_keys(void)
+{
+	while (ui__key_pending())
+		debuginfod__cancel_key(ui__key_read());
+}
+
 /*
  * Print a warning and a progress indicator when the debuginfod client
  * ends up fetching a file, which can be big, such as the vmlinux for a
@@ -246,7 +264,9 @@ static void debuginfod__poll_cancel_keys(void)
  *
  * In the stdio case the progress goes to stderr, a \r terminated line,
  * the keys are drained from stdin, that debuginfod__fetch() put in raw
- * mode.
+ * mode.  In the TUI the progress is drawn in a window over the browser
+ * and the keys come from the TUI input queue, slang stays behind the
+ * ui/ layer, see the comment on ui/util.h.
  */
 static int debuginfod_progress_fn(debuginfod_client *c __maybe_unused,
 				  long a, long b)
@@ -254,7 +274,18 @@ static int debuginfod_progress_fn(debuginfod_client *c __maybe_unused,
 	if (debuginfod_signal)
 		return 1;
 
-	if (!isatty(STDERR_FILENO) || use_browser)
+	if (use_browser > 0) {
+		ui__progress_window("Fetching debuginfo by build ID from the debuginfod servers",
+				    "This may take a while for large files such as the vmlinux, press 's' to skip, 'd' to skip and disable",
+				    a > 0 ? (u64)a : 0, b > 0 ? (u64)b : 0);
+
+		debuginfod__tui_poll_cancel_keys();
+		if (debuginfod_fetch_cancelled)
+			return 1;
+		return 0;
+	}
+
+	if (!isatty(STDERR_FILENO))
 		return 0;
 
 	if (isatty(STDIN_FILENO)) {
@@ -502,11 +533,14 @@ static int debuginfod__fetch(const struct build_id *bid, char **path)
 	 * Make stdin deliver keypresses without waiting for a newline,
 	 * the progress callback above polls it for the 's'/'d' keys,
 	 * only in the stdio case with both stdin and stderr being a
-	 * terminal: the pipe cases have no business being poked here,
-	 * and in the TUI the terminal and its input queue are the
-	 * browser's own.  Intercept SIGINT, SIGQUIT and SIGTERM so that
-	 * the terminal is restored before the process dies, the handler
-	 * only records the signal and the callback aborts the query.
+	 * terminal: the TUI draws its own progress window over the
+	 * browser and drains the keys from the input queue the browser
+	 * owns, with the ui__ primitives, and the pipe cases have no
+	 * business being poked here.  Intercept SIGINT, SIGQUIT and
+	 * SIGTERM so that the terminal is restored before the process
+	 * dies, the handler only records the signal and the callback
+	 * aborts the query; in the TUI the terminal is the TUI's own and
+	 * so are those signal handlers, that restore it before exiting.
 	 * The handlers go in before the terminal mode changes, so that a
 	 * signal landing in between is caught and the raw mode is
 	 * restored.
@@ -538,7 +572,9 @@ static int debuginfod__fetch(const struct build_id *bid, char **path)
 		sigaction(SIGTERM, &orig_sigterm, NULL);
 
 	debuginfod_end(c);
-	if (debuginfod_progress_started) {
+	if (use_browser > 0)
+		ui__progress_window_end();
+	else if (debuginfod_progress_started) {
 		fputc('\n', stderr);
 		debuginfod_progress_started = false;
 	}
-- 
2.55.0

