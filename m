Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F93E148820;
	Tue, 21 May 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313201; cv=none; b=TFzGpxQMkyphwg4bmUYHU+2NVjhcUySELkdClBiKyexMedSS5UPCouG43o0/K4YnGw4m1fPkUMt2vnGJp5azVoO/QHOqS1QAGl/Copk8buTt2ant/fOZAFKYxeQVPYLT/g/0THaGnc9Q2E8DWzLvjAixwgMWVuxpIYJSClJrqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313201; c=relaxed/simple;
	bh=WsqpE6hySICZuLE1ggqpieCn1M2X1N9qSkG2FYXQ0/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQB67q4V11xwYntm/ggBsZW1MxwLASXhypULmcRAypR6s4EqCM23062WF9tSmNWUh/R5q3WAmCG1I7k4+R9PxNnn5mYMkAtr4zM49S+jUPPcV0zpglL9oFsYBumTuxcuvrsE1+sbdnAozjILv4hIPV1ZZpzoXdm3IFOU/1exDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXjcyD7e; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXjcyD7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716313200; x=1747849200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WsqpE6hySICZuLE1ggqpieCn1M2X1N9qSkG2FYXQ0/I=;
  b=aXjcyD7eJV/qRnfp3MV//ynR59LdufC1OSSteVoLxamcE9B8fDWoJQ1f
   khNZmzKqTBw1qoEhodv8O2x+yn1cpxwjo+B63HLrPZE84ZafvNfjL285D
   2dU6pO/qPgew6E4MKZLy7Xdx+4dC2MJDWqoh8kYQl17pJQWDQs5gpp5Wo
   ++IWIt9uNbgCCdZnLv7/mnOfamsll5NMmXAofoytQLhpKJ6OTs6TX1Hs5
   rotw+AQWamSa86u4AiXVUmd7KyKUKIJOpCIMIhtmpO9xtfP74Fwf+rOHz
   8vvR167k/MG9SVyvewxroDDmhMsJWTCR9kl+rkkwh3mfLAwzrdJgs/470
   g==;
X-CSE-ConnectionGUID: RjPIwDfsR/eKtxidrRiZbA==
X-CSE-MsgGUID: 0dfNoopgQIuseXAdcceW4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12317667"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12317667"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 10:39:58 -0700
X-CSE-ConnectionGUID: U/ZnUg6bQiOM5wyGuvkKWQ==
X-CSE-MsgGUID: Or9MlpM2RoWwnsIdX/NUXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32924964"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa007.fm.intel.com with ESMTP; 21 May 2024 10:39:58 -0700
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
Subject: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from sampled data to evsel
Date: Tue, 21 May 2024 13:39:32 -0400
Message-ID: <20240521173952.3397644-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521173952.3397644-1-weilin.wang@intel.com>
References: <20240521173952.3397644-1-weilin.wang@intel.com>
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

In this commit, at the time when a retire_latency evsel is read, set the retire
latency value processed from the sampled data to count value. This sampled
retire latency value will be used for metric calculation and final event count
print out.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/arch/x86/util/evlist.c |  6 +++++
 tools/perf/util/evsel.c           | 44 +++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h           |  5 ++++
 3 files changed, 55 insertions(+)

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
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a0a8aee7d6b9..4d700338fc99 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -58,6 +58,7 @@
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
+#include "util/intel-tpebs.h"
 
 #include <linux/ctype.h>
 
@@ -1523,6 +1524,40 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
 }
 
+static int evsel__set_retire_lat(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	struct perf_counts_values *count;
+	struct tpebs_retire_lat *t;
+	bool found = false;
+	__u64 val;
+
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+
+	list_for_each_entry(t, &tpebs_results, nd) {
+		if (!strcmp(t->tpebs_name, evsel->name)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -1;
+
+	/*
+	 * Only set retire_latency value to the first CPU and thread.
+	 */
+	if (cpu_map_idx == 0 && thread == 0)
+		val = t->val;
+	else
+		val = 0;
+
+	count->val = val;
+	/* Set ena and run to non-zero */
+	count->ena = count->run = 1;
+	count->lost = 0;
+	return 0;
+}
+
 static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 			     u64 val, u64 ena, u64 run, u64 lost)
 {
@@ -1530,6 +1565,12 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 
 	count = perf_counts(counter->counts, cpu_map_idx, thread);
 
+	if (counter->retire_lat) {
+		evsel__set_retire_lat(counter, cpu_map_idx, thread);
+		perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
+		return;
+	}
+
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
@@ -1778,6 +1819,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__read_tool(evsel, cpu_map_idx, thread);
 
+	if (evsel__is_retire_lat(evsel))
+		return evsel__set_retire_lat(evsel, cpu_map_idx, thread);
+
 	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
 		return evsel__read_group(evsel, cpu_map_idx, thread);
 
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
 
-- 
2.43.0

