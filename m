Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019411;
	b=swMRBJipJavnw0hX1nNct5yi0jHmyScxzM0USqv+rwDQcx0vPdrZKzIvVV4d7OUQ6wAw
	 /l8KY7fKjbOOAcsfvjLZPw+y/a9/Aqtnv8pF59bKr+l9HFagfZddJuNs+tVbRIB8sTnfB
	 wJEYmAKTF3VVaLixseahZ/pB5Jme4V8nGDPqK32z/jLh2XcOFupMN7F9RBcnJt68XuiRK
	 Kn25ylc4TQGEuhrRHt+N5pMdUsUt/pp6ZEd5N8CPX/3QSjhOfGZALxhbCUO3iwy//+fEM
	 J89OeJZWgZ4zg+w1anxWwU1huZWb+eAyNcZjeOLdnHUIIux47AFwcOdN/nlyr9O9Dzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=0aiH+FnPwmKnpufx7VQcChkHItCK9RUh/V91yOyRAes=;
	b=S5FFegDzmsiBVqa3nf9+xQFb3Ed8cyr1SILPpxI0PyoYxQCWzf7ukZ15zK5K7CqVuR69
	 K5HNqm91tmWTRTXN9by70M665UKo2h6l7220jAvxSrV46WrXNT5qdrHVX8C+pCRk1CZ+J
	 7buzL3QSgQcp407bJrL0+ZOZ3FLQopZykP5se+KI2NX+Qy7ar5UktBzxxr9R4ioPQ2W/M
	 AKQfZBHr9LsDUUyf/LP+Seq3hCHPxZ88DW8Z+UWXWdGiDAUQWbqIaeYBsWBoVictBWEAy
	 RHsmCUsnlpKBRuzCbT53afs/rdyOrgxeP/Xf+zxYnlxHeAwTHAy8tEBjUzjRh9j6gHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ffs2j4Bw;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2160A3807
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA2160A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ffs2j4Bw
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso9367515e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019407; x=1795624207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0aiH+FnPwmKnpufx7VQcChkHItCK9RUh/V91yOyRAes=;
        b=ffs2j4Bwxolftuxq4W7YWx+MVZ/l3e5OZQHVjK2fBfNt+CH1rBTfAgayNwj0lrtWmz
         NV8HwRrZNp4CxcfpWzqUuXjIch11JH2TOeG/AUqHNljGyFsk404YH9qZXZtsubJNE9qZ
         5un32kjMRFsdL/k4SsyW0L+APCYi0fmeoaptszOM7fGmVadLU/IimWHIbliY7fZuAlDx
         FnVM2w9hyHOo+k0XtEJYapOBxQpKcN2wQMbGmb+XAQHCqN6OMDaveqArTPMB3z/PRMc0
         1NoCbIq5GDpTaDrFRmmebopRedoGVqVC+p80/C51Z+ca4NTnKokmpx0ytcWqgMCTbS7V
         NW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019407; x=1795624207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0aiH+FnPwmKnpufx7VQcChkHItCK9RUh/V91yOyRAes=;
        b=KteAZMKxyiKOT8ZG/sPvg7r/knQZI5QfHMtv8ZfUMxCnafnh4SZVBS/UZevBwwBiAm
         RyzKr4mqp4J9g9doe9tTwr6eydIBT08EaVNLEIQNyNmIzuXUxiZPHFJOwzyMHdIgW96d
         87IT2elMKK0JR56oTKDyM1eCS8aGvpy/lE/em07GZKXIwrPF/EkwTgpgpIZxv/AyEExF
         JhAmlvpcA7N77//Znx2pAy1G6YWY0GUeR2qfLSyUijUX6oG+OKSoHwiSkxelWa4IA3js
         oVQ42OYVr8SU7eP/GgVkHQMwXQvPp9oQtMoR/Vqq6n8yIvm7Mo+WstRHayAfNRlDitqo
         OWHQ==
X-Gm-Message-State: APuU4Z/2BkWvk2MbRpQuEn/HEXfoDaCjM0ts7BveXtsqAHw0ZIKPh/UB
	RJ0jTELlnJTRB3QAhNaaD8HDD7EeL71/FAdKwm00O7nyGJs44mtGraN+KwEDbbMtlmU=
