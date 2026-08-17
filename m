Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2D264F80;
	Mon, 17 Aug 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005377; cv=none; b=VS7V7K5C1JGfc1YlA48bp0V96mGJ0jWJLGyTAPR0KzUlJB5lO9kd7HLZ2xNI8nrOHpdBapbcNxmUrF+LAgqBzitrbOKbEs5VpgumBt1+rw1k287hzd5qpqlJKq4sSmIO8Vu6q32lzHZFASLdjaioxNi+fssz94UnUeScRY8YF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005377; c=relaxed/simple;
	bh=YigMkh/XxF+5Pqn6LXh9XKhKJ8dvIfOZX7RRq+iNTeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqcvTZuZG0O9feriCJbz2JrbSn8thbwAP6TJWrxK73X9qcbR74aAVfFy8kSfvZQleQM2IaMrUL/FXrrchN6v8uoFeJtV2QYLaHvfUDG8nM2hu1++pd+wyI0YfQGhczrq7HnIagNwiT0W8TlThU1AAp3EdQg2Q0sbVBPgWkwiIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=CWp4y5fY; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="CWp4y5fY"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLo6JV1568585;
	Mon, 17 Aug 2026 15:22:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=605wghv1GmCm+CQo5ghevZOkIoXef05xyWTwE
	8Q/kIU=; b=CWp4y5fYTBEttsJqa9FVOQDXfdjMt7eloQnnvD6mL8+Ou3MhnYrEU
	Z5KCLAwywYpvdmB1Jbwlh50n4S+aiQM2Bw4AQKKXJHomsZWh7NKl/gNUd7OQ3A6d
	sF8nFWKxQ3N7gD3rfIZ8M3Qi313Of4sIbcK9Qvp1fbvg6WHiqssyC6MEeP4yVQcU
	Z7ZN1S1ZKU+hOirrnQ1Ud686d5eFxyM2NNDsXEWHX5947MR5CVHfO5rb02qq/Fxy
	w1VcTtqURV3KGpNDJNIO5wLJXfX/rpruVKhftI7gmD1DkwEZDtFAVYKWEzGlygRd
	YlL6xo/6LHSH4KkcgEeV9K9s5vUW3EOIA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g2m516h9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Aug 2026 15:22:24 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 17 Aug
 2026 22:22:23 +0000
From: Amir Ayupov <aaupov@fb.com>
To: <linux-perf-users@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        James Clark <james.clark@linaro.org>, Leo Yan
	<leo.yan@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Swapnil
 Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v2 3/5] perf cs-etm: Add branch history to existing samples
Date: Mon, 17 Aug 2026 15:22:18 -0700
Message-ID: <454bc49f51eeef9f758fc2d2c7af75889d8aff46.1787005265.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787005265.git.aaupov@fb.com>
References: <cover.1787005265.git.aaupov@fb.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfX77sjvycTuNbk
 HlIbhJo06paLcJPxtPovq9OgWNvzrDGA+ttWtWp3sgcC43TE6oUjNupF0wTS36S8MjsO0mKnDXu
 Gqc0T7+RIl0PVsO2fHCo3Sy/xiy/Dnw=
X-Authority-Analysis: v=2.4 cv=W9cIkxWk c=1 sm=1 tr=0 ts=6a8389a0 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=FOH2dFAWAAAA:8 a=SZa0zZG4tVEWKVtGqZoA:9
X-Proofpoint-GUID: 6VuozeOMKCbR-bSjHV8bTMv67Mu24oKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfX48dUj8Gwy8qL
 VFohlkpG9g4h+ZUw3JEaugKQd9j+KFAk9vY3kUc5tzHf3wm9n0+Htos8SV5TyJ8gMYwYYCa9Dm1
 6WBDrig9u5TTYC1lp5v/48TkmTRDQsi2mioeph6b3fZI93Qjgy4HH1pQhtw8uVdIdt1N/OSe8+G
 xWYKMCIosMUlrPV+xXpA0QmlJlRk2+mRFa4TaOFq8dQHl1faWMHvFsvVCINmMhYlPsnWv3L+LDY
 D5j2CFd+IWQfOg/M6/4ToG20ROK9V6JE5/3+Kz3diBW18SslIEcZ3CyEEUPDsk85TC+EbraEwK6
 /IfXP/7oBumCAObgHsaLunYlqS7oocUqimao1pWx3b7kaHxe6k+Kg18fDmxOyzuNFyJMRUJzwb9
 H2/xECjF2PgkUg6L8ZyaWH1l8S6am07WBM2v0fXEWnq/968i5V8KgSbQYzf/Qkse+gbm8q6zBwO
 QXK4my0N2+TfubqfAog==
