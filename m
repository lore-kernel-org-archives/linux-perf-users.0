Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373215;
	b=JGZwuiejcT7APoPCgpuZ2t6phg2H5SCdGp8NRvGa6sGOL4Zt3nKREHXHJ5n2XI4PRKM7
	 mU131mtyfDJsf+IOlK0wogemh8xGwaqE6FkE+lGOR9yFMTKMIdEIAZ580ZSphwZpnqdya
	 R678FLp0ClEyBzz1kiRHFN1Yp852jEfX3gJCHnYKT9uImlKxbRcrB4xRYUivVevhzKgOM
	 yJ0dO78XNlY8I9Ib9UYHhuRi08M6nw/nME6tkg023tcomW3Z8K0FZIJ+7nw+hXd8HMRe+
	 Hm+1I7HxSBQNe/LO8DOtOu7FBozRhXN+Hd6Tr8LxJLG69xZ4VUOfNOonb0ybwSqlw7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373215;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zVQzlbm/axbBWxu0idKA4EVFIq0SJVIOwTqe3aaB750=;
	b=Cn7/DIY8+zNj6PlCyesCjcBSe/Np1xCFggi+SavTxq+6MrsyZjmTpbZpxKnxo0WjJoYo
	 PRKZNrlOFuWAi+Ze0axSrgaTKvPz0EfkkyubB2ZDtysmZ2tdy+pCGS4g+CwQY/XFnzVf1
	 Fx62CzLHeVxYf99z4/Inra3LCtlQGKDXQpgkq6QaeUoC/8fkbYYONe7e7l2hPG1HOkur8
	 hDV0zqvPz5g/y6kJPOubTiS7QcReo29V8UQ5FRFW5pbbfUvkdUCX17dcH1wh7sTf+NsU1
	 UYmxqHKYf89Ng7qKBgLjPxtH0xQ7E/B/GuiQPadLzOeQnqQtTQlo6kv2R0MPg62wcOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QCvl31bO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB760A2613;
	Fri, 30 Oct 2026 15:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDDB760A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QCvl31bO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 105181682;
	Fri, 30 Oct 2026 08:13:31 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA8613F59E;
	Fri, 30 Oct 2026 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373214; bh=IZ5g89KjjQVhG8DabVVL8mYXRbldOMIptBm7uGTdIHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QCvl31bO81hsMqCRIG7IvAKtG9EpsG1GTWZDaJju2sKQEVUWfNQHcOKJGazF8StLp
	 BsSdzQEKVFrfDErf+WL2pP/qeryxkkuniz2/SJDCylHAoeydjNMEN17dVIYOcDN9+E
	 I6OpPQDc26AEIi1uHiISyN+Y9BG4+pRuTgLmXEXw=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:11 +0000
Subject: [PATCH v3 04/14] perf cs-etm: Centralize packet ISA initialization
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
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-4-7629b52ab047@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=6522;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=IZ5g89KjjQVhG8DabVVL8mYXRbldOMIptBm7uGTdIHg=;
 b=FAMayDVqkvtNqud0uLZ4nRZib1P01Wxyoge8/8ClkBKGzleHcFz1M9vMp/tM2iHXzI6B/VyUL
 thxZ2U/H1pKDOVL5c2w1HMaaj9+r0kvHztxJPE9tL1OnU0T6RYrVA/r
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Exception packets need their own ISA so the frontend can generate samples
directly from them. Currently, ISA initialization is limited to instruction
range packets.

Move ISA initialization into cs_etm_decoder__buffer_packet() and use a
common helper to obtain it from the OpenCSD element. Populate the ISA for
instruction ranges, context updates and exceptions, leaving it unknown
for other element types.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 69 +++++++++++++++----------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 3fbb3fdf0382705bd4efa732c54ebb816144b2a8..911bb28db2985bc65828ad342ca5b0a8bb903e47 100644
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

