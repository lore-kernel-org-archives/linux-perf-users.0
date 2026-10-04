Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084B3B7B6B;
	Sun,  4 Oct 2026 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135037; cv=none; b=tJsQQ8QSwImTSvBXm28mTngOmZrzou5NDCgX/oojjHlgzxBzX59tqNb0TkvLnQuTChpYMvls2m+7tpeErMiILjRYBFKQior5OrtFWOspJ8IKBM7ebEShJxkioX/YQ/ng4y7GM4YxyZbnTFUoXwwL6wQ0KtIQdUckangyblqVtyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135037; c=relaxed/simple;
	bh=KZCQUQiaZwg6ZmeAyl/myHyBodlYjQsPSLWPHFyfrME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oo/og5l+MhOT4KLcfWOfja+EnuW3WwcfLl2/6c/Yg6ZDfR8NPOy5r2T+w3tAHCR5CYkhV/cqvWnozfNsmXgPAgGkNihOOodORAWXbLAQTM9yQ6LnV2BU/mNBwB4F+yL1F8sH0q7q5ic+1uwk400/XqNfDSHYFGpQG8CX31aJJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZDhQZEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZDhQZEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570B71F000FF;
	Sun,  4 Oct 2026 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135035;
	bh=zdVwvWflK4HzU9POCQX3np41vKj9G8KAxKS9S1qLZs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hZDhQZEG0eTji23sQeF59mQRCa/iOujNqS4zKJBVnifUj6E47oAn3NvLC9RbdXExm
	 kaN+CcSpjXEyo5CNiDYffnvxsqVTgs70M8Ub4Pu6WuFbC4kMu9FtqAlXXrEMelZbpY
	 tw/ccN0sJIAC53ZuoVuEs9VsEyJ4fp6xa69Q9KxL6pzBlOXUIlRUesIhG0bkMcCVX6
	 iDwIUj/9fq4DNC7nT1/NQuEa6KrwKt0A67Al7n6JbgLHEDduClGq1PwZHzs2BFtryA
	 iZ6G865QkXAPhAKcsW/Wj3ngE4OJWlkNXn0IBvLg8b/UCvIrb+VTH4PdkgLcVqoKdE
	 krs570a4yPM1w==
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
Subject: [PATCH v11 6/9] perf report: Add --progress option
Date: Sun,  4 Oct 2026 19:29:57 +0200
Message-ID: <20261004173000.2863935-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004173000.2863935-1-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Processing a large session with stdio output gives no feedback about
which phase perf is in or how far along it is: ui_progress updates are
only shown by the TUI.  Add --progress, installing a stdio backend
(ui/stdio/progress.c) that prints the phase title, percentage and
counts:

  Processing events... [ 42.3%] 317M / 746M

Phases can be nested, so the backend tracks the ones started to
complete the right one on ui_progress__finish(); that requires
init()/finish() pairs, fixed in ordered-events.c and the pipe and
directory event processing.

With a pager both stdout and stderr lead to it, so isatty(stderr)
turns false and the updates end up printed one per line in the
pager's output: use /dev/tty in that case, so that the updates keep
updating in place, untouched by the pager.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  14 ++
 tools/perf/builtin-report.c              |   6 +
 tools/perf/ui/Build                      |   1 +
 tools/perf/ui/progress.h                 |   2 +
 tools/perf/ui/stdio/progress.c           | 170 +++++++++++++++++++++++
 tools/perf/util/ordered-events.c         |  16 ++-
 tools/perf/util/session.c                |  12 +-
 7 files changed, 214 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/ui/stdio/progress.c

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 3718ebd297ce0673..a7429a30ec28f903 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -29,6 +29,20 @@ OPTIONS
 --quiet::
 	Do not show any warnings or messages.  (Suppress -v)
 
+--progress::
+	Show progress for each of the processing phases, printing the
+	percentage done and the current/total counts: the first phase
+	counts the bytes of the perf.data file processed so far, the
+	merge and sort phases count hist entries, e.g.:
+
+	Processing events... [ 42.3%] 4G / 10G
+	Merging related events... [  7.1%] 1024 / 14387
+	Sorting events for output... [ 98.2%] 14132 / 14387
+
+	It is a no-op when using the TUI or GTK browsers, that already
+	present progress information, or when --quiet is used, that asks
+	for no messages at all.
+
 -n::
 --show-nr-samples::
 	Show the number of samples for each symbol
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 57225bc87731d074..81e13fb8194976c9 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -87,6 +87,7 @@ struct report {
 	bool			use_gtk;
 #endif
 	bool			use_stdio;
+	bool			progress;
 	bool			show_full_info;
 	bool			show_threads;
 	bool			inverted_callchain;
@@ -1384,6 +1385,8 @@ int cmd_report(int argc, const char **argv)
 		    "Use the stdio interface"),
 	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
 			"Show or hide weight columns in annotation. Default show if non-zero."),
