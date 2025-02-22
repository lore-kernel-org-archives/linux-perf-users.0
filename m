Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B82204686
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Feb 2025 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204641; cv=none; b=Cb/k0iq4u/14pZykLuC9fb4Wm+KokT10fRn8iMn1Dm7tYoegBTnzFI5OqAIo2TYE2QdGjg8vzL12az0v6uEgMWKM+hMsDWlLk2dAZ8jijIkggePzNzGutpt0+2OeA5tqKr4GINQqs3isLmNZqZN96nt44F8nT6YD5FvndoawlKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204641; c=relaxed/simple;
	bh=k06H4Vcpgsd6/Mkydj/FGzxUQvxN79VwTK7kPz5nwgE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=FoU+Z1vG8mqQqu63G+qNLkgw2lc2iwubaVxZhBk6rAKlt+kFGRI3veNDt8jz0B4fNh2EvvtCsVLj1RqY0uoTUvyltWyvV1/WVUO6CIUOMe6ncczlCbkdeBFXig6iWLTbrpeSpJd7NWL5BIeEpwrD80yl3areETLz9URZKDOcv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVG46lBR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVG46lBR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fbbb28b070so24604997b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Feb 2025 22:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204639; x=1740809439; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dc03GGKjNrJ36IJY1bOTZFOcM6Q7AOhYDNgE9sBgJC0=;
        b=eVG46lBRolyf0Ta+LKpWb8+WQLvHAM3M24GV2AYRfrGhkmOShGbCvz8lj+LjTgG/uk
         S4sBahAT8rx8oHCdHutkgmHTWisXAzkPMR3vndHlVOMLzIx16miROMu7IeVUkkEt1wJQ
         sgAnnKJGm6zhVMkr9qdno3EWql6QygCiAOu2akg4NyLi0+g15qMvUC0Q12UKJJyBDL6t
         JwjNOSswLrjBNFO8naWKdv6fk+0p3OY4YK7WQDt7q3grBORxq2xFvB3I8oT/cnwu6KZj
         bDiW9rQMiDi5qfVbgi5fW/K2/MH4Isd/Z1uExqK8f0s/6oz04H/vP6+CsNxokaxNVmIi
         J20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204639; x=1740809439;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dc03GGKjNrJ36IJY1bOTZFOcM6Q7AOhYDNgE9sBgJC0=;
        b=c9vS5/MdMmw+hW7i4xPNXCkX7evzoUuL/7wiCupQbUZCFcCqC7wmt967twCQB+0DXM
         HXEirTah0Jmul59qkNwqFuoMUwqqNNjVbgFnt1+kiPVTeeOIltumXny4SMnf7ml7bq+z
         45480Ej7zsCkGCjTp9rDJRYRXlXfi3FSkGZOc/x1F5714lt2iD4TkQw1AuVpzvlQ5Ozl
         sjIYW2Kajm9U2vIz/FMpqrI93NHtvHaVdy2UmhKarsdo53smfF2352OAGe+4Iioq3jS/
         ikd64OgV0lxsLPnjJ2KbMLj8HR780/CEumcF4uEhCz/jopPODXldVD9j7RFBNwRwjit3
         fdYw==
X-Forwarded-Encrypted: i=1; AJvYcCX/iV4viaqErExDobDk2eIYaEDXvw0LW0BZa1DvczgbrdZt0S6lTx6qAI157m1Q9RJGFTNFMOSfVeSJ7kqpO1Yb@vger.kernel.org
X-Gm-Message-State: AOJu0YzUqWqmFOfwc9re17/djQ8ieEfA+CnBAUM0YSuoVfgHsqI50GbE
	A7PC206CPkXoZF+HfOyTn6MVXWd7V6mtMTsB/5aR0kwwHghLd4/9w8r6pghm1CurV5zpbDULZOi
	t9xbZag==
X-Google-Smtp-Source: AGHT+IF78oS90ACeZ4zO0NJL6IhAOII04X3736RziRNp0CvmfHhXtOIC+7iDnuqfxH8n999RV62wjVQYprmo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a05:690c:4712:b0:6fb:8e5b:bd2e with SMTP
 id 00721157ae682-6fbcc37552dmr5271527b3.4.1740204639211; Fri, 21 Feb 2025
 22:10:39 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:12 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 7/8] perf hwmon_pmu: Switch event discovery to io_dir__readdir
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
2.48.1.658.g4767266eb4-goog

