Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA314AB3BC;
	Wed, 16 Sep 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583571; cv=none; b=Z+GHJb+CnxaAABDEwvZ1NsaTVcZycDX/5Il/FjLG3oNVrsuOJ8DQYPAaCMg//lqfdc+Wo4y4Hss3Hop0cE1Mf/CJwOX4TkSUVJECnHixyYz3xLsxdULyku0uy/cCYJ1o4CMEZ5CrlP9+TXcoxbOKX/5/8yoenqjocVdFCHLCOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583571; c=relaxed/simple;
	bh=9de30fpK+FjlEc6Zx0EYXPffeGgzKidhMDqQpeunEDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwtC5Mketue26oCLpxW5Xf78SBFx1l1siMaTw5RdM9RykTZ6Rd9NJHaH71IedeDhK72trRs7mczAIS3wtocOyTT5n1N2/tkO86uLeIr0ABIQnbENTJAFp3wm9RVc1YmIcBSH4TwQFa9+DvLrBrZadj7EVp50wy7rX9bZf6eaWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9012s0D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9012s0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346441F00899;
	Wed, 16 Sep 2026 18:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583551;
	bh=9lw9ppSljwe7tgQX6UghEIY0j7oCp66gCvuvqRaKXsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9012s0DSGRMKC3VDg2u+4XAlLE1BkLkuWx3EJ6/5rYurK5wtFCbUgcxtdCPqXIdJ
	 A8MiRqwwtnkXFObarajAcgxMQGx4sXqlwz6tH3jtHOkZ1lqdnLXKjZOnLWR9V5ds5r
	 Z3dA5znvQgDs8mQ2Zyx/yFC5xRATH3XWBBfGb1pHD9dDvHqKOKRXQQwo1XL9a2wk25
	 QSXi61UWSCK5eaayWW14ngwCe9cUfSEkOQx3Ps0P7DGKhXSzbR7DoGi7xWZulzWYQY
	 pJoyk9Vi9GMUai9B2vV4w/LkdU79JZFwaxMys4bWyr6iOQqzzWil4dlBj9V3uN9w+F
	 gkfqkBvVPqP/A==
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
Subject: [PATCH 03/12] perf config: Move perf_config__set_variable() to util/config.c
Date: Wed, 16 Sep 2026 15:32:04 -0300
Message-ID: <20260916183215.54305-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916183215.54305-1-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It is code from the 'perf config' builtin to set a variable in the
configuration file perf is using, the user's ~/.perfconfig, or the file
named by the PERF_CONFIG environment variable when it is set, rewriting
that file from the config set, the same rewrite 'perf config' does,
i.e. the comments in it are not preserved, as the config set carries
just the key-value pairs.  It has to honour PERF_CONFIG, that makes perf
read only that file: the config set is loaded from it, so writing
~/.perfconfig would replace it with the exclusive file's entries.

The next patch wants to use it from util/debuginfo.c, so that when the
user asks for a debuginfod fetch to be skipped, pressing 'd', the
disable can also be made permanent, moving perf_config__set_variable()
to util/config.c, together with the set_config() body it uses,
parameterized as perf_config_set__write() with the system_config
choice as an argument, since the builtin's static use_system_config
and use_user_config option variables are not available outside it.
'perf config' keeps its behavior via the set_config() wrapper.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c | 70 +------------------------------------
 tools/perf/util/config.c    | 70 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/config.h    |  2 ++
 3 files changed, 73 insertions(+), 69 deletions(-)

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
index 31c6618d3b3daf22..3f9753b2a7bdfb76 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -876,6 +876,76 @@ void perf_config__exit(void)
 	config_set = NULL;
 }
 
+int perf_config_set__write(struct perf_config_set *set,
+			   const char *file_name, bool system_config)
+{
+	struct perf_config_section *section = NULL;
+	struct perf_config_item *item = NULL;
+	FILE *fp;
+
+	fp = fopen(file_name, "w");
+	if (!fp)
+		return -1;
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
+
+	return 0;
+}
+
+/*
+ * Set @var=@value in the configuration file perf is using: the user's
+ * ~/.perfconfig, or the file named by the PERF_CONFIG environment
+ * variable.  The latter has to be honoured as it makes perf read only
+ * that file, so the config set came from it and writing ~/.perfconfig
+ * would replace it with the exclusive file's entries.  Rewriting the
+ * file from the config set is the same rewrite 'perf config' does: the
+ * comments are not preserved, as the config set carries just the
+ * key-value pairs.
+ */
+int perf_config__set_variable(const char *var, const char *value)
+{
+	char path[PATH_MAX];
+	char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
+	const char *config_filename = config_exclusive_filename ?: user_config;
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
+	if (perf_config_set__write(set, config_filename, /*system_config=*/false) < 0) {
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

