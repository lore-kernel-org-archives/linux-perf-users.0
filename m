Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B33B813C;
	Mon,  3 Aug 2026 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748039; cv=none; b=u+6H3keISyHNyFAc0hK7EZ2UTxJ1WHKSvEtBjbYc/a9c8+1inI/tNXeYq2YGjqAv2bY2wOfAKIg78qMunqiY7fqsmyRqofMhY4XouI8OKuMnEanZzNqsj9TiAMbahzPVM5H1r9muOKSK9XiUWlz6JipICdl4kIl6YVZkUyRc3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748039; c=relaxed/simple;
	bh=92hm9xSlFskP67WxN07u37Vn1L1nyKrNv4xf9yiftNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvb9tJPXc2iueFg6QZHgo2z9jpICPSqjuWoACqDQGXLVekj+z7pm7VebIVW8zXnDChy/XqzlA9wuq1szvq8WcTp7VmruAlxM35BKeR6O1BwGXYNcq5p2ACPAY3F4xXGa2T0X17lzpjTyOIZRiuVAwOUcgxh7ic2kOPL3Hz47pBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=WO22r8Te; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="WO22r8Te"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6734sMrW4069467;
	Mon, 3 Aug 2026 02:06:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=10bBWVL8EKMXMT+iEwiyUI1XAjlQINgNs6tnC
	TJuluE=; b=WO22r8TewWZqWkW3BO4xZs43Lbbc9uxu07K9yMxeTpB/bG435D8uD
	b3aVe17CI3v2ry9naYalnXbvEpcXp6kyI6ZKM4/jUnVsikBDlngY/YfXcG/K8qEo
	i4RI47ceHOxrdwfk5XOVtB5yq53kLG+fj1agffRHqK9CycNCW9IjViL9pETsa6Zu
	8OY4mfRVyZCRH53HGFVKuWve7R6vBGkiRAnDW2FQqdXNgxNbXOVuFeRxzKN9jAtx
	GaZc38NyB08Vo9E13/4+nxfNMRl4yeSLhRO3v1GRvQvgCix+M6WNf4mcu4DT3qla
	SUC2aU7DrQSA8X++C1PsdG3LejPt8t8KQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fsc41rnw4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Aug 2026 02:06:47 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 3 Aug
 2026 09:06:46 +0000
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
Subject: [PATCH 6/9] perf cs-etm: Add branch history to existing samples
Date: Mon, 3 Aug 2026 02:06:37 -0700
Message-ID: <20260803090640.2412336-6-aaupov@fb.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260803090640.2412336-1-aaupov@fb.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4aT5iKSUKb-YT1uHE9Az9gQ523Cl4pIS
X-Proofpoint-ORIG-GUID: 4aT5iKSUKb-YT1uHE9Az9gQ523Cl4pIS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX/+pqFPW/gEbe
 QG9sY6Zg+mZB/LNqYJz8uMtiTpAWQEdICLAJVgr4wSq4ye/Q7F7Qwud2FGGZ/1I7I7eLUhJzDOs
 TA1tteiGlGSov9fmdryGWDU1L2NxMJBtRBWlvdrtwbkj/kq+dDLgWb0AVVDYv4zgCYujJ3EZGlh
 k5eAqrrt57NIRk80ElqwPEUn/32ju6tmNIoJyHMpEF7AWHWqX8HVpcl/zpY3twqM96Y/FMf539s
 fNGz99JeUPAqlWti7L2MMjfZH0VVJxGuM9NLy4nFIngGEM9z61ofpZvN7REfmjRkH9VUOysu50N
 4XVLVlsFRmRmbCiwHEDxV5jovu2zHAM+tSXaZNPPGy2pKw5gtDhQDA9fJCvLY+AVZj+FZ1vRqRc
 kb12j0wCJ0k2vvCIUwA/sx9+U/TqDDgpvfUy9BOAhMYVK3MteJ3kefM0JzfCxAp7BBj9QEKxQvH
 tu4zX2JELD1OcQFFuxQ==
X-Authority-Analysis: v=2.4 cv=A7Fc+aWG c=1 sm=1 tr=0 ts=6a705a27 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=FOH2dFAWAAAA:8 a=WJwQeloTZ5xvvEq14poA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA4MSBTYWx0ZWRfX/ToY2rfcJh8l
 Qjg6ic3bOTHqgxtfg4HUsSytef5rw9kmlKlqWb/qzHlNEYGBW6WyNF9sR2AFq0IR18S0lFcXDRo
 ARmulYYZmFDRiuzbxrXmfqmJdMhy+UA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01

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

A sample that lands in a gap between two trace windows is still attached
the preceding window's branches at this point: the discontinuity that
ends the gap is only decoded once trace resumes, so the thread stack has
not been emptied yet. Whenever the trace is duty cycled that is the
common case rather than a corner case. The next patch suppresses it.

As with intel-pt, the internal reconstruction ring is kept deeper than
the requested output depth to cover branches decoded between the sampled
ip and the point at which the sample time was recorded, so --itrace=L<n>
can actually return n entries. Kernel-inclusive trace gets the same
conservative 1024-entry headroom that intel-pt uses.

Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 tools/perf/util/cs-etm.c | 176 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 168 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4d895f11deb7f..048ff97caa936 100644
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
@@ -2878,8 +2893,16 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		 * No more auxtrace_buffers to process in this etmq, simply
 		 * move on to another entry in the auxtrace_heap.
 		 */
-		if (!ret)
+		if (!ret) {
+			/*
+			 * The trace for this queue is exhausted. Drop any
+			 * branch history so that samples arriving later
+			 * cannot pick up entries decoded before the gap.
+			 */
+			if (etm->synth_opts.add_last_branch)
+				thread_stack__flush(tidq->frontend_thread);
 			continue;
+		}
 
 		ret = cs_etm__decode_data_block(etmq);
 		if (ret)
@@ -3011,6 +3034,116 @@ static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
+static bool cs_etm__tracing_kernel(struct cs_etm_auxtrace *etm,
+				   struct perf_session *session)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		if (evsel->core.attr.type == etm->pmu_type)
+			return !evsel->core.attr.exclude_kernel;
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
+	 * The thread stack is emptied when the decoder reports a
+	 * discontinuity and when a queue runs out of trace, so branches from
+	 * before either of those are never reported.
+	 *
+	 * Note that a sample landing in a gap between two trace windows is
+	 * not covered by that: the discontinuity that ends the gap has not
+	 * been decoded at this point, so the preceding window is still in
+	 * the thread stack and gets attached. Filtering those out needs a
+	 * per-window end time that the decoder does not currently expose.
+	 */
+	thread_stack__br_sample_late(thread, sample->cpu, etm->br_stack,
+				     etm->br_stack_sz, sample->ip,
+				     machine__kernel_start(machine));
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
@@ -3049,6 +3182,9 @@ static int cs_etm__process_event(struct perf_session *session,
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		return cs_etm__process_switch_cpu_wide(etm, event);
 
+	case PERF_RECORD_SAMPLE:
+		return cs_etm__process_sample(etm, session, sample);
+
 	case PERF_RECORD_AUX:
 		/*
 		 * Record the latest kernel timestamp available in the header
@@ -3752,11 +3888,34 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 
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
@@ -3812,6 +3971,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	auxtrace_queues__free(&etm->queues);
 	session->auxtrace = NULL;
 err_free_etm:
+	zfree(&etm->br_stack);
 	zfree(&etm);
 err_free_metadata:
 	/* No need to check @metadata[j], free(NULL) is supported */
-- 
2.52.0

