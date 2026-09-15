Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E5D4B0CAA;
	Tue, 15 Sep 2026 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487408; cv=none; b=ejJWCnYw03ZulDJHzAvzSL1heaLU66nR4vF2FeFMVuYHVzUrwECbpWVg+bZa2eIPojwqrPxAVMOYD0SSsI6yr8+mC9yDreLgggntAhZhsYLk2ESio3+FNXHU63qc7Tr+58vF1iPbDai6UPdrUZ6vsTOx1HmvBxfjlX6UyVA5tTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487408; c=relaxed/simple;
	bh=RwdsZM+a5uD/u0uXiHq0QhelTuat7HbYA6vpgy4lSvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIcT2q30YhjEn5SSs0hO3SAOiHmDoJ+hAFdFi2y9DJjAlEUhRvX4v+0RyeTlpsaYDTZvwZloo6304tqvUPgzWH8tNwbtxOwHDxEx8EX5uYq3dTL+/71hzIYyMWjP6MdMToQ+vW6EvQskyMla/4giwoT6h3VtR1d+6mbFCPeKhS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HA48Op/B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HA48Op/B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663171BF3;
	Tue, 15 Sep 2026 08:49:58 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CA1B3F882;
	Tue, 15 Sep 2026 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487402; bh=RwdsZM+a5uD/u0uXiHq0QhelTuat7HbYA6vpgy4lSvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HA48Op/BWQoUQohLek/bFyrKQzhCJgoB7Fig1/46bRzCj+hp1dwOLeJPUyYywG4eZ
	 LTpK3n8h3aeX+ir5Nwnx5lkQvUhGMyGNuO8UN4lZzJ8iRLPaOokkLori4z8BLJpkro
	 fGyxShcWhCsy0aHs/5rJRHf12WmBx1+YTv49x2To=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:08 +0100
Subject: [PATCH 22/25] perf cs-etm: Centralize sample history collection
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-22-35cf6f297d20@arm.com>
References: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
In-Reply-To: <20260915-arm_cs_support_aux_sample-v1-0-35cf6f297d20@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487341; l=3619;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=RwdsZM+a5uD/u0uXiHq0QhelTuat7HbYA6vpgy4lSvY=;
 b=SzWUV9IxuvwoEnwv1yCjXzzj2D+2HcEKberLOkn9Tby6iG+oqqbtlnqZAh6pNlqSOg3oaD450
 0ecb8mnF72MCUsyXyyY0f2uFtUrBujFTE4yF4UnFXoMoZ41Xi1XlgUA
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Extract thread lookup, branch history collection and history consumption
from cs_etm__process_sample() into cs_etm__save_sample_history(). This
separates collecting decoded history from attaching it to a perf sample
and provides a common place for adding callchain collection.

Keep history collection to consume branch history so later samples
cannot reuse an earlier trace window. Use the session stored in the
auxtrace state and remove the redundant process_sample() argument.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e78c8e089f38eae34faa12bbd2f899f1f72acce4..815a22cedc49e9281b7087f01355bb71b5e41c57 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2048,6 +2048,26 @@ static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 	return 0;
 }
 
+static int cs_etm__save_sample_history(struct cs_etm_auxtrace *etm,
+				       const struct perf_sample *sample)
+{
+	struct machine *machine = &etm->session->machines.host;
+	struct thread *thread;
+
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (!thread)
+		return -ENOMEM;
+
+	/* Consume branch history so later samples cannot reuse the same window. */
+	thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
+				     etm->br_stack_sz, sample->ip,
+				     machine__kernel_start(machine));
+	thread_stack__br_stack_consume(thread, sample->cpu);
+
+	thread__put(thread);
+	return 0;
+}
+
 static int cs_etm__flush(struct cs_etm_queue *etmq,
 			 struct cs_etm_traceid_queue *tidq)
 {
@@ -3088,11 +3108,8 @@ static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
  * the kernel; its thread and trace window still identify valid history.
  */
 static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
-				  struct perf_session *session,
 				  struct perf_sample *sample)
 {
-	struct machine *machine = &session->machines.host;
-	struct thread *thread;
 	int err;
 
 	if (!etm->synth_opts.add_last_branch || sample->branch_stack ||
@@ -3117,28 +3134,13 @@ static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
 	if (err)
 		return err;
 
-	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
-	if (!thread)
-		return -ENOMEM;
-
-	/*
-	 * Take the branch history rather than copying it. The trace window
-	 * belongs to the sample that ends it, so once it has been attached a
-	 * later sample with nothing newly decoded finds an empty stack rather
-	 * than being given an earlier window's branches. That is the common
-	 * case whenever the trace is duty cycled, by AUX pause/resume or by
-	 * ETM strobing.
-	 */
-	thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
-				     etm->br_stack_sz, sample->ip,
-				     machine__kernel_start(machine));
-	thread_stack__br_stack_consume(thread, sample->cpu);
+	err = cs_etm__save_sample_history(etm, sample);
+	if (err)
+		return err;
 
 	if (etm->br_stack->nr)
 		sample->branch_stack = etm->br_stack;
 
-	thread__put(thread);
-
 	return 0;
 }
 
@@ -3181,7 +3183,7 @@ static int cs_etm__process_event(struct perf_session *session,
 		return cs_etm__process_switch_cpu_wide(etm, event);
 
 	case PERF_RECORD_SAMPLE:
-		return cs_etm__process_sample(etm, session, sample);
+		return cs_etm__process_sample(etm, sample);
 
 	case PERF_RECORD_AUX:
 		/*

-- 
2.34.1

