Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579247D954
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708972; cv=none; b=PU+HVmhbWdUs/UGFKmxWxbHMNEQOj4P/m/mKGQaOIgw2LByvs8fXAZbueP4/zbRGi7iv0LwCd/jtQqoaU2yeGKDBpTr6GdhcNa3i8rTq1BYkTahaBgfgOZ3cjSCpyiMVf9BsyEZx2+XS2VLO1qf+nChqj2JDefJGgbGSYheadMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708972; c=relaxed/simple;
	bh=5rUqoIRr3r37UYIktrOWez8aK+VjG6cV8PsmJ3Y13BA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alL9d3tFbo8SdBe3zY0pdBAPTUvo2qCSiSUC1vq9Z5fLP+yzKygQg+6le/junRB1vvLwNbSKp14UZVuOGR3H8Bo8PVT32XN62dp2Yjnq8xMB45ofzMfD5qjLztZ/z4fvpzKKcppPWcn9o7aPhBD/NmYPEZ52xD3onSR1SfNDDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HSKLff0X; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HSKLff0X"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44E973589;
	Wed, 17 Jun 2026 08:09:25 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D26D93F915;
	Wed, 17 Jun 2026 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781708969; bh=5rUqoIRr3r37UYIktrOWez8aK+VjG6cV8PsmJ3Y13BA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HSKLff0Xk+WJbQTYY6mfz3F1FyxWkZlxCQHXlANWj2G2HBvipE6YQhkm8R4EzN3T2
	 n1nk1IuLVs6EooGthPuGgBcTqk7/Xe6c6Q/7nN/kXWlsdYQMntqstqtNYMKJDG4ZTo
	 3rd2iv5ilbpSBs9JhnWESSVWuLIqNBaTY3TlK5qw=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 17 Jun 2026 16:08:59 +0100
Subject: [PATCH v10 8/9] perf cs-etm: Synthesize callchains for instruction
 samples
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-b4-arm_cs_callchain_support_v1-v10-8-e8b6e5d63db5@arm.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
In-Reply-To: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
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
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
 Leo Yan <leo.yan@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781708939; l=7028;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Wq//CkOCI1s3w4PxbM+4EL4N5WNadU4TKvz3pMdTZkw=;
 b=0Zl2klKPNcFADgBk1/6TXtep4GI4sFpIdvCKHNXgMpNwbex0fXBTQzRWuXSHW71hvEyQJD3eB
 0Tb+LPJnISMCaCVX+twZMskHM8bw25lRBsu/50jG58in+wFrekPburC
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: Leo Yan <leo.yan@linaro.org>

CS ETM already records branches into the thread stack, but instruction
samples do not carry synthesized callchains. It misses to support the
callchain and no output with the itrace option 'g'.

Allocate a callchain buffer per queue and use thread_stack__sample()
when synthesizing instruction samples.

Advertise PERF_SAMPLE_CALLCHAIN on the synthetic instruction event.
Allocate one extra callchain entry than requested, as the first entry
is reserved for storing context information.

cs_etm__context() is introduced for handling context packet and update
the thread info and start kernel address for frontend decoding.

After:

  perf script --itrace=g16l64i1i

  callchain_test    6543 [002]          1 instructions:
        ffff800080010c14 vectors+0x414 ([kernel.kallsyms])
            aaaad6b60784 do_svc+0x1c (/home/kernel/leoy/test_cs_callchain/callchain_test)
            aaaad6b60798 print+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
            aaaad6b607b0 foo+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
            aaaad6b607c8 main+0xc (/home/kernel/leoy/test_cs_callchain/callchain_test)
            ffff9325225c __libc_start_call_main+0x7c (/usr/lib/aarch64-linux-gnu/libc.so.6)
            ffff9325233c call_init+0x9c (inlined)
            ffff9325233c __libc_start_main_impl+0x9c (inlined)
            aaaad6b60670 _start+0x30 (/home/kernel/leoy/test_cs_callchain/callchain_test)
        ffff800080012290 ret_to_user+0x120 ([kernel.kallsyms])

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 83 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 30536b919af732abeee11d4f7813dcef0b4047eb..67885ed43bab9cfd47bdb30c598c4e36d0e191fb 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -18,6 +18,7 @@
 #include <stdlib.h>
 
 #include "auxtrace.h"
+#include "callchain.h"
 #include "color.h"
 #include "cs-etm.h"
 #include "cs-etm-decoder/cs-etm-decoder.h"
