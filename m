Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8337377AAD;
	Sun, 13 Sep 2026 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789266916; cv=none; b=rtazghv7PigkRxiN/LW6HUOcoZAcj8PmlRLQ3oL+Ye9cU14l6UmX/rUHa0Qhp1SnCJk6t3Sgz/Pj2avovPzUNZXnswn6/ZYLy6ZzNkZPRa8xVj8o++O0Vqztk9nAyMsVvhVww6igOPJel6EJOrckTnrUAwqHLdrcPwJiWIf6u1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789266916; c=relaxed/simple;
	bh=0Kw5c/Ef2VOMKNkznl7gEqTVKVPPQ3+x6DEcq5TdD/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLKNEiNRJy4lFmKWRhUYThJ3G2pBaTMHd0x98AronzaCoARal1TFd/fEPFSKxF9ausnFyMrYkrRGltREWrPbC3ekzr4PgVBHOt6/PtU0GW7tjg/k1hSSF+vDeuN2WFitcda1EWgNFMJOwBRcxXsyUJn4pS/cXZ0prd+77q5kttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKTzn+zu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKTzn+zu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A5F1F000FF;
	Sun, 13 Sep 2026 02:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789266914;
	bh=nYpBDvQOfe+G/O4OkQ/+MFAO+g+JcImd/0blQj3xZPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKTzn+zu38copCgaH3u5CZtuCb9JUQ6h56c0++j56sIUMmKWNijZMXrjiZD9caxMy
	 BzzQvLcKmf1CkaQRT1Atkw+Ugd2sYXV4FrVdgOOBSa843rPC0ZL41lxck44PJAeNax
	 8lJ+Y+9/370nM1d/X7t0ItocjL8ZnZLBdrrkGgPa8ccaafpTRtWs61+Adl+CFbQ0sg
	 sYMOrp8yTCRcM+9/qbtz5IrddxQBo5qP1Ko40ykh+hUC675iggjLEeXpUmSThLnV/C
	 3vV24id/Hxx6Qnju8VZd5Y6H1n5ZH8pyew8rXZRQHJoes59LYIaC8xV3iBYyUBKUts
	 Q+N3qXrZpuopA==
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
Subject: [PATCH v1 2/8] perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod
Date: Sat, 12 Sep 2026 23:34:53 -0300
Message-ID: <20260913023459.112654-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913023459.112654-1-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf already uses debuginfod to fetch source files when annotating
(via probe-finder.c) and 'perf probe' has open_from_debuginfod(),
which queries debuginfo keyed by build ID when a module's debuginfo
isn't found locally, largely the same thing this adds; eventually
that one could be moved over to the new helper.  For the analysis
tools there was no way to obtain the debuginfo for a DSO in a
profile when it isn't available locally under the name the DSO was
opened with, for instance the vmlinux for the kernel a profile was
recorded on when processing it on another machine, or after the
kernel and its debuginfo package got upgraded in between.

Add debuginfo__find_build_id(), that uses the debuginfod client to
locate a debuginfo file keyed by the build ID, checking its local
cache first and then querying the servers in DEBUGINFOD_URLS, and
debuginfo__new_build_id(), that opens the DWARF in the file it finds.

The debuginfod client fails when DEBUGINFOD_URLS isn't set even when
what it wants is in its local cache, and the distro setup scripts that
populate it from /etc/debuginfod don't reach cron jobs, systemd services
and other environments that don't source the profile scripts, so also
set it from the .urls files in /etc/debuginfod when not set.

Querying servers, possibly third party ones, sends off-box the build
IDs of the binaries being analysed and a fetch can take a while, so
this is opt-out: on by default, off with --no-debuginfod, with
core.debuginfod=false, per tool with report.debuginfod and
top.debuginfod, and, since users that set buildid.dir to /dev/null
(e.g. Linus) or otherwise turn the local build-id cache off clearly
don't want fetched files stored on the box, off too in that case.

When a fetch is in progress in a terminal, stdio, the way it prints
progress is how one gets out of it: 's' aborts the current fetch via
the debuginfod client's progress callback protocol, 'd' additionally
disables debuginfod for the rest of the session and points at 'perf
config core.debuginfod=false' to make that permanent -- rewriting the
user's ~/.perfconfig from a keypress would silently drop its comments
-- and SIGINT/SIGTERM are intercepted while the terminal is in raw
mode, so that it is restored and the signal is re-raised when the user
interrupts a fetch.