X-Proofpoint-ORIG-GUID: 6VuozeOMKCbR-bSjHV8bTMv67Mu24oKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

Implement --itrace=L for CoreSight ETM: decode timestamped trace up to
each existing PMU sample and attach the branch history that led to it.
The sample keeps its own ip, callchain and event identity, and a sample
that already carries a branch stack is left alone.

Samples are correlated with the trace by time, so this requires virtual
ETM timestamps that are correlated to perf time; timeless decoding is
rejected. The decode loop, which the previous patch left on its own in
cs_etm__process_timestamped_queues(), grows a timestamp argument and
stops once the decode frontier reaches it, so on return the
thread stack holds the branches that executed before the sample and none
that executed after. Attaching then reduces to the same
thread_stack__br_sample_late() call intel-pt uses.

No explicit sample-to-queue matching is needed:
thread_stack__br_sample_late() keys on the thread, and the thread stack
is already emptied whenever the decoder reports a discontinuity. The one
case that was not covered is a queue whose trace runs out: flush the
thread stack there too, otherwise samples recorded after the last trace
would pick up stale history.

Take the branch history when attaching it rather than leaving it in the
thread stack. With AUX pause and resume, a pause sample ends a completed
trace window and that window belongs to the sample. Execution while AUX
is paused is not traced, so retaining the window would let a later sample
reuse branches from before the untraced gap. Consuming it ensures that a
sample with no newly decoded trace gets an empty branch stack instead.

As with intel-pt, the internal reconstruction ring is kept deeper than
the requested output depth to cover branches decoded between the sampled
ip and the point at which the sample time was recorded, so --itrace=L<n>
can actually return n entries. Kernel-inclusive trace gets the same
conservative 1024-entry headroom that intel-pt uses.

