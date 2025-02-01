Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB368146D76
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738395811; cv=none; b=rhDRFdmY0a6pK5ZguUVgoU7RtfvhxV4fGzGxij6mVjN2to/li8gv5XnyoxzhT7EUByPcn5D9GgYG/tuee4rIeiqc7wDoUmMr1Pv9N07/ll21slGa7P9B8pmVE4f5hDf8LvYqFBBaX3H5wVXaN9zcs00ToNayd8WECDdecj2OlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738395811; c=relaxed/simple;
	bh=uMzd/iZH/bMNz0wCzJ8K2NHZFexCew+F0KAa6hFUErc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TTJeN5LElp+k2GMrP9PXF7LTJHE/NAfa9ar1cHAnfCW5bnrDa4mbp1e/6CQr4fMuNB9deu110SEsmlTG6rIDhiJpNnJu6krkOi3qMLGHDIa9iBfyeCPm0JKY5vOk3UnRHr09cKyEttwYIfPonuY9xVuNZ9UVG7/gt37Or8rjfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8AWEK8/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8AWEK8/"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f465f0f314so21315397b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 23:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738395809; x=1739000609; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDhASOShaVtg1nFmPBQqJGEWYej7NV0Sg2Li3SVhUYY=;
        b=s8AWEK8/FYJBBFZWZnHzYPn/96wXYozv6MNM1XNGXiqlk2Zj0qfHez9asJNGG4oO8D
         CEnIvd4KVvvgEiZymrL6q+n4GBIfbKZEWAG1XaBRApw3ebOSbXy5cg3pfDlKbBUg1xM8
         zFAQWAi9pO6L98L6EKpdOh59IGpfsGWH7wh8L9FEOZvcITCfHiU5fb6oPKG8AUgEeGpE
         x8iJnYzOYjviwHCNkwG9eFJ2hv+mvAKyuxtBp0CKhl44TxfpxX0q/yRopMTRAhqgyfMI
         dMB0SMFBR9YKzBIOctq0z82vuvf5P+S9w9cMqdsQ/SpD4nyToO8kdHZT+t2FAJ5nclzL
         +Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738395809; x=1739000609;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDhASOShaVtg1nFmPBQqJGEWYej7NV0Sg2Li3SVhUYY=;
        b=MMGe/4v5eciwUYbdXKb0si0fCgAcqw7O9wjl1OxM6ORNP9K5ecwnkrhueZgve7keDl
         X+AYMDm0A+xuriLrzSCakVvceT6JMYIbDrejH9O0/OLlWHSK8tj06qJA9cIkaoiBguyH
         PdqCQj56GQVvV5RddArzmAoKIptSU8Lp7+jle32h0QS09cKw1zGlIKZCVU4va4I1g3xI
         Tu1zUZDyEUdrCiBHbd0AtPZLGTPPxhFHbZDRNs+pipPmhYHDIiUhnQ2rFzXKWEsPpn4V
         5EfB/xZy/IO/mxADkpZHziXDhu/nAg+iPjZKJQOrhDi/bkI7xYvhewC73KJG5Cirsgid
         jKhw==
X-Forwarded-Encrypted: i=1; AJvYcCXaGYyeTFpVYLRDIyVZ76bVtIuMhyj8Op7ZLU/ukuevqSipblOVkK+Ju8tyyRIBkfrxEm5LvlqfAEXWfcKYOOZ/@vger.kernel.org
X-Gm-Message-State: AOJu0YweTnAM/ncmX+M3WVRU5nGZuitnx7cQS5l13fHryf/RkxWrSTHH
	V16FdtGs0jx5BaEt6kS+M31eMTXcG8X27kBNZnXgjEjwFnjps1Aj3AHsHJkXWGQlVms3rE5eEIw
	dLdKWrw==
X-Google-Smtp-Source: AGHT+IEPEYgJhzzQhXSiX/3mdYkV3qCd1AQqkWeXFfzj+i5Xnt/hVQt7ufvmfgdpx7K3PQC/Ch8psKprQeiy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de26:87db:e4d0:62b6])
 (user=irogers job=sendgmr) by 2002:a05:690c:7348:b0:6ef:7d06:1eb7 with SMTP
 id 00721157ae682-6f7a831ecb9mr335047b3.2.1738395807960; Fri, 31 Jan 2025
 23:43:27 -0800 (PST)
Date: Fri, 31 Jan 2025 23:43:17 -0800
In-Reply-To: <20250201074320.746259-1-irogers@google.com>
Message-Id: <20250201074320.746259-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201074320.746259-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v3 2/5] perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than scanning core or all PMUs, allow pmu_read_sysfs to read
some combination of core, other, hwmon and tool PMUs. The PMUs that
should be read and are already read are held as bitmaps. It is known
that a "hwmon_" prefix is necessary for a hwmon PMU's name, similarly
with "tool", so only scan those PMUs in situations the PMU name or the
PMU's type number make sense to.

