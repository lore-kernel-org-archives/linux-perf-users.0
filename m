Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62792194C83;
	Fri,  9 Aug 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205709; cv=none; b=Q2NuM2ErOX+1JFYbDLlAmN+IGAFSpTz5FffsEfq/7kglfUystTfpYmJjjJ4n+SUFTYlv74cjonV4OGCjYxhYH1IfGeNZpEXSxn+aOBhLDVT6k9X7UAyqJCBcoNBp/gJ+EKS2KxDQO68tVqCySEIWNig8muO2BbwhoZM45H7oxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205709; c=relaxed/simple;
	bh=YyWvOR9uGmdxRAWpWvvQqCnyz8h2QAKQSUQZhO++sI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3t4yN9DN0oO9kplJWSHrofUYCX7aix5nzQdWQkEJyQvgtXXVXF9qy6jvsICluiyEJMS67PL9AuVY1DPJ4d1N/nBXTzQIsbioKRwl5IT5+OKkqgUeUrAQJ3+WFOfOpSRtnjmpqHa70sL70gkvle56FFcuGBkkg7hX3WRIT8Vwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7435A1692;
	Fri,  9 Aug 2024 05:15:33 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D44953F6A8;
	Fri,  9 Aug 2024 05:15:05 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 5/8] perf auxtrace: Refactor evlist__enable_event_idx()
Date: Fri,  9 Aug 2024 13:14:44 +0100
Message-Id: <20240809121447.2078084-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809121447.2078084-1-leo.yan@arm.com>
References: <20240809121447.2078084-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit splits the evlist__enable_event_idx() function into two
steps. The first step uses a new function evlist__find_cpu_map_idx() to
find the CPU map index, based on the found CPU map index or a thread map
index, it continues to call evlist__enable_event_idx() for enabling the
corresponding event.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/auxtrace.c | 42 +++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b51b98a80acf..c970024f16db 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -651,20 +651,30 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 	return -EINVAL;
 }
 
-static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel, int idx)
+static int evlist__find_cpu_map_idx(struct evlist *evlist, struct evsel *evsel,
+				    int idx)
 {
 	bool per_cpu_mmaps = !perf_cpu_map__has_any_cpu(evlist->core.user_requested_cpus);
+	struct perf_cpu evlist_cpu;
+	int cpu_map_idx;
 
-	if (per_cpu_mmaps) {
-		struct perf_cpu evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
-		int cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
+	if (!per_cpu_mmaps)
+		return -EINVAL;
 
-		if (cpu_map_idx == -1)
-			return -EINVAL;
-		return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
-	}
+	evlist_cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
+	cpu_map_idx = perf_cpu_map__idx(evsel->core.cpus, evlist_cpu);
+	if (cpu_map_idx == -1)
+		return -ENOENT;
+
+	return cpu_map_idx;
+}
 
-	return perf_evsel__enable_thread(&evsel->core, idx);
+static int evlist__enable_event_idx(struct evsel *evsel, int cpu_mode, int idx)
+{
+	if (cpu_mode)
+		return perf_evsel__enable_cpu(&evsel->core, idx);
+	else
+		return perf_evsel__enable_thread(&evsel->core, idx);
 }
 
 int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
@@ -676,9 +686,21 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 
 	evlist__for_each_entry(itr->evlist, evsel) {
 		if (evsel__is_aux_event(evsel)) {
+			int cpu_map_idx;
+
 			if (evsel->disabled)
 				return 0;
-			return evlist__enable_event_idx(itr->evlist, evsel, idx);
+
+			cpu_map_idx = evlist__find_cpu_map_idx(itr->evlist,
+							       evsel, idx);
+			/* No map is found in per CPU mmap */
+			if (cpu_map_idx == -ENOENT)
+				return cpu_map_idx;
+
+			if (cpu_map_idx >= 0)
+				return evlist__enable_event_idx(evsel, 1, cpu_map_idx);
+			else
+				return evlist__enable_event_idx(evsel, 0, idx);
 		}
 	}
 	return -EINVAL;
-- 
2.34.1