Assisted-by: Devmate:GPT-5.6
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 tools/perf/util/cs-etm.c       | 185 +++++++++++++++++++++++++++++++--
 tools/perf/util/thread-stack.c |  17 +++
 tools/perf/util/thread-stack.h |   1 +
 3 files changed, 195 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4d895f11deb7f..00407a80933e1 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -72,6 +72,11 @@ struct cs_etm_auxtrace {
 	bool use_callchain;
 
 	int num_cpu;
+	/* Output depth requested with --itrace=L<n> */
+	unsigned int br_stack_sz;
+	/* Internal reconstruction depth, see cs_etm__br_stack_init() */
+	unsigned int br_stack_sz_plus;
+	struct branch_stack *br_stack;
 	u64 latest_kernel_timestamp;
 	u32 auxtrace_type;
 	u32 branches_filter;
@@ -91,6 +96,7 @@ struct cs_etm_traceid_queue {
 	u64 kernel_start;
 	union perf_event *event_buf;
 	unsigned int br_stack_sz;
+	unsigned int br_stack_sz_plus;
 	struct branch_stack *last_branch;
 	struct ip_callchain *callchain;
 	struct cs_etm_packet *prev_packet;
@@ -141,7 +147,8 @@ struct cs_etm_queue {
 };
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
-static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
+static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm,
+					      u64 timestamp);
 static int cs_etm__flush_timestamped_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
@@ -165,6 +172,7 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
 #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
 #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
 #define SINK_UNSET ((u32) -1)
+#define MAX_TIMESTAMP (~0ULL)
 
 static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 {
@@ -674,7 +682,8 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 		if (!tidq->last_branch)
 			goto out_free;
 
-		tidq->br_stack_sz = etm->synth_opts.last_branch_sz;
+		tidq->br_stack_sz = etm->br_stack_sz;
+		tidq->br_stack_sz_plus = etm->br_stack_sz_plus;
 	}
 
 	if (etm->synth_opts.callchain) {
@@ -794,7 +803,7 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 	struct cs_etm_packet *tmp;
 
 	if (etm->synth_opts.branches || etm->synth_opts.last_branch ||
-	    etm->synth_opts.instructions) {
+	    etm->synth_opts.add_last_branch || etm->synth_opts.instructions) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
@@ -963,7 +972,7 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (ret)
 		return ret;
 
-	ret = cs_etm__process_timestamped_queues(etm);
+	ret = cs_etm__process_timestamped_queues(etm, MAX_TIMESTAMP);
 	if (ret)
 		return ret;
 
@@ -1060,6 +1069,7 @@ static void cs_etm__free(struct perf_session *session)
 		zfree(&aux->metadata[i]);
 
 	zfree(&aux->metadata);
+	zfree(&aux->br_stack);
 	zfree(&aux);
 }
 
@@ -1597,7 +1607,8 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	u64 from, to;
 	int size;
 
-	if (!etm->synth_opts.branches && !etm->synth_opts.instructions)
+	if (!etm->synth_opts.branches && !etm->synth_opts.instructions &&
+	    !etm->synth_opts.add_last_branch)
 		return;
 
 	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
@@ -1614,7 +1625,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 				    tidq->prev_packet->flags, from, to, size,
 				    etmq->buffer->buffer_nr + 1,
 				    etmq->etm->use_callchain,
-				    tidq->br_stack_sz, 0);
+				    tidq->br_stack_sz_plus, 0);
 	} else {
 		thread_stack__set_trace_nr(tidq->frontend_thread,
 					   tidq->prev_packet->cpu,
@@ -2817,7 +2828,8 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
 	return ret;
 }
 
-static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
+static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm,
+					      u64 timestamp)
 {
 	int ret = 0;
 	unsigned int cs_queue_nr, queue_nr;
@@ -2831,6 +2843,9 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		if (!etm->heap.heap_cnt)
 			break;
 
+		if (etm->heap.heap_array[0].ordinal >= timestamp)
+			break;
+
 		/* Take the entry at the top of the min heap */
 		cs_queue_nr = etm->heap.heap_array[0].queue_nr;
 		queue_nr = TO_QUEUE_NR(cs_queue_nr);
@@ -2878,8 +2893,25 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		 * No more auxtrace_buffers to process in this etmq, simply
 		 * move on to another entry in the auxtrace_heap.
 		 */
-		if (!ret)
+		if (!ret) {
+			/*
+			 * The trace for this physical queue is exhausted. Drop
+			 * branch history for every trace ID it carried so that
+			 * samples arriving later cannot pick up entries decoded
+			 * before the gap.
+			 */
+			if (etm->synth_opts.add_last_branch) {
+				struct int_node *inode;
+
+				intlist__for_each_entry(inode, etmq->traceid_queues_list) {
+					int idx = (int)(intptr_t)inode->priv;
+
+					tidq = etmq->traceid_queues[idx];
+					thread_stack__flush(tidq->frontend_thread);
+				}
+			}
 			continue;
+		}
 
 		ret = cs_etm__decode_data_block(etmq);
 		if (ret)
@@ -3011,6 +3043,116 @@ static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static bool cs_etm__tracing_kernel(struct cs_etm_auxtrace *etm,
+				   struct perf_session *session)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		if (evsel->core.attr.type == etm->pmu_type &&
+		    !evsel->core.attr.exclude_kernel)
+			return true;
+	}
+
+	return false;
+}
+
+static int cs_etm__br_stack_init(struct cs_etm_auxtrace *etm,
+				 struct perf_session *session)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		/*
+		 * Only timestamped events can be matched against the decoded
+		 * trace, so do not advertise a branch stack on any other.
+		 */
+		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
+			continue;
+		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK))
+			evsel->synth_sample_type |= PERF_SAMPLE_BRANCH_STACK;
+	}
+
+	/*
+	 * Additional branch stack depth to cater for the branches decoded
+	 * between the sampled ip and the point at which the sample time was
+	 * recorded. Those are trimmed by thread_stack__br_sample_late(), so
+	 * the extra depth keeps the requested output depth achievable. If
+	 * kernel space is not traced, only the branch into the kernel needs
+	 * to be accounted for.
+	 */
+	if (cs_etm__tracing_kernel(etm, session))
+		etm->br_stack_sz_plus += 1024;
+	else
+		etm->br_stack_sz_plus += 1;
+
+	etm->br_stack = zalloc(sizeof(struct branch_stack) +
+			       etm->br_stack_sz * sizeof(struct branch_entry));
+	if (!etm->br_stack)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * Add decoded branch history to an existing sample. The sample keeps its own
+ * ip, callchain and event identity; only an absent branch stack is filled in.
+ */
+static int cs_etm__process_sample(struct cs_etm_auxtrace *etm,
+				  struct perf_session *session,
+				  struct perf_sample *sample)
+{
+	struct machine *machine = &session->machines.host;
+	struct thread *thread;
+	int err;
+
+	if (!etm->synth_opts.add_last_branch || sample->branch_stack ||
+	    !sample->ip || !sample->time || sample->time == (u64)-1)
+		return 0;
+
+	/* Adding branch history to existing samples supports the host only */
+	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
+	    sample->cpumode == PERF_RECORD_MISC_GUEST_USER)
+		return 0;
+
+	err = cs_etm__update_queues(etm);
+	if (err)
+		return err;
+
+	/*
+	 * Decode every queue up to this sample's time. Afterwards the thread
+	 * stack holds the branches that executed before the sample, and
+	 * nothing that executed after it.
+	 */
+	err = cs_etm__process_timestamped_queues(etm, sample->time);
+	if (err)
+		return err;
+
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (!thread)
+		return -ENOMEM;
+
+	/*
+	 * Take the branch history rather than copying it. The trace window
+	 * belongs to the sample that ends it, so once it has been attached a
+	 * later sample with nothing newly decoded finds an empty stack rather
+	 * than being given an earlier window's branches. That is the common
+	 * case whenever the trace is duty cycled, by AUX pause/resume or by
+	 * ETM strobing.
+	 */
+	thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
+				     etm->br_stack_sz, sample->ip,
+				     machine__kernel_start(machine));
+	thread_stack__br_stack_consume(thread, sample->cpu);
+
+	if (etm->br_stack->nr)
+		sample->branch_stack = etm->br_stack;
+
+	thread__put(thread);
+
+	return 0;
+}
+
 static int cs_etm__process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -3049,6 +3191,9 @@ static int cs_etm__process_event(struct perf_session *session,
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		return cs_etm__process_switch_cpu_wide(etm, event);
 
+	case PERF_RECORD_SAMPLE:
+		return cs_etm__process_sample(etm, session, sample);
+
 	case PERF_RECORD_AUX:
 		/*
 		 * Record the latest kernel timestamp available in the header
@@ -3752,11 +3897,34 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 
 	etm->use_thread_stack = etm->synth_opts.thread_stack ||
 				etm->synth_opts.last_branch ||
+				etm->synth_opts.add_last_branch ||
 				etm->synth_opts.callchain;
 
 	etm->use_callchain = etm->synth_opts.thread_stack ||
 			     etm->synth_opts.callchain;
 
+	if (etm->synth_opts.last_branch || etm->synth_opts.add_last_branch) {
+		etm->br_stack_sz = etm->synth_opts.last_branch_sz;
+		etm->br_stack_sz_plus = etm->br_stack_sz;
+	}
+
+	if (etm->synth_opts.add_last_branch) {
+		/*
+		 * Existing samples are matched to decoded trace by time, so
+		 * the trace must carry timestamps that are correlated to perf
+		 * time and the queues must be decoded in time order.
+		 */
+		if (etm->timeless_decoding || !etm->has_virtual_ts) {
+			pr_err("CS ETM Trace: --itrace=L requires virtual timestamped trace\n");
+			err = -EINVAL;
+			goto err_free_queues;
+		}
+
+		err = cs_etm__br_stack_init(etm, session);
+		if (err)
+			goto err_free_queues;
+	}
+
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_free_queues;
@@ -3812,6 +3980,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	auxtrace_queues__free(&etm->queues);
 	session->auxtrace = NULL;
 err_free_etm:
