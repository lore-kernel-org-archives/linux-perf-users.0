Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373223;
	b=uYS6gV8LS7cYtrVLhhMex72g9PK+ZcroROnYXF/Y964Clj8Do8A28MuEVomzAaDPwzIu
	 KJpCqjGPuSj3GJPQVmCYY8mmq+pHLtsIPwKtYv0cKma0lWJkagcS/1Eymj7WGC42AaHJ3
	 hbZD8lQxO0cvgUHGuEmdh/cWnHTt9L2kO12gYQzeatZlR9jjzV+rQN19+UhTl1f1nJKeQ
	 WUJbzxqn1awABHyXZjjYYr7nh11zVUjNZ1M7MSGXzPM5F6/N0nPNPfuT4AEFPMMxh5HD6
	 HRGRtiybXoUQMAp3dy/gl9cedxJB/6k+32BbtxzDUL8OJYIbzRjbsr/ehhAhAjAwLbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373223;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vrFLm/cCax5yQI71l8CSG587q1vifAi7hQZt2T8Cg7s=;
	b=WVy0qdCvYzz4Z/4/iqTwaeYcOUWy2IRpWQA3Dta/pjmFrRr7M2szjIpLriaAJtm/fHX6
	 WmvWSZQH/CahA2Zh6pt/sM1rPrN/Z8zIQTvkrLCr2ZEtqr69V2hC8q8mYAfBr7GbxWn6j
	 H6GzOpp1sYSCLPKIjOJ3ZWL9mNTlciPsFcEjDcURdEL/f9UJmSXWb6mxrSuQr9R4WBBV4
	 +RAO0XURe7Mb1aK2l/TLAzgpgisWD6ft25SnsGCXlPiFYiFcZKzo3qZRpU5x7vhBMXBcz
	 Cectxa83vs3Wk7d3qdCnzhnKKoDfGhPYQFXjnswO8bkY+6h5zEaVVPdM40E+u/PtzaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RQomrtf8;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE5660A2601;
	Fri, 30 Oct 2026 15:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE5660A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RQomrtf8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCCCD1BD0;
	Fri, 30 Oct 2026 08:13:38 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A41193F59E;
	Fri, 30 Oct 2026 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373221; bh=9ktypl1JqI0GWoy1OCHdCp+amWjg+77FtBUCJzM1uhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RQomrtf8+sgBKINaoHQMAlmUVuVhlfl8M1vvS0QUiWt4M8crnz6+AI0JE2WLt3K/0
	 V9fkSrUudlNWatWkFGfbhhZyizf/pWJd16VhJvNMcVAFovJCRgRXQs62Lspsou9aSU
	 2WR+qvYS/9NaoIBVcngBehERKkODxhAuI9XWCi3I=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:14 +0000
Subject: [PATCH v3 07/14] perf cs-etm: Factor out final instruction sample
 synthesis
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-7-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=3739;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=9ktypl1JqI0GWoy1OCHdCp+amWjg+77FtBUCJzM1uhE=;
 b=x4NYgbz3FMG00a7UH+RzdMK0YhVi7rrz8hLReaLrwJlij0ZmF10X2JUFCJ5tgK36/GfCX6pIz
 1KzkACdRPThAFtqZDkSBtAB5XNODWB9xefL/KeC0SF95KRWbsR3d5uD
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__flush() and cs_etm__end_block() duplicate the instruction sample
used to report the remaining branch history at the end of a trace.

Move this code into cs_etm__synth_last_instruction_sample(), preserving
the sample generation and instruction period reset.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 71 ++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 7cb9f69ead2b134b62653f133da7bdec23aaf280..9abbbc28dd1e2a66eadd663ce18217cd62deb390 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1727,6 +1727,28 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
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
@@ -2065,28 +2087,9 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
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
@@ -2108,8 +2111,6 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 static int cs_etm__end_block(struct cs_etm_queue *etmq,
 			     struct cs_etm_traceid_queue *tidq)
 {
-	int err;
-
 	/*
 	 * It has no new packet coming and 'etmq->packet' contains the stale
 	 * packet which was set at the previous time with packets swapping;
@@ -2119,27 +2120,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
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

