Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8B916E886;
	Tue,  6 Aug 2024 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977316; cv=none; b=bei4jojy7y6mIndS7oy594y35S12sOhyApM38hmSEvB7yniOxIO+d9156cOrPwu1didHaZr6JQ65up9IjEQHGeUjg8hz78iSNXcGdsyhuFkzs56BrE1AhvjWVG29bOZDIv7I9GbuIVBCOncCv79WHal1kc0DHu4/ie80ODr62JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977316; c=relaxed/simple;
	bh=DZ3y6rE0WtG8JAF1FkGWzLulh0ijjJQofxBt3XV1Dbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Si7SIJO/hc+clUKnZnThsa6bbhfZvoHcn8Y+teORcOLFLvEhMJV2KDI+mAf9berKPncAPHpTNAf7LLR1kqSHlEiyKYXz3UglnPwCuuvgIuEy5fVgENtQmKYdqK1AGex3e8c1ahHSnmPy0QqE3uzblsk3CuOOd0zCoxTSZSBfUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B4781063;
	Tue,  6 Aug 2024 13:48:59 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 090523F766;
	Tue,  6 Aug 2024 13:48:31 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 3/5] perf auxtrace: Refactor evlist__enable_event_idx()
Date: Tue,  6 Aug 2024 21:48:11 +0100
Message-Id: <20240806204813.722372-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806204813.722372-1-leo.yan@arm.com>
References: <20240806204813.722372-1-leo.yan@arm.com>
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
index d5015d27b6dd..174d486056e0 100644
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
@@ -675,10 +685,22 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 		return -EINVAL;
 
 	evlist__for_each_entry(itr->evlist, evsel) {
+		int cpu_map_idx;
+
 		if (evsel__is_aux_event(evsel)) {
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

