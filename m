Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BE4EB85A;
	Thu, 17 Sep 2026 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660558; cv=none; b=s34u2LTDSdWHo4Qe2qyvi+qVM4ySou50Q6G2N5CUSsylVyJ7wVEa5sakErHsoqVMDm1t1+3CR12IwHTDZ9FphKDw206h3YcAiW1gJRefS3GzEQXtFdBExjPWpRfC0SuTMIi1Ekx9DzCchq1C+xtCIRlRfnrO84t3f+FsJg3/0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660558; c=relaxed/simple;
	bh=W7FFmi7s9lDF4nFQE1wd+QtNoXhRaYKMGRwk1wAgcY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnUkap0HoFf+zLWW0h/YGZ6WAhw4amhDhBZcEiEqrzIIgamU/WfKgP6jFa985TVX0qmV+CtlR5/Oebo7KOIieccgTqap0U/gzv5Ml99Pt8W8Ma72uO+zFQ6VCfeOjzaN912vl589z1fw6rOpJF4yrnm2lKuFx3O4d6Sn4bCrb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ0AGSsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ0AGSsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0222A1F00893;
	Thu, 17 Sep 2026 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660556;
	bh=/Eglm6SlL28MqoVCibvqvIgYslao5w2kLm5zKcmuWQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZ0AGSslWNSZze58bYci/KDT8kPQN9Dtcios/NgpIM9ycP1bHMc0TAhWDUKWrmruK
	 ePdqALgl0mbHaSKBqVUlXgfXB43ToYL7Ig+LrKDmaLLJsjC4I7//CtF3UMjZQFdbul
	 op3t9BOjvPV0RWrqFhog5EEjfUfS8elo3GxXAd3QyYGEhJnEdiJsJeEJ7klrNOyfGy
	 /eWqVeNOn3Mr5VnVH5jc2OzKGPtetUdFfrjCVY9H7Km3UkVkvSHQMSEpPi084/Ycoj
	 e7xLQ71qxq4ubxlCxdcPP8UyzMPDqKUMnU0I2tF28wvvYWlQME+1fcW67IIvMMxDlY
	 7dGJv2CG4Ws2w==
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
Subject: [PATCH 04/15] perf debuginfo: Let the user skip and disable debuginfod fetches
Date: Thu, 17 Sep 2026 12:55:15 -0300
Message-ID: <20260917155528.62607-5-acme@kernel.org>
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

