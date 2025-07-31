Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5FA2C3774
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968437; cv=none; b=jgpscAiZksBY0MXAK4g+9hVWOH76htZIWpjDBaVExwVHAuXVxQP9IZ0r8/o1rbc02HMYsEv94r+sESfhCuxIiSk6D8fC79fHMGZsJxlT4WkPnI+aifhj8vupPnVayz3BjgbZoqL5Ize/mganPc3l8m5wf0gBlZcc4diz5RqGCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968437; c=relaxed/simple;
	bh=nJU5kigoo7RLtBqj4cwlZeF8sB/Lo6viot1OJIrVX3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GUNrdjsNGYj4kf+IV2kr02W1f5MzxSe+2ARW1/M/GThYXDpkJSkXolc/WyjAuhY8KrTP5q/aUCRIHEfBQPysQwwKwgGFzQ+4OUdhPaBAauCvBYNlkDPZh2Ty0SloMAhUeGuVg8NTgAiWD0KG3j/Bq8zM1XUsI1NEfdHmzmly+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12EE92C41;
	Thu, 31 Jul 2025 06:27:08 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EBDC3F66E;
	Thu, 31 Jul 2025 06:27:13 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 14:25:40 +0100
Subject: [PATCH v4 05/15] perf arm_spe: Use full type for data_src
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-5-58e5677a412b@arm.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753968422; l=3486;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=dC1YJ8EUH5UByzXf2nNJG0iR9osDUbakif4x5pzmfVo=;
 b=kGQ5lkT1WubFtRqwed+9MzHepynPt9+pJeJX76FeJM0AIUcuxx0aXDKczFfYB8eEUbP78Adyk
 Zkb4SWWRLc/B961oPynpxtZ+vdgxqkRsSZ5XwQ7jiOdFK9NybERamBu
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
index 3086dad92965af3981b1065f2892a3e67df7b616..8aed942a3da22f71f2c302586a4e84d68600e597 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -471,7 +471,8 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 }
 
 static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
-				     u64 spe_events_id, u64 data_src)
+				     u64 spe_events_id,
+				     union perf_mem_data_src data_src)
 {
 	struct arm_spe *spe = speq->spe;
 	struct arm_spe_record *record = &speq->decoder->record;
@@ -486,7 +487,7 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->virt_addr;
 	sample.phys_addr = record->phys_addr;
-	sample.data_src = data_src;
+	sample.data_src = data_src.val;
 	sample.weight = record->latency;
 
 	ret = arm_spe_deliver_synth_event(spe, speq, event, &sample);
@@ -519,7 +520,8 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 }
 
 static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
-					     u64 spe_events_id, u64 data_src)
+					     u64 spe_events_id,
+					     union perf_mem_data_src data_src)
 {
 	struct arm_spe *spe = speq->spe;
 	struct arm_spe_record *record = &speq->decoder->record;
@@ -542,7 +544,7 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->to_ip;
 	sample.phys_addr = record->phys_addr;
-	sample.data_src = data_src;
+	sample.data_src = data_src.val;
 	sample.period = spe->instructions_sample_period;
 	sample.weight = record->latency;
 	sample.flags = speq->flags;
@@ -891,21 +893,22 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
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
@@ -919,14 +922,14 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
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
 
 	arm_spe__sample_flags(speq);

-- 
2.34.1

