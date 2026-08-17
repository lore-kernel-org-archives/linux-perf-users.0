Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E438330E;
	Mon, 17 Aug 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005376; cv=none; b=e7GUGlLaZ9ELfljTZ1pvxDC29Z02gFFTz26y3r3ur3xx6nItinFgUYOigoUhTFmGuPhcA6M9bZz3YTnZekpq8Hznn9KHeFoNUcJ5M3Da+Z8cPFZim5zNONRRRh60g3WXrUgZyDHiH44m4m8MLLIxnK20wSGgjYu4FnNAPsUtgOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005376; c=relaxed/simple;
	bh=9V08/jLW/+xQsav7GTmEGCSVs3fzdjRBEv++z+uFQX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JM+UkJiy5+GisGOQSo0Z9LM17z5OBe0CV2b8BadloCoT/dW0NRpVfsK45erVB0bjVAAav6OH8KUc00bGuWj0MQgXRJDC3T3//2Mxw5NpSo6gqZblHQ1SdQ7dspYuc5iO6sYWIei1i+GcUqmQdw2+wajSAvuWXYDAllonFNSL5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=hWZ/ppc/; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="hWZ/ppc/"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLoAXP1515142;
	Mon, 17 Aug 2026 15:22:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=XF8cb9U+V+GSAfsXb/sFGag3v7S7sIUwnt8Qr
	au/Dp4=; b=hWZ/ppc/qnLublOcFUDb9uvAhRk6NctJr4scv9JUp+wCb0KP8gpWS
	U5C/FHbGInOYydSgs6ZV/NrBxHh7R3x8o2W7oUFHXeSv1FWZ3ixRBRVXjZ7EbSvi
	ngPRqnER7Lo/73cohKpM7QkD1MyANMznhxLx29vWdC3yRT8Sl5B0tNQ6NoiqHz1K
	hFps5hxvv+2ljAISDBaEOqoQ2LeyR3TTU0uOQb56ISLuBAyPm7NzbsvV8Z6UdR1N
	7mx+NWwuR1MebGQzGZ0FjNCqm1lnDhJKVvX23ZHmYJxUl+CpFOGwvteEv5guyPqC
	xv5s0BUZSzTkG8BdLhddpc9JpqbAxfnLQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4g2nx9v064-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 17 Aug 2026 15:22:23 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.45; Mon, 17 Aug
 2026 22:22:22 +0000
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
Subject: [PATCH v2 2/5] perf cs-etm: Split up cs_etm__process_timestamped_queues()
Date: Mon, 17 Aug 2026 15:22:17 -0700
Message-ID: <ac33d12949419373516ca02f2972c7e0af01c069.1787005265.git.aaupov@fb.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfXwqbQqbh7N9vZ
 kMG6KYAFSXSGf13LoBU3Ty6R+7tQJQtHTnSGBV6pxlHt1VrTyGnIZl4lOu+upps60aBRfgeDx8J
 oZXbO3N+fJRSCu1vHpfc+2ojQBS0zPA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE3MSBTYWx0ZWRfX7VaFG2YT19Zt
 3SdWi9HPY7QKv+TOR4UKiy5gROgiiqPsVmhzFdl5MvPeBr/WTMR8pN4uOPr4x/dw4+el3hC2ymm
 YCm/+Unt77vY/GYIxeNSa59kU9FvgwPEjGfpFn4NM863ri/v7RUky52qvVh9pHfljU+uh4aY+gu
 39aBu9EgISNsB3VtddJzVDrkfvTYrj3T0QsrmE/jO5pexg9Bnwpr/TYruln2nTVskEkTNTu9mjR
 NLmJ7pkIh6bQJHNo0nRbtZtd1XVNJUgNQT7PFhrT7DLfNZT4N3HM3iqdg1T+t3v59+2cx3YqFWu
 QaLtYalATUwlVYx4pXgXwhT6ZU/omZMArYfdoV2jy7+69PVm1poFztbQKTvXzCIPflZ1Ah5kN6l
 GZA9nLFmPLL6fvv9zwlJT16p/+hsWb1vmeOn4bxpbbgDMg3cITpZKWKkochSilIJRej+C3YdHPp
 UzFkshhdoMvqQ1ET1AQ==
X-Proofpoint-GUID: -NVO-2kNuPnbpx6GVH61LRminefBMhDz
X-Proofpoint-ORIG-GUID: -NVO-2kNuPnbpx6GVH61LRminefBMhDz
X-Authority-Analysis: v=2.4 cv=D7t37PRj c=1 sm=1 tr=0 ts=6a83899f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=FOH2dFAWAAAA:8 a=nEhC7NrZ7_LQuKocUF8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

cs_etm__process_timestamped_queues() currently does three things: it seeds
the auxtrace heap with one entry per queue, it decodes until the heap is
empty, and it then walks every traceID queue to flush whatever is left in
the branch stacks. That is fine while the only caller is
cs_etm__flush_events(), which runs once, but it does not survive the
function being called repeatedly.