In the stdio case, while a fetch is in progress: 's' aborts it through
the debuginfod client's progress callback and remembers the build ID, so
that the rest of the session does not ask for it again; 'd' additionally
disables debuginfod for the session, emptying the DEBUGINFOD_URLS copy
perf owns (libdwfl's own client reads it in every query) and writing
core.debuginfod=false to the config file with
perf_config__set_variable().  SIGINT, SIGQUIT and SIGTERM are
intercepted while the terminal is in raw mode and re-raised after it is
restored.

The keys are drained with read()s that do not block: the terminal is in
raw mode with VMIN and VTIME zero, so read() returns zero when nothing
was typed and the callback returns to the client, which carries on with
the fetch.  In the TUI nothing is shown yet, that comes in the next
patch.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |   4 +-
 tools/perf/Documentation/perf-report.txt   |  11 +-
 tools/perf/Documentation/perf-top.txt      |  10 +-
 tools/perf/util/debuginfo.c                | 375 +++++++++++++++------
 4 files changed, 283 insertions(+), 117 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 12edc3337b86f099..25af1d166dc4c877 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -64,7 +64,9 @@ OPTIONS
 	configured in DEBUGINFOD_URLS, checking the local debuginfod
 	client cache first, when it is not available locally, on for
 	these commands by default.  See the --debuginfod option of
-	'perf report' for how to turn it off.
+	'perf report' for how to turn it off, including the 's' and
+	'd' keys that skip a fetch in progress while 'perf' is
+	waiting for it.
 
 --itrace::
 	Options for decoding instruction tracing data. The options are:
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 2e11c0a97a016853..0a821490d6a0f895 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -374,9 +374,14 @@ OPTIONS
 	these commands by default.  It can be turned off per invocation
 	with --no-debuginfod, per tool with the "report.debuginfod"
 	config option or globally with "core.debuginfod" set to false.
-	It is disabled as well when the local build-id cache is turned
-	off, e.g. "buildid.dir" set to /dev/null, as that asks for
-	fetched files not to be kept on the box.
+	While a fetch is in progress, 's' skips the current fetch and
+	'd' skips it and disables debuginfod for the rest of the
+	session, writing core.debuginfod=false to the configuration
+	file so that it stays disabled in the next runs too; in the
+	stdio interface the progress is a line on stderr.  It is
+	disabled as well when the local build-id cache is turned off,
+	e.g. "buildid.dir" set to /dev/null, as that asks for fetched
+	files not to be kept on the box.
 
 --kallsyms=<file>::
         kallsyms pathname
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 345dd9ee9b6bab88..f38b54267125cb08 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -90,9 +90,13 @@ Default is to monitor all CPUS.
 	client cache first, when it is not available locally, on for
 	these commands by default.  Turn it off per invocation with
 	--no-debuginfod, with the "top.debuginfod" config option or
-	globally with "core.debuginfod" set to false.  Disabled as well
-	when the build-id cache is off, e.g. "buildid.dir" set to
-	/dev/null.
+	globally with "core.debuginfod" set to false.  While a fetch is
+	in progress, 's' skips the current fetch and 'd' skips it and
+	disables debuginfod for the rest of the session, writing
+	core.debuginfod=false to the configuration file so that it
+	stays disabled in the next runs too; in the stdio interface the
+	progress is a line on stderr.  Disabled as well when the
+	build-id cache is off, e.g. "buildid.dir" set to /dev/null.
 
 --kallsyms=<file>::
 	kallsyms pathname
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index be5882d9c2204797..0ec11e1ad7508edc 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -9,21 +9,25 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <pthread.h>
+#include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <termios.h>
 #include <unistd.h>
 #include <linux/list.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
 
 #include "build-id.h"
+#include "config.h"
 #include "dso.h"
 #include "debug.h"
 #include "debuginfo.h"
 #include "mutex.h"
 #include "symbol.h"
+#include "term.h"
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 #include <elfutils/debuginfod.h>
@@ -147,11 +151,137 @@ struct debuginfo *debuginfo__new(const char *path)
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 /*
- * Users can disable the local build-id/.debug cache by setting
- * buildid.dir to /dev/null, meaning they don't want fetched
- * binaries/debuginfo stored on the box; the debuginfod client keeps
- * its own cache in ~/.cache/debuginfod_client, so honour that intent
- * and don't fetch at all in that case.
+ * use_browser tells whether a full screen UI, the TUI for now, owns
+ * the terminal and its input queue: the fetch progress and the
+ * skip/disable keys below are stdio only when it doesn't.
+ */
+#include "ui/ui.h"
+
+static bool debuginfod_progress_started;
+static bool debuginfod_fetch_cancelled;
+
+/*
+ * While stdin is in raw mode, SIGINT, SIGQUIT and SIGTERM are only
+ * recorded by the handler; the callback aborts the query and
+ * debuginfod__fetch() restores the terminal and re-raises the signal.
+ */
+static volatile sig_atomic_t debuginfod_signal;
+
+static void debuginfod_signal_handler(int sig)
+{
+	debuginfod_signal = sig;
+}
+
+/*
+ * Say that the fetch in progress was skipped, and where disabling it
+ * lands.
+ */
+static void debuginfod__skipped(const char *msg)
+{
+	fprintf(stderr, "\n%s\n", msg);
+}
+
+/*
+ * 's': skip this fetch, and remember the build ID so that the rest of
+ * the session doesn't ask for it again, the query is aborted by
+ * returning a non-zero value from the progress callback, as the
+ * debuginfod client docs prescribe.  'd': also disable debuginfod for
+ * the rest of the session, emptying the copy of DEBUGINFOD_URLS that
+ * util/util.c installed at setup, so that libdwfl's own client, that
+ * reads it in every query, stops fetching too, without a setenv() here
+ * racing other threads' getenv()s, and
+ * write core.debuginfod=false to the configuration file, the same
+ * rewrite 'perf config' does, the comments are not preserved as the
+ * config set carries just the key-value pairs, pointing at
+ * 'perf config' when that rewrite can't be done.
+ */
+static void debuginfod__cancel_key(int key)
+{
+	if (key == 's' || key == 'S') {
+		debuginfod_fetch_cancelled = true;
+		debuginfod__skipped("Skipping this debuginfod fetch, this build ID will not be fetched again in this session, press 'd' to also disable it for the other ones");
+	} else if (key == 'd' || key == 'D') {
+		debuginfod_fetch_cancelled = true;
+		symbol_conf.debuginfod = false;
+		/*
+		 * libdwfl's own client reads DEBUGINFOD_URLS in every query, clear the
+		 * perf-owned copy to stop it too.
+		 */
+		debuginfod__disable_urls_env();
+		if (perf_config__set_variable("core.debuginfod", "false"))
+			debuginfod__skipped("Skipping this debuginfod fetch and disabling debuginfod for this session, run 'perf config core.debuginfod=false' to also disable it permanently");
+		else if (config_exclusive_filename)
+			debuginfod__skipped("Skipping this debuginfod fetch and disabling debuginfod for this session and in the configuration file");
+		else
+			debuginfod__skipped("Skipping this debuginfod fetch and disabling debuginfod for this session and in ~/.perfconfig");
+	}
+}
+
+/*
+ * The terminal is in raw mode with VMIN and VTIME zero, so read()
+ * returns zero when nothing was typed: this drains the keys typed so
+ * far and returns, it doesn't wait for a keypress.
+ */
+static void debuginfod__poll_cancel_keys(void)
+{
+	char ch;
+
+	while (read(STDIN_FILENO, &ch, 1) == 1)
+		debuginfod__cancel_key(ch);
+}
+
+/*
+ * Print a warning and a progress indicator when the debuginfod client
+ * ends up fetching a file, which can be big, such as the vmlinux for a
+ * kernel profiled on another machine or before it got upgraded, so that
+ * users know perf is not stuck, and let them bail out: 's' skips this
+ * fetch and remembers the build ID, so that the rest of the session
+ * doesn't ask for it again, 'd' also disables debuginfod for the rest
+ * of the session.
+ *
+ * The client invokes this both while fetching, where 'a' is the number
+ * of bytes transferred so far and 'b' the total size, zero when it
+ * doesn't know it yet, and, before committing to a server, from the
+ * cache cleanup, that scans the debuginfod client cache, with 'a' being
+ * the number of cache files scanned so far and 'b' zero.
+ *
+ * In the stdio case the progress goes to stderr, a \r terminated line,
+ * the keys are drained from stdin, that debuginfod__fetch() put in raw
+ * mode.
+ */
+static int debuginfod_progress_fn(debuginfod_client *c __maybe_unused,
+				  long a, long b)
+{
+	if (debuginfod_signal)
+		return 1;
+
+	if (!isatty(STDERR_FILENO) || use_browser)
+		return 0;
+
+	if (isatty(STDIN_FILENO)) {
+		debuginfod__poll_cancel_keys();
+		if (debuginfod_fetch_cancelled)
+			return 1;
+	}
+
+	if (!debuginfod_progress_started) {
+		fprintf(stderr, "Fetching debuginfo by build ID from the debuginfod servers, this may take a while for large files such as the vmlinux, press 's' to skip, 'd' to skip and disable\n");
+		debuginfod_progress_started = true;
+	}
+
+	if (a >= 0) {
+		if (b > 0)
+			fprintf(stderr, "  %ld/%ld MiB fetched\r", a >> 20, b >> 20);
+		else
+			fprintf(stderr, "  %ld MiB fetched\r", a >> 20);
+	}
+
+	return 0;
+}
+
+/*
+ * Setting buildid.dir to /dev/null means no fetched files stored
+ * locally, honour it and don't fetch at all.
  */
 static bool debuginfod__cache_disabled(void)
 {
@@ -159,42 +289,39 @@ static bool debuginfod__cache_disabled(void)
 }
 
 /*
- * Build IDs that shouldn't be searched for again in this session: the
- * ones already searched for on the debuginfod servers without success,
- * so that callers that see the same DSO over and over, such as the data
- * type profiler switching between DSOs on every hist entry, don't pay a
- * server round trip again for each miss.  The cache of successes is the
- * debuginfod client's own, in the local filesystem.
- *
- * Guarded by debuginfod__fetch_lock: it is only read by the lookups
- * below, that run with that lock held, and written by fetches, that run
- * with it held too.
+ * Build IDs already searched for without success or cancelled by the
+ * user, so that callers revisiting DSOs don't pay a server round trip
+ * per miss.  Guarded by debuginfod__fetch_lock.
  */
 struct debuginfod_miss {
 	struct list_head	node;
 	struct build_id		bid;
+	bool			cancelled;
 };
 
 static LIST_HEAD(debuginfod__misses);
 
-/*
- * Was the search for this build ID already made and settled, i.e. the
- * servers had nothing for it?
- */
-static bool debuginfod__missed(const struct build_id *bid)
+/* Was the search for this build ID already settled, or cancelled? */
+static bool debuginfod__missed(const struct build_id *bid, bool *cancelled)
 {
 	struct debuginfod_miss *miss;
+	bool found = false;
+
+	*cancelled = false;
 
 	list_for_each_entry(miss, &debuginfod__misses, node) {
 		if (miss->bid.size == bid->size &&
-		    !memcmp(miss->bid.data, bid->data, bid->size))
-			return true;
+		    !memcmp(miss->bid.data, bid->data, bid->size)) {
+			found = true;
+			*cancelled = miss->cancelled;
+			break;
+		}
 	}
 
-	return false;
+	return found;
 }
 
