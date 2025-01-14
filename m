Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E021E0A6
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896422; cv=none; b=pFUYc7rNiDmCfavQriSwmwVO9UYCRb4IxVh4268H45jJ4LTQFxvHm0cuEWw2vVP5R0K2EpowhkiYqGs/TZpxpdXN9y/JGmz5rwiVLzvfn9qUrxNFlEV9E2R+L0UAsKc/3KymeERdZmCTKpkBIqDgsEONUZk4LNLeMUvQ0qnkymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896422; c=relaxed/simple;
	bh=btl4qXL5evLxqcHl1FvdrUG8RJ5rjIlNvcEpLlfshFg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i5OLrdTKk3aLu4TzDBKe4FEIvD7TD6p8RZZ2VsLnEk6ERnA+XxcxD9UadfySigV8/sTd66Vo6GQZG7XGX1TyUeud6N2hPkP8pOWDDaFiHhu9oLE4gn9j0OmCwJdxNyI4BQx5iKE4kCpn89cFdEVoo4rzOZM3kPxBtDi3IVzKah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1cHF8amj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1cHF8amj"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3c61a11a40so15130580276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 15:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736896420; x=1737501220; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ua/j8ZQhkKWj7ygdra9SGaNhS8kdmsUQSxwWnqi04Hs=;
        b=1cHF8amjmE1GxbH0Yu03jTHlhs1n8Yx79kNjQ6wbS9a9pv1FVDIROweeW71P3Ekvyt
         XEzE0cLO1TBzGf5BPcfmyMjNkX8LfSk43ndV2g6GVjk96Gxv1ju/0XCazUvKl6NOcrk0
         u35OhrDySrMhmNOMxwpJ5H5agen8qfIQ0PhFLriYe3Rh8XwjcPzlUe4e9kRRnoYVMKPc
         Rq5BvD1PViyWcINcSoAponIhGKK/Y/8Bk4ByKlpoa7JEf5bW4PxuNeft3GejPYtZHGt1
         Pr6e2e5IpAiVXGJFBhX+b7ugiUhjEBSnknG2m3+a5mcNSZIYR3iyfeizL+VPISlrf82D
         LlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896420; x=1737501220;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua/j8ZQhkKWj7ygdra9SGaNhS8kdmsUQSxwWnqi04Hs=;
        b=EgndflyqbmeX6Kf7JsR0THoQIlmWSSRB6CmSGbkul1ieUJbQ4d6egs96UFopFBl0bj
         tvpQbujg/of9Noq7a35FCMdKBRb1/P/DfaKkCzfiH/ELEc99kKwyXv5UrAcvP1CVhvlT
         KzJIywB3RZYmp169wj8cXPzc96D1aTTo6waXny94eJvT/O5gD8aZ/RYwOcgdEMp3Mk+4
         5YpH+cBN0x01fLeHU2nNYwaFylE+4CJ8c7PGqpwiIc1vxxUypfui+BXf2uTZxorKmblx
         0DZUpdKBQ8G2zdmfqTe789rm73GtcmOOcaP+s8g+jb4GcjamIo46hZC0oYNBgtYU8+kj
         NQHg==
X-Forwarded-Encrypted: i=1; AJvYcCX1Cw1ln9umWGXsLhpovuU9TUpKjpiYdd6YUQA4l7WE3BWFanFAMjgL54TdEPnSfnRKoZYOGeMpky2ncQzuVOPg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8t4I3gteWsiJjBng8mu64gVMiv0FvREphVfJQqPUHx2f7ZxO
	y0PEzqNk8HGyBeIp1T7fFM+9S0rps9nWY9d0FR6HMaxU49vtYE6l51MCC3+yI5U2Lpfdd4YbQ4R
	VbPLtrw==
