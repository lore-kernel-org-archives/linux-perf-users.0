Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E420B08
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlq3ymrm"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B979D49
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 10:58:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d99ec34829aso1446635276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Nov 2023 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947901; x=1699552701; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yysZzz5KsjdB52OWy1zT/Vl17Oi4/hQFvJPxuk/sMvQ=;
        b=zlq3ymrmN8Lc7ob++onxMma3rt9g17xEv5a7Y9y5s5QRHqLLTjs4xMlKXIYKYVm3EU
         ccBhFHXBYVEC5i3g/FYCh2UoWnYDOMgk4FRaiR9xDev0KY7/4Y/4onls/Rmrciy5AnrS
         Tjx1ZCKrvAf3z7TttV/KLqNO01nTRaIhIc4NZpdxRLHHhZ9nRXc1eAvyBwYy3TiJyJHc
         RcXFBkDV3AZ8xgv7/SlicOvdf5keaY0/MqKUqu/GiJX9vfyGaaDys/ypSJxw6OhGBQQY
         5iU0ckBSLj3eKW06m0bNv9efVOcdURf0hm6bvTxE3ryUBVBCllYVv/9QvLdKil512QJq
         /H+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947901; x=1699552701;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yysZzz5KsjdB52OWy1zT/Vl17Oi4/hQFvJPxuk/sMvQ=;
        b=e6hvX/8Joh7VzxaOcKAR4jifq7uRStBlesByW2aUx2I09sM3qbesZBi33Zk1bV6RDy
         Qzz0LNDz09Fibifa98OAwa7QO14dpqUCPmfKfwWZi5azn4+aD6yXcUN1yIWNgbNy7O3A
         ocafsmRsL7EVUbQHcg5k7grI2lmfd6spsIe67WdJkd/X6yJaM/OWwntYcVhdlWETWOQM
         qtryzpmlgQzjwiKnm37RxCpTUwN9LbMpwWYfefeUQuWzITL6l9blbHAJT77Zd5BcppAW
         nDhb1G5nxMZkaUTcxbnWUKimezP1jSlvFXY4cd1iyxWXGSbgEFAomFajbe4yzZtS85H+
         4cYg==
X-Gm-Message-State: AOJu0YxKpKid5t4z1nId9jIvTUybtGhDja2N0X6DNLRaXa/LrLakSV/C
	lM0FgyTSdRTWwizsBOvydvsttZ+5Qw5A
X-Google-Smtp-Source: AGHT+IFZq3XjOVlkIWYyvXzwZrwQpwKLx89sKDSS9RxKY22/k+JEIpsof/3inrifhE4evPr6Mq6lk6zP8suL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a05:6902:1083:b0:d9a:c3b8:4274 with SMTP
 id v3-20020a056902108300b00d9ac3b84274mr460446ybu.7.1698947901164; Thu, 02
 Nov 2023 10:58:21 -0700 (PDT)
Date: Thu,  2 Nov 2023 10:56:53 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 11/53] perf pmu: Switch to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid DIR allocations when scanning sysfs by using io_dir for the
readdir implementation, that allocates about 1kb on the stack.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 48 +++++++++++++++++-------------------------
 tools/perf/util/pmus.c | 30 ++++++++++----------------
 2 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d3c9aa4326be..35548bbf7d17 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 #include <dirent.h>
 #include <api/fs/fs.h>
+#include <api/io_dir.h>
 #include <locale.h>
 #include <fnmatch.h>
 #include <math.h>
