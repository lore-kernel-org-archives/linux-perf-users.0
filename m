Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC44DDB53;
	Thu, 17 Sep 2026 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660544; cv=none; b=STEYzUHx8qoQW3ncJm9nkRclEVo8l7EJ8e4dd5fbzmS3yR7+Rf25Amn2TKbEYaF3JK8Jp8N3TIW3onYnCaO6awwuP52HDd6/3v20c8wqVWa85weg9izCljBsX479BI6QuTGjdyXGY/BpB+3ldRX3pJmEAVeql/P/A1qHC9yPsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660544; c=relaxed/simple;
	bh=LcaxSLwQW+MnUlLGg9DL0JduOXTswwEvhzP6ZF4ikEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwQvCOu8x23W8/lzLCoRX5ghIMFYgQqH8ps0gLsP/hJjagbfwGPsCj6r53BmCcx/JOqPMw9La1uieoVXTJwIx62pEhCaQ7mPZpWS0eWQ0As7QKayfQ4EuK7sZGEc/6flUuEA4cntNwbHmbIzdoZ6uyRH1KC+1QQsStuaTICely0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWX6POYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWX6POYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181721F000FF;
	Thu, 17 Sep 2026 15:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660542;
	bh=Mhq6KSeI3LcSTb54cw0+mjWtq32mDhF8Ko8lwr5Y3dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWX6POYRQQOjr90vH6iMlMFDlxveT8zKF8A2/EzRFcLqL0g8l2/SyZyE7CnMpjnDw
	 w8Jf+U0tWypFTB4gHIaKSPnaHnIT4vVuE2Au3rOowQA4hUb02+8CRtpEuI2nNYQ700
	 MNFqCEzXyfO3GlxLmZ/pRZA2ABIxQKMPskeyXdnx+9lZf/yTIh6Cezy2HtLMevRqqm
	 ph7VJ7/L8TJ/k9VUVGYfPJQdqQDArXSt9A/G7P4b/qzQS8AqnZnfUekh0lhg2pX05t
	 SwRkvEPUo1d1KL8MM7W1ZSYFhFl7A1Y4y6gYx+IEqIp549+iidFT5oSrZTRH1XNa5r
	 eoRdUVwh/q6Bg==
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
Subject: [PATCH 01/15] perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod
Date: Thu, 17 Sep 2026 12:55:12 -0300
Message-ID: <20260917155528.62607-2-acme@kernel.org>
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

Add debuginfo__find_build_id(), which uses the debuginfod client to
locate a debuginfo file keyed by the build ID - checking its local cache
first and then the servers in DEBUGINFOD_URLS - and
debuginfo__new_build_id(), which opens the DWARF in the file it finds.
dso__debuginfo() falls back to it for DSOs whose debuginfo is not
installed locally, e.g. the vmlinux of a kernel profiled on another
machine or upgraded since, doing the fetch outside dso__lock.

Querying servers, possibly third party ones, sends the build IDs of the
binaries being analysed off-box, and a fetch can take a while, so this
is opt-out: --no-debuginfod, core.debuginfod=false,
report.debuginfod/top.debuginfod, and off also when the build-id cache
is disabled.  Fetches are serialized and misses are remembered, as both
the lookup state and the fetch interaction are process global.

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
 tools/perf/util/debuginfo.h                |  35 +++
 tools/perf/util/dso.c                      |  10 +
 tools/perf/util/symbol.c                   |   2 +
 tools/perf/util/symbol_conf.h              |   1 +
 13 files changed, 445 insertions(+)

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
index a52d69932815cd72..ef44a7557a9d6192 100644
--- a/tools/perf/util/debuginfo.h
+++ b/tools/perf/util/debuginfo.h
@@ -5,6 +5,8 @@
 #include <errno.h>
 #include <linux/compiler.h>
 
+struct build_id;
+
 #ifdef HAVE_LIBDW_SUPPORT
 
 #include "dwarf-aux.h"
@@ -54,6 +56,27 @@ static inline int debuginfo__get_text_offset(struct debuginfo *dbg __maybe_unuse
 #ifdef HAVE_DEBUGINFOD_SUPPORT
 int get_source_from_debuginfod(const char *raw_path, const char *sbuild_id,
 			       char **new_path);
+
+/*
+ * These need libdw to open the DWARF, so they live in debuginfo.o,
+ * built only with CONFIG_LIBDW.
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
@@ -61,6 +84,18 @@ static inline int get_source_from_debuginfod(const char *raw_path __maybe_unused
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
index 42bfe30a3b518e80..b0079ef17c597011 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -32,6 +32,7 @@
 #include "string2.h"
 #include "vdso.h"
 #include "annotate-data.h"
+#include "debuginfo.h"
 #include "libdw.h"
 
 static const char * const debuglink_paths[] = {
@@ -2073,5 +2074,14 @@ struct debuginfo *dso__debuginfo(struct dso *dso)
 
 	mutex_unlock(dso__lock(dso));
 	free(name);
+
+	/*
+	 * The debuginfo for a DSO in the profile may not be installed locally,
+	 * fall back to fetching it keyed by the build ID recorded in perf.data.
+	 * Do it outside dso__lock, a fetch can take a while.
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