-static void debuginfod__miss_add(const struct build_id *bid)
+static void debuginfod__miss_add(const struct build_id *bid, bool cancelled)
 {
 	struct debuginfod_miss *miss = zalloc(sizeof(*miss));
 
@@ -202,36 +329,18 @@ static void debuginfod__miss_add(const struct build_id *bid)
 		return;
 
 	miss->bid = *bid;
+	miss->cancelled = cancelled;
 
 	list_add(&miss->node, &debuginfod__misses);
 }
 
 /*
- * One fetch at a time.
- *
- * The lookup state below is process global, so two concurrent fetches,
- * which dso__debuginfo() makes possible by taking the fetch out of
- * dso__lock, would race for it: the second one could answer from a list
- * the first one is concurrently updating, and put the same build ID on
- * the misses list twice.
- *
- * Serializing also means a second request for a build ID that is being
- * fetched waits here for the fetch to finish, instead of starting a second
- * download of the same file, and is then answered from the entry the fetch
- * published, or from the misses list, with no client at all.  Should the
- * fetches ever run in parallel, that wait has to come back explicitly, with
- * this lock split in two: one only for the lookup state, that the waiters
- * sleep on, and one held around each fetch, with the thread that finds a
- * fetch in progress waiting on the former for the entry to be published.
- *
- * What that costs is that a fetch for one build ID blocks a fetch for
- * another one, and it is what parallel downloads would fix.  Worth doing
- * only if the wait turns out to be long, because it mostly is not: the
- * lookups below answer the second and later requests for a build ID from
- * memory, so after the first pass over the build IDs of a workload, which
- * is the only time anything is fetched at all, the serialization has
- * nothing left to serialize.  Start there if a profile with many DSOs to
- * fetch shows up in a profile of perf itself.
+ * One fetch at a time: the lookup state below and the interaction state
+ * (terminal mode, signal dispositions, progress line and keys) are
+ * process global, so serializing avoids two fetches racing for them.
+ * A request for a build ID being fetched waits here and is answered
+ * from the published entry, or from the misses list, with no second
+ * download.
  */
 static struct mutex debuginfod__fetch_lock;
 
