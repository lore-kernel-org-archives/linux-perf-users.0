Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A613A89A;
	Fri, 28 Jun 2024 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719557525; cv=none; b=ZR5M6n0BEhasFvG4dVEiw2/nbMI/mkrkSdntVnRrB7gSbs9mrjxycqLjTWGVT5UWT83ejrQwSQFTDeEDtF1pZRX+F7TKnXuj3Va1WIdXZ5fCpH0WRv4dXCgArQ72D6FmDe2U5O7j/de8BPCM0Bejb+DkBtqPc+0Cc8/CqhKD6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719557525; c=relaxed/simple;
	bh=RR3rwbnMC6ghBhDqx5zv3Qqug9YamguX/X6OJMJG9Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CqUsoU6c8NQfkp6kA12jwyWnGqOOmed9eI2b33eYhNIvOYRtEbqqZjUiGuQGyKB7zJzFaMPiwUUwbZYNlH7r6AKHZ60hg0egMXWBDUm5JijAvRtbQRb7L4gDrt/6HrcuZpLooT/qBOCZCiFo6SQ0uXpYnUPB5RqGjsaosivLUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oz0243M2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oz0243M2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719557524; x=1751093524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RR3rwbnMC6ghBhDqx5zv3Qqug9YamguX/X6OJMJG9Fw=;
  b=Oz0243M2BkxfsLkvmQ25OtDuQNfw0va1w9C+w7434iWNCWCqJcuQ10Vp
   jJq5UAmaBUKHPwW1iLwD607quQY2qi/7lHXXrc8dYySL54c4LPnOVKcU1
   H4yZ4FysvrqdH8BENvcnQ6RLcmZWHHUP6uvsgM4HoenvQN8Qv7EQ4qZ0J
   crktASVrZnGEXveDVmtgN8HHZXiYGZ+4ls7XIXKX4sbq6/1vxP7cid7zR
   4QAFovqjqxVwneOKahUzGrp0WWKmIgptlHNsadq21B/VcOaBjdIyklzzx
   KmR55a1ZgvBVnE9Voluk4NAv8CJm5FA30rSnshi3ii6Tcdhucp2kDtyZf
   Q==;
X-CSE-ConnectionGUID: 8ZyRaYmfRpWhis8BBqwvPQ==
X-CSE-MsgGUID: cWWIiqIORESNrqUAFk8tUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16857174"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16857174"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:52:04 -0700
X-CSE-ConnectionGUID: dX0AHA12Tyy1S+nDr9PdAg==
X-CSE-MsgGUID: MfLECR1eRSK0ZrU/H4i2Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="75386703"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:51:58 -0700
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
Subject: [PATCH V8 05/12] perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
Date: Fri, 28 Jun 2024 09:51:04 +0300
Message-Id: <20240628065111.59718-6-adrian.hunter@intel.com>
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

evsel__is_aux_event() identifies AUX area tracing selected events.

S390_CPUMSF uses a raw event type (PERF_TYPE_RAW - refer
s390_cpumsf_evsel_is_auxtrace()) not a PMU type value that could be checked
in evsel__is_aux_event(). However it sets needs_auxtrace_mmap (refer
auxtrace_record__init()), so check that first.

Currently, the features that use evsel__is_aux_event() are used only by
Intel PT, but that may change in the future.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c94a91645b21..05deea7724eb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1182,8 +1182,12 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 
 bool evsel__is_aux_event(const struct evsel *evsel)
 {
-	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+	struct perf_pmu *pmu;
 
+	if (evsel->needs_auxtrace_mmap)
+		return true;
+
+	pmu = evsel__find_pmu(evsel);
 	return pmu && pmu->auxtrace;
 }
 
-- 
2.34.1