+	zfree(&etm->br_stack);
 	zfree(&etm);
 err_free_metadata:
 	/* No need to check @metadata[j], free(NULL) is supported */
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 1360f44421ef8..2713a2ad70b69 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -614,6 +614,23 @@ void thread_stack__sample_late(struct thread *thread, int cpu,
 	}
 }
 
+/*
+ * Branch history belongs to the sample that ends the trace window, so a
+ * decoder that attaches it to an existing sample should take it rather than
+ * copy it. A later sample with no newly decoded trace then finds an empty
+ * branch stack instead of the previous window's branches.
+ */
+void thread_stack__br_stack_consume(struct thread *thread, int cpu)
+{
+	struct thread_stack *ts = thread__stack(thread, cpu);
+
+	if (!ts || !ts->br_stack_rb)
+		return;
+
+	ts->br_stack_pos = 0;
+	ts->br_stack_rb->nr = 0;
+}
+
 void thread_stack__br_sample(struct thread *thread, int cpu,
 			     struct branch_stack *dst, unsigned int sz)
 {
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index b3cd09beb62f0..2aec292bd1bcb 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -88,6 +88,7 @@ void thread_stack__sample(struct thread *thread, int cpu, struct ip_callchain *c
 void thread_stack__sample_late(struct thread *thread, int cpu,
 			       struct ip_callchain *chain, size_t sz, u64 ip,
 			       u64 kernel_start);
+void thread_stack__br_stack_consume(struct thread *thread, int cpu);
 void thread_stack__br_sample(struct thread *thread, int cpu,
 			     struct branch_stack *dst, unsigned int sz);
 void thread_stack__br_sample_late(struct thread *thread, int cpu,
-- 
2.52.0