X-Gm-Gg: AYBFou2pVwhQEFpnQHUIDLcs6W+kzrFRLJ2hBXHlGxsDN5vQHyHuKBjY6rPmdRvFx2P
	CkUhjpXcEsbNm+RPQfH3hIe8dT5oVUitF3wsha/Rp0OBlr0TgSywUvyxNVkn+EWZGZoDZttRmC8
	eDqkG4HoRwZBbsPWUeNKbyOH+xJKgzGRLhFlwPqhAWkqtiFqKjQL/PjmrXqFNbR+xfPEHwxnqc4
	bD3iUNFsgViIsOpWJ8cTf8GkC0SDMcmBUs1Ivg6RNufvrF/13H5JcVetlf6Lls3z8fXcKIPDQGw
	vdUYL97+6BDgZqImtaK1U8PWNcQcYxYglm7Kp3hRLRXz5LpGoAREO7WpXQX4LmIps6/Fgjy03jb
	gBad7AKMb49L5cotC4eroscCU2kBKryia4WK28fh3qQI2XRZp9xpSw4F9xzPCsrMUKD5zKl8uQp
	eAzTZmNYRGr51u2np0p2vG79naBEMNWlUFIeOs36L3ChONySd5RtLdltHMgslBqeAlIBA3cJ9bA
	cbeLLWvBBzVCBRcf/5NOLP52uJ+VpMUMBV/nbw4TctNNYwazAjjz5RdN0WVa/BFlny13GaihMAy
	AfB++3ODrLxSjxPGkDhTwmo7ydXNi0ux
X-Received: by 2002:a05:600c:501f:b0:4bb:6f67:ca0b with SMTP id 5b1f17b1804b1-4bb7da462b2mr63514125e9.29.1795019406654;
        Wed, 18 Nov 2026 08:30:06 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:06 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:39 +0000
Subject: [PATCH 17/34] perf cs-etm: Decode in order of Perf samples
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
Message-Id: <20261118-james-coresight-jit-v1-17-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Replace all the special case paths for various combinations of
per-thread and timestamped/non-timestamped decode with a single ordered
decode path. By assigning the timestamp from the aux records to trace
without timestamps, the ordered decode produces the same results as if
decoding was done in file order. Non-virtual timestamps can't be
compared to Perf events but they can still order trace between queues,
so push all queues at AUX events.

There are now only two operations on the ordered decode heap, push and
pop. Pushing decodes up to the first timestamp, stops and adds to the
heap. If there are no timestamps, pushing adds the first packet to the
heap. When there are virtual timestamps in the trace we can push as soon
as we get the ITRACE_START event so that decoding can continue in order
with future JIT and MMAP events, without that we delay until the AUX
record for that chunk, at which point we know the MMAPs will have been
processed.

One downside of decoding the first couple of atoms to search for the
timestamp is we might mis-decode them because they are associate with
the wrong MMAP. This will be fixed in a later commit by using a separate
packet only decoder to search for the timestamp.

Update the per-thread test now that the output is correct for platforms
with virtual timestamps and slightly improved for ones without.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/coresight/per-thread.sh |  45 ++-
 tools/perf/util/cs-etm.c                       | 432 +++++++++----------------
 2 files changed, 188 insertions(+), 289 deletions(-)

diff --git a/tools/perf/tests/shell/coresight/per-thread.sh b/tools/perf/tests/shell/coresight/per-thread.sh
index 8a1ab9d8f1e7..bc17b6046c4c 100755
--- a/tools/perf/tests/shell/coresight/per-thread.sh
+++ b/tools/perf/tests/shell/coresight/per-thread.sh
@@ -27,22 +27,35 @@ perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -- \
 echo "Decoding..."
 perf script -i "$tmpdir/data" --itrace=b -F comm,cpu 2> /dev/null | \
 	grep -Eo '(taskset|true).*(\[[0-9]+\])' | \
