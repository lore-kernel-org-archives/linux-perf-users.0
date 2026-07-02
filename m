Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139AE372EC6
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021948; cv=none; b=UhnIU6t1hA2TEa3PLtjJxHfY4+QvAAd31smnN1MRltHQTNFUv2pvtCUgaEWpzgX2lFPoiN5mlVoqeDMBah2+Wk6xHpEzdd5tfjcn5nf9Wz6O9q3SX0pworujeThj/CWwwgQiK387Fo8OzwpH0tgqQXu4SIvcP30LlshrXzMWY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021948; c=relaxed/simple;
	bh=Sqwov2LCkYLnR5lep1hpSJ+8RmtoEa//JjWAVQYJqXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eThdZ0rPP2GyaYWFlRKdnsyo7/Pt2AWAzNN1Gmt1M2bVMY70wMHA/nEMuL9H+ax65U/u0MIaqKcblAARxTQQEbMK8o/hym6C+/rT5i74PlYwiEGYLZeaqs4L/NqZQfuhelDPrfs//cEzcQl1QqMOdKaffOfiWrjbs6O7KEv8zuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GaZESgBj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GaZESgBj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2378835B7;
	Thu,  2 Jul 2026 12:52:21 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CD653F673;
	Thu,  2 Jul 2026 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783021945; bh=Sqwov2LCkYLnR5lep1hpSJ+8RmtoEa//JjWAVQYJqXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GaZESgBjdmkhKNj27ZdO5J+Y0a/psbWn+lV7LXwCzZVzZM5CS35BVic0C3bcqdgn/
	 HfD19RxGJVi4fjPv2KtwYYxe26ezoZkLHq7gQI0frYr7cUTB4VMPUKeixAXcWL89MS
	 LygPaN5s66fqkAOclkZ1xKKb1l3z8/i1vfbf5mf8=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Jul 2026 20:51:42 +0100
Subject: [PATCH v11 7/9] perf cs-etm: Support call indentation
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-arm_cs_callchain_support_v1-v11-7-846abbf600d7@arm.com>
References: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
In-Reply-To: <20260702-b4-arm_cs_callchain_support_v1-v11-0-846abbf600d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783021918; l=7010;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=KU1nGLnlyfV4qp0o9gXppX+q1xgFc3kxSXETMgbcvEk=;
 b=jOObZ3HyoauKzF7wTMdv03cf8gu6TuQPcnknBK9LjrayHb2iHq6IaMygClvCTqaGxEPftvs5k
 hKsIGFaElaBAfJcc/XXR/ReEH1fP7+yvu5RfDm5kurCcWVGNiEqO02Y
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: Leo Yan <leo.yan@linaro.org>

The perf script callindent is derived from call stack in thread context,
CS ETM ignores the requirement for callindent without pushing and poping
call stack.

Enable thread-stack when either itrace thread-stack support or last branch
entries are requested, allocate the branch stack storage accordingly, and
feed taken branches to thread_stack__event() whenever thread-stack state
is needed.

When callindent is requested, pass callstack=true to thread_stack__event()
so the common thread-stack code maintains call depth for branch samples.

Before:

  perf script -F +callindent

  callchain_test    6543 [002]          1 branches: main                                 ffff93252258 __libc_start_call_main+0x78 (/usr/lib/aarch64-linux-gnu/libc.so.6)
  callchain_test    6543 [002]          1 branches: foo                                  aaaad6b607c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    6543 [002]          1 branches: print                                aaaad6b607ac foo+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    6543 [002]          1 branches: do_svc                               aaaad6b60794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    6543 [002]          1 branches: vectors                              aaaad6b60780 do_svc+0x18 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    6543 [002]          1 branches: el0t_64_sync_handler             ffff80008001159c el0t_64_sync+0x194 ([kernel.kallsyms])
  callchain_test    6543 [002]          1 branches: el0_svc                          ffff800081829194 el0t_64_sync_handler+0x9c ([kernel.kallsyms])
  callchain_test    6543 [002]          1 branches: lockdep_hardirqs_off             ffff800081828794 el0_svc+0x24 ([kernel.kallsyms])
  callchain_test    6543 [002]          1 branches: __this_cpu_preempt_check         ffff80008182b348 lockdep_hardirqs_off+0xf0 ([kernel.kallsyms])

