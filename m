Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750820D4F7;
	Fri, 25 Oct 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866661; cv=none; b=Id5A4EeO72T+orh2pz/izebDLIHuxUtxxDlpPLdkZCnN6hbvaaSON8couFBbeat9PpFNCrHR7ihx3WDBZelOOR39yOH2hPk6NocBdWW9uingtoA7ZkecZXnLAndQFEl3vt5Y1KrtmmzhC1CyOeBDqlSq/B1B2xWR2qnXVf6HRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866661; c=relaxed/simple;
	bh=bxlavruyCeOG0aiYoX6EJZfe8AAgSdNwL5KyPxMXcQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwYtv4U95wGSiJlEErz7g3erD+bQFqwQk6f/L6IiHWzeKfFG6SMjySdi93s+CxtDxVEOrjn87YjPJdjZCgt5wewPbXkm0NOOaIBEuvr18saBoXzVk37kHAujVPxu3gBcMTn7vCEYq2jdP4V1tIyMgar49RPzMwLIrH/jx7dmcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835B9497;
	Fri, 25 Oct 2024 07:31:28 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 873E53F73B;
	Fri, 25 Oct 2024 07:30:56 -0700 (PDT)
From: Graham Woodward <graham.woodward@arm.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	Graham Woodward <graham.woodward@arm.com>
Subject: [PATCH v1 3/4] perf arm-spe: Correctly set sample flags
Date: Fri, 25 Oct 2024 15:30:08 +0100
Message-Id: <20241025143009.25419-4-graham.woodward@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241025143009.25419-1-graham.woodward@arm.com>
References: <20241025143009.25419-1-graham.woodward@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set flags on all synthesized instruction and branch samples.

Signed-off-by: Graham Woodward <graham.woodward@arm.com>
---
 tools/perf/builtin-script.c |  1 +
 tools/perf/util/arm-spe.c   | 17 +++++++++++++++++
 tools/perf/util/event.h     |  1 +
 3 files changed, 19 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8c5d5cecfba4..6b6d4472db6e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1728,6 +1728,7 @@ static struct {
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
 	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
+	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_BRANCH_MISS, "br miss"},
 	{0, NULL}
 };
 
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index e60e21d24735..a291a412f6a1 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -100,6 +100,7 @@ struct arm_spe_queue {
 	u64				timestamp;
 	struct thread			*thread;
 	u64				period_instructions;
+	u32				flags;
 };
 
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
@@ -394,6 +395,7 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->to_ip;
 	sample.weight = record->latency;
+	sample.flags = speq->flags;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -423,6 +425,7 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	sample.data_src = data_src;
 	sample.period = spe->instructions_sample_period;
 	sample.weight = record->latency;
+	sample.flags = speq->flags;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -440,6 +443,19 @@ static const struct midr_range common_ds_encoding_cpus[] = {
 	{},
 };
 
+static void arm_spe__sample_flags(struct arm_spe_queue *speq)
+{
+	const struct arm_spe_record *record = &speq->decoder->record;
+
+	speq->flags = 0;
+	if (record->op & ARM_SPE_OP_BRANCH_ERET) {
+		speq->flags = PERF_IP_FLAG_BRANCH;
+
+		if (record->type & ARM_SPE_BRANCH_MISS)
+			speq->flags |= PERF_IP_FLAG_BRANCH_MISS;
+	}
+}
+
 static void arm_spe__synth_data_source_common(const struct arm_spe_record *record,
 					      union perf_mem_data_src *data_src)
 {
@@ -622,6 +638,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	u64 data_src;
 	int err;
 
+	arm_spe__sample_flags(speq);
 	data_src = arm_spe__synth_data_source(speq, record);
 
 	if (spe->sample_flc) {
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f8742e6230a5..2744c54f404e 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -66,6 +66,7 @@ enum {
 	PERF_IP_FLAG_VMEXIT		= 1ULL << 12,
 	PERF_IP_FLAG_INTR_DISABLE	= 1ULL << 13,
 	PERF_IP_FLAG_INTR_TOGGLE	= 1ULL << 14,
+	PERF_IP_FLAG_BRANCH_MISS	= 1ULL << 15,
 };
 
 #define PERF_IP_FLAG_CHARS "bcrosyiABExghDt"
-- 
2.40.1

