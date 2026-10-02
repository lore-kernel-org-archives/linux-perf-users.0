Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC04478E5B;
	Fri,  2 Oct 2026 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936535; cv=none; b=tq71T76+oClxlS5mK08B+uVk4/rNBjpvhWqk0aDj9CI/lzZ3iYsrYPZT+XReIQCVyhaHU1mqxRc/dkkPoPW48J4ErTY0P5Q74tN/xaZFxOy8cVN0EBqjyenilnK0a2rKsNeytK3OpnyzTXkGXovP9ihLKCrEGbW9k9ljl99OPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936535; c=relaxed/simple;
	bh=mu7VGumEcJQprINCQfmX1+W1xgQLOgrbJTrfFdZYFqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNmQbNOoxkudlicnkYNyThPTJyxL4rSsZNorh8hxeYj4VmRY0B7RKilSnuedh3sxuHpQcqxSoHfjI+wYpfW1fM2qUcLpELBA6yvd40ImYkWsk2IHzKkJhqtuUt97gFQyeMtk5S7bAhKVJtp11s5cQ7MwjWWQMBpL2BODvUUJWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apqwQ90T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apqwQ90T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80C01F00893;
	Fri,  2 Oct 2026 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936533;
	bh=MfKs8OtBqCDByBYpjgQyZ3lj/pwcgNUSo+gP59FQ2kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=apqwQ90T60b/1LV6GMV5DV5tJuMqMv4HQXMizDD0LTRTKEvTlwloN0gQBlXqnqEdW
	 5IjJ+l9ZAspBgahmfydjay14roW51ImoZVsPtKrePPYlrT0+mxU/bG9QUG8XiCMI6N
	 l/iQxukVRljPA+eqp09G3/4MaNkaY6iF19TQDG7OFX1SxpfMt6b7hHU1L2CUo5DOfN
	 g8X8zDmETR1R6mlKmxtsY4HCGesS0iLg6kVkBYXGa7vAj0VdrQfq3OU8WRfKJb9fZ+
	 1QwKiIwJT2VISY2ALIwVi5N1Mfctvaedd7LeeWsZJ0xyr0RB427ugfNB2iCRt5NgV0
	 hvXd9LeOp9MQA==
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
Subject: [PATCH v8 5/9] perf config: Serialize config file access with a mutex
Date: Fri,  2 Oct 2026 12:21:06 +0200
Message-ID: <20261002102110.27587-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002102110.27587-1-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Config file access shares the static parser state and, since
perf_config__set_variable() became an entry point for background
features, can run on more than one thread: a feature writing the
config while perf top's display thread reads it.  Serialize parsing
and rewriting with config_mutex and the whole read-modify-write of
perf_config__set_variable() with config_update_mutex; config_set_mutex
comes before it, as building the set parses the config files.

perf has its own mutex type, util/mutex.h; the file scope mutexes
here use the DEFINE_MUTEX() static initializer added in the previous
patch.  The two lazy inits that system_path() and home_perfconfig()
do would leak all but one of the strings racing on two threads, so
they move to DO_ONCE(), added in the previous patch as well.
bad_config() runs on the dispatching thread, outside config_mutex, so
it stops reading config_file_name, which the parsing thread owns.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/config.c | 106 +++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6e0ff8a9140ccf96..287401f159e66e8c 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -31,6 +31,7 @@
 #include "callchain.h"
 #include "debug.h"
 #include "header.h"
+#include "mutex.h"
 #include "path.h"
 #include "srcline.h"
 #include "unwind.h"
@@ -371,10 +372,8 @@ static int perf_parse_long(const char *value, long *ret)
 
 static void bad_config(const char *name)
 {
-	if (config_file_name)
-		pr_warning("bad config value for '%s' in %s, ignoring...\n", name, config_file_name);
-	else
-		pr_warning("bad config value for '%s', ignoring...\n", name);
+	/* config_file_name is owned by the parsing thread, under config_mutex. */
+	pr_warning("bad config value for '%s', ignoring...\n", name);
 }
 
 int perf_config_u64(u64 *dest, const char *name, const char *value)
@@ -550,11 +549,18 @@ int perf_default_config(const char *var, const char *value,
 	return 0;
 }
 
