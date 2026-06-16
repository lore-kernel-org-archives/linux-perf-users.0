Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59A3BFE41
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621514; cv=none; b=GM4GETpD597taAedulScjMAbq6ck8dO8TnOLCXpeOdtjsHb5C7qAv3pWgSEEunwhUXQhmcockWbcj5GIo0NTEPhSKN938niqIwyYFUDJv4Y1vUch71FVXmLjESwvCrZL2+g7At23VPdEv6Na1fN4EpI0tVbwaoyJXZjhpZ/qP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621514; c=relaxed/simple;
	bh=GkY92qS3kV/YzvCGViExqM8+c4BXxEucZP3jk9mabKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lafRGWDQBPUCYduT2VhlfFbk4TXkRXfgLxO1BCX1ShEyzAS+Tf9AC++AynnKGtGHf6X4dcynHMS7kLKPNcv75I6Sw5raqQ/+XIX+fv3wfMWkVdkn/o3PVW0SLkw+0k8NxQPY+IdfausN8UjMHGLYce9pUo1t1nDj31RA6+92ycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DLkKtKKq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DLkKtKKq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 164F51FC7;
	Tue, 16 Jun 2026 07:51:47 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB0B3F915;
	Tue, 16 Jun 2026 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781621511; bh=GkY92qS3kV/YzvCGViExqM8+c4BXxEucZP3jk9mabKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DLkKtKKqpj/l5Q2SCsn10tEPTa2iJDQ2nYKhDxokqpT7ENbWX4VFsKsklJwD5Y0Rp
	 nd75kQ+WRK0KewmjwjT4HuLxiZz0wKJRZltY+ZbhzVCYjIN0+eC6DN+jDeYV5jhrEU
	 3Dnjb3mcTeAyCivtcPO/zU3DfPuRoQdj44NczR8U=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 16 Jun 2026 15:51:16 +0100
Subject: [PATCH v9 8/9] perf cs-etm: Synthesize callchains for instruction
 samples
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-b4-arm_cs_callchain_support_v1-v9-8-f8fad931c413@arm.com>
References: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
In-Reply-To: <20260616-b4-arm_cs_callchain_support_v1-v9-0-f8fad931c413@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781621481; l=7031;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=webtXuA8GHeeHCvS3PnEnZbaTIbnGT2UXa95b4BMKTg=;
 b=pBy2w3Y3ZNuXzzlnau5sRuFJryYRQkW5dsV/Ja8cAzO2ogGn7RorISVPE3nPUlvgU5WOhpXDs
 joUcAGiq1lVCIflfX5Z+wb0G6xp/QporrQczb6qTvTltwstF+g5PF9D
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
index e18d2dec79431f7e4b26742d98cf074483c4a246..34489476681b8e46c7a0d9e20bff433f66962484 100644
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
@@ -1611,6 +1625,26 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 		sample.branch_stack = tidq->last_branch;
 	}
 
+	if (etm->synth_opts.callchain) {
+		if (tidq->kernel_start)
+			thread_stack__sample(tidq->frontend_thread,
+					     tidq->packet->cpu,
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
+			       struct_size(tidq->callchain, ips,
+					   etm->synth_opts.callchain_sz + 1));
+
+		sample.callchain = tidq->callchain;
+	}
+
 	if (etm->synth_opts.inject) {
 		ret = cs_etm__inject_event(etm, event, &sample,
 					   etm->instructions_sample_type);
@@ -1773,6 +1807,9 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
 	}
 
+	if (etm->synth_opts.callchain)
+		attr.sample_type |= PERF_SAMPLE_CALLCHAIN;
+
 	if (etm->synth_opts.instructions) {
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
 		attr.sample_period = etm->synth_opts.period;
@@ -1904,6 +1941,34 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
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
@@ -2504,9 +2569,7 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
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
@@ -3530,6 +3593,14 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
@@ -3581,9 +3652,11 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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

