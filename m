Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14474D7D35;
	Wed, 16 Sep 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583577; cv=none; b=REPDkwsAVY5XE17STnvl3UoF0uX/ovYhqR39jUtJ0uHwBqpIbKFuulDV7KNDTQYsWOQTN4xYUlqaQAivXaBxH2sp5dMAz+NpqSGMadwjeNZEREiFTOM2nQkZxv4pIs/LO2pQKGyRg7Px9srlMrOa16iiPpXsiqRjI3ZLyF+xrlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583577; c=relaxed/simple;
	bh=WZskyoIfU/LkacXKYr9ZRS9091JtCq50essvNvDXe+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAjd8DmjECIlKUIU70tIBl+0HbEmtrHGN97lbrAXewjY1IpOQUZLya+akj/GDM8KmHSMokE2JkhPCM+yvKlryTeuq8cyYzgICPLwmmuFUh+tJDaTYLUteMtMvAIy2A7A2WgyjRBNua6B6g3wu5zYCey+Hje2qC0jQE9TROITd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF2uGlJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF2uGlJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C434D1F000FF;
	Wed, 16 Sep 2026 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583568;
	bh=H1ub4rAwXZfMrP2rano6GAM/kUbu7aOGUpFv13VW8qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MF2uGlJpMo4fXrhFrxzo2ITZL4lT9rjYQqhVJem91bDHERS5sfBFHLJRKSIflcLcG
	 eSlq8kG/QScyBZpVwuztRpzOL4MT6RudU25oLsJI7BWCUQtHCHb6ckw30cTrTP/uSW
	 VRYZ91gsQN0XoJXFiM6Hn4iY8n/zVugvbqjkS65qJA6SUoG01jZCulLw6FatrkzzNp
	 8/OaGgAVTIG315TSJ1KN3WuxCHonPhV20EJx0QkaDU8HP5SCStCfrL2QjOH3FDJp5N
	 6zuPCrM8oULkTeGcaCwhwZoYBSNOUf+S0IJ/TZg5STXY9u9qMojxqaboKgJcdrcbgd
	 uDIA46O7lQ1cA==
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
Subject: [PATCH 08/12] perf report: Add --progress option
Date: Wed, 16 Sep 2026 15:32:09 -0300
Message-ID: <20260916183215.54305-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916183215.54305-1-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Processing a large data type profiling session, e.g. an AMD IBS one, can
take a long time and, when using the stdio output, 'perf report' gives no
feedback about which phase it is in nor about how far along it is: the
TUI has a progress bar for that, but in the stdio case the ui_progress
updates, that are already there, are dropped on the floor.

Add a --progress option that installs a stdio backend for ui_progress,
ui/stdio/progress.c, printing the phase title, the percentage done and
the current/total counts to stderr:

  Processing events... [ 42.3%] 317M / 746M
  Merging related events... [ 61.0%] 309026 / 506686
  Sorting events for output... [ 98.2%] 14132 / 14387

The first one is the perf.data file size based progress already kept
while reading events, sized with the same unit_number__scnprintf() used
by the TUI progress bar title; the other two are the hist entry based
ones for the hist entry merging (collapse) and output sorting phases,
that print raw counts.

Steps are 1% of the phase total, the default (total / 16) is tuned for
the character cell based TUI bar, and the last update normally stops
short of the total, so finishing a phase prints it as complete.

When stderr is a tty the line is updated in place, with each phase
getting a line of its own, otherwise one line is printed per update, so
that redirecting stderr to a file leaves a readable log of the phases.

Phases can be nested, e.g. the ordered events flushes that take place
while the "Processing events..." phase is still in progress, so the
backend keeps track of the ones started so far to be able to complete
the right one when a phase finishes, as ui_progress__finish() gets no
arguments.

That bookkeeping requires ui_progress__init() and ui_progress__finish()
to be paired, and a few callers had paths returning early without the
finish: do_flush() in ordered-events.c on session_done() and on
deliver() errors, and the ENOMEM paths right after the init in
__perf_session__process_pipe_events() and __perf_session__process_dir_events().

Fix those, with a backend that kept the stale entries it would print
through dangling pointers to returned stack frames, and have the
update() method ignore anything that doesn't match the innermost running
phase, printing nothing is better than printing another phase's numbers
or reading the stack array with index -1.

Committer testing:

  ⬢ [acme@toolbx perf-tools-next]$ perf record -o perf.data.small -- sleep 0.2
  [ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.002 MB perf.data.small (7 samples) ]
  ⬢ [acme@toolbx perf-tools-next]$ perf report --progress -i perf.data.small > /dev/null
  Processing events... [  0.0%] 0B / 2K
  Processing events... [ 99.6%] 2040B / 2K
  Processing time ordered events... [100.0%] 13 / 13
  Processing events... [100.0%] 2K / 2K
  Sorting events for output... [100.0%] 5 / 5
  ⬢ [acme@toolbx perf-tools-next]$

