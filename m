Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6605221F2;
	Wed, 30 Sep 2026 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804248; cv=none; b=LpRmgCaf83bS/ZVaydZiWlkInIQG9Ks9BOsOW2dVsLFwmHz2/pdbQJMyTIqphXzynrm0ItrI5z4bSvuOZRQZsu03rs+zfGz3eF39IdkppYEctrA0MZxBy6HM3E2wftDRK2Pjf9x2/la3Ns4flQJPe2WF0q4EYkzp+XqNCzBwsqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804248; c=relaxed/simple;
	bh=9JHA2nAVxW6o6SKHykwEG0ekb/VRXjpR4AsKq2Pxxew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+Jh9tuRHz+AADIX4fxE5gnPsAnQlFBRanFCoORnGl65PfZ2rT3mGy7fGU5geaqwYv05YRj1gZVJbaqDUSg8EfbF2C+b+IBc+jeu5StFnN/8AqbKQgjVQaOEEVtdZXxnFG84fevLm9MAXHHp4fcicPUH9rL2eQB897AZOGdCmmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOO2unCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOO2unCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4DA1F00898;
	Wed, 30 Sep 2026 21:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804246;
	bh=a3dk6QgfPPi8pM8omHbugvgUI97ycBCpXn1FtdjWJi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mOO2unCEoRDUOc06UMxF6xOm/iDln4hcMtduZDJKFoXpGf5tEY6SFNDLONX/C2qcq
	 YbuUaEas2Wx/QArY9uKFKo4iNtm8t+XKDG6ZpAkCSWX72153xSsO09AZY0/JKsnfkj
	 Q3jSleogDVuJWglw7HO4syYmKpsShq6n6uyc5lOMFtJyxcf/pEKMHQki+VuN/q0ns4
	 jR2EDAlEX/v32e8cvDOFv9yLUBO7xhumaygteGvI85MJZS9F+UqNIXcu6GHjpDWjcv
	 4IZptXUKB6HZiqdd/NjxPYYwapXzjADdWiG4rod8Zy0Vr1ZNCoDf8RojnLfs5LecN2
	 U2kqRC7KcfkmQ==
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
Subject: [PATCH v6 1/5] perf config: Move perf_config__set_variable() to util/config.c
Date: Wed, 30 Sep 2026 23:37:12 +0200
Message-ID: <20260930213716.2633750-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930213716.2633750-1-acme@kernel.org>
References: <20260930213716.2633750-1-acme@kernel.org>
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

perf_config_set__write() checked fopen() but none of the fprintf()s or
fclose(), so a write failure after truncating the file was reported as
success.  Harmless for the interactive 'perf config' this came from,
but this makes it an entry point a background feature can call with no
other feedback, so propagate those errors too.

perf_etc_perfconfig() caches what system_path() returns, and that
allocates, so on failure every caller dereferenced NULL, the
pre-existing ones in perf_config_from_file() and in the daemon
included.  Pre-existing, not introduced here, but this rewrites the
accessor anyway, so make it total: the unresolved path is the same
string for the usual absolute ETC_PERFCONFIG.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c |  70 +-----------
 tools/perf/util/config.c    | 219 ++++++++++++++++++++++++++++++++----
 tools/perf/util/config.h    |   2 +
 3 files changed, 201 insertions(+), 90 deletions(-)

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
index 8fe43b032e9af88a..3b6a45569ae3d2eb 100644
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
@@ -370,10 +372,15 @@ static int perf_parse_long(const char *value, long *ret)
 
 static void bad_config(const char *name)
 {
-	if (config_file_name)
-		pr_warning("bad config value for '%s' in %s, ignoring...\n", name, config_file_name);
-	else
-		pr_warning("bad config value for '%s', ignoring...\n", name);
+	/*
+	 * No file name here: config_file_name is set and cleared by
+	 * whichever thread has a config file in flight, under config_mutex,
+	 * while this runs on the thread dispatching the collected values.
+	 * Reading it would race with that thread: NULL between the check
+	 * and the use, or the file it is parsing, not the one the bad value
+	 * came from.
+	 */
+	pr_warning("bad config value for '%s', ignoring...\n", name);
 }
 
 int perf_config_u64(u64 *dest, const char *name, const char *value)
