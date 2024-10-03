Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E41AC891;
	Thu,  3 Oct 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981004; cv=none; b=GSeGZvIKIP2eATITQNZk554f9U4QnCvQy+voKTsn2fSMRz7jw80syqtCoV80lyYJQungebquLmrl1dt9FxI5LijRYECfXw3o5J6Y27z4weoFNJrxvjoxID066ithQa/5mPRHSCOfN10oM6HXgwv1u7aG7y/9xqeo4ZFVrqEsd8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981004; c=relaxed/simple;
	bh=lyphz1EPh8Qt2lMXrF1Pu2CTR2pWFAvY8Rn8Vq96Jw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rtNCwHQ6J99sKigVKkNTKKZ7nC2S0ZNX5X2CdMShj0SBBrRFWRYA+CRyExGxtBiejsBRp66jRk46zkuI3xdBOcO94prFdFJAwiQScaZmUx4QjT/jhwg71a00jX5A2hGKcXKK4zY677ViLL3p1IRzxJ4L2+TLRY0iMitPI/ayM0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 394D4339;
	Thu,  3 Oct 2024 11:43:52 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A583B3F58B;
	Thu,  3 Oct 2024 11:43:20 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 3/5] perf arm-spe: Save per CPU information in metadata
Date: Thu,  3 Oct 2024 19:43:00 +0100
Message-Id: <20241003184302.190806-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003184302.190806-1-leo.yan@arm.com>
References: <20241003184302.190806-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the Arm SPE information on a per-CPU basis. This approach is easier
in the decoding phase for retrieving metadata based on the CPU number of
every Arm SPE record.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 83 +++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 81d5c07380a4..28b35463d274 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -26,6 +26,8 @@
 #include "../../../util/arm-spe.h"
 #include <tools/libc_compat.h> // reallocarray
 
+#define ARM_SPE_CPU_MAGIC		0x1010101010101010ULL
+
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
 
@@ -77,14 +79,70 @@ arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	return size;
 }
 
+static int arm_spe_save_cpu_header(struct auxtrace_record *itr,
+				   struct perf_cpu cpu, __u64 data[])
+{
+	struct arm_spe_recording *sper =
+			container_of(itr, struct arm_spe_recording, itr);
+	struct perf_pmu *pmu = NULL;
+	struct perf_pmu tmp_pmu;
+	char cpu_id_str[16];
+	char *cpuid = NULL;
+	u64 val;
+
+	snprintf(cpu_id_str, sizeof(cpu_id_str), "%d", cpu.cpu);
+	tmp_pmu.cpus = perf_cpu_map__new(cpu_id_str);
+	if (!tmp_pmu.cpus)
+		return -ENOMEM;
+
+	/* Read CPU MIDR */
+	cpuid = perf_pmu__getcpuid(&tmp_pmu);
+
+	/* The CPU map will not be used anymore, release it */
+	perf_cpu_map__put(tmp_pmu.cpus);
+
+	if (!cpuid)
+		return -ENOMEM;
+	val = strtol(cpuid, NULL, 16);
+
+	data[ARM_SPE_MAGIC] = ARM_SPE_CPU_MAGIC;
+	data[ARM_SPE_CPU] = cpu.cpu;
+	data[ARM_SPE_CPU_NR_PARAMS] = ARM_SPE_CPU_PRIV_MAX - ARM_SPE_CPU_MIDR;
+	data[ARM_SPE_CPU_MIDR] = val;
+
+	/* Find the associate Arm SPE PMU for the CPU */
+	if (perf_cpu_map__has(sper->arm_spe_pmu->cpus, cpu))
+		pmu = sper->arm_spe_pmu;
+
+	if (!pmu) {
+		/* No Arm SPE PMU is found */
+		data[ARM_SPE_CPU_PMU_TYPE] = ULLONG_MAX;
+		data[ARM_SPE_CAP_MIN_IVAL] = 0;
+	} else {
+		data[ARM_SPE_CPU_PMU_TYPE] = pmu->type;
+
+		if (perf_pmu__scan_file(pmu, "caps/min_interval", "%lu", &val) != 1)
+			val = 0;
+		data[ARM_SPE_CAP_MIN_IVAL] = val;
+	}
+
+	free(cpuid);
+	return ARM_SPE_CPU_PRIV_MAX;
+}
+
 static int arm_spe_info_fill(struct auxtrace_record *itr,
 			     struct perf_session *session,
 			     struct perf_record_auxtrace_info *auxtrace_info,
 			     size_t priv_size)
 {
+	int i, ret;
+	size_t offset;
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+	struct perf_cpu_map *cpu_map;
+	struct perf_cpu cpu;
+	__u64 *data;
 
 	if (priv_size != arm_spe_info_priv_size(itr, session->evlist))
 		return -EINVAL;
@@ -92,10 +150,31 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 	if (!session->evlist->core.nr_mmaps)
 		return -EINVAL;
 
+	cpu_map = arm_spe_find_cpus(session->evlist);
+	if (!cpu_map)
+		return -EINVAL;
+
 	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
-	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
+	auxtrace_info->priv[ARM_SPE_HEADER_VERSION] = ARM_SPE_HEADER_CURRENT_VERSION;
+	auxtrace_info->priv[ARM_SPE_HEADER_SIZE] =
+		ARM_SPE_AUXTRACE_PRIV_MAX - ARM_SPE_HEADER_VERSION;
+	auxtrace_info->priv[ARM_SPE_PMU_TYPE_V2] = arm_spe_pmu->type;
+	auxtrace_info->priv[ARM_SPE_CPUS_NUM] = perf_cpu_map__nr(cpu_map);
+
+	offset = ARM_SPE_AUXTRACE_PRIV_MAX;
+	perf_cpu_map__for_each_cpu(cpu, i, cpu_map) {
+		assert(offset < priv_size);
+		data = &auxtrace_info->priv[offset];
+		ret = arm_spe_save_cpu_header(itr, cpu, data);
+		if (ret < 0)
+			goto out;
+		offset += ret;
+	}
 
-	return 0;
+	ret = 0;
+out:
+	perf_cpu_map__put(cpu_map);
+	return ret;
 }
 
 static void
-- 
2.34.1