@@ -87,9 +88,11 @@ struct cs_etm_auxtrace {
 struct cs_etm_traceid_queue {
 	u8 trace_chan_id;
 	u64 period_instructions;
+	u64 kernel_start;
 	union perf_event *event_buf;
 	unsigned int br_stack_sz;
 	struct branch_stack *last_branch;
+	struct ip_callchain *callchain;
 	struct cs_etm_packet *prev_packet;
 	struct cs_etm_packet *packet;
 	struct cs_etm_packet_queue packet_queue;
@@ -652,6 +655,15 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 		tidq->br_stack_sz = etm->synth_opts.last_branch_sz;
 	}
 
+	if (etm->synth_opts.callchain) {
+		/* Add 1 to callchain_sz for callchain context */
+		tidq->callchain =
+			zalloc(struct_size(tidq->callchain, ips,
+					   etm->synth_opts.callchain_sz + 1));
+		if (!tidq->callchain)
+			goto out_free;
+	}
+
 	tidq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
 	if (!tidq->event_buf)
 		goto out_free;
@@ -659,6 +671,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	return 0;
 
 out_free:
+	zfree(&tidq->callchain);
 	zfree(&tidq->last_branch);
 	zfree(&tidq->prev_packet);
 	zfree(&tidq->packet);
@@ -942,6 +955,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		thread__zput(tidq->frontend_thread);
 		thread__zput(tidq->decode_thread);
 		zfree(&tidq->event_buf);
+		zfree(&tidq->callchain);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->prev_packet);
 		zfree(&tidq->packet);
@@ -1584,6 +1598,26 @@ static void cs_etm__sample_branch_stack(struct cs_etm_auxtrace *etm,
 					tidq->last_branch, tidq->br_stack_sz);
 		sample->branch_stack = tidq->last_branch;
 	}
+
+	if (etm->synth_opts.callchain) {
+		if (tidq->kernel_start)
+			thread_stack__sample(tidq->frontend_thread,
+					     tidq->packet->cpu,
+					     tidq->callchain,
+					     etm->synth_opts.callchain_sz + 1,
+					     sample->ip, tidq->kernel_start);
+		else
+			/*
+			 * Clear the callchain when the kernel start address is
+			 * not available yet. The empty callchain can then be
+			 * consumed by cs_etm__inject_event().
+			 */
+			memset(tidq->callchain, 0,
+			       struct_size(tidq->callchain, ips,
+					   etm->synth_opts.callchain_sz + 1));
+
+		sample->callchain = tidq->callchain;
+	}
 }
 
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
@@ -1779,6 +1813,9 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
 	}
 
+	if (etm->synth_opts.callchain)
+		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
+
 	if (etm->synth_opts.instructions) {
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
 		attr.sample_period = etm->synth_opts.period;
@@ -1910,6 +1947,34 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	return 0;
 }
 
+static int cs_etm__context(struct cs_etm_queue *etmq,
+			   struct cs_etm_traceid_queue *tidq)
+{
+	ocsd_ex_level el = tidq->packet->el;
+	struct machine *machine;
+	int ret;
+
+	machine = cs_etm__get_machine(etmq, el);
+	if (!machine) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	tidq->kernel_start = machine__kernel_start(machine);
+
+	ret = cs_etm__etmq_update_thread(etmq, el, tidq->packet->tid,
+					 &tidq->frontend_thread);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	thread__zput(tidq->frontend_thread);
+	tidq->kernel_start = 0;
+	return ret;
+}
+
 static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 {
 	/*
@@ -2510,9 +2575,7 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 			 * tracing the kernel the context packet will be emitted
 			 * between two ranges.
 			 */
-			ret = cs_etm__etmq_update_thread(etmq, tidq->packet->el,
-							 tidq->packet->tid,
-							 &tidq->frontend_thread);
+			ret = cs_etm__context(etmq, tidq);
 			if (ret)
 				goto out;
 			break;
@@ -3536,6 +3599,14 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -3587,9 +3658,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	}
 
 	etm->use_thread_stack = etm->synth_opts.thread_stack ||
-				etm->synth_opts.last_branch;
+				etm->synth_opts.last_branch ||
+				etm->synth_opts.callchain;
 
-	etm->use_callchain = etm->synth_opts.thread_stack;
+	etm->use_callchain = etm->synth_opts.thread_stack ||
+			     etm->synth_opts.callchain;
 
 	err = cs_etm__synth_events(etm, session);
 	if (err)

-- 
2.34.1