@@ -248,18 +357,9 @@ static void debuginfod__fetch_lock_init(void)
 }
 
 /*
- * The build IDs already fetched in this session, and the path of the file
- * that came back for each, so that the repeated requests for the same build
- * ID, dso__debuginfo() is called per symbol annotated, are answered with a
- * strdup() instead of another client: the file is in the debuginfod client
- * cache already and its path checked before being handed out, in case that
- * cache is cleaned from under us.
- *
- * Guarded by debuginfod__fetch_lock.  Only a fetch that brought a file back
- * gets an entry: one that didn't is recorded in debuginfod__misses as a miss,
- * and that is what keeps the rest of the session from asking for it again.
- * Like debuginfod__misses this grows with the number of build IDs in the
- * workload, one small entry each, and is not trimmed.
+ * Build IDs fetched in this session and the path of the file that came
+ * back, so repeated requests are answered with a strdup() instead of
+ * another client.  Guarded by debuginfod__fetch_lock.
  */
 struct debuginfo_lookup {
 	struct list_head	 node;
@@ -294,10 +394,9 @@ static void debuginfo_lookup__delete(struct debuginfo_lookup *lookup)
 }
 
 /*
- * Remember that this build ID was fetched, with the file at @path, so that
- * the next request for it is answered from memory.  Called with
- * debuginfod__fetch_lock held.  Out of memory just means not sharing this
- * one, the file is fetched and the caller has its path.
+ * Remember that this build ID was fetched, with the file at @path, so
+ * that the next request is answered from memory.  Called with
+ * debuginfod__fetch_lock held.
  */
 static void debuginfo_lookup__add(const struct build_id *bid, const char *path)
 {
@@ -317,12 +416,16 @@ static void debuginfo_lookup__add(const struct build_id *bid, const char *path)
 }
 
 /*
- * The fetch itself.  Called with debuginfod__fetch_lock held for the
- * whole of it, see the comment there.
+ * The fetch itself, and, in the stdio case, the terminal in raw mode:
+ * the caller has to hold debuginfod__fetch_lock for the whole of it.
  */
 static int debuginfod__fetch(const struct build_id *bid, char **path)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
