Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5847A16B732;
	Tue,  6 Aug 2024 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977313; cv=none; b=ZHdjEFEfq4XbZ48ztLAV7aevkFIAbnGi9zMD61p3+LbBEGyvA1cpb/i27RnuhQCCvuMTEfHhlecOndA6nmR9kx54ssxP+nziF/2d0vPYPpsFpmqYg6MePOQJk/MXXoRk4HCJX4cB1WM/Pbyf6I5w7krl6sli3EDP9a38SWX43ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977313; c=relaxed/simple;
	bh=Nt4nsFyNDaQfQjk/HxmeQajOc3GiEinL/BUMrviln+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvocedzTTosdVud21HOFoSVbyZEFpWsBFlXO4pbnbGommB0mo/K7E0lnseIco2WHRazPpKYT9afVbUFkSTHJkSCbYJmcHUGZUBfQ5+Q/kisXB4y5yVOftVzODTieZF0inQI22sT1Zl7m36V5QW4Q6JsjCsgFSnWSVVvzTRLgcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EB85113E;
	Tue,  6 Aug 2024 13:48:57 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E071A3F766;
	Tue,  6 Aug 2024 13:48:29 -0700 (PDT)
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
Subject: [PATCH v3 2/5] perf auxtrace: Introduce auxtrace_record__validate_events()
Date: Tue,  6 Aug 2024 21:48:10 +0100
Message-Id: <20240806204813.722372-3-leo.yan@arm.com>
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
index 72345d1e54b0..dffb56052219 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -853,6 +853,10 @@ static int record__auxtrace_init(struct record *rec)
 
 	auxtrace_regroup_aux_output(rec->evlist);
 
+	err = auxtrace_validate_events(rec->evlist);
+	if (err)
+		return err;
+
 	return auxtrace_parse_filters(rec->evlist);
 }
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 03462ff346e7..d5015d27b6dd 100644
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
 			    struct perf_sample *sample, struct perf_tool *tool)
 {
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index f13c2de17653..9fd5095894de 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -634,6 +634,7 @@ void addr_filters__exit(struct addr_filters *filts);
 int addr_filters__parse_bare_filter(struct addr_filters *filts,
 				    const char *filter);
 int auxtrace_parse_filters(struct evlist *evlist);
+int auxtrace_validate_events(struct evlist *evlist);
 
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, struct perf_tool *tool);
@@ -873,6 +874,12 @@ int auxtrace_parse_filters(struct evlist *evlist __maybe_unused)
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