Nothing goes to stderr without --progress:

  ⬢ [acme@toolbx perf-tools-next]$ perf report --stdio -i perf.data.small > /dev/null 2> stderr.txt
  ⬢ [acme@toolbx perf-tools-next]$ wc -c stderr.txt
  0 stderr.txt
  ⬢ [acme@toolbx perf-tools-next]$

With a 321 MB perf.data (perf mem record, i7-14700K):

  ⬢ [acme@toolbx perf-tools-next]$ perf report --progress -i perf.data.i7 > /dev/null
  Processing events... [  0.0%] 0B / 306M
  [...]
  Sorting events for output... [100.0%] 29996 / 29996
  ⬢ [acme@toolbx perf-tools-next]$

Which is what prompted this: an AMD IBS data type profile session hangs
in the DWARF type resolution done when merging hist entries, with
--progress it now is visible that it is not the event loading that is
stuck, but the merging, at a specific hist entry:

  ⬢ [acme@toolbx perf-tools-next]$ perf report --progress -s type -i perf.data.ibs > /dev/null
  Processing events... [  0.0%] 0B / 746M
  [...]
  Processing events... [100.0%] 746M / 746M
  Merging related events... [ 58.0%] 293828 / 506686
  Merging related events... [ 59.0%] 298894 / 506686
  Merging related events... [ 60.0%] 303960 / 506686
  Merging related events... [ 61.0%] 309026 / 506686

  ⬢ [acme@toolbx perf-tools-next]$ gdb -p $(pidof perf) -batch -ex 'bt 6' -ex detach
  #0  0x0000000000773f31 in die_get_pointer_type ()
  #1  0x000000000077b817 in find_data_type ()
  #2  0x0000000000636f20 in __hist_entry__get_data_type ()
  #3  0x0000000000639c65 in hist_entry__get_data_type ()
  #4  0x00000000006e57a8 in sort__type_collapse ()
  #5  0x00000000006ef0ee in hists__collapse_resort ()
  ⬢ [acme@toolbx perf-tools-next]$

The report related entries in 'perf test' pass:

  ⬢ [acme@toolbx perf-tools-next]$ perf test 17 27 30 31 85 88
  17: Match and link multiple hists                              : Ok
  27: Filter hist entries                                        : Ok
  30: Sort output of hist entries                                : Ok
  31: Cumulate child hist entries                                : Ok
  85: Test that perf report includes file offsets and event type names in diagnostic messages. : Skip
  88: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).: Ok
  ⬢ [acme@toolbx perf-tools-next]$

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  13 ++
 tools/perf/builtin-report.c              |  11 ++
 tools/perf/ui/Build                      |   1 +
 tools/perf/ui/progress.h                 |   2 +
 tools/perf/ui/stdio/progress.c           | 185 +++++++++++++++++++++++
 tools/perf/util/ordered-events.c         |  17 ++-
 tools/perf/util/session.c                |  12 +-
 7 files changed, 234 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/ui/stdio/progress.c

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 0a4f61283b9542f7..8fc1d5d56d54f698 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -29,6 +29,19 @@ OPTIONS
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
+	present progress information.
+
 -n::
 --show-nr-samples::
 	Show the number of samples for each symbol
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 442c0822e614197f..32d5b35772cf374a 100644
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
@@ -1374,6 +1375,8 @@ int cmd_report(int argc, const char **argv)
 		    "Use the stdio interface"),
 	OPT_BOOLEAN(0, "weights", &symbol_conf.annotate_weight,
 			"Show or hide weight columns in annotation. Default show if non-zero."),
+	OPT_BOOLEAN(0, "progress", &report.progress,
+		    "Show progress while processing the perf.data file"),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
@@ -1766,6 +1769,14 @@ int cmd_report(int argc, const char **argv)
 	else
 		use_browser = 0;
 
