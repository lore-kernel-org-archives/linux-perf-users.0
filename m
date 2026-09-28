Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD64ED1BE;
	Mon, 28 Sep 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612583; cv=none; b=RcGj5Gu3gzv/FLWec1/DLqsalg47oP37qb6GzeJtB0SbX9selP0mpX0jODsi9P6AgJ3NCg0+/ohr8OD7bAwhbJ4bZWawudUsmYjqQfn7ufFzBsRENQ+JT3YHjp0XLJXHVVYficjGHM/xJVItEW/EPV9zf+aITbr+PmFbOB06C58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612583; c=relaxed/simple;
	bh=8FNtjuQHphfzOWCgkuC3X1TF/pA6igC+rhi7kDPO/us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofJnRZJ0sSRMW8rIo7Nej+ssbMmsFsUL4bB+1MnZkDE2xv9TNXSJFPsCJ2YUeTTdBoCF4GdX3AqBaqt+yNS0/mlxtshQHUAe6JB0YW0+0BW4Op+DyVeJv96nesD1Zexg3CI/icSXaxxVxOQSX8feHcC8QU1LwZ2wCkxYMs3jV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXBaBwFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXBaBwFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628731F000FF;
	Mon, 28 Sep 2026 16:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612581;
	bh=JSUj6YOkZH+PZMnV84chciziXjZGU/7GA4KwRh6XTro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bXBaBwFEqt39TMLqIwjo1tI4Lx8KXv5wBDxBcnLe+9wTM45EZbvWWJk6q7N7ObQ24
	 /UX+Ea6WjpvWIe48/ikkUsXv084Ue/m9beSWIkOK2U2dVGtbMDP++Mw+pF9eOV1VsU
	 mFdROWAZ0F3qaQ3G+Aov8Gog3lfjyhM8msxU1RaqUbEf+3VvMwj0AU+JoBb8GN9T+U
	 yw9p4FLM/+AJpLX0AixHbwDyWXIKvZwPDjBuzxmtA/Fnbda/Ket6fA+L3coXiwzGEU
	 B8H9gMzr+DaSqSsTRJqjDgWIB1mB3Lzug9gP77OH4A8FqBPXyX2PLqavpo3i3xWi4z
	 IBstSLgxf+b5g==
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
Subject: [PATCH 1/4] perf config: Move perf_config__set_variable() to util/config.c
Date: Mon, 28 Sep 2026 18:22:47 +0200
Message-ID: <20260928162250.2413383-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928162250.2413383-1-acme@kernel.org>
References: <20260928162250.2413383-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Move perf_config__set_variable() out of the 'perf config' builtin so
that opt-in features can persist their choice from outside it, e.g.
util/debuginfo.c writing core.debuginfod=false when the user disables
debuginfod for the rest of the session.  The
set_config() body becomes perf_config_set__write(), with the
system_config choice as an argument, as the builtin's
use_system_config/use_user_config statics are not available outside it.

All config file access shares the static parser state and can now run
on more than one thread, with a feature writing the config while perf
top's display thread reads it, so serialize parsing and
rewriting with a mutex, and the whole read-modify-write of
perf_config__set_variable() against itself.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c |  70 +-------------------
 tools/perf/util/config.c    | 124 ++++++++++++++++++++++++++++++++++--
 tools/perf/util/config.h    |   2 +
 3 files changed, 122 insertions(+), 74 deletions(-)

diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index cefd042e4f853466..3b074aca8d344539 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -41,37 +41,7 @@ static struct option config_options[] = {
 
 static int set_config(struct perf_config_set *set, const char *file_name)
 {
-	struct perf_config_section *section = NULL;
-	struct perf_config_item *item = NULL;
-	const char *first_line = "# this file is auto-generated.";
-	FILE *fp;
-
-	if (set == NULL)
-		return -1;
-
-	fp = fopen(file_name, "w");
-	if (!fp)
-		return -1;
-
-	fprintf(fp, "%s\n", first_line);
-
-	/* overwrite configvariables */
-	perf_config_items__for_each_entry(&set->sections, section) {
-		if (!use_system_config && section->from_system_config)
-			continue;
-		fprintf(fp, "[%s]\n", section->name);
-
-		perf_config_items__for_each_entry(&section->items, item) {
-			if (!use_system_config && item->from_system_config)
-				continue;
-			if (item->value)
-				fprintf(fp, "\t%s = %s\n",
-					item->name, item->value);
-		}
-	}
-	fclose(fp);
-
-	return 0;
+	return perf_config_set__write(set, file_name, use_system_config);
 }
 
 static int show_spec_config(struct perf_config_set *set, const char *var)
@@ -158,44 +128,6 @@ static int parse_config_arg(char *arg, char **var, char **value)
 	return 0;
 }
 
-int perf_config__set_variable(const char *var, const char *value)
-{
-	char path[PATH_MAX];
-	char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
-	const char *config_filename;
-	struct perf_config_set *set;
-	int ret = -1;
-
-	if (use_system_config)
-		config_exclusive_filename = perf_etc_perfconfig();
-	else if (use_user_config)
-		config_exclusive_filename = user_config;
-
-	if (!config_exclusive_filename)
-		config_filename = user_config;
-	else
-		config_filename = config_exclusive_filename;
-
-	set = perf_config_set__new();
-	if (!set)
-		goto out_err;
-
-	if (perf_config_set__collect(set, config_filename, var, value) < 0) {
-		pr_err("Failed to add '%s=%s'\n", var, value);
-		goto out_err;
-	}
-
-	if (set_config(set, config_filename) < 0) {
-		pr_err("Failed to set the configs on %s\n", config_filename);
-		goto out_err;
-	}
-
-	ret = 0;
-out_err:
-	perf_config_set__delete(set);
-	return ret;
-}
-
 int cmd_config(int argc, const char **argv)
 {
 	int i, ret = -1;
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 8fe43b032e9af88a..43994786eb964413 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -12,6 +12,8 @@
 #include "config.h"
 
 #include <errno.h>
+#include <limits.h>
+#include <pthread.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -549,11 +551,26 @@ int perf_default_config(const char *var, const char *value,
 	return 0;
 }
 
+/*
+ * Serialize config file access: parsing and rewriting share the static
+ * parser state and can run on more than one thread, the debuginfod
+ * fetch writing core.debuginfod=false while perf top reads it.
+ */
+static pthread_mutex_t config_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+/*
+ * perf_config__set_variable() is a read-modify-write of a config file,
+ * and config_mutex serializes just each of its steps: take it for the
+ * whole update so callers can't write over each other's changes.
+ */
+static pthread_mutex_t config_update_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 static int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
 	FILE *f = fopen(filename, "r");
 
+	pthread_mutex_lock(&config_mutex);
 	ret = -1;
 	if (f) {
 		config_file = f;
@@ -564,15 +581,27 @@ static int perf_config_from_file(config_fn_t fn, const char *filename, void *dat
 		fclose(f);
 		config_file_name = NULL;
 	}
+	pthread_mutex_unlock(&config_mutex);
 	return ret;
 }
 
+/*
+ * Computed once: system_path() allocates, a lazy init racing on two
+ * threads would leak all but one of the strings.
+ */
+static const char *etc_perfconfig;
+
+static void perf_etc_perfconfig__init(void)
+{
+	etc_perfconfig = system_path(ETC_PERFCONFIG);
+}
+
 const char *perf_etc_perfconfig(void)
 {
-	static const char *system_wide;
-	if (!system_wide)
-		system_wide = system_path(ETC_PERFCONFIG);
-	return system_wide;
+	static pthread_once_t once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&once, perf_etc_perfconfig__init);
+	return etc_perfconfig;
 }
 
 static int perf_env_bool(const char *k, int def)
