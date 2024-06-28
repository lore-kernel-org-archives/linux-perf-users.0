Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1413C9CF;
	Fri, 28 Jun 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557519; cv=none; b=ImAmwZC+tSpZDkc7znVakEo79CpYcLu+oNIf2BJixKFnJyvTotrVS/wGCEeD0NIkHK8cQ1q1nZ7qWUTdMuyGAFuruHJCUEtvqTPC5AmLKQcR3ues0U1tj1JwWITlgO304dIYtHf1VD0YzFOYFC8/I/6KFqSBP91En3gvAwHuh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557519; c=relaxed/simple;
	bh=UTYI9X6QTifs4NJwp7dVMi/w2wY+nJ8OweDviCzYQvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzRh58/o5FARizKUGkrRVPjF4ri/qFNgvhEO1Ab1H29NgFo+thZVZvX/jsFQt8nk95u57as3g7lzg8EtS4nyf6VdUMFzbGGdUv0eQz78qS2UaaGDaMOREeb/dCtopPejinO5tJW+jhLG8761szHVi0KV2njlZ1wsouYa5K5qHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1+pHXaV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1+pHXaV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719557518; x=1751093518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTYI9X6QTifs4NJwp7dVMi/w2wY+nJ8OweDviCzYQvI=;
  b=B1+pHXaVDxanawyg3zjPCOF3GL1xLMDsfmSBxBrXj4f8yurtLh9jEZvj
   j4pv1x4LMl9NNDgZiuPDONiV9ah/Ne/U02pxeL26lzOLE0EobJUIce+6V
   AnAfMEsR50elrHo17NekBSukLwad6I5l8ANu/29YQDof65i8U+LvxXKJ/
   ZJWgdBhLDLBANWCOJoCzMAE9cjSfYpC/WPoI9EwmPDgA5AgNOOXiyZdJE
   dCL/H7KAjUj9JKTI8BuqVToNHkvqDuk1upkSzVGNRIWs62VcCobPMN73A
   FhB0MvAnbBrAqLaBeyAZBGDuB/mp/id7FkTPAWymFmprbtoaJoMCuPUVC
   g==;
X-CSE-ConnectionGUID: fhhMaL17QB6xW/Ivwmf2+g==
X-CSE-MsgGUID: sPj2WRF8Qd+XCLfZXN3GaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16857162"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16857162"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:51:58 -0700
X-CSE-ConnectionGUID: HPTirA3FTImAVSVacaACdQ==
X-CSE-MsgGUID: 8hnEsJLtSICwoTjCYiLROg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="75386696"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:51:51 -0700
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
Subject: [PATCH V8 04/12] perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
Date: Fri, 28 Jun 2024 09:51:03 +0300
Message-Id: <20240628065111.59718-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628065111.59718-1-adrian.hunter@intel.com>
References: <20240628065111.59718-1-adrian.hunter@intel.com>
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
index 6b544edbd3f6..df0a85dd42d2 100644
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
 		if (!strcmp(pmu->name, "arm_spe_0"))
 			pmu->mem_events = perf_mem_events_arm;
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
+		pmu->auxtrace = true;
 		pmu->selectable = true;
 #endif
 	}
-- 
2.34.1

