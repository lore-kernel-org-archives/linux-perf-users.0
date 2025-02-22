Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C6201269
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Feb 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204633; cv=none; b=j8uG58WzLjeWADVu8gEZRd95oAqq0KfdyFsnRrK+GGGVhpNFwxQwVWiArU775cBZKPTliN9tB2grLmVEzoCxZ4stuhu+7FWL7Dq9YTb54oZ5YQim+JFGX2FUrsTV73DwcDLxKsT1eOtP2rSKYJpt8FhohuO9InhphxvAe3AA1YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204633; c=relaxed/simple;
	bh=El3XeRtQ8OVZvnoXo6U/JPgYkzRfppXqk9slQa6YGzI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=jztGKVwT0Epc2zXrxZeOdnvjv3qtb8FVEZP4aMBhi8xsG9diX33n+6xmIwM96crqMKqnKfZrSlyunVOZBLpaGEfVROz8pWu4DAbLGLVSt1uaNZMlFnh39nCzudv+YFPhXmMV+7uN8r42b+db1sX56YouDtJlGGH3y0TbUzxFUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSrLymD2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSrLymD2"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e549b6c54a0so4010893276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Feb 2025 22:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204630; x=1740809430; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQgs9D90lYlG1wh1e4gxKo/IB7ELhv6Ph1wQ4nXY+AA=;
        b=zSrLymD2E3DBGS70h+UrHydxyTqu2WJD7K8uHjyIkqMFfia7XhNYaA/oWYr9HZM6/D
         Jsc8Cm1/0809mZntgwCMxHRzTYD416DpAPVe8AJCoa36KLnZZYv0k1/xO3HdmX0rSb0H
         +tK48qFrhdWuBYPUYT1XWh3MGJaPEs+g3OIqpj8qL5dbNz0SjQwXmak0txUsmn2wyRhy
         ngpa5mA95mmOSi11ANqTy4PXQ5ihbttXTmJxFPTGrA078G2HFh8I98S9x40j33Bn2U9q
         ZrkP+dZ7OO23mZxkM6wtvKIpGKJnQ+DVPz5xVPY83b/X/b49E598S0McXGGCBfoir/Wa
         ET5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204630; x=1740809430;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQgs9D90lYlG1wh1e4gxKo/IB7ELhv6Ph1wQ4nXY+AA=;
        b=MRigPIt7N5841SjH0FvWd5nrQfo6dKW6/sH6IMLydB4rd90u8Qosh8R0mBVKFdkp/g
         EPSIvdRD9WTxeLZJw9Rf4O5sIbQlTmZZPJPM/DNC/Fi9EBDQ1meSU+FtcmCojcW5Jpke
         6Gz/EPPoBq804Ge3HuW4Vt8CdDAWkP86i+kozOy5CE8n1oT1pzqcHD7jBS/Hvcm0wk3H
         1s2EVxizlSIg4iyBf6/z74CaktOazSQyEsKx3PZSU+yTiV+252YiY6fmr8P786+fEZwq
         docFxPpEZoNXJfSmEhndus/UzJdjh8ocMJv1jPduhlOEPaDc6A5ndax0rjcnVqRaZGOS
         jDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvnG4fDoxvmKzlQO4tOTVyEhNoHx+41x3shfX7KBXSVpkM+amEYb9YUGJJe7Jmb4aARSQzNoPIl4k2ENAqGHRi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0s4i31S3uUGP17GmFtOsMJ4hEXRo8ioMOkrnQMexImhF3ML1
	5f9ZXU2bf2cOjcKc47iLsU9MUByLK32JD7hlmgy8soiPrHCBMFYWB7ApB29tK4QG94PmA0AOoBH
	X1tch6A==
X-Google-Smtp-Source: AGHT+IGXtFIaZMEMC4tZMr9039JzzAtxMiM9SCVzH+3K7kZMO5jt7NrWjUZ4fOIJ1SFOMD2oBerQw8yCZt/s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a25:7c43:0:b0:e57:d22f:3449 with SMTP id
 3f1490d57ef6-e5e2484ff55mr479026276.1.1740204630388; Fri, 21 Feb 2025
 22:10:30 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:08 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 3/8] perf pmu: Switch to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid DIR allocations when scanning sysfs by using io_dir for the
