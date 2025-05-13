Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE11CDFCE;
	Tue, 13 May 2025 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747178300; cv=none; b=V5k9x6a1tP0V11GeI1nhDQVe2fpljV2vz+VMdFZE1ILyrA6x/YG+DDrdwfB0lIGNeeek1bFuompGStzdkn1lzVwXqR6BBrQo2U8Y/SaGJjQLqXUpsmw6tqv1JFSSeqtLlkrsNlREU31wYYvcCgRLVX0P6kaBauLDTqHUOgI+HhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747178300; c=relaxed/simple;
	bh=RUjw3k3z3/ZbWS5MXky60/tqgnoqetBxZfmp6jc5/lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIzViXu9hS1xW1cSRYwYNufA5fZ67P6fNYJI9p/HMquDY6ml/zw3D09Y/kdZtNf4/RgK2K13NjzMRgQj4thF0YB67dr+rvbvL+6pZEGEQtUjpdcIu9azLPOlF2zkqRgENOQE4HGAFIgueDxtG2x7ddlRrEpLRfuuFg3aFkKsaYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDiPdEwC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDiPdEwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747178299; x=1778714299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RUjw3k3z3/ZbWS5MXky60/tqgnoqetBxZfmp6jc5/lU=;
  b=MDiPdEwCk2QVTOfrcD73dcqATcNei0DOtSP7NLxIzGHxzCyYqmggWd7b
   CBwiYDIKJ7UeSSt/7RTyAYf0jvfKGISyUld8QvIoJD9qoUe5NS+btNmFD
   dJNR0YiVen8UPNDZLAuY9bltiM6joGKF2lsOy69p0e+ZpVPVzZawQN1yH
   Tn7aZrFNaEODDu83JCRQEy5DaeFNHyH+dUgTO39225YlTn6zo7l5B2XZr
   eOQFbPZD3WHu3YtpNrK7ZUHw/GtLFS7bXjXZF5itS202QoIXoP7dRYLnj
   YqSR+aOtnsVsiBLne9JSeIowwXBavkO0p9l69w5YwhaAkwXCv5Bhe/iUO
   Q==;
X-CSE-ConnectionGUID: dn/nYDmJT+6UofxLDlqe4w==
X-CSE-MsgGUID: wzw85yAUSC+Ps7xNGe+fsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="60453296"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="60453296"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 16:18:18 -0700
X-CSE-ConnectionGUID: gywbClBtTEWFpUsPJ2M8Qg==
X-CSE-MsgGUID: pAQnA8OyQLOahSEwpRx9QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="137901066"
Received: from tfalcon-desk.amr.corp.intel.com (HELO tfalcon-desk.attlocal.net) ([10.124.222.10])
  by fmviesa007.fm.intel.com with ESMTP; 13 May 2025 16:18:17 -0700
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
Subject: [PATCH 1/2 v1] perf: move perf_pmus__find_core_pmu() prototype to pmus.h
Date: Tue, 13 May 2025 18:18:12 -0500
Message-ID: <20250513231813.13846-1-thomas.falcon@intel.com>
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
2.49.0