+	/*
+	 * The TUI/GTK browsers already show progress, this is for the stdio
+	 * case, where we print the percentage of the perf.data file that was
+	 * processed so far, for each of the processing phases.
+	 */
+	if (report.progress && use_browser == 0)
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
index 0000000000000000..b4a6b2732a0546cd
--- /dev/null
+++ b/tools/perf/ui/stdio/progress.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Progress feedback for the stdio (non-TUI/GTK) case, enabled via
+ * 'perf report --progress': the perf.data file size based progress for
+ * the event processing phase, plus the hist entry based ones for the
+ * merging and sorting phases.
+ */
+#include <inttypes.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <linux/kernel.h>
+#include "../../util/debug.h"
+#include "../../util/units.h"
+#include "../progress.h"
+
+/*
+ * Phases can be nested, e.g. the ordered events flushes that take place
+ * while the "Processing events..." phase is still in progress, so keep
+ * track of the ones started so far to be able to complete the right one
+ * when a phase finishes, as ui_progress__finish() gets no arguments.  The
+ * bookkeeping of what was last printed is per phase: when the nested one
+ * finishes, the outer one must still know that its own last line was
+ * already the complete one, else it would be printed again at finish time.
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
+static bool stdio_progress__is_tty;
+/*
+ * Phases that started when there was no room left for them on the stack:
+ * they are not shown, and their finish() is still to come, see
+ * stdio_progress__finish().
+ */
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
+	 * Only the completion line shows 100.0%: a 99.99% progress would
+	 * round up to it in the display, making the line printed at finish
+	 * time look like a duplicate.
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
+		fprintf(stderr, "%s\n", buf);
+		goto out;
+	}
+
+	/* Pad to the length of the previous line to erase its leftovers. */
+	fprintf(stderr, "\r%s%*s", buf,
+		(int)(len < phase->last_len ? phase->last_len - len : 0), "");
+	phase->last_len = len;
+out:
+	phase->last_printed = curr;
+	fflush(stderr);
+}
+
+static void __stdio_progress__init(struct ui_progress *p)
+{
+	/*
+	 * The default step (total / 16) is meant for the TUI progress
+	 * bar, for stdio, where a percentage is printed, use 1% steps.
+	 */
+	p->next = p->step = p->total / 100 ?: 1;
+
+	if (stdio_progress__depth == STDIO_PROGRESS__MAX_DEPTH) {
+		/*
+		 * Out of room: don't start this phase, stdio_progress__update()
+		 * then ignores its updates, as it doesn't match the innermost
+		 * running phase, and its finish() is swallowed below, so that
+		 * it doesn't complete the phase that encloses it.  Completing
+		 * that one here, to make room, would leave its own finish()
+		 * without a phase to complete, which is what would then get
+		 * out of sync, finishing the phases above it one by one.
+		 */
+		pr_warning("progress phases nested deeper than %d, not showing progress for %s\n",
+			   STDIO_PROGRESS__MAX_DEPTH, p->title);
+		stdio_progress__dropped++;
+		return;
+	}
+
+	/* Start a nested phase in a line of its own. */
+	if (stdio_progress__depth && stdio_progress__is_tty)
+		fputc('\n', stderr);
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
+	 * Phases are started/finished via init/finish, if we get an
+	 * update that doesn't match the innermost running phase then
+	 * something got out of sync, print nothing rather than some
+	 * other phase's numbers, or, with no phases at all, reading
+	 * stdio_progress__stack[-1].
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
+	 * A phase that didn't fit on the stack still gets its finish(), and
+	 * being the innermost one, it is the first to come: swallow it, or
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
+	 * As we print only at 1% steps, the last line printed may have
+	 * stopped short of the total, so close this phase showing it as
+	 * complete, unless that was what got printed already.
+	 */
+	if (phase->last_printed != phase->p->total)
+		stdio_progress__print_phase(phase, phase->p->total);
+
+	phase->last_printed	= 0;
+	phase->last_len		= 0;
+
+	if (stdio_progress__is_tty)
+		fputc('\n', stderr);
+
+	fflush(stderr);
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
+	stdio_progress__is_tty = isatty(STDERR_FILENO) == 1;
+	ui_progress__ops = &stdio_progress__ops;
+}
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index a5857f9f5af2d3de..4063403d4978b45e 100644
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
@@ -258,10 +260,17 @@ static int do_flush(struct ordered_events *oe, bool show_progress)
 	else if (last_ts <= limit)
 		oe->last = list_entry(head->prev, struct ordered_event, list);
 
+	ret = 0;
+out_progress:
+	/*
+	 * Always pair ui_progress__init() with ui_progress__finish(), the
+	 * stdio progress backend tracks phases on a stack and an early
+	 * return that skipped the finish would leave the dead 'prog' on it.
+	 */
 	if (show_progress)
 		ui_progress__finish();
 
-	return 0;
+	return ret;
 }
 
 static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a5b596cd14be6186..50f3e1d6c17d3147 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -3248,8 +3248,12 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
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
@@ -3748,8 +3752,10 @@ static int __perf_session__process_dir_events(struct perf_session *session)
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

