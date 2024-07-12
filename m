Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6616CD30
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779747; cv=none; b=aS5iLlB9/mUGintCvce3YxY+8lAWtC74dcIalVpICblgouCdmghpDLNubNv3VpIdmnQPOS9z2Iyydvwv2VdKdmriywh5t0znrqUjD2WaDmwYKn0oRZD3xmBngAGvIYqUaLDD+V4l7/J6v54THDTuMed82jPpmtTtVO7QkoBtJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779747; c=relaxed/simple;
	bh=98G9foYRMUjXXVxFy/Md57/pICgXi8uBkrBtVIeU0EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oF9++PoRZ7R+jtfL18/siSOsoldxdKfxzxbhObHeC9rqqq4B9HiyVcnY3BBt29t9s0gxps8AIiyX/pC7iMa7zQK3mvAjOHeXwilg9wLd7NIBF3H64YvrFFdlEoAiN9hEyCiGxNircDk83JS6IJOcI+ipbwUWLiGW2t7HLg+ETbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OvfziPcb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvfziPcb"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36796bbf687so970357f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779744; x=1721384544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3qYpD2zLUt465de+5mKtywtrqrvAJh8zPnz4l2yJxM=;
        b=OvfziPcbUIjbiWhxCmjgqXPvHRvgrtZF8cBbEAt8uwsN7Rs2PtZ+6b470mYLwNq8Tw
         nfibIWDFEGyeIQKOdfH77bJxqVdji/HoK0inrfwGy9LK7JiBLnJ/O7yIDzU36/7j92HM
         hM5PTrmPKlhHvWyc0ZJjeLlnl9gV2r4TxES3pApPZBsRhYb8VD0ew46+DtW+oyASmz1H
         nRxZf7Ris6ULJaCWXF+jK8SrOa5w6D5Pi78q+0jfSspUFDHp/UJYcoBML45jQ379hDbr
         joaO5KJRyUVCjgx1DH5ZV6bIOSFuEyvthlpawQD4ZmK34BMS1PqHMbM7bX1r2PDavGAc
         opTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779744; x=1721384544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3qYpD2zLUt465de+5mKtywtrqrvAJh8zPnz4l2yJxM=;
        b=dRBwkxWSIh8DP1Rhx6rIRy8dC7SnvgEzL22+XvjeYMHTll4xxjioyrTfOd8Is9oyRr
         PdZjNPw6q/NqDpV6XuJyfgThc+vlte/RsW9gXvWuiaNVT1rWvSrYGIohuQYE9h4vkE6v
         QeNQhlW2wGcrIz1jgGJE2256/8FQp2FxsyuCPq+9huBFf5qNxpDv+FMk/t+JCz/gseVj
         toTbXpc6YVY73BFHVXL6e//6cWkAN+YAqkn0kk/5+XmQy1xMXLLitytoCwUwr5UFd+Hw
         5eBG1fBmiqTRTYtEUKcZdRomqdanrz/luiw/02I1PmgCUaGJyJnPqMigcHFbcueeVhE9
         pQvA==
X-Forwarded-Encrypted: i=1; AJvYcCXnxQCeIUrZ4a/7Tq1BZQnEkqhKe3Lbqqo4dXFLvi3pQdIlNcBYmpIShLSBnguiQ9Z+S/i5Ic2Rn+H52MarLN0NVKUir8mK6bILRbKNnqrZTg==
X-Gm-Message-State: AOJu0YzEmAhzY/kqeT28GDYsbDQVKMP26TNgq+9kzF0Dccfb5vKisYfk
	ckWeLeKDGrjZ9M2ky2sH9IxUbpxIKJlZDGeZ3FAVajQ1fEMzzH/pOpLjXDa+Id4=
