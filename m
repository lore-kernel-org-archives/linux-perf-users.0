Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AA81D1735;
	Tue, 27 Aug 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777084; cv=none; b=tALo9CYhbLo6djJy7fO9/LZQN7G8+16mk68Y/1hI3RywbkybQnH0BPVnQbXdTYNPhmsioYx2VQllnVm7Fnp2zpqaBTvuXWOM/HRmJI62BwVA1M2m1a+bpReRr1aT+NoBuXZrVN4hsaAxCkKJgU1IDUd4Emrcunm/eSBu55MSkAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777084; c=relaxed/simple;
	bh=Hu/fohuMR1YEeV30QvO9/h7LNFQQcbY0053t9Nrov9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZXfMwNxTh3wjE8iyrVgGwHqlyqHRyy9qNV2+CwqaVhnGCIXaLnYmaumAAGXb9oy6g9Oq0jTe9LYC6WaA592evHRBzfI2pGKeH5PvYJ5Ry/YVf3xjUVwEF/UnBVU/RC0spCnpjuA/rqPbM2Z2g+mbBdwQbDfZf1BYJ+Al/Tw88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E56EDDA7;
	Tue, 27 Aug 2024 09:45:08 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 979E03F762;
	Tue, 27 Aug 2024 09:44:40 -0700 (PDT)
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
Subject: [PATCH v1 4/9] perf: arm-spe: Record multiple PMUs
Date: Tue, 27 Aug 2024 17:44:12 +0100
Message-Id: <20240827164417.3309560-5-leo.yan@arm.com>
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

Currently, the arm_spe_recording structure only saves the first Arm SPE
PMU pointer and it cannot cover all PMU events for the multiple Arm SPE
event case.

Save the all Arm SPE PMU pointers into the arm_spe_recording structure,
later changes will use these pointers to retrieve meta data.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm/util/auxtrace.c  |  2 +-
 tools/perf/arch/arm64/util/arm-spe.c | 19 +++++++++++++++----
 tools/perf/util/arm-spe.h            |  3 ++-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 2fca16659858..55877418b6c4 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -100,7 +100,7 @@ struct auxtrace_record
 
 #if defined(__aarch64__)
 	if (arm_spe_pmus)
-		itr = arm_spe_recording_init(err, arm_spe_pmus[0]);
+		itr = arm_spe_recording_init(err, arm_spe_pmus, nr_spe);
 
 	if (hisi_ptt_pmus)
 		itr = hisi_ptt_recording_init(err, hisi_ptt_pmus[0]);
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 2be99fdf997d..7880190c3dd6 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -31,7 +31,8 @@
 
 struct arm_spe_recording {
 	struct auxtrace_record		itr;
-	struct perf_pmu			*arm_spe_pmu;
+	struct perf_pmu			**pmu;
+	int				nr_pmu;
 	struct evlist		*evlist;
 	int			wrapped_cnt;
 	bool			*wrapped;
@@ -51,7 +52,7 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
 {
 	struct arm_spe_recording *sper =
 			container_of(itr, struct arm_spe_recording, itr);
-	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
+	struct perf_pmu *arm_spe_pmu = sper->pmu[0];
 
 	if (priv_size != ARM_SPE_AUXTRACE_PRIV_SIZE)
 		return -EINVAL;
@@ -494,11 +495,13 @@ static void arm_spe_recording_free(struct auxtrace_record *itr)
 			container_of(itr, struct arm_spe_recording, itr);
 
 	zfree(&sper->wrapped);
+	zfree(&sper->pmu);
 	free(sper);
 }
 
 struct auxtrace_record *arm_spe_recording_init(int *err,
-					       struct perf_pmu *arm_spe_pmu)
+					       struct perf_pmu **arm_spe_pmu,
+					       int nr_pmu)
 {
 	struct arm_spe_recording *sper;
 
@@ -513,7 +516,15 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 		return NULL;
 	}
 
-	sper->arm_spe_pmu = arm_spe_pmu;
+	sper->pmu = zalloc(sizeof(struct perf_pmu *) * nr_pmu);
+	if (!sper->pmu) {
+		free(sper);
+		*err = -ENOMEM;
+		return NULL;
+	}
+	memcpy(sper->pmu, arm_spe_pmu, sizeof(struct perf_pmu *) * nr_pmu);
+	sper->nr_pmu = nr_pmu;
+
 	sper->itr.snapshot_start = arm_spe_snapshot_start;
 	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
 	sper->itr.find_snapshot = arm_spe_find_snapshot;
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 4f4900c18f3e..e1327e1b3fec 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -22,7 +22,8 @@ struct perf_session;
 struct perf_pmu;
 
 struct auxtrace_record *arm_spe_recording_init(int *err,
-					       struct perf_pmu *arm_spe_pmu);
+					       struct perf_pmu **arm_spe_pmu,
+					       int nr_pmu);
 
 int arm_spe_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
-- 
2.34.1

