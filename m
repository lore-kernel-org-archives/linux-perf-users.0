Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125111AE875;
	Wed, 16 Oct 2024 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059845; cv=none; b=vFMv5mxt8+93g0Ygc4xLInIE6ayblx3jYDJeWIaheOH1p2L1QXt3wbLIeX5/p6y9cBxNPRyhAOwqQKmBlOi3AnRxs2moIUKeXc2MdwtGRJ/w4aMN1j3TUyXlJxcMP131ZN9UqNXRpTHjzjqNgPfSJv2maACIo0emJ0+BoG1GKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059845; c=relaxed/simple;
	bh=wOC3wbvjULyv4qDchNgQPs64pdP2NWEZY6UxX/KhnY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn4A8U31kyE1DAdvTPviS/jbaHoptZKeM41HXhXoFIqSS9Gw4nHHiDbFWGd3OxjaTDeZ4h9qWbJVS3AeHLA7eT3XQwS8kbmTO/Q8zQWMgaR6DhdWd4TNdDs+z4q2mvfhkGR2fx+YkUppXY0X9seMDgfI03/TWORDKBRE4kQM3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkFkL5Ny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkFkL5Ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1562FC4CECE;
	Wed, 16 Oct 2024 06:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059844;
	bh=wOC3wbvjULyv4qDchNgQPs64pdP2NWEZY6UxX/KhnY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkFkL5NyKDNqFYu6TvS0q0Df5FoTKf/epGP2DGVTPAYMoXVRjiDJXsr3PYeUn2DxS
	 6m3tvadJkscj2stJ2ti/CX68yr1O8dfqFm/Ao4DwJhR9WlKooDmGKkNO48HEPY+quG
	 m7E5/vkt+T1BA5rUmw/JiGcCt5hQSekcfaXoc6PF7S14Kltf7Gi+P07N+KLtcBmZlh
	 8T4afVLlivrAhv1TTYm6+SNXOzmPD5zjvxKCeCWwmCLkaG00YBzSyitdQWWz4SBA/m
	 8rfcmJ8SNEKIzCmW07okWk/de3L3t+2SD7gsRfmJk+q40MdOBq6epwftVjSe+AIUaF
	 KziClYXQZxgWA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v5 5/9] perf tools: Detect missing kernel features properly
Date: Tue, 15 Oct 2024 23:23:55 -0700
Message-ID: <20241016062359.264929-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241016062359.264929-1-namhyung@kernel.org>
References: <20241016062359.264929-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The evsel__detect_missing_features() is to check if the attributes of
the evsel is supported or not.  But it checks the attribute based on the
given evsel, it might miss something if the attr doesn't have the bit or
give incorrect results if the event is special.

Also it maintains the order of the feature that was added to the kernel
which means it can assume older features should be supported once it
detects the current feature is working.  To minimized the confusion and
to accurately check the kernel features, I think it's better to use a
software event and go through all the features at once.

Also make the function static since it's only used in evsel.c.

Acked-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 403 ++++++++++++++++++++++++++++++----------
 tools/perf/util/evsel.h |   1 -
 tools/perf/util/pmu.h   |   4 +
 3 files changed, 307 insertions(+), 101 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 353b8da972bcfc54..a7213cfa75f31150 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -19,6 +19,7 @@
 #include <linux/zalloc.h>
 #include <sys/ioctl.h>
 #include <sys/resource.h>
+#include <sys/syscall.h>
 #include <sys/types.h>
 #include <dirent.h>
 #include <stdlib.h>
@@ -1964,125 +1965,327 @@ int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return err;
 }
 