-	uniq | tail -n 3 > "$tmpdir/script" 2>/dev/null
-
-# Check that the decode says it ran on CPU 0, 1, 2, in that order. TODO: The
-# correct result should be "taskset [0,1,2], true 2" but we don't decode trace
-# in order of the Perf events yet, so everything is associated with the last
-# exec.
-cat > "$tmpdir/expected" << EOF
-true [000]
-true [001]
-true [002]
-EOF
-
-if ! diff -q "$tmpdir/script" "$tmpdir/expected"; then
-	echo "FAIL: per-thread output doesn't match expected:"
-	cat "$tmpdir/script"
-	exit 1
+	uniq > "$tmpdir/script" 2>/dev/null
+
+
+# Check that the decode says it ran on CPU 0, 1, 2, in that order. With
+# virtual timestamps the process name is also accurate.
+check_line()
+{
+	if ! sed -n "${1}p" "$tmpdir/procs" | grep -Eqx "$2"; then
+		echo "FAIL: per-thread output doesn't match expected on line $1:"
+		cat "$tmpdir/script"
+		exit 1
+	fi
+}
+
+if grep -qx '1' /sys/bus/coresight/devices/et*0/ts_source 2>/dev/null; then
+	tail -n 4 "$tmpdir/script" > "$tmpdir/procs"
+	check_line 1 'taskset \[000\]'
+	check_line 2 'taskset \[001\]'
+	check_line 3 'taskset \[002\]'
+	check_line 4 'true \[002\]'
+else
+	# No virtual timestamps means decoding is in order of AUX records, which
+	# are not guaranteed to be in order of COMM records. The last 'true'
+	# will be correct because tracing is always stopped after the last
+	# process was started.
+	tail -n 3 "$tmpdir/script" > "$tmpdir/procs"
+	check_line 1 '(true|taskset) \[000\]'
+	check_line 2 '(true|taskset) \[001\]'
+	check_line 3 'true \[002\]'
 fi
 
 exit 0
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b746d1215e0a..5c98c7960f82 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -126,11 +126,12 @@ struct cs_etm_queue {
 	 */
 	struct intlist *own_traceid_list;
 	u32 sink_id;
+	/* Whether this queue currently occupies a slot in etm->heap */
+	bool on_heap;
 };
 
-static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
-static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
-					   pid_t tid);
+static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp);
+static int cs_etm__flush_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
 static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
 static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata);
@@ -151,6 +152,7 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata);
 #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
 #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
 #define SINK_UNSET ((u32) -1)
+#define MAX_TIMESTAMP (~0ULL)
 
 static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
 {
@@ -288,6 +290,10 @@ static int cs_etm__map_trace_id(struct cs_etm_queue *etmq, u8 trace_chan_id,
 
 static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int cpu)
 {
+	/* Old per-thread files have no CPU on AUX events (before v6.4) */
+	if (cpu == -1)
+		cpu = 0;
+
 	if (cpu < 0 || cpu >= (int)etm->queues.nr_queues)
 		return NULL;
 
@@ -640,20 +646,6 @@ static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
 	}
 }
 
-static void cs_etm__clear_all_packet_queues(struct cs_etm_queue *etmq)
-{
-	int idx;
-	struct int_node *inode;
-	struct cs_etm_traceid_queue *tidq;
-	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
-
-	intlist__for_each_entry(inode, traceid_queues_list) {
-		idx = (int)(intptr_t)inode->priv;
-		tidq = etmq->traceid_queues[idx];
-		cs_etm__clear_packet_queue(&tidq->packet_queue);
-	}
-}
-
 static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 				      struct cs_etm_traceid_queue *tidq,
 				      u8 trace_chan_id)
@@ -960,21 +952,19 @@ static int cs_etm__flush_events(struct perf_session *session,
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
+	int ret;
+
 	if (dump_trace || auxtrace__dont_decode(session))
 		return 0;
 
 	if (!tool->ordered_events)
 		return -EINVAL;
 
-	if (!etm->has_timestamps) {
-		/*
-		 * Pass tid = -1 to process all queues. But likely they will have
-		 * already been processed on PERF_RECORD_EXIT anyway.
-		 */
-		return cs_etm__process_timeless_queues(etm, -1);
-	}
+	ret = cs_etm__pop_heap(etm, MAX_TIMESTAMP);
+	if (ret)
+		return ret;
 
-	return cs_etm__process_timestamped_queues(etm);
+	return cs_etm__flush_queues(etm);
 }
 
 static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
