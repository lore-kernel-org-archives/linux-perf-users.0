Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31613261B8D;
	Wed, 16 Sep 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559302; cv=none; b=pSLucrLGPGEej2g5i1bn58BOECf0fveRqo1HB5eroJ1cEzIkSHRbZrhKvG1Ghj5DsVSS5BlYaznpYiXnG988Nmnp+rl9CuWKTbPOv9ePLSNhwcTXVAksquMsHoCJSWGJWLAgtrohioSkYoOnporalhwAr6hyzYD20xcO+oO4wwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559302; c=relaxed/simple;
	bh=Ytpm/am8TbLHqiUqhZ7sU4G+ccKooQdYSniobfxb3ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOHPBPb/Jxj2CAb7Akh5FkMxZwkAPpCOxc3qf2+g6quhI8eSxYubHjBzv0Xx72SiAVhD6bIqDt5hVI3SSkH9VOT1eEVdFrHR6Xeh6C/3y6EN0OPeS1xsh482d4+5I0ZnDldCA7N4pRIunwN9fvlpHHM/eJrhrq36JzqdD0Yi1DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Md9qhfLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Md9qhfLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99561F00893;
	Wed, 16 Sep 2026 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559288;
	bh=G73mPiNbqNi5jS9R06XuhUInSIvW+d8V75TUl3+PIsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Md9qhfLCJrGT1WcSI/oUKrUMRrrCbheACgSjr3cshJOkOACU+9jf7Ak4YFi5+aAER
	 yErNq7f1Ma3VTsUB+xHtsWXcyWNBYG08vNGIE8AJIqQGgC3R6zie5/dHvJDJv1kiPX
	 mTnkfDUsuYFlrZjFvFUuvW/BOhd/OUkmc9VHZYFJeK6IY6nuuWhxYsXgM+x/kFd0Lg
	 Bfr9R1C+EOV5xWRQzYcbKQE9hrcJ9h1XvlH0EBYBZaN1uOtYrZpw0dtwRQNEmPbQ2G
	 a+KYDiK0NPBldByuvrBqmJfZlVjuYNHdz1/JchsA6oc3UhU/4IYgR67lVqGgVDRumr
	 TiRK9eYHj5LhA==
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
Subject: [PATCH 04/12] perf debuginfo: Let the user skip and disable debuginfod fetches
Date: Wed, 16 Sep 2026 08:47:31 -0300
Message-ID: <20260916114740.48230-5-acme@kernel.org>
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

When a fetch is in progress, the way it prints progress is how one
gets out of it: 's' aborts the current fetch via the debuginfod
client's progress callback protocol and remembers the build ID, so
that the rest of the session doesn't ask for it again, the user may
have skipped it for being too big; 'd' additionally disables debuginfod
for the rest of the session, clearing DEBUGINFOD_URLS so that libdwfl's
own client, that reads it in every query, stops fetching too, and, using
perf_config__set_variable(), moved to util/config.c in the previous
patch, writes core.debuginfod=false to the configuration file directly,
the user's ~/.perfconfig or the one named by PERF_CONFIG, the same
rewrite 'perf config' does -- the comments are not preserved, as the
config set carries just the key-value pairs -- and SIGINT, SIGQUIT and
SIGTERM are intercepted while the terminal is in raw mode, so that it is
restored and the signal is re-raised when the user interrupts a fetch.

In the TUI nothing is shown yet, printing to stderr would garble the
browser display and draining stdin would eat the keys the browser
wants, that comes in the next patch.

The interaction state -- the terminal settings, the signal dispositions
and the progress and cancellation state -- is process global, so the
fetches stay serialized: a second fetch resetting the cancellation
state would drop the 's'/'d' keypress that was meant for the fetch
already in progress, and the serialization the lookup state needs
already provides the lock the interaction state uses.

