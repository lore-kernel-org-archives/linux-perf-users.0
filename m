Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638B20ADD8;
	Fri, 11 Oct 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633899; cv=none; b=AV6ybIRwDnqvCMrFIoRmkLT2E+XxvISdbF6O2Qszkioa/ZT642QmjPPNII2HlDnivdIvZ4Saa2aeev5XeL19Shp/aJWVAi+TY6JT4iZy6jTWqo3yZlSkjgqLkXiKq4r5qBYnjukx0/0aE9SHanOEOajdvBm6dukjYe0X4pCrpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633899; c=relaxed/simple;
	bh=fPKofGPlkjVRHCiWiVxlKsRzmgwhXPYXJij6RS0Tj7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MC5BUYpfB5dYasIEq/sSEAYk7pXDdU1j5+Kldpcq99xZWPoHgkFgQoDRHRCYe6I4YqAba5QevLbDS6OdfFqELMu2Ydmf560DruujmTW4jc/sRLo/0IMhJ+LEGaqqsu7iyn5SiOFW/DyeJBfMAxRjSlQFtf2UOXgH+DnZVyB5kA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tl9ghV5h; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl9ghV5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728633899; x=1760169899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPKofGPlkjVRHCiWiVxlKsRzmgwhXPYXJij6RS0Tj7M=;
  b=Tl9ghV5h3/sDLxGGnGZJeywN6pIBac9Z+ZbB0KIwdYFJPebnV0RuU1E6
   kYsoF6XvVA5wimTETPF1XgKc8BCeNAaUUlY8ZvtWKaeWSe2Gdsd8104/H
   o6Krf9FfhshFhpBSseXUpx8gLAPdg3OW9ehNUH5HSoTmh3JzkPSqJpqOz
   l8sbLFmPUkIi9IOycqPNiAEl9C341d4JcqgjQc5KWXPxfUf5jahdojzpO
   fYyHn2JwVTGoL0Z6WwpN9zgj9Rw+WhwkLFObxf41QlAK9ikIeWO9/P54I
   HQJsB4R72Hp4bzpdv4oh90AGSShRfrVs5c7SFe3YDq+cPUBA87krlwSJB
   A==;
X-CSE-ConnectionGUID: ppN1XCjgQnuF6Vf3jlcbjw==
X-CSE-MsgGUID: Q/aXAj5gQParkA46D8Q9PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="30899109"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="30899109"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 01:04:58 -0700
X-CSE-ConnectionGUID: J5IO7o50RmSuBhw2cJqLgw==
X-CSE-MsgGUID: zT8JVa1JSsOk2mFmAreTXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="81829187"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2024 01:04:55 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 2/2] perf x86/topdown: Refine helper arch_is_topdown_metrics()
Date: Fri, 11 Oct 2024 11:02:07 +0000
Message-Id: <20241011110207.1032235-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
References: <20241011110207.1032235-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leverage the existed function perf_pmu__name_from_config() to check if
an event is topdown metrics event. perf_pmu__name_from_config() goes
through the defined formats and figures out the config of pre-defined
topdown events.

This avoids to figure out the config of topdown pre-defined events with
hard-coded format strings "event=" and "umask=" and provides more
flexibility.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/arch/x86/util/topdown.c | 39 +++++++-----------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
index cb2c64928bc4..f63747d0abdf 100644
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -41,43 +41,22 @@ bool arch_is_topdown_slots(const struct evsel *evsel)
 	return false;
 }
 
-static int compare_topdown_event(void *vstate, struct pmu_event_info *info)
-{
-	int *config = vstate;
-	int event = 0;
-	int umask = 0;
-	char *str;
-
-	if (!strcasestr(info->name, "topdown"))
-		return 0;
-
-	str = strcasestr(info->str, "event=");
-	if (str)
-		sscanf(str, "event=%x", &event);
-
-	str = strcasestr(info->str, "umask=");
-	if (str)
-		sscanf(str, "umask=%x", &umask);
-
-	if (event == 0 && *config == (event | umask << 8))
-		return 1;
-
-	return 0;
-}
-
 bool arch_is_topdown_metrics(const struct evsel *evsel)
 {
-	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 	int config = evsel->core.attr.config;
+	const char *name_from_config;
+	struct perf_pmu *pmu;
 
-	if (!pmu || !pmu->is_core)
+	/* All topdown events have an event code of 0. */
+	if ((config & 0xFF) != 0)
 		return false;
 
-	if (perf_pmu__for_each_event(pmu, false, &config,
-				     compare_topdown_event))
-		return true;
+	pmu = evsel__find_pmu(evsel);
+	if (!pmu || !pmu->is_core)
+		return false;
 
-	return false;
+	name_from_config = perf_pmu__name_from_config(pmu, config);
+	return name_from_config && strcasestr(name_from_config, "topdown");
 }
 
 /*
-- 
2.40.1