+/* Parsing and rewriting share the static parser state. */
+static DEFINE_MUTEX(config_mutex);
+
+/* Serializes whole perf_config__set_variable() updates. */
+static DEFINE_MUTEX(config_update_mutex);
+
 static int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
 {
 	int ret;
 	FILE *f = fopen(filename, "r");
 
+	mutex_lock(&config_mutex);
 	ret = -1;
 	if (f) {
 		config_file = f;
@@ -565,21 +571,24 @@ static int perf_config_from_file(config_fn_t fn, const char *filename, void *dat
 		fclose(f);
 		config_file_name = NULL;
 	}
+	mutex_unlock(&config_mutex);
 	return ret;
 }
 
-const char *perf_etc_perfconfig(void)
-{
-	static const char *system_wide;
+/* system_path() allocates, so it is computed once. */
+static const char *etc_perfconfig;
 
-	if (!system_wide)
-		/*
-		 * ETC_PERFCONFIG is absolute, so its unresolved path is
-		 * the same string, better than the callers crashing.
-		 */
-		system_wide = system_path(ETC_PERFCONFIG) ?: ETC_PERFCONFIG;
+static void perf_etc_perfconfig__init(void)
+{
+	etc_perfconfig = system_path(ETC_PERFCONFIG);
+	if (!etc_perfconfig)
+		etc_perfconfig = ETC_PERFCONFIG;
+}
 
-	return system_wide;
+const char *perf_etc_perfconfig(void)
+{
+	DO_ONCE(perf_etc_perfconfig__init);
+	return etc_perfconfig;
 }
 
 static int perf_env_bool(const char *k, int def)
@@ -637,19 +646,18 @@ static char *home_perfconfig(void)
 	return NULL;
 }
 
-const char *perf_home_perfconfig(void)
-{
-	static const char *config;
-	static bool failed;
-
-	if (failed || config)
-		return config;
+/* home_perfconfig() allocates and warns, so it is computed once. */
+static const char *home_config;
 
-	config = home_perfconfig();
-	if (!config)
-		failed = true;
+static void perf_home_perfconfig__init(void)
+{
+	home_config = home_perfconfig();
+}
 
-	return config;
+const char *perf_home_perfconfig(void)
+{
+	DO_ONCE(perf_home_perfconfig__init);
+	return home_config;
 }
 
 static struct perf_config_section *find_section(struct list_head *sections,
@@ -790,8 +798,15 @@ static int collect_config(const char *var, const char *value,
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 			     const char *var, const char *value)
 {
+	int ret;
+
+	mutex_lock(&config_mutex);
 	config_file_name = file_name;
-	return collect_config(var, value, set);
+	ret = collect_config(var, value, set);
+	/* Don't leave the static parser state pointing at the caller's buffer. */
+	config_file_name = NULL;
+	mutex_unlock(&config_mutex);
+	return ret;
 }
 
 static int perf_config_set__init(struct perf_config_set *set)
@@ -838,6 +853,10 @@ struct perf_config_set *perf_config_set__load_file(const char *file)
 	return set;
 }
 
+/* Not config_mutex: building the set parses the config files, which takes it. */
+static DEFINE_MUTEX(config_set_mutex);
+
+/* Called with config_set_mutex held. */
 static int perf_config__init(void)
 {
 	if (config_set == NULL)
@@ -878,16 +897,26 @@ int perf_config_set(struct perf_config_set *set,
 
 int perf_config(config_fn_t fn, void *data)
 {
-	if (config_set == NULL && perf_config__init())
+	struct perf_config_set *set;
+
+	/* Not held across the dispatch: a callback can call perf_config() again. */
+	mutex_lock(&config_set_mutex);
+	if (perf_config__init()) {
+		mutex_unlock(&config_set_mutex);
 		return -1;
+	}
+	set = config_set;
+	mutex_unlock(&config_set_mutex);
 
-	return perf_config_set(config_set, fn, data);
+	return perf_config_set(set, fn, data);
 }
 
 void perf_config__exit(void)
 {
+	mutex_lock(&config_set_mutex);
 	perf_config_set__delete(config_set);
 	config_set = NULL;
+	mutex_unlock(&config_set_mutex);
 }
 
 int perf_config_set__write(struct perf_config_set *set,
@@ -898,9 +927,12 @@ int perf_config_set__write(struct perf_config_set *set,
 	int ret = 0;
 	FILE *fp;
 
+	mutex_lock(&config_mutex);
 	fp = fopen(file_name, "w");
-	if (!fp)
+	if (!fp) {
+		mutex_unlock(&config_mutex);
 		return -1;
+	}
 
 	if (fprintf(fp, "# this file is auto-generated.\n") < 0)
 		ret = -1;
@@ -922,6 +954,7 @@ int perf_config_set__write(struct perf_config_set *set,
 	}
 	if (fclose(fp) != 0)
 		ret = -1;
+	mutex_unlock(&config_mutex);
 
 	return ret;
 }
@@ -933,14 +966,20 @@ int perf_config_set__write(struct perf_config_set *set,
  */
 int perf_config__set_variable(const char *var, const char *value)
 {
-	char path[PATH_MAX];
-	char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
 	const char *config_filename;
 	bool system_config;
-	struct perf_config_set *set;
+	struct perf_config_set *set = NULL;
 	int ret = -1;
 
-	config_filename = config_exclusive_filename ?: user_config;
+	mutex_lock(&config_update_mutex);
+
+	/* Static: the parser publishes it as config_file_name. */
+	{
+		static char path[PATH_MAX];
+		char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
+
+		config_filename = config_exclusive_filename ?: user_config;
+	}
 
 	/* Rewriting the system wide file keeps its entries, or it is truncated. */
 	system_config = strcmp(config_filename, perf_etc_perfconfig()) == 0;
@@ -962,6 +1001,7 @@ int perf_config__set_variable(const char *var, const char *value)
 	ret = 0;
 out_err:
 	perf_config_set__delete(set);
+	mutex_unlock(&config_update_mutex);
 	return ret;
 }
 
-- 
2.55.0

