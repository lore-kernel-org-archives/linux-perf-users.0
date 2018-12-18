From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/63] perf cs-etm: Avoid stale branch samples when flush packet
Date: Tue, 18 Dec 2018 19:06:57 -0300
Message-ID: <20181218220733.15839-28-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mike Leach <mike.leach@linaro.org>, Namhyung Kim <namhyung@kernel.org>, Robert Walker <robert.walker@arm.com>, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

At the end of trace buffer handling, function cs_etm__flush() is invoked
to flush any remaining branch stack entries.  As a side effect, it also
generates branch sample, because the 'etmq->packet' doesn't contains any
new coming packet but point to one stale packet after packets swapping,
so it wrongly makes synthesize branch samples with stale packet info.

We could review below detailed flow which causes issue:

  Packet1: start_addr=0xffff000008b1fbf0 end_addr=0xffff000008b1fbfc
  Packet2: start_addr=0xffff000008b1fb5c end_addr=0xffff000008b1fb6c

  step 1: cs_etm__sample():
	sample: ip=(0xffff000008b1fbfc-4) addr=0xffff000008b1fb5c

  step 2: flush packet in cs_etm__run_decoder():
	cs_etm__run_decoder()
	  `-> err = cs_etm__flush(etmq, false);
	sample: ip=(0xffff000008b1fb6c-4) addr=0xffff000008b1fbf0

Packet1 and packet2 are two continuous packets, when packet2 is the new
coming packet, cs_etm__sample() generates branch sample for these two
packets and use [packet1::end_addr - 4 => packet2::start_addr] as branch
jump flow, thus we can see the first generated branch sample in step 1.
At the end of cs_etm__sample() it swaps packets so 'etm->prev_packet'=
packet2 and 'etm->packet'=packet1, so far it's okay for branch sample.

If packet2 is the last one packet in trace buffer, even there have no
any new coming packet, cs_etm__run_decoder() invokes cs_etm__flush() to
flush branch stack entries as expected, but it also generates branch
samples by taking 'etm->packet' as a new coming packet, thus the branch
jump flow is as [packet2::end_addr - 4 =>  packet1::start_addr]; this
is the second sample which is generated in step 2.  So actually the
second sample is a stale sample and we should not generate it.

This patch introduces a new function cs_etm__end_block(), at the end of
trace block this function is invoked to only flush branch stack entries
and thus can avoid to generate branch sample for stale packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-3-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 789707bc4e9e..ffc4fe5c0b7e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1055,6 +1055,39 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	return err;
 }
 
+static int cs_etm__end_block(struct cs_etm_queue *etmq)
+{
+	int err;
+
+	/*
+	 * It has no new packet coming and 'etmq->packet' contains the stale
+	 * packet which was set at the previous time with packets swapping;
+	 * so skip to generate branch sample to avoid stale packet.
+	 *
+	 * For this case only flush branch stack and generate a last branch
+	 * event for the branches left in the circular buffer at the end of
+	 * the trace.
+	 */
+	if (etmq->etm->synth_opts.last_branch &&
+	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
+		/*
+		 * Use the address of the end of the last reported execution
+		 * range.
+		 */
+		u64 addr = cs_etm__last_executed_instr(etmq->prev_packet);
+
+		err = cs_etm__synth_instruction_sample(
+			etmq, addr,
+			etmq->period_instructions);
+		if (err)
+			return err;
+
+		etmq->period_instructions = 0;
+	}
+
+	return 0;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -1137,7 +1170,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 
 		if (err == 0)
 			/* Flush any remaining branch stack entries */
-			err = cs_etm__flush(etmq);
+			err = cs_etm__end_block(etmq);
 	}
 
 	return err;
-- 
2.19.2