readdir implementation, that allocates about 1kb on the stack.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 46 +++++++++++++++++-------------------------
 tools/perf/util/pmus.c | 30 ++++++++++-----------------
 2 files changed, 30 insertions(+), 46 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ec3878c890a9..e51c17b1ea35 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -13,6 +13,7 @@
 #include <dirent.h>
 #include <api/fs/fs.h>
 #include <api/io.h>
+#include <api/io_dir.h>
 #include <locale.h>
 #include <fnmatch.h>
 #include <math.h>
@@ -195,19 +196,17 @@ static void perf_pmu_format__load(const struct perf_pmu *pmu, struct perf_pmu_fo
  */
 static int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_load)
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
@@ -234,7 +233,7 @@ static int perf_pmu__format_parse(struct perf_pmu *pmu, int dirfd, bool eager_lo
 		}
 	}
 
-	closedir(format_dir);
+	close(format_dir.dirfd);
 	return ret;
 }
 
@@ -635,14 +634,12 @@ static inline bool pmu_alias_info_file(const char *name)
  */
 static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 {
-	struct dirent *evt_ent;
-	DIR *event_dir;
+	struct io_dirent64 *evt_ent;
+	struct io_dir event_dir;
 
-	event_dir = fdopendir(events_dir_fd);
-	if (!event_dir)
-		return -EINVAL;
+	io_dir__init(&event_dir, events_dir_fd);
 
-	while ((evt_ent = readdir(event_dir))) {
+	while ((evt_ent = io_dir__readdir(&event_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
 		FILE *file;
@@ -674,7 +671,6 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
 		fclose(file);
 	}
 
-	closedir(event_dir);
 	pmu->sysfs_aliases_loaded = true;
 	return 0;
 }
@@ -2221,10 +2217,9 @@ static void perf_pmu__del_caps(struct perf_pmu *pmu)
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
@@ -2235,24 +2230,21 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
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
@@ -2274,7 +2266,7 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 		fclose(file);
 	}
 
-	closedir(caps_dir);
+	close(caps_fd);
 
 	pmu->caps_initialized = true;
 	return pmu->nr_caps;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 8a0a919415d4..afd59d678fd0 100644
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
@@ -235,20 +235,16 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 
 	if (to_read_types & (PERF_TOOL_PMU_TYPE_PE_CORE_MASK | PERF_TOOL_PMU_TYPE_PE_OTHER_MASK)) {
 		int fd = perf_pmu__event_source_devices_fd();
-		DIR *dir;
-		struct dirent *dent;
+		struct io_dir dir;
+		struct io_dirent64 *dent;
 		bool core_only = (to_read_types & PERF_TOOL_PMU_TYPE_PE_OTHER_MASK) == 0;
 
 		if (fd < 0)
 			goto skip_pe_pmus;
 
-		dir = fdopendir(fd);
-		if (!dir) {
-			close(fd);
-			goto skip_pe_pmus;
-		}
+		io_dir__init(&dir, fd);
 
-		while ((dent = readdir(dir))) {
+		while ((dent = io_dir__readdir(&dir)) != NULL) {
 			if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 				continue;
 			if (core_only && !is_pmu_core(dent->d_name))
@@ -257,7 +253,7 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 			perf_pmu__find2(fd, dent->d_name);
 		}
 
-		closedir(dir);
+		close(fd);
 	}
 skip_pe_pmus:
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK) && list_empty(&core_pmus)) {
@@ -721,8 +717,8 @@ bool perf_pmus__supports_extended_type(void)
 char *perf_pmus__default_pmu_name(void)
 {
 	int fd;
-	DIR *dir;
-	struct dirent *dent;
+	struct io_dir dir;
+	struct io_dirent64 *dent;
 	char *result = NULL;
 
 	if (!list_empty(&core_pmus))
@@ -732,13 +728,9 @@ char *perf_pmus__default_pmu_name(void)
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
@@ -747,7 +739,7 @@ char *perf_pmus__default_pmu_name(void)
 		}
 	}
 
-	closedir(dir);
+	close(fd);
 	return result ?: strdup("cpu");
 }
 
-- 
2.48.1.658.g4767266eb4-goog

