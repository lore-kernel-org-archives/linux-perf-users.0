Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07794333448
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Oct 2025 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143350; cv=none; b=KR5KDf5KJHTMszlpjNd/TfQvIViiIaasM1pfg1ndJQJVzZdhQ1iQrsBHqo0v0Rht+ek1WoHyJpxM8NTAY9CChLwVRIL9t0Fduy5t7dlRGAO5/J6ZpXCUUgu8HDvhtvUaqMoRiKHwedV8sQ+tb4S3GssNnJHNUa6VF48OvULEA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143350; c=relaxed/simple;
	bh=YDzN9FAdSnljYvnJxEGhsgDoddgCVmvOT4gkC/3Mks0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=axS3aWMBNsum5Dh0gQPfKxzFD1c5Ni+H7haSsD74YzHvtDDcbNOwO6wMcFv1Go+omkjT0Hn7MMGBtVbz9ufHu0mO0AO3mJRU94R8YkvvAgEd5OVGugzKcVlIOn+X5TtpkktnGl5z5NmahH+DT10DAWdUELN3xR6MybzC1Mbq7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A0511063;
	Wed, 22 Oct 2025 07:28:59 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BF293F59E;
	Wed, 22 Oct 2025 07:29:05 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] perf cs-etm: Mute enumeration value warning
Date: Wed, 22 Oct 2025 15:28:49 +0100
Message-Id: <20251022142849.1537706-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the OpenCSD library introduces a new enumeration value (for example,
in the v1.7.1 release), the perf build fails with an error:

  util/cs-etm-decoder/cs-etm-decoder.c:600:10: error: enumeration value 'OCSD_GEN_TRC_ELEM_ITMTRACE' not explicitly handled in switch [-Werror, -Wswitch-enum]
    600 |         switch (elem->elem_type) {
	|                 ^~~~~~~~~~~~~~~
  1 error generated.

Convert to if-else sentences to mute the enumeration value warning,
which can avoid build failures whenever the lib is updated.

No functional change.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 44 +++++--------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index b85a8837bddc..3050fe212666 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -588,6 +588,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 				const ocsd_generic_trace_elem *elem)
 {
 	ocsd_datapath_resp_t resp = OCSD_RESP_CONT;
+	ocsd_gen_trc_elem_t type;
 	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
 	struct cs_etm_queue *etmq = decoder->data;
 	struct cs_etm_packet_queue *packet_queue;
@@ -597,52 +598,29 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	if (!packet_queue)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	switch (elem->elem_type) {
-	case OCSD_GEN_TRC_ELEM_UNKNOWN:
-		break;
-	case OCSD_GEN_TRC_ELEM_EO_TRACE:
-	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-	case OCSD_GEN_TRC_ELEM_TRACE_ON:
+	type = elem->elem_type;
+
+	if (type == OCSD_GEN_TRC_ELEM_EO_TRACE ||
+	    type == OCSD_GEN_TRC_ELEM_NO_SYNC ||
+	    type == OCSD_GEN_TRC_ELEM_TRACE_ON)
 		resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
 							    trace_chan_id);
-		break;
-	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
+	else if (type == OCSD_GEN_TRC_ELEM_INSTR_RANGE)
 		resp = cs_etm_decoder__buffer_range(etmq, packet_queue, elem,
 						    trace_chan_id);
-		break;
-	case OCSD_GEN_TRC_ELEM_EXCEPTION:
+	else if (type == OCSD_GEN_TRC_ELEM_EXCEPTION)
 		resp = cs_etm_decoder__buffer_exception(etmq, packet_queue, elem,
 							trace_chan_id);
-		break;
-	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
+	else if (type == OCSD_GEN_TRC_ELEM_EXCEPTION_RET)
 		resp = cs_etm_decoder__buffer_exception_ret(etmq, packet_queue,
 							    trace_chan_id);
-		break;
-	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
+	else if (type == OCSD_GEN_TRC_ELEM_TIMESTAMP)
 		resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
 							 trace_chan_id,
 							 indx);
-		break;
-	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
+	else if (type == OCSD_GEN_TRC_ELEM_PE_CONTEXT)
 		resp = cs_etm_decoder__set_tid(etmq, packet_queue,
 					       elem, trace_chan_id);
-		break;
-	/* Unused packet types */
-	case OCSD_GEN_TRC_ELEM_I_RANGE_NOPATH:
-	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
-	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
-	case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
-	case OCSD_GEN_TRC_ELEM_EVENT:
-	case OCSD_GEN_TRC_ELEM_SWTRACE:
-	case OCSD_GEN_TRC_ELEM_CUSTOM:
-	case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
-	case OCSD_GEN_TRC_ELEM_MEMTRANS:
-#if (OCSD_VER_NUM >= 0x010400)
-	case OCSD_GEN_TRC_ELEM_INSTRUMENTATION:
-#endif
-	default:
-		break;
-	}
 
 	return resp;
 }
-- 
2.34.1

