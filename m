Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3223148B8
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691792; cv=none; b=N55luyb2HH5vtHwoJC9vWGQwSsOgIO4UsnZXjn+71gQDVhnTtvaXVC0yxcxrZvoQVdIVYne2pIFeVZ+3mi0GrG5w1cfnES4mGgxx5iQnSY0/CtwMp5JHrNOVB44IVw9y+AKcKHn13OmtAnKuLiYRIBhkbS2+pNDg7tSYyrzAK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691792; c=relaxed/simple;
	bh=ON2/9YnAdEDqUoo8kuk+zKWqe1rVAcJ/TqrxBuYfQfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+GME3DrQs9jDasPjU7Yx42CHpYMGUNywZfr4De3i/4Gukq9maDejuiiOLd21ZpqErZFiRIKdk0hZfiLJW58PTm1mnNYv1H3YOMmO5wjdcDHpsUf/gCAmQGsEZ33dr6kBj0eLFk7VhuOemUmuzWEjDaDaGVJvoBF0A3d8n+PGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC7131A25;
	Fri, 12 Sep 2025 08:43:02 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EACD43F694;
	Fri, 12 Sep 2025 08:43:08 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Sep 2025 16:42:18 +0100
Subject: [PATCH v5 13/14] perf arm_spe: Set HITM flag
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-13-0800880da0a7@arm.com>
References: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
In-Reply-To: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 German Gomez <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757691759; l=3698;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=ON2/9YnAdEDqUoo8kuk+zKWqe1rVAcJ/TqrxBuYfQfA=;
 b=e2ddGXFXmZENyicKxeRKvDXwnYnHQPLjTWJOEYkhIXska41dJwqnkOr2dNX/BaSpXY+JlpCLi
 FSDabXuABorAtbar8XjAnYbXyi01M75X3BIXfiAXNzg7gw7v+bw2ms9
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since FEAT_SPEv1p4, Arm SPE provides extra two events "Cache data
modified" and "Data snooped".

Set the snoop mode as:

- If both the "Cache data modified" event and the "Data snooped" event
  are set, which indicates a load operation that snooped from a outside
  cache and hit a modified copy, set the HITM flag to inspect false
  sharing.
- If the snooped event bit is not set, and the snooped event has been
  supported by the hardware, set as NONE mode (no snoop operation).
- If the snooped event bit is not set, and the event is not supported or
  absent the events info in the meta data, set as NA mode (not
  available).

Don't set any mode for only "Cache data modified" event, as it hits a
local modified copy.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h |  2 ++
 tools/perf/util/arm-spe.c                         | 26 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 3afa8703b21db9d231eef93fe981e0c20d562e83..fbb57f8052371e51d562d9dd6098e97fc099461c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -28,6 +28,8 @@
 #define ARM_SPE_L2D_ACCESS		BIT(EV_L2D_ACCESS)
 #define ARM_SPE_L2D_MISS		BIT(EV_L2D_MISS)
 #define ARM_SPE_RECENTLY_FETCHED	BIT(EV_RECENTLY_FETCHED)
+#define ARM_SPE_DATA_SNOOPED		BIT(EV_DATA_SNOOPED)
+#define ARM_SPE_HITM			BIT(EV_CACHE_DATA_MODIFIED)
 
 enum arm_spe_op_type {
 	/* First level operation type */
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 58f80b5c0ab969448c962adb31abde5067cf4be3..08cb493c3265ade3093c84a90fa5e47dcd77c8f1 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -894,9 +894,12 @@ static void arm_spe__synth_st_memory_level(const struct arm_spe_record *record,
 	}
 }
 
-static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
+static void arm_spe__synth_memory_level(struct arm_spe_queue *speq,
+					const struct arm_spe_record *record,
 					union perf_mem_data_src *data_src)
 {
+	struct arm_spe *spe = speq->spe;
+
 	if (data_src->mem_op == PERF_MEM_OP_LOAD)
 		arm_spe__synth_ld_memory_level(record, data_src);
 	if (data_src->mem_op == PERF_MEM_OP_STORE)
@@ -907,6 +910,25 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 	}
 
+	if (record->type & ARM_SPE_DATA_SNOOPED) {
+		if (record->type & ARM_SPE_HITM)
+			data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
+		else
+			data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
+	} else {
+		u64 *metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
+
+		/*
+		 * Set NA ("Not available") mode if no meta data or the
+		 * SNOOPED event is not supported.
+		 */
+		if (!metadata ||
+		    !(metadata[ARM_SPE_CAP_EVENT_FILTER] & ARM_SPE_DATA_SNOOPED))
+			data_src->mem_snoop = PERF_MEM_SNOOP_NA;
+		else
+			data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
+	}
+
 	if (record->type & ARM_SPE_REMOTE_ACCESS)
 		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 }
@@ -963,7 +985,7 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
 		return data_src;
 
 	if (!arm_spe__synth_ds(speq, record, &data_src))
-		arm_spe__synth_memory_level(record, &data_src);
+		arm_spe__synth_memory_level(speq, record, &data_src);
 
 	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
 		data_src.mem_dtlb = PERF_MEM_TLB_WK;

-- 
2.34.1