Since the debuginfo fetching this builds on is opt-out, a fetch that
the user asked to skip is not restarted by the next request for the
same build ID in the same session, it is remembered as a cancellation
on the misses list, where the debug message can tell it apart from a
plain miss.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |   4 +-
 tools/perf/Documentation/perf-report.txt   |  11 +-
 tools/perf/Documentation/perf-top.txt      |  10 +-
 tools/perf/util/debuginfo.c                | 311 ++++++++++++++++++---
 4 files changed, 296 insertions(+), 40 deletions(-)

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
index be5882d9c2204797..e2066fce2450c6fb 100644
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
@@ -146,6 +150,134 @@ struct debuginfo *debuginfo__new(const char *path)
 }
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
+/*
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
+ * A fetch can be interrupted with Ctrl-C, Ctrl-\ or SIGTERM while stdin
+ * is in raw mode: the handler only records the signal, the progress
+ * callback aborts the query, and debuginfod__fetch() restores the
+ * terminal and raises the signal again, so that it is not left in raw
+ * mode when perf dies mid-fetch.
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
+ * the rest of the session, clearing DEBUGINFOD_URLS so that libdwfl's
+ * own client, that reads it in every query, stops fetching too, and
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
+		 * libdwfl's own debuginfod client reads DEBUGINFOD_URLS
+		 * in every query, so clear it to stop it as well.
+		 */
+		setenv("DEBUGINFOD_URLS", "", 1);
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
+ * The stdio fetch UI: the terminal is in raw mode, see
+ * debuginfod__fetch(), so the keypresses are on stdin, drain them.
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
 /*
  * Users can disable the local build-id/.debug cache by setting
  * buildid.dir to /dev/null, meaning they don't want fetched
@@ -163,8 +295,11 @@ static bool debuginfod__cache_disabled(void)
  * ones already searched for on the debuginfod servers without success,
  * so that callers that see the same DSO over and over, such as the data
  * type profiler switching between DSOs on every hist entry, don't pay a
- * server round trip again for each miss.  The cache of successes is the
- * debuginfod client's own, in the local filesystem.
+ * server round trip again for each miss, and the ones whose search the
+ * user cancelled, maybe because what was being downloaded is too big,
+ * so that the next request for the same build ID doesn't restart a
+ * download that was refused.  The cache of successes is the debuginfod
+ * client's own, in the local filesystem.
  *
  * Guarded by debuginfod__fetch_lock: it is only read by the lookups
  * below, that run with that lock held, and written by fetches, that run
@@ -173,28 +308,37 @@ static bool debuginfod__cache_disabled(void)
 struct debuginfod_miss {
 	struct list_head	node;
 	struct build_id		bid;
+	bool			cancelled;
 };
 
 static LIST_HEAD(debuginfod__misses);
 
 /*
- * Was the search for this build ID already made and settled, i.e. the
- * servers had nothing for it?
+ * Was the search for this build ID already settled, by the servers
+ * having nothing or by the user cancelling it?  When it was, @cancelled
+ * tells the two apart, so that the debug message can say which one it
+ * was.
  */
-static bool debuginfod__missed(const struct build_id *bid)
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
 
@@ -202,6 +346,7 @@ static void debuginfod__miss_add(const struct build_id *bid)
 		return;
 
 	miss->bid = *bid;
+	miss->cancelled = cancelled;
 
 	list_add(&miss->node, &debuginfod__misses);
 }