@@ -1321,75 +1311,77 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 	return 0;
 }
 
-static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
-					    struct cs_etm_queue *etmq,
-					    unsigned int queue_nr)
+static int cs_etm__add_to_heap(struct cs_etm_queue *etmq)
 {
-	int ret = 0;
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	int ret;
 	unsigned int cs_queue_nr;
 	u8 trace_chan_id;
 	u64 cs_timestamp;
 
+	ret = cs_etm__decode_data_block(etmq);
+	if (ret || !etmq->ready_chan_id)
+		return ret;
+
+	cs_timestamp = cs_etm__etmq_get_sort_timestamp(etmq, &trace_chan_id);
+
 	/*
-	 * We are under a CPU-wide trace scenario.  As such we need to know
-	 * when the code that generated the traces started to execute so that
-	 * it can be correlated with execution on other CPUs.  So we get a
-	 * handle on the beginning of traces and decode until we find a
-	 * timestamp.  The timestamp is then added to the auxtrace min heap
-	 * in order to know what nibble (of all the etmqs) to decode first.
+	 * We have a timestamp.  Add it to the min heap to reflect when
+	 * instructions conveyed by the range packets of this traceID queue
+	 * started to execute.
+	 *
+	 * Note that any packets decoded above are still in the traceID's packet
+	 * queue and will be processed later.
 	 */
-	while (1) {
-		/*
-		 * Fetch an aux_buffer from this etmq.  Bail if no more
-		 * blocks or an error has been encountered.
-		 */
+	cs_queue_nr = TO_CS_QUEUE_NR(etmq->queue_nr, trace_chan_id);
+	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
+	if (!ret)
+		etmq->on_heap = true;
+	return ret;
+}
+
+static int cs_etm__push_queue(struct cs_etm_queue *etmq, u64 time)
+{
+	int ret;
+
+	if (!etmq || etmq->on_heap)
+		return 0;
+
+	while (!etmq->on_heap) {
 		ret = cs_etm__get_data_block(etmq);
 		if (ret <= 0)
-			goto out;
+			return ret;
+		if (!etmq->etm->has_virtual_ts && etmq->buffer->time > time)
+			return 0;
 
-		/*
-		 * Run decoder on the trace block.  The decoder will stop when
-		 * encountering a CS timestamp, a full packet queue or the end of
-		 * trace for that block.
-		 */
-		ret = cs_etm__decode_data_block(etmq);
+		ret = cs_etm__add_to_heap(etmq);
 		if (ret)
-			goto out;
+			return ret;
+	}
 
-		/*
-		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
-		 * the timestamp calculation for us.
-		 */
-		cs_timestamp = cs_etm__etmq_get_sort_timestamp(etmq, &trace_chan_id);
+	return 0;
+}
 
-		/* We found a timestamp, no need to continue. */
-		if (cs_timestamp)
-			break;
+static int cs_etm__push_heap(struct cs_etm_auxtrace *etm,
+			     struct perf_sample *sample)
+{
+	return cs_etm__push_queue(cs_etm__get_queue(etm, sample->cpu),
+				  sample->time);
+}
 
-		/*
-		 * We didn't find a timestamp so empty all the traceid packet
-		 * queues before looking for another timestamp packet, either
-		 * in the current data block or a new one.  Packets that were
-		 * just decoded are useless since no timestamp has been
-		 * associated with them.  As such simply discard them.
-		 */
-		cs_etm__clear_all_packet_queues(etmq);
+static int cs_etm__push_heap_all(struct cs_etm_auxtrace *etm)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < etm->queues.nr_queues; i++) {
+		ret = cs_etm__push_queue(etm->queues.queue_array[i].priv,
+					 MAX_TIMESTAMP);
+		if (ret)
+			return ret;
 	}
 
-	/*
-	 * We have a timestamp.  Add it to the min heap to reflect when
-	 * instructions conveyed by the range packets of this traceID queue
-	 * started to execute.  Once the same has been done for all the traceID
-	 * queues of each etmq, redenring and decoding can start in
-	 * chronological order.
-	 *
-	 * Note that packets decoded above are still in the traceID's packet
-	 * queue and will be processed in cs_etm__process_timestamped_queues().
-	 */
-	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
-	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
-out:
-	return ret;
+	return 0;
 }
 
 static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
