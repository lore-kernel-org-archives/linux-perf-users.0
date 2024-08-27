Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0FC1D1F60;
	Tue, 27 Aug 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777087; cv=none; b=mbw5ec/TC8Yq0SNLtALKEx6lxqqbBb5xscapT6muQIGtmND1epUacXkzNWwIq+UQiR/dd+AHUzVMvCAZSsVvwhyg9zaMmb12kWd1cV0CmgVsphLgQAnMxmYB1nWQxeIGLKyul85bZCt/+z/28TYYpGh8iOpBcKS9ilhFpyET6dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777087; c=relaxed/simple;
	bh=Yx1/eeMFtrkQb8jXlUjvHxpXhc00/yH+KkRyKEXgz/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5PpBzcGG4KcUaE6Q2XZpZFvc9idFEbxTOGMgCqvU2w+xLcaQK0HOiCt6miK6bBHB7zqS1DWuBBKSBPWdrhijeQME6Pq2PILXwuzvXjkwRoAzLj1zBm0F08odryq+rp52Nyh/clt+ueE0rjV2DCPhQCruYHR0zk9tG6jrwFN1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4673FDA7;
	Tue, 27 Aug 2024 09:45:11 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED06A3F762;
	Tue, 27 Aug 2024 09:44:42 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 5/9] perf arm-spe: Extend meta data header for version 2
Date: Tue, 27 Aug 2024 17:44:13 +0100
Message-Id: <20240827164417.3309560-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827164417.3309560-1-leo.yan@arm.com>
References: <20240827164417.3309560-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit extends the meta data header structure for version 2.

The first version's header structure doesn't include a field to indicate
the header's version, adds a new field for it. And extends to support
per CPU's meta data. Add macros for metadata header size and per CPU
data size, and update the code with these macros.

No functional change.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c |  4 ++--
 tools/perf/util/arm-spe.c            |  2 +-
 tools/perf/util/arm-spe.h            | 34 +++++++++++++++++++++++++++-
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 7880190c3dd6..3e7f62bac2e0 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -42,7 +42,7 @@ static size_t
 arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		       struct evlist *evlist __maybe_unused)
 {
-	return ARM_SPE_AUXTRACE_PRIV_SIZE;
+	return ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
 }
 
 static int arm_spe_info_fill(struct auxtrace_record *itr,
@@ -54,7 +54,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->pmu[0];
 
-	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
+	if (priv_size != ARM_SPE_AUXTRACE_V1_PRIV_SIZE)
 		return -EINVAL;
 
 	if (!session->evlist->core.nr_mmaps)
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 3f8695fe6a20..1e87342f4bd8 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1260,7 +1260,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
-	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
+	size_t min_sz = ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
 	struct perf_record_time_conv *tc = &session->time_conv;
 	const char *cpuid = perf_env__cpuid(session->evlist->env);
 	u64 midr = strtol(cpuid, NULL, 16);
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index e1327e1b3fec..5d587a8e3cf8 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -12,10 +12,42 @@
 enum {
 	ARM_SPE_PMU_TYPE,
 	ARM_SPE_PER_CPU_MMAPS,
+	/*
+	 * The initial version doesn't have version number, so version 1 is
+	 * reserved and the header version starts from 2.
+	 */
+	ARM_SPE_HEADER_VERSION,
+	ARM_SPE_CPU_NUM,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-#define ARM_SPE_AUXTRACE_PRIV_SIZE (ARM_SPE_AUXTRACE_PRIV_MAX * sizeof(u64))
+enum {
+	ARM_SPE_CPU,
+	ARM_SPE_CPU_MIDR,
+	ARM_SPE_CPU_PMU_TYPE,
+	ARM_SPE_CAP_MIN_IVAL,
+	ARM_SPE_CAP_LDS,
+	ARM_SPE_PER_CPU_PRIV_MAX,
+};
+
+#define ARM_SPE_HEADER_CURRENT_VERSION	2
+
+#define ARM_SPE_METADATA_SIZE(cnt)	((cnt) * sizeof(u64))
+
+#define ARM_SPE_AUXTRACE_V1_PRIV_MAX		\
+	(ARM_SPE_PER_CPU_MMAPS + 1)
+#define ARM_SPE_AUXTRACE_V1_PRIV_SIZE		\
+	ARM_SPE_METADATA_SIZE(ARM_SPE_AUXTRACE_V1_PRIV_MAX)
+
+#define ARM_SPE_AUXTRACE_V2_PRIV_MAX		\
+	(ARM_SPE_CPU_NUM + 1)
+#define ARM_SPE_AUXTRACE_V2_PRIV_SIZE		\
+	ARM_SPE_METADATA_SIZE(ARM_SPE_AUXTRACE_V2_PRIV_MAX)
+
+#define ARM_SPE_AUXTRACE_V2_PRIV_PER_CPU_MAX	\
+	(ARM_SPE_CAP_LDS + 1)
+#define ARM_SPE_AUXTRACE_V2_PER_CPU_SIZE	\
+	ARM_SPE_METADATA_SIZE(ARM_SPE_AUXTRACE_V2_PRIV_PER_CPU_MAX)
 
 union perf_event;
 struct perf_session;
-- 
2.34.1

