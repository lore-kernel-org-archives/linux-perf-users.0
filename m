Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E71DF26B
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738970714; cv=none; b=cRUJpMFNYIpF4CIOTbRTK//t7iPeH432O6gYvmeFHmE9bBynIW7cKrm5aplvtGmltr8k4XJJ7GKf1eoWpfDSPuFsQTSf+zhNbGWU630g2p48hOzcXAjHCWriEgJcj0ulHsglCpTMv2QvyTwJURsTXSFTjB212rls16Uektm7bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738970714; c=relaxed/simple;
	bh=t65Qte1hMK2K/SqGXWL6WDwX51wRPkkWC4a83KGD0zg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EnYO1vwAWkm+Ji1Uyi7VBcTNnIaUw//lV3uzmbueKsKG9svVmdq/z2eTZowwTDjnM7JTV6cJdDiir9Wainatpda184qeRkIbRIEBNzuKUqNP1YJQyYN7ICbcdNMsE9UeWoELPdnXFSyokSh3vFaiXHpFeIKHBR6RJyBe2iWNlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQb5SPO/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQb5SPO/"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f975f86b74so35095997b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738970712; x=1739575512; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEq/K8vKiseEoA2QFSLjXeZ/dhyahLOHi8u2z0uKAPQ=;
        b=FQb5SPO/VOvDXGF0luobyyUEuHnJ8VICJg8mrqkN+5ywN4Kg4RrGt1L2EwR4rJ3+Gf
         FlCjARZ0WmhJHdeHNXJoxWYpaYaaYkQzbTkIYpox+cXJrghUOxI6oa488gfD4ze9eESj
         6FvfQC9MzfTFDuATBIIcZM8Ba7A101qUMHgpUNa6rnTnrNpoR7b5PV65jg3cUsyaFr7w
         Wo7CyNbSKLqMMbmVo4Q9t/GZsUoqAJvyKIv53Ls2tbn4pC3Ihzz97yMoATk2/eQKd0o1
         A6QnCVK2F4uOffQfTzhg1vJ+jdZs5GCqBGEQALB6kCRHHchA0hALD+7qTd+KgM4rFp24
         nAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738970712; x=1739575512;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEq/K8vKiseEoA2QFSLjXeZ/dhyahLOHi8u2z0uKAPQ=;
        b=TU2WMdWeITfzm06Fv2TvRtqNfZcAITh+msuqLnct8ZzhG/Jm/VqysZUuOX/X9HYZpz
         Clw+ATls1AbQUg8Ru/Vbomf0U3YsuvxYvvmesnZheX5FSiGalTj8dWXmD/SmNr81UElt
         5J2DeEvNtDlTouatm2a1wI0uaviHPSYs6FUtYoYzDrsE0eHFoDUbpzXf4nIDrCRMEK+c
         1Y7eq3e0tj6mmb/WF9RI/8Sy9X8E9fet7aei2ssRqYNFwX/s2pUXBYEM0Zt/2U5IvZRi
         yZBM4nxiTBPIc1UGLBRCdlOEAt8rn1vZUQcWeEtii9ZwAmkJWKhqDkF/nSzvzuyOdkdp
         bBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMZQ+xWuYG2CNO3cieB4TO+5JrIsHBet+1g9UAfmwWr0YHEJRerjoT261iS28No2OTa9yfczc5vdRQIgaN8vmL@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKJ63wHJWbALeZplFW3w4Plysg6md3m4qMk5gytoKkKs4TeRZ
	+vzGSzO9oBga/036oEf8Ypm5ml7g+wcYOvj2alUVKwdBpK2oTJDOw3O8UA3pm7DkECO0/rwK7Rk
	1+jAO8w==
