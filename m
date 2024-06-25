Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C2146A6C;
	Tue, 25 Jun 2024 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322388; cv=none; b=C5IKGumAEnIttNiqxJ/oqEv3vbZsT4UdzRPtgNyUgIWtcC2suLjjU0/jouH9yHYPIndJ86SYexjVbFh7tRcKUCJZ1zbly+Wt2LgTVNGT+C1zIgKqmvJ0mLK1akH96f4vzRLrcjlohjP4FgQQipdKiywxzynIB4EOpKG189gksxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322388; c=relaxed/simple;
	bh=dEDijOAcvPurEw8O+EaEQkPF5YjwB716dwuVfYRcc5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CKpNqAhOVtxOOssbes/fTmPitQ2o95i3FMCyP12BGc6PsZInl57muv7DVnC9tzF890uD06j2X2BsyMGgUwNUYo5PVxFajY1omVLdYgTZztaO2pZ6nR/9m42PxErTfsTw/iW6HVvAlDd1V+waWZsARa5X6f2elJ2UPZ21gUpQpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 329A0DA7;
	Tue, 25 Jun 2024 06:33:31 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 177913F73B;
	Tue, 25 Jun 2024 06:33:01 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com,
	jszu@nvidia.com,
	bwicaksono@nvidia.com
Cc: James Clark <james.clark@arm.com>,
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
Subject: [PATCH v4 06/17] perf: cs-etm: Support version 0.1 of HW_ID packets
Date: Tue, 25 Jun 2024 14:30:49 +0100
Message-Id: <20240625133105.671245-7-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625133105.671245-1-james.clark@arm.com>
References: <20240625133105.671245-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v0.1 HW_ID packets have a new field that describes which sink each CPU
writes to. Use the sink ID to link trace ID maps to each other so that
mappings are shared wherever the sink is shared.

Also update the error message to show that overlapping IDs aren't an
error in per-thread mode, just not supported. In the future we can
use the CPU ID from the AUX records, or watch for changing sink IDs on
HW_ID packets to use the correct decoders.

Signed-off-by: James Clark <james.clark@arm.com>
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