Make dso__debuginfo() use debuginfo__new_build_id() as a fallback,
keyed by the build ID recorded in the perf.data file, so that
consumers such as the data type profiler can resolve the types of
DSOs whose debuginfo can be fetched this way.  Do the fetch outside
dso__lock and remember the build IDs that were a miss, so that
consumers revisiting a set of DSOs repeatedly, such as the data type
profiler on every hist entry DSO switch, don't pay server round trips
per attempt, a user cancelled search isn't recorded as a miss.

debuginfo__new_build_id() needs libdw to open the DWARF, so it lives
in debuginfo.o, built only with CONFIG_LIBDW, while the libdebuginfod
feature check is independent of NO_LIBDW; keep the new build ID
prototypes under HAVE_LIBDW_SUPPORT too, with stubs otherwise, so
that make NO_LIBDW=1 on a system that has the debuginfod client
keeps linking.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |  10 +
 tools/perf/Documentation/perf-config.txt   |  19 ++
 tools/perf/Documentation/perf-report.txt   |  15 +
 tools/perf/Documentation/perf-top.txt      |  14 +
 tools/perf/builtin-annotate.c              |   2 +
 tools/perf/builtin-report.c                |   6 +
 tools/perf/builtin-top.c                   |   6 +
 tools/perf/util/config.c                   |   3 +
 tools/perf/util/debuginfo.c                | 372 +++++++++++++++++++++
 tools/perf/util/debuginfo.h                |  36 ++
 tools/perf/util/dso.c                      |  19 ++
 tools/perf/util/symbol.c                   |   2 +
 tools/perf/util/symbol_conf.h              |   1 +
 13 files changed, 505 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 1a90b09a12d5abb1..25af1d166dc4c877 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -58,6 +58,16 @@ OPTIONS
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--debuginfod::
+--no-debuginfod::
+	Fetch debuginfo keyed by build ID from the debuginfod servers
+	configured in DEBUGINFOD_URLS, checking the local debuginfod
+	client cache first, when it is not available locally, on for
+	these commands by default.  See the --debuginfod option of
+	'perf report' for how to turn it off, including the 's' and
+	'd' keys that skip a fetch in progress while 'perf' is
+	waiting for it.
+
 --itrace::
 	Options for decoding instruction tracing data. The options are:
 
diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 9b223f8928299945..688306abe847a0df 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -216,6 +216,14 @@ core.*::
 	addr2line-timeout::
 		Sets a timeout (in milliseconds) for parsing 'addr2line'
 		output.  The default timeout is 5s.
+	debuginfod::
+		When set to 'false', disable fetching debuginfo keyed by
+		build ID from the debuginfod servers configured in
+		DEBUGINFOD_URLS.  It is on by default, can be overridden per
+		tool with the 'report.debuginfod' and 'top.debuginfod'
+		options and per invocation with --no-debuginfod; it is off
+		too when the local build-id cache is disabled, e.g.
+		'buildid.dir' set to /dev/null.
 
 tui.*, gtk.*::
 	Subcommands that can be configured here are 'top', 'report' and 'annotate'.
@@ -562,6 +570,14 @@ report.*::
 		This option can change default stat behavior with empty results.
 		If it's set true, 'perf report --stat' will not show 0 stats.
 
+	report.debuginfod::
+		Fetch debuginfo keyed by build ID from the debuginfod
+		servers configured in DEBUGINFOD_URLS, checking the local
+		debuginfod client cache first, when it is not available
+		locally.  On by default, set to 'false' to disable it for
+		'perf report', globally with 'core.debuginfod=false' or per
+		invocation with --no-debuginfod.
+
 top.*::
 	top.children::
 		Same as 'report.children'. So if it is enabled, the output of 'top'
@@ -569,6 +585,9 @@ top.*::
 		column by default.
 		The default is 'true'.
 
