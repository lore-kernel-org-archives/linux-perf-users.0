Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474DE2003C1;
	Fri, 25 Oct 2024 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853554; cv=none; b=AQ9A/yTNCA+c4kf0FRJA/gJUkjcVkWf0qddQoijEhpVn3KR4sJ2daCcxXNcTM4ED/AqWfmITe9HgmlsSSO7XrLg9EOp0U7K5Zmo/u2OZyjwEcMMXdzvJf1IH5aBx07JoClT+V/VEp2r7u4BX9V2x/WH4BZU00QtTI2AJIMF2BAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853554; c=relaxed/simple;
	bh=zOVyKZ+ZvB/9SwbWEYIY80fMUYtlcEosf/RnEiK6BrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9yUqqtIPfvGjDBgt+g2bHpMm1VkO9+wi3v9zzSgqoS5BLVMFFrROM3IQ2mc/ED9hAhg+fRwIsOPpx1wBNgcYc1IfZz6jIje7A9/gkkfYcI0Zyj4GZKEV2lfurqaxF8FOsOaEiP54iIxRdzTEVWnvRQBm9+AgwyY6bLWzhf7kCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36979165C;
	Fri, 25 Oct 2024 03:53:01 -0700 (PDT)
Received: from VDW30FN91H.arm.com (unknown [10.57.79.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41D993F73B;
	Fri, 25 Oct 2024 03:52:29 -0700 (PDT)
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
Subject: [PATCH v10 3/4] perf arm-spe: Correctly set sample flags
Date: Fri, 25 Oct 2024 11:52:11 +0100
Message-Id: <20241025105212.51779-4-graham.woodward@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241025105212.51779-1-graham.woodward@arm.com>
References: <20241025105212.51779-1-graham.woodward@arm.com>
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
index a644787fa..6f3db0737 100644
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
index d27500c53..830ab653f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -96,6 +96,7 @@ struct arm_spe_queue {
 	u64				timestamp;
 	struct thread			*thread;
 	u64				period_instructions;
+	u32				flags;
 };
 
 static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
@@ -376,6 +377,7 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	sample.stream_id = spe_events_id;
 	sample.addr = record->to_ip;
 	sample.weight = record->latency;
+	sample.flags = speq->flags;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -405,10 +407,24 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	sample.data_src = data_src;
 	sample.period = spe->instructions_sample_period;
 	sample.weight = record->latency;
+	sample.flags = speq->flags;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
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
 static const struct midr_range neoverse_spe[] = {
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
@@ -551,6 +567,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 	u64 data_src;
 	int err;
 
+	arm_spe__sample_flags(speq);
 	data_src = arm_spe__synth_data_source(record, spe->midr);
 
 	if (spe->sample_flc) {
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f8742e623..2744c54f4 100644
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