+	struct termios orig_termios;
+	struct sigaction sa, orig_sigint, orig_sigquit, orig_sigterm;
+	bool term_set = false, sigint_set = false, sigquit_set = false;
+	bool sigterm_set = false;
 	debuginfod_client *c;
 	int fd;
 
@@ -330,30 +433,102 @@ static int debuginfod__fetch(const struct build_id *bid, char **path)
 	if (c == NULL)
 		return -1;
 
+	debuginfod_set_progressfn(c, debuginfod_progress_fn);
+
+	debuginfod_fetch_cancelled = false;
+	debuginfod_signal = 0;
+
+	/*
+	 * Make stdin deliver keypresses without waiting for a newline,
+	 * the progress callback above polls it for the 's'/'d' keys,
+	 * only in the stdio case with both stdin and stderr being a
+	 * terminal: the pipe cases have no business being poked here,
+	 * and in the TUI the terminal and its input queue are the
+	 * browser's own.  Intercept SIGINT, SIGQUIT and SIGTERM so that
+	 * the terminal is restored before the process dies, the handler
+	 * only records the signal and the callback aborts the query.
+	 * The handlers go in before the terminal mode changes, so that a
+	 * signal landing in between is caught and the raw mode is
+	 * restored.
+	 */
+	if (isatty(STDIN_FILENO) && isatty(STDERR_FILENO) && !use_browser) {
+		memset(&sa, 0, sizeof(sa));
+		sa.sa_handler = debuginfod_signal_handler;
+		sigemptyset(&sa.sa_mask);
+		if (sigaction(SIGINT, &sa, &orig_sigint) == 0)
+			sigint_set = true;
+		if (sigaction(SIGQUIT, &sa, &orig_sigquit) == 0)
+			sigquit_set = true;
+		if (sigaction(SIGTERM, &sa, &orig_sigterm) == 0)
+			sigterm_set = true;
+
+		set_term_quiet_input(&orig_termios);
+		term_set = true;
+	}
+
 	fd = debuginfod_find_debuginfo(c, bid->data, bid->size, path);
 
-	debuginfod_end(c);
+	if (term_set)
+		tcsetattr(STDIN_FILENO, TCSANOW, &orig_termios);
+	if (sigint_set)
+		sigaction(SIGINT, &orig_sigint, NULL);
+	if (sigquit_set)
+		sigaction(SIGQUIT, &orig_sigquit, NULL);
+	if (sigterm_set)
+		sigaction(SIGTERM, &orig_sigterm, NULL);
 
+	debuginfod_end(c);
+	if (debuginfod_progress_started) {
+		fputc('\n', stderr);
+		debuginfod_progress_started = false;
+	}
 	if (fd < 0) {
 		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+		if (debuginfod_fetch_cancelled || debuginfod_signal) {
+			pr_debug("debuginfod search for build ID %s cancelled by the user\n",
+				 sbuild_id);
+			/*
+			 * Remember it so that the rest of the session doesn't
+			 * ask for the same file again: the user may have
+			 * skipped it for being too big.
+			 */
+			debuginfod__miss_add(bid, true);
+			/*
+			 * The terminal is restored, die as the user asked;
+			 * the original dispositions are back in place.
+			 */
+			if (debuginfod_signal)
+				raise(debuginfod_signal);
+			return -1;
+		}
 		pr_debug("No debuginfo found for build ID %s in debuginfod\n",
 			 sbuild_id);
-		debuginfod__miss_add(bid);
+		debuginfod__miss_add(bid, false);
 		return -1;
 	}
 
 	close(fd);
 