-bool evsel__detect_missing_features(struct evsel *evsel)
+static bool has_attr_feature(struct perf_event_attr *attr, unsigned long flags)
 {
+	int fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+			 /*group_fd=*/-1, flags);
+	close(fd);
+
+	if (fd < 0) {
+		attr->exclude_kernel = 1;
+
+		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+			     /*group_fd=*/-1, flags);
+		close(fd);
+	}
+
+	if (fd < 0) {
+		attr->exclude_hv = 1;
+
+		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+			     /*group_fd=*/-1, flags);
+		close(fd);
+	}
+
+	if (fd < 0) {
+		attr->exclude_guest = 1;
+
+		fd = syscall(SYS_perf_event_open, attr, /*pid=*/0, /*cpu=*/-1,
+			     /*group_fd=*/-1, flags);
+		close(fd);
+	}
+
+	attr->exclude_kernel = 0;
+	attr->exclude_guest = 0;
+	attr->exclude_hv = 0;
+
+	return fd >= 0;
+}
+
+static void evsel__detect_missing_pmu_features(struct evsel *evsel)
+{
+	struct perf_event_attr attr = {
+		.type = evsel->core.attr.type,
+		.config = evsel->core.attr.config,
+		.disabled = 1,
+	};
+	struct perf_pmu *pmu = evsel->pmu;
+	int old_errno;
+
+	old_errno = errno;
+
+	if (pmu == NULL)
+		pmu = evsel->pmu = evsel__find_pmu(evsel);
+
+	if (pmu == NULL || pmu->missing_features.checked)
+		goto out;
+
 	/*
 	 * Must probe features in the order they were added to the
-	 * perf_event_attr interface.
+	 * perf_event_attr interface.  These are PMU specific limitation
+	 * so we can detect with the given hardware event and stop on the
+	 * first one succeeded.
 	 */
-	if (!perf_missing_features.inherit_sample_read &&
-	    evsel->core.attr.inherit && (evsel->core.attr.sample_type & PERF_SAMPLE_READ)) {
-		perf_missing_features.inherit_sample_read = true;
-		pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
-		return true;
-	} else if (!perf_missing_features.branch_counters &&
-	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
-		perf_missing_features.branch_counters = true;
-		pr_debug2("switching off branch counters support\n");
+
+	/* Please add new feature detection here. */
+
+	attr.exclude_guest = 1;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	pmu->missing_features.exclude_guest = true;
+	pr_debug2("switching off exclude_guest for PMU %s\n", pmu->name);
+
+found:
+	pmu->missing_features.checked = true;
+out:
+	errno = old_errno;
+}
+
+static void evsel__detect_missing_brstack_features(struct evsel *evsel)
+{
+	static bool detection_done = false;
+	struct perf_event_attr attr = {
+		.type = evsel->core.attr.type,
+		.config = evsel->core.attr.config,
+		.disabled = 1,
+		.sample_type = PERF_SAMPLE_BRANCH_STACK,
+		.sample_period = 1000,
+	};
+	int old_errno;
+
+	if (detection_done)
+		return;
+
+	old_errno = errno;
+
+	/*
+	 * Must probe features in the order they were added to the
+	 * perf_event_attr interface.  These are PMU specific limitation
+	 * so we can detect with the given hardware event and stop on the
+	 * first one succeeded.
+	 */
+
+	/* Please add new feature detection here. */
+
+	attr.branch_sample_type = PERF_SAMPLE_BRANCH_COUNTERS;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.branch_counters = true;
+	pr_debug2("switching off branch counters support\n");
+
+	attr.branch_sample_type = PERF_SAMPLE_BRANCH_HW_INDEX;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.branch_hw_idx = true;
+	pr_debug2("switching off branch HW index support\n");
+
+	attr.branch_sample_type = PERF_SAMPLE_BRANCH_NO_CYCLES | PERF_SAMPLE_BRANCH_NO_FLAGS;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.lbr_flags = true;
+	pr_debug2_peo("switching off branch sample type no (cycles/flags)\n");
+
+found:
+	detection_done = true;
+	errno = old_errno;
+}
+
+static bool evsel__detect_missing_features(struct evsel *evsel)
+{
+	static bool detection_done = false;
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_TASK_CLOCK,
+		.disabled = 1,
+	};
+	int old_errno;
+
+	evsel__detect_missing_pmu_features(evsel);
+
+	if (evsel__has_br_stack(evsel))
+		evsel__detect_missing_brstack_features(evsel);
+
+	if (detection_done)
+		goto check;
+
+	old_errno = errno;
+
+	/*
+	 * Must probe features in the order they were added to the
+	 * perf_event_attr interface.  These are kernel core limitation
+	 * not PMU-specific so we can detect with a software event and
+	 * stop on the first one succeeded.
+	 */
+
+	/* Please add new feature detection here. */
+
+	attr.inherit = true;
+	attr.sample_type = PERF_SAMPLE_READ;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.inherit_sample_read = true;
+	pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
+	attr.inherit = false;
+	attr.sample_type = 0;
+
+	attr.read_format = PERF_FORMAT_LOST;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.read_lost = true;
+	pr_debug2("switching off PERF_FORMAT_LOST support\n");
+	attr.read_format = 0;
+
+	attr.sample_type = PERF_SAMPLE_WEIGHT_STRUCT;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.weight_struct = true;
+	pr_debug2("switching off weight struct support\n");
+	attr.sample_type = 0;
+
+	attr.sample_type = PERF_SAMPLE_CODE_PAGE_SIZE;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.code_page_size = true;
+	pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support\n");
+	attr.sample_type = 0;
+
+	attr.sample_type = PERF_SAMPLE_DATA_PAGE_SIZE;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.data_page_size = true;
+	pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support\n");
+	attr.sample_type = 0;
+
+	attr.cgroup = 1;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.cgroup = true;
+	pr_debug2_peo("Kernel has no cgroup sampling support\n");
+	attr.cgroup = 0;
+
+	attr.aux_output = 1;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.aux_output = true;
+	pr_debug2_peo("Kernel has no attr.aux_output support\n");
+	attr.aux_output = 0;
+
+	attr.bpf_event = 1;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.bpf = true;
+	pr_debug2_peo("switching off bpf_event\n");
+	attr.bpf_event = 0;
+
+	attr.ksymbol = 1;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.ksymbol = true;
+	pr_debug2_peo("switching off ksymbol\n");
+	attr.ksymbol = 0;
+
+	attr.write_backward = 1;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.write_backward = true;
+	pr_debug2_peo("switching off write_backward\n");
+	attr.write_backward = 0;
+
+	attr.use_clockid = 1;
+	attr.clockid = CLOCK_MONOTONIC;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.clockid = true;
+	pr_debug2_peo("switching off clockid\n");
+	attr.use_clockid = 0;
+	attr.clockid = 0;
+
+	if (has_attr_feature(&attr, /*flags=*/PERF_FLAG_FD_CLOEXEC))
+		goto found;
+	perf_missing_features.cloexec = true;
+	pr_debug2_peo("switching off cloexec flag\n");
+
+	attr.mmap2 = 1;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.mmap2 = true;
+	pr_debug2_peo("switching off mmap2\n");
+	attr.mmap2 = 0;
+
+	/* set this unconditionally? */
+	perf_missing_features.sample_id_all = true;
+	pr_debug2_peo("switching off sample_id_all\n");
+
+	attr.inherit = 1;
+	attr.read_format = PERF_FORMAT_GROUP;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.group_read = true;
+	pr_debug2_peo("switching off group read\n");
+	attr.inherit = 0;
+	attr.read_format = 0;
+
+found:
+	detection_done = true;
+	errno = old_errno;
+
+check:
+	if (evsel->core.attr.inherit &&
+	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
+	    perf_missing_features.inherit_sample_read)
 		return true;
-	} else if (!perf_missing_features.read_lost &&
-	    (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
-		perf_missing_features.read_lost = true;
-		pr_debug2("switching off PERF_FORMAT_LOST support\n");
+
+	if ((evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) &&
+	    perf_missing_features.branch_counters)
 		return true;
-	} else if (!perf_missing_features.weight_struct &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT)) {
-		perf_missing_features.weight_struct = true;
-		pr_debug2("switching off weight struct support\n");
+
+	if ((evsel->core.attr.read_format & PERF_FORMAT_LOST) &&
+	    perf_missing_features.read_lost)
 		return true;
-	} else if (!perf_missing_features.code_page_size &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)) {
-		perf_missing_features.code_page_size = true;
-		pr_debug2_peo("Kernel has no PERF_SAMPLE_CODE_PAGE_SIZE support, bailing out\n");
-		return false;
-	} else if (!perf_missing_features.data_page_size &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
-		perf_missing_features.data_page_size = true;
-		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
-		return false;
-	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
-		perf_missing_features.cgroup = true;
-		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
-		return false;
-	} else if (!perf_missing_features.branch_hw_idx &&
-	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)) {
-		perf_missing_features.branch_hw_idx = true;
-		pr_debug2("switching off branch HW index support\n");
+
+	if ((evsel->core.attr.sample_type & PERF_SAMPLE_WEIGHT_STRUCT) &&
+	    perf_missing_features.weight_struct)
 		return true;
-	} else if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
-		perf_missing_features.aux_output = true;
-		pr_debug2_peo("Kernel has no attr.aux_output support, bailing out\n");
-		return false;
-	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
-		perf_missing_features.bpf = true;
-		pr_debug2_peo("switching off bpf_event\n");
+
+	if (evsel->core.attr.use_clockid && evsel->core.attr.clockid != CLOCK_MONOTONIC &&
+	    !perf_missing_features.clockid) {
+		perf_missing_features.clockid_wrong = true;
 		return true;
-	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
-		perf_missing_features.ksymbol = true;
-		pr_debug2_peo("switching off ksymbol\n");
+	}
+
+	if (evsel->core.attr.use_clockid && perf_missing_features.clockid)
 		return true;