After:

  callchain_test    6543 [002]          1 branches:                 main                                                 ffff93252258 __libc_start_call_main+0x78 (/usr/lib/aarch64-linux-gnu/libc.so.6)
  callchain_test    6543 [002]          1 branches:                     foo                                              aaaad6b607c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    6543 [002]          1 branches:                         print                                        aaaad6b607ac foo+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    6543 [002]          1 branches:                             do_svc                                   aaaad6b60794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    6543 [002]          1 branches:                                 vectors                              aaaad6b60780 do_svc+0x18 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    6543 [002]          1 branches:                                     el0t_64_sync_handler         ffff80008001159c el0t_64_sync+0x194 ([kernel.kallsyms])
  callchain_test    6543 [002]          1 branches:                                         el0_svc                  ffff800081829194 el0t_64_sync_handler+0x9c ([kernel.kallsyms])
  callchain_test    6543 [002]          1 branches:                                             lockdep_hardirqs_off ffff800081828794 el0_svc+0x24 ([kernel.kallsyms])
  callchain_test    6543 [002]          1 branches:                                                 __this_cpu_preempt_check                         ffff80008182b348 lockdep_hardirqs_off+0xf0 ([kernel.kallsyms])

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 996317687ce7b241afed83444b554155edb09564..f76648fa67681c464faf5e9cf4e019653bce5b4c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -67,6 +67,8 @@ struct cs_etm_auxtrace {
 	bool snapshot_mode;
 	bool data_queued;
 	bool has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
+	bool use_thread_stack;
+	bool use_callchain;
 
 	int num_cpu;
 	u64 latest_kernel_timestamp;
@@ -656,7 +658,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	if (!tidq->prev_packet)
 		goto out_free;
 
-	if (etm->synth_opts.last_branch) {
+	if (etm->use_thread_stack) {
 		size_t sz = sizeof(struct branch_stack);
 
 		sz += etm->synth_opts.last_branch_sz *
@@ -1572,7 +1574,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	if (!cs_etm__packet_has_taken_branch(tidq->prev_packet))
 		return;
 
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etmq->etm->use_thread_stack) {
 		from = cs_etm__last_executed_instr(tidq->prev_packet);
 		to = cs_etm__first_executed_instr(tidq->packet);
 
@@ -1581,7 +1583,8 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 		/* Enable callchain so thread stack entry can be allocated */
 		thread_stack__event(tidq->frontend_thread, tidq->prev_packet->cpu,
 				    tidq->prev_packet->flags, from, to, size,
-				    etmq->buffer->buffer_nr + 1, false,
+				    etmq->buffer->buffer_nr + 1,
+				    etmq->etm->use_callchain,
 				    tidq->br_stack_sz, 0);
 	} else {
 		thread_stack__set_trace_nr(tidq->frontend_thread,
@@ -1991,7 +1994,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 	cs_etm__packet_swap(etm, tidq);
 
 	/* Reset last branches after flush the trace */
-	if (etm->synth_opts.last_branch)
+	if (etm->use_thread_stack)
 		thread_stack__flush(tidq->frontend_thread);
 
 	return err;
@@ -2054,7 +2057,7 @@ static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
 {
 	enum cs_etm_pid_fmt pid_fmt = cs_etm__get_pid_fmt(etmq);
 
-	if (!etmq->etm->synth_opts.last_branch)
+	if (!etmq->etm->use_thread_stack)
 		return;
 
 	switch (pid_fmt) {
@@ -3556,6 +3559,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
 		etm->synth_opts.callchain = false;
+		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
 	}
 
 	if (etm->synth_opts.calls)
@@ -3617,6 +3621,12 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		etm->tc.cap_user_time_zero = tc->cap_user_time_zero;
 		etm->tc.cap_user_time_short = tc->cap_user_time_short;
 	}
+
+	etm->use_thread_stack = etm->synth_opts.thread_stack ||
+				etm->synth_opts.last_branch;
+
+	etm->use_callchain = etm->synth_opts.thread_stack;
+
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_free_queues;

-- 
2.34.1