X-Google-Smtp-Source: AGHT+IFzLqtby0cMKhUUxByZ9tsX8ure+00+up1AP7/5aUoOon/Zw8QixzPbi2uHIkmDcKbs4RncMw==
X-Received: by 2002:a05:6000:124a:b0:362:ebf5:3fd with SMTP id ffacd0b85a97d-367cea8f981mr6852656f8f.30.1720779743942;
        Fri, 12 Jul 2024 03:22:23 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 03/17] perf: cs-etm: Move traceid_list to each queue
Date: Fri, 12 Jul 2024 11:20:12 +0100
Message-Id: <20240712102029.3697965-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

The global list won't work for per-sink trace ID allocations, so put a
list in each queue where the IDs will be unique to that queue.

To keep the same behavior as before, for version 0 of the HW_ID packets,
copy all the HW_ID mappings into all queues.

This change doesn't effect the decoders, only trace ID lookups on the
Perf side. The decoders are still created with global mappings which
will be fixed in a later commit.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  28 ++-
 tools/perf/util/cs-etm.c                      | 215 +++++++++++-------
 tools/perf/util/cs-etm.h                      |   2 +-
 3 files changed, 147 insertions(+), 98 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e917985bbbe6..0c9c48cedbf1 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -388,7 +388,8 @@ cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
