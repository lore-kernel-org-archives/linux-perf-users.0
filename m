Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E484EBAE1;
	Wed, 16 Sep 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559294; cv=none; b=oeB4ojKeSu2ZmZcR7PuGFB4qGhryvZFYY7HxYoUswyyOm/70OD42310U2CI7/eZMzfemfWPzgKTwCDmN5rrcJtzxiPOAzL1WIt/LgP/yJ1N9pMe5mgChfycz3Nakv+dXkhy5pQwMtnNifqohzHPJRuhYxfpDKdNuWwNH5twyw60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559294; c=relaxed/simple;
	bh=4mCVrqhTzeqV1mrXWrij5er0D17TWr9vTZ266wvVWNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkBoUhoJQan3VJKMavts3iXP7VHM2bxXH0vtuKvLTKAGow5oJ1iearSAiph+kfLD81Wh6rvwcTdQT1jL4TRRhaoCN1OHxsD6S/YhGQKgW6sK7jikwOzv9pmntnjCA+NKvKIeENUdRQ0yjAVVQNZimSirvSCTh5cDfON3HgSgCQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpWwsNFS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpWwsNFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9D91F00898;
	Wed, 16 Sep 2026 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559279;
	bh=iG5u5rL9A4SNxjIUNRmCY+VBpFSiOJuuF+OnRTKljW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DpWwsNFSah9NqDSDyJzk86fw5Y4DOi6tp7GSo9NVxgryNLdXqTWysq0GzFrGP/gKu
	 i1QORgEp0kSkW8AugdM9D7VxxKAM+NdDKNlxsQhmxELMu0+/PCijeFViHV1mYj7UDK
	 L2Ufm4gODlt98LudcImHzp+DbfIWQ7FGfU9FkTyD8mFKK715OpruNCzLqp7BvaIJCn
	 owzOUDKNpqNdpM643lsgx78wkp75mXtMzNNDMHmRjLyNupBk1LzGPq4DALuqS6HjVd
	 TTF5OpQTNuMoGFCl5APjS4clCEjwDtm3o5PpnUMnHc/XBrAiDYdgBeXBLNABbIV4FU
	 msmfDAlyytm/g==
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
Subject: [PATCH 02/12] perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod
Date: Wed, 16 Sep 2026 08:47:29 -0300
Message-ID: <20260916114740.48230-3-acme@kernel.org>
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
set it from the .urls files in /etc/debuginfod when not set.  That has
to happen before any thread that can call getenv() is started, as
setenv() is not thread safe, and there are getenv()s outside the fetch
lock: libdebuginfod reads DEBUGINFOD_URLS in every debuginfod_begin(),
which perf also does in build-id.c, probe-event.c and probe-finder.c,
so do it from symbol__init(), on the single-threaded setup, and not
lazily from the fetch path.

Querying servers, possibly third party ones, sends off-box the build
IDs of the binaries being analysed and a fetch can take a while, so
this is opt-out: on by default, off with --no-debuginfod, with
core.debuginfod=false, per tool with report.debuginfod and
top.debuginfod, and, since users that set buildid.dir to /dev/null
(e.g. Linus) or otherwise turn the local build-id cache off clearly
don't want fetched files stored on the box, off too in that case.

The opt-outs also cover libdwfl's own debuginfod client, that reads
DEBUGINFOD_URLS in every query: when debuginfod is off, be it with
--no-debuginfod, core.debuginfod=false or by disabling the build-id
cache, the variable is set to the empty string, that the client treats
as an opt-out and fails the query without even looking at its cache,
instead of being exported from /etc/debuginfod.  Tools that manage
DEBUGINFOD_URLS themselves, such as 'perf record --debuginfod', keep
doing so.

The fetches are serialized, as the lookup state they use is process
global, so two concurrent fetches would race for it, and serializing
also means that a request for a build ID that is being fetched doesn't
start a second download of the same file: it waits for the fetch to
finish and is answered from the entry the fetch published, keyed by the
build ID, with the path of the file that came back, checked before
being handed out in case the debuginfod client cache is cleaned from
under us.

Make dso__debuginfo() use debuginfo__new_build_id() as a fallback,
keyed by the build ID recorded in the perf.data file, so that
consumers such as the data type profiler can resolve the types of
DSOs whose debuginfo can be fetched this way.  Do the fetch outside
dso__lock, a fetch from a remote debuginfod server can take a while
and would otherwise block anything else using this dso, and remember
the build IDs that were a miss, so that consumers revisiting a set of
DSOs repeatedly, such as the data type profiler on every hist entry
DSO switch, don't pay server round trips per attempt.