@@ -209,11 +354,17 @@ static void debuginfod__miss_add(const struct build_id *bid)
 /*
  * One fetch at a time.
  *
- * The lookup state below is process global, so two concurrent fetches,
+ * The terminal settings, the signal dispositions and the progress and
+ * cancellation state below are process global, so two concurrent fetches,
  * which dso__debuginfo() makes possible by taking the fetch out of
- * dso__lock, would race for it: the second one could answer from a list
- * the first one is concurrently updating, and put the same build ID on
- * the misses list twice.
+ * dso__lock, would fight over them: the second one would take the first
+ * one's raw mode as the state to restore and leave the terminal broken when
+ * it is done, and resetting the cancellation state would drop the 's'/'d'
+ * keypress that was meant for the fetch already in progress.  Serializing
+ * also keeps the two from racing for the same keypresses and for the same
+ * progress line, and a second fetch has nothing to gain from running in
+ * parallel with a first one reading the same kind of file off the same
+ * servers.
  *
  * Serializing also means a second request for a build ID that is being
  * fetched waits here for the fetch to finish, instead of starting a second
@@ -221,11 +372,16 @@ static void debuginfod__miss_add(const struct build_id *bid)
  * published, or from the misses list, with no client at all.  Should the
  * fetches ever run in parallel, that wait has to come back explicitly, with
  * this lock split in two: one only for the lookup state, that the waiters
- * sleep on, and one held around each fetch, with the thread that finds a
- * fetch in progress waiting on the former for the entry to be published.
+ * sleep on, and one for the process global state above, held around each
+ * fetch, with the thread that finds a fetch in progress waiting on the
+ * former for the entry to be published.
  *
  * What that costs is that a fetch for one build ID blocks a fetch for
- * another one, and it is what parallel downloads would fix.  Worth doing
+ * another one, and it is what parallel downloads would fix: the terminal
+ * in raw mode, the signal dispositions, the progress line and the 's'/'d'
+ * keys would have to become per fetch and refcounted, so that N fetches
+ * share one terminal session and one signal handler, with the first one in
+ * setting them up and the last one out putting them back.  Worth doing
  * only if the wait turns out to be long, because it mostly is not: the
  * lookups below answer the second and later requests for a build ID from
  * memory, so after the first pass over the build IDs of a workload, which
@@ -256,10 +412,11 @@ static void debuginfod__fetch_lock_init(void)
  * cache is cleaned from under us.
  *
  * Guarded by debuginfod__fetch_lock.  Only a fetch that brought a file back
- * gets an entry: one that didn't is recorded in debuginfod__misses as a miss,
- * and that is what keeps the rest of the session from asking for it again.
- * Like debuginfod__misses this grows with the number of build IDs in the
- * workload, one small entry each, and is not trimmed.
+ * gets an entry: one that didn't is recorded in debuginfod__misses, either
+ * as a miss or as a user cancellation, and that is what keeps the rest of
+ * the session from asking for it again.  Like debuginfod__misses this grows
+ * with the number of build IDs in the workload, one small entry each, and is
+ * not trimmed.
  */
 struct debuginfo_lookup {
 	struct list_head	 node;
@@ -317,12 +474,18 @@ static void debuginfo_lookup__add(const struct build_id *bid, const char *path)
 }
 
 /*
- * The fetch itself.  Called with debuginfod__fetch_lock held for the
- * whole of it, see the comment there.
+ * The fetch itself, and, in the stdio case, the terminal in raw mode
+ * and the signal dispositions swapped for the ones that restore it, so
+ * that the caller has to hold debuginfod__fetch_lock for the whole of
+ * it, see the comment there.
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
 
@@ -330,20 +493,96 @@ static int debuginfod__fetch(const struct build_id *bid, char **path)
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
 
@@ -397,7 +636,7 @@ static int debuginfo_lookup__find_build_id(const struct build_id *bid, char **pa
  * Querying servers, possibly third party, sends the build IDs of the
  * binaries being analysed off the box, so this is opt-out: on by
  * default, switchable off with --no-debuginfod, with
- * core.debuginfod=false, with the per-tool
+ * core.debuginfod=false (what the 'd' key writes), with the per-tool
  * report.debuginfod/top.debuginfod, and it is off too when the user
  * disabled the local build-id/.debug cache, e.g. with
  * buildid.dir = /dev/null, as is the case for users that don't want
@@ -417,25 +656,31 @@ int debuginfo__find_build_id(const struct build_id *bid, char **path)
 
 	/*
 	 * The checks below have to be made with the lock held, as they look
-	 * at the state the fetch changes: a build ID the fetch in progress
-	 * just settled as a miss is settled for whoever is waiting for the
-	 * lock as well.  Deciding here and fetching there would repeat a
-	 * fetch that was already made, and put the same build ID on the
-	 * misses list twice.
+	 * at the state the fetch changes: debuginfod can be turned off while
+	 * a fetch is in progress, by the 'd' key in its progress line, and a
+	 * build ID the fetch in progress just settled, as a miss or as a
+	 * cancellation, is settled for whoever is waiting for the lock as
+	 * well.  Deciding here and fetching there would repeat a fetch that
+	 * was already made, and put the same build ID on the misses list
+	 * twice.
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