@@ -2731,159 +2723,15 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 	return ret;
 }
 
-static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
-{
-	int idx;
-	struct int_node *inode;
-	struct cs_etm_traceid_queue *tidq;
-	struct intlist *traceid_queues_list = etmq->traceid_queues_list;
-
-	intlist__for_each_entry(inode, traceid_queues_list) {
-		idx = (int)(intptr_t)inode->priv;
-		tidq = etmq->traceid_queues[idx];
-
-		/* Ignore return value */
-		cs_etm__process_traceid_queue(etmq, tidq);
-	}
-}
-
-static int cs_etm__run_per_thread_timeless_decoder(struct cs_etm_queue *etmq)
-{
-	int err = 0;
-	struct cs_etm_traceid_queue *tidq;
-
-	tidq = cs_etm__etmq_get_traceid_queue(etmq, CS_ETM_PER_THREAD_TRACEID);
-	if (!tidq)
-		return -EINVAL;
-
-	/* Go through each buffer in the queue and decode them one by one */
-	while (1) {
-		err = cs_etm__get_data_block(etmq);
-		if (err <= 0)
-			return err;
-
-		/* Run trace decoder until buffer consumed or end of trace */
-		do {
-			err = cs_etm__decode_data_block(etmq);
-			if (err)
-				return err;
-
-			/*
-			 * Process each packet in this chunk, nothing to do if
-			 * an error occurs other than hoping the next one will
-			 * be better.
-			 */
-			err = cs_etm__process_traceid_queue(etmq, tidq);
-
-		} while (etmq->buf_len);
-
-		if (err == 0)
-			/* Flush any remaining branch stack entries */
-			err = cs_etm__end_block(etmq, tidq);
-	}
-
-	return err;
-}
-
-static int cs_etm__run_per_cpu_timeless_decoder(struct cs_etm_queue *etmq)
-{
-	int idx, err = 0;
-	struct cs_etm_traceid_queue *tidq;
-	struct int_node *inode;
-
-	/* Go through each buffer in the queue and decode them one by one */
-	while (1) {
-		err = cs_etm__get_data_block(etmq);
-		if (err <= 0)
-			return err;
-
-		/* Run trace decoder until buffer consumed or end of trace */
-		do {
-			err = cs_etm__decode_data_block(etmq);
-			if (err)
-				return err;
-
-			/*
-			 * cs_etm__run_per_thread_timeless_decoder() runs on a
-			 * single traceID queue because each TID has a separate
-			 * buffer. But here in per-cpu mode we need to iterate
-			 * over each channel instead.
-			 */
-			intlist__for_each_entry(inode,
-						etmq->traceid_queues_list) {
-				idx = (int)(intptr_t)inode->priv;
-				tidq = etmq->traceid_queues[idx];
-				cs_etm__process_traceid_queue(etmq, tidq);
-			}
-		} while (etmq->buf_len);
-
-		intlist__for_each_entry(inode, etmq->traceid_queues_list) {
-			idx = (int)(intptr_t)inode->priv;
-			tidq = etmq->traceid_queues[idx];
-			/* Flush any remaining branch stack entries */
-			err = cs_etm__end_block(etmq, tidq);
-			if (err)
-				return err;
-		}
-	}
-
-	return err;
-}
-
-static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
-					   pid_t tid)
-{
-	unsigned int i;
-	struct auxtrace_queues *queues = &etm->queues;
-
-	for (i = 0; i < queues->nr_queues; i++) {
-		struct auxtrace_queue *queue = &etm->queues.queue_array[i];
-		struct cs_etm_queue *etmq = queue->priv;
-		struct cs_etm_traceid_queue *tidq;
-
-		if (!etmq)
-			continue;
-
-		if (etm->per_thread_decoding) {
-			tidq = cs_etm__etmq_get_traceid_queue(
-				etmq, CS_ETM_PER_THREAD_TRACEID);
-
-			if (!tidq)
-				continue;
-
-			if (tid == -1 || thread__tid(tidq->frontend_thread) == tid)
-				cs_etm__run_per_thread_timeless_decoder(etmq);
-		} else
-			cs_etm__run_per_cpu_timeless_decoder(etmq);
-	}
-
-	return 0;
-}
-
-static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
+static int cs_etm__pop_heap(struct cs_etm_auxtrace *etm, u64 timestamp)
 {
 	int ret = 0;
-	unsigned int cs_queue_nr, queue_nr, i;
+	unsigned int cs_queue_nr, queue_nr;
 	u8 trace_chan_id;
-	u64 cs_timestamp;
 	struct auxtrace_queue *queue;
 	struct cs_etm_queue *etmq;
 	struct cs_etm_traceid_queue *tidq;
 
-	/*
-	 * Pre-populate the heap with one entry from each queue so that we can
-	 * start processing in time order across all queues.
-	 */
-	for (i = 0; i < etm->queues.nr_queues; i++) {
-		etmq = etm->queues.queue_array[i].priv;
-		if (!etmq)
-			continue;
-
-		ret = cs_etm__queue_first_cs_timestamp(etm, etmq, i);
-		if (ret)
-			return ret;
-	}
-
 	while (1) {
 		if (!etm->heap.heap_cnt)
 			break;
@@ -2895,11 +2743,21 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		queue = &etm->queues.queue_array[queue_nr];
 		etmq = queue->priv;
 
+		/* Don't go further than the trace timestamp or collection time */
+		if (etm->has_virtual_ts) {
+			if (etm->heap.heap_array[0].ordinal >= timestamp)
+				break;
+		} else {
+			if (etmq->buffer->time >= timestamp)
+				break;
+		}
+
 		/*
 		 * Remove the top entry from the heap since we are about
 		 * to process it.
 		 */
 		auxtrace_heap__pop(&etm->heap);
+		etmq->on_heap = false;
 
 		tidq  = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
 		if (!tidq) {
@@ -2913,7 +2771,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		}
 
 		/*
-		 * Packets associated with this timestamp are already in
+		 * Packets associated with this timestamp, if any, are already in
 		 * the etmq's traceID queue, so process them.
 		 */
 		ret = cs_etm__process_traceid_queue(etmq, tidq);
@@ -2925,7 +2783,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		 * move on to the next timestamp, fetching a new auxtrace_buffer
 		 * if need be.
 		 */
-refetch:
+get_data_block:
 		ret = cs_etm__get_data_block(etmq);
 		if (ret < 0)
 			goto out;
@@ -2937,37 +2795,28 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 		if (!ret)
 			continue;
 
-		ret = cs_etm__decode_data_block(etmq);
-		if (ret)
-			goto out;
-
-		cs_timestamp = cs_etm__etmq_get_sort_timestamp(etmq, &trace_chan_id);
-
-		if (!cs_timestamp) {
-			/*
-			 * Function cs_etm__decode_data_block() returns when
-			 * there is no more traces to decode in the current
-			 * auxtrace_buffer OR when a timestamp has been
-			 * encountered on any of the traceID queues.  Since we
-			 * did not get a timestamp, there is no more traces to
-			 * process in this auxtrace_buffer.  As such empty and
-			 * flush all traceID queues.
-			 */
-			cs_etm__clear_all_traceid_queues(etmq);
-
-			/* Fetch another auxtrace_buffer for this etmq */
-			goto refetch;
-		}
-
 		/*
-		 * Add to the min heap the timestamp for packets that have
-		 * just been decoded.  They will be processed and synthesized
-		 * during the next call to cs_etm__process_traceid_queue() for
-		 * this queue/traceID.
+		 * Add the next timestamp or decoded packets to the min heap.
+		 * Packets will be processed and synthesized during the next call
+		 * to cs_etm__process_traceid_queue() for this queue/traceID.
 		 */
-		cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
-		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
+		ret = cs_etm__add_to_heap(etmq);
+		if (ret)
+			goto out;
+		if (!etmq->on_heap)
+			goto get_data_block;
 	}
+out:
+	return ret;
+}
+
+/* Flush any branch stack entries left over once all trace is decoded */
+static int cs_etm__flush_queues(struct cs_etm_auxtrace *etm)
+{
+	int ret = 0;
+	unsigned int i;
+	struct cs_etm_queue *etmq;
+	struct cs_etm_traceid_queue *tidq;
 
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		struct int_node *inode;
@@ -2986,7 +2835,7 @@ static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 				return ret;
 		}
 	}
