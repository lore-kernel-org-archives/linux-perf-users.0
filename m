Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0524C4F57;
	Tue, 15 Sep 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487408; cv=none; b=ny+tSgODME3umYTpYHS869s2NW2Tphvut7mpPbridipN6Ab/NZ/idg+4lS0Auk3eZnTekd4N5SEir2AuF8RcrjU7yzuNxKTkZFen7DKa94VQYVd3FtQvyuBmRtXtxzhlrPQHec2Q+phWvq+AUZZqZPZrjTdpk52twaja+JXM5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487408; c=relaxed/simple;
	bh=I+iiIlGTfrQKy13QypHXpMwmt+eDHgZHgtpkVV9oHQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=safgt+5xeX93zBpdscGt/xBfqeeQnOpeETiyf13FI0Z3iszF2FlR/dpBW8ENFzpaViLS5We5ZOD9F/RAkaqjX998qMOuxaH7Zh/xEk9Ns10zr+/BMuXqfPhUNGw2ChokxfTe67QLhwjxTARxnsd/UWgKItObkS9pwAzrjHem+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bo8GCotS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bo8GCotS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 141D41570;
	Tue, 15 Sep 2026 08:50:01 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47D0E3FA32;
	Tue, 15 Sep 2026 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789487404; bh=I+iiIlGTfrQKy13QypHXpMwmt+eDHgZHgtpkVV9oHQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bo8GCotSIFB1anG/4UN/PYgn1Hkd/WVv6Hkfob2l8S515F0kCwMXWO5EpvbxgkPcJ
	 EHvsnqqWwLPWSsoTN0pa8NXFFH/QPJWLXtctTNmHBjFRXDRM3+Dhs3gJiTVi8Q+O2s
	 VPfbjD002tLZaBWimmJPKxMurdkVA/5VaGwgAjEc=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 15 Sep 2026 16:49:09 +0100
Subject: [PATCH 23/25] perf cs-etm: Decode AUX samples into callchains and
 branch stacks
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-arm_cs_support_aux_sample-v1-23-35cf6f297d20@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487341; l=19991;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=I+iiIlGTfrQKy13QypHXpMwmt+eDHgZHgtpkVV9oHQc=;
 b=kJvurkfssjOYXzd6If0vwjW5B3oA/3aRwhclhRRO28d2A4TpVNMFhPA/B4BWtewaqbZnyif12
 CNTUP4BY4jTDHqgw2gSTZui3/lNO5kQYBnFC+LJ2zmHsV77IaBRnFwv
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Decode raw AUX trace embedded in PERF_SAMPLE_AUX and attach missing
callchains and branch stacks to the owning PMU samples.

Select the decoder by the sampled CPU and initialize its thread context
from the sample's PID and TID. Queue each payload temporarily for the
shared timeless decoder, clearing packet queues and flushing thread
stacks before decoding an independent window. The embedded trace already
belongs to the sample, so timestamp correlation is not needed.

Extend cs_etm__save_sample_history() to collect callchains as well as
branch stacks after decoding. Support --itrace=G and --itrace=L while
preserving recorded callchains and branch stacks.

Record CPU ID on AUX sampling events so each sample selects the correct
decoder.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c |   6 +
 tools/perf/util/cs-etm.c          | 308 +++++++++++++++++++++++++++++++++-----
 2 files changed, 274 insertions(+), 40 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d2861d66a6612ea213066258672ba41769e578cb..710887daad0e4cbb5f48a45aa396c7bbab4c7ead 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -450,6 +450,12 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 */
 	evsel__set_sample_bit(cs_etm_evsel, CPU);
 
+	/* Raw AUX samples need the sampling CPU to select the trace decoder. */
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.aux_sample_size)
+			evsel__set_sample_bit(evsel, CPU);
+	}
+
 	/*
 	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
 	 * when a context switch happened.
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 815a22cedc49e9281b7087f01355bb71b5e41c57..8a1b532df0d3f45fbec85b32ade9bc5ce5b58c98 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -66,6 +66,7 @@ struct cs_etm_auxtrace {
 	 */
 	bool per_thread_decoding;
 	bool snapshot_mode;
+	bool sampling_mode;
 	bool data_queued;
 	bool has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
 	bool use_thread_stack;
