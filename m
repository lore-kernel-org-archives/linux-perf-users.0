Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40989390230;
	Thu, 17 Sep 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660563; cv=none; b=EyYq9ZL92ZHXbjbmtM10zEqsNijDpHtXfACuLErlU4rFyeVdLdiVOTTZPRTPa+EmFngSPp7B8Gziumce5q/dTknx2FIIT/qvfSmA8dNGdUzuSkx87EA1rMNUn2/tcLFAr86IDy/W04/eoAu4WpBXt+eEh9S1gw+jI6wgETYfM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660563; c=relaxed/simple;
	bh=DcvHzGl5oesIU+AQPLi07d/9HB5IrBx/tN1+lTD6ZIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViIgAhTiC03u/evTQYBsS6YbxyUlGckLZeNqyHdJd1K+Z3XjWhzAJ3Epbraw6VVqI4+9FW1QnQ+h/VoAKuDin+aegSdqVxuLa/0fktoqJoBBEfleeqZrwsQrB68EDfnrwVJHnT/QkaDiH1KQwWeSM5GNDPKn/kF2IGfYd4jiTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtvIY+gj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtvIY+gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B451F00898;
	Thu, 17 Sep 2026 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660561;
	bh=lcDq6R3zqPhqcnAMX7wVGS6Ayltg6JZIho0w+u15AzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AtvIY+gjXAIUSoXO0RJgmgNmZh72hxZB4i1Vhjvve/CQMQCLFp0zmbM22wXs7U8gl
	 GexBA0Y+op5vc+pvgVBxnKyaA0Zn12/GV1LKBhKrwd5UmXVUC6IyNkBWk4TgCWS2ew
	 9n0Qw8Fnr5Eja2whSAZGnc1PhUm+GzNvttnpfo+s3vTwEo77QIGgMfbY+eusq07Ds6
	 CFn7V1JAvGurgTqyyZUzCSCFKk3gJGakwKVcvD+SxrosQcfHvebBVsynnVb3+yfzGw
	 p/2gAclXq2iA615KMJgGEL1wlWoNXqBDyuyA/PNoHuwarKmb4rNOelx+hpvFnn24Um
	 ypEkWpjxjDiMw==
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
Subject: [PATCH 05/15] perf debuginfo: Show the debuginfod fetch progress and keys in the TUI
Date: Thu, 17 Sep 2026 12:55:16 -0300
Message-ID: <20260917155528.62607-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917155528.62607-1-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The stdio only fetch UI left a TUI fetch in progress with nothing on
screen, indistinguishable from a stuck perf, with no way out of it.
Draw a window over the browser with the fetch progress, and drain the
's'/'d' keys from the TUI input queue, through the new
ui__key_pending()/ui__key_read()/ui__progress_window()/
ui__progress_window_end() primitives declared in ui/util.h and
implemented in ui/tui/util.c, with no-ops for builds without slang:
slang stays behind the ui/ layer and callers stay free of #ifdefs.

The text is word wrapped to the available columns so that narrow
terminals get the 'd' option hint too, and the width is clamped, never
negative.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |   9 +-
 tools/perf/Documentation/perf-top.txt    |   5 +-
 tools/perf/ui/tui/util.c                 | 171 +++++++++++++++++++++++
 tools/perf/ui/util.h                     |  27 ++++
 tools/perf/util/debuginfo.c              |  97 +++++++------
 5 files changed, 254 insertions(+), 55 deletions(-)

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
index e4d322ce0b54cbc6..280865e980ef5491 100644
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
@@ -272,3 +274,172 @@ struct perf_error_ops perf_tui_eops = {
 	.error		= perf_tui__error,
 	.warning	= perf_tui__warning,
 };
+
+/*
+ * The debuginfod fetch progress window, drawn over the browser while a
+ * fetch is in progress: with nothing on screen the browser looks hung.
+ * Redraw only when the fetched bytes change, the callback is called at
+ * every write chunk.
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
+	if (width <= 0)
+		return 0;
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
+	/*
+	 * SLsmg_write_nstring() takes the width as an unsigned int, so never
+	 * let a narrow terminal make it negative.  Clamp it.
+	 */
+	inner = SLtt_Screen_Cols - 2;
+	if (inner < 0)
+		inner = 0;
+	else if (inner > 255)
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
+		SLsmg_write_nstring(lines[i], inner);
+	}
+	SLsmg_gotorc(y, 1);
+	SLsmg_write_nstring(bytes, inner);
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
+ * The keys typed while the fetch blocked the browser are in the TUI
+ * input queue: nobody else is reading it, drain them through these.
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
index e30cea807564f92f..c264a8b2d5016110 100644
--- a/tools/perf/ui/util.h
+++ b/tools/perf/ui/util.h
@@ -2,9 +2,36 @@
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
+ * asks for the progress display and for pending keys through these,
+ * keeping slang behind the ui/ layer.  Without slang they are no-ops,
+ * so callers stay free of #ifdefs.
+ */
+#ifndef HAVE_SLANG_SUPPORT
+/* No-ops without the TUI, keeping callers free of #ifdefs. */
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
index 0ec11e1ad7508edc..737dd445d42bb72f 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -151,11 +151,13 @@ struct debuginfo *debuginfo__new(const char *path)
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 /*
- * use_browser tells whether a full screen UI, the TUI for now, owns
- * the terminal and its input queue: the fetch progress and the
- * skip/disable keys below are stdio only when it doesn't.
+ * The TUI side of the fetch interaction is behind the ui/ layer:
+ * slang stays in ui/tui/ and callers use the ui__ primitives in
+ * ui/util.h.
  */
 #include "ui/ui.h"
