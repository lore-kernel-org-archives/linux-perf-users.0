Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D3C48BC2
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCCB61C23
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhF0NUh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:60751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhF0NUf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137047"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137047"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589025"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:08 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/10] perf script: Add option to list dlfilters
Date:   Sun, 27 Jun 2021 16:18:11 +0300
Message-Id: <20210627131818.810-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add option --list-dlfilters to list dlfilters in the current directory or
the exec-path e.g. ~/libexec/perf-core/dlfilters. Use with option -v (must
come before option --list-dlfilters) to show long descriptions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt |   4 +
 tools/perf/Documentation/perf-script.txt   |   4 +
 tools/perf/builtin-script.c                |   2 +
 tools/perf/util/dlfilter.c                 | 117 ++++++++++++++++++++-
 tools/perf/util/dlfilter.h                 |   2 +
 tools/perf/util/perf_dlfilter.h            |   6 ++
 6 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index aef1c32babd1..8bc219f3eb83 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -37,6 +37,7 @@ int start(void **data, void *ctx);
 int stop(void *data, void *ctx);
 int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
 int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
+const char *filter_description(const char **long_description);
 ----
 
 If implemented, 'start' will be called at the beginning, before any
@@ -59,6 +60,9 @@ error code. 'data' is set by 'start'. 'ctx' is needed for calls to
 'filter_event_early' is the same as 'filter_event' except it is called before
 internal filtering.
 
+If implemented, 'filter_description' should return a one-line description
+of the filter, and optionally a longer description.
+
 The perf_dlfilter_sample structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2306c81b606b..d2705d6b9874 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -102,6 +102,10 @@ OPTIONS
 	Filter sample events using the given shared object file.
 	Refer linkperf:perf-dlfilter[1]
 
+--list-dlfilters=::
+        Display a list of available dlfilters. Use with option -v (must come
+        before option --list-dlfilters) to show long descriptions.
+
 -a::
         Force system-wide collection.  Scripts run without a <command>
         normally use -a by default, while scripts run with a <command>
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e47affe674a5..4ffba1dbc55d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3631,6 +3631,8 @@ int cmd_script(int argc, const char **argv)
 		    "show latency attributes (irqs/preemption disabled, etc)"),
 	OPT_CALLBACK_NOOPT('l', "list", NULL, NULL, "list available scripts",
 			   list_available_scripts),
+	OPT_CALLBACK_NOOPT(0, "list-dlfilters", NULL, NULL, "list available dlfilters",
+			   list_available_dlfilters),
 	OPT_CALLBACK('s', "script", NULL, "name",
 		     "script file name (lang:script name, script name, or *)",
 		     parse_scriptname),
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index e93c49c07999..288a2b57378c 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -6,6 +6,8 @@
 #include <dlfcn.h>
 #include <stdlib.h>
 #include <string.h>
+#include <dirent.h>
+#include <subcmd/exec-cmd.h>
 #include <linux/zalloc.h>
 #include <linux/build_bug.h>
 
@@ -136,6 +138,35 @@ static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_addr    = dlfilter__resolve_addr,
 };
 
+static char *find_dlfilter(const char *file)
+{
+	char path[PATH_MAX];
+	char *exec_path;
+
+	if (strchr(file, '/'))
+		goto out;
+
+	if (!access(file, R_OK)) {
+		/*
+		 * Prepend "./" so that dlopen will find the file in the
+		 * current directory.
+		 */
+		snprintf(path, sizeof(path), "./%s", file);
+		file = path;
+		goto out;
+	}
+
+	exec_path = get_argv_exec_path();
+	if (!exec_path)
+		goto out;
+	snprintf(path, sizeof(path), "%s/dlfilters/%s", exec_path, file);
+	free(exec_path);
+	if (!access(path, R_OK))
+		file = path;
+out:
+	return strdup(file);
+}
+
 #define CHECK_FLAG(x) BUILD_BUG_ON((u64)PERF_DLFILTER_FLAG_ ## x != (u64)PERF_IP_FLAG_ ## x)
 
 static int dlfilter__init(struct dlfilter *d, const char *file)
