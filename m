Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7F916C87E;
	Sun, 21 Jul 2024 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721593308; cv=none; b=iXqt9sURZ+pmfgREhNm09nNX+AIAxJGCs9mmpQa8KCHUjCT24Tss4JFhWTia0xtE6VmuNiVpQBg2w6Lm6Fi5YfbkFdbZfzTskIgftSC0ucqnM+p3kIW+OgY1xXsulX47Uw1EqY4Zhw0NnkwgjWdIpauE6yBQz3YqPjEdsANf1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721593308; c=relaxed/simple;
	bh=Y8EgnpVbjnLV5HmxemU0chOkiT2j3DIAePw6Pudxt+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VzxEOJOvKJpTBzJENcBHkFq0e1Y1peOTzwaV8isGKOw1bBW2aL7s6oAcsURUldoX2YPhywI5SR3AJHg800XtlRmRfSMQ8bE6lkVVcI+bzH8+bz2xUtQGArLSNvqbogAr5FE0nCH8qWyczTANSVScWedcbpI+9NbUG/nF7BeD4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C695FEC;
	Sun, 21 Jul 2024 13:22:12 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66BFB3F73F;
	Sun, 21 Jul 2024 13:21:44 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 6/6] perf arm-spe: Support multiple Arm SPE events
Date: Sun, 21 Jul 2024 21:21:13 +0100
Message-Id: <20240721202113.380750-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721202113.380750-1-leo.yan@arm.com>
References: <20240721202113.380750-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the flag 'auxtrace' has been set for Arm SPE events, now it is ready
to use evsel__is_aux_event() to check if an event is AUX trace event or
not. Use this function to replace the old checking for only the first
Arm SPE event.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 37 ++++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index fe7942824113..d59f6ca499f2 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include <linux/zalloc.h>
 #include <time.h>
 
@@ -177,8 +178,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 {
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
-	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
-	struct evsel *evsel, *arm_spe_evsel = NULL;
+	struct evsel *evsel, *tmp;
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool privileged = perf_event_paranoid_check(-1);
 	struct evsel *tracking_evsel;
@@ -187,12 +187,12 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	sper->evlist = evlist;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == arm_spe_pmu->type) {
-			if (arm_spe_evsel) {
-				pr_err("There may be only one " ARM_SPE_PMU_NAME "x event\n");
+		if (evsel__is_aux_event(evsel)) {
+			if (!strstarts(evsel->pmu_name, ARM_SPE_PMU_NAME)) {
+				pr_err("Found unexpected auxtrace event: %s\n",
+				       evsel->pmu_name);
 				return -EINVAL;
 			}
-			arm_spe_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
 	}
@@ -257,7 +257,10 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
 			  opts->auxtrace_snapshot_size);
 
-	arm_spe_setup_evsel(arm_spe_evsel, cpus);
+	evlist__for_each_entry_safe(evlist, tmp, evsel) {
+		if (evsel__is_aux_event(evsel))
+			arm_spe_setup_evsel(evsel, cpus);
+	}
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
@@ -307,12 +310,16 @@ static int arm_spe_snapshot_start(struct auxtrace_record *itr)
 	struct arm_spe_recording *ptr =
 			container_of(itr, struct arm_spe_recording, itr);
 	struct evsel *evsel;
+	int ret = -EINVAL;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->arm_spe_pmu->type)
-			return evsel__disable(evsel);
+		if (evsel__is_aux_event(evsel)) {
+			ret = evsel__disable(evsel);
+			if (ret < 0)
+				return ret;
+		}
 	}
-	return -EINVAL;
+	return ret;
 }
 
 static int arm_spe_snapshot_finish(struct auxtrace_record *itr)
@@ -320,12 +327,16 @@ static int arm_spe_snapshot_finish(struct auxtrace_record *itr)
 	struct arm_spe_recording *ptr =
 			container_of(itr, struct arm_spe_recording, itr);
 	struct evsel *evsel;
+	int ret = -EINVAL;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->arm_spe_pmu->type)
-			return evsel__enable(evsel);
+		if (evsel__is_aux_event(evsel)) {
+			ret = evsel__enable(evsel);
+			if (ret < 0)
+				return ret;
+		}
 	}
-	return -EINVAL;
+	return ret;
 }
 
 static int arm_spe_alloc_wrapped_array(struct arm_spe_recording *ptr, int idx)
-- 
2.34.1