Seeding cannot be repeated because a queue that still holds a heap slot
would be seeded again, adding duplicate entries and growing the heap
without bound. Flushing cannot be repeated either, because ending a block
finalises state that later trace still needs.

Move both out. Seeding becomes cs_etm__update_queues(), gated on
queues.new_data so it only runs when new AUX data has been queued, with
etmq->on_heap tracking whether a queue currently occupies a heap slot;
this mirrors intel_pt_update_queues() and intel_pt_queue::on_heap.
Flushing becomes cs_etm__flush_timestamped_queues(). What remains is the
decode loop on its own, which a later patch can then drive incrementally.

No functional change: the sole caller performs the same three steps in the
same order.

Assisted-by: Devmate:GPT-5.6
Signed-off-by: Amir Ayupov <aaupov@fb.com>
---
 tools/perf/util/cs-etm.c | 71 ++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 114b3cd2da495..4d895f11deb7f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,9 +136,13 @@ struct cs_etm_queue {
 	 */
 	struct intlist *own_traceid_list;
 	u32 sink_id;
+	/* Whether this queue currently occupies a slot in etm->heap */
+	bool on_heap;
 };
 
+static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
+static int cs_etm__flush_timestamped_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
@@ -939,6 +943,8 @@ static int cs_etm__flush_events(struct perf_session *session,
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
+	int ret;
+
 	if (dump_trace)
 		return 0;
 
@@ -953,7 +959,15 @@ static int cs_etm__flush_events(struct perf_session *session,
 		return cs_etm__process_timeless_queues(etm, -1);
 	}
 
-	return cs_etm__process_timestamped_queues(etm);
+	ret = cs_etm__update_queues(etm);
+	if (ret)
+		return ret;
+
+	ret = cs_etm__process_timestamped_queues(etm);
+	if (ret)
+		return ret;
+
+	return cs_etm__flush_timestamped_queues(etm);
 }
 
 static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
@@ -1330,6 +1344,8 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
 	 */
 	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
 	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
+	if (!ret)
+		etmq->on_heap = true;
 out:
 	return ret;
 }
@@ -2767,23 +2783,30 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
-static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
+/*
+ * Seed the heap with one entry from each queue that is not already
+ * represented in it, so that decoding proceeds in time order across all
+ * queues. Only queues that have newly queued data need to be considered.
+ */
+static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
 {
 	int ret = 0;
-	unsigned int cs_queue_nr, queue_nr, i;
-	u8 trace_chan_id;
-	u64 cs_timestamp;
-	struct auxtrace_queue *queue;
+	unsigned int i;
 	struct cs_etm_queue *etmq;
-	struct cs_etm_traceid_queue *tidq;
+
+	if (!etm->queues.new_data)
+		return 0;
+
+	etm->queues.new_data = false;
 
 	/*
 	 * Pre-populate the heap with one entry from each queue so that we can
-	 * start processing in time order across all queues.
+	 * start processing in time order across all queues. Skip queues that
+	 * already occupy a heap slot, otherwise they would be added twice.
 	 */
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		etmq = etm->queues.queue_array[i].priv;
-		if (!etmq)
+		if (!etmq || etmq->on_heap)
 			continue;
 
 		ret = cs_etm__queue_first_cs_timestamp(etm, etmq, i);
@@ -2791,6 +2814,19 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 			return ret;
 	}
 
+	return ret;
+}
+
+static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
+{
+	int ret = 0;
+	unsigned int cs_queue_nr, queue_nr;
+	u8 trace_chan_id;
+	u64 cs_timestamp;
+	struct auxtrace_queue *queue;
+	struct cs_etm_queue *etmq;
+	struct cs_etm_traceid_queue *tidq;
+
 	while (1) {
 		if (!etm->heap.heap_cnt)
 			break;
@@ -2807,6 +2843,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		 * to process it.
 		 */
 		auxtrace_heap__pop(&etm->heap);
+		etmq->on_heap = false;
 
 		tidq  = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
 		if (!tidq) {
@@ -2874,7 +2911,21 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		 */
 		cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
 		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
+		if (ret)
+			goto out;
+		etmq->on_heap = true;
 	}
+out:
+	return ret;
+}
+
+/* Flush any branch stack entries left over once all trace is decoded */
+static int cs_etm__flush_timestamped_queues(struct cs_etm_auxtrace *etm)
+{
+	int ret = 0;
+	unsigned int i;
+	struct cs_etm_queue *etmq;
+	struct cs_etm_traceid_queue *tidq;
 
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		struct int_node *inode;
@@ -2893,7 +2944,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 				return ret;
 		}
 	}
-out:
+
 	return ret;
 }
 
-- 
2.52.0