X-Google-Smtp-Source: AGHT+IFnOnokinwj7W6d66xeycuW5pfirx4gJhlEr4QKRDn9npVQrsFBWLER1GrO5dxcUrZ3qNKDmQLXh2ul
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:79e4:4a45:1e80:ace5])
 (user=irogers job=sendgmr) by 2002:a05:690c:9315:b0:6f9:7447:79a1 with SMTP
 id 00721157ae682-6f9b29584bdmr340987b3.6.1738970712533; Fri, 07 Feb 2025
 15:25:12 -0800 (PST)
Date: Fri,  7 Feb 2025 15:24:48 -0800
In-Reply-To: <20250207232452.994822-1-irogers@google.com>
Message-Id: <20250207232452.994822-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250207232452.994822-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v2 7/7] perf hwmon_pmu: Switch event discovery to io_dir__readdir
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 42 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index acd889b2462f..3cce77fc8004 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -11,13 +11,13 @@
 #include <sys/types.h>
 #include <assert.h>
 #include <ctype.h>
-#include <dirent.h>
 #include <fcntl.h>
 #include <stddef.h>
 #include <stdlib.h>
 #include <string.h>
 #include <api/fs/fs.h>
 #include <api/io.h>
+#include <api/io_dir.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -235,31 +235,22 @@ static void fix_name(char *p)
 
 static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 {
-	DIR *dir;
-	struct dirent *ent;
-	int dup_fd, err = 0;
+	int err = 0;
 	struct hashmap_entry *cur, *tmp;
 	size_t bkt;
+	struct io_dirent64 *ent;
+	struct io_dir dir;
 
 	if (pmu->pmu.sysfs_aliases_loaded)
 		return 0;
 
-	/*
-	 * Use a dup-ed fd as closedir will close it. Use openat so that the
-	 * directory contents are refreshed.
-	 */
-	dup_fd = openat(pmu->hwmon_dir_fd, ".", O_DIRECTORY);
+	/* Use openat so that the directory contents are refreshed. */
+	io_dir__init(&dir, openat(pmu->hwmon_dir_fd, ".", O_CLOEXEC | O_DIRECTORY | O_RDONLY));
 
-	if (dup_fd == -1)
-		return -ENOMEM;
+	if (dir.dirfd < 0)
+		return -ENOENT;
 
-	dir = fdopendir(dup_fd);
-	if (!dir) {
-		close(dup_fd);
-		return -ENOMEM;
-	}
-
-	while ((ent = readdir(dir)) != NULL) {
+	while ((ent = io_dir__readdir(&dir)) != NULL) {
 		enum hwmon_type type;
 		int number;
 		enum hwmon_item item;
@@ -347,7 +338,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 	pmu->pmu.sysfs_aliases_loaded = true;
 
 err_out:
-	closedir(dir);
+	close(dir.dirfd);
 	return err;
 }
 
@@ -702,8 +693,8 @@ int hwmon_pmu__check_alias(struct parse_events_terms *terms, struct perf_pmu_inf
 int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
 {
 	char *line = NULL;
-	DIR *class_hwmon_dir;
-	struct dirent *class_hwmon_ent;
+	struct io_dirent64 *class_hwmon_ent;
+	struct io_dir class_hwmon_dir;
 	char buf[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
 
@@ -711,11 +702,12 @@ int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
 		return 0;
 
 	scnprintf(buf, sizeof(buf), "%s/class/hwmon/", sysfs);
-	class_hwmon_dir = opendir(buf);
-	if (!class_hwmon_dir)
+	io_dir__init(&class_hwmon_dir, open(buf, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+
+	if (class_hwmon_dir.dirfd < 0)
 		return 0;
 
-	while ((class_hwmon_ent = readdir(class_hwmon_dir)) != NULL) {
+	while ((class_hwmon_ent = io_dir__readdir(&class_hwmon_dir)) != NULL) {
 		size_t line_len;
 		int hwmon_dir, name_fd;
 		struct io io;
@@ -745,7 +737,7 @@ int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
 		close(name_fd);
 	}
 	free(line);
-	closedir(class_hwmon_dir);
+	close(class_hwmon_dir.dirfd);
 	return 0;
 }
 
-- 
2.48.1.502.g6dc24dfdaf-goog