debuginfo__new_build_id() needs libdw to open the DWARF, so it lives
in debuginfo.o, built only with CONFIG_LIBDW, while the libdebuginfod
feature check is independent of NO_LIBDW; keep the new build ID
prototypes under HAVE_LIBDW_SUPPORT too, with stubs otherwise, so
that make NO_LIBDW=1 on a system that has the debuginfod client
keeps linking.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |   8 +
 tools/perf/Documentation/perf-config.txt   |  19 ++
 tools/perf/Documentation/perf-report.txt   |  12 +
 tools/perf/Documentation/perf-top.txt      |  11 +
 tools/perf/builtin-annotate.c              |   3 +
 tools/perf/builtin-report.c                |   7 +
 tools/perf/builtin-top.c                   |   7 +
 tools/perf/util/config.c                   |   3 +
 tools/perf/util/debuginfo.c                | 327 +++++++++++++++++++++
 tools/perf/util/debuginfo.h                |  36 +++
 tools/perf/util/dso.c                      |  19 ++
 tools/perf/util/symbol.c                   |  12 +
 tools/perf/util/symbol_conf.h              |   1 +
 tools/perf/util/util.c                     | 103 +++++++
 tools/perf/util/util.h                     |   8 +
 15 files changed, 576 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 1a90b09a12d5abb1..12edc3337b86f099 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -58,6 +58,14 @@ OPTIONS
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--debuginfod::
+--no-debuginfod::
+	Fetch debuginfo keyed by build ID from the debuginfod servers
+	configured in DEBUGINFOD_URLS, checking the local debuginfod
+	client cache first, when it is not available locally, on for
+	these commands by default.  See the --debuginfod option of
+	'perf report' for how to turn it off.
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
index 1a4706329c6cef1d..2e11c0a97a016853 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -366,6 +366,18 @@ OPTIONS
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
+	It is disabled as well when the local build-id cache is turned
+	off, e.g. "buildid.dir" set to /dev/null, as that asks for
+	fetched files not to be kept on the box.
+
 --kallsyms=<file>::
         kallsyms pathname
 
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 2da2a16bbf260685..345dd9ee9b6bab88 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -83,6 +83,17 @@ Default is to monitor all CPUS.
 --ignore-vmlinux::
 	Ignore vmlinux files.
 
+--debuginfod::
+--no-debuginfod::
+	Fetch debuginfo keyed by build ID from the debuginfod servers
+	configured in DEBUGINFOD_URLS, checking the local debuginfod
+	client cache first, when it is not available locally, on for
+	these commands by default.  Turn it off per invocation with
+	--no-debuginfod, with the "top.debuginfod" config option or
+	globally with "core.debuginfod" set to false.  Disabled as well
+	when the build-id cache is off, e.g. "buildid.dir" set to
+	/dev/null.
+
 --kallsyms=<file>::
 	kallsyms pathname
 
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 850fc72fa75fe7df..d6a201c1866d363f 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -733,6 +733,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
                     "don't load vmlinux even if found"),
+	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
+		    "fetch debuginfo keyed by build ID from the debuginfod "
+		    "servers, on by default, use --no-debuginfod to turn off"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 279e61c2366cb294..442c0822e614197f 100644
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
 
@@ -1346,6 +1350,9 @@ int cmd_report(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
                     "don't load vmlinux even if found"),
+	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
+		    "fetch debuginfo keyed by build ID from the debuginfod "
+		    "servers, on by default, use --no-debuginfod to turn off"),
 	OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
 		   "file", "kallsyms pathname"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c2562d49be46a9a1..2be6859fd4aee141 100644
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
@@ -1508,6 +1512,9 @@ int cmd_top(int argc, const char **argv)
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
 		    "don't load vmlinux even if found"),
+	OPT_BOOLEAN(0, "debuginfod", &symbol_conf.debuginfod,
+		    "fetch debuginfo keyed by build ID from the debuginfod "
+		    "servers, on by default, use --no-debuginfod to turn off"),
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
index 84a78b30ceac1066..be5882d9c2204797 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -7,16 +7,22 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
+#include <pthread.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
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
 
 #ifdef HAVE_DEBUGINFOD_SUPPORT
