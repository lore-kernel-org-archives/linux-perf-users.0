Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C803290AA;
	Mon, 15 Jun 2026 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562799; cv=none; b=aZDL4SewAsFeuM22v4gg/1jxB0U0+52YZ89GXnhrYdxvhCP3RZWS9NGlF+xoX/fyxgzjr+H+5PzldDcEfn3FdMWCWWTqt+e/YDoUWcw0G+PaZb64KZdvsRXORcyHZMD/L8t/MBMGZJhHWcefDfrtd6U89842o1uR5HoP4tnw8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562799; c=relaxed/simple;
	bh=dtzYcHZgG0hqkA9z54QV309PHffUSU2ySymNNbOxs8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei584Eiq8ii5Vv1/1XnUmWDFFB4HHxiz317/dADNZ8ak6kR7SLoBNBygqgV/ERsutn/EV0R/xNgJBfdp0zpxK4J1DKlXau6eyq2eXn6AbMXzILm+9K6q2237VoiFOTaxENDO0NrpEnBIi4/0vr9eqJ/GWYztDPcu8gjIMJ+xbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mquqf1WZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mquqf1WZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2341A1F00A3A;
	Mon, 15 Jun 2026 22:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781562798;
	bh=hICK0f9EXipK30sHw4w7F3YugcEvbyriZHsVdJLEggc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mquqf1WZ2Qy+evaO58uiaWeZwqkCq7eZgajleOxuUSPQeG6iOgQ7jWTyZTmabsx4C
	 sY73GaQObvCycAIOIFRZ6MExAAlx5YScEhlIogouO3SJCYAot4OhF3ZCcByJwMjQ6O
	 3q/q7CdpivU9uAnsGR05lP2UIQur+hul5YwlElxCBIzYB66HYb5zE7J70M7FmqF0hr
	 ealri91SyA8jo7sJk4xplcA3sCulLZ1Ld9eCmT9RQIaYTC+KA+W5oGj8eDrviJkV+8
	 EXtObiPjokrzf9nRggkFx3tgUpL9A/MC00ASncjWPj2XFN92bqoWH54vj5RTmiLlSr
	 D7M8tykYpkFFQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linaro.org>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 5/9] perf cs-etm: Bounds-check CPU in cs_etm__get_queue()
Date: Mon, 15 Jun 2026 19:32:45 -0300
Message-ID: <20260615223249.36598-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615223249.36598-1-acme@kernel.org>
References: <20260615223249.36598-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

cs_etm__get_queue() indexes etm->queues.queue_array[cpu] without
validating that cpu is within nr_queues.  When processing
AUX_OUTPUT_HW_ID events, the cpu value comes from untrusted perf.data
trace payload and flows through cs_etm__process_trace_id_v0_1() and
cs_etm__queue_aux_fragment() without bounds checking, allowing an
out-of-bounds read with a crafted file.

Add a bounds check in cs_etm__get_queue() and NULL checks in all
callers.

Also add NULL checks for queue_array[i].priv in the queue iteration
loops in cs_etm__map_trace_id_v0() and cs_etm__process_trace_id_v0_1()
— after auxtrace_queues__grow() new entries are zero-initialized so
.priv can be NULL.  Add a get_cpu_data() NULL check in
cs_etm__process_trace_id_v0_1(), matching the existing check in
cs_etm__process_trace_id_v0().

Fixes: 77c123f53e97ad4b ("perf: cs-etm: Move traceid_list to each queue")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d121c8f22028d5ba..5d0664ff73b79122 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -292,8 +292,11 @@ static struct cs_etm_queue *cs_etm__get_queue(struct cs_etm_auxtrace *etm, int c
 {
 	if (etm->per_thread_decoding)
 		return etm->queues.queue_array[0].priv;
-	else
-		return etm->queues.queue_array[cpu].priv;
+
+	if (cpu < 0 || cpu >= (int)etm->queues.nr_queues)
+		return NULL;
+
+	return etm->queues.queue_array[cpu].priv;
 }
 
 static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id,
@@ -306,6 +309,9 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id
 	 * queue associated with that CPU so only one decoder is made.
 	 */
 	etmq = cs_etm__get_queue(etm, cpu_metadata[CS_ETM_CPU]);
+	if (!etmq)
+		return -EINVAL;
+
 	if (etmq->format == UNFORMATTED)
 		return cs_etm__insert_trace_id_node(etmq, trace_chan_id,
 						    cpu_metadata);
@@ -318,6 +324,9 @@ static int cs_etm__map_trace_id_v0(struct cs_etm_auxtrace *etm, u8 trace_chan_id
 		int ret;
 
 		etmq = etm->queues.queue_array[i].priv;
+		if (!etmq)
+			continue;
+
 		ret = cs_etm__insert_trace_id_node(etmq, trace_chan_id,
 						   cpu_metadata);
 		if (ret)
@@ -358,6 +367,9 @@ static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace *etm, int cpu,
 	u32 sink_id = FIELD_GET(CS_AUX_HW_ID_SINK_ID_MASK, hw_id);
 	u8 trace_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
 
+	if (!etmq)
+		return -EINVAL;
+
 	/*
 	 * Check sink id hasn't changed in per-cpu mode. In per-thread mode,
 	 * let it pass for now until an actual overlapping trace ID is hit. In
@@ -375,6 +387,9 @@ static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace *etm, int cpu,
 	for (unsigned int i = 0; i < etm->queues.nr_queues; ++i) {
 		struct cs_etm_queue *other_etmq = etm->queues.queue_array[i].priv;
 
+		if (!other_etmq)
+			continue;
+
 		/* Different sinks, skip */
 		if (other_etmq->sink_id != etmq->sink_id)
 			continue;
@@ -396,6 +411,9 @@ static int cs_etm__process_trace_id_v0_1(struct cs_etm_auxtrace *etm, int cpu,
 	}
 
 	cpu_data = get_cpu_data(etm, cpu);
+	if (!cpu_data)
+		return -EINVAL;
+
 	ret = cs_etm__insert_trace_id_node(etmq, trace_id, cpu_data);
 	if (ret)
 		return ret;
@@ -3144,6 +3162,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
 		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
 
+		if (!etmq)
+			return -EINVAL;
+
 		/*
 		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
 		 * based on the sizes of the aux event, and queue that fragment.
-- 
2.54.0

