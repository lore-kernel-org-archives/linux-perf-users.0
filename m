Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2EC49EA6
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB0661C21
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Jun 2021 13:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhF0NUk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 09:20:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:60751 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhF0NUi (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 09:20:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195137053"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="195137053"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 06:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="640589036"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga006.fm.intel.com with ESMTP; 27 Jun 2021 06:18:11 -0700
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
Subject: [PATCH V2 04/10] perf script: Add option to pass arguments to dlfilters
Date:   Sun, 27 Jun 2021 16:18:12 +0300
Message-Id: <20210627131818.810-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210627131818.810-1-adrian.hunter@intel.com>
References: <20210627131818.810-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add option --dlarg to pass arguments to dlfilters. The --dlarg option can
be repeated to pass more than 1 argument.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt | 10 +++--
 tools/perf/Documentation/perf-script.txt   |  4 ++
 tools/perf/builtin-script.c                | 35 ++++++++++++++++-
 tools/perf/util/dlfilter.c                 | 45 ++++++++++++++++++----
 tools/perf/util/dlfilter.h                 |  6 ++-
 tools/perf/util/perf_dlfilter.h            |  4 +-
 6 files changed, 91 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index 8bc219f3eb83..5795ab3ca23b 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -9,13 +9,14 @@ object file
 SYNOPSIS
 --------
 [verse]
-'perf script' [--dlfilter file.so ]
+'perf script' [--dlfilter file.so ] [ --dlarg arg ]...
 
 DESCRIPTION
 -----------
 
 This option is used to process data through a custom filter provided by a
-dynamically loaded shared object file.
+dynamically loaded shared object file. Arguments can be passed using --dlarg
+and retrieved using perf_dlfilter_fns.args().
 
 If 'file.so' does not contain "/", then it will be found either in the current
 directory, or perf tools exec path which is ~/libexec/perf-core/dlfilters for
@@ -121,7 +122,8 @@ file is loaded. The functions can be called by 'filter_event' or
 struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
-	void *(*reserved[126])(void *);
+	char **(*args)(void *ctx, int *dlargc);
+	void *(*reserved[125])(void *);
 };
 ----
 
@@ -129,6 +131,8 @@ struct perf_dlfilter_fns {
 
 'resolve_addr' returns information about addr (if addr_correlates_sym).
 
+'args' returns arguments from --dlarg options.
+
 The perf_dlfilter_al structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index d2705d6b9874..aa3a0b2c29a2 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -102,6 +102,10 @@ OPTIONS
 	Filter sample events using the given shared object file.
 	Refer linkperf:perf-dlfilter[1]
 
+--dlarg=<arg>::
+	Pass 'arg' as an argument to the dlfilter. --dlarg may be repeated
+	to add more arguments.
+
 --list-dlfilters=::
         Display a list of available dlfilters. Use with option -v (must come
         before option --list-dlfilters) to show long descriptions.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4ffba1dbc55d..2030936cc891 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -81,6 +81,8 @@ static struct perf_stat_config	stat_config;
 static int			max_blocks;
 static bool			native_arch;
 static struct dlfilter		*dlfilter;
+static int			dlargc;
+static char			**dlargv;
 
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
@@ -3175,6 +3177,34 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 	exit(0);
 }
 
