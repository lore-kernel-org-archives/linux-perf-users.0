Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438BB4C1516;
	Tue, 15 Sep 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487402; cv=none; b=fcoh6zHrhwhf45Kd/fJWtkdLeDqzHdv63MHMaade9AieSs7O+aCLKo1hY4qgm2r/i8Ccas1WgeMj4Zx8eYDPlZy3MQ3S7J39EOwgaA/QkAyNgoqyFIP9RE5NicmssZUQeTlkVtMN8hFc124DYVrHtze0R/SG/a1AW/6I6Lb1Fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487402; c=relaxed/simple;
	bh=HljhFJEqlq7f7W2DVP9TBWkK9RJ5OJM0OyDY6TKa7aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mY03BQ6mHHN+7fOZWnLDqVulUaMM4QCtM4PIXUrVYTzUXRTr0iE8HqWVO6S4x9fogwqrjAdgJHi4vyRLSefE40w6sqkreNFzu0chE3tLFpinNnIHtRvTtdRC+Nk8fQGKnn7LjQOGbmylqBHAWvIFG0SOq2AyEpunh4BTziUGY+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YrouDpNp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YrouDpNp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B85491570;
	Tue, 15 Sep 2026 08:49:55 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0A9C3F882;
	Tue, 15 Sep 2026 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487399; bh=HljhFJEqlq7f7W2DVP9TBWkK9RJ5OJM0OyDY6TKa7aA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YrouDpNp8SZ2QE0byjuIbn4UIH71Pv+tBu/JVzTQEN/ByKG/NR3Dc7y3G+AHSduIh
	 0xAhYO6MvCILzSJfiRGwCuIGPlkVUbq6lzNdOmWiMdJ2ngt9dWFO10Fbtb+viClnbv
	 5do8HDKn1XPYcTqjFG1IjlHGeLpSh9WGiCxKDDdw=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:07 +0100
Subject: [PATCH 21/25] perf cs-etm: Complete packet draining with end of
 trace
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-21-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487341; l=4028;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=HljhFJEqlq7f7W2DVP9TBWkK9RJ5OJM0OyDY6TKa7aA=;
 b=o4v41o6wGnQSWzRh19HpHqvnPSpr3ZFpJWJvM/Kdl1h0QFmJjWhexacHQOm9rKrwolJzWC1r0
 9BXw4L71Mb6B3g4LxsHg9VlZYNN7xwD1DVYZSiOvNO9N5I0PkB3K2YU
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

OpenCSD can retain output at the end of an input block even after
returning CONT. WAIT driven flushing alone does not use out that output
before the decoder is reset for the next block.

Submit OCSD_OP_EOT from cs_etm_decoder__drain_packets() after any
pending WAIT response has been flushed. Track submission with the
eot_sent flag and clear it on reset, make sure to submit EOT only once.
This applies to timeless decoding, timestamped decoding and raw packet
dumping through their existing drain calls.

Return OCSD_RESP_CONT for a clean EOT without queuing a discontinuity.
This lets the frontend finish draining while preserving trace history
for sample processing. EOT reporting trace loss, NO_SYNC and TRACE_ON
still generate discontinuities and flush the thread stack.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 24 +++++++++++++++++++++++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  2 +-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index a7a6410481e5c99be14a951493092c145a8512ba..0fcbf91aac63bcc5c40bf1453359d3be3ece684f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -46,6 +46,7 @@ struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg, void *data);
 	bool suppress_printing;
+	bool eot_sent;
 	dcd_tree_handle_t dcd_tree;
 	cs_etm_mem_cb_type mem_access;
 	ocsd_datapath_resp_t prev_return;
@@ -86,6 +87,7 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
 	ocsd_datapath_resp_t dp_ret;
 
 	decoder->prev_return = OCSD_RESP_CONT;
+	decoder->eot_sent = false;
 	decoder->suppress_printing = true;
 	dp_ret = ocsd_dt_process_data(decoder->dcd_tree, OCSD_OP_RESET,
 				      0, 0, NULL, NULL);
@@ -592,6 +594,17 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 
 	type = elem->elem_type;
 
+	/*
+	 * The frontend uses EOT to drain packets buffered in OpenCSD at the
+	 * end of a data block. Return CONT for a clean EOT so the frontend
+	 * can finish draining without generating a discontinuity, preserving
+	 * trace history for sample processing. EOTs reporting trace loss
+	 * still generate a discontinuity below.
+	 */
+	if (type == OCSD_GEN_TRC_ELEM_EO_TRACE &&
+	    elem->unsync_eot_info == UNSYNC_EOT)
+		return OCSD_RESP_CONT;
+
 	if (type == OCSD_GEN_TRC_ELEM_EO_TRACE ||
 	    type == OCSD_GEN_TRC_ELEM_NO_SYNC ||
 	    type == OCSD_GEN_TRC_ELEM_TRACE_ON)
@@ -803,10 +816,19 @@ int cs_etm_decoder__drain_packets(struct cs_etm_decoder *decoder)
 							    NULL,
 							    NULL);
 
+	if (OCSD_DATA_RESP_IS_CONT(decoder->prev_return) && !decoder->eot_sent) {
+		decoder->prev_return = ocsd_dt_process_data(decoder->dcd_tree,
+							    OCSD_OP_EOT,
+							    0,
+							    0,
+							    NULL,
+							    NULL);
+		decoder->eot_sent = true;
+	}
+
 	if (OCSD_DATA_RESP_IS_WAIT(decoder->prev_return))
 		return 1;
 
-	/* No further WAIT driven flushing is needed */
 	return OCSD_DATA_RESP_IS_CONT(decoder->prev_return) ? 0 : -EINVAL;
 }
 
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index c187f3809ba0a350ca6ee549d2c0c67ed8e16d1e..876b28f6fda099db5694fdfa9552104cc270b49a 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -92,7 +92,7 @@ int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
 				       size_t len, size_t *consumed);
 
 /*
- * Drain pending packets after consuming a data block.
+ * Drain pending packets and submit EOT once after consuming a data block.
  * Process queued packets after each call, including the final call.
  * Returns 1 for WAIT, 0 when done, or a negative error.
  */

-- 
2.34.1