@@ -184,19 +185,17 @@ static void perf_pmu_format__load(const struct perf_pmu *pmu, struct perf_pmu_fo
  */
 int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
 {
-	struct dirent *evt_ent;
-	DIR *format_dir;
+	struct io_dirent64 *evt_ent;
+	struct io_dir format_dir;
 	int ret = 0;
 
-	format_dir = fdopendir(dirfd);
-	if (!format_dir)
-		return -EINVAL;
+	io_dir__init(&format_dir, dirfd);
 
-	while ((evt_ent = readdir(format_dir)) != NULL) {
+	while ((evt_ent = io_dir__readdir(&format_dir)) != NULL) {
 		struct perf_pmu_format *format;
 		char *name = evt_ent->d_name;
 
-		if (!strcmp(name, ".") || !strcmp(name, ".."))
+		if (io_dir__is_dir(&format_dir, evt_ent))
 			continue;
 
 		format = perf_pmu__new_format(&pmu->format, name);
@@ -223,7 +222,7 @@ int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
 		}
 	}
 
-	closedir(format_dir);
+	close(format_dir.dirfd);
 	return ret;
 }
 
@@ -599,8 +598,8 @@ static inline bool pmu_alias_info_file(const char *name)
 static int pmu_aliases_parse(struct perf_pmu *pmu)
 {
 	char path[PATH_MAX];
-	struct dirent *evt_ent;
-	DIR *event_dir;
+	struct io_dirent64 *evt_ent;
+	struct io_dir event_dir;
 	size_t len;
 	int fd, dir_fd;
 
@@ -615,13 +614,9 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		return 0;
 	}
 
-	event_dir = fdopendir(dir_fd);
-	if (!event_dir){
-		close (dir_fd);
-		return -EINVAL;
-	}
+	io_dir__init(&event_dir, dir_fd);
 
-	while ((evt_ent = readdir(event_dir))) {
+	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		FILE *file;
 
@@ -651,7 +646,6 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		fclose(file);
 	}
 
-	closedir(event_dir);
 	close (dir_fd);
 	pmu->sysfs_aliases_loaded = true;
 	return 0;
@@ -1879,10 +1873,9 @@ static void perf_pmu__del_caps(struct perf_pmu *pmu)
  */
 int perf_pmu__caps_parse(struct perf_pmu *pmu)
 {
-	struct stat st;
 	char caps_path[PATH_MAX];
-	DIR *caps_dir;
-	struct dirent *evt_ent;
+	struct io_dir caps_dir;
+	struct io_dirent64 *evt_ent;
 	int caps_fd;
 
 	if (pmu->caps_initialized)
@@ -1893,24 +1886,21 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	if (!perf_pmu__pathname_scnprintf(caps_path, sizeof(caps_path), pmu->name, "caps"))
 		return -1;
 
-	if (stat(caps_path, &st) < 0) {
+	caps_fd = open(caps_path, O_CLOEXEC | O_DIRECTORY | O_RDONLY);
+	if (caps_fd == -1) {
 		pmu->caps_initialized = true;
 		return 0;	/* no error if caps does not exist */
 	}
 
-	caps_dir = opendir(caps_path);
-	if (!caps_dir)
-		return -EINVAL;
-
-	caps_fd = dirfd(caps_dir);
+	io_dir__init(&caps_dir, caps_fd);
 
-	while ((evt_ent = readdir(caps_dir)) != NULL) {
+	while ((evt_ent = io_dir__readdir(&caps_dir)) != NULL) {
 		char *name = evt_ent->d_name;
 		char value[128];
 		FILE *file;
 		int fd;
 
-		if (!strcmp(name, ".") || !strcmp(name, ".."))
+		if (io_dir__is_dir(&caps_dir, evt_ent))
 			continue;
 
 		fd = openat(caps_fd, name, O_RDONLY);
@@ -1932,7 +1922,7 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 		fclose(file);
 	}
 
-	closedir(caps_dir);
+	close(caps_fd);
 
 	pmu->caps_initialized = true;
 	return pmu->nr_caps;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index ce4931461741..65b23b98666b 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -3,10 +3,10 @@
 #include <linux/list_sort.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <api/io_dir.h>
 #include <subcmd/pager.h>
 #include <sys/types.h>
 #include <ctype.h>
-#include <dirent.h>
 #include <pthread.h>
 #include <string.h>
 #include <unistd.h>
@@ -184,8 +184,8 @@ static int pmus_cmp(void *priv __maybe_unused,
 static void pmu_read_sysfs(bool core_only)
 {
 	int fd;
-	DIR *dir;
-	struct dirent *dent;
+	struct io_dir dir;
+	struct io_dirent64 *dent;
 
 	if (read_sysfs_all_pmus || (core_only && read_sysfs_core_pmus))
 		return;
@@ -194,13 +194,9 @@ static void pmu_read_sysfs(bool core_only)
 	if (fd < 0)
 		return;
 
-	dir = fdopendir(fd);
-	if (!dir) {
-		close(fd);
-		return;
-	}
+	io_dir__init(&dir, fd);
 
-	while ((dent = readdir(dir))) {
+	while ((dent = io_dir__readdir(&dir)) != NULL) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
 		if (core_only && !is_pmu_core(dent->d_name))
@@ -209,7 +205,7 @@ static void pmu_read_sysfs(bool core_only)
 		perf_pmu__find2(fd, dent->d_name);
 	}
 
-	closedir(dir);
+	close(fd);
 	if (list_empty(&core_pmus)) {
 		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
 			pr_err("Failure to set up any core PMUs\n");
@@ -563,8 +559,8 @@ bool perf_pmus__supports_extended_type(void)
 char *perf_pmus__default_pmu_name(void)
 {
 	int fd;
-	DIR *dir;
-	struct dirent *dent;
+	struct io_dir dir;
+	struct io_dirent64 *dent;
 	char *result = NULL;
 
 	if (!list_empty(&core_pmus))
@@ -574,13 +570,9 @@ char *perf_pmus__default_pmu_name(void)
 	if (fd < 0)
 		return strdup("cpu");
 
-	dir = fdopendir(fd);
-	if (!dir) {
-		close(fd);
-		return strdup("cpu");
-	}
+	io_dir__init(&dir, fd);
 
-	while ((dent = readdir(dir))) {
+	while ((dent = io_dir__readdir(&dir)) != NULL) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
 		if (is_pmu_core(dent->d_name)) {
@@ -589,7 +581,7 @@ char *perf_pmus__default_pmu_name(void)
 		}
 	}
 
-	closedir(dir);
+	close(fd);
 	return result ?: strdup("cpu");
 }
 
-- 
2.42.0.869.gea05f2083d-goog

