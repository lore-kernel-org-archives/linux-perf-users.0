Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4398C195F3B;
	Fri,  9 Aug 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205715; cv=none; b=QmzMITV5FKe3MIa3JaThDki+NZHB49yI4MrsABEiyYCoWUSPbTtM36h0SDCR7GM0Fwt8h44326k2H2Msynoa06h8u1zSy1HFTa2SSgDKnwGy35wATRepL4oUfp2l5BUIH8rrrrN09bY7rWdUUz/YtNHPNKdxLIJopRX+0+13X38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205715; c=relaxed/simple;
	bh=XxpPFAiZoGA4uzQEKtkMCrfMKV9LBjZfTjcn4vL39NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jIYyoJDx8S8uczHgCNUGQjMsLKAL5iKP+z+e2wFRW26OhN5J0CeY+/LdeagLT3lOuskUZ1lGNCwnzVsY9GCye5EGfe97dbx8fwwPLKX1eBLe5StBChOGvpph6ATRKu139VFPCULbZhcfJ7hNYURNF5LwNjiTHdy6rO5EOMRCbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AD7B1756;
	Fri,  9 Aug 2024 05:15:39 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EB2743F6A8;
	Fri,  9 Aug 2024 05:15:11 -0700 (PDT)
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
Subject: [PATCH v4 8/8] perf arm-spe: Support multiple events in arm_spe_evsel_is_auxtrace()
Date: Fri,  9 Aug 2024 13:14:47 +0100
Message-Id: <20240809121447.2078084-9-leo.yan@arm.com>
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

The 'pmu_type' field is an unique value and cannot support multiple PMU
events.

The arm_spe_evsel_is_auxtrace() function changes to compare PMU name to
decide if it is a Arm SPE event. This leads to the 'pmu_type' field is
no longer used, remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index afbd5869f6bf..7c27d5179470 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
@@ -45,7 +46,6 @@ struct arm_spe {
 	u32				auxtrace_type;
 	struct perf_session		*session;
 	struct machine			*machine;
-	u32				pmu_type;
 	u64				midr;
 
 	struct perf_tsc_conversion	tc;
@@ -1053,12 +1053,10 @@ static void arm_spe_free(struct perf_session *session)
 	free(spe);
 }
 
-static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
+static bool arm_spe_evsel_is_auxtrace(struct perf_session *session __maybe_unused,
 				      struct evsel *evsel)
 {
-	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe, auxtrace);
-
-	return evsel->core.attr.type == spe->pmu_type;
+	return strstarts(evsel->pmu_name, ARM_SPE_PMU_NAME);
 }
 
 static const char * const arm_spe_info_fmts[] = {
@@ -1128,7 +1126,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	int err;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == spe->pmu_type) {
+		if (arm_spe_evsel_is_auxtrace(session, evsel)) {
 			found = true;
 			break;
 		}
@@ -1313,7 +1311,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->session = session;
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
-	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 	spe->midr = midr;
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
-- 
2.34.1

