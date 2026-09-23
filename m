Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC4563FC3;
	Wed, 23 Sep 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176928; cv=none; b=dlNyWjKVLaKELuAFsGw4QFB3esZBxXa8Ob08nAaB7HXMkHgrhZ5Z3DczkspaXEV1P8Y1W839CfkG5cVmDF5A/bvLdsKz0qMLeE9ooR7hY4a9Rxgxy742Yvmr5yqlzIEXEJo3CrH3pxVeoNGSLtyJW9bJQe0D1NM2XnrIw1O2lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176928; c=relaxed/simple;
	bh=BkxK+LtxfryXBC5WzXodJ262cTbTi9UYj0rhj6FzdUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8LmBVPtKqQH6TJAf2HcvBFHqdMBSv8K7tVQ0tFuZyvcAoiZVMqcqIMPGzFUhakz6h8Wgcf+v1qSN4X8azt/iPupr2S8Nf/jHIaBLa4z2gQSfU5nn1YruUcaLwb3TEHTamnIVRgrWhfLjJwm9veCXufPIPrMxru6PX4ID7zIH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TCgyLxOs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TCgyLxOs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72CCB1CDD;
	Wed, 23 Sep 2026 08:22:02 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B979F3F86F;
	Wed, 23 Sep 2026 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176926; bh=BkxK+LtxfryXBC5WzXodJ262cTbTi9UYj0rhj6FzdUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TCgyLxOsWuFBYBSFK0MPm5WIDIBy5vHa3OJK2t+u8H+hg7cx4l6ZlVkp/T9Tr6W10
	 gTYn42IUTwy7HeB4iTou1epwV94ScUN6eOmvrX/l26EwYKFPFqI7wHZKaGJKWKC73A
	 DJmIUZmkyZoyYpoNNsozAzdw3qTDafdd09WQ4pnI=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:44 +0100
Subject: [PATCH v2 04/14] perf cs-etm: Centralize packet ISA initialization
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-4-6ab8c07a5455@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=6497;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=BkxK+LtxfryXBC5WzXodJ262cTbTi9UYj0rhj6FzdUU=;
 b=pv81NnNurnXrvgVqQnkkduobkB9PxVL6WeC1jErb5lURrX1NESRbLO47pQvkIflRvor5faD29
 acKioMvidioDXaZ3ud2OsMJddcvHQ89UTLT2WqSqRldNyeRaTWjmEqV
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Exception packets need their own ISA so the frontend can generate samples
directly from them. Currently, ISA initialization is limited to instruction
range packets.

Move ISA initialization into cs_etm_decoder__buffer_packet() and use a
common helper to obtain it from the OpenCSD element. Populate the ISA for
instruction ranges, context updates and exceptions, leaving it unknown
for other element types.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 69 +++++++++++++++----------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 35ca1a23e12735416d0d412a949595efc5bfe50a..469aba5e596a791289c5bcece132aba7b0baf6c3 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -368,9 +368,38 @@ cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
 	packet_queue->instr_count = 0;
 }
 
