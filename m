Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994D16E897
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779760; cv=none; b=LyO2bC8tan1zShj8245aJj3n0spJ5EiXFNKBOCEily9xN/01l3cgWGMaVoVI8OFq3tlkhiH90qTZhNKMRrHtEybcA5gM9jEvVdkv2uIzzGadkH7kvkjtbADwWDfHsXtcVqFzywrve+ABwtcV+NKudIA2mk8Pj6blZBimNJeNF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779760; c=relaxed/simple;
	bh=n1V4Mkku0PXIyMtnBnYi1DY09b7H/0UV0oib0b5cUZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgDRsYnJETdx2sY1ISEbfmCBCsLP5mMQIKznJeliKHxc1TGbXG/BRlgPs/jy4i7XNdcPHY0yuQuidxAdP6Zznb45AglwPDgWlGhS/r4Hb5GWC8TXy/itDLz1mBETtP2ctbqtfM7fCL+Df0PCpJq/dmAuHsKJX+xS083W3Lr82Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFe1qbbE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFe1qbbE"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so14614975e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779757; x=1721384557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah9k75BJOaZTXMfLc9XJp4ghTXY2y5r0z+Y/ysHuLQg=;
        b=nFe1qbbETeMHFU+uVv7i9DMOHW7+YCnco88Ds5WoaG8GkCmZvtPAVIxZaWaiu7CKNt
         7Y8huEzfrhi6rX1IWLkcPt8gzR5/4zYLt//uHMJH8PPCogbIWQjnN7hUja/ilVC4LCJ6
         LFMQeYB2IkCSjgfRyZjEEDn0qEP76LkXzAtrVMKPTMnkkgaRqpzZo8EDWEP/0cA3ZuHm
         SlPar8s5PR0/Gh6mfWUPGHIWti+aLRrmOiHEw06+p9Cz4QGaDcTG9tVRZvQYGEBjmAst
         xt4MdsWeM0SlJEX8t1eOEmAC6BSJwXjmzGs50zlnxlzkrSY8MtvV2mmjT6eNpsNb3gs3
         y1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779757; x=1721384557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ah9k75BJOaZTXMfLc9XJp4ghTXY2y5r0z+Y/ysHuLQg=;
        b=mIWB93AsKJdaeHYwVcCPqXDY58hbnQ0g1iT6QMJss3exB+t4/wbbK5AvjN7DHIGfWq
         5SKpcdykAczFirF+L6Usv781O15EmUN190dI8qpZXuQuPClVw/5tUNzmcplV3pmal6Hv
         KsyFPnpbMoMWaTLISsnJZjwI+4dhd+31NNOeZk/lk3EJQHYeID1IpvW3ViA4LUkSDXOK
         HBaLkXghZJ0QjBO32uQoxOl8yr+wi1khkkgvvUWe6X9OMu2K7xkotBxsioMXvB538WTW
         GGK/QAU4+c5hAIVHQofAADaQTCx/iHMLfKyn23/8i/FEwv7QvohHcc5kVaYoS1af1F+7
         NViA==
X-Forwarded-Encrypted: i=1; AJvYcCWbZmf4ptwPnDtoSRVMQzkGoNz+AUAwwDB4i3OYxU/1LVHGX2ECa4VAoxACUus8bpKpnM1dR8mLxzXHXu4HstL/s1W8qnOyf+ogikIRsQ/3DQ==
X-Gm-Message-State: AOJu0YyyvXLH4xDGqmELNZ1ah+X6oyOD4MXOX/GQpoI9+b5/ym0W8FpO
	tS752mV+XZhDm3oow0RI/hOd/aoXF3pLJWbSJChcdQj992jPRiEvVy2lJp++yBc=
X-Google-Smtp-Source: AGHT+IGPEcqwdD8/75nBwHmz7V9EEZVfCM0YjiLJhzeXNzNdPm7q7nELUcwtmZAqeXOP8tC5MYlBkg==
X-Received: by 2002:adf:ae52:0:b0:35f:3189:ddd2 with SMTP id ffacd0b85a97d-367cea961bbmr8483699f8f.35.1720779757207;
        Fri, 12 Jul 2024 03:22:37 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:36 -0700 (PDT)
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
Subject: [PATCH v5 06/17] perf: cs-etm: Support version 0.1 of HW_ID packets
Date: Fri, 12 Jul 2024 11:20:15 +0100
Message-Id: <20240712102029.3697965-7-james.clark@linaro.org>
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