@@ -77,6 +78,7 @@ struct cs_etm_auxtrace {
 	/* Internal reconstruction depth, see cs_etm__br_stack_init() */
 	unsigned int br_stack_sz_plus;
 	struct branch_stack *br_stack;
+	struct ip_callchain *chain;
 	u64 latest_kernel_timestamp;
 	u32 auxtrace_type;
 	u32 branches_filter;
@@ -804,7 +806,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 	struct cs_etm_packet *tmp;
 
 	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
-	    etm->synth_opts.add_last_branch || etm->synth_opts.instructions) {
+	    etm->synth_opts.add_last_branch || etm->synth_opts.add_callchain ||
+	    etm->synth_opts.instructions) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
@@ -961,7 +964,7 @@ static int cs_etm__flush_events(struct perf_session *session,
 						   auxtrace);
 	int ret;
 
-	if (dump_trace)
+	if (dump_trace || etm->sampling_mode)
 		return 0;
 
 	if (!tool->ordered_events)
@@ -1077,6 +1080,7 @@ static void cs_etm__free(struct perf_session *session)
 
 	zfree(&aux->metadata);
 	zfree(&aux->br_stack);
+	zfree(&aux->chain);
 	zfree(&aux);
 }
 
@@ -1102,6 +1106,13 @@ static struct machine *cs_etm__get_machine(struct cs_etm_queue *etmq,
 	if (pid_fmt == CS_ETM_PIDFMT_CTXTID)
 		return &etmq->etm->session->machines.host;
 
+	/*
+	 * AUX samples without context IDs use the owning host sample's PID/TID.
+	 * Keep EL1 trace in that host context as well.
+	 */
+	if (etmq->etm->sampling_mode && pid_fmt == CS_ETM_PIDFMT_NONE)
+		return &etmq->etm->session->machines.host;
+
 	/*
 	 * Not perfect, but otherwise assume anything in EL1 is the default
 	 * guest, and everything else is the host. Distinguishing between guest
@@ -1615,7 +1626,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	int size;
 
 	if (!etm->synth_opts.branches && !etm->synth_opts.instructions &&
-	    !etm->synth_opts.add_last_branch)
+	    !etm->synth_opts.add_last_branch && !etm->synth_opts.add_callchain)
 		return;
 
 	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
@@ -2059,10 +2070,17 @@ static int cs_etm__save_sample_history(struct cs_etm_auxtrace *etm,
 		return -ENOMEM;
 
 	/* Consume branch history so later samples cannot reuse the same window. */
-	thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
-				     etm->br_stack_sz, sample->ip,
-				     machine__kernel_start(machine));
-	thread_stack__br_stack_consume(thread, sample->cpu);
+	if (etm->synth_opts.add_last_branch && !sample->branch_stack) {
+		thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
+					     etm->br_stack_sz, sample->ip,
+					     machine__kernel_start(machine));
+		thread_stack__br_stack_consume(thread, sample->cpu);
+	}
+
+	if (etm->synth_opts.add_callchain && !sample->callchain)
+		thread_stack__sample_late(thread, sample->cpu, etm->chain,
+					  etm->synth_opts.callchain_sz + 1,
+					  sample->ip, machine__kernel_start(machine));
 
 	thread__put(thread);
 	return 0;
@@ -2187,6 +2205,13 @@ static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
 		cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
 		break;
 	case CS_ETM_PIDFMT_NONE:
+		/*
+		 * AUX samples provide PID/TID via PERF_SAMPLE_TID, so flush host
+		 * stacks even without traced context IDs.
+		 */
+		if (etmq->etm->sampling_mode)
+			cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
+		break;
 	default:
 		break;
 
@@ -3064,6 +3089,61 @@ static bool cs_etm__tracing_kernel(struct cs_etm_auxtrace *etm,
 	return false;
 }
 