+static enum cs_etm_isa
+cs_etm_decoder__get_isa(const ocsd_generic_trace_elem *elem)
+{
+	/*
+	 * OpenCSD preserves ISA and context between output elements, including
+	 * exceptions after a context change with no intervening range.
+	 */
+	if (elem->elem_type != OCSD_GEN_TRC_ELEM_PE_CONTEXT &&
+	    elem->elem_type != OCSD_GEN_TRC_ELEM_INSTR_RANGE &&
+	    elem->elem_type != OCSD_GEN_TRC_ELEM_EXCEPTION)
+		return CS_ETM_ISA_UNKNOWN;
+
+	switch (elem->isa) {
+	case ocsd_isa_aarch64:
+		return CS_ETM_ISA_A64;
+	case ocsd_isa_arm:
+		return CS_ETM_ISA_A32;
+	case ocsd_isa_thumb2:
+		return CS_ETM_ISA_T32;
+	case ocsd_isa_tee:
+	case ocsd_isa_jazelle:
+	case ocsd_isa_custom:
+	case ocsd_isa_unknown:
+	default:
+		return CS_ETM_ISA_UNKNOWN;
+	}
+}
+
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 			      struct cs_etm_packet_queue *packet_queue,
+			      const ocsd_generic_trace_elem *elem,
 			      const u8 trace_chan_id,
 			      enum cs_etm_sample_type sample_type)
 {
@@ -389,7 +418,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
 	packet_queue->packet_count++;
 
 	packet_queue->packet_buffer[et].sample_type = sample_type;
-	packet_queue->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
+	packet_queue->packet_buffer[et].isa = cs_etm_decoder__get_isa(elem);
 	packet_queue->packet_buffer[et].cpu = cpu;
 	packet_queue->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
 	packet_queue->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
@@ -420,31 +449,13 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, trace_chan_id,
-					    CS_ETM_RANGE);
+	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, elem,
+					    trace_chan_id, CS_ETM_RANGE);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
 
 	packet = &packet_queue->packet_buffer[packet_queue->tail];
 
-	switch (elem->isa) {
-	case ocsd_isa_aarch64:
-		packet->isa = CS_ETM_ISA_A64;
-		break;
-	case ocsd_isa_arm:
-		packet->isa = CS_ETM_ISA_A32;
-		break;
-	case ocsd_isa_thumb2:
-		packet->isa = CS_ETM_ISA_T32;
-		break;
-	case ocsd_isa_tee:
-	case ocsd_isa_jazelle:
-	case ocsd_isa_custom:
-	case ocsd_isa_unknown:
-	default:
-		packet->isa = CS_ETM_ISA_UNKNOWN;
-	}
-
 	packet->start_addr = elem->st_addr;
 	packet->end_addr = elem->en_addr;
 	packet->instr_count = elem->num_instr_range;
@@ -483,6 +494,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
 				     struct cs_etm_packet_queue *queue,
+				     const ocsd_generic_trace_elem *elem,
 				     const uint8_t trace_chan_id)
 {
 	/*
@@ -490,7 +502,7 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
 	 * reset time statistics.
 	 */
 	cs_etm_decoder__reset_timestamp(queue);
-	return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(etmq, queue, elem, trace_chan_id,
 					     CS_ETM_DISCONTINUITY);
 }
 
@@ -502,7 +514,7 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 {	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(etmq, queue, elem, trace_chan_id,
 					    CS_ETM_EXCEPTION);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
@@ -516,9 +528,10 @@ cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
 				     struct cs_etm_packet_queue *queue,
+				     const ocsd_generic_trace_elem *elem,
 				     const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(etmq, queue, elem, trace_chan_id,
 					     CS_ETM_EXCEPTION_RET);
 }
 
@@ -555,8 +568,8 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 				elem->context.exception_level, tid))
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, trace_chan_id,
-					    CS_ETM_CONTEXT);
+	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, elem,
+					    trace_chan_id, CS_ETM_CONTEXT);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
 
@@ -597,7 +610,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	    type == OCSD_GEN_TRC_ELEM_TRACE_ON ||
 	    type == OCSD_GEN_TRC_ELEM_ADDR_NACC)
 		resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
-							    trace_chan_id);
+							    elem, trace_chan_id);
 	else if (type == OCSD_GEN_TRC_ELEM_INSTR_RANGE)
 		resp = cs_etm_decoder__buffer_range(etmq, packet_queue, elem,
 						    trace_chan_id);
@@ -606,7 +619,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 							trace_chan_id);
 	else if (type == OCSD_GEN_TRC_ELEM_EXCEPTION_RET)
 		resp = cs_etm_decoder__buffer_exception_ret(etmq, packet_queue,
-							    trace_chan_id);
+							    elem, trace_chan_id);
 	else if (type == OCSD_GEN_TRC_ELEM_TIMESTAMP)
 		resp = cs_etm_decoder__do_hard_timestamp(etmq, elem,
 							 trace_chan_id,

-- 
2.34.1

