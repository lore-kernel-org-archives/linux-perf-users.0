Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DF1CF2B7;
	Mon, 16 Dec 2024 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332591; cv=none; b=qq3b6IPt9j+9w4Db/BTVh4qMqqFBTBENMoNgEq53IHO7LprnfAffhsKIokUllu93Ya46kJqJebW7KXk2PllNRijCMcU8DFU++2FXLnmjKTiOJ4A1L3blHQyGEllC787G8QQCWSA2lD9q+XjvVbER6amZ+FU8bA7mZL3mQBQz8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332591; c=relaxed/simple;
	bh=wIT5SmNxdT4v0e5iiwgpi069V9tAL1iTI0hAfKFb6Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9taAt0vIgtLdOwKvDwm+J8eot+X1rRNlxQkjYis8SSv/n5MSfF0I5/PNkFC/74HLL/8E7RukibRfsLKq7LpdyQf7yqkdbU2VO0t2Megq+K2aIdugo06XVEqYWMh7M59BjNYsELwQfcX/+6QJ2ZZmwLVYxXcWGqjfv8zdteQqL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/BKYu6Q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/BKYu6Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734332589; x=1765868589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wIT5SmNxdT4v0e5iiwgpi069V9tAL1iTI0hAfKFb6Rs=;
  b=h/BKYu6QXtz7z+ECWw9rGxfLUlAjsOPBkAtgjBvG9qg16NPtIm0Zy28/
   CyCwNmhpKYWuYeaY+bRt5zO05IIJbVh3sL+bWQIhrZzmFoTh9HOVvv3tz
   rkWL7Tkp/i6F8CkPYfjUi4iyKSYMsn1C9l1lmmTo43uSJ3rzkar77q9OU
   w8MtKLIrE0SL1X36efTiQADWU7nO3bmBR4QV7DP96ngSOdLjD38I49inK
   gb9pc2ZuLiqQDKAdHqxBFNQ3QRoPKchKZJhkGc37PvEVQahB74gPBYldz
   150U1JXzHTCF4gjQ+Jk+qvB6WERZGN0MuOxTV40y+BXEoJcknVZ8BKUPx
   g==;
X-CSE-ConnectionGUID: HRYfMCWtQh6wjDYTOsNSKw==
X-CSE-MsgGUID: xPXwQKGnQTy1emez2JBs+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34584271"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34584271"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:03:09 -0800
X-CSE-ConnectionGUID: dj46vlaOQZSpHRAP06J0Ng==
X-CSE-MsgGUID: DBQZQAHbSXGX1iTGsvtCMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101258743"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.115.59])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 23:03:06 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V16 4/7] perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
Date: Mon, 16 Dec 2024 09:02:40 +0200
Message-ID: <20241216070244.14450-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216070244.14450-1-adrian.hunter@intel.com>
References: <20241216070244.14450-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Display "feature is not supported" error message if aux_start_paused,
aux_pause or aux_resume result in a perf_event_open() error.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V15:
	Re-base on new API probe method of missing feature detection
	and add probe for aux_action.

Changes in V13:
	Add error message also in EOPNOTSUPP case (Leo)


 tools/perf/util/evsel.c | 98 ++++++++++++++++++++++++++++++++++++-----
 tools/perf/util/evsel.h |  1 +
 2 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0a1b797d1f00..f6bf845808d6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2145,16 +2145,17 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
-static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
+static bool __has_attr_feature(struct perf_event_attr *attr,
+			       struct perf_cpu cpu, unsigned long flags)
 {
-	int fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+	int fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
 			 /*group_fd=*/-1, flags);
 	close(fd);
 
 	if (fd < 0) {
 		attr->exclude_kernel = 1;
 
-		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
 			     /*group_fd=*/-1, flags);
 		close(fd);
 	}
@@ -2162,7 +2163,7 @@ static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
 	if (fd < 0) {
 		attr->exclude_hv = 1;
 
-		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
 			     /*group_fd=*/-1, flags);
 		close(fd);
 	}
@@ -2170,7 +2171,7 @@ static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
 	if (fd < 0) {
 		attr->exclude_guest = 1;
 
-		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
 			     /*group_fd=*/-1, flags);
 		close(fd);
 	}
@@ -2182,6 +2183,13 @@ static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
 	return fd >= 0;
 }
 
