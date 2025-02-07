Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F51DE2BE
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970706; cv=none; b=AqBEyfqmWaj7se44zpbB2vLpRyOscFm3Hh8S1GK73iMU1Jg96PqEEd+8827vWmJOUSwAXqJK1qhHEBaFIIpiwof44pZ2FjroLzrw5EfW5vYlrOJQ6liqdx64FEOFX6ufPfhHpWCOHDKeC9I1KYpI7bFuSnNCqPoG+96pTIMhROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970706; c=relaxed/simple;
	bh=svnWEsdd0RH2EO1mazYA60VXYRHZD9wTFEGGdpTDYK8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DtR2pMjxt9Gmt3aF+oVmhhU99nC9DkxHQVmPimYdevzbbSsx6FvAf9ZFkGtfPdFuCb3sC4IkD0sq6PEJuv3WPxar4JsgBT/jU+EZrFLiMYlQG+cz5M3dNzOpo86P9iXdrIWqINQACzcyAwQxiBObBtQx7/TewqgDWdj66ZVUKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c7uimYUq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7uimYUq"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e583e274095so3131041276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738970703; x=1739575503; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zThM502oWmZskuFWvBnh7q8yzaYbumd3GHoPECBIme8=;
        b=c7uimYUqUz1SCg9xdE8CTixSK81zAcv+tZAPoX8kpdT3BpKTfRetHwsMev9GvNveaN
         qvpo5+PN97Qr24SYRawoeiX3Ebrrq6jj7qKN1GUuoqf/T9ygz72PhMwHyGn8MzjRLZYk
         74ZAUOj6Kpl021d1yNkoK8pkru3a6m28iTwKxDYJvJnh6DbTYQiUZH99D9sdjO3oOP+l
         HEM9avxYmvRKHhskrmtcSzFWzNnSXcbds6APZcA6wJ0k0ADMUoeg40JxrpRKxXACdnfP
         lBYwig11/A33xNBynwLQo8ekcnk4P3xbkWXL2NuRx2BWITzbR0Mt6CqvmFBoRX83pRhE
         ozDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970703; x=1739575503;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zThM502oWmZskuFWvBnh7q8yzaYbumd3GHoPECBIme8=;
        b=JQ01CnVBQXZyho4MXNG0Whfb25qQACs3zVmxybLEzh7G8KZTODRJHJ6hfm8tStaM5f
         kZCg+BBttmQ+AhyzGCFly1RrkxWS6Av6OZV5m6pC/IYvjCvHEF89/VvV3Sh0Qhrv+KSr
         27BKT5zZ4OqFX+8VoDk4MaoXvoBLL2trbHLW/etrqkzzm/rMvypwKh5Y/zwDga84KTk3
         aIcEL5rw0bQxozK6jez1myJx6J4SIJN/WDiKPDbYQJROgbC7LFNZWTrHJaZzxkhT3Puc
         8i8XXY9xIgGzunhfg82YUJsW7JpUihvtxeSORnZbbS+dQCYGK1Tod5vsHO4lRkz9lWXM
         hvQg==
X-Forwarded-Encrypted: i=1; AJvYcCW2orPWRznHxw8mAzh4bYhM/7OG04c8+nHF0BJuUl/vw/hJsuc8xe2FFuotCqZcjIG9/Z+L7bCA87SQj4Qi5mtn@vger.kernel.org
X-Gm-Message-State: AOJu0YyUi2iwKiGLjX5NpjRZvd6liU+561JX+JD80BcEQfs4I7PFfTnS
	q3SpfVBf4sJGbzo5DomgAOAGgvvT0FpsP85K+NnFMOHL2ha2bjzCeWNzZLdCY6a35KRy0LX3bnR
	mMpCmhw==
X-Google-Smtp-Source: AGHT+IFAhE/XkHhwi5uq3vCpmrpZE+Y0JWgUbIMBDiq2rNgMaOB6aOCcctu3WZpW4W+A+Y+gQnTMvb2kVcM0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a05:6902:726:b0:e5b:4651:ad0c with SMTP id
 3f1490d57ef6-e5b4651adbamr47032276.3.1738970703232; Fri, 07 Feb 2025 15:25:03
 -0800 (PST)
Date: Fri,  7 Feb 2025 15:24:44 -0800
In-Reply-To: <20250207232452.994822-1-irogers@google.com>
Message-Id: <20250207232452.994822-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207232452.994822-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v2 3/7] perf pmu: Switch to io_dir__readdir
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>, 
	Jesper Juhl <jesperjuhl76@gmail.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Michael Petlan <mpetlan@redhat.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
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
index c2a15b0259cf..91ed909433cc 100644
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
2.48.1.502.g6dc24dfdaf-goog