@@ -139,6 +145,327 @@ struct debuginfo *debuginfo__new(const char *path)
 	return __debuginfo__new(buf);
 }
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
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
+ * Build IDs that shouldn't be searched for again in this session: the
+ * ones already searched for on the debuginfod servers without success,
+ * so that callers that see the same DSO over and over, such as the data
+ * type profiler switching between DSOs on every hist entry, don't pay a
+ * server round trip again for each miss.  The cache of successes is the
+ * debuginfod client's own, in the local filesystem.
+ *
+ * Guarded by debuginfod__fetch_lock: it is only read by the lookups
+ * below, that run with that lock held, and written by fetches, that run
+ * with it held too.
+ */
+struct debuginfod_miss {
+	struct list_head	node;
+	struct build_id		bid;
+};
+
+static LIST_HEAD(debuginfod__misses);
+
+/*
+ * Was the search for this build ID already made and settled, i.e. the
+ * servers had nothing for it?
+ */
+static bool debuginfod__missed(const struct build_id *bid)
+{
+	struct debuginfod_miss *miss;
+
+	list_for_each_entry(miss, &debuginfod__misses, node) {
+		if (miss->bid.size == bid->size &&
+		    !memcmp(miss->bid.data, bid->data, bid->size))
+			return true;
+	}
+
+	return false;
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
+	list_add(&miss->node, &debuginfod__misses);
+}
+
+/*
+ * One fetch at a time.
+ *
+ * The lookup state below is process global, so two concurrent fetches,
+ * which dso__debuginfo() makes possible by taking the fetch out of
+ * dso__lock, would race for it: the second one could answer from a list
+ * the first one is concurrently updating, and put the same build ID on
+ * the misses list twice.
+ *
+ * Serializing also means a second request for a build ID that is being
+ * fetched waits here for the fetch to finish, instead of starting a second
+ * download of the same file, and is then answered from the entry the fetch
+ * published, or from the misses list, with no client at all.  Should the
+ * fetches ever run in parallel, that wait has to come back explicitly, with
+ * this lock split in two: one only for the lookup state, that the waiters
+ * sleep on, and one held around each fetch, with the thread that finds a
+ * fetch in progress waiting on the former for the entry to be published.
+ *
+ * What that costs is that a fetch for one build ID blocks a fetch for
+ * another one, and it is what parallel downloads would fix.  Worth doing
+ * only if the wait turns out to be long, because it mostly is not: the
+ * lookups below answer the second and later requests for a build ID from
+ * memory, so after the first pass over the build IDs of a workload, which
+ * is the only time anything is fetched at all, the serialization has
+ * nothing left to serialize.  Start there if a profile with many DSOs to
+ * fetch shows up in a profile of perf itself.
+ */
+static struct mutex debuginfod__fetch_lock;
+
+static void debuginfod__fetch_lock_setup(void)
+{
+	mutex_init(&debuginfod__fetch_lock);
+}
+
+static void debuginfod__fetch_lock_init(void)
+{
+	static pthread_once_t once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&once, debuginfod__fetch_lock_setup);
+}
+
+/*
+ * The build IDs already fetched in this session, and the path of the file
+ * that came back for each, so that the repeated requests for the same build
+ * ID, dso__debuginfo() is called per symbol annotated, are answered with a
+ * strdup() instead of another client: the file is in the debuginfod client
+ * cache already and its path checked before being handed out, in case that
+ * cache is cleaned from under us.
+ *
+ * Guarded by debuginfod__fetch_lock.  Only a fetch that brought a file back
+ * gets an entry: one that didn't is recorded in debuginfod__misses as a miss,
+ * and that is what keeps the rest of the session from asking for it again.
+ * Like debuginfod__misses this grows with the number of build IDs in the
+ * workload, one small entry each, and is not trimmed.
+ */
+struct debuginfo_lookup {
+	struct list_head	 node;
+	struct build_id		 bid;
+	char			*path;
+};
+
+static LIST_HEAD(debuginfo_lookups);
+
+static bool build_id__equal(const struct build_id *a, const struct build_id *b)
+{
+	return a->size == b->size && memcmp(a->data, b->data, a->size) == 0;
+}
+
+static struct debuginfo_lookup *debuginfo_lookup__find(const struct build_id *bid)
+{
+	struct debuginfo_lookup *lookup;
+
+	list_for_each_entry(lookup, &debuginfo_lookups, node) {
+		if (build_id__equal(&lookup->bid, bid))
+			return lookup;
+	}
+
+	return NULL;
+}
+
+static void debuginfo_lookup__delete(struct debuginfo_lookup *lookup)
+{
+	list_del(&lookup->node);
+	zfree(&lookup->path);
+	free(lookup);
+}
+
+/*
+ * Remember that this build ID was fetched, with the file at @path, so that
+ * the next request for it is answered from memory.  Called with
+ * debuginfod__fetch_lock held.  Out of memory just means not sharing this
+ * one, the file is fetched and the caller has its path.
+ */
+static void debuginfo_lookup__add(const struct build_id *bid, const char *path)
+{
+	struct debuginfo_lookup *lookup = zalloc(sizeof(*lookup));
+
+	if (lookup == NULL)
+		return;
+
+	lookup->bid = *bid;
+	lookup->path = strdup(path);
+	if (lookup->path == NULL) {
+		free(lookup);
+		return;
+	}
+
+	list_add(&lookup->node, &debuginfo_lookups);
+}
+
+/*
+ * The fetch itself.  Called with debuginfod__fetch_lock held for the
+ * whole of it, see the comment there.
+ */
+static int debuginfod__fetch(const struct build_id *bid, char **path)
+{
+	char sbuild_id[SBUILD_ID_SIZE];
+	debuginfod_client *c;
+	int fd;
+
+	c = debuginfod_begin();
+	if (c == NULL)
+		return -1;
+
+	fd = debuginfod_find_debuginfo(c, bid->data, bid->size, path);
+
+	debuginfod_end(c);
+
+	if (fd < 0) {
+		build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+		pr_debug("No debuginfo found for build ID %s in debuginfod\n",
+			 sbuild_id);
+		debuginfod__miss_add(bid);
+		return -1;
+	}
+
+	close(fd);
+
+	return 0;
+}
+
+/*
+ * Look the build ID up in the files already fetched in this session,
+ * fetching it if it isn't there yet.  Called, and left, with
+ * debuginfod__fetch_lock held, which also means that no fetch for this
+ * build ID can be running anywhere else: a second request for a build ID
+ * being fetched waits for the lock and is answered from the entry the fetch
+ * published, or from the misses list, with no client at all.
+ */
+static int debuginfo_lookup__find_build_id(const struct build_id *bid, char **path)
+{
+	struct debuginfo_lookup *lookup = debuginfo_lookup__find(bid);
+
+	if (lookup != NULL) {
+		/*
+		 * The file stays in the debuginfod client cache, but that
+		 * cache can be cleaned from under us, so check that it is
+		 * still there before handing its path out.  If it isn't,
+		 * forget the entry and look for the file again below,
+		 * remembering the new answer the same way the first fetch
+		 * does, so that the next lookup shares it instead of
+		 * fetching it a third time.
+		 */
+		if (access(lookup->path, R_OK) == 0) {
+			*path = strdup(lookup->path);
+			return *path != NULL ? 0 : -1;
+		}
+
+		debuginfo_lookup__delete(lookup);
+	}
+
+	if (debuginfod__fetch(bid, path) < 0)
+		return -1;
+
+	debuginfo_lookup__add(bid, *path);
+
+	return 0;
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
+ * core.debuginfod=false, with the per-tool
+ * report.debuginfod/top.debuginfod, and it is off too when the user
+ * disabled the local build-id/.debug cache, e.g. with
+ * buildid.dir = /dev/null, as is the case for users that don't want
+ * any of this stored locally.
+ *
+ * On success the path is stored in *@path and must be freed by the
+ * caller, the file remains available in the debuginfod client cache.
+ */
+int debuginfo__find_build_id(const struct build_id *bid, char **path)
+{
+	int err = -1;
+
+	*path = NULL;
+
+	if (!build_id__is_defined(bid))
+		return -1;
+
+	/*
+	 * The checks below have to be made with the lock held, as they look
+	 * at the state the fetch changes: a build ID the fetch in progress
+	 * just settled as a miss is settled for whoever is waiting for the
+	 * lock as well.  Deciding here and fetching there would repeat a
+	 * fetch that was already made, and put the same build ID on the
+	 * misses list twice.
+	 */
+	debuginfod__fetch_lock_init();
+	mutex_lock(&debuginfod__fetch_lock);
+
+	if (symbol_conf.debuginfod) {
+		if (debuginfod__cache_disabled()) {
+			pr_debug("Build-id cache disabled (buildid dir is '%s'), not using debuginfod\n",
+				 buildid_dir);
+		} else if (debuginfod__missed(bid)) {
+			char sbuild_id[SBUILD_ID_SIZE];
+
+			build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
+			pr_debug("Not searching build ID %s in debuginfod again, it was a miss earlier\n",
+				 sbuild_id);
+		} else {
+			err = debuginfo_lookup__find_build_id(bid, path);
+		}
+	}
+
+	mutex_unlock(&debuginfod__fetch_lock);
+
+	return err;
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
index 3587ad243159074f..1d70c43bb24ee279 100644
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
@@ -2534,6 +2536,16 @@ int symbol__init(struct perf_env *env)
 	if (symbol_conf.initialized)
 		return 0;
 
+	/*
+	 * Have DEBUGINFOD_URLS set before the threads that can take the
+	 * debuginfod fetch path, and that getenv() it, e.g. in the every
+	 * debuginfod_begin() of the other debuginfod client users, are
+	 * started: set it up here, from the .urls files in /etc/debuginfod
+	 * when it isn't set, instead of doing it lazily from the fetch
+	 * path itself, setenv() not being thread safe.
+	 */
+	debuginfod__setup_urls_env();
+
 	symbol_conf.priv_size = PERF_ALIGN(symbol_conf.priv_size, sizeof(u64));
 
 	symbol__elf_init();
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
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 8f7cd32f524dc10e..3195795e09b853ba 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -21,9 +21,11 @@
 #include <linux/time64.h>
 #include <linux/overflow.h>
 #include <unistd.h>
+#include "build-id.h"
 #include "cap.h"
 #include "strlist.h"
 #include "string2.h"
+#include "symbol_conf.h"
 
 /*
  * XXX We need to find a better place for these things...
@@ -431,6 +433,8 @@ char *perf_exe(char *buf, int len)
 	return strcpy(buf, "perf");
 }
 
+static bool debuginfod__urls_set_by_tool;
+
 void perf_debuginfod_setup(struct perf_debuginfod *di)
 {
 	/*
@@ -443,6 +447,7 @@ void perf_debuginfod_setup(struct perf_debuginfod *di)
 	else if (di->urls && strcmp(di->urls, "system"))
 		setenv("DEBUGINFOD_URLS", di->urls, 1);
 
+	debuginfod__urls_set_by_tool = true;
 	pr_debug("DEBUGINFOD_URLS=%s\n", getenv("DEBUGINFOD_URLS"));
 
 #ifndef HAVE_DEBUGINFOD_SUPPORT
@@ -451,6 +456,104 @@ void perf_debuginfod_setup(struct perf_debuginfod *di)
 #endif
 }
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
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
+ *
+ * setenv() is not thread safe: it can race with a getenv() in another
+ * thread on the environ array, and there are getenv()s that don't go
+ * through the fetch lock: libdebuginfod reads DEBUGINFOD_URLS in every
+ * debuginfod_begin(), and perf creates clients from other paths,
+ * build-id.c, probe-event.c and probe-finder.c, so this is called from
+ * symbol__init(), on the single-threaded setup, before the threads that
+ * can get here are started, and not from the fetch path.
+ *
+ * When debuginfod is turned off, with --no-debuginfod,
+ * core.debuginfod=false or by disabling the build-id cache, set it to
+ * that empty opt-out instead of exporting it: libdwfl's own debuginfod
+ * client reads DEBUGINFOD_URLS in every query, not only when perf's
+ * client is used, so it would otherwise fetch debuginfo and keep it in
+ * its own cache even though the user asked for no debuginfod.
+ *
+ * This lives here, not in debuginfo.o, as that object is only built
+ * with CONFIG_LIBDW and the debuginfod users above are not.
+ */
+void debuginfod__setup_urls_env(void)
+{
+	char *urls = NULL;
+	DIR *dir;
+	struct dirent *dent;
+
+	/*
+	 * Tools that set DEBUGINFOD_URLS themselves, e.g. 'perf record'
+	 * --debuginfod and 'perf buildid-cache', already made their
+	 * choice, leave it alone.
+	 */
+	if (debuginfod__urls_set_by_tool)
+		return;
+
+	if (!symbol_conf.debuginfod || !strcmp(buildid_dir, "/dev/null")) {
+		setenv("DEBUGINFOD_URLS", "", 1);
+		pr_debug("DEBUGINFOD_URLS cleared, debuginfod is disabled\n");
+		return;
+	}
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
+#endif /* HAVE_DEBUGINFOD_SUPPORT */
+
 /*
  * Return a new filename prepended with task's root directory if it's in
  * a chroot.  Callers should free the returned string.
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index f8f1ff603c728086..1f763f9960bd0756 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -82,6 +82,14 @@ struct perf_debuginfod {
 };
 void perf_debuginfod_setup(struct perf_debuginfod *di);
 
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+void debuginfod__setup_urls_env(void);
+#else
+static inline void debuginfod__setup_urls_env(void)
+{
+}
+#endif
+
 const char *perf_basename(const char *path);
 
 char *filename_with_chroot(int pid, const char *filename);
-- 
2.55.0