v0.1 HW_ID packets have a new field that describes which sink each CPU
writes to. Use the sink ID to link trace ID maps to each other so that
mappings are shared wherever the sink is shared.

Also update the error message to show that overlapping IDs aren't an
error in per-thread mode, just not supported. In the future we can
use the CPU ID from the AUX records, or watch for changing sink IDs on
HW_ID packets to use the correct decoders.

Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/linux/coresight-pmu.h |  17 +++--
 tools/perf/util/cs-etm.c            | 100 +++++++++++++++++++++++++---
 2 files changed, 103 insertions(+), 14 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 51ac441a37c3..89b0ac0014b0 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -49,12 +49,21 @@
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.
  * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
- * [59:08] - Unused (SBZ)
- * [63:60] - Version
+ * [39:08] - Sink ID - as reported in /sys/bus/event_source/devices/cs_etm/sinks/
+ *	      Added in minor version 1.
+ * [55:40] - Unused (SBZ)
+ * [59:56] - Minor Version - previously existing fields are compatible with
+ *	      all minor versions.
+ * [63:60] - Major Version - previously existing fields mean different things
+ *	      in new major versions.
  */
 #define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
-#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+#define CS_AUX_HW_ID_SINK_ID_MASK	GENMASK_ULL(39, 8)
 
-#define CS_AUX_HW_ID_CURR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION_MASK	GENMASK_ULL(59, 56)
+#define CS_AUX_HW_ID_MAJOR_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_MAJOR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION 1
 
 #endif
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 954a6f7bedf3..87e983da19be 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -118,6 +118,12 @@ struct cs_etm_queue {
 	struct cs_etm_traceid_queue **traceid_queues;
 	/* Conversion between traceID and metadata pointers */
 	struct intlist *traceid_list;
+	/*
+	 * Same as traceid_list, but traceid_list may be a reference to another
+	 * queue's which has a matching sink ID.
+	 */
+	struct intlist *own_traceid_list;
+	u32 sink_id;
 };
 
 static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
@@ -142,6 +148,7 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
 		      (queue_nr << 16 | trace_chan_id)
 #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
 #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