@@ -783,8 +812,15 @@ static int collect_config(const char *var, const char *value,
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 			     const char *var, const char *value)
 {
+	int ret;
+
+	pthread_mutex_lock(&config_mutex);
 	config_file_name = file_name;
-	return collect_config(var, value, set);
+	ret = collect_config(var, value, set);
+		/* Don't leave the static parser state pointing at the caller's buffer. */
+	config_file_name = NULL;
+	pthread_mutex_unlock(&config_mutex);
+	return ret;
 }
 
 static int perf_config_set__init(struct perf_config_set *set)
@@ -883,6 +919,84 @@ void perf_config__exit(void)
 	config_set = NULL;
 }
 
+int perf_config_set__write(struct perf_config_set *set,
+			   const char *file_name, bool system_config)
+{
+	struct perf_config_section *section = NULL;
+	struct perf_config_item *item = NULL;
+	FILE *fp;
+
+	pthread_mutex_lock(&config_mutex);
+	fp = fopen(file_name, "w");
+	if (!fp) {
+		pthread_mutex_unlock(&config_mutex);
+		return -1;
+	}
+
+	fprintf(fp, "# this file is auto-generated.\n");
+
+	/* overwrite configvariables */
+	perf_config_sections__for_each_entry(&set->sections, section) {
+		if (!system_config && section->from_system_config)
+			continue;
+		fprintf(fp, "[%s]\n", section->name);
+
+		perf_config_items__for_each_entry(&section->items, item) {
+			if (!system_config && item->from_system_config)
+				continue;
+			if (item->value)
+				fprintf(fp, "\t%s = %s\n",
+					item->name, item->value);
+		}
+	}
+	fclose(fp);
+	pthread_mutex_unlock(&config_mutex);
+
+	return 0;
+}
+
+/*
+ * Set @var=@value in the configuration file perf is using: ~/.perfconfig
+ * or the file named by PERF_CONFIG, which makes perf read only that
+ * file.  The rewrite is the same 'perf config' does, comments are not
+ * preserved.
+ */
+int perf_config__set_variable(const char *var, const char *value)
+{
+	char path[PATH_MAX];
+	char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
+	const char *config_filename = config_exclusive_filename ?: user_config;
+		/*
+	 * When rewriting the system wide file all entries are marked as coming
+	 * from it and must be kept, or it would be truncated down to its
+	 * header.
+	 */
+	bool system_config = strcmp(config_filename, perf_etc_perfconfig()) == 0;
+	struct perf_config_set *set;
+	int ret = -1;
+
+	pthread_mutex_lock(&config_update_mutex);
+	set = perf_config_set__new();
+	if (!set)
+		goto out_err;
+
+	if (perf_config_set__collect(set, config_filename, var, value) < 0) {
+		pr_err("Failed to add '%s=%s'\n", var, value);
+		goto out_err;
+	}
+
+	if (perf_config_set__write(set, config_filename, system_config) < 0) {
+		pr_err("Failed to set the configs on %s\n", config_filename);
+		goto out_err;
+	}
+
+	ret = 0;
+out_err:
+	perf_config_set__delete(set);
+	pthread_mutex_unlock(&config_update_mutex);
+	return ret;
+}
+
 static void perf_config_item__delete(struct perf_config_item *item)
 {
 	zfree(&item->name);
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index 987b47cf54c350ba..9098f8a045850c97 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -33,6 +33,8 @@ int perf_config_scan(const char *name, const char *fmt, ...) __scanf(2, 3);
 const char *perf_config_get(const char *name);
 int perf_config_set(struct perf_config_set *set,
 		    config_fn_t fn, void *data);
+int perf_config_set__write(struct perf_config_set *set,
+			   const char *file_name, bool system_config);
 int perf_config_int(int *dest, const char *, const char *);
 int perf_config_u8(u8 *dest, const char *name, const char *value);
 int perf_config_u64(u64 *dest, const char *, const char *);
-- 
2.55.0

