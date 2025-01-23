Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26E20C002
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618429; cv=none; b=AGb4jnsc/mQGW6WuY5SBmMJrMLeYDvDXbxCNif7isxFe4tMfMmS1H9IR3u5Suerm50SagBDhKMcYoffZpNNSfzmub8wIl3Fl9tB/ssTo69uTMxP17ZfJCPXwYgK6AnNi4oTlM3Mt4MDU4vwG7dvnRkLb6kHQw2zEtI1+xb0VP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618429; c=relaxed/simple;
	bh=+M5w/T+041A89vZWNITIEfjyLsENoF3hrRVxva2X7m8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uAI7reh1t2sOtwf3zhiAzcCIekZzmW4Jyui8etL7LnOcrWFgbuD69O49iTJnhTAa6flY5AIXmjSKoj74LdXvlhFgCVP/Tfchk9eD98OAw2IvxoEPG/+DiCEku9BALin56jLhQQDPy9cdZjeRIq7z99ECgXiZvnlUmcxcQ+g878I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xk7b2dHX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xk7b2dHX"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e572f6dee18so1733410276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 23:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737618427; x=1738223227; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wYn6WdcSm32njaJYNLZydBVESxh4P8CNAbIPH/J3a4=;
        b=xk7b2dHXaa+AwoZ+Frp+DQlO9Dh7agw9lwY05iYdfbzoiCjgiMXObJzANITPxTA6W1
         uhxZN0cvxmjrvuyrMttIjrONEfhEeiJwWyh0nvKqbvpVIneEudfX+tKQvJIiuNXfPRAV
         BtMOm7BzLcKIj1/jxcS1LiQLw1YksglSrLbPuKMDG/AbQvw6onozS7mpc/k6F+CTupUv
         ybvyUZwSStUaaZUK+KHXNX0FMP2FEEenfeZcv5NGDJCoRTa7GpDCOJYbPsY6pxA2Ufll
         50+ykujCB+hlmgOcYkvBBgbaRJuuhMkye9Zj4aeKv84i6kuI+pvI03FgT7jdbN5h21Pd
         X14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737618427; x=1738223227;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wYn6WdcSm32njaJYNLZydBVESxh4P8CNAbIPH/J3a4=;
        b=R9C7rt7N9jeZUifFh6sq9y7y2OdAnXfRkd5cnKTXLI/9jf5nLQK8Oru0YgFaCnwND5
         TFrLdGYN0AZtglRtQsKF3hUzuAKc/wbvgh8/tLG9wKREa/rDRuR3ZqkgO4tmN16+ym15
         rNQdkuOe4cEOTTF1fhgeJRc71QwJwNg87ezhaE/mFULYTzaDluymoqK26Lb9p4pxEC0x
         haiOcj4Xmlipqy89WFuJCePh3B9um5S0Gb46XzDhnxjI6vxlXoQm5tOHMu2IDnbSVgXe
         gosevKtRBr88ZJcKRMmrNkBzVdn/QU0jtEy2mO3DFEzmUlWdUG9IvzfvHymAq/Lyqn/9
         oNgA==
X-Forwarded-Encrypted: i=1; AJvYcCUxUimzTlp46j+NoRbzgb6hQh9qw1xHSlrtQxnLv1ahajyVN3K2CMjnhZ6r8qG53mq0/gMjVxgMTBcOoumC1M3g@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67GlDxZi115yc8G+EPQojOO/x6Uk93ZAMe+HLmAhQ3hhf7yGG
	yKT8XN4x3lrB1DEB9cnIQIMjB7e4TC67QVUiBoESm3H6viNRtnHaz18HsoM//sdxAGQlmYOJ7v2
	QuhX2Zw==
X-Google-Smtp-Source: AGHT+IEMVGcccS9YIusJJY8SexHd3ZHVSgJHMDqjabZRZ2BXaosQ36nKl77U5VibVbpUDExMmdKebuFxi+4n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2fda:d811:ae83:77e0])
 (user=irogers job=sendgmr) by 2002:a05:690c:288f:b0:6e7:e3e4:9d83 with SMTP
 id 00721157ae682-6f6eb94745amr436007b3.8.1737618426958; Wed, 22 Jan 2025
 23:47:06 -0800 (PST)
Date: Wed, 22 Jan 2025 23:46:56 -0800
In-Reply-To: <20250123074659.698123-1-irogers@google.com>
Message-Id: <20250123074659.698123-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250123074659.698123-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v2 2/5] perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
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
2.48.1.262.g85cc9f2d1e-goog