+cs_etm_decoder__buffer_packet(struct cs_etm_queue *etmq,
+			      struct cs_etm_packet_queue *packet_queue,
 			      const u8 trace_chan_id,
 			      enum cs_etm_sample_type sample_type)
 {
@@ -398,7 +399,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_packet_queue *packet_queue,
 	if (packet_queue->packet_count >= CS_ETM_PACKET_MAX_BUFFER - 1)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
-	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
+	if (cs_etm__get_cpu(etmq, trace_chan_id, &cpu) < 0)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
 	et = packet_queue->tail;
@@ -436,7 +437,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(packet_queue, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(etmq, packet_queue, trace_chan_id,
 					    CS_ETM_RANGE);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
@@ -496,7 +497,8 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_discontinuity(struct cs_etm_queue *etmq,
+				     struct cs_etm_packet_queue *queue,
 				     const uint8_t trace_chan_id)
 {
 	/*
@@ -504,18 +506,19 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_packet_queue *queue,
 	 * reset time statistics.
 	 */
 	cs_etm_decoder__reset_timestamp(queue);
-	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					     CS_ETM_DISCONTINUITY);
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_exception(struct cs_etm_queue *etmq,
+				 struct cs_etm_packet_queue *queue,
 				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
 {	int ret = 0;
 	struct cs_etm_packet *packet;
 
-	ret = cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	ret = cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					    CS_ETM_EXCEPTION);
 	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
 		return ret;
@@ -527,10 +530,11 @@ cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
 }
 
 static ocsd_datapath_resp_t
-cs_etm_decoder__buffer_exception_ret(struct cs_etm_packet_queue *queue,
+cs_etm_decoder__buffer_exception_ret(struct cs_etm_queue *etmq,
+				     struct cs_etm_packet_queue *queue,
 				     const uint8_t trace_chan_id)
 {
-	return cs_etm_decoder__buffer_packet(queue, trace_chan_id,
+	return cs_etm_decoder__buffer_packet(etmq, queue, trace_chan_id,
 					     CS_ETM_EXCEPTION_RET);
 }
 
@@ -599,7 +603,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_EO_TRACE:
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
-		resp = cs_etm_decoder__buffer_discontinuity(packet_queue,
+		resp = cs_etm_decoder__buffer_discontinuity(etmq, packet_queue,
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
@@ -607,11 +611,11 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(packet_queue, elem,
+		resp = cs_etm_decoder__buffer_exception(etmq, packet_queue, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
-		resp = cs_etm_decoder__buffer_exception_ret(packet_queue,
+		resp = cs_etm_decoder__buffer_exception_ret(etmq, packet_queue,
 							    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1a95c4bb898f..0cd7d3843411 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -116,16 +116,18 @@ struct cs_etm_queue {
 	/* Conversion between traceID and index in traceid_queues array */
 	struct intlist *traceid_queues_list;
 	struct cs_etm_traceid_queue **traceid_queues;
+	/* Conversion between traceID and metadata pointers */
+	struct intlist *traceid_list;
 };
 
-/* RB tree for quick conversion between traceID and metadata pointers */
-static struct intlist *traceid_list;
-
 static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
 static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
+static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata);
+static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu);
+static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
 
 /* PTMs ETMIDR [11:8] set to b0011 */
 #define ETMIDR_PTM_VERSION 0x00000300
@@ -151,12 +153,12 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 	return CS_ETM_PROTO_ETMV3;
 }
 
-static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
+static int cs_etm__get_magic(struct cs_etm_queue *etmq, u8 trace_chan_id, u64 *magic)
 {
 	struct int_node *inode;
 	u64 *metadata;
 
-	inode = intlist__find(traceid_list, trace_chan_id);
+	inode = intlist__find(etmq->traceid_list, trace_chan_id);
 	if (!inode)
 		return -EINVAL;
 
@@ -165,12 +167,12 @@ static int cs_etm__get_magic(u8 trace_chan_id, u64 *magic)
 	return 0;
 }
 
-int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
+int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu)
 {
 	struct int_node *inode;
 	u64 *metadata;
 
-	inode = intlist__find(traceid_list, trace_chan_id);
+	inode = intlist__find(etmq->traceid_list, trace_chan_id);
 	if (!inode)
 		return -EINVAL;
 
@@ -222,30 +224,108 @@ enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq)
 	return etmq->etm->pid_fmt;
 }
 
-static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
+static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
+					u8 trace_chan_id, u64 *cpu_metadata)
 {
-	struct int_node *inode;
-
 	/* Get an RB node for this CPU */
-	inode = intlist__findnew(traceid_list, trace_chan_id);
+	struct int_node *inode = intlist__findnew(etmq->traceid_list, trace_chan_id);
 
 	/* Something went wrong, no need to continue */
 	if (!inode)
 		return -ENOMEM;
 
+	/* Disallow re-mapping a different traceID to metadata pair. */
+	if (inode->priv) {
+		u64 *curr_cpu_data = inode->priv;
+		u8 curr_chan_id;
+		int err;
+
+		if (curr_cpu_data[CS_ETM_CPU] != cpu_metadata[CS_ETM_CPU]) {
+			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
+			return -EINVAL;
+		}
+
+		/* check that the mapped ID matches */
+		err = cs_etm__metadata_get_trace_id(&curr_chan_id, curr_cpu_data);
+		if (err)
+			return err;
+
+		if (curr_chan_id != trace_chan_id) {
+			pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
+			return -EINVAL;
+		}
+
+		/* Skip re-adding the same mappings if everything matched */
+		return 0;
+	}
+
+	/* Not one we've seen before, associate the traceID with the metadata pointer */
+	inode->priv = cpu_metadata;
+
+	return 0;
+}
+
+static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
+{
+	if (etm->per_thread_decoding)
+		return etm->queues.queue_array[0].priv;
+	else
+		return etm->queues.queue_array[cpu].priv;
+}
+
+static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id,
+				   u64 *cpu_metadata)
+{
+	struct cs_etm_queue *etmq;
+
 	/*
-	 * The node for that CPU should not be taken.
-	 * Back out if that's the case.
+	 * If the queue is unformatted then only save one mapping in the
+	 * queue associated with that CPU so only one decoder is made.
 	 */
-	if (inode->priv)
-		return -EINVAL;
+	etmq = cs_etm__get_queue(etm, cpu_metadata[CS_ETM_CPU]);
+	if (etmq->format == UNFORMATTED)
+		return cs_etm__insert_trace_id_node(etmq, trace_chan_id,
+						    cpu_metadata);
 
-	/* All good, associate the traceID with the metadata pointer */
-	inode->priv = cpu_metadata;
+	/*
+	 * Otherwise, version 0 trace IDs are global so save them into every
+	 * queue.
+	 */
+	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
+		int ret;
+
+		etmq = etm->queues.queue_array[i].priv;
+		ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id,
+						   cpu_metadata);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
+static int cs_etm__process_trace_id_v0(struct cs_etm_auxtrace *etm, int cpu,
+				       u64 hw_id)
+{
+	int err;
+	u64 *cpu_data;
+	u8 trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
+
+	cpu_data = get_cpu_data(etm, cpu);
+	if (cpu_data == NULL)
+		return -EINVAL;
+
+	err = cs_etm__map_trace_id_v0(etm, trace_chan_id, cpu_data);
+	if (err)
+		return err;
+
+	/*
+	 * if we are picking up the association from the packet, need to plug
+	 * the correct trace ID into the metadata for setting up decoders later.
+	 */
+	return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
+}
+
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
 {
 	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
@@ -329,17 +409,13 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 {
 	struct cs_etm_auxtrace *etm;
 	struct perf_sample sample;
-	struct int_node *inode;
 	struct evsel *evsel;
-	u64 *cpu_data;
 	u64 hw_id;
 	int cpu, version, err;
-	u8 trace_chan_id, curr_chan_id;
 
 	/* extract and parse the HW ID */
 	hw_id = event->aux_output_hw_id.hw_id;
 	version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
-	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
 
 	/* check that we can handle this version */
 	if (version > CS_AUX_HW_ID_CURR_VERSION) {
@@ -367,43 +443,7 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 		return -EINVAL;
 	}
 
-	/* See if the ID is mapped to a CPU, and it matches the current CPU */
-	inode = intlist__find(traceid_list, trace_chan_id);
-	if (inode) {
-		cpu_data = inode->priv;
-		if ((int)cpu_data[CS_ETM_CPU] != cpu) {
-			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
-			return -EINVAL;
-		}
-
-		/* check that the mapped ID matches */
-		err = cs_etm__metadata_get_trace_id(&curr_chan_id, cpu_data);
-		if (err)
-			return err;
-		if (curr_chan_id != trace_chan_id) {
-			pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
-			return -EINVAL;
-		}
-
-		/* mapped and matched - return OK */
-		return 0;
-	}
-
-	cpu_data = get_cpu_data(etm, cpu);
-	if (cpu_data == NULL)
-		return err;
-
-	/* not one we've seen before - lets map it */
-	err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
-	if (err)
-		return err;
-
-	/*
-	 * if we are picking up the association from the packet, need to plug
-	 * the correct trace ID into the metadata for setting up decoders later.
-	 */
-	err = cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
-	return err;
+	return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
 }
 
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
@@ -856,6 +896,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 
 static void cs_etm__free_queue(void *priv)
 {
+	struct int_node *inode, *tmp;
 	struct cs_etm_queue *etmq = priv;
 
 	if (!etmq)
@@ -863,6 +904,14 @@ static void cs_etm__free_queue(void *priv)
 
 	cs_etm_decoder__free(etmq->decoder);
 	cs_etm__free_traceid_queues(etmq);
+
+	/* First remove all traceID/metadata nodes for the RB tree */
+	intlist__for_each_entry_safe(inode, tmp, etmq->traceid_list)
+		intlist__remove(etmq->traceid_list, inode);
+
+	/* Then the RB tree itself */
+	intlist__delete(etmq->traceid_list);
+
 	free(etmq);
 }
 
@@ -885,19 +934,12 @@ static void cs_etm__free_events(struct perf_session *session)
 static void cs_etm__free(struct perf_session *session)
 {
 	int i;
-	struct int_node *inode, *tmp;
 	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
 	cs_etm__free_events(session);
 	session->auxtrace = NULL;
 
-	/* First remove all traceID/metadata nodes for the RB tree */
-	intlist__for_each_entry_safe(inode, tmp, traceid_list)
-		intlist__remove(traceid_list, inode);
-	/* Then the RB tree itself */
-	intlist__delete(traceid_list);
-
 	for (i = 0; i < aux->num_cpu; i++)
 		zfree(&aux->metadata[i]);
 
@@ -1055,9 +1097,24 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 
 	etmq->traceid_queues_list = intlist__new(NULL);
 	if (!etmq->traceid_queues_list)
-		free(etmq);
+		goto out_free;
+
+	/*
+	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
+	 * has to be made for each packet that gets decoded, optimizing access
+	 * in anything other than a sequential array is worth doing.
+	 */
+	etmq->traceid_list = intlist__new(NULL);
+	if (!etmq->traceid_list)
+		goto out_free;
 
 	return etmq;
+
+out_free:
+	intlist__delete(etmq->traceid_queues_list);
+	free(etmq);
+
+	return NULL;
 }
 
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
@@ -2207,7 +2264,7 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 					      PERF_IP_FLAG_TRACE_END;
 		break;
 	case CS_ETM_EXCEPTION:
-		ret = cs_etm__get_magic(packet->trace_chan_id, &magic);
+		ret = cs_etm__get_magic(etmq, packet->trace_chan_id, &magic);
 		if (ret)
 			return ret;
 
@@ -3124,7 +3181,8 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
 }
 
 /* map trace ids to correct metadata block, from information in metadata */
-static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
+static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm, int num_cpu,
+					  u64 **metadata)
 {
 	u64 cs_etm_magic;
 	u8 trace_chan_id;
@@ -3146,7 +3204,7 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
 			/* unknown magic number */
 			return -EINVAL;
 		}
-		err = cs_etm__map_trace_id(trace_chan_id, metadata[i]);
+		err = cs_etm__map_trace_id_v0(etm, trace_chan_id, metadata[i]);
 		if (err)
 			return err;
 	}
@@ -3277,23 +3335,12 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	u64 *ptr = NULL;
 	u64 **metadata = NULL;
 
-	/*
-	 * Create an RB tree for traceID-metadata tuple.  Since the conversion
-	 * has to be made for each packet that gets decoded, optimizing access
-	 * in anything other than a sequential array is worth doing.
-	 */
-	traceid_list = intlist__new(NULL);
-	if (!traceid_list)
-		return -ENOMEM;
-
 	/* First the global part */
 	ptr = (u64 *) auxtrace_info->priv;
 	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
 	metadata = zalloc(sizeof(*metadata) * num_cpu);
-	if (!metadata) {
-		err = -ENOMEM;
-		goto err_free_traceid_list;
-	}
+	if (!metadata)
+		return -ENOMEM;
 
 	/* Start parsing after the common part of the header */
 	i = CS_HEADER_VERSION_MAX;
@@ -3472,7 +3519,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
 	/* otherwise, this is a file with metadata values only, map from metadata */
 	else
-		err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
+		err = cs_etm__map_trace_ids_metadata(etm, num_cpu, metadata);
 
 	if (err)
 		goto err_free_queues;
@@ -3494,7 +3541,5 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	for (int j = 0; j < num_cpu; j++)
 		zfree(&metadata[j]);
 	zfree(&metadata);
-err_free_traceid_list:
-	intlist__delete(traceid_list);
 	return err;
 }
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index 4696267a32f0..f4f69f7cc0f3 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -252,7 +252,7 @@ enum cs_etm_pid_fmt {
 
 #ifdef HAVE_CSTRACE_SUPPORT
 #include <opencsd/ocsd_if_types.h>
-int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
+int cs_etm__get_cpu(struct cs_etm_queue *etmq, u8 trace_chan_id, int *cpu);
 enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
 int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
 			    u8 trace_chan_id, ocsd_ex_level el);
-- 
2.34.1

