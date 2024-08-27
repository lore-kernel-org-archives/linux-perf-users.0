Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAFB1D279B;
	Tue, 27 Aug 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777089; cv=none; b=TIk3cg3Ak23B6SEYB94KO/mlj69ZY75PSNbGU8vD9Smhi5O2yn585NcMcBn33aJLW434tCTHIJDmtQXR1rwWhg3tKBmeWRdIszvfBhDq0Jrda63ov7+j76FCNEdJ2b1OnI9A6z1knW17+SXppQiauBRT9eNPS6NEeQlGrI/4hFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777089; c=relaxed/simple;
	bh=CnSPrIwC6kJN6FdUr7O/geh6zfK4tHrG5Zbb1u6hkNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8kpeohg8ClL0/hgfExQMh+UgYUw+vG1PNF966YkIWEI43qUZBIh4D1Y6RXSjBbVrVScff69TYxb4TB4tuD6keOssRoVWsxhFVxoqmy4BiCVwTyTl/5sqkg9WhxVGgOwtfEMWklADjvKOXlU/Tq5VGn8lCL0CWn7B5hsIDlcTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B82811FB;
	Tue, 27 Aug 2024 09:45:13 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E19A3F762;
	Tue, 27 Aug 2024 09:44:45 -0700 (PDT)
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
Subject: [PATCH v1 6/9] perf arm-spe: Calculate meta data size
Date: Tue, 27 Aug 2024 17:44:14 +0100
Message-Id: <20240827164417.3309560-7-leo.yan@arm.com>
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

The metadata is designed to contain a header and per CPU information.

The arm_spe_find_cpus() function is introduced to identify how many CPUs
support ARM SPE. Based on the found CPU number, calculates the metadata
size.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 34 +++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 3e7f62bac2e0..f8126283dad2 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -38,11 +38,39 @@ struct arm_spe_recording {
 	bool			*wrapped;
 };
 
+static struct perf_cpu_map *arm_spe_find_cpus(struct evlist *evlist)
+{
+	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
+	struct perf_cpu_map *online_cpus = perf_cpu_map__new_online_cpus();
+	struct perf_cpu_map *intersect_cpus;
+
+	/* cpu map is not "any" CPU , we have specific CPUs to work with */
+	if (!perf_cpu_map__has_any_cpu(event_cpus)) {
+		intersect_cpus = perf_cpu_map__intersect(event_cpus, online_cpus);
+		perf_cpu_map__put(online_cpus);
+	/* Event can be "any" CPU so count all CPUs. */
+	} else {
+		intersect_cpus = online_cpus;
+	}
+
+	return intersect_cpus;
+}
+
 static size_t
 arm_spe_info_priv_size(struct auxtrace_record *itr __maybe_unused,
-		       struct evlist *evlist __maybe_unused)
+		       struct evlist *evlist)
 {
-	return ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
+	struct perf_cpu_map *cpu_map = arm_spe_find_cpus(evlist);
+	size_t size;
+
+	if (!cpu_map)
+		return 0;
+
+	size = ARM_SPE_AUXTRACE_V2_PRIV_SIZE +
+	       ARM_SPE_AUXTRACE_V2_PER_CPU_SIZE * perf_cpu_map__nr(cpu_map);
+
+	perf_cpu_map__put(cpu_map);
+	return size;
 }
 
 static int arm_spe_info_fill(struct auxtrace_record *itr,
@@ -54,7 +82,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->pmu[0];
 
-	if (priv_size != ARM_SPE_AUXTRACE_V1_PRIV_SIZE)
+	if (priv_size != arm_spe_info_priv_size(itr, session->evlist))
 		return -EINVAL;
 
 	if (!session->evlist->core.nr_mmaps)
-- 
2.34.1

