Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355228AAF8;
	Thu, 12 Jun 2025 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746232; cv=none; b=EDx/F6cu31vL2lXg76UuSjmnqLVRygIeOHXd37Zk9Z2a+r3VEbRFUa4gDTclqUZSXx5J+SMUhz2AryQU6ytzNIVFr3Rh3zlwn2Lq/dEmsikd9R0MkQFlb57hB/ysXtpuBjDAFKwNZr17ZF5xe65qOisKRjUz8ke856xusKASJFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746232; c=relaxed/simple;
	bh=Xw8NY++yvCtE0FcxweWC9uIfkONuXmW62OOgQjcK/0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzXdTWqsdKTsrlJ5GI/rceMdx0vJlij5IHUd0KIKeIJl0A+DsjlzfBqUAwTnEjxSgES15sRZNDpHn0dnd4o77s07PKUianpU8A9/cNlHS7plmmRlwBY/H7tOAIztINtScIXDBEMi741xwVEC20VneZZyCXusGHJSK22ZYDRVHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elzle4GN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elzle4GN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749746231; x=1781282231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xw8NY++yvCtE0FcxweWC9uIfkONuXmW62OOgQjcK/0M=;
  b=elzle4GNVDLpf+ShgnW2OlIlSUDI3F2Iu6uB/HchDD9gtr7RX6BPk2VY
   PulDR2v0YL7HiXcRm0MzH8JwVzyRkNNBNMFXmcxZHl+G0UBMNmGhjCt4v
   6hvNQyvzlUMhCNJOu/zcjXOohB5tV+tQ/BUCMmAFHd62VGcodtay/QJHC
   +9ZPQ2dZjKPlrowitOZQO/58HpG8dFticBMDlVWYcZUX0+hln/qsiGF1F
   cT2kCVJMurEXkuPQevv7J/S5XjA4LuMli8DTJIJzevCM6fGtJ7NucyGcd
   dgIrVmuy0QiY1Una5iRgFCtUW4FQMCv+lCm2mOtnWzTy1HD253UsvByXr
   g==;
X-CSE-ConnectionGUID: B4WZH9A/QjCYcrJNJV+5mg==
X-CSE-MsgGUID: 8z1+5kLvRBSH1+jLsAoyYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="54567941"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="54567941"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:37:10 -0700
X-CSE-ConnectionGUID: uC4aU3sfSWGvSMezSo5w0w==
X-CSE-MsgGUID: o5UMFk9XTy6hFZ5ICd9ITQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148474615"
Received: from ldmartin-desk2.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.125.111.204])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 09:37:09 -0700
From: Thomas Falcon <thomas.falcon@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: [PATCH v4 1/2] perf: move perf_pmus__find_core_pmu() prototype to pmus.h
Date: Thu, 12 Jun 2025 11:36:58 -0500
Message-ID: <20250612163659.1357950-1-thomas.falcon@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_pmus__find_core_pmu() is implemented in util/pmus.c but its
prototpye is in util/pmu.h. Move it to util/pmus.h.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/pmu.h  | 1 -
 tools/perf/util/pmus.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a1fdd6d50c53..d38a63ba4583 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -298,7 +298,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 				  bool eager_load);
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
-struct perf_pmu *perf_pmus__find_core_pmu(void);
 
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 bool perf_pmu__is_fake(const struct perf_pmu *pmu);
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 8def20e615ad..d6a8d95af376 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -33,5 +33,6 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(int hwmon_dir,
 					       const char *sysfs_name,
 					       const char *name);
 struct perf_pmu *perf_pmus__fake_pmu(void);
+struct perf_pmu *perf_pmus__find_core_pmu(void);
 
 #endif /* __PMUS_H */
-- 
2.48.1

