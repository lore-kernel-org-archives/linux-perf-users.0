Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1B3F9A0B
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814846; cv=none; b=rwyv1ZHcB1tjdcej2gAuV3hQuAb18e2roWyZAOetX4Wrdwiuhkn/Q2PaPIT9qWwkwrXuUNIUxTplxhA6rSh7AEVFSeJ2KPdJuaPQ81ubnlZLeiCyYLa38EObleldxpyQ8u1F0x9h0JEx+thpvPopl26pKD5mFVsmQtcR1QplBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814846; c=relaxed/simple;
	bh=AoBmj6oARPibtpwLxmEEnpUB2eETbTbQmfrNkJRna7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5SurC4xpMPX4kXxi3DOqSMULZW9fFcfnJ9P1jBHY5Ke6WD+iun7TOlmI/bA8JwjmPtJqQ10yKixA+ob9auMyr95ssZgt1WJU7aZ4LlS4ZFvAZnRifBTdqb8eHOaMxdAKbEfX1SHMLzU631gjONGFEHTQd6nZo7vWErant5vguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OfCxTzcf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OfCxTzcf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB60316F2;
	Tue, 26 May 2026 10:00:39 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B0203F7B4;
	Tue, 26 May 2026 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779814844; bh=AoBmj6oARPibtpwLxmEEnpUB2eETbTbQmfrNkJRna7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OfCxTzcfCby0PbhPAkdoPCgqSFJNR1LUuHry85tNcStEhrM8YBhKVvlXx44yQA3n4
	 WzlDhXJRZrfPehtJ4J+A+Vvwxd5pCXI1LM0UWOq0HOtBRCX4diXKkaKyucJxrm4aIA
	 cskerURNG7twHa3cOjf61goPrj6l3fZQaEJAqupA=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 26 May 2026 17:59:43 +0100
Subject: [PATCH v6 7/8] perf cs-etm: Synthesize callchains for instruction
 samples
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-arm_cs_callchain_support_v1-v6-7-f9f49f53c9dd@arm.com>
References: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
In-Reply-To: <20260526-b4-arm_cs_callchain_support_v1-v6-0-f9f49f53c9dd@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>, 
 Paschalis Mpeis <paschalis.mpeis@arm.com>, Amir Ayupov <aaupov@fb.com>
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779814822; l=5883;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=zGujfEFKWe0VzZgvSGUYUIWft4UQWCHlLiz2Rwf3q6A=;
 b=quZUYDw8aDi8JRb3RMHLr8NURo6xn3IDC+/CcgmGT3ByUfQJl9os9A5BtpLQS+HOLtp0aMouh
 /ipB5v45emDCIlibfRcHl1hwMSI7YTJpo8dJJBxoylauFYwAqFQannN
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: Leo Yan <leo.yan@linaro.org>

CS ETM already records branches into the thread stack, but instruction
samples do not carry synthesized callchains. It misses to support the
callchain and no output with the itrace option 'g'.

Allocate a callchain buffer per queue and use thread_stack__sample()
when synthesizing instruction samples. Advertise PERF_SAMPLE_CALLCHAIN
on the synthetic instruction event.

Allocate the callchain stack with one more entry than requested, as the
first entry is reserved for storing context information.

After:

  perf script --itrace=g16l64i100

  callchain_test    9187 [002] 599611.826599:          1 instructions:
              aaaae3ed0774 do_svc+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaae3ed0798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaae3ed07b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              aaaae3ed07c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
              ffff8331225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
              ffff8331233c call_init+0x9c (inlined)
              ffff8331233c __libc_start_main_impl+0x9c (inlined)
              aaaae3ed0670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8d98e772ecb307381b5ed1b4bbc4056e8779b261..90e0beb910156093d8bd0f320bb0210aca95dd26 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 
 #include "auxtrace.h"
+#include "callchain.h"
 #include "color.h"
 #include "cs-etm.h"
 #include "cs-etm-decoder/cs-etm-decoder.h"