-out:
+
 	return ret;
 }
 
@@ -3049,6 +2898,8 @@ static int cs_etm__process_event(struct perf_session *session,
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
+	bool has_sample_time = sample->time && sample->time != (u64)-1;
+	int ret = 0;
 
 	if (dump_trace || auxtrace__dont_decode(session))
 		return 0;
@@ -3059,34 +2910,71 @@ static int cs_etm__process_event(struct perf_session *session,
 	}
 
 	switch (event->header.type) {
-	case PERF_RECORD_EXIT:
+	case PERF_RECORD_ITRACE_START:
+		ret = cs_etm__process_itrace_start(etm, event);
+		if (ret)
+			return ret;
+
 		/*
-		 * Don't need to wait for cs_etm__flush_events() in per-thread mode to
-		 * start the decode because we know there will be no more trace from
-		 * this thread. All this does is emit samples earlier than waiting for
-		 * the flush in other modes, but with timestamps it makes sense to wait
-		 * for flush so that events from different threads are interleaved
-		 * properly.
+		 * Start decoding for this CPU on trace start. Timestamps in the
+		 * trace will prevent decoding from going further ahead than
+		 * Perf events.
 		 */
-		if (etm->per_thread_decoding && !etm->has_timestamps)
-			return cs_etm__process_timeless_queues(etm,
-							       event->fork.tid);
+		if (has_sample_time && etm->has_virtual_ts) {
+			ret = cs_etm__push_heap(etm, sample);
+			if (ret)
+				return ret;
+		}
 		break;
 
-	case PERF_RECORD_ITRACE_START:
-		return cs_etm__process_itrace_start(etm, event);
-
 	case PERF_RECORD_SWITCH_CPU_WIDE:
-		return cs_etm__process_switch_cpu_wide(etm, event, sample);
+		ret = cs_etm__process_switch_cpu_wide(etm, event, sample);
+		if (ret)
+			return ret;
+		break;
 
 	case PERF_RECORD_SWITCH:
-		return cs_etm__process_switch(etm, sample);
+		ret = cs_etm__process_switch(etm, sample);
+		if (ret)
+			return ret;
+		break;
+
+	case PERF_RECORD_AUX_OUTPUT_HW_ID:
+		/*
+		 * If ITRACE_START was dropped then use HW_ID as a backup start
+		 * point because it's emitted at the same time.
+		 */
+		if (has_sample_time && etm->has_virtual_ts) {
+			ret = cs_etm__push_heap(etm, sample);
+			if (ret)
+				return ret;
+		}
+		break;
 
+	case PERF_RECORD_AUX:
+		/*
+		 * Start decoding after AUX to support !etm->has_virtual_ts
+		 * because mmaps for that buffer must be available at this
+		 * point. Push all queues so that they are ordered between each
+		 * other, rather than waiting for their own AUX records which
+		 * would be too late.
+		 */
+		if (etm->has_timestamps && !etm->has_virtual_ts)
+			ret = cs_etm__push_heap_all(etm);
+		else if (has_sample_time)
+			ret = cs_etm__push_heap(etm, sample);
+
+		if (ret)
+			return ret;
+		break;
 
 	default:
 		break;
 	}
 
+	if (has_sample_time)
+		return cs_etm__pop_heap(etm, sample->time);
+
 	return 0;
 }
 
@@ -3264,9 +3152,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	frag_end = min(aux_end, auxtrace_end);
 
 	if (frag_start < frag_end) {
-		/* Old per-thread files have no CPU (before v6.4) */
-		int queue_idx = sample->cpu == (u32)-1 ? 0 : sample->cpu;
-		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, queue_idx);
+		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, sample->cpu);
 		struct auxtrace_buffer *buffer;
 
 		if (!etmq)

-- 
2.43.0

