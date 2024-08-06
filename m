Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946B1BDAA3;
	Tue,  6 Aug 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959841; cv=none; b=HUuAfJ+sH553O2qrByDYmXe4XZcxaBWHVsvFNrP647Z8TaKHszs/ccyXzgYmPpsDZntbSSsV0dEd2GcBajs1oV9YJpJ55/p8FRBEJhlI9uQdry9zgrEK53Vrq8kx8YfvSfyHaqkXY1iaSU+43fTv+Cv4zifxQ2D6q1juJ/G4ruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959841; c=relaxed/simple;
	bh=rYla/CIs7On6YzggSgFMLvRtaI5JJQYxImdMCRGvFkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDewGbmHR5udYO4AdVjtH0OQXqyuFwvPxgJL/iV86AijrV4CrZFKg8NuEWfgk8mYGCL06sguHBRjU0qVF8+pkeX0vh9eNd37+Qr5aagCxvHmSdNqxzt051cJq/CiAGNNvPJg1lf+XXG0uEjnGgq0SuLWfkROnASqmpy1oH9utsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zwc3DVwW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zwc3DVwW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722959840; x=1754495840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rYla/CIs7On6YzggSgFMLvRtaI5JJQYxImdMCRGvFkc=;
  b=Zwc3DVwWcRbbiob6dmb7RutFMMbOknSI0IgvXqwuv8KeGTzfgnHIABiW
   2KSBlIvCOqN7gb6AGFPvHEO1s7xDMF1u5BnflTi/9WywqG+9yCUhPOarW
   xiRwdGa48s5k7hQftLi5te4p3deXeT2USzAmVjqzYAbeX4frDQGwOP1Hx
   hF6UAOGtyhEtCI7Fkr6BnxeOSjFUflMdN+jhGKsEJBePMPwx4e8/CjmW6
   Hoc616O7SgBEkH38ChG7bh7tABdqODcroJF70R5Hw3wG4ETqZ27Yyq9LU
   VlAna9c395nC6zExZUQTDn0Y6VrBTHhqLT6x8bf206HMbCZIJzEvkGIb7
   g==;
X-CSE-ConnectionGUID: MpotrZmgR9iFh2WPTOvHGg==
X-CSE-MsgGUID: VuUqUz+aS0udixx/dlGGEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="43514209"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="43514209"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:56:14 -0700
X-CSE-ConnectionGUID: aNbjtSaBT6C5UTVG0bTOqA==
X-CSE-MsgGUID: w0KlU80PRFK/N1EC2J5FvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56631332"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.94.248.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:56:08 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V11 07/10] perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
Date: Tue,  6 Aug 2024 18:55:11 +0300
Message-Id: <20240806155514.17900-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806155514.17900-1-adrian.hunter@intel.com>
References: <20240806155514.17900-1-adrian.hunter@intel.com>
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
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evsel.c | 10 +++++++++-
 tools/perf/util/evsel.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cc2873131093..3aa90054de97 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2078,7 +2078,13 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.branch_counters &&
+	if (!perf_missing_features.aux_pause_resume &&
+	    (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
+	     evsel->core.attr.aux_start_paused)) {
+		perf_missing_features.aux_pause_resume = true;
+		pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
+		return false;
+	} else if (!perf_missing_features.branch_counters &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
 		perf_missing_features.branch_counters = true;
 		pr_debug2("switching off branch counters support\n");
@@ -3324,6 +3330,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_pause_resume)
+			return scnprintf(msg, size, "The 'aux_pause / aux_resume' feature is not supported, update the kernel.");
 		if (perf_missing_features.aux_output)
 			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		if (!target__has_cpu(target))
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 80b5f6dd868e..0b0c847e776d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -206,6 +206,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool aux_pause_resume;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.34.1