+static int add_dlarg(const struct option *opt __maybe_unused,
+		     const char *s, int unset __maybe_unused)
+{
+	char *arg = strdup(s);
+	void *a;
+
+	if (!arg)
+		return -1;
+
+	a = realloc(dlargv, sizeof(dlargv[0]) * (dlargc + 1));
+	if (!a) {
+		free(arg);
+		return -1;
+	}
+
+	dlargv = a;
+	dlargv[dlargc++] = arg;
+
+	return 0;
+}
+
+static void free_dlarg(void)
+{
+	while (dlargc--)
+		free(dlargv[dlargc]);
+	free(dlargv);
+}
+
 /*
  * Some scripts specify the required events in their "xxx-record" file,
  * this function will check if the events in perf.data match those
@@ -3639,6 +3669,8 @@ int cmd_script(int argc, const char **argv)
 	OPT_STRING('g', "gen-script", &generate_script_lang, "lang",
 		   "generate perf-script.xx script in specified language"),
 	OPT_STRING(0, "dlfilter", &dlfilter_file, "file", "filter .so file name"),
+	OPT_CALLBACK(0, "dlarg", NULL, "argument", "filter argument",
+		     add_dlarg),
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
 	OPT_BOOLEAN('d', "debug-mode", &debug_mode,
 		   "do various checks like samples ordering and lost events"),
@@ -3958,7 +3990,7 @@ int cmd_script(int argc, const char **argv)
 	}
 
 	if (dlfilter_file) {
-		dlfilter = dlfilter__new(dlfilter_file);
+		dlfilter = dlfilter__new(dlfilter_file, dlargc, dlargv);
 		if (!dlfilter)
 			return -1;
 	}
@@ -4116,6 +4148,7 @@ int cmd_script(int argc, const char **argv)
 	if (script_started)
 		cleanup_scripting();
 	dlfilter__cleanup(dlfilter);
+	free_dlarg();
 out:
 	return err;
 }
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 288a2b57378c..eaa3cea49178 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -133,9 +133,26 @@ static const struct perf_dlfilter_al *dlfilter__resolve_addr(void *ctx)
 	return d_addr_al;
 }
 
+static char **dlfilter__args(void *ctx, int *dlargc)
+{
+	struct dlfilter *d = (struct dlfilter *)ctx;
+
+	if (dlargc)
+		*dlargc = 0;
+	else
+		return NULL;
+
+	if (!d->ctx_valid && !d->in_start && !d->in_stop)
+		return NULL;
+
+	*dlargc = d->dlargc;
+	return d->dlargv;
+}
+
 static const struct perf_dlfilter_fns perf_dlfilter_fns = {
 	.resolve_ip      = dlfilter__resolve_ip,
 	.resolve_addr    = dlfilter__resolve_addr,
+	.args            = dlfilter__args,
 };
 
 static char *find_dlfilter(const char *file)
@@ -169,7 +186,7 @@ static char *find_dlfilter(const char *file)
 
 #define CHECK_FLAG(x) BUILD_BUG_ON((u64)PERF_DLFILTER_FLAG_ ## x != (u64)PERF_IP_FLAG_ ## x)
 
-static int dlfilter__init(struct dlfilter *d, const char *file)
+static int dlfilter__init(struct dlfilter *d, const char *file, int dlargc, char **dlargv)
 {
 	CHECK_FLAG(BRANCH);
 	CHECK_FLAG(CALL);
@@ -189,6 +206,8 @@ static int dlfilter__init(struct dlfilter *d, const char *file)
 	d->file = find_dlfilter(file);
 	if (!d->file)
 		return -1;
+	d->dlargc = dlargc;
+	d->dlargv = dlargv;
 	return 0;
 }
 
@@ -219,14 +238,14 @@ static int dlfilter__close(struct dlfilter *d)
 	return dlclose(d->handle);
 }
 
-struct dlfilter *dlfilter__new(const char *file)
+struct dlfilter *dlfilter__new(const char *file, int dlargc, char **dlargv)
 {
 	struct dlfilter *d = malloc(sizeof(*d));
 
 	if (!d)
 		return NULL;
 
-	if (dlfilter__init(d, file))
+	if (dlfilter__init(d, file, dlargc, dlargv))
 		goto err_free;
 
 	if (dlfilter__open(d))
@@ -253,16 +272,28 @@ int dlfilter__start(struct dlfilter *d, struct perf_session *session)
 {
 	if (d) {
 		d->session = session;
-		if (d->start)
-			return d->start(&d->data, d);
+		if (d->start) {
+			int ret;
+
+			d->in_start = true;
+			ret = d->start(&d->data, d);
+			d->in_start = false;
+			return ret;
+		}
 	}
 	return 0;
 }
 
 static int dlfilter__stop(struct dlfilter *d)
 {
-	if (d && d->stop)
-		return d->stop(d->data, d);
+	if (d && d->stop) {
+		int ret;
+
+		d->in_stop = true;
+		ret = d->stop(d->data, d);
+		d->in_stop = false;
+		return ret;
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/dlfilter.h b/tools/perf/util/dlfilter.h
index a1ed38da3ce6..505980442360 100644
--- a/tools/perf/util/dlfilter.h
+++ b/tools/perf/util/dlfilter.h
@@ -23,6 +23,10 @@ struct dlfilter {
 	void				*data;
 	struct perf_session		*session;
 	bool				ctx_valid;
+	bool				in_start;
+	bool				in_stop;
+	int				dlargc;
+	char				**dlargv;
 
 	union perf_event		*event;
 	struct perf_sample		*sample;
@@ -47,7 +51,7 @@ struct dlfilter {
 	struct perf_dlfilter_fns *fns;
 };
 
-struct dlfilter *dlfilter__new(const char *file);
+struct dlfilter *dlfilter__new(const char *file, int dlargc, char **dlargv);
 
 int dlfilter__start(struct dlfilter *d, struct perf_session *session);
 
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/util/perf_dlfilter.h
index 31ad4c100181..35e03aa41a7f 100644
--- a/tools/perf/util/perf_dlfilter.h
+++ b/tools/perf/util/perf_dlfilter.h
@@ -90,8 +90,10 @@ struct perf_dlfilter_fns {
 	const struct perf_dlfilter_al *(*resolve_ip)(void *ctx);
 	/* Return information about addr (if addr_correlates_sym) */
 	const struct perf_dlfilter_al *(*resolve_addr)(void *ctx);
+	/* Return arguments from --dlarg option */
+	char **(*args)(void *ctx, int *dlargc);
 	/* Reserved */
-	void *(*reserved[126])(void *);
+	void *(*reserved[125])(void *);
 };
 
 /*
-- 
2.17.1

