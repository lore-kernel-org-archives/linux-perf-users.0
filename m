Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CB4D8D1;
	Mon, 15 Jul 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059682; cv=none; b=ptdH+5HyscZ3WxBsWgGUA5YdaoryL5Ts4WJPKzW4sNv3SfDyrsLTPggeva9JRmb6hqWnQkidfa3YCuFEZVvp9EsYWeECXzy8Br6tyV40TIvSS7jtOqLT7i0OZYg7J2hdVBJHipmaPL68/uXL9W/GXfAWzIqF8kRjpRZt2X9lcDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059682; c=relaxed/simple;
	bh=THudwkVwuPwa7x07vorLWh22uq9Bq8o+/y8n/tytTj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jjv8wtA0Pvk31NCdEiIEDdwRlyQhpJsavje9qcnwa1JALQFwWx2WenRdFbIfKOFxIulLWlRDD+kKtPbfRA6mlJFIUzI9ro3HFcs5wCFUNrnBGDM/gUj9pYPtVY6HPNTl+VA0DF92e1dOTixtV8fBViw/spK6tWOheKVfjSR+xcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNsjAkJf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNsjAkJf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721059681; x=1752595681;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THudwkVwuPwa7x07vorLWh22uq9Bq8o+/y8n/tytTj8=;
  b=lNsjAkJfzziVNAZlf/BrmQ/vzCCjEgV5t4hjxohFplaLM00P0aVw6FFk
   XqBKZOKNpg9GlY8MWGrCew7eym3G/8euoSSKN4qqOvpExslPoVEZqV1Ds
   HKgDePONuW1fFQrLtt0gvfkQILrCf69GxaETtB0hCJDmZ8V5E7MvVX+i6
   QIJqVaks1VtAmBHAxIxNwc4ED5MWjnJ19aT0C6erapO3HedTus2aKdTTS
   fh7vnZRoJQ1q88O+q8oQ9pKT3Qd3Z0vQZtp+cM4RwOi5Y5BXJqCiA5meV
   PpL3YG626XqUQm9zqKXkDH3/ibuIIhu6AKfaONuc5286p2EcLr10SJaYz
   A==;
X-CSE-ConnectionGUID: /AprmalZTseXnT8E4euWLw==
X-CSE-MsgGUID: THnRBJkZREWQ6Uz7XJjOzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="21361247"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="21361247"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 09:08:00 -0700
X-CSE-ConnectionGUID: AdDkuYaGSKyrgmo3i5sSLg==
X-CSE-MsgGUID: wHGiEGZSSgC47ZqGGYJl8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49413563"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 09:07:55 -0700
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
Subject: [PATCH V9 06/13] perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
Date: Mon, 15 Jul 2024 19:07:05 +0300
Message-Id: <20240715160712.127117-7-adrian.hunter@intel.com>
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
index 986166bc7c78..0b38c51bd6eb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1199,8 +1199,12 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 
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

