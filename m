Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA31494BB;
	Wed, 25 Sep 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294038; cv=none; b=J/6ns3sSGuRjGjCAL4IjhbMRngV1HvYFJ6Bcbb+T/fc6+Rkzxit5WHtvHLPVRtPbLKZx1EYIFoQLy4Q614aJzohTvdIM4yNyVsT+Z/vhsbXc0yjf083y8cdqlq10l6xO9m/3A2TugEPeTXnBwlarc+meUKnw1ayirnWZwLNl25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294038; c=relaxed/simple;
	bh=nAUhPuhlSPAQZG/JZFwPNxlaDFCicwpSIukdsNOdHeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rq5wDXYDY0ztpCsItehgmOg78XG2iZ+rYULPkxWFxgFvzpHX1dYNfAn0ZU15iXbrhfEmncSCj2aQC40zmWsDgBGOraKQUpY4KwaA3C5eMGyCOybNUOGHDVP6buC8pEskWR644r/Q4G1+seWHXnnn8094lhdFTMyziPEpLnfYtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D19D150C;
	Wed, 25 Sep 2024 12:54:25 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64D583F64C;
	Wed, 25 Sep 2024 12:53:54 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 2/5] perf: Release old CPU maps after merging
Date: Wed, 25 Sep 2024 20:53:22 +0100
Message-Id: <20240925195325.426533-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925195325.426533-1-leo.yan@arm.com>
References: <20240925195325.426533-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After CPU maps are merged, the old CPU map will not automatically
released.

This commit adds a new variable to record old CPU map, after merging the
new allocated map is returned, and release the old CPU map.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/lib/perf/evlist.c      | 4 ++++
 tools/perf/util/mem-events.c | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c6d67fc9e57e..37920e0b0cd6 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -36,6 +36,8 @@ void perf_evlist__init(struct perf_evlist *evlist)
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 					  struct perf_evsel *evsel)
 {
+	struct perf_cpu_map *old_all_cpus;
+
 	if (evsel->system_wide) {
 		/* System wide: set the cpu map of the evsel to all online CPUs. */
 		perf_cpu_map__put(evsel->cpus);
@@ -75,7 +77,9 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		evsel->threads = perf_thread_map__get(evlist->threads);
 	}
 
+	old_all_cpus = evlist->all_cpus;
 	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
+	perf_cpu_map__put(old_all_cpus);
 }
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 051feb93ed8d..016a1f4adb5d 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -257,7 +257,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 	int i = *argv_nr;
 	const char *s;
 	char *copy;
-	struct perf_cpu_map *cpu_map = NULL;
+	struct perf_cpu_map *cpu_map = NULL, *old_cpu_map;
 
 	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
 		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
@@ -283,7 +283,9 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 			rec_argv[i++] = "-e";
 			rec_argv[i++] = copy;
 
+			old_cpu_map = cpu_map;
 			cpu_map = perf_cpu_map__merge(cpu_map, pmu->cpus);
+			perf_cpu_map__put(old_cpu_map);
 		}
 	}
 
-- 
2.34.1

