Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1B21448E0;
	Sat, 14 Sep 2024 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350927; cv=none; b=PKnbhX1kd8FjsC1xcT+PsnZy51Xi7b2prcFrd72ylpjGa7rtRCG70ZP8vdcFdUop/j0jIBlQopwfCFkcijFGT+pT7nmkjqJZWCn4cUGmsF8pRwTt5Lhmoeq1qJMoWDcQ0EVht+nHoHgophQttb1qs+3WyNgwxsQUCLIeZZssowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350927; c=relaxed/simple;
	bh=joN+1kVtOuEWI1BVAKsK5A0s1DhbiVyBpMUIx1LJasI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naSo54AH09H6kf2Laps2jlPZa8lSjbNB2vrGwWCxjxBvVn87dULZjLOL/4bBExP4+0rzEGnpIbzaB9lxJa8hbt5QuNoLvjur9t2aQ8fPrEIGJCg/VNhgs0aucWYPeVP+pDzZtqbcmvdDKlh5Nf3XAvx4zPejBMdOPfPo34Hda9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15B99169C;
	Sat, 14 Sep 2024 14:55:49 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A38433F66E;
	Sat, 14 Sep 2024 14:55:17 -0700 (PDT)
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
Subject: [PATCH v2 2/5] perf arm-spe: Calculate meta data size
Date: Sat, 14 Sep 2024 22:54:55 +0100
Message-Id: <20240914215458.751802-3-leo.yan@arm.com>
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

The metadata is designed to contain a header and per CPU information.

The arm_spe_find_cpus() function is introduced to identify how many CPUs
support ARM SPE. Based on the CPU number, calculates the metadata size.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 35 +++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index c2d5c8ca4900..15478989ef30 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -37,11 +37,40 @@ struct arm_spe_recording {
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
+	size = ARM_SPE_AUXTRACE_PRIV_MAX +
+	       ARM_SPE_CPU_PRIV_MAX * perf_cpu_map__nr(cpu_map);
+	size *= sizeof(u64);
+
+	perf_cpu_map__put(cpu_map);
+	return size;
 }
 
 static int arm_spe_info_fill(struct auxtrace_record *itr,
@@ -53,7 +82,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 
-	if (priv_size != ARM_SPE_AUXTRACE_V1_PRIV_SIZE)
+	if (priv_size != arm_spe_info_priv_size(itr, session->evlist))
 		return -EINVAL;
 
 	if (!session->evlist->core.nr_mmaps)
-- 
2.34.1

