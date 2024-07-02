Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2B191F84;
	Tue,  2 Jul 2024 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958089; cv=none; b=W6383DKENW+PKPOlDwDGPH9ejB1vmSOgZkxKN5diZBNcANnLPa9E+rqykNa9vSdb3irFWdaYw0F96CYPmKhUmuxtsfLOecazmWX9/c8hNH7CSggkwFCIvmaPIbqcgmHU3WoB7XShq95Fad9IAzW8pU8LdEZ7NJ3JwMzI14M8qA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958089; c=relaxed/simple;
	bh=UYxp0J5BBqmL4B6bO1B1wJ23uuONJPHgBsA/OrY61bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWZBgHnAG2/fS32zg5TaQPnkj6u39ZdG6YU3HwnQZ1pT7iPov2rw4ZWwImhAhZNtM1Mw53OGyuDLfXDtpU8sis3W3U2RaQIaxLk088CDj23/h9AhvC82FYaBTuYO9p14tR+IJRl1mvVpa6VJEpGj6AVNSzI5uIR+9+fCZiMfv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfNxY2qB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfNxY2qB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719958088; x=1751494088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UYxp0J5BBqmL4B6bO1B1wJ23uuONJPHgBsA/OrY61bc=;
  b=AfNxY2qBzNljYkEzeobuo2xmUuA5YzDDb+4DCfLU8PnCg9SCotZh5ZtK
   iTqPlhfzudT4Hg7pYnefq2P8GtC3K1/+Mi78g0JySJ9O9g2PNGZtz5mmT
   AXdBVMO+eKpgpkHMH4CWuiTyGJWalmvVKDOd1nAKcKTmGkZ9IR+QAAWi+
   94wqLtCAUNapogMGPgXBWAR2BHxeuR0XTcHeyGbBvMyyF5PLFVYtZJhu2
   RQ0WAaYN8q7ViPei+ktTW+zXeFh42xjsQO99/ebDPApI3ZV4JFTFEn2z4
   ukUhspR6EjCaW1btRgDX7NcrZiX3Kuz/0RFC+Q+/2y0DFaEySHIvFDdZz
   A==;
X-CSE-ConnectionGUID: TPPVPBgdRNSV9hJtjKH1/Q==
X-CSE-MsgGUID: xKriYtKGTWaspYJ8q6LkRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17296907"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17296907"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:08:05 -0700
X-CSE-ConnectionGUID: 4FJ6+7SHTzCyicIdvEUZRQ==
X-CSE-MsgGUID: 46tQyLcVTTWaqcpkBRkwNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="50888202"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa003.jf.intel.com with ESMTP; 02 Jul 2024 15:08:04 -0700
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
Subject: [RFC PATCH v15 4/8] perf stat: Plugin retire_lat value from sampled data to evsel
Date: Tue,  2 Jul 2024 18:07:51 -0400
Message-ID: <20240702220757.262825-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702220757.262825-1-weilin.wang@intel.com>
References: <20240702220757.262825-1-weilin.wang@intel.com>
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
print out. No special metric calculation and event print out code required for
retire_latency events.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/arch/x86/util/evlist.c |  6 ++++++
 tools/perf/util/evsel.c           | 15 +++++++++++++++
 tools/perf/util/evsel.h           |  5 +++++
 3 files changed, 26 insertions(+)

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
index 1d000fa2c6cf..d607056b73c9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -59,6 +59,7 @@
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
+#include "util/intel-tpebs.h"
 
 #include <linux/ctype.h>
 
@@ -1539,6 +1540,11 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
 }
 
+static int evsel__read_retire_lat(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	return tpebs_set_evsel(evsel, cpu_map_idx, thread);
+}
+
 static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 			     u64 val, u64 ena, u64 run, u64 lost)
 {
@@ -1546,6 +1552,12 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 
 	count = perf_counts(counter->counts, cpu_map_idx, thread);
 
+	if (counter->retire_lat) {
+		evsel__read_retire_lat(counter, cpu_map_idx, thread);
+		perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
+		return;
+	}
+
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
@@ -1838,6 +1850,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__read_tool(evsel, cpu_map_idx, thread);
 
+	if (evsel__is_retire_lat(evsel))
+		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
+
 	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
 		return evsel__read_group(evsel, cpu_map_idx, thread);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 14f777b9e03e..a5da4b03bb1c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -311,6 +311,11 @@ static inline bool evsel__is_tool(const struct evsel *evsel)
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