+	top.debuginfod::
+		Same as 'report.debuginfod', for 'perf top'.
+
 	top.call-graph::
 		This is identical to 'call-graph.record-mode', except it is
 		applicable only for 'top' subcommand. This option ONLY setup
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index ae68ca402d0b4f0e..fed6af128ff07e4c 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -366,6 +366,21 @@ OPTIONS
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--debuginfod::
+--no-debuginfod::
+	Fetch debuginfo keyed by build ID from the debuginfod servers
+	configured in DEBUGINFOD_URLS, checking the local debuginfod
+	client cache first, when it is not available locally, on for
+	these commands by default.  It can be turned off per invocation
+	with --no-debuginfod, per tool with the "report.debuginfod"
+	config option or globally with "core.debuginfod" set to false.
+	While a fetch is in progress in the stdio interface, 's' skips
+	the current fetch and 'd' skips it and disables debuginfod for
+	the rest of the session, pointing at 'perf config' to make that
+	permanent.  It is disabled as well when the local build-id cache
+	is turned off, e.g. "buildid.dir" set to /dev/null, as that
+	asks for fetched files not to be kept on the box.
+
 --kallsyms=<file>::
         kallsyms pathname
 
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 2da2a16bbf260685..8bcb7b0ac4a2407a 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -83,6 +83,20 @@ Default is to monitor all CPUS.
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--debuginfod::
+--no-debuginfod::
+	Fetch debuginfo keyed by build ID from the debuginfod servers
+	configured in DEBUGINFOD_URLS, checking the local debuginfod
+	client cache first, when it is not available locally, on for
+	these commands by default.  Turn it off per invocation with
+	--no-debuginfod, with the "top.debuginfod" config option or
+	globally with "core.debuginfod" set to false.  While a fetch is
+	in progress in the stdio interface, 's' skips the current fetch
+	and 'd' skips it and disables debuginfod for the rest of the
+	session, pointing at 'perf config' to make that permanent.
+	Disabled as well when the build-id cache is off, e.g.
+	"buildid.dir" set to /dev/null.
+
 --kallsyms=<file>::
 	kallsyms pathname
 
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 4638e6fdc39bb6b7..d14ae7d1c345cb79 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -733,6 +733,8 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
                     "don't load vmlinux even if found"),
+	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
+                    "fetch debuginfo keyed by build ID from the debuginfod servers, on by default, use --no-debuginfod to turn off"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b280ff9ff45e6485..4d3383d1daae2ed9 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -134,6 +134,10 @@ static int report__config(const char *var, const char *value, void *cb)
 		symbol_conf.event_group = perf_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "report.debuginfod")) {
+		symbol_conf.debuginfod = perf_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "report.percent-limit")) {
 		double pcnt = strtof(value, NULL);
 
@@ -1346,6 +1350,8 @@ int cmd_report(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
                     "don't load vmlinux even if found"),
+	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
+                    "fetch debuginfo keyed by build ID from the debuginfod servers, on by default, use --no-debuginfod to turn off"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
 		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c2562d49be46a9a1..aed45167d95005dd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1436,6 +1436,10 @@ static int perf_top_config(const char *var, const char *value, void *cb __maybe_
 		symbol_conf.cumulate_callchain = perf_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "top.debuginfod")) {
+		symbol_conf.debuginfod = perf_config_bool(var, value);
+		return 0;
+	}
 
 	return 0;
 }
@@ -1508,6 +1512,8 @@ int cmd_top(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
 		    "don't load vmlinux even if found"),
+	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
+                    "fetch debuginfo keyed by build ID from the debuginfod servers, on by default, use --no-debuginfod to turn off"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
 		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index b2972c35c1eca68c..31c6618d3b3daf22 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -470,6 +470,9 @@ static int perf_default_core_config(const char *var, const char *value)
 	if (!strcmp(var, "core.addr2line-disable-warn"))
 		symbol_conf.addr2line_disable_warn = perf_config_bool(var, value);
 
+	if (!strcmp(var, "core.debuginfod"))
+		symbol_conf.debuginfod = perf_config_bool(var, value);
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 84a78b30ceac1066..82158750318defd9 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -7,17 +7,26 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <dirent.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <termios.h>
 #include <unistd.h>
+#include <linux/list.h>
 #include <linux/zalloc.h>
+#include <api/fs/fs.h>
 
 #include "build-id.h"
 #include "dso.h"
 #include "debug.h"
 #include "debuginfo.h"
+#include "mutex.h"
 #include "symbol.h"