+	OPT_BOOLEAN(0, "progress", &report.progress,
+		    "Show progress while processing the perf.data file"),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
@@ -1790,6 +1793,9 @@ int cmd_report(int argc, const char **argv)
 	else
 		use_browser = 0;
 
+	if (report.progress && !quiet && use_browser == 0)
+		stdio_progress__init();
+
 	if (report.data_type && use_browser == 1) {
 		symbol_conf.annotate_data_member = true;
 		symbol_conf.annotate_data_sample = true;
diff --git a/tools/perf/ui/Build b/tools/perf/ui/Build
index 6005f813c9e3990c..a7b1740d51c80f23 100644
--- a/tools/perf/ui/Build
+++ b/tools/perf/ui/Build
@@ -4,6 +4,7 @@ perf-ui-y += progress.o
 perf-ui-y += util.o
 perf-ui-y += hist.o
 perf-ui-y += stdio/hist.o
+perf-ui-y += stdio/progress.o
 
 CFLAGS_setup.o += -DLIBDIR="BUILD_STR($(LIBDIR))"
 
diff --git a/tools/perf/ui/progress.h b/tools/perf/ui/progress.h
index 4f52c37b2f099a82..03f1a8bb260ba076 100644
--- a/tools/perf/ui/progress.h
+++ b/tools/perf/ui/progress.h
@@ -23,6 +23,8 @@ void __ui_progress__init(struct ui_progress *p, u64 total,
 
 void ui_progress__update(struct ui_progress *p, u64 adv);
 
+void stdio_progress__init(void);
+
 struct ui_progress_ops {
 	void (*init)(struct ui_progress *p);
 	void (*update)(struct ui_progress *p);
diff --git a/tools/perf/ui/stdio/progress.c b/tools/perf/ui/stdio/progress.c
new file mode 100644
index 0000000000000000..57f615c455b0ca7d
--- /dev/null
+++ b/tools/perf/ui/stdio/progress.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Progress feedback for the stdio (non-TUI/GTK) case, enabled with
+ * 'perf report --progress'.
+ */
+#include <inttypes.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <linux/kernel.h>
+#include <subcmd/pager.h>
+#include "../../util/debug.h"
+#include "../../util/units.h"
+#include "../progress.h"
+
+/*
+ * Phases can be nested, so keep track of the ones started so far to be
+ * able to complete the right one on ui_progress__finish(), which gets
+ * no arguments.
+ */
+#define STDIO_PROGRESS__MAX_DEPTH 8
+
+struct stdio_progress_phase {
+	struct ui_progress	*p;
+	u64			last_printed;
+	size_t			last_len;
+};
+
+static struct stdio_progress_phase stdio_progress__stack[STDIO_PROGRESS__MAX_DEPTH];
+static int stdio_progress__depth;
+static FILE *stdio_progress__out;
+static bool stdio_progress__is_tty;
+/* Phases that didn't fit on the stack are not shown. */
+static int stdio_progress__dropped;
+
+static void stdio_progress__print_phase(struct stdio_progress_phase *phase,
+					u64 curr)
+{
+	struct ui_progress *p = phase->p;
+	char buf_cur[20], buf_tot[20], buf[128];
+	double percent = p->total ? 100.0 * (double)curr / (double)p->total : 0.0;
+	size_t len;
+
+	/*
+	 * Only the completion line shows 100.0%: a 99.99% progress would round
+	 * up to it and look like a duplicate at finish time.
+	 */
+	if (curr < p->total && percent > 99.9)
+		percent = 99.9;
+
+	if (p->size) {
+		unit_number__scnprintf(buf_cur, sizeof(buf_cur), curr);
+		unit_number__scnprintf(buf_tot, sizeof(buf_tot), p->total);
+		len = scnprintf(buf, sizeof(buf), "%s [%5.1f%%] %s / %s",
+				p->title, percent, buf_cur, buf_tot);
+	} else {
+		len = scnprintf(buf, sizeof(buf), "%s [%5.1f%%] %" PRIu64 " / %" PRIu64,
+				p->title, percent, curr, p->total);
+	}
+
+	if (!stdio_progress__is_tty) {
+		fprintf(stdio_progress__out, "%s\n", buf);
+		goto out;
+	}
+
+	/* Pad to the length of the previous line to erase its leftovers. */
+	fprintf(stdio_progress__out, "\r%s%*s", buf,
+		(int)(len < phase->last_len ? phase->last_len - len : 0), "");
+	phase->last_len = len;
+out:
+	phase->last_printed = curr;
+	fflush(stdio_progress__out);
+}
+
+static void __stdio_progress__init(struct ui_progress *p)
+{
+	/* The default step is meant for the TUI bar, use 1% steps for stdio. */
+	p->next = p->step = p->total / 100 ?: 1;
+
+	if (stdio_progress__depth == STDIO_PROGRESS__MAX_DEPTH) {
+		/*
+		 * Out of room: don't start this phase, its finish() is
+		 * swallowed and its updates ignored below.
+		 */
+		pr_warning("progress phases nested deeper than %d, not showing progress for %s\n",
+			   STDIO_PROGRESS__MAX_DEPTH, p->title);
+		stdio_progress__dropped++;
+		return;
+	}
+
+	/* Start a nested phase in a line of its own. */
+	if (stdio_progress__depth && stdio_progress__is_tty)
+		fputc('\n', stdio_progress__out);
+
+	stdio_progress__stack[stdio_progress__depth++] =
+		(struct stdio_progress_phase) {
+			.p = p,
+			.last_printed = 0,
+			.last_len = 0,
+		};
+
+	stdio_progress__print_phase(&stdio_progress__stack[stdio_progress__depth - 1],
+				    p->curr);
+}
+
+static void stdio_progress__update(struct ui_progress *p)
+{
+	/*
+	 * An update that doesn't match the innermost phase means something
+	 * is out of sync: print nothing rather than another phase's
+	 * numbers, or read past the stack.
+	 */
+	if (!stdio_progress__depth ||
+	    stdio_progress__stack[stdio_progress__depth - 1].p != p)
+		return;
+
+	stdio_progress__print_phase(&stdio_progress__stack[stdio_progress__depth - 1],
+				    p->curr);
+}
+
+static void stdio_progress__finish(void)
+{
+	struct stdio_progress_phase *phase;
+
+	/*
+	 * Being the innermost phase, its finish() comes first: swallow it, or
+	 * it would complete the phase that encloses it.
+	 */
+	if (stdio_progress__dropped) {
+		stdio_progress__dropped--;
+		return;
+	}
+
+	if (!stdio_progress__depth)
+		return;
+
+	phase = &stdio_progress__stack[--stdio_progress__depth];
+
+	/*
+	 * The last line may have stopped short of the total, close this phase
+	 * showing it as complete unless that was already printed.
+	 */
+	if (phase->last_printed != phase->p->total)
+		stdio_progress__print_phase(phase, phase->p->total);
+
+	phase->last_printed	= 0;
+	phase->last_len		= 0;
+
+	if (stdio_progress__is_tty)
+		fputc('\n', stdio_progress__out);
+
+	fflush(stdio_progress__out);
+}
+
+static struct ui_progress_ops stdio_progress__ops = {
+	.init	= __stdio_progress__init,
+	.update	= stdio_progress__update,
+	.finish	= stdio_progress__finish,
+};
+
+void stdio_progress__init(void)
+{
+	if (pager_in_use()) {
+		/* stderr leads to the pager, the updates go to the terminal. */
+		stdio_progress__out = fopen("/dev/tty", "w");
+	}
+	if (!stdio_progress__out)
+		stdio_progress__out = stderr;
+	stdio_progress__is_tty = isatty(fileno(stdio_progress__out)) == 1;
+	ui_progress__ops = &stdio_progress__ops;
+}
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index a5857f9f5af2d3de..54c85663e733be4d 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -237,14 +237,16 @@ static int do_flush(struct ordered_events *oe, bool show_progress)
 		ui_progress__init(&prog, oe->nr_events, "Processing time ordered events...");
 
 	list_for_each_entry_safe(iter, tmp, head, list) {
-		if (session_done())
-			return 0;
+		if (session_done()) {
+			ret = 0;
+			goto out_progress;
+		}
 
 		if (iter->timestamp > limit)
 			break;
 		ret = oe->deliver(oe, iter);
 		if (ret < 0)
-			return ret;
+			goto out_progress;
 
 		ordered_events__delete(oe, iter);
 		oe->last_flush = iter->timestamp;
@@ -258,10 +260,16 @@ static int do_flush(struct ordered_events *oe, bool show_progress)
 	else if (last_ts <= limit)
 		oe->last = list_entry(head->prev, struct ordered_event, list);
 
+	ret = 0;
+out_progress:
+	/*
+	 * Always pair ui_progress__init() with ui_progress__finish(), the
+	 * stdio backend tracks the phases on a stack.
+	 */
 	if (show_progress)
 		ui_progress__finish();
 
-	return 0;
+	return ret;
 }
 
 static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7fea9e72726c936c..c4b4c7fb3b864589 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -3253,8 +3253,12 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	cur_size = sizeof(union perf_event);
 
 	buf = malloc(cur_size);
-	if (!buf)
-		return -errno;
+	if (!buf) {
+		err = -errno;
+		if (update_prog)
+			ui_progress__finish();
+		return err;
+	}
 	ordered_events__set_copy_on_queue(oe, true);
 more:
 	event = buf;
@@ -3753,8 +3757,10 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 	}
 
 	rd = calloc(nr_readers, sizeof(struct reader));
-	if (!rd)
+	if (!rd) {
+		ui_progress__finish();
 		return -ENOMEM;
+	}
 
 	rd[0] = (struct reader) {
 		.fd		 = perf_data__fd(session->data),
-- 
2.55.0

