Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF421FDF9E;
	Thu, 14 Nov 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579460; cv=none; b=fRnSuxkdkPeYfm0ZnxqcENKvNmrLHGfzALVHCc/EmE0/SAYyKNdjHfQYrkIz5Ju2Of+NPte2/ltzyyvbSUhGr08mulER3jFOGBKFt4WPbowCI37MzkSyz1sH/vDJ0VJYL/8xfI9PH3NEyHLEP5AhYSltePGvuew43xy5l7SLnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579460; c=relaxed/simple;
	bh=UGHpIc3jIe0I0zLDA7Mgwix0ULySZkjyWewX2UZidZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OajtQSSd3s+J5qHQfEmzpIwnXV20hXMM9L2zVTONyJ2zWso1tRzCgdJaE/i7pjOGVGIamynBRuPbvvrVrEglLdOJOBmaLJ6jsNvRWM4clm2sPWJWzcKVGY39/ah4e5xtb6+F4lxLQltEjLwTzs98I5gMySXfVF9AwrNGDBOA8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXUhKDa2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXUhKDa2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731579459; x=1763115459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGHpIc3jIe0I0zLDA7Mgwix0ULySZkjyWewX2UZidZ0=;
  b=HXUhKDa2KPKknpczGTj4Xt//FiELlmY95kmO79nE5YVtt2phAorGKM+u
   rMoO7Ybmw5cyew0VSy04e2OvilrKPAXFjkyxk3Xhwlb6nTEOOB+fMO5nc
   GY+x6gZguD0sUf6wwQhzCYMsKy8hUCWywjwHrs+0E0RuwXOLdloIrcqVK
   V2a+JO3M3wh85t3QRv/RK93akF7nx5smMDWJWmCK12PosNEGAWGiLIbFR
   /lrUVbfTs+zHdrXxM9UlAFdX606O6Kdas9IfFB9rImVCubf7gXNJWD9bJ
   Ue0TS7Di7XukMl21avZTFOGD7x+8eLnzIyRUr0uIsOBjKiogT0AtL1G5D
   w==;
X-CSE-ConnectionGUID: pn/tQAigSxyL912tST5zgQ==
X-CSE-MsgGUID: JUWpHm0qS0q6DoLJSyayrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31290529"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31290529"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:17:39 -0800
X-CSE-ConnectionGUID: Ur4xgTBeR8ObComI7eo5Dw==
X-CSE-MsgGUID: xhlEjJlXS2WrkPTS1SFCMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88588019"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.245.99.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 02:17:35 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V15 4/7] perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
Date: Thu, 14 Nov 2024 12:17:07 +0200
Message-ID: <20241114101711.34987-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114101711.34987-1-adrian.hunter@intel.com>
References: <20241114101711.34987-1-adrian.hunter@intel.com>
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
index bda1b7994df8..f6a5284ed5f9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2093,16 +2093,17 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
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
@@ -2110,7 +2111,7 @@ static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
 	if (fd < 0) {
 		attr->exclude_hv = 1;
 
-		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
 			     /*group_fd=*/-1, flags);
 		close(fd);
 	}
@@ -2118,7 +2119,7 @@ static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
 	if (fd < 0) {
 		attr->exclude_guest = 1;
 
-		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, cpu.cpu,
 			     /*group_fd=*/-1, flags);
 		close(fd);
 	}
@@ -2130,6 +2131,13 @@ static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
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
@@ -2218,7 +2226,65 @@ static void evsel__detect_missing_brstack_features(struct evsel *evsel)
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
@@ -2228,6 +2294,8 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
 	};
 	int old_errno;
 
+	evsel__detect_missing_aux_action_feature(evsel, cpu);
+
 	evsel__detect_missing_pmu_features(evsel);
 
 	if (evsel__has_br_stack(evsel))
@@ -2442,6 +2510,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int idx, thread, nthreads;
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
+	struct perf_cpu cpu;
 
 	if (evsel__is_retire_lat(evsel))
 		return tpebs_start(evsel->evlist);
@@ -2479,6 +2548,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	}
 
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
+		cpu = perf_cpu_map__cpu(cpus, idx);
 
 		for (thread = 0; thread < nthreads; thread++) {
 			int fd, group_fd;
@@ -2499,10 +2569,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			/* Debug message used by test scripts */
 			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				pid, perf_cpu_map__cpu(cpus, idx).cpu, group_fd, evsel->open_flags);
+				pid, cpu.cpu, group_fd, evsel->open_flags);
 
-			fd = sys_perf_event_open(&evsel->core.attr, pid,
-						perf_cpu_map__cpu(cpus, idx).cpu,
+			fd = sys_perf_event_open(&evsel->core.attr, pid, cpu.cpu,
 						group_fd, evsel->open_flags);
 
 			FD(evsel, idx, thread) = fd;
@@ -2518,8 +2587,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			bpf_counter__install_pe(evsel, idx, fd);
 
 			if (unlikely(test_attr__enabled())) {
-				test_attr__open(&evsel->core.attr, pid,
-						perf_cpu_map__cpu(cpus, idx),
+				test_attr__open(&evsel->core.attr, pid, cpu,
 						fd, group_fd, evsel->open_flags);
 			}
 
@@ -2577,7 +2645,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
 		goto retry_open;
 
-	if (err == -EINVAL && evsel__detect_missing_features(evsel))
+	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
 		goto fallback_missing_features;
 
 	if (evsel__handle_error_quirks(evsel, err))
@@ -3529,6 +3597,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
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
@@ -3559,6 +3631,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_action)
+			return scnprintf(msg, size, "The 'aux_action' feature is not supported, update the kernel.");
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		if (!target__has_cpu(target))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 04934a7af174..d703157268dc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -205,6 +205,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool aux_action;
 	bool inherit_sample_read;
 };
 
-- 
2.43.0

