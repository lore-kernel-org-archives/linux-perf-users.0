Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17312131BAF;
	Thu, 13 Jun 2024 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249802; cv=none; b=gtDDw7jpCk5cZoBofpiM6tdwxI8Bmdp6Mt3/OmL1Q8umOeOBippsyjoYoE0/4REf3Xx+bFM5psPkW7oGLCRwQyt18nWDEX1zs9xefGYNN/kHaiwQMx5F+gXNL5Fx/WEtLxP0+m5rgtvmiitEVbhOymDl5NvlkZbnoGwVjb+hJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249802; c=relaxed/simple;
	bh=d1Z57xpygWJ1WWeGDjCZfLEIqGYwjdRv4+Zd0U0TuGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QInnFEuDb/gJY2lR46cTjTjxOgwbpDf4h3Bhx7rQ+GHSemE4pMZT2YekBjxXsCZSOdhz/MVUpzGjcwFZNz06KK5Ukj4TynFVOzJ1OJuhlY6opQspga8eYGxkiBqbJYia8+xe+m+paTSmTZ8JlBX79Q8FVpkvgPINaNCu3ClnBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEFpF/Dy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEFpF/Dy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249800; x=1749785800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d1Z57xpygWJ1WWeGDjCZfLEIqGYwjdRv4+Zd0U0TuGY=;
  b=ZEFpF/DyYw53ugVpdFDePMNFT4F4yp5L42PkWKXXRFLp60oSv/z780iq
   zf9le5QkggbybjTGYct+DMrLHxHuz6DoGqRw98pIubnLKkgHATk+1ql6K
   ZFd3dygvTOAimQ6agPPwK75mcuLmKHOH3HktMQIKvkG6UgjO4Gip7tidC
   Jjdmtpmi4ZThQFK5q25ASmeusSt13q4LK1/JYIdxZ3ANhrDt65z4eX/O6
   Rz5B0MoOjeoLRZKuarYQkBdlq0BDBhnJMsHaKRLUDIe/2hCniBf27mqB7
   zSyyNQ9ZncQbExuGdovO8H7gjwbP1kU+1SQX0mvevS4KCcEc5pehfUEdt
   A==;
X-CSE-ConnectionGUID: jkjUXqX7S6ySzRbuaKK2Yg==
X-CSE-MsgGUID: lEqc5LWhQ5yAdzW5svA7+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12046722"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12046722"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:36:38 -0700
X-CSE-ConnectionGUID: c30APkv6QF2TPKcnET3A7A==
X-CSE-MsgGUID: iYHIUPh9TKeftCZHr7rkng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40100357"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jun 2024 20:36:37 -0700
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
Subject: [RFC PATCH v13 5/9] perf stat: Plugin retire_lat value from sampled data to evsel
Date: Wed, 12 Jun 2024 23:36:25 -0400
Message-ID: <20240613033631.199800-6-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613033631.199800-1-weilin.wang@intel.com>
References: <20240613033631.199800-1-weilin.wang@intel.com>
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
index e8e2ad5fc867..a6d8cf4118b1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -58,6 +58,7 @@
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
+#include "util/intel-tpebs.h"
 
 #include <linux/ctype.h>
 
@@ -1532,6 +1533,11 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
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
@@ -1539,6 +1545,12 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 
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
@@ -1831,6 +1843,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
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

