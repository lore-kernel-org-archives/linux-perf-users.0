Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF81757E;
	Mon, 15 Jul 2024 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059679; cv=none; b=tpwmDigtMuCWQWlBJObtvSxXErd2tCodtoZzcuEEd7OtW1XwZbo2GZIIvAYrMaJchEY2AQbc/Bru81H4bzfUVnHKAMrjpPtv5luBzDz6ZUQH0jaInf2ryNgETWhMEMKDbMah7IEUVJiUPAl/LGB7+GhMynqoskkme8YdLLTQERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059679; c=relaxed/simple;
	bh=xl/0bEpk3BRRcoORH2dbm/1s8wpRj/jEJl01LF/oJYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwbZzGQNnK5JURZgdcmhL/yi+m+H4SY+ugt0/oiGT08iTDGC4mOFHaI3e+wqUm1gUOlF+aficxA7qSS8mcubbYQ27UxPwqaZ8VCf2nGqjrGpdhZtGtXK+Dyt4B93b7sR5FY4Rl7M6NzrMReV/KyHoKFdX2hOxD33TdmbbZdTzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZG75Vz+X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZG75Vz+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721059678; x=1752595678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xl/0bEpk3BRRcoORH2dbm/1s8wpRj/jEJl01LF/oJYM=;
  b=ZG75Vz+XUyEi3y2as8uDTtQoixyH2lVWhC0DDQB7LGaGUjfpfUPt+a3u
   mEXjFVnNbFtNBX4MlIhDWWHz20rDTdzlMkx+fA2oMQDys/QSQkJMi9H3E
   DMq5D5dbmAQ7q1TNAl66fu5lNwHckn94cOuPf0KN9apNtM8v2VzS0ur8r
   ItMYAB5UtJ/5x01cbjwC2ATkg/J44XT7cFQwdUKRlF2W4DCCSLJbHS5jA
   XgUC51puE+gmJr0SDEtjBXQcPOWNecJtH/JgP/0EJNHLIS7eYMC9FDZqC
   F1eiIFyYOedQ57uCIPprZY0AKr9ayETFx8nGN7YW5C7AkYycPQQ4xcWe9
   Q==;
X-CSE-ConnectionGUID: nK9DWUsESvSw2JKfMxsnLQ==
X-CSE-MsgGUID: 4AYsv79kRUGvBmpBavcoaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="21361230"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="21361230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 09:07:55 -0700
X-CSE-ConnectionGUID: ONpEVzWrTpauaJImW+/7XA==
X-CSE-MsgGUID: L+3ArP1uS26NkQmSUB+iwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49413550"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 09:07:50 -0700
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
Subject: [PATCH V9 05/13] perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
Date: Mon, 15 Jul 2024 19:07:04 +0300
Message-Id: <20240715160712.127117-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715160712.127117-1-adrian.hunter@intel.com>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Set pmu->auxtrace on ARM/ARM64 AUX area PMUs. evsel__is_aux_event() needs
the setting to identify AUX area tracing selected events.

Currently, the features that use evsel__is_aux_event() are used only by
Intel PT, but that may change in the future.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/arch/arm/util/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 1c9541d01722..57dc94a6e38c 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -23,16 +23,19 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
+		pmu->auxtrace = true;
 		pmu->selectable = true;
 		pmu->perf_event_attr_init_default = cs_etm_get_default_config;
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
+		pmu->auxtrace = true;
 		pmu->selectable = true;
 		pmu->is_uncore = false;
 		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
 		if (strstarts(pmu->name, "arm_spe_"))
 			pmu->mem_events = perf_mem_events_arm;
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
+		pmu->auxtrace = true;
 		pmu->selectable = true;
 #endif
 	}
-- 
2.34.1

