Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A234BFE88;
	Tue, 15 Sep 2026 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487397; cv=none; b=Zdugp73V8M+/fRy08nAOvRWrXaUQjEF3tyUgClmA84SbqPSsispI7HboqAMgjke+QH2P46jRIr1yJnR0jGyunnp5fMaLV3Fpv1O2Nc/aaVyI57lBVZXf4ixRbmCiRklSjsRK8I79QBHKgAgbaD2+au40MrZ/b0cSinC5SmaneCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487397; c=relaxed/simple;
	bh=M6nqCi/crONOiSQCUR9ebCZXN0BqQCYtCGnaHG7Fm3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxHu5x3FxfEJBqG/BBX9yrRmVZcpdsey6T3WUw53KfMYDAGIqqM/rgsDaDYeJDae1pAedu44FfdXgHIRJG/CU1oPdYGWUoygtQcNjpoh9Lbmor3ufJjv5vCyrl6x2ZEmm2XULxqX4ayH9FtBw/1iE2v2zsT+Mu13K5iI2dOX42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cdLyKYlv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cdLyKYlv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C7D61570;
	Tue, 15 Sep 2026 08:49:50 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A550C3F882;
	Tue, 15 Sep 2026 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487394; bh=M6nqCi/crONOiSQCUR9ebCZXN0BqQCYtCGnaHG7Fm3U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cdLyKYlvjIsbO9h1g6r+fzgWKXudScU1Iv6uZNOzp5LiiEcQ9yWuWy8SLNVqbjv0m
	 BUEZXeRpsQ+417PqpCq3LKpipFp5gyocY3Z/TnIkoG1CXDM65LoVk7FslnE9w3P4J/
	 /2aV+o3o0tnBrwYuHzpVOtmMF22ZmhMtumh49vfM=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:05 +0100
Subject: [PATCH 19/25] perf cs-etm: Propagate errors from trace queue
 flushing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-19-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487341; l=3038;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=M6nqCi/crONOiSQCUR9ebCZXN0BqQCYtCGnaHG7Fm3U=;
 b=G4NLdPyQpLVOuFsk9+NyG+u9mJpgzbism1K/8D1yQs6qhKsCfH9hrgv5/wL71KrEZ/fCx2dph
 A/NmBRW20ARCjHe9BeGmMlW8B4U8qU0zu9kzPllQ32ZilECj7YlyCnc
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

cs_etm__flush() can fail while synthesizing or delivering a sample at a
trace discontinuity. cs_etm__process_traceid_queue() ignores the result
and continues even though the packet swap and thread stack flush may
not have completed.

The timestamped decoder also loses errors when it processes packets
left at the end of an AUX buffer: cs_etm__clear_all_traceid_queues()
discards the result from each trace ID queue and allows decoding to
fetch the next buffer.

Check the discontinuity flush result, make
cs_etm__clear_all_traceid_queues() return the first queue-processing
error, and propagate that error through
cs_etm__process_timestamped_queues(). This stops decoding on failure
and reports the error to the caller, including sample delivery errors
from a perf script dlfilter.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1a53431161e995ba6b3cfdc86e338ed26e675774..8340b8a16fed363795fc78ffbc419661a61442a3 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2644,10 +2644,13 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 			break;
 		case CS_ETM_DISCONTINUITY:
 			/*
-			 * Discontinuity in trace, flush
-			 * previous branch stack
+			 * Flush the previous branch stack at a discontinuity.
+			 * Propagate sample delivery errors, which can occur before
+			 * the packet swap and thread stack flush are complete.
 			 */
-			cs_etm__flush(etmq, tidq);
+			ret = cs_etm__flush(etmq, tidq);
+			if (ret)
+				goto out;
 			break;
 		case CS_ETM_EMPTY:
 			/*
@@ -2665,9 +2668,9 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 	return ret;
 }
 
-static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
+static int cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
 {
-	int idx;
+	int idx, ret;
 	struct int_node *inode;
 	struct cs_etm_traceid_queue *tidq;
 	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
@@ -2676,9 +2679,12 @@ static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
 		idx = (int)(intptr_t)inode->priv;
 		tidq = etmq->traceid_queues[idx];
 
-		/* Ignore return value */
-		cs_etm__process_traceid_queue(etmq, tidq);
+		ret = cs_etm__process_traceid_queue(etmq, tidq);
+		if (ret)
+			return ret;
 	}
+
+	return 0;
 }
 
 static int cs_etm__run_timeless_decoder(struct cs_etm_queue *etmq)
@@ -2893,7 +2899,9 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm,
 			 * process in this auxtrace_buffer.  As such empty and
 			 * flush all traceID queues.
 			 */
-			cs_etm__clear_all_traceid_queues(etmq);
+			ret = cs_etm__clear_all_traceid_queues(etmq);
+			if (ret)
+				goto out;
 
 			/* Fetch another auxtrace_buffer for this etmq */
 			goto refetch;

-- 
2.34.1

