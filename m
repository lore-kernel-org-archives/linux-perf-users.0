Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27C7188A24;
	Fri, 23 Aug 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412831; cv=none; b=XzpoT9qh3G8HskqTkTupz8da+aXj88stfjn/P0fYQStnvRZxVtuqBEGBAgScuC75V1eQ315+dYQjoP3QJM3EqECW6CCCvXhhMLnvNIr8Yi/opHv5Z1ClrLAPgCuJx8I6TQrr8/0GTnnrD1Mq58QHLG6RbZapWQRT9zpJ2kQsIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412831; c=relaxed/simple;
	bh=cMHzfQ9hXRH0a2cw3aKhfnQcf1GD+TH3ZUYtvgpZyXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YN8y1V8Ju9q0GOWg8hTmY+VxerVhRnmKQQyyU2XbsW5AYpBuNwvF5Yd0kLk9p6cH6BSZuTgF+xm8EgcFijVDJ6C8BrYsNJN5xmUVQi/uc7sBi80hTGB0uio/zRV6G+1Vy90gifdaK+SDLDzEmeRXsWzDLm/X/DalP2uuG06jd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C0D5FEC;
	Fri, 23 Aug 2024 04:34:15 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5E7D3F58B;
	Fri, 23 Aug 2024 04:33:46 -0700 (PDT)
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
Subject: [PATCH v6 8/8] perf arm-spe: Support multiple events in arm_spe_evsel_is_auxtrace()
Date: Fri, 23 Aug 2024 12:33:06 +0100
Message-Id: <20240823113306.2310957-9-leo.yan@arm.com>
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
index 138ffc71b32d..27724711e763 100644
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
+	return strstarts(evsel->name, "arm_spe");
 }
 
 static const char * const arm_spe_info_fmts[] = {
@@ -1099,7 +1097,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	int err;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == spe->pmu_type) {
+		if (arm_spe_evsel_is_auxtrace(session, evsel)) {
 			found = true;
 			break;
 		}
@@ -1284,7 +1282,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->session = session;
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
-	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 	spe->midr = midr;
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
-- 
2.34.1