+#define SINK_UNSET ((u32) -1)
 
 static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 {
@@ -241,7 +248,16 @@ static int cs_etm__insert_trace_id_node(struct cs_etm_queue *etmq,
 		int err;
 
 		if (curr_cpu_data[CS_ETM_CPU] != cpu_metadata[CS_ETM_CPU]) {
-			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
+			/*
+			 * With > CORESIGHT_TRACE_IDS_MAX ETMs, overlapping IDs
+			 * are expected (but not supported) in per-thread mode,
+			 * rather than signifying an error.
+			 */
+			if (etmq->etm->per_thread_decoding)
+				pr_err("CS_ETM: overlapping Trace IDs aren't currently supported in per-thread mode\n");
+			else
+				pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
+
 			return -EINVAL;
 		}
 
@@ -326,6 +342,64 @@ static int cs_etm__process_trace_id_v0(struct cs_etm_auxtrace *etm, int cpu,
 	return cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
 }
 
+static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace *etm, int cpu,
+					 u64 hw_id)
+{
+	struct cs_etm_queue *etmq = cs_etm__get_queue(etm, cpu);
+	int ret;
+	u64 *cpu_data;
+	u32 sink_id = FIELD_GET(CS_AUX_HW_ID_SINK_ID_MASK, hw_id);
+	u8 trace_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
+
+	/*
+	 * Check sink id hasn't changed in per-cpu mode. In per-thread mode,
+	 * let it pass for now until an actual overlapping trace ID is hit. In
+	 * most cases IDs won't overlap even if the sink changes.
+	 */
+	if (!etmq->etm->per_thread_decoding && etmq->sink_id != SINK_UNSET &&
+	    etmq->sink_id != sink_id) {
+		pr_err("CS_ETM: mismatch between sink IDs\n");
+		return -EINVAL;
+	}
+
+	etmq->sink_id = sink_id;
+
+	/* Find which other queues use this sink and link their ID maps */
+	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
+		struct cs_etm_queue *other_etmq = etm->queues.queue_array[i].priv;
+
+		/* Different sinks, skip */
+		if (other_etmq->sink_id != etmq->sink_id)
+			continue;
+
+		/* Already linked, skip */
+		if (other_etmq->traceid_list == etmq->traceid_list)
+			continue;
+
+		/* At the point of first linking, this one should be empty */
+		if (!intlist__empty(etmq->traceid_list)) {
+			pr_err("CS_ETM: Can't link populated trace ID lists\n");
+			return -EINVAL;
+		}
+
+		etmq->own_traceid_list = NULL;
+		intlist__delete(etmq->traceid_list);
+		etmq->traceid_list = other_etmq->traceid_list;
+		break;
+	}
+
+	cpu_data = get_cpu_data(etm, cpu);
+	ret = cs_etm__insert_trace_id_node(etmq, trace_id, cpu_data);
+	if (ret)
+		return ret;
+
+	ret = cs_etm__metadata_set_trace_id(trace_id, cpu_data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
 {
 	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
@@ -414,10 +488,10 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 
 	/* extract and parse the HW ID */
 	hw_id = event->aux_output_hw_id.hw_id;
-	version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
+	version = FIELD_GET(CS_AUX_HW_ID_MAJOR_VERSION_MASK, hw_id);
 
 	/* check that we can handle this version */
-	if (version > CS_AUX_HW_ID_CURR_VERSION) {
+	if (version > CS_AUX_HW_ID_MAJOR_VERSION) {
 		pr_err("CS ETM Trace: PERF_RECORD_AUX_OUTPUT_HW_ID version %d not supported. Please update Perf.\n",
 		       version);
 		return -EINVAL;
@@ -442,7 +516,10 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 		return -EINVAL;
 	}
 
-	return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
+	if (FIELD_GET(CS_AUX_HW_ID_MINOR_VERSION_MASK, hw_id) == 0)
+		return cs_etm__process_trace_id_v0(etm, cpu, hw_id);
+	else
+		return cs_etm__process_trace_id_v0_1(etm, cpu, hw_id);
 }
 
 void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
@@ -882,12 +959,14 @@ static void cs_etm__free_queue(void *priv)
 	cs_etm_decoder__free(etmq->decoder);
 	cs_etm__free_traceid_queues(etmq);
 
-	/* First remove all traceID/metadata nodes for the RB tree */
-	intlist__for_each_entry_safe(inode, tmp, etmq->traceid_list)
-		intlist__remove(etmq->traceid_list, inode);
+	if (etmq->own_traceid_list) {
+		/* First remove all traceID/metadata nodes for the RB tree */
+		intlist__for_each_entry_safe(inode, tmp, etmq->own_traceid_list)
+			intlist__remove(etmq->own_traceid_list, inode);
 
-	/* Then the RB tree itself */
-	intlist__delete(etmq->traceid_list);
+		/* Then the RB tree itself */
+		intlist__delete(etmq->own_traceid_list);
+	}
 
 	free(etmq);
 }
@@ -1081,7 +1160,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(void)
 	 * has to be made for each packet that gets decoded, optimizing access
 	 * in anything other than a sequential array is worth doing.
 	 */
-	etmq->traceid_list = intlist__new(NULL);
+	etmq->traceid_list = etmq->own_traceid_list = intlist__new(NULL);
 	if (!etmq->traceid_list)
 		goto out_free;
 
@@ -1113,6 +1192,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	etmq->queue_nr = queue_nr;
 	queue->cpu = queue_nr; /* Placeholder, may be reset to -1 in per-thread mode */
 	etmq->offset = 0;
+	etmq->sink_id = SINK_UNSET;
 
 	return 0;
 }
-- 
2.34.1

