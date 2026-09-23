Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9355D894;
	Wed, 23 Sep 2026 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176937; cv=none; b=bEA4Mmy3RpX/V/6rPxbeRcGcw5/IpLJSkt+sgsMmaiCdLt0KooCrRKxfTgEHRxCTSd4hRn2S5+hBWqbsADcgKhZXisXuWkJQmShkMJKHgy7alX+ln89CNzXul/ZUhLPkDysqcZtJQPua/jbbw1by3fvZcdugHMIA5/zMcKpgF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176937; c=relaxed/simple;
	bh=MElIxOjSVxPdBco/8DPDHK5NhvwHvte23jsz8G8f+rM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTpYHzU6JRZvHS39kQH8Yn0zRWkR0orVQ9PGnAG2yVtaG6U1bd+tcVlVVqiShencviFnYMEAz4hApSjg1ndMD6TG+ZV+EqO5CL1c8IMgXZUaH5P6ynpAteDTJ7YYJ/STOuCjeBn3F382APNzP6gHE3KxHOXp38axqLYmjozYY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LH/LRUMK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LH/LRUMK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27F231D13;
	Wed, 23 Sep 2026 08:22:10 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F38D3F86F;
	Wed, 23 Sep 2026 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176933; bh=MElIxOjSVxPdBco/8DPDHK5NhvwHvte23jsz8G8f+rM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LH/LRUMKRLOIPuKLKmk7PEsVpOo1X/VUd1L9nrIXZemJ7HFAnypchvd3nC+X43tFJ
	 PWiWVbfzWj0dx3iVistehIvUtr+PQyMSL0DJgR7KVZ0ZVKEGYcu5bJ6YiUDzQrfvgg
	 ryCAoYtOdw9cVHC9nWq2wIV8qKMAW+F2fV8Q9Tnw=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:47 +0100
Subject: [PATCH v2 07/14] perf cs-etm: Factor out final instruction sample
 synthesis
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-7-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=3714;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=MElIxOjSVxPdBco/8DPDHK5NhvwHvte23jsz8G8f+rM=;
 b=PcwS9HINPU78ZZZPPE0+emH4fKk1SGGj3QzMUJEah63+DQBdZ7D49nPXZb5RqIEM39gBUfqIb
 rJMKpmWktBwCs/1vjH6XKhONX5ex0F+69wH+EKHhQgyIhOp32SdCfQu
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__flush() and cs_etm__end_block() duplicate the instruction sample
used to report the remaining branch history at the end of a trace.

Move this code into cs_etm__synth_last_instruction_sample(), preserving
the sample generation and instruction period reset.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 71 ++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c54218aeef53e8420447e9a2bee6e98d8225e335..5b5ee52c0277f5ff8f03c2908e4af1d7801845ff 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1685,6 +1685,28 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	return ret;
 }
 
+static int cs_etm__synth_last_instruction_sample(struct cs_etm_queue *etmq,
+						 struct cs_etm_traceid_queue *tidq)
+{
+	struct cs_etm_packet *packet = tidq->prev_packet;
+	int ret;
+
+	if (!etmq->etm->synth_opts.last_branch ||
+	    !etmq->etm->synth_opts.instructions)
+		return 0;
+
+	if (packet->sample_type != CS_ETM_RANGE)
+		return 0;
+
+	ret = cs_etm__synth_instruction_sample(etmq, tidq, packet,
+					       cs_etm__last_executed_instr(packet),
+					       tidq->period_instructions);
+	if (!ret)
+		tidq->period_instructions = 0;
+
+	return ret;
+}
+
 /*
  * The cs etm packet encodes an instruction range between a branch target
  * and the next taken branch. Generate sample accordingly.
@@ -2023,28 +2045,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
 		goto swap_packet;
 
-	if (etmq->etm->synth_opts.last_branch &&
-	    etmq->etm->synth_opts.instructions &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
-		u64 addr;
-		/*
-		 * Generate a last branch event for the branches left in the
-		 * circular buffer at the end of the trace.
-		 *
-		 * Use the address of the end of the last reported execution
-		 * range
-		 */
-		addr = cs_etm__last_executed_instr(tidq->prev_packet);
-
-		err = cs_etm__synth_instruction_sample(
-			etmq, tidq, tidq->prev_packet, addr,
-			tidq->period_instructions);
-		if (err)
-			return err;
-
-		tidq->period_instructions = 0;
-
-	}
+	err = cs_etm__synth_last_instruction_sample(etmq, tidq);
+	if (err)
+		return err;
 
 	if (etm->synth_opts.branches &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
@@ -2066,8 +2069,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 static int cs_etm__end_block(struct cs_etm_queue *etmq,
 			     struct cs_etm_traceid_queue *tidq)
 {
-	int err;
-
 	/*
 	 * It has no new packet coming and 'etmq->packet' contains the stale
 	 * packet which was set at the previous time with packets swapping;
@@ -2077,27 +2078,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 	 * event for the branches left in the circular buffer at the end of
 	 * the trace.
 	 */
-	if (etmq->etm->synth_opts.last_branch &&
-	    etmq->etm->synth_opts.instructions &&
-	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
-		u64 addr;
-
-		/*
-		 * Use the address of the end of the last reported execution
-		 * range.
-		 */
-		addr = cs_etm__last_executed_instr(tidq->prev_packet);
-
-		err = cs_etm__synth_instruction_sample(
-			etmq, tidq, tidq->prev_packet, addr,
-			tidq->period_instructions);
-		if (err)
-			return err;
-
-		tidq->period_instructions = 0;
-	}
-
-	return 0;
+	return cs_etm__synth_last_instruction_sample(etmq, tidq);
 }
 
 static int cs_etm__flush_stack_cb(struct thread *thread,

-- 
2.34.1

