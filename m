Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D792187FEA;
	Fri, 23 Aug 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412820; cv=none; b=nr4/1KzBzO51mr7WsiwpDIw2eSMokZnNJE4j0OsOxViBdvekEArbC+v2DExRIl7IMtbocJeJT99m5LsqROrAQTBt/B7pIzSDjd7cHUcjhw4mvO/alaNOWGxxiMTkDuXXKGiyKpEd/EYgtUTKofVEhv3JHZXCn7IimuCP8d7c/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412820; c=relaxed/simple;
	bh=H6w10jYTrJ+KZDCrCKg26+egc1UhDEhCUqlEYNIWxOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmY+lg8aLg5Nya5rNQjeq3P5DJkr7xHzpEatRG/cY7GO4/tAxxjObxWudgHZtsFFgApk7x9qI18vtzTv/AzBfko6vyTd4IwG/Fr9lpHG4vv2C78TAfws4Md2jDTL65mNNtzFkcgZxz+UpLDqUrtA/5+ZppHnlgEUjVYhIQZsu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE6EDDA7;
	Fri, 23 Aug 2024 04:34:04 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74F6D3F58B;
	Fri, 23 Aug 2024 04:33:36 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v6 4/8] perf auxtrace: Introduce auxtrace_record__validate_events()
Date: Fri, 23 Aug 2024 12:33:02 +0100
Message-Id: <20240823113306.2310957-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823113306.2310957-1-leo.yan@arm.com>
References: <20240823113306.2310957-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A prerequisite for multiple AUX events is that the AUX events cannot
overlap CPU maps. The reason is that every CPU has only one AUX trace
buffer and maps it to an unique buffer index for CPU and system tracing
mode.

To prevent the case of CPU maps overlapping occurring within multiple
AUX events, the auxtrace_record__validate_events() function is
introduced. It iterates through all AUX events and returns failure if
it detects CPU maps overlapping.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/builtin-record.c |  4 +++
 tools/perf/util/auxtrace.c  | 64 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h  |  7 ++++
 3 files changed, 75 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..2c618efba97d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -862,6 +862,10 @@ static int record__auxtrace_init(struct record *rec)
 
 	auxtrace_regroup_aux_output(rec->evlist);
 
+	err = auxtrace_validate_events(rec->evlist);
+	if (err)
+		return err;
+
 	return auxtrace_parse_filters(rec->evlist);
 }
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ca8682966fae..87e4f21b6edf 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2828,6 +2828,70 @@ int auxtrace_parse_filters(struct evlist *evlist)
 	return 0;
 }
 
+int auxtrace_validate_events(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	struct perf_cpu_map *cpu_map = NULL;
+	struct perf_cpu_map *cpu_map_intersect = NULL;
+	struct perf_cpu_map *cpu_map_merged = NULL;
+	int ret = 0;
+
+	if (!evlist)
+		return 0;
+
+	/*
+	 * Currently the tool only supports multiple AUX events without
+	 * overlapping CPU maps and every CPU has its unique AUX buffer
+	 * for CPU or system mode tracing.
+	 *
+	 * Returns failure if detects CPU maps overlapping.
+	 */
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel__is_aux_event(evsel))
+			continue;
+
+		if (perf_cpu_map__is_empty(evsel->pmu->cpus))
+			continue;
+
+		cpu_map_intersect = perf_cpu_map__intersect(cpu_map, evsel->pmu->cpus);
+		if (cpu_map_intersect) {
+			perf_cpu_map__put(cpu_map_intersect);
+			pr_err("Doesn't support AUX events with overlapping CPU masks\n");
+			ret = -EINVAL;
+			break;
+		}
+		perf_cpu_map__put(cpu_map_intersect);
+
+		cpu_map_merged = perf_cpu_map__merge(cpu_map, evsel->pmu->cpus);
+		if (!cpu_map_merged) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		/* Update the CPU maps after merging */
+		perf_cpu_map__put(cpu_map);
+		cpu_map = cpu_map_merged;
+	}
+
+	if (!ret)
+		goto out;
+
+	/* If fails, dump CPU maps for debugging */
+	evlist__for_each_entry(evlist, evsel) {
+		char buf[200];
+
+		if (!evsel__is_aux_event(evsel))
+			continue;
+
+		cpu_map__snprint(evsel->pmu->cpus, buf, sizeof(buf));
+		pr_debug("AUX event [%s]'s cpu map is: %s\n", evsel->pmu->name, buf);
+	}
+
+out:
+	perf_cpu_map__put(cpu_map);
+	return ret;
+}
+
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, const struct perf_tool *tool)
 {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a1895a4f530b..67a74ad0c383 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -636,6 +636,7 @@ void addr_filters__exit(struct addr_filters *filts);
 int addr_filters__parse_bare_filter(struct addr_filters *filts,
 				    const char *filter);
 int auxtrace_parse_filters(struct evlist *evlist);
+int auxtrace_validate_events(struct evlist *evlist);
 
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, const struct perf_tool *tool);
@@ -875,6 +876,12 @@ int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
 	return 0;
 }
 
+static inline
+int auxtrace_validate_events(struct evlist *evlist __maybe_unused)
+{
+	return 0;
+}
+
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 			struct auxtrace_mmap_params *mp,
 			void *userpg, int fd);
-- 
2.34.1

