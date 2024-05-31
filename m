Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE97D3F8;
	Fri, 31 May 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135103; cv=none; b=dxvAccLBorWtdPsPY4d89DmodXCW3TU4WMRVIkBdxCuElUhXLhdjIyhd2GXWD5fUs/w9kBFD8+iO+yqhGlp4GJACemZrQ1ziZFAJ+mexGiaIlFgwWUJ7du5ZN4djV0V8bcPgLTgCaHvReFPtiVeDw8sWBCYzjtxnI1egTK+dLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135103; c=relaxed/simple;
	bh=UW2BCplhMWf0Uk9H/TC84K3bNxl7b2FFw/QfP+F2heE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2lWwoPvC4UF9NhPvJ7imnBZ40Ge2/hE5mm36c3jlUv4c3MAI95IHF3RpjRtvL2C1qx4hYqDpqTfC8oMot0TJz5Qg5skITrqcKprLHc8Wi1Or5uExAOMFhwLeLDo3aHdHq6aYnGPGZ/zJOj/ykXlj3vUxjuhZ2lqN5N1ZB5hofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLCKt+6W; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLCKt+6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717135102; x=1748671102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UW2BCplhMWf0Uk9H/TC84K3bNxl7b2FFw/QfP+F2heE=;
  b=dLCKt+6W2vxdGqMHzj6Fbr/35H+0Zw7HoZ7ITdhZhg5K4Wkssip47w/+
   Hld05HmqNgD/l2RXuCrnbeDkmgeXgTT4k5pKs+Br9zSGhaCX4HCPW5BTh
   7MvSOzYN+e5+fPjpHrWHNWUG7JcCw6S7ICL2V2CdH1OpslQNr/zCg990N
   XjULCTaFsmkOM7U3M2OhM4gMcdfbxGW4DnPEApMV8rZ/xoootkEHkhfjH
   EtJCAYjr8d/c0B4q5gkqc12OuubQlxACrXZ7mrahDl7bBf4zcqnTqJCB0
   rKOELJTfN5IaRMgthiT6+k1+r1MkJjnPvj2pjPxuZmHsRTzKxAfw1+P1f
   Q==;
X-CSE-ConnectionGUID: Mau2IoiGTRmzdtWg25vZFw==
X-CSE-MsgGUID: FN1BPlvIS1qyp6JGJ1Ht5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25068174"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25068174"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:12 -0700
X-CSE-ConnectionGUID: twGzDCCdSUaAUrILk06/KA==
X-CSE-MsgGUID: OJ3TFkroQBCSQJo1IKuUsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40510896"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.41.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:08 -0700
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
Subject: [PATCH V7 04/12] perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
Date: Fri, 31 May 2024 08:57:23 +0300
Message-Id: <20240531055731.12541-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531055731.12541-1-adrian.hunter@intel.com>
References: <20240531055731.12541-1-adrian.hunter@intel.com>
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
index 8b7cb68ba1a8..668a4310cb69 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -20,16 +20,19 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
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