@@ -155,7 +186,7 @@ static int dlfilter__init(struct dlfilter *d, const char *file)
 	CHECK_FLAG(VMEXIT);
 
 	memset(d, 0, sizeof(*d));
-	d->file = strdup(file);
+	d->file = find_dlfilter(file);
 	if (!d->file)
 		return -1;
 	return 0;
@@ -333,3 +364,87 @@ int dlfilter__do_filter_event(struct dlfilter *d,
 
 	return ret;
 }
+
+static bool get_filter_desc(const char *dirname, const char *name,
+			    char **desc, char **long_desc)
+{
+	char path[PATH_MAX];
+	void *handle;
+	const char *(*desc_fn)(const char **long_description);
+
+	snprintf(path, sizeof(path), "%s/%s", dirname, name);
+	handle = dlopen(path, RTLD_NOW);
+	if (!handle || !(dlsym(handle, "filter_event") || dlsym(handle, "filter_event_early")))
+		return false;
+	desc_fn = dlsym(handle, "filter_description");
+	if (desc_fn) {
+		const char *dsc;
+		const char *long_dsc;
+
+		dsc = desc_fn(&long_dsc);
+		if (dsc)
+			*desc = strdup(dsc);
+		if (long_dsc)
+			*long_desc = strdup(long_dsc);
+	}
+	dlclose(handle);
+	return true;
+}
+
+static void list_filters(const char *dirname)
+{
+	struct dirent *entry;
+	DIR *dir;
+
+	dir = opendir(dirname);
+	if (!dir)
+		return;
+
+	while ((entry = readdir(dir)) != NULL)
+	{
+		size_t n = strlen(entry->d_name);
+		char *long_desc = NULL;
+		char *desc = NULL;
+
+		if (entry->d_type == DT_DIR || n < 4 ||
+		    strcmp(".so", entry->d_name + n - 3))
+			continue;
+		if (!get_filter_desc(dirname, entry->d_name, &desc, &long_desc))
+			continue;
+		printf("  %-36s %s\n", entry->d_name, desc ? desc : "");
+		if (verbose) {
+			char *p = long_desc;
+			char *line;
+
+			while ((line = strsep(&p, "\n")) != NULL)
+				printf("%39s%s\n", "", line);
+		}
+		free(long_desc);
+		free(desc);
+	}
+
+	closedir(dir);
+}
+
+int list_available_dlfilters(const struct option *opt __maybe_unused,
+			     const char *s __maybe_unused,
+			     int unset __maybe_unused)
+{
+	char path[PATH_MAX];
+	char *exec_path;
+
+	printf("List of available dlfilters:\n");
+
+	list_filters(".");
+
+	exec_path = get_argv_exec_path();
+	if (!exec_path)
+		goto out;
+	snprintf(path, sizeof(path), "%s/dlfilters", exec_path);
+
+	list_filters(path);
+
+	free(exec_path);
+out:
+	exit(0);
+}
diff --git a/tools/perf/util/dlfilter.h b/tools/perf/util/dlfilter.h
index a994560e563d..a1ed38da3ce6 100644
--- a/tools/perf/util/dlfilter.h
+++ b/tools/perf/util/dlfilter.h
@@ -88,4 +88,6 @@ static inline int dlfilter__filter_event_early(struct dlfilter *d,
 	return dlfilter__do_filter_event(d, event, sample, evsel, machine, al, addr_al, true);
 }
 
+int list_available_dlfilters(const struct option *opt, const char *s, int unset);
+
 #endif
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index f7a847fdee59..31ad4c100181 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -126,4 +126,10 @@ int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ct
  */
 int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, void *ctx);
 
+/*
+ * If implemented, return a one-line description of the filter, and optionally
+ * a longer description.
+ */
+const char *filter_description(const char **long_description);
+
 #endif
-- 
2.17.1

