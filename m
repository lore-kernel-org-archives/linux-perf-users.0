Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8584B7E588;
	Fri, 31 May 2024 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135106; cv=none; b=E0iGLZTrJ8qwGO8CtDFHc9gjNSzBnGKHw86TKYJc+f6lRV0X+70Fr2D9yplZRV76gQ8M6r8/HDj7fwU9JY0raDnRJD+hFQ9hmiW09HJfd3ySMvlWm0AqjzW/mPvY7xOsQArj9Ecm6W3T8+RJ+LWZyhECyygfVsllARnJz2g4aoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135106; c=relaxed/simple;
	bh=LmPWJzCWmr0I0R2LelK/lC4wn9pT0+3isQy4N3tK83A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INXUidvJMsu+8prEb2k3wyt7WFGlPWYjjUQTLl1nZ3C27e6aIxbZ3jc6VzJLPxMEVI/LRs6pGPJtfXxDMANTf/J4lrDNU9MAitP4ysr/1xCFU1u2fQK+Kw9Qpz2ZayTP7wn+MPadPaqxHzdsdzvfRNdD3BPfkGc7PLcWBHggZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4lj1bXU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4lj1bXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717135104; x=1748671104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmPWJzCWmr0I0R2LelK/lC4wn9pT0+3isQy4N3tK83A=;
  b=g4lj1bXUDBFKOY/gdn8QpJyoJ6jRvfYwz1I/k4klOcY77pep3DR8BuqT
   sCagF41CNaxit1/aUDBXc/YebM+oP34CaEX/Mz7Vo5y6Yv5Lr8HfTm/BZ
   S83PxNLbaDq4OJotQ6CbuWkyYRpstt6gSNy1msySeD7gJpGoG61M7kQaF
   3uGjguzZWazghs2GEbTCQ7u0NoT1TX3xeUP0cNopGZsvKaMFZJAEfVXvU
   tJhkRm0GN4Za7kl6SxuOqODJhhmmxOC6i4Fvxo/wGUrPvdNxegmfqU7+o
   cXHeHm8wHqql08hZT1YBiFoHx+aLvVpG84KVFZOFyajZGTgJXFai614Zs
   A==;
X-CSE-ConnectionGUID: cl/TwGslSrulElBtLTOuRQ==
X-CSE-MsgGUID: GZWw84eSRa+MT9dEqUXEmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25068205"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="25068205"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:17 -0700
X-CSE-ConnectionGUID: o3bProXRR42dZilBbtgckQ==
X-CSE-MsgGUID: PMmNtjt5Q0WlXuWvW2QoQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40510920"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.41.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 22:58:13 -0700
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
Subject: [PATCH V7 05/12] perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
Date: Fri, 31 May 2024 08:57:24 +0300
Message-Id: <20240531055731.12541-6-adrian.hunter@intel.com>
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
index 888ce9912275..6599599db2b1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1174,8 +1174,12 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 
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

