Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EB016C867;
	Sun, 21 Jul 2024 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721593306; cv=none; b=qbra9UxjAFz94ii39kk1SXhgyQv/TCuBDcuH1w+sEQ0RZPDhJDJUvtcWwaV66dT7Xqd0Qj2S3V7ONcEYS2iReSZ62lZoWiJfSmqbuG4FiCmIWGbC5SVuV9UHFtkKgsYS3TovDLBnFlOXJakd2pjKQe9Y854MRwrT9NTOkl2b70g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721593306; c=relaxed/simple;
	bh=C8rbW6v4dP6/3H+Ayh2Gtfo2zWlROkqK1LSpR43wuIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G38I3l6J4sAYSKjcweV9y5qo5CxGm3A2JzFIdi7TVYDxpeXi96F20w6IDlYWpCnwPQRXphKUm7BMuzW9hs2VcuiL5nFaArXqFB8DwT1wPc/g84HtyEajY4V5W4Mlpp0gh0y29E/hFSqHrbSEg7qokP5dcK4JIJhbnpz4ZFzwVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82FFB1007;
	Sun, 21 Jul 2024 13:22:09 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 865DA3F73F;
	Sun, 21 Jul 2024 13:21:41 -0700 (PDT)
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
Subject: [PATCH v1 5/6] perf arm-spe: Extract evsel setting up
Date: Sun, 21 Jul 2024 21:21:12 +0100
Message-Id: <20240721202113.380750-6-leo.yan@arm.com>
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

The evsel for Arm SPE PMU needs to be set up. Extract the setting up
into a function arm_spe_setup_evsel().

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 74 +++++++++++++++-------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 0b52e67edb3b..fe7942824113 100644
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