-	} else if (!perf_missing_features.write_backward && evsel->core.attr.write_backward) {
-		perf_missing_features.write_backward = true;
-		pr_debug2_peo("switching off write_backward\n");
-		return false;
-	} else if (!perf_missing_features.clockid_wrong && evsel->core.attr.use_clockid) {
-		perf_missing_features.clockid_wrong = true;
-		pr_debug2_peo("switching off clockid\n");
+
+	if ((evsel->open_flags & PERF_FLAG_FD_CLOEXEC) &&
+	    perf_missing_features.cloexec)
 		return true;
-	} else if (!perf_missing_features.clockid && evsel->core.attr.use_clockid) {
-		perf_missing_features.clockid = true;
-		pr_debug2_peo("switching off use_clockid\n");
+
+	if (evsel->core.attr.mmap2 && perf_missing_features.mmap2)
 		return true;
-	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
-		perf_missing_features.cloexec = true;
-		pr_debug2_peo("switching off cloexec flag\n");
+
+	if ((evsel->core.attr.branch_sample_type & (PERF_SAMPLE_BRANCH_NO_FLAGS |
+						    PERF_SAMPLE_BRANCH_NO_CYCLES)) &&
+	    perf_missing_features.lbr_flags)
 		return true;
-	} else if (!perf_missing_features.mmap2 && evsel->core.attr.mmap2) {
-		perf_missing_features.mmap2 = true;
-		pr_debug2_peo("switching off mmap2\n");
+
+	if (evsel->core.attr.inherit && (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
+	    perf_missing_features.group_read)
 		return true;
-	} else if (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) {
-		if (evsel->pmu == NULL)
-			evsel->pmu = evsel__find_pmu(evsel);
-
-		if (evsel->pmu)
-			evsel->pmu->missing_features.exclude_guest = true;
-		else {
-			/* we cannot find PMU, disable attrs now */
-			evsel->core.attr.exclude_host = false;
-			evsel->core.attr.exclude_guest = false;
-		}
 
-		if (evsel->exclude_GH) {
-			pr_debug2_peo("PMU has no exclude_host/guest support, bailing out\n");
-			return false;
-		}
-		if (!perf_missing_features.exclude_guest) {
-			perf_missing_features.exclude_guest = true;
-			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
-		}
+	if (evsel->core.attr.ksymbol && perf_missing_features.ksymbol)
 		return true;
-	} else if (!perf_missing_features.sample_id_all) {
-		perf_missing_features.sample_id_all = true;
-		pr_debug2_peo("switching off sample_id_all\n");
+
+	if (evsel->core.attr.bpf_event && perf_missing_features.bpf)
 		return true;
-	} else if (!perf_missing_features.lbr_flags &&
-			(evsel->core.attr.branch_sample_type &
-			 (PERF_SAMPLE_BRANCH_NO_CYCLES |
-			  PERF_SAMPLE_BRANCH_NO_FLAGS))) {
-		perf_missing_features.lbr_flags = true;
-		pr_debug2_peo("switching off branch sample type no (cycles/flags)\n");
+
+	if ((evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX) &&
+	    perf_missing_features.branch_hw_idx)
 		return true;
-	} else if (!perf_missing_features.group_read &&
-		    evsel->core.attr.inherit &&
-		   (evsel->core.attr.read_format & PERF_FORMAT_GROUP) &&
-		   evsel__is_group_leader(evsel)) {
-		perf_missing_features.group_read = true;
-		pr_debug2_peo("switching off group read\n");
+
+	if (evsel->core.attr.sample_id_all && perf_missing_features.sample_id_all)
 		return true;
-	} else {
-		return false;
-	}
+
+	return false;
 }
 
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9fcaf417b277859e..04934a7af174524e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -343,7 +343,6 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 void evsel__close(struct evsel *evsel);
 int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
-bool evsel__detect_missing_features(struct evsel *evsel);
 
 bool evsel__precise_ip_fallback(struct evsel *evsel);
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e400db9e9eb1581a..b86b3c3685a23cfb 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -170,6 +170,10 @@ struct perf_pmu {
 		 * exclude_host.
 		 */
 		bool exclude_guest;
+		/**
+		 * @checked: Are the missing features checked?
+		 */
+		bool checked;
 	} missing_features;
 
 	/**
-- 
2.47.0.rc1.288.g06298d1525-goog