+static bool cs_etm__sampling_mode(struct perf_session *session)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		if ((evsel->core.attr.sample_type & PERF_SAMPLE_AUX) &&
+		    evsel->core.attr.aux_sample_size)
+			return true;
+	}
+	return false;
+}
+
+static int cs_etm__aux_sample_init(struct cs_etm_auxtrace *etm)
+{
+	struct evsel *evsel;
+
+	if (!etm->sampling_mode) {
+		if (etm->synth_opts.add_callchain) {
+			pr_err("CS ETM: --itrace=G requires AUX samples\n");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	evlist__for_each_entry(etm->session->evlist, evsel) {
+		u64 type = evsel->core.attr.sample_type;
+		u64 required = PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_CPU;
+
+		if (!(type & PERF_SAMPLE_AUX))
+			continue;
+
+		if ((type & required) != required) {
+			pr_err("CS ETM: AUX samples require IP, TID and CPU\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * Synthesize the callchain from AUX trace when it is not
+		 * provided by the PMU sample.
+		 */
+		if (etm->synth_opts.add_callchain && !(type & PERF_SAMPLE_CALLCHAIN))
+			evsel->synth_sample_type |= PERF_SAMPLE_CALLCHAIN;
+	}
+
+	if (etm->synth_opts.add_callchain) {
+		etm->chain = zalloc(struct_size(etm->chain, ips,
+						etm->synth_opts.callchain_sz + 1));
+		if (!etm->chain)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
 				 struct perf_session *session)
 {
@@ -3071,10 +3151,11 @@ static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
 
 	evlist__for_each_entry(session->evlist, evsel) {
 		/*
-		 * Only timestamped events can be matched against the decoded
-		 * trace, so do not advertise a branch stack on any other.
+		 * AUX samples own their trace window. Other samples need a
+		 * timestamp to match against the decoded trace.
 		 */
-		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
+		if (!(evsel->core.attr.sample_type &
+		      (etm->sampling_mode ? PERF_SAMPLE_AUX : PERF_SAMPLE_TIME)))
 			continue;
 		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK))
 			evsel->synth_sample_type |= PERF_SAMPLE_BRANCH_STACK;
@@ -3101,9 +3182,85 @@ static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static int cs_etm__set_sample_context(struct cs_etm_queue *etmq,
+				      const struct perf_sample *sample)
+{
+	struct machine *machine = &etmq->etm->session->machines.host;
+	struct cs_etm_traceid_queue *tidq;
+	u64 *metadata = get_cpu_data(etmq->etm, sample->cpu);
+	struct thread *thread;
+	u8 trace_id;
+	int ret;
+
+	if (!metadata)
+		return -EINVAL;
+
+	ret = cs_etm__metadata_get_trace_id(&trace_id, metadata);
+	if (ret)
+		return ret;
+
+	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_id);
+	if (!tidq)
+		return -ENOMEM;
+
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (!thread)
+		return -ENOMEM;
+
+	tidq->kernel_start = machine__kernel_start(machine);
+	tidq->decode_el = ocsd_EL_unknown;
+	thread__put(tidq->decode_thread);
+	thread__put(tidq->frontend_thread);
+	/* Thread already holds a reference from machine__findnew_thread() */
+	tidq->decode_thread = thread;
+	tidq->frontend_thread = thread__get(thread);
+
+	return 0;
+}
+
+/* Consume the queued AUX window while its owning sample is still available. */
+static int cs_etm__process_aux_sample(struct cs_etm_auxtrace *etm,
+				      struct perf_sample *sample)
+{
+	struct cs_etm_queue *etmq = cs_etm__get_queue(etm, sample->cpu);
+	struct auxtrace_buffer buffer = {
+		.data = sample->aux_sample.data,
+		.size = sample->aux_sample.size,
+		.pid = sample->pid,
+		.tid = sample->tid,
+		.cpu = { sample->cpu },
+	};
+	struct auxtrace_queue *queue;
+	int ret;
+
+	if (!etmq || !etmq->decoder)
+		return -EINVAL;
+
+	queue = &etm->queues.queue_array[etmq->queue_nr];
+	if (!list_empty(&queue->head) || etmq->buffer)
+		return -EINVAL;
+
+	ret = cs_etm__set_sample_context(etmq, sample);
+	if (ret)
+		return ret;
+
+	cs_etm__clear_all_packet_queues(etmq);
+
+	buffer.buffer_nr = etm->queues.next_buffer_nr++;
+	list_add_tail(&buffer.list, &queue->head);
+	ret = cs_etm__run_timeless_decoder(etmq);
+
+	/* The buffer is borrowed for this decode only. */
+	list_del_init(&buffer.list);
+	etmq->buffer = NULL;
+	etmq->buf = NULL;
+	etmq->buf_len = 0;
+	return ret;
+}
+
 /*
- * Add decoded branch history to an existing sample. The sample keeps its own
- * ip, callchain and event identity; only an absent branch stack is filled in.
+ * Decode the trace belonging to this sample and fill in missing history.
+ * The sample keeps its IP, event identity and any recorded stacks.
  * A user-only PMU sample can have a zero IP when the interrupt skids into
  * the kernel; its thread and trace window still identify valid history.
  */
@@ -3112,25 +3269,35 @@ static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
 {
 	int err;
 
-	if (!etm->synth_opts.add_last_branch || sample->branch_stack ||
-	    !sample->time || sample->time == (u64)-1)
+	if ((!etm->synth_opts.add_last_branch || sample->branch_stack) &&
+	    (!etm->synth_opts.add_callchain || sample->callchain))
 		return 0;
 
-	/* Adding branch history to existing samples supports the host only */
+	/* Adding history to existing samples supports the host only */
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
 	    sample->cpumode == PERF_RECORD_MISC_GUEST_USER)
 		return 0;
 
-	err = cs_etm__update_queues(etm);
-	if (err)
-		return err;
+	if (etm->sampling_mode) {
+		if (!sample->aux_sample.size)
+			return 0;
 
-	/*
-	 * Decode every queue up to this sample's time. Afterwards the thread
-	 * stack holds the branches that executed before the sample, and
-	 * nothing that executed after it.
-	 */
-	err = cs_etm__process_timestamped_queues(etm, sample->time);
+		err = cs_etm__process_aux_sample(etm, sample);
+	} else {
+		if (!sample->time || sample->time == (u64)-1)
+			return 0;
+
+		err = cs_etm__update_queues(etm);
+		if (err)
+			return err;
+
+		/*
+		 * Decode every queue up to this sample's time. Afterwards the
+		 * thread stack holds the branches that executed before the
+		 * sample, and nothing that executed after it.
+		 */
+		err = cs_etm__process_timestamped_queues(etm, sample->time);
+	}
 	if (err)
 		return err;
 
@@ -3138,9 +3305,16 @@ static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
 	if (err)
 		return err;
 
-	if (etm->br_stack->nr)
+	if (etm->synth_opts.add_last_branch && !sample->branch_stack && etm->br_stack->nr)
 		sample->branch_stack = etm->br_stack;
 
+	if (etm->synth_opts.add_callchain && !sample->callchain) {
+		/* An empty history produces only a context marker and sample IP */
+		if (etm->chain->nr > 2 ||
+		    (etm->chain->nr == 2 && etm->chain->ips[1] != sample->ip))
+			sample->callchain = etm->chain;
+	}
+
 	return 0;
 }
 
@@ -3225,6 +3399,10 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
+
+	if (etm->sampling_mode)
+		return 0;
+
 	if (!etm->data_queued) {
 		struct auxtrace_buffer *buffer;
 		off_t  data_offset;
@@ -3529,14 +3707,28 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	return ret;
 }
 
-static int cs_etm__queue_aux_records(struct perf_session *session)
+static int cs_etm__prepare_auxtrace_queues(struct cs_etm_auxtrace *etm,
+					   struct perf_session *session)
 {
-	struct auxtrace_index *index = list_first_entry_or_null(&session->auxtrace_index,
-								struct auxtrace_index, list);
-	if (index && index->nr > 0)
-		return perf_session__peek_events(session, session->header.data_offset,
-						 session->header.data_size,
-						 cs_etm__queue_aux_records_cb, NULL);
+	struct auxtrace_index *index;
+	unsigned int i;
+
+	/*
+	 * AUX samples have no AUX record to describe the formatter framing.
+	 * Since it is only supported by TRBE, the trace is always unformatted.
+	 */
+	if (etm->sampling_mode) {
+		for (i = 0; i < etm->queues.nr_queues; i++) {
+			struct cs_etm_queue *etmq = etm->queues.queue_array[i].priv;
+
+			etmq->format = UNFORMATTED;
+		}
+
+		return 0;
+	}
+
+	index = list_first_entry_or_null(&session->auxtrace_index,
+					 struct auxtrace_index, list);
 
 	/*
 	 * We would get here if there are no entries in the index (either no auxtrace
@@ -3546,7 +3738,12 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
 	 *
 	 * In that scenario, buffers will not be split by AUX records.
 	 */
-	return 0;
+	if (!index || index->nr <= 0)
+		return 0;
+
+	return perf_session__peek_events(session, session->header.data_offset,
+					 session->header.data_size,
+					 cs_etm__queue_aux_records_cb, NULL);
 }
 
 #define HAS_PARAM(j, type, param) (metadata[(j)][CS_ETM_NR_TRC_PARAMS] <= \
@@ -3622,6 +3819,11 @@ static int cs_etm__create_queue_decoders(struct cs_etm_queue *etmq)
 	if (decoders == 0)
 		return 0;
 
+	if (etmq->etm->sampling_mode && decoders != 1) {
+		pr_err("CS ETM Trace: AUX samples require a per-CPU raw trace source\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
 	 * needed.
@@ -3679,11 +3881,12 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
 		int ret;
 
 		/*
-		 * Don't create decoders for empty queues, mainly because
-		 * etmq->format is unknown for empty queues.
+		 * AUX sample buffers are queued when their samples are processed,
+		 * so create their decoders even though the queues are still empty.
+		 * Other empty queues have no known format or data to decode.
 		 */
 		assert(empty || etmq->format != UNSET);
-		if (empty)
+		if (empty && !etm->sampling_mode)
 			continue;
 
 		ret = cs_etm__create_queue_decoders(etmq);
@@ -3818,6 +4021,19 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
 	}
 
+	etm->sampling_mode = cs_etm__sampling_mode(session);
+	if (etm->sampling_mode) {
+		/* AUX windows augment their owning samples, without synthesizing events. */
+		etm->synth_opts.instructions = false;
+		etm->synth_opts.branches = false;
+		etm->synth_opts.callchain = false;
+		etm->synth_opts.last_branch = false;
+		if (!session->itrace_synth_opts->set) {
+			etm->synth_opts.add_callchain = true;
+			etm->synth_opts.add_last_branch = true;
+		}
+	}
+
 	if (etm->synth_opts.calls)
 		etm->branches_filter |= PERF_IP_FLAG_CALL |
 					PERF_IP_FLAG_TRACE_BEGIN |
@@ -3828,11 +4044,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 					PERF_IP_FLAG_TRACE_BEGIN |
 					PERF_IP_FLAG_TRACE_END;
 
-	if (etm->synth_opts.callchain && !symbol_conf.use_callchain) {
+	if ((etm->synth_opts.callchain || etm->synth_opts.add_callchain) &&
+	    !symbol_conf.use_callchain) {
 		symbol_conf.use_callchain = true;
 		if (callchain_register_param(&callchain_param) < 0) {
 			symbol_conf.use_callchain = false;
 			etm->synth_opts.callchain = false;
+			etm->synth_opts.add_callchain = false;
 		}
 	}
 
@@ -3859,7 +4077,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		/* Use virtual timestamps if all ETMs report ts_source = 1 */
 		etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
 
-	if (!etm->has_virtual_ts)
+	if (!etm->has_virtual_ts && !etm->sampling_mode)
 		ui__warning("Virtual timestamps are not enabled, or not supported by the traced system.\n"
 			    "The time field of the samples will not be set accurately.\n"
 			    "For Arm CPUs prior to Armv8.4 or without support FEAT_TRF,\n"
@@ -3875,6 +4093,8 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	session->auxtrace = &etm->auxtrace;
 
 	cs_etm__setup_timeless_decoding(etm);
+	if (etm->sampling_mode)
+		etm->timeless_decoding = true;
 
 	etm->tc.time_shift = tc->time_shift;
 	etm->tc.time_mult = tc->time_mult;
@@ -3889,9 +4109,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->use_thread_stack = etm->synth_opts.thread_stack ||
 				etm->synth_opts.last_branch ||
 				etm->synth_opts.add_last_branch ||
+				etm->synth_opts.add_callchain ||
 				etm->synth_opts.callchain;
 
 	etm->use_callchain = etm->synth_opts.thread_stack ||
+			     etm->synth_opts.add_callchain ||
 			     etm->synth_opts.callchain;
 
 	if (etm->synth_opts.last_branch || etm->synth_opts.add_last_branch) {
@@ -3899,13 +4121,18 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		etm->br_stack_sz_plus = etm->br_stack_sz;
 	}
 
+	err = cs_etm__aux_sample_init(etm);
+	if (err)
+		goto err_free_queues;
+
 	if (etm->synth_opts.add_last_branch) {
 		/*
 		 * Existing samples are matched to decoded trace by time, so
 		 * the trace must carry timestamps that are correlated to perf
 		 * time and the queues must be decoded in time order.
 		 */
-		if (etm->timeless_decoding || !etm->has_virtual_ts) {
+		if (!etm->sampling_mode &&
+		    (etm->timeless_decoding || !etm->has_virtual_ts)) {
 			pr_err("CS ETM Trace: --itrace=L requires virtual timestamped trace\n");
 			err = -EINVAL;
 			goto err_free_queues;
@@ -3920,7 +4147,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		goto err_free_queues;
 
-	err = cs_etm__queue_aux_records(session);
+	err = cs_etm__prepare_auxtrace_queues(etm, session);
 	if (err)
 		goto err_free_queues;
 
@@ -3972,6 +4199,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	session->auxtrace = NULL;
 err_free_etm:
 	zfree(&etm->br_stack);
+	zfree(&etm->chain);
 	zfree(&etm);
 err_free_metadata:
 	/* No need to check @metadata[j], free(NULL) is supported */

-- 
2.34.1

