Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4543613A3F0;
	Sat, 14 Sep 2024 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350926; cv=none; b=oj85vKB4O9KzXyYevMLqNWDta+jzCJqdNbUeLrhl23ugHoC9+ZbjvgKEyabRLR8c9fJ4oIQBcoqQe+Deb9I+KK9h2VKRC0l7gwUYKYl4Mlo1CM7t1+oBhMxO1mVXMbMHsOwMyExbASG5kRPq7N3vIriIpEbwLTG1BNwQGApeGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350926; c=relaxed/simple;
	bh=d96bTxV099+eX8EdDXoFempjx+NKJ/1W0EnNak7DfpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9VB2LSRldtE41gxC2cvbgJ/Z+cEV1J3zWJ3J4fzDQS1vjXD68IE5qvTPNoTYhyS3DHMW1JGc46YZjo/7ZSR2+9q1WBwN6mlUiwkTke2ZVKkoku20aprTPz6u6IAqMsHHmRTkRrR9mowSdc1UnewdaR4JlBksV8QEDsd8d8pl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C48AF1691;
	Sat, 14 Sep 2024 14:55:46 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E5DC3F66E;
	Sat, 14 Sep 2024 14:55:15 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Will Deacon <will@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 1/5] perf arm-spe: Define metadata header version 2
Date: Sat, 14 Sep 2024 22:54:54 +0100
Message-Id: <20240914215458.751802-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914215458.751802-1-leo.yan@arm.com>
References: <20240914215458.751802-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first version's metadata header structure doesn't include a field to
indicate a header version, which is not friendly for extension.

Define the metadata version 2 format with a new header structure and
extend per CPU's metadata. In the meantime, the old metadata header will
still be supported for backward compatibility.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c |  4 +--
 tools/perf/util/arm-spe.c            |  2 +-
 tools/perf/util/arm-spe.h            | 38 +++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 2be99fdf997d..c2d5c8ca4900 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -41,7 +41,7 @@ static size_t
 arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		       struct evlist *evlist __maybe_unused)
 {
-	return ARM_SPE_AUXTRACE_PRIV_SIZE;
+	return ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
 }
 
 static int arm_spe_info_fill(struct auxtrace_record *itr,
@@ -53,7 +53,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 
-	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
+	if (priv_size != ARM_SPE_AUXTRACE_V1_PRIV_SIZE)
 		return -EINVAL;
 
 	if (!session->evlist->core.nr_mmaps)
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 138ffc71b32d..70989b1bae47 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1262,7 +1262,7 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
-	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
+	size_t min_sz = ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
 	struct perf_record_time_conv *tc = &session->time_conv;
 	const char *cpuid = perf_env__cpuid(session->evlist->env);
 	u64 midr = strtol(cpuid, NULL, 16);
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 4f4900c18f3e..5416d4e1d15f 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -12,10 +12,46 @@
 enum {
 	ARM_SPE_PMU_TYPE,
 	ARM_SPE_PER_CPU_MMAPS,
+	ARM_SPE_AUXTRACE_V1_PRIV_MAX,
+};
+
+#define ARM_SPE_AUXTRACE_V1_PRIV_SIZE	\
+	(ARM_SPE_AUXTRACE_V1_PRIV_MAX * sizeof(u64))
+
+enum {
+	/*
+	 * The old metadata format (defined above) does not include a
+	 * field for version number. Version 1 is reserved and starts
+	 * from version 2.
+	 */
+	ARM_SPE_HEADER_VERSION,
+	/* Number of sizeof(u64) */
+	ARM_SPE_HEADER_SIZE,
+	/* PMU type shared by CPUs */
+	ARM_SPE_SHARED_PMU_TYPE,
+	/* Number of CPUs */
+	ARM_SPE_CPUS_NUM,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-#define ARM_SPE_AUXTRACE_PRIV_SIZE (ARM_SPE_AUXTRACE_PRIV_MAX * sizeof(u64))
+enum {
+	/* Magic number */
+	ARM_SPE_MAGIC,
+	/* CPU logical number in system */
+	ARM_SPE_CPU,
+	/* Number of parameters */
+	ARM_SPE_CPU_NR_PARAMS,
+	/* CPU MIDR */
+	ARM_SPE_CPU_MIDR,
+	/* Associated PMU type */
+	ARM_SPE_CPU_PMU_TYPE,
+	/* Minimal interval */
+	ARM_SPE_CAP_MIN_IVAL,
+	ARM_SPE_CPU_PRIV_MAX,
+};
+
+#define ARM_SPE_HEADER_CURRENT_VERSION	2
+
 
 union perf_event;
 struct perf_session;
-- 
2.34.1