@@ -85,6 +86,7 @@ struct cs_etm_auxtrace {
 struct cs_etm_traceid_queue {
 	u8 trace_chan_id;
 	u64 period_instructions;
+	u64 kernel_start;
 	union perf_event *event_buf;
 	struct thread *thread;
 	struct thread *prev_packet_thread;
@@ -92,6 +94,7 @@ struct cs_etm_traceid_queue {
 	ocsd_ex_level el;
 	unsigned int br_stack_sz;
 	struct branch_stack *last_branch;
+	struct ip_callchain *callchain;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
 	struct cs_etm_packet_queue packet_queue;
@@ -640,6 +643,16 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 		tidq->br_stack_sz = etm->synth_opts.last_branch_sz;
 	}
 
+	if (etm->synth_opts.callchain) {
+		size_t sz = sizeof(struct ip_callchain);
+
+		/* Add 1 to callchain_sz for callchain context */
+		sz += (etm->synth_opts.callchain_sz + 1) * sizeof(u64);
+		tidq->callchain = zalloc(sz);
+		if (!tidq->callchain)
+			goto out_free;
+	}
+
 	tidq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
 	if (!tidq->event_buf)
 		goto out_free;
@@ -647,6 +660,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	return 0;
 
 out_free:
+	zfree(&tidq->callchain);
 	zfree(&tidq->last_branch);
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
@@ -939,6 +953,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		thread__zput(tidq->thread);
 		thread__zput(tidq->prev_packet_thread);
 		zfree(&tidq->event_buf);
+		zfree(&tidq->callchain);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->prev_packet);
 		zfree(&tidq->packet);
@@ -1431,6 +1446,7 @@ static void cs_etm__set_thread(struct cs_etm_queue *etmq,
 		tidq->thread = machine__idle_thread(machine);
 
 	tidq->el = el;
+	tidq->kernel_start = machine__kernel_start(machine);
 }
 
 int cs_etm__etmq_set_tid_el(struct cs_etm_queue *etmq, pid_t tid,
@@ -1561,6 +1577,25 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 		sample.branch_stack = tidq->last_branch;
 	}
 
+	if (etm->synth_opts.callchain) {
+		if (tidq->kernel_start)
+			thread_stack__sample(tidq->thread, tidq->packet->cpu,
+					     tidq->callchain,
+					     etm->synth_opts.callchain_sz + 1,
+					     sample.ip, tidq->kernel_start);
+		else
+			/*
+			 * Clear the callchain when the kernel start address is
+			 * not available yet. The empty callchain can then be
+			 * consumed by cs_etm__inject_event().
+			 */
+			memset(tidq->callchain, 0,
+			       sizeof(struct ip_callchain) +
+			       (etm->synth_opts.callchain_sz + 1) * sizeof(u64));
+
+		sample.callchain = tidq->callchain;
+	}
+
 	if (etm->synth_opts.inject) {
 		ret = cs_etm__inject_event(etm, event, &sample,
 					   etm->instructions_sample_type);
@@ -1724,6 +1759,9 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
 	}
 
+	if (etm->synth_opts.callchain)
+		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
+
 	if (etm->synth_opts.instructions) {
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
 		attr.sample_period = etm->synth_opts.period;
@@ -3457,6 +3495,14 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 					PERF_IP_FLAG_TRACE_BEGIN |
 					PERF_IP_FLAG_TRACE_END;
 
+	if (etm->synth_opts.callchain && !symbol_conf.use_callchain) {
+		symbol_conf.use_callchain = true;
+		if (callchain_register_param(&callchain_param) < 0) {
+			symbol_conf.use_callchain = false;
+			etm->synth_opts.callchain = false;
+		}
+	}
+
 	etm->session = session;
 
 	etm->num_cpu = num_cpu;
@@ -3508,7 +3554,8 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	}
 
 	etm->use_thread_stack = etm->synth_opts.thread_stack ||
-				etm->synth_opts.last_branch;
+				etm->synth_opts.last_branch ||
+				etm->synth_opts.callchain;
 
 	err = cs_etm__synth_events(etm, session);
 	if (err)

-- 
2.34.1

