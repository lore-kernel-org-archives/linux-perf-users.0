Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75D1A2540;
	Mon, 24 Jun 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267651; cv=none; b=kHR2HIFNCorIzCr+vxcPsN0l4qzSMrLF/uyT+LQiaqP4A1alzyOcO1TOk1ss/tnQ96Hk+spsrprQ4vMGd5szy66LxOI2ROPZjrq2oSnn+/YOD4jhSboQGGurMukaPrV6N+qzbvFf/rNBjlBe3OAcWsD7PxWmgeKYcDum3gyTP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267651; c=relaxed/simple;
	bh=vR8jfYXJdI15bBOehCyynFHtKG7m2066TjDODzNfBJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfZ42p+y5kGij4A1aqlGpf6zkXvY/k6OXFUh6jrcsrw2596LzRI5ZyGlH41exio1kdwvY7WWl0JU1DJpsqLj/7MWF0H49uWZfU3pOLQEnZvinxw+Mb7GmxFZSNUpkDzuEqQ0nYNkpL8Igw2Ur+ZVo5zVcfkB8g5N0uu6IJJCK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzKU+3Qf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzKU+3Qf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719267650; x=1750803650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vR8jfYXJdI15bBOehCyynFHtKG7m2066TjDODzNfBJ8=;
  b=XzKU+3QfuMlOGQooGg8rKyN8J6y65R/TwT50dQW3AKVKAAT9WtVjINUI
   3CpIX2pLqgBetATjkLycBC59/0QrZHM0P5dIZbvBDgsOg0L6Pe9NJEuvr
   W6FtTQU6kfSTeDHM74XUbkEDpwhl/PD3yMdmmG3LIs/5nVjoSPgjoCFJB
   HOx+fgSeBFDUWCC9XFgFIaMnZPNCxu3RjEK+JoKXy0HK6Ge5WoCwJ6l6Y
   D2QKAzJyuDEJwMlUMfO5vT3lRjpAdomHgBLY+nKxtjiPEUrLdYaHpwAAY
   oy4T9n1k+03Unol0gnO3GBAzXRt/SCT6OlT8NBhNotkvmU8X408JL3AfV
   A==;
X-CSE-ConnectionGUID: /PPnk6lwRu6M7RtKWgsExQ==
X-CSE-MsgGUID: Fn+Tw08WS5mONKeGwPiryw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41681617"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="41681617"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 15:20:46 -0700
X-CSE-ConnectionGUID: VMDK7RDWSQ21K5Ey6qJpSg==
X-CSE-MsgGUID: Tqc9SESSS9GX3vnxniWmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="48608227"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa004.jf.intel.com with ESMTP; 24 Jun 2024 15:20:46 -0700
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
Subject: [RFC PATCH v14 4/8] perf stat: Plugin retire_lat value from sampled data to evsel
Date: Mon, 24 Jun 2024 18:20:20 -0400
Message-ID: <20240624222026.229401-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624222026.229401-1-weilin.wang@intel.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
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
 tools/perf/util/evsel.c           | 21 +++++++++++++++++++++
 tools/perf/util/evsel.h           |  5 +++++
 3 files changed, 32 insertions(+)

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
index 06dcaa36c3f3..f7791879b661 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -58,6 +58,7 @@
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
+#include "util/intel-tpebs.h"
 
 #include <linux/ctype.h>
 
@@ -1532,6 +1533,13 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
 }
 
+#ifndef PYTHON_PERF
+static int evsel__read_retire_lat(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	return tpebs_set_evsel(evsel, cpu_map_idx, thread);
+}
+#endif
+
 static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 			     u64 val, u64 ena, u64 run, u64 lost)
 {
@@ -1539,6 +1547,14 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 
 	count = perf_counts(counter->counts, cpu_map_idx, thread);
 
+#ifndef PYTHON_PERF
+	if (counter->retire_lat) {
+		evsel__read_retire_lat(counter, cpu_map_idx, thread);
+		perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
+		return;
+	}
+#endif
+
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
@@ -1831,6 +1847,11 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__read_tool(evsel, cpu_map_idx, thread);
 
+#ifndef PYTHON_PERF
+	if (evsel__is_retire_lat(evsel))
+		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
+#endif
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

