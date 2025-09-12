Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DACD315D5A
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691774; cv=none; b=IA5/J351ucFNo9BDZ8kVDMFCvnYEXD0yH/I37ipYK4i28pJu6YGXvAXTRx9hWxu1ThbaBCJXyEuJsJzU8LbjfcTRDXfZAPH5vvP9az1sEzRLpSbSQYBAWetAAfcB6IOMSQAixoRtyBhQXGVrmIJrA99rd/4mLEfdLmy8n+t31Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691774; c=relaxed/simple;
	bh=9MooJIAjWW7XUlWnUjquEUcmSSk3wzoBpe75YIQDMbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRAyubIfN3v4tcIuBQ65pcMZbE6HrvmWLv5KoxzX09uaOlPUEQ7/a4q39aB5RQbkQ95dbtubXNXsSAjQNMZnY2v/r5GhIY6c2k4bvJ53urz3UeqfnI3958pdLI8lgMq92yM5ThgC06uEetS3DDlXgoRggdEnMyJ9Zh2kud6Fq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66B481515;
	Fri, 12 Sep 2025 08:42:44 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A56803F694;
	Fri, 12 Sep 2025 08:42:50 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Sep 2025 16:42:10 +0100
Subject: [PATCH v5 05/14] perf arm_spe: Use full type for data_src
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-5-0800880da0a7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757691759; l=3452;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=B5MnTJqbE8nUXxaPEkMUJDWBL2VBqJdx7w1bQRFcVkQ=;
 b=nJzczTTb3bwmE3jZEJCMh9w2S4RGHG3kY6LrdrEOlCCfUUJ+y0TksJYLG9YUVgiPrEDfHlZ0b
 dFcAYMn3QoiAkFaH07DGulWkER7dXfnBDGsjwjrjyd5uLp5+i66A7iA
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: James Clark <james.clark@linaro.org>

data_src has an actual type rather than just being a u64. To help
readers, delay decomposing it to a u64 until it's finally assigned to
the sample.

Signed-off-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 6fb012d89488c1e5d4866ec62a2df2bc895cb6ca..38e6f8331f2790b9cd3bc94d5a18657d7e0f5e42 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -469,7 +469,8 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 }
 
 static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
-				     u64 spe_events_id, u64 data_src)
+				     u64 spe_events_id,
+				     union perf_mem_data_src data_src)
 {
 	struct arm_spe *spe = speq->spe;
 	struct arm_spe_record *record = &speq->decoder->record;
@@ -484,7 +485,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->virt_addr;
 	sample.phys_addr = record->phys_addr;
-	sample.data_src = data_src;
+	sample.data_src = data_src.val;
 	sample.weight = record->latency;
 
 	ret = arm_spe_deliver_synth_event(spe, speq, event, &sample);
@@ -517,7 +518,8 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 }
 
 static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
-					     u64 spe_events_id, u64 data_src)
+					     u64 spe_events_id,
+					     union perf_mem_data_src data_src)
 {
 	struct arm_spe *spe = speq->spe;
 	struct arm_spe_record *record = &speq->decoder->record;
@@ -532,7 +534,7 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->to_ip;
 	sample.phys_addr = record->phys_addr;
-	sample.data_src = data_src;
+	sample.data_src = data_src.val;
 	sample.weight = record->latency;
 	sample.flags = speq->flags;
 	sample.branch_stack = speq->last_branch;
@@ -880,21 +882,22 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
 	return false;
 }
 
-static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
-				      const struct arm_spe_record *record)
+static union perf_mem_data_src
+arm_spe__synth_data_source(struct arm_spe_queue *speq,
+			   const struct arm_spe_record *record)
 {
-	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
+	union perf_mem_data_src	data_src = {};
 
 	/* Only synthesize data source for LDST operations */
 	if (!is_ldst_op(record->op))
-		return 0;
+		return data_src;
 
 	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
 	else if (record->op & ARM_SPE_OP_ST)
 		data_src.mem_op = PERF_MEM_OP_STORE;
 	else
-		return 0;
+		return data_src;
 
 	if (!arm_spe__synth_ds(speq, record, &data_src))
 		arm_spe__synth_memory_level(record, &data_src);
@@ -908,14 +911,14 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
 			data_src.mem_dtlb |= PERF_MEM_TLB_HIT;
 	}
 
-	return data_src.val;
+	return data_src;
 }
 
 static int arm_spe_sample(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
 	struct arm_spe *spe = speq->spe;
-	u64 data_src;
+	union perf_mem_data_src data_src;
 	int err;
 
 	/*

-- 
2.34.1