+#include "term.h"
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 #include <elfutils/debuginfod.h>
@@ -139,6 +148,369 @@ struct debuginfo *debuginfo__new(const char *path)
 	return __debuginfo__new(buf);
 }
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+/*
+ * Set with the use_browser variable in ui/ui.h, not included here to
+ * avoid pulling in the UI headers: when the TUI is in use, printing to
+ * stderr would garble its display.
+ */
+extern int use_browser;
+
+static bool debuginfod_progress_started;
+static bool debuginfod_fetch_cancelled;
+
+/*
+ * A fetch can be interrupted with Ctrl-C/SIGTERM while stdin is in raw
+ * mode: the handler only records the signal, the progress callback
+ * aborts the query, and debuginfo__find_build_id() restores the
+ * terminal and raises the signal again, so that the terminal is never
+ * left in raw mode when perf dies mid-fetch.
+ */
+static volatile sig_atomic_t debuginfod_signal;
+
+static void debuginfod_signal_handler(int sig)
+{
+	debuginfod_signal = sig;
+}
+
+/*
+ * 's': skip this fetch, the query is aborted by returning a non-zero
+ * value from the progress callback, as the debuginfod client docs
+ * prescribe.  'd': also disable debuginfod for the rest of the session,
+ * telling how to make that permanent: rewriting the user's ~/.perfconfig
+ * from here would drop its comments, so point at 'perf config' instead.
+ */
+static void debuginfod__poll_cancel_keys(void)
+{
+	char ch;
+
+	while (read(STDIN_FILENO, &ch, 1) == 1) {
+		if (ch == 's' || ch == 'S') {
+			debuginfod_fetch_cancelled = true;
+			fputs("\nSkipping this debuginfod fetch, press 'd' to also disable it for this session\n", stderr);
+		} else if (ch == 'd' || ch == 'D') {
+			debuginfod_fetch_cancelled = true;
+			symbol_conf.debuginfod = false;
+			fputs("\nSkipping this debuginfod fetch and disabling debuginfod for this session, run 'perf config core.debuginfod=false' to also disable it permanently\n", stderr);
+		}
+	}
+}
+
+/*
+ * Print a warning and a progress indicator when the debuginfod client
+ * ends up fetching a file, which can be big, such as the vmlinux for a
+ * kernel profiled on another machine or before it got upgraded, so that
+ * users know perf is not stuck, and let them bail out: 's' skips this
+ * fetch, 'd' also disables debuginfod for the rest of the session.  The
+ * client only invokes this once it committed to a server, so 'a' is the
+ * number of bytes fetched so far, 'b' the total size when the server
+ * tells it, -1 otherwise.
+ */
+static int debuginfod_progress_fn(debuginfod_client *c __maybe_unused,
+				  long a, long b)
+{
+	if (!isatty(STDERR_FILENO) || use_browser)
+		return 0;
+
+	if (debuginfod_signal)
+		return 1;
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
+ * The debuginfod client checks its local cache only as part of the
+ * server query flow, so with no servers configured it fails even when
+ * the artifact is in the client cache.  Distro setup scripts, e.g.
+ * /etc/profile.d/99-debuginfod.sh, export DEBUGINFOD_URLS from the
+ * .urls files in /etc/debuginfod, but that doesn't reach environments
+ * that don't source the profile scripts, such as cron jobs, systemd
+ * services and CI, so do it here when the variable isn't set.  An
+ * explicitly empty DEBUGINFOD_URLS is an opt-out, matching the
+ * perf_debuginfod_setup() handling, and is left alone.
+ */
+static void debuginfod__setup_urls_env(void)
+{
+	char *urls = NULL;
+	DIR *dir;
+	struct dirent *dent;
+
+	if (getenv("DEBUGINFOD_URLS") != NULL)
+		return;
+
+	dir = opendir("/etc/debuginfod");
+	if (dir == NULL)
+		return;
+
+	while ((dent = readdir(dir)) != NULL) {
+		char *content = NULL;
+		char *new_urls;
+		char path[PATH_MAX];
+		size_t len = strlen(dent->d_name), i, size;
+		int n;
+
+		if (len < 5 || strcmp(dent->d_name + len - 5, ".urls"))
+			continue;
+
+		snprintf(path, sizeof(path), "/etc/debuginfod/%s", dent->d_name);
+		if (filename__read_str(path, &content, &size) < 0)
+			continue;
+
+		for (i = 0; i < size; i++)
+			if (content[i] == '\n' || content[i] == '\r')
+				content[i] = ' ';
+
+		if (urls == NULL) {
+			urls = strdup(content);
+		} else {
+			n = asprintf(&new_urls, "%s %s", urls, content);
+			if (n < 0) {
+				free(content);
+				continue;
+			}
+			free(urls);
+			urls = new_urls;
+		}
+		free(content);
+	}
+	closedir(dir);
+
+	if (urls != NULL) {
+		setenv("DEBUGINFOD_URLS", urls, 1);
+		pr_debug("Set DEBUGINFOD_URLS from /etc/debuginfod: %s\n", urls);
+	}
+	free(urls);
+}
+
+/*
+ * Users can disable the local build-id/.debug cache by setting
+ * buildid.dir to /dev/null, meaning they don't want fetched
+ * binaries/debuginfo stored on the box; the debuginfod client keeps
+ * its own cache in ~/.cache/debuginfod_client, so honour that intent
+ * and don't fetch at all in that case.
+ */
+static bool debuginfod__cache_disabled(void)
+{
+	return !strcmp(buildid_dir, "/dev/null");
+}
+
+/*
+ * Build IDs already searched for on the debuginfod servers without
+ * success, so that callers that see the same DSO over and over, such as
+ * the data type profiler switching between DSOs on every hist entry,
+ * don't pay a server round trip again for each miss.  The cache of
+ * successes is the debuginfod client's own, in the local filesystem.
+ */
+struct debuginfod_miss {
+	struct list_head	node;
+	struct build_id		bid;
+};
+
+static LIST_HEAD(debuginfod__misses);
+static struct mutex debuginfod__missed_lock;
+
+static void debuginfod__missed_lock_setup(void)
+{
+	mutex_init(&debuginfod__missed_lock);
+}
+
+static void debuginfod__missed_lock_init(void)
+{
+	static pthread_once_t once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&once, debuginfod__missed_lock_setup);
+}
+
+static bool debuginfod__missed(const struct build_id *bid)
+{
+	struct debuginfod_miss *miss;
+	bool found = false;
+
+	debuginfod__missed_lock_init();
+	mutex_lock(&debuginfod__missed_lock);
+	list_for_each_entry(miss, &debuginfod__misses, node) {
+		if (miss->bid.size == bid->size &&
+		    !memcmp(miss->bid.data, bid->data, bid->size)) {
+			found = true;
+			break;
+		}
+	}
+	mutex_unlock(&debuginfod__missed_lock);
+
+	return found;
+}
+
+static void debuginfod__miss_add(const struct build_id *bid)
+{
+	struct debuginfod_miss *miss = zalloc(sizeof(*miss));
+
+	if (miss == NULL)
+		return;
+
+	miss->bid = *bid;
+
+	debuginfod__missed_lock_init();
+	mutex_lock(&debuginfod__missed_lock);
+	list_add(&miss->node, &debuginfod__misses);
+	mutex_unlock(&debuginfod__missed_lock);
+}
+
+/*
+ * Find a debuginfo file keyed by the build ID, using the debuginfod
+ * client, which checks its local cache first and then queries the
+ * servers in DEBUGINFOD_URLS.  Used when the debuginfo is not available
+ * locally under the name the DSO was opened with, for instance the
+ * vmlinux for the kernel the profile was recorded on, when processing
+ * the profile on another machine or after the kernel or its debuginfo
+ * package got upgraded in between.
+ *
+ * Querying servers, possibly third party, sends the build IDs of the
+ * binaries being analysed off the box, so this is opt-out: on by
+ * default, switchable off with --no-debuginfod, with
+ * core.debuginfod=false (what the 'd' key below writes), with the
+ * per-tool report.debuginfod/top.debuginfod, and it is off too when
+ * the user disabled the local build-id/.debug cache, e.g. with
+ * buildid.dir = /dev/null, as is the case for users that don't want
+ * any of this stored locally.
+ *
+ * On success the path is stored in *@path and must be freed by the
+ * caller, the file remains available in the debuginfod client cache.
+ */
+int debuginfo__find_build_id(const struct build_id *bid, char **path)
+{
+	char sbuild_id[SBUILD_ID_SIZE];
+	struct termios orig_termios;
+	struct sigaction sa, orig_sigint, orig_sigterm;
+	bool term_set = false, sigint_set = false, sigterm_set = false;
+	debuginfod_client *c;
+	int fd;
+
+	*path = NULL;
+
+	if (!build_id__is_defined(bid) || !symbol_conf.debuginfod)
+		return -1;
+
+	if (debuginfod__cache_disabled()) {
+		pr_debug("Build-id cache disabled (buildid dir is '%s'), not using debuginfod\n",
+			 buildid_dir);
+		return -1;
+	}
+
+	if (debuginfod__missed(bid)) {
+		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+		pr_debug("Not searching build ID %s in debuginfod again, it was a miss earlier\n",
+			 sbuild_id);
+		return -1;
+	}
+
+	debuginfod__setup_urls_env();
+
+	c = debuginfod_begin();
+	if (c == NULL)
+		return -1;
+
+	debuginfod_set_progressfn(c, debuginfod_progress_fn);
+
+	debuginfod_fetch_cancelled = false;
+	debuginfod_signal = 0;
+
+	/*
+	 * Make stdin deliver keypresses without waiting for a newline,
+	 * the progress callback above polls it for the 's'/'d' keys,
+	 * only in the stdio case with both stdin and stderr being a
+	 * terminal, the TUI/pipe cases have no business being poked
+	 * here.  Intercept SIGINT/SIGTERM so that the terminal is
+	 * restored before the process dies, the handler only records
+	 * the signal and the callback aborts the query.
+	 */
+	if (isatty(STDIN_FILENO) && isatty(STDERR_FILENO) && !use_browser) {
+		set_term_quiet_input(&orig_termios);
+		term_set = true;
+
+		memset(&sa, 0, sizeof(sa));
+		sa.sa_handler = debuginfod_signal_handler;
+		sigemptyset(&sa.sa_mask);
+		if (sigaction(SIGINT, &sa, &orig_sigint) == 0)
+			sigint_set = true;
+		if (sigaction(SIGTERM, &sa, &orig_sigterm) == 0)
+			sigterm_set = true;
+	}
+
+	fd = debuginfod_find_debuginfo(c, bid->data, bid->size, path);
+
+	if (term_set)
+		tcsetattr(STDIN_FILENO, TCSANOW, &orig_termios);
+	if (sigint_set)
+		sigaction(SIGINT, &orig_sigint, NULL);
+	if (sigterm_set)
+		sigaction(SIGTERM, &orig_sigterm, NULL);
+
+	debuginfod_end(c);
+	if (debuginfod_progress_started) {
+		fputc('\n', stderr);
+		debuginfod_progress_started = false;
+	}
+	if (fd < 0) {
+		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+		if (debuginfod_fetch_cancelled || debuginfod_signal) {
+			pr_debug("debuginfod search for build ID %s cancelled by the user\n",
+				 sbuild_id);
+			/*
+			 * The terminal is restored, die as the user asked;
+			 * the original dispositions are back in place.
+			 */
+			if (debuginfod_signal)
+				raise(debuginfod_signal);
+			return -1;
+		}
+		pr_debug("No debuginfo found for build ID %s in debuginfod\n",
+			 sbuild_id);
+		debuginfod__miss_add(bid);
+		return -1;
+	}
+
+	close(fd);
+	return 0;
+}
+
+struct debuginfo *debuginfo__new_build_id(const struct build_id *bid)
+{
+	char sbuild_id[SBUILD_ID_SIZE];
+	char *path = NULL;
+	struct debuginfo *dbg;
+
+	if (debuginfo__find_build_id(bid, &path))
+		return NULL;
+
+	dbg = __debuginfo__new(path);
+	if (dbg == NULL) {
+		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+		pr_debug("Failed to open DWARF in debuginfo fetched for build ID %s: %s\n",
+			 sbuild_id, path);
+	}
+	free(path);
+	return dbg;
+}
+#endif /* HAVE_DEBUGINFOD_SUPPORT */
+
 void debuginfo__delete(struct debuginfo *dbg)
 {
 	if (dbg) {
diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
index a52d69932815cd72..43b211a0dec174f5 100644
--- a/tools/perf/util/debuginfo.h
+++ b/tools/perf/util/debuginfo.h
@@ -5,6 +5,8 @@
 #include <errno.h>
 #include <linux/compiler.h>
 
+struct build_id;
+
 #ifdef HAVE_LIBDW_SUPPORT
 
 #include "dwarf-aux.h"
@@ -54,6 +56,28 @@ static inline int debuginfo__get_text_offset(struct debuginfo *dbg __maybe_unuse
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 int get_source_from_debuginfod(const char *raw_path, const char *sbuild_id,
 			       char **new_path);
+
+/*
+ * Finding a debuginfo file keyed by build ID uses the debuginfod client,
+ * but opening the DWARF in it needs libdw, i.e. these live in
+ * debuginfo.o, which is only built with CONFIG_LIBDW.
+ */
+#ifdef HAVE_LIBDW_SUPPORT
+int debuginfo__find_build_id(const struct build_id *bid, char **path);
+struct debuginfo *debuginfo__new_build_id(const struct build_id *bid);
+#else
+static inline int debuginfo__find_build_id(const struct build_id *bid __maybe_unused,
+					   char **path __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+static inline struct debuginfo *
+debuginfo__new_build_id(const struct build_id *bid __maybe_unused)
+{
+	return NULL;
+}
+#endif /* HAVE_LIBDW_SUPPORT */
 #else /* HAVE_DEBUGINFOD_SUPPORT */
 static inline int get_source_from_debuginfod(const char *raw_path __maybe_unused,
 					     const char *sbuild_id __maybe_unused,
@@ -61,6 +85,18 @@ static inline int get_source_from_debuginfod(const char *raw_path __maybe_unused
 {
 	return -ENOTSUP;
 }
+
+static inline int debuginfo__find_build_id(const struct build_id *bid __maybe_unused,
+					   char **path __maybe_unused)
+{
+	return -ENOTSUP;
+}
+
+static inline struct debuginfo *
+debuginfo__new_build_id(const struct build_id *bid __maybe_unused)
+{
+	return NULL;
+}
 #endif /* HAVE_DEBUGINFOD_SUPPORT */
 
 #endif /* _PERF_DEBUGINFO_H */
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 42bfe30a3b518e80..fe7c3b0265ba633a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -32,6 +32,7 @@
 #include "string2.h"
 #include "vdso.h"
 #include "annotate-data.h"
+#include "debuginfo.h"
 #include "libdw.h"
 
 static const char * const debuglink_paths[] = {
@@ -2073,5 +2074,23 @@ struct debuginfo *dso__debuginfo(struct dso *dso)
 
 	mutex_unlock(dso__lock(dso));
 	free(name);
+
+	/*
+	 * The debuginfo for a DSO in the profile may not be installed
+	 * locally, for instance the vmlinux for the kernel the profile was
+	 * recorded on when processing it on another machine, or after the
+	 * kernel and its debuginfo got upgraded in between.  Fall back to
+	 * fetching it keyed by the build ID recorded in the perf.data file,
+	 * using the debuginfod client, which checks its local cache first.
+	 *
+	 * Do it outside dso__lock, a fetch from a remote debuginfod server
+	 * can take a while and would otherwise block anything else using
+	 * this dso, and honour the opt-out, the user may have asked for
+	 * no debuginfod via --no-debuginfod, core.debuginfod=false or by
+	 * disabling the build-id cache.
+	 */
+	if (dinfo == NULL)
+		dinfo = debuginfo__new_build_id(dso__bid(dso));
+
 	return dinfo;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3587ad243159074f..b1a2684c813c5d8d 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -76,6 +76,8 @@ struct symbol_conf symbol_conf = {
 	.inline_name		= true,
 	.res_sample		= 0,
 	.addr2line_timeout_ms	= 5 * 1000,
+	/* Fetching debuginfo by build ID, off via --no-debuginfod, etc */
+	.debuginfod		= true,
 };
 
 struct map_list_node {
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 71f60081a85bb18d..a56b1d2d843b9ff1 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -45,6 +45,7 @@ struct symbol_conf {
 			force,
 			ignore_vmlinux,
 			ignore_vmlinux_buildid,
+			debuginfod,
 			show_kernel_path,
 			use_modules,
 			allow_aliases,
-- 
2.55.0