The number of openat system calls reduces from 276 to 98 for a hwmon
event. The number of openats for regular perf events isn't changed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.h  |   2 +
 tools/perf/util/pmus.c | 146 +++++++++++++++++++++++++++--------------
 2 files changed, 97 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index dbed6c243a5e..edd36c20aedc 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -37,6 +37,8 @@ struct perf_pmu_caps {
 };
 
 enum {
+	PERF_PMU_TYPE_PE_START    = 0,
+	PERF_PMU_TYPE_PE_END      = 0xFFFEFFFF,
 	PERF_PMU_TYPE_HWMON_START = 0xFFFF0000,
 	PERF_PMU_TYPE_HWMON_END   = 0xFFFFFFFD,
 	PERF_PMU_TYPE_TOOL = 0xFFFFFFFE,
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 60d81d69503e..8a0a919415d4 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -37,10 +37,25 @@
  */
 static LIST_HEAD(core_pmus);
 static LIST_HEAD(other_pmus);
-static bool read_sysfs_core_pmus;
-static bool read_sysfs_all_pmus;
+enum perf_tool_pmu_type {
+	PERF_TOOL_PMU_TYPE_PE_CORE,
+	PERF_TOOL_PMU_TYPE_PE_OTHER,
+	PERF_TOOL_PMU_TYPE_TOOL,
+	PERF_TOOL_PMU_TYPE_HWMON,
+
+#define PERF_TOOL_PMU_TYPE_PE_CORE_MASK (1 << PERF_TOOL_PMU_TYPE_PE_CORE)
+#define PERF_TOOL_PMU_TYPE_PE_OTHER_MASK (1 << PERF_TOOL_PMU_TYPE_PE_OTHER)
+#define PERF_TOOL_PMU_TYPE_TOOL_MASK (1 << PERF_TOOL_PMU_TYPE_TOOL)
+#define PERF_TOOL_PMU_TYPE_HWMON_MASK (1 << PERF_TOOL_PMU_TYPE_HWMON)
+
+#define PERF_TOOL_PMU_TYPE_ALL_MASK (PERF_TOOL_PMU_TYPE_PE_CORE_MASK |	\
+					PERF_TOOL_PMU_TYPE_PE_OTHER_MASK | \
+					PERF_TOOL_PMU_TYPE_TOOL_MASK |	\
+					PERF_TOOL_PMU_TYPE_HWMON_MASK)
+};
+static unsigned int read_pmu_types;
 
-static void pmu_read_sysfs(bool core_only);
+static void pmu_read_sysfs(unsigned int to_read_pmus);
 
 size_t pmu_name_len_no_suffix(const char *str)
 {
@@ -102,8 +117,7 @@ void perf_pmus__destroy(void)
 
 		perf_pmu__delete(pmu);
 	}
-	read_sysfs_core_pmus = false;
-	read_sysfs_all_pmus = false;
+	read_pmu_types = 0;
 }
 
 static struct perf_pmu *pmu_find(const char *name)
@@ -129,6 +143,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	struct perf_pmu *pmu;
 	int dirfd;
 	bool core_pmu;
+	unsigned int to_read_pmus = 0;
 
 	/*
 	 * Once PMU is loaded it stays in the list,
@@ -139,11 +154,11 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	if (pmu)
 		return pmu;
 
-	if (read_sysfs_all_pmus)
+	if (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK)
 		return NULL;
 
 	core_pmu = is_pmu_core(name);
-	if (core_pmu && read_sysfs_core_pmus)
+	if (core_pmu && (read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK))
 		return NULL;
 
 	dirfd = perf_pmu__event_source_devices_fd();
@@ -151,15 +166,27 @@ struct perf_pmu *perf_pmus__find(const char *name)
 			       /*eager_load=*/false);
 	close(dirfd);
 
-	if (!pmu) {
-		/*
-		 * Looking up an inidividual PMU failed. This may mean name is
-		 * an alias, so read the PMUs from sysfs and try to find again.
-		 */
-		pmu_read_sysfs(core_pmu);
+	if (pmu)
+		return pmu;
+
+	/* Looking up an individual perf event PMU failed, check if a tool PMU should be read. */
+	if (!strncmp(name, "hwmon_", 6))
+		to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
+	else if (!strcmp(name, "tool"))
+		to_read_pmus |= PERF_TOOL_PMU_TYPE_TOOL_MASK;
+
+	if (to_read_pmus) {
+		pmu_read_sysfs(to_read_pmus);
 		pmu = pmu_find(name);
+		if (pmu)
+			return pmu;
 	}
-	return pmu;
+	/* Read all necessary PMUs from sysfs and see if the PMU is found. */
+	to_read_pmus = PERF_TOOL_PMU_TYPE_PE_CORE_MASK;
+	if (!core_pmu)
+		to_read_pmus |= PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
+	pmu_read_sysfs(to_read_pmus);
+	return pmu_find(name);
 }
 
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
@@ -176,11 +203,11 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	if (pmu)
 		return pmu;
 