@@ -549,11 +556,26 @@ int perf_default_config(const char *var, const char *value,
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
@@ -564,15 +586,34 @@ static int perf_config_from_file(config_fn_t fn, const char *filename, void *dat
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
+	/*
+	 * None of the callers check for NULL, so an allocation failure
+	 * here leaves all of them dereferencing it.  The unresolved path
+	 * is the same string when ETC_PERFCONFIG is absolute anyway.
+	 */
+	if (!etc_perfconfig)
+		etc_perfconfig = ETC_PERFCONFIG;
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
@@ -630,19 +671,25 @@ static char *home_perfconfig(void)
 	return NULL;
 }
 
-const char *perf_home_perfconfig(void)
-{
-	static const char *config;
-	static bool failed;
+/*
+ * Computed once for the same reason as perf_etc_perfconfig() above:
+ * home_perfconfig() allocates, a lazy init racing on two threads would
+ * leak all but one of the strings, and the warnings it may print would
+ * come out more than once.
+ */
+static const char *home_config;
 
-	if (failed || config)
-		return config;
+static void perf_home_perfconfig__init(void)
+{
+	home_config = home_perfconfig();
+}
 
-	config = home_perfconfig();
-	if (!config)
-		failed = true;
+const char *perf_home_perfconfig(void)
+{
+	static pthread_once_t once = PTHREAD_ONCE_INIT;
 
-	return config;
+	pthread_once(&once, perf_home_perfconfig__init);
+	return home_config;
 }
 
 static struct perf_config_section *find_section(struct list_head *sections,
@@ -783,8 +830,18 @@ static int collect_config(const char *var, const char *value,
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 			     const char *var, const char *value)
 {
+	int ret;
+
+	pthread_mutex_lock(&config_mutex);
 	config_file_name = file_name;
-	return collect_config(var, value, set);
+	ret = collect_config(var, value, set);
+	/*
+	 * Don't leave the static parser state pointing at the caller's
+	 * buffer.
+	 */
+	config_file_name = NULL;
+	pthread_mutex_unlock(&config_mutex);
+	return ret;
 }
 
 static int perf_config_set__init(struct perf_config_set *set)
@@ -831,6 +888,16 @@ struct perf_config_set *perf_config_set__load_file(const char *file)
 	return set;
 }
 
+/*
+ * The global config_set is built lazily: two threads in perf_config() at
+ * once would both build one and leak all but the last, and config_set must
+ * not be read while another thread swaps it, so take it one at a time.  Not
+ * with config_mutex: building the set parses the config files, which takes
+ * that one.
+ */
+static pthread_mutex_t config_set_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+/* Called with config_set_mutex held. */
 static int perf_config__init(void)
 {
 	if (config_set == NULL)
@@ -871,16 +938,126 @@ int perf_config_set(struct perf_config_set *set,
 
 int perf_config(config_fn_t fn, void *data)
 {
-	if (config_set == NULL && perf_config__init())
+	struct perf_config_set *set;
+
+	/*
+	 * The mutex is taken just for the lazy init and for the pointer:
+	 * the dispatch below only reads the set, so a callback that called
+	 * perf_config() again would find it unlocked, and only
+	 * perf_config__exit() replaces the set.
+	 */
+	pthread_mutex_lock(&config_set_mutex);
+	if (perf_config__init()) {
+		pthread_mutex_unlock(&config_set_mutex);
 		return -1;
+	}
+	set = config_set;
+	pthread_mutex_unlock(&config_set_mutex);
 
-	return perf_config_set(config_set, fn, data);
+	return perf_config_set(set, fn, data);
 }
 
 void perf_config__exit(void)
 {
+	pthread_mutex_lock(&config_set_mutex);
 	perf_config_set__delete(config_set);
 	config_set = NULL;
+	pthread_mutex_unlock(&config_set_mutex);
+}
+
+int perf_config_set__write(struct perf_config_set *set,
+			   const char *file_name, bool system_config)
+{
+	struct perf_config_section *section = NULL;
+	struct perf_config_item *item = NULL;
+	int ret = 0;
+	FILE *fp;
+
+	pthread_mutex_lock(&config_mutex);
+	fp = fopen(file_name, "w");
+	if (!fp) {
+		pthread_mutex_unlock(&config_mutex);
+		return -1;
+	}
+
+	if (fprintf(fp, "# this file is auto-generated.\n") < 0)
+		ret = -1;
+
+	/* overwrite configvariables */
+	perf_config_sections__for_each_entry(&set->sections, section) {
+		if (!system_config && section->from_system_config)
+			continue;
+		if (fprintf(fp, "[%s]\n", section->name) < 0)
+			ret = -1;
+
+		perf_config_items__for_each_entry(&section->items, item) {
+			if (!system_config && item->from_system_config)
+				continue;
+			if (item->value &&
+			    fprintf(fp, "\t%s = %s\n", item->name, item->value) < 0)
+				ret = -1;
+		}
+	}
+	if (fclose(fp) != 0)
+		ret = -1;
+	pthread_mutex_unlock(&config_mutex);
+
+	return ret;
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
+	const char *config_filename;
+	bool system_config;
+	struct perf_config_set *set = NULL;
+	int ret = -1;
+
+	pthread_mutex_lock(&config_update_mutex);
+
+	/*
+	 * Not on the stack: the parser publishes this buffer as
+	 * config_file_name, which another thread may still be reading.  It is
+	 * shared by every caller, so it is formatted under the lock above.
+	 */
+	{
+		static char path[PATH_MAX];
+		char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
+
+		config_filename = config_exclusive_filename ?: user_config;
+	}
+
+	/*
+	 * When rewriting the system wide file all entries are marked as coming
+	 * from it and must be kept, or it would be truncated down to its
+	 * header.
+	 */
+	system_config = strcmp(config_filename, perf_etc_perfconfig()) == 0;
+
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
 }
 
 static void perf_config_item__delete(struct perf_config_item *item)
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

