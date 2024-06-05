Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E713AD2A;
	Wed,  5 Jun 2024 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717564936; cv=none; b=feCBUhi7mYr85e5oCcVa4xlf+kh5korYvUVYoxwLTT27DDByBA42MDAWhn41z8yR9ZeS+7EBnMRrGAnRAasCtJ0Kwd9Oep6sVA+9XKzJhVtCHauc76+MKc65vAASr+o+WypbQsrY3KZRoe9dlRsq6/5G2T2TNarG0eDTPZnWCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717564936; c=relaxed/simple;
	bh=gwB0I7RkYnw4aLsoz60wFzMJXB1aUGhGB5xCjYqPql8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aozgi60J3fM3MwPWQ4cR4LL62M1yEm8aL7P0dmmcZNcHpljoCDnrcb9/wbIjTDWXG7h4xGJHvpRTn6zDBUke7pDwPq/r4XK7RIvz9Jm6CyzVmWiHn64H3A29qRHcPeuN2r0Zld2K6O2D++OE7UqST9Ty7fXbcZHe/nq3YUF7Vx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IApXlK7r; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IApXlK7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717564935; x=1749100935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwB0I7RkYnw4aLsoz60wFzMJXB1aUGhGB5xCjYqPql8=;
  b=IApXlK7ruCD4u1kCf3ovCZWXmJXT4v+lnhwjPqCqdr8oDLxtiiE7C5LI
   y4Z5T7eePO3A+DcKhlLRvdFOzp1JSsmQZ9u1ZZ5eUOaSYHCjnsikv6Uzu
   jw7VhDWwNt5xM6qlNhf+OUPvxMiP7BP4xpgCpw04Hj6keXqEiJyt2KRDO
   NRLX279Y1bEnCfitaYDQjfXgtWcEH8Zx6EEcQmxq0Uzsd78CiFMF2QeKS
   ed3HkOhVaZVXSmFBxhZkh5hZMxUrLLL/RW8d6UyvMxc6CWHE3PIc+MzUx
   /nfzUCbnFjU8EwgMoaQQ+W2hd3E2vKV4rrnUEyTj+/AGXLOJW2ed1i7M/
   w==;
X-CSE-ConnectionGUID: qBslBsjeQWaLl9X1c7rBlA==
X-CSE-MsgGUID: A+7G4f8jQcGovYoNJNiFMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25258804"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="25258804"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 22:22:11 -0700
X-CSE-ConnectionGUID: KBgZTgu0Tq6gxnj7wRiYCg==
X-CSE-MsgGUID: ulH2Iy/yQgypJ7K7Y1H/Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37525743"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa009.jf.intel.com with ESMTP; 04 Jun 2024 22:22:11 -0700
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
Subject: [RFC PATCH v11 4/8] perf stat: Plugin retire_lat value from sampled data to evsel
Date: Wed,  5 Jun 2024 01:21:45 -0400
Message-ID: <20240605052200.4143205-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605052200.4143205-1-weilin.wang@intel.com>
References: <20240605052200.4143205-1-weilin.wang@intel.com>
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
index bd3627819afe..a54806179555 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -58,6 +58,7 @@
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
+#include "util/intel-tpebs.h"
 
 #include <linux/ctype.h>
 
@@ -1523,6 +1524,11 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
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
@@ -1530,6 +1536,12 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 
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
@@ -1832,6 +1844,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__read_tool(evsel, cpu_map_idx, thread);
 
+	if (evsel__is_retire_lat(evsel))
+		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
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