+static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
+{
+	struct perf_cpu cpu = {.cpu = -1};
+
+	return __has_attr_feature(attr, cpu, flags);
+}
+
 static void evsel__detect_missing_pmu_features(struct evsel *evsel)
 {
 	struct perf_event_attr attr = {
@@ -2270,7 +2278,65 @@ static void evsel__detect_missing_brstack_features(struct evsel *evsel)
 	errno = old_errno;
 }
 
-static bool evsel__detect_missing_features(struct evsel *evsel)
+static bool evsel__probe_aux_action(struct evsel *evsel, struct perf_cpu cpu)
+{
+	struct perf_event_attr attr = evsel->core.attr;
+	int old_errno = errno;
+
+	attr.disabled = 1;
+	attr.aux_start_paused = 1;
+
+	if (__has_attr_feature(&attr, cpu, /*flags=*/0)) {
+		errno = old_errno;
+		return true;
+	}
+
+	/*
+	 * EOPNOTSUPP means the kernel supports the feature but the PMU does
+	 * not, so keep that distinction if possible.
+	 */
+	if (errno != EOPNOTSUPP)
+		errno = old_errno;
+
+	return false;
+}
+
+static void evsel__detect_missing_aux_action_feature(struct evsel *evsel, struct perf_cpu cpu)
+{
+	static bool detection_done;
+	struct evsel *leader;
+
+	/*
+	 * Don't bother probing aux_action if it is not being used or has been
+	 * probed before.
+	 */
+	if (!evsel->core.attr.aux_action || detection_done)
+		return;
+
+	detection_done = true;
+
+	/*
+	 * The leader is an AUX area event. If it has failed, assume the feature
+	 * is not supported.
+	 */
+	leader = evsel__leader(evsel);
+	if (evsel == leader) {
+		perf_missing_features.aux_action = true;
+		return;
+	}
+
+	/*
+	 * AUX area event with aux_action must have been opened successfully
+	 * already, so feature is supported.
+	 */
+	if (leader->core.attr.aux_action)
+		return;
+
+	if (!evsel__probe_aux_action(leader, cpu))
+		perf_missing_features.aux_action = true;
+}
+
+static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu cpu)
 {
 	static bool detection_done = false;
 	struct perf_event_attr attr = {
@@ -2280,6 +2346,8 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
 	};
 	int old_errno;
 
+	evsel__detect_missing_aux_action_feature(evsel, cpu);
+
 	evsel__detect_missing_pmu_features(evsel);
 
 	if (evsel__has_br_stack(evsel))
@@ -2494,6 +2562,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int idx, thread, nthreads;
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
+	struct perf_cpu cpu;
 
 	if (evsel__is_retire_lat(evsel))
 		return tpebs_start(evsel->evlist);
@@ -2531,6 +2600,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	}
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
+		cpu = perf_cpu_map__cpu(cpus, idx);
 
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
@@ -2551,10 +2621,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
+				pid, cpu.cpu, group_fd, evsel->open_flags);
 
-			fd = sys_perf_event_open(&evsel->core.attr, pid,
-						perf_cpu_map__cpu(cpus, idx).cpu,
+			fd = sys_perf_event_open(&evsel->core.attr, pid, cpu.cpu,
 						group_fd, evsel->open_flags);
 
 			FD(evsel, idx, thread) = fd;
@@ -2570,8 +2639,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			bpf_counter__install_pe(evsel, idx, fd);
 
 			if (unlikely(test_attr__enabled())) {
-				test_attr__open(&evsel->core.attr, pid,
-						perf_cpu_map__cpu(cpus, idx),
+				test_attr__open(&evsel->core.attr, pid, cpu,
 						fd, group_fd, evsel->open_flags);
 			}
 
@@ -2626,7 +2694,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
 		goto retry_open;
 
-	if (err == -EINVAL && evsel__detect_missing_features(evsel))
+	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
 		goto fallback_missing_features;
 
 	if (evsel__precise_ip_fallback(evsel))
@@ -3585,6 +3653,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size,
 	"%s: PMU Hardware doesn't support 'aux_output' feature",
 					 evsel__name(evsel));
+		if (evsel->core.attr.aux_action)
+			return scnprintf(msg, size,
+	"%s: PMU Hardware doesn't support 'aux_action' feature",
+					evsel__name(evsel));
 		if (evsel->core.attr.sample_period != 0)
 			return scnprintf(msg, size,
 	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
@@ -3615,6 +3687,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_action)
+			return scnprintf(msg, size, "The 'aux_action' feature is not supported, update the kernel.");
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		if (!target__has_cpu(target))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 93b6244ec302..76749bb0e1a5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -207,6 +207,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool aux_action;
 	bool inherit_sample_read;
 };
 
-- 
2.43.0

