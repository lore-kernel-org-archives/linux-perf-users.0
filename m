Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5B155C88
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Sep 2024 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727553369; cv=none; b=uItozsIhOh+vdmTpgKkd8gEpN9CiqhWDnUnYthIJCfy1UeQDjpSUyx3FKULFDPkmOC8KL7m0GAZmuoWeIYSTc0W5CllXc5vaxjCKFg6IdouXHuLjKjckD+iz6NkZDp6ttSj//5zfaLswqJM+rKdtAEMtFIyHO5cbfnr2SNLkxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727553369; c=relaxed/simple;
	bh=mmm7BDDvkh0/0NUNhjooKU67D9Ut32+mQQkbG1vxwlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ps8q0JKGeFqZwdaGPMyNw5JX5hh2cmNLl3v3xxsOTuUcYLpyfGsJ464dsYvhuGzJt+AdQeTje81bHTWpK2JqKULWlxKUAt1DOVMItmziolCaQJK9MJkqREBJ28nX3chIf21kLcept86RjlAVvZ1t/UDokUvytDw4F/xmIeE0m7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CBAB1595;
	Sat, 28 Sep 2024 12:56:30 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EFAD83F64C;
	Sat, 28 Sep 2024 12:55:58 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 2/5] perf arm-spe: Calculate meta data size
Date: Sat, 28 Sep 2024 20:55:44 +0100
Message-Id: <20240928195547.59780-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928195547.59780-1-leo.yan@arm.com>
References: <20240928195547.59780-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The metadata is designed to contain a header and per CPU information.

The arm_spe_find_cpus() function is introduced to identify how many CPUs
support ARM SPE. Based on the CPU number, calculates the metadata size.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 39 +++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index c2d5c8ca4900..81d5c07380a4 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -37,11 +37,44 @@ struct arm_spe_recording {
 	bool			*wrapped;
 };
 
+/*
+ * arm_spe_find_cpus() returns a new cpu map, and the caller should invoke
+ * perf_cpu_map__put() to release the map after use.
+ */
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
+	size = ARM_SPE_AUXTRACE_PRIV_MAX +
+	       ARM_SPE_CPU_PRIV_MAX * perf_cpu_map__nr(cpu_map);
+	size *= sizeof(u64);
+
+	perf_cpu_map__put(cpu_map);
+	return size;
 }
 
 static int arm_spe_info_fill(struct auxtrace_record *itr,
@@ -53,7 +86,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 
-	if (priv_size != ARM_SPE_AUXTRACE_V1_PRIV_SIZE)
+	if (priv_size != arm_spe_info_priv_size(itr, session->evlist))
 		return -EINVAL;
 
 	if (!session->evlist->core.nr_mmaps)
-- 
2.34.1

