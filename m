Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83341E25
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ho7PysMA"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4A12119
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7e4745acdso94122107b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186300; x=1698791100; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGp/3cu2x+AKrnRU7KWdBupCS5op7rBGMNR9ttA6zXA=;
        b=ho7PysMAjwIJ3yIPe+0/b/7VBk4CN0/vnEqDCkDAR0t9wOPDgRfiS8RBAoZO2M9YUn
         nsrWvo7n5hqAdTf5tyKzhTFyR9051FJUHrbpqxXsrz/cRb1xgPg2I8whqIaomG7JZNF3
         nwNZ4QAYTJgPF+C1zp75z9njx2mG5+uwzEdSCYjquYMwL7LUUkZnWYVnoNsucYQ05fBK
         2N+xKhINliTVjQP5OrD93WsjUsKk1bH+7u1DzPpIcZ6Yw5id3WruyxXsg38VYgh7a5lo
         zq556AP8f3GodPF6g+gPZ93Y09BsiSyghWlltHWXIG5Ddr23Vb/juFmm+qYHS4IvfkFa
         Jhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186300; x=1698791100;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGp/3cu2x+AKrnRU7KWdBupCS5op7rBGMNR9ttA6zXA=;
        b=rooburTHvZ3ZVLlL3LOrs+0frQUQmpJFhlCiSINDz7uZH0Y7k7j+zhM5s1pHVvfjiO
         SeqSDmBOSlZLKgSeZcOK9z03Os9jA/jLKkjnpWnbTVJVLptC7QKkBrVqBZeOpsECpae4
         r9hbuSYFEU94sN0Fqkt/18lVaO13K8qKmfm3p2wkcoJufaygqc5wxf47TeAVIgai5hkI
         1BlMv8I/g7grVtBcKAQqbwhigYIgCU5PwY3hwrY+j0G6MSHpMklwyuAuwl3aTInNwdQO
         Hmilg3Gu1AovaOK8raGRUZa7MlwEGq2cbLqvrwcn7DZVPz23Na9FA4nWmwwbMDxXp9nO
         MPEA==
X-Gm-Message-State: AOJu0Ywkgrdmut8kn9BRZ7ru81jsvAtfWt+yFN9/3rr6RnTRGcDHAmev
	NjNeesieW3GiOdY/ipyQ+e1L3TmR+Ndq
X-Google-Smtp-Source: AGHT+IFMkFd01myzF9RyTV4d34BIGfM6QWBED6N507yZ/SCniaudgBXMjhF+gfxS4Agu38v5epx9FcdWmPo9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a81:5206:0:b0:5a7:b672:4d88 with SMTP id
 g6-20020a815206000000b005a7b6724d88mr288080ywb.0.1698186299914; Tue, 24 Oct
 2023 15:24:59 -0700 (PDT)
Date: Tue, 24 Oct 2023 15:23:24 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 21/50] perf pmu: Switch to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid DIR allocations when scanning sysfs by using io_dir for the
readdir implementation, that allocates about 1kb on the stack.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 48 +++++++++++++++++-------------------------
 tools/perf/util/pmus.c | 30 ++++++++++----------------
 2 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a967d25e899b..91ae0ce06ef0 100644
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
2.42.0.758.gaed0368e0e-goog

