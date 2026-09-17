Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE54E77EE;
	Thu, 17 Sep 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660553; cv=none; b=vAZNyh+UCVEgG7MInikCyC0JVKlGW3Q8G6gJkvcy6Da0Nuo5AVYUTVwVc5MflW7UT++mlfLip7pgnA5OmFiHRHdfue0zbj1Shz5/T7si+MS5MhuQRN4300SuQVL40EqmCabG6mSlyvpSPC2ktPWVbnNIcXjUgT0kvWe0vLug/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660553; c=relaxed/simple;
	bh=LdEw/QTInOJ563vNeGfjQlo5LNId6hRlzp7M1iLSQbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5OSdVRe+BN8Wf/8ttWuwf6AJY3EjUmClGnijDadCR5cboBNE+O028lNzeLvvu1OsfAuTpKRne2pQyTP/z8uil8vfXdm7deUVL/vaj0HztKujGKqh+URWnVd+fef0472W7RgAUPToZzH0JNCoQjd7Iqwuk88qNAyFxdfBALIOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTGJgbjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTGJgbjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170911F00898;
	Thu, 17 Sep 2026 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660551;
	bh=hzNAh/dZy3Dg85TJnOnNpH7opqOlcT8YZFzDZsnsJUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTGJgbjpdsdMrMh0pwcb6cM1YZNXZgEYIv2eCyRZJdeWU2mCSxwKG4o93DV4XjRni
	 iZKsgRDPJBb9bfc4qsnmTXoYrgIwnTSuRq/OXy1t+UWAOZix3cgy/EwY/Y7iZVBVn8
	 HxcJl08EO3SCPq2HkABhR8le694KHhvC8lryrPOIBTvNglfGZWUDMSeG2p09uk1J22
	 XQs+z55ug6MpD7HJzo6sYEiBGkJNFBrjGG99t1XZzCkmS+M4CUqO+UrYTKLziIOaNo
	 3MNCRqcLN+Dptn1538B5oT5dQG+SG3L8NlnVtpAOrkL11iOZr7c02x6cBXM8fHYmtE
	 fzKtONzovqSnw==
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
Subject: [PATCH 03/15] perf config: Move perf_config__set_variable() to util/config.c
Date: Thu, 17 Sep 2026 12:55:14 -0300
Message-ID: <20260917155528.62607-4-acme@kernel.org>
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

Move perf_config__set_variable() out of the 'perf config' builtin so
that util/debuginfo.c can use it to write core.debuginfod=false when the
user disables debuginfod for the rest of the session.  The set_config()
body becomes perf_config_set__write(), with the system_config choice as
an argument, as the builtin's use_system_config/use_user_config statics
are not available outside it, and it has to honour PERF_CONFIG and keep
the entries marked as coming from the system config when rewriting the
system wide file.

All config file access shares the static parser state and can now run on
more than one thread, with the debuginfod fetch writing the config while
perf top's display thread reads it, so serialize parsing and rewriting
with a mutex.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c | 70 +--------------------------
 tools/perf/util/config.c    | 96 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/config.h    |  2 +
 3 files changed, 98 insertions(+), 70 deletions(-)

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
index 31c6618d3b3daf22..d926360bccfd23a0 100644
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
@@ -542,11 +544,20 @@ int perf_default_config(const char *var, const char *value,
 	return 0;
 }
 
+/*
+ * Serialize config file access: parsing and rewriting share the static
+ * parser state and can run on more than one thread, with the debuginfod
+ * fetch writing core.debuginfod=false while perf top's display thread
+ * calls perf_config().
+ */
+static pthread_mutex_t config_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 static int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
 	FILE *f = fopen(filename, "r");
 
+	pthread_mutex_lock(&config_mutex);
 	ret = -1;
 	if (f) {
 		config_file = f;
@@ -557,6 +568,7 @@ static int perf_config_from_file(config_fn_t fn, const char *filename, void *dat
 		fclose(f);
 		config_file_name = NULL;
 	}
+	pthread_mutex_unlock(&config_mutex);
 	return ret;
 }
 
@@ -776,8 +788,13 @@ static int collect_config(const char *var, const char *value,
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 			     const char *var, const char *value)
 {
+	int ret;
+
+	pthread_mutex_lock(&config_mutex);
 	config_file_name = file_name;
-	return collect_config(var, value, set);
+	ret = collect_config(var, value, set);
+	pthread_mutex_unlock(&config_mutex);
+	return ret;
 }
 
 static int perf_config_set__init(struct perf_config_set *set)
@@ -876,6 +893,83 @@ void perf_config__exit(void)
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
+ * Set @var=@value in the configuration file perf is using: the user's
+ * ~/.perfconfig, or the file named by PERF_CONFIG, which makes perf
+ * read only that file, so writing ~/.perfconfig would replace it with
+ * the exclusive file's entries.  The rewrite is the same 'perf config'
+ * does, comments are not preserved.
+ */
+int perf_config__set_variable(const char *var, const char *value)
+{
+	char path[PATH_MAX];
+	char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
+	const char *config_filename = config_exclusive_filename ?: user_config;
+	/*
+	 * When rewriting the system wide file (e.g. with
+	 * PERF_CONFIG=/etc/perfconfig) all entries are marked as coming from it
+	 * and must be kept, or the file would be truncated down to its header.
+	 */
+	bool system_config = strcmp(config_filename, perf_etc_perfconfig()) == 0;
+	struct perf_config_set *set;
+	int ret = -1;
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

