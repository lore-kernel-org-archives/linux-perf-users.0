Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903A3C47C;
	Wed, 15 May 2024 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751897; cv=none; b=JvwUNz6kN1Uzv4dUt2LWjWge6y9sc0lR+vIomSRn0pRRhYBZd7PLGzdaje4Q+IgymG1R+QMc0h3++NZizNbFESFfG9+OXAZPDWvW8bPEwZw2IuXgdwk3FVyjObJ6YEMfCp5cRVv+mOUvO2CernfJypmvYmO7zCT/F398lUqVDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751897; c=relaxed/simple;
	bh=uBLumifDriseoh4xe0DvJei5EAwfabS8LAawzprkI1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aroJAL/+YusxtlpWxQtIGakxAJqsdsmzxkrVBLFre9GxnT7M+vMlcNqWUJzcI1K4OhKcYh+Gu/lY3Rd1sJqrnAFWfJjn0ai9r8Fx5DhvGeeJ6muRWXOuN1eU8RNzPehLCcbHVygz+xgWaf25pxnDvi8aj12cKgYsrfPWnCIPjaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/hFxV0V; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/hFxV0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715751895; x=1747287895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uBLumifDriseoh4xe0DvJei5EAwfabS8LAawzprkI1w=;
  b=h/hFxV0Vzwny4F4SJicHGP3g1BzZh6GhQmQ/NZGULuMgExb8PPgQkkNu
   WFhEzTEyY6ieIR8EyfuLbIR88Nbp7xkmuNErpP2XgHlgPvanRg5HRHFwf
   WFJIvHj4JMpkflMN2sIr5cXZaOCzy4Zcd8MExhAOmrtd9oc+rYdkw+c4J
   1GjdePiI312XRS2iCOWXQJCc+Mqd6GsqYlEXzm7GEcWFWB/byUp8ycxCe
   X0PxsdR5jA46vOTUm/+LEIoN5JFc42HIPaF476D7eO0i3LPEdkMGEc45t
   cg6FSsAmu0jHSfV2fb7RIeCHDyLVSebBtAxhhSMfZck4/0n65gNMDIdIz
   w==;
X-CSE-ConnectionGUID: f7oHBITJSMGGro0942bUYw==
X-CSE-MsgGUID: OG7rPTEwSVu1RIz7FeCQfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29298050"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29298050"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:44:52 -0700
X-CSE-ConnectionGUID: /lrm9gq1TeSFjXKTPiMy7A==
X-CSE-MsgGUID: egOcnlqBTn+ofJC0gd8vUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35469219"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 22:44:52 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v8 7/7] perf stat: Skip read retire_lat counters and plugin retire_lat data from sampled data
Date: Wed, 15 May 2024 01:44:29 -0400
Message-ID: <20240515054443.2824147-8-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515054443.2824147-1-weilin.wang@intel.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

In current :R parsing implementation, the parser would recognize events with
retire_latency modifier and insert them into the evlist like a normal event.
Ideally, we need to avoid counting these events.

In this commit, at the stage of metric calculation, the code uses sampled
retire latency value instead of counted event value.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 6 ++++++
 tools/perf/util/evsel.h           | 5 +++++
 tools/perf/util/stat-display.c    | 5 +++++
 tools/perf/util/stat-shadow.c     | 2 +-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index b1ce0c52d88d..cebdd483149e 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -89,6 +89,12 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 			return 1;
 	}
 
+	/* Retire latency event should not be group leader*/
+	if (lhs->retire_lat && !rhs->retire_lat)
+		return 1;
+	if (!lhs->retire_lat && rhs->retire_lat)
+		return -1;
+
 	/* Default ordering by insertion index. */
 	return lhs->core.idx - rhs->core.idx;
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index bd8e84954e34..aaf572317e92 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -303,6 +303,11 @@ static inline bool evsel__is_tool(const struct evsel *evsel)
 	return evsel->tool_event != PERF_TOOL_NONE;
 }
 
+static inline bool evsel__is_retire_lat(const struct evsel *evsel)
+{
+	return evsel->retire_lat;
+}
+
 const char *evsel__group_name(struct evsel *evsel);
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b9c3978cc99c..499fe0ddca93 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1013,6 +1013,9 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	/* Tool events have the software PMU but are only gathered on 1. */
 	if (evsel__is_tool(counter))
 		return true;
+	/* Retire latency events are read from sampling data. */
+	if (evsel__is_retire_lat(counter))
+		return true;
 
 	/*
 	 * Skip value 0 when it's an uncore event and the given aggr id
@@ -1653,6 +1656,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		} else {
 			print_metric_begin(config, evlist, &os, /*aggr_idx=*/0);
 			evlist__for_each_entry(evlist, counter) {
+				if (evsel__is_retire_lat(counter))
+					continue;
 				print_counter(config, counter, &os);
 			}
 			print_metric_end(config, &os);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index b97d23bfeac1..45e0b21a4724 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -384,7 +384,7 @@ static int prepare_metric(const struct metric_expr *mexp,
 		double val;
 		int source_count = 0;
 
-		if (metric_events[i]->retire_lat)
+		if (evsel__is_retire_lat(metric_events[i]))
 			continue;
 
 		if (evsel__is_tool(metric_events[i])) {
-- 
2.43.0