+#include "ui/util.h"
+#include "ui/helpline.h"
 
 static bool debuginfod_progress_started;
 static bool debuginfod_fetch_cancelled;
@@ -172,28 +174,19 @@ static void debuginfod_signal_handler(int sig)
 	debuginfod_signal = sig;
 }
 
-/*
- * Say that the fetch in progress was skipped, and where disabling it
- * lands.
- */
+/* Say that the fetch in progress was skipped, and where disabling lands. */
 static void debuginfod__skipped(const char *msg)
 {
-	fprintf(stderr, "\n%s\n", msg);
+	if (use_browser > 0)
+		ui_helpline__puts(msg);
+	else
+		fprintf(stderr, "\n%s\n", msg);
 }
 
 /*
- * 's': skip this fetch, and remember the build ID so that the rest of
- * the session doesn't ask for it again, the query is aborted by
- * returning a non-zero value from the progress callback, as the
- * debuginfod client docs prescribe.  'd': also disable debuginfod for
- * the rest of the session, emptying the copy of DEBUGINFOD_URLS that
- * util/util.c installed at setup, so that libdwfl's own client, that
- * reads it in every query, stops fetching too, without a setenv() here
- * racing other threads' getenv()s, and
- * write core.debuginfod=false to the configuration file, the same
- * rewrite 'perf config' does, the comments are not preserved as the
- * config set carries just the key-value pairs, pointing at
- * 'perf config' when that rewrite can't be done.
+ * 's': skip this fetch and remember the build ID, so that the rest of
+ * the session doesn't ask for it again.  'd': also disable debuginfod
+ * for the session and write core.debuginfod=false to the config file.
  */
 static void debuginfod__cancel_key(int key)
 {
@@ -230,24 +223,22 @@ static void debuginfod__poll_cancel_keys(void)
 		debuginfod__cancel_key(ch);
 }
 
+/*
+ * The browser thread is the one doing the fetch, so its input queue has
+ * the keys typed while it was busy, drain those.
+ */
+static void debuginfod__tui_poll_cancel_keys(void)
+{
+	while (ui__key_pending())
+		debuginfod__cancel_key(ui__key_read());
+}
+
 /*
  * Print a warning and a progress indicator when the debuginfod client
- * ends up fetching a file, which can be big, such as the vmlinux for a
- * kernel profiled on another machine or before it got upgraded, so that
- * users know perf is not stuck, and let them bail out: 's' skips this
- * fetch and remembers the build ID, so that the rest of the session
- * doesn't ask for it again, 'd' also disables debuginfod for the rest
- * of the session.
- *
- * The client invokes this both while fetching, where 'a' is the number
- * of bytes transferred so far and 'b' the total size, zero when it
- * doesn't know it yet, and, before committing to a server, from the
- * cache cleanup, that scans the debuginfod client cache, with 'a' being
- * the number of cache files scanned so far and 'b' zero.
- *
- * In the stdio case the progress goes to stderr, a \r terminated line,
- * the keys are drained from stdin, that debuginfod__fetch() put in raw
- * mode.
+ * fetches a file, which can be big, so that users know perf is not
+ * stuck, and let them bail out with 's' or 'd'.  In the stdio case the
+ * progress goes to stderr and the keys are drained from stdin; in the
+ * TUI they come from the input queue, see the comment on ui/util.h.
  */
 static int debuginfod_progress_fn(debuginfod_client *c __maybe_unused,
 				  long a, long b)
@@ -255,7 +246,18 @@ static int debuginfod_progress_fn(debuginfod_client *c __maybe_unused,
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
@@ -439,17 +441,12 @@ static int debuginfod__fetch(const struct build_id *bid, char **path)
 	debuginfod_signal = 0;
 
 	/*
-	 * Make stdin deliver keypresses without waiting for a newline,
-	 * the progress callback above polls it for the 's'/'d' keys,
-	 * only in the stdio case with both stdin and stderr being a
-	 * terminal: the pipe cases have no business being poked here,
-	 * and in the TUI the terminal and its input queue are the
-	 * browser's own.  Intercept SIGINT, SIGQUIT and SIGTERM so that
-	 * the terminal is restored before the process dies, the handler
-	 * only records the signal and the callback aborts the query.
-	 * The handlers go in before the terminal mode changes, so that a
-	 * signal landing in between is caught and the raw mode is
-	 * restored.
+	 * In the stdio case, with stdin and stderr a terminal, put stdin in raw
+	 * mode so the 's'/'d' keys are delivered without waiting for a newline,
+	 * and intercept SIGINT, SIGQUIT and SIGTERM so the terminal is restored
+	 * before the process dies; the TUI uses its own primitives and
+	 * handlers.  The handlers go in before the terminal mode changes, so a
+	 * signal landing in between still restores it.
 	 */
 	if (isatty(STDIN_FILENO) && isatty(STDERR_FILENO) && !use_browser) {
 		memset(&sa, 0, sizeof(sa));
@@ -478,7 +475,9 @@ static int debuginfod__fetch(const struct build_id *bid, char **path)
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

