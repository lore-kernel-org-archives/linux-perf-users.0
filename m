Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F111D27BD;
	Tue, 27 Aug 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777091; cv=none; b=T1rsLyHUnbS3oOvGuMifEgwmMMRbHNjR2ENDPxnoeai6IUcap5osyEmHxr4FaNDdsIjQcKY3v3bngY9xUwzEmNxDxjlGbe77dmKdRIQSWWp9cqssDslvTFnW9sqsvgKSgbvEyLumbOvUCvBLmhn11hI6cwTKqoKOvY8RX2HYwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777091; c=relaxed/simple;
	bh=BoFeRWl8kX5KY+U0v//wMnR7OqyRy2AXyAdv96dv878=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQcCmJx6Of5yVlL7hXHwA1WAltCAHJo46ODA+lKBcGRkh+lcYfIAZMS6vVCJvhX0bneRrIKlga0dzs1265pxMw30JBtMZ6tJ8b6N7Y7C8RhsfkcJKJ3iA0aJM1YBKXuAjEmcnW+zpJfJfgn/YC6yAdaCjaPNQ42NmNUMq3MxEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F04C3DA7;
	Tue, 27 Aug 2024 09:45:15 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2E143F762;
	Tue, 27 Aug 2024 09:44:47 -0700 (PDT)
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
Subject: [PATCH v1 7/9] perf arm-spe: Save per CPU information in metadata
Date: Tue, 27 Aug 2024 17:44:15 +0100
Message-Id: <20240827164417.3309560-8-leo.yan@arm.com>
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

An Arm SPE event can include all CPUs or just a subset of CPUs in a
system.

Instead of storing the Arm SPE event parameters in a single metadata
entry, save the Arm SPE information on a per-CPU basis. This approach
aligns with how Arm SPE traces are recorded per CPU, making it easier
to match metadata with trace data.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 73 ++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index f8126283dad2..d0cff3ac7c1f 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -73,14 +73,74 @@ arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
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
+	int i;
+
+	snprintf(cpu_id_str, sizeof(cpu_id_str), "%d", cpu.cpu);
+	tmp_pmu.cpus = perf_cpu_map__new(cpu_id_str);
+	if (!tmp_pmu.cpus)
+		return -ENOMEM;
+
+	/* Read CPU MIDR */
+	cpuid = perf_pmu__getcpuid(&tmp_pmu);
+	if (!cpuid)
+		return -ENOMEM;
+	val = strtol(cpuid, NULL, 16);
+	perf_cpu_map__put(tmp_pmu.cpus);
+
+	data[ARM_SPE_CPU] = cpu.cpu;
+	data[ARM_SPE_CPU_MIDR] = val;
+
+	/* Find the associate Arm SPE PMU for the CPU */
+	for (i = 0; i < sper->nr_pmu; i++) {
+		if (perf_cpu_map__has(sper->pmu[i]->cpus, cpu)) {
+			pmu = sper->pmu[i];
+			break;
+		}
+	}
+
+	if (!pmu) {
+		/* No Arm SPE PMU is found */
+		data[ARM_SPE_CPU_PMU_TYPE] = ULLONG_MAX;
+		data[ARM_SPE_CAP_MIN_IVAL] = 0;
+		data[ARM_SPE_CAP_LDS] = 0;
+	} else {
+		data[ARM_SPE_CPU_PMU_TYPE] = pmu->type;
+
+		if (perf_pmu__scan_file(pmu, "caps/min_interval", "%lu", &val) != 1)
+			val = 0;
+		data[ARM_SPE_CAP_MIN_IVAL] = val;
+
+		if (perf_pmu__scan_file(pmu, "caps/lds", "%lu", &val) != 1)
+			val = 0;
+		data[ARM_SPE_CAP_LDS] = val;
+	}
+
+	return ARM_SPE_PER_CPU_PRIV_MAX;
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
 	struct perf_pmu *arm_spe_pmu = sper->pmu[0];
+	struct perf_cpu_map *cpu_map = arm_spe_find_cpus(session->evlist);
+	struct perf_cpu cpu;
+	__u64 *data;
 
 	if (priv_size != arm_spe_info_priv_size(itr, session->evlist))
 		return -EINVAL;
@@ -90,7 +150,20 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 
 	auxtrace_info->type = PERF_AUXTRACE_ARM_SPE;
 	auxtrace_info->priv[ARM_SPE_PMU_TYPE] = arm_spe_pmu->type;
+	auxtrace_info->priv[ARM_SPE_HEADER_VERSION] = ARM_SPE_HEADER_CURRENT_VERSION;
+	auxtrace_info->priv[ARM_SPE_CPU_NUM] = perf_cpu_map__nr(cpu_map);
+
+	offset = ARM_SPE_CPU_NUM + 1;
+	perf_cpu_map__for_each_cpu(cpu, i, cpu_map) {
+		assert(offset < priv_size);
+		data = &auxtrace_info->priv[offset];
+		ret = arm_spe_save_cpu_header(itr, cpu, data);
+		if (ret < 0)
+			return ret;
+		offset += ret;
+	}
 
+	perf_cpu_map__put(cpu_map);
 	return 0;
 }
 
-- 
2.34.1

