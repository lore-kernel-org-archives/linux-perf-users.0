Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB934718CE;
	Sun,  4 Oct 2026 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135018; cv=none; b=M+P70nn9ebNpK/cSep6bLD2KIHE90LvCBAixSsFVoBv60edgB3LgCTLJNombcLDUDdBRuN35Hk7KTBJmhSG8YWZerRyxPRzhHDdr+29p3f8tApK4tRUlM9/he6vPIvqzC1I9t8SU/ynlualvnl64PuV/8j8gK/ZV/jWXP2AaOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135018; c=relaxed/simple;
	bh=BcKDBp0/tuqohCP4tWXyzXYGfmCGzpagjswWlJJfqd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3ayPt6uN0yK+UH2nA8V09v2bvCaR9bT9zsdYAvN3Xp37CHoIdWtIR9fVp2SnQCwpf1s7aXZwpoaM0OQEsngwTz/b0PBqdgESpRMkFGcBUeZxoXFVozSTMCENW9VyGTfbVXavT9xiyiDCUWVOGNTYHbT3vtP9VyxPGcx9rDSmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBBLMWB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBBLMWB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F401F00893;
	Sun,  4 Oct 2026 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135016;
	bh=dRGHatdLxqJVQm7rM650Tq0H3Js2+HM8FHgq6/8hJIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBBLMWB30cTeOKfofKQh7bnSmNFEuTRBhexMaBaRo1SqS+1KSS0oEIVdiPU/p2+5A
	 sAM7zXJh2R/GVd2TkTCfDSGvTbochUBPS3Rw4dezftRDFOhn0QdPWpZP8abR5DGbcD
	 yJuq/Dxh8xKLibn4kGlWgXsqGmUKTLJkOYP4aZToM1VYTU1AtJyTcqYt8c3d9xx+F9
	 YLfzB1VYWi7No78a6WUpteOWsVIoYrTVfIxjJglOa5Abv7bFtdR2/Wv9kkWDx/L3o/
	 wDxxnVcbgU6DGN7ACn7VEDUZXN8X5b9VNToGVpvZHLHG0aQUr7tenZDuNYFORdGWPb
	 MFkfgPqpmZwKQ==
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
Subject: [PATCH v11 1/9] perf config: Move perf_config__set_variable() to util/config.c
Date: Sun,  4 Oct 2026 19:29:52 +0200
Message-ID: <20261004173000.2863935-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004173000.2863935-1-acme@kernel.org>
References: <20261004173000.2863935-1-acme@kernel.org>
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
debuginfod for the rest of the session.  The set_config() body becomes
perf_config_set__write(), with the system_config choice as an argument,
as the builtin's use_system_config/use_user_config statics are not
available outside it.

perf_config_set__write() checked fopen() but none of the fprintf()s or
fclose(), so a write failure after truncating the file was reported as
success.  Harmless for the interactive 'perf config' this came from,
but this makes it an entry point a background feature can call with no
other feedback, so propagate those errors too.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c | 70 +---------------------------------
 tools/perf/util/config.c    | 76 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/config.h    |  2 +
 3 files changed, 79 insertions(+), 69 deletions(-)

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
index 8fe43b032e9af88a..85e50d0a25580da0 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -12,6 +12,7 @@
 #include "config.h"
 
 #include <errno.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -883,6 +884,81 @@ void perf_config__exit(void)
 	config_set = NULL;
 }
 
+int perf_config_set__write(struct perf_config_set *set,
+			   const char *file_name, bool system_config)
+{
+	struct perf_config_section *section = NULL;
+	struct perf_config_item *item = NULL;
+	int ret = 0;
+	FILE *fp;
+
+	fp = fopen(file_name, "w");
+	if (!fp)
+		return -1;
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
+
+	return ret;
+}
+
+/*
+ * Set @var=@value in the config file perf is using: ~/.perfconfig or the
+ * file named by PERF_CONFIG.  Same rewrite 'perf config' does, comments
+ * are not preserved.
+ */
+int perf_config__set_variable(const char *var, const char *value)
+{
+	char path[PATH_MAX];
+	char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
+	const char *config_filename;
+	bool system_config;
+	struct perf_config_set *set;
+	int ret = -1;
+
+	config_filename = config_exclusive_filename ?: user_config;
+
+	/* Rewriting the system wide file keeps its entries, or it is truncated. */
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

