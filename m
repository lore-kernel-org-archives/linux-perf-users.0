Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF4116D32C
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890005; cv=none; b=bFKb7iG1tQdLLMj0lbjh119DbIvb/trL/LT3whZXOM5OnU+LC/xJe2HJ+mseS8dY/qBn0NeXlJWdmjO/wNKdqGW0LbNY42PGZNF8E/Qb9Qb4svowlc2gb9a2UQTwui56U91Fd9Q+wLIP5AizuuWArckg1Z8LW1n4MWaLIlwfGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890005; c=relaxed/simple;
	bh=u7ImsxMbaOkI3frHCewjA+EJibt/31IaDaUwb7n9s7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JG9WrjjoxjrKHcf14JldiK/T9K3/g0eXvqEczztWtiBmeEL1UfO0xVQi+daCiq5AOdFvAra8GjzD964JNCaFtpEyBUCKxfqDZOELHnmnMa4twyCtd8/l4UON+Qu61SeSa8GBiGMApSRFGPqC6NGVyyp2DqTk6suNYvA3ah7Co2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 516E11476;
	Wed, 24 Jul 2024 23:47:08 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37EC23F73F;
	Wed, 24 Jul 2024 23:46:41 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 3/4] perf arm-spe: Extract evsel setting up
Date: Thu, 25 Jul 2024 07:46:19 +0100
Message-Id: <20240725064620.1651819-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725064620.1651819-1-leo.yan@arm.com>
References: <20240725064620.1651819-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The evsel for Arm SPE PMU needs to be set up. Extract the setting up
into a function arm_spe_setup_evsel().

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 74 +++++++++++++++-------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 622fd47573ec..c228b96aa78b 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -132,6 +132,45 @@ static __u64 arm_spe_pmu__sample_period(const struct perf_pmu *arm_spe_pmu)
 	return sample_period;
 }
 
+static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
+{
+	u64 bit;
+
+	evsel->core.attr.freq = 0;
+	evsel->core.attr.sample_period = arm_spe_pmu__sample_period(evsel->pmu);
+	evsel->needs_auxtrace_mmap = true;
+
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(evsel->evlist, evsel);
+
+	/*
+	 * In the case of per-cpu mmaps, sample CPU for AUX event;
+	 * also enable the timestamp tracing for samples correlation.
+	 */
+	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
+		evsel__set_sample_bit(evsel, CPU);
+		evsel__set_config_if_unset(evsel->pmu, evsel, "ts_enable", 1);
+	}
+
+	/*
+	 * Set this only so that perf report knows that SPE generates memory info. It has no effect
+	 * on the opening of the event or the SPE data produced.
+	 */
+	evsel__set_sample_bit(evsel, DATA_SRC);
+
+	/*
+	 * The PHYS_ADDR flag does not affect the driver behaviour, it is used to
+	 * inform that the resulting output's SPE samples contain physical addresses
+	 * where applicable.
+	 */
+	bit = perf_pmu__format_bits(evsel->pmu, "pa_enable");
+	if (evsel->core.attr.config & bit)
+		evsel__set_sample_bit(evsel, PHYS_ADDR);
+}
+
 static int arm_spe_recording_options(struct auxtrace_record *itr,
 				     struct evlist *evlist,
 				     struct record_opts *opts)
@@ -144,7 +183,6 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	bool privileged = perf_event_paranoid_check(-1);
 	struct evsel *tracking_evsel;
 	int err;
-	u64 bit;
 
 	sper->evlist = evlist;
 
@@ -154,9 +192,6 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 				pr_err("There may be only one " ARM_SPE_PMU_NAME "x event\n");
 				return -EINVAL;
 			}
-			evsel->core.attr.freq = 0;
-			evsel->core.attr.sample_period = arm_spe_pmu__sample_period(arm_spe_pmu);
-			evsel->needs_auxtrace_mmap = true;
 			arm_spe_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
@@ -222,36 +257,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		pr_debug2("%sx snapshot size: %zu\n", ARM_SPE_PMU_NAME,
 			  opts->auxtrace_snapshot_size);
 
-	/*
-	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
-	 * must come first.
-	 */
-	evlist__to_front(evlist, arm_spe_evsel);
-
-	/*
-	 * In the case of per-cpu mmaps, sample CPU for AUX event;
-	 * also enable the timestamp tracing for samples correlation.
-	 */
-	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
-		evsel__set_sample_bit(arm_spe_evsel, CPU);
-		evsel__set_config_if_unset(arm_spe_pmu, arm_spe_evsel,
-					   "ts_enable", 1);
-	}
-
-	/*
-	 * Set this only so that perf report knows that SPE generates memory info. It has no effect
-	 * on the opening of the event or the SPE data produced.
-	 */
-	evsel__set_sample_bit(arm_spe_evsel, DATA_SRC);
-
-	/*
-	 * The PHYS_ADDR flag does not affect the driver behaviour, it is used to
-	 * inform that the resulting output's SPE samples contain physical addresses
-	 * where applicable.
-	 */
-	bit = perf_pmu__format_bits(arm_spe_pmu, "pa_enable");
-	if (arm_spe_evsel->core.attr.config & bit)
-		evsel__set_sample_bit(arm_spe_evsel, PHYS_ADDR);
+	arm_spe_setup_evsel(arm_spe_evsel, cpus);
 
 	/* Add dummy event to keep tracking */
 	err = parse_event(evlist, "dummy:u");
-- 
2.34.1