-	if (read_sysfs_all_pmus)
+	if (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK)
 		return NULL;
 
 	core_pmu = is_pmu_core(name);
-	if (core_pmu && read_sysfs_core_pmus)
+	if (core_pmu && (read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK))
 		return NULL;
 
 	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name,
@@ -197,52 +224,60 @@ static int pmus_cmp(void *priv __maybe_unused,
 }
 
 /* Add all pmus in sysfs to pmu list: */
-static void pmu_read_sysfs(bool core_only)
+static void pmu_read_sysfs(unsigned int to_read_types)
 {
-	int fd;
-	DIR *dir;
-	struct dirent *dent;
 	struct perf_pmu *tool_pmu;
 
-	if (read_sysfs_all_pmus || (core_only && read_sysfs_core_pmus))
+	if ((read_pmu_types & to_read_types) == to_read_types) {
+		/* All requested PMU types have been read. */
 		return;
+	}
 
-	fd = perf_pmu__event_source_devices_fd();
-	if (fd < 0)
-		return;
+	if (to_read_types & (PERF_TOOL_PMU_TYPE_PE_CORE_MASK | PERF_TOOL_PMU_TYPE_PE_OTHER_MASK)) {
+		int fd = perf_pmu__event_source_devices_fd();
+		DIR *dir;
+		struct dirent *dent;
+		bool core_only = (to_read_types & PERF_TOOL_PMU_TYPE_PE_OTHER_MASK) == 0;
 
-	dir = fdopendir(fd);
-	if (!dir) {
-		close(fd);
-		return;
-	}
+		if (fd < 0)
+			goto skip_pe_pmus;
 
-	while ((dent = readdir(dir))) {
-		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
-			continue;
-		if (core_only && !is_pmu_core(dent->d_name))
-			continue;
-		/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
-		perf_pmu__find2(fd, dent->d_name);
-	}
+		dir = fdopendir(fd);
+		if (!dir) {
+			close(fd);
+			goto skip_pe_pmus;
+		}
 
-	closedir(dir);
-	if (list_empty(&core_pmus)) {
+		while ((dent = readdir(dir))) {
+			if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
+				continue;
+			if (core_only && !is_pmu_core(dent->d_name))
+				continue;
+			/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
+			perf_pmu__find2(fd, dent->d_name);
+		}
+
+		closedir(dir);
+	}
+skip_pe_pmus:
+	if ((to_read_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK) && list_empty(&core_pmus)) {
 		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
 			pr_err("Failure to set up any core PMUs\n");
 	}
 	list_sort(NULL, &core_pmus, pmus_cmp);
-	if (!core_only) {
+
+	if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
+	    (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
 		tool_pmu = perf_pmus__tool_pmu();
 		list_add_tail(&tool_pmu->list, &other_pmus);
-		perf_pmus__read_hwmon_pmus(&other_pmus);
 	}
+	if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
+	    (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
+		perf_pmus__read_hwmon_pmus(&other_pmus);
+
 	list_sort(NULL, &other_pmus, pmus_cmp);
-	if (!list_empty(&core_pmus)) {
-		read_sysfs_core_pmus = true;
-		if (!core_only)
-			read_sysfs_all_pmus = true;
-	}
+
+	read_pmu_types |= to_read_types;
 }
 
 static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
@@ -263,12 +298,21 @@ static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
 
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 {
+	unsigned int to_read_pmus;
 	struct perf_pmu *pmu = __perf_pmus__find_by_type(type);
 
-	if (pmu || read_sysfs_all_pmus)
+	if (pmu || (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK))
 		return pmu;
 
-	pmu_read_sysfs(/*core_only=*/false);
+	if (type >= PERF_PMU_TYPE_PE_START && type <= PERF_PMU_TYPE_PE_END) {
+		to_read_pmus = PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
+			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
+	} else if (type >= PERF_PMU_TYPE_HWMON_START && type <= PERF_PMU_TYPE_HWMON_END) {
+		to_read_pmus = PERF_TOOL_PMU_TYPE_HWMON_MASK;
+	} else {
+		to_read_pmus = PERF_TOOL_PMU_TYPE_TOOL_MASK;
+	}
+	pmu_read_sysfs(to_read_pmus);
 	pmu = __perf_pmus__find_by_type(type);
 	return pmu;
 }
@@ -282,7 +326,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 	bool use_core_pmus = !pmu || pmu->is_core;
 
 	if (!pmu) {
-		pmu_read_sysfs(/*core_only=*/false);
+		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	}
 	if (use_core_pmus) {
@@ -300,7 +344,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 {
 	if (!pmu) {
-		pmu_read_sysfs(/*core_only=*/true);
+		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_PE_CORE_MASK);
 		return list_first_entry_or_null(&core_pmus, typeof(*pmu), list);
 	}
 	list_for_each_entry_continue(pmu, &core_pmus, list)
@@ -316,7 +360,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
 
 	if (!pmu) {
-		pmu_read_sysfs(/*core_only=*/false);
+		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	} else
 		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
-- 
2.48.1.362.g079036d154-goog