+	/*
+	 * The interrupt can land after the file is already here, in which
+	 * case there is no failure to report, but the user still asked for
+	 * perf to stop, and the terminal and the signal dispositions are
+	 * back to what they were, so honour it here as well instead of
+	 * swallowing it and going on.
+	 */
+	if (debuginfod_signal) {
+		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+		pr_debug("debuginfod found the debuginfo for build ID %s, but the search was interrupted, exiting\n",
+			 sbuild_id);
+		raise(debuginfod_signal);
+	}
+
 	return 0;
 }
 
 /*
- * Look the build ID up in the files already fetched in this session,
- * fetching it if it isn't there yet.  Called, and left, with
- * debuginfod__fetch_lock held, which also means that no fetch for this
- * build ID can be running anywhere else: a second request for a build ID
- * being fetched waits for the lock and is answered from the entry the fetch
- * published, or from the misses list, with no client at all.
+ * Look the build ID up in the files already fetched, fetching it if it
+ * isn't there yet.  Called, and left, with debuginfod__fetch_lock held.
  */
 static int debuginfo_lookup__find_build_id(const struct build_id *bid, char **path)
 {
@@ -361,13 +536,8 @@ static int debuginfo_lookup__find_build_id(const struct build_id *bid, char **pa
 
 	if (lookup != NULL) {
 		/*
-		 * The file stays in the debuginfod client cache, but that
-		 * cache can be cleaned from under us, so check that it is
-		 * still there before handing its path out.  If it isn't,
-		 * forget the entry and look for the file again below,
-		 * remembering the new answer the same way the first fetch
-		 * does, so that the next lookup shares it instead of
-		 * fetching it a third time.
+		 * The file may have been cleaned from the debuginfod client cache:
+		 * if it is gone, forget the entry and fetch it again below.
 		 */
 		if (access(lookup->path, R_OK) == 0) {
 			*path = strdup(lookup->path);
@@ -386,25 +556,10 @@ static int debuginfo_lookup__find_build_id(const struct build_id *bid, char **pa
 }
 
 /*
- * Find a debuginfo file keyed by the build ID, using the debuginfod
- * client, which checks its local cache first and then queries the
- * servers in DEBUGINFOD_URLS.  Used when the debuginfo is not available
- * locally under the name the DSO was opened with, for instance the
- * vmlinux for the kernel the profile was recorded on, when processing
- * the profile on another machine or after the kernel or its debuginfo
- * package got upgraded in between.
- *
- * Querying servers, possibly third party, sends the build IDs of the
- * binaries being analysed off the box, so this is opt-out: on by
- * default, switchable off with --no-debuginfod, with
- * core.debuginfod=false, with the per-tool
- * report.debuginfod/top.debuginfod, and it is off too when the user
- * disabled the local build-id/.debug cache, e.g. with
- * buildid.dir = /dev/null, as is the case for users that don't want
- * any of this stored locally.
- *
- * On success the path is stored in *@path and must be freed by the
- * caller, the file remains available in the debuginfod client cache.
+ * Find a debuginfo file keyed by the build ID using the debuginfod
+ * client, which checks its local cache first and then the servers in
+ * DEBUGINFOD_URLS.  On success the path is stored in *@path and must be
+ * freed by the caller.
  */
 int debuginfo__find_build_id(const struct build_id *bid, char **path)
 {
@@ -416,26 +571,26 @@ int debuginfo__find_build_id(const struct build_id *bid, char **path)
 		return -1;
 
 	/*
-	 * The checks below have to be made with the lock held, as they look
-	 * at the state the fetch changes: a build ID the fetch in progress
-	 * just settled as a miss is settled for whoever is waiting for the
-	 * lock as well.  Deciding here and fetching there would repeat a
-	 * fetch that was already made, and put the same build ID on the
-	 * misses list twice.
+	 * These check the state the fetch changes, so they have to run with
+	 * the lock held.
 	 */
 	debuginfod__fetch_lock_init();
 	mutex_lock(&debuginfod__fetch_lock);
 
 	if (symbol_conf.debuginfod) {
+		bool cancelled;
+
 		if (debuginfod__cache_disabled()) {
 			pr_debug("Build-id cache disabled (buildid dir is '%s'), not using debuginfod\n",
 				 buildid_dir);
-		} else if (debuginfod__missed(bid)) {
+		} else if (debuginfod__missed(bid, &cancelled)) {
 			char sbuild_id[SBUILD_ID_SIZE];
 
 			build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
-			pr_debug("Not searching build ID %s in debuginfod again, it was a miss earlier\n",
-				 sbuild_id);
+			pr_debug("Not searching build ID %s in debuginfod again, %s\n",
+				 sbuild_id,
+				 cancelled ? "the user cancelled the search earlier" :
+					     "it was a miss earlier");
 		} else {
 			err = debuginfo_lookup__find_build_id(bid, path);
 		}
-- 
2.55.0