X-Google-Smtp-Source: AGHT+IGmnTme9h/rpITxWUBz+vW/Nmh8/Ox6gBif+8JaTIBSnE+1wJDVCGBgW9tRmSZ2O4/OTmEwKTVVeGk3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b3e8:96da:3fa1:5494])
 (user=irogers job=sendgmr) by 2002:a5b:642:0:b0:e39:6fdc:5567 with SMTP id
 3f1490d57ef6-e54eddd285bmr71645276.0.1736896419977; Tue, 14 Jan 2025 15:13:39
 -0800 (PST)
Date: Tue, 14 Jan 2025 15:13:30 -0800
In-Reply-To: <20250114231332.13419-1-irogers@google.com>
Message-Id: <20250114231332.13419-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114231332.13419-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v1 2/4] perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
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
 tools/perf/util/pmus.c | 144 ++++++++++++++++++++++++++---------------
 2 files changed, 95 insertions(+), 51 deletions(-)

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
index b493da0d22ef..3e3ffafcad71 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -37,10 +37,23 @@
  */
 static LIST_HEAD(core_pmus);
 static LIST_HEAD(other_pmus);
-static bool read_sysfs_core_pmus;
-static bool read_sysfs_all_pmus;
+enum perf_tool_pmu_type {
+	PERF_TOOL_PMU_TYPE_PE_CORE,
+#define PERF_TOOL_PMU_TYPE_PE_CORE_MASK (1 << PERF_TOOL_PMU_TYPE_PE_CORE)
+	PERF_TOOL_PMU_TYPE_PE_OTHER,
+#define PERF_TOOL_PMU_TYPE_PE_OTHER_MASK (1 << PERF_TOOL_PMU_TYPE_PE_OTHER)
+	PERF_TOOL_PMU_TYPE_TOOL,
+#define PERF_TOOL_PMU_TYPE_TOOL_MASK (1 << PERF_TOOL_PMU_TYPE_TOOL)
+	PERF_TOOL_PMU_TYPE_HWMON,
+#define PERF_TOOL_PMU_TYPE_HWMON_MASK (1 << PERF_TOOL_PMU_TYPE_HWMON)
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
@@ -102,8 +115,7 @@ void perf_pmus__destroy(void)
 
 		perf_pmu__delete(pmu);
 	}
-	read_sysfs_core_pmus = false;
-	read_sysfs_all_pmus = false;
+	read_pmu_types = 0;
 }
 
 static struct perf_pmu *pmu_find(const char *name)
@@ -129,6 +141,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	struct perf_pmu *pmu;
 	int dirfd;
 	bool core_pmu;
+	unsigned int to_read_pmus = 0;
 
 	/*
 	 * Once PMU is loaded it stays in the list,
@@ -139,11 +152,11 @@ struct perf_pmu *perf_pmus__find(const char *name)
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
@@ -151,15 +164,27 @@ struct perf_pmu *perf_pmus__find(const char *name)
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
@@ -176,11 +201,11 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
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
@@ -197,52 +222,60 @@ static int pmus_cmp(void *priv __maybe_unused,
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
@@ -263,12 +296,21 @@ static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
 
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
@@ -282,7 +324,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 	bool use_core_pmus = !pmu || pmu->is_core;
 
 	if (!pmu) {
-		pmu_read_sysfs(/*core_only=*/false);
+		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	}
 	if (use_core_pmus) {
@@ -300,7 +342,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 {
 	if (!pmu) {
-		pmu_read_sysfs(/*core_only=*/true);
+		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_PE_CORE_MASK);
 		return list_first_entry_or_null(&core_pmus, typeof(*pmu), list);
 	}
 	list_for_each_entry_continue(pmu, &core_pmus, list)
@@ -316,7 +358,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
 
 	if (!pmu) {
-		pmu_read_sysfs(/*core_only=*/false);
+		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
 		pmu = list_prepare_entry(pmu, &core_pmus, list);
 	} else
 		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
-- 
2.48.0.rc2.279.g1de40edade-goog

