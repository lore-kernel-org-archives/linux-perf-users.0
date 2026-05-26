Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B508325E469
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814841; cv=none; b=oULsuUoSJuIr57IiC7CFh7r3GxaOIHXy3ljVfjn47ozRIt8WdrksUbo9vw1PHcfP7GAPcClIOSWaqlVs180MG6Gkch4uvncvcnQiT1xGfhvmb1ZlUh4dpIHIhWk8WgbRccob5gjrkfXLrMjmhCi2m1fYs2chJa2DpegMfr2piCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814841; c=relaxed/simple;
	bh=Kcth1RJqv+zMc0ZESeczmZndUhxQKhuTOwR6td0cu3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHtuXBZ+7VYNn3simKG+p1kO10Kbr2J+e7b8hIsQ2hnDV+H0ztQG4VrU6lVr8HLsBQJzBYB2aN4AubwrcV/8TEkhBT3ZANnBFrEyVbPxd88FDJ8U6YTzZ3H1pkH+92gyHF2A8KDd9/6A+ZnRJf7aXd7eCjIjet+HX+kcv9+HLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JNTi/HDT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JNTi/HDT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FA1716F2;
	Tue, 26 May 2026 10:00:34 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F9A33F7B4;
	Tue, 26 May 2026 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779814839; bh=Kcth1RJqv+zMc0ZESeczmZndUhxQKhuTOwR6td0cu3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JNTi/HDT9RPXcflpkczLX+VCxICN0+hSs2bMZtDzl1K4B0ehbpVFzBD7Zhj7/Y5yO
	 hlmCbs5eOtq5R3cBU9aKG5vtzLCucijC6M3MhcQq/ejVaA5Jccm5Cj3e8SU9tzZM2a
	 l/YKVnydssVN9LL7lEk4B98YiGaK7uIvQT+NdL2w=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 26 May 2026 17:59:41 +0100
Subject: [PATCH v6 5/8] perf cs-etm: Support call indentation
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-arm_cs_callchain_support_v1-v6-5-f9f49f53c9dd@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779814822; l=9173;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=5v4rOsEzmaK4bO4ajTFfE4l0d4K4ZdxguC8gQsEZMhQ=;
 b=nUNX+Jq1EhwG0bXTaqfXmXW+snb8/wEQS1Wi7OCuRAu3IJ6leYd8pleKLiRKYoQOUAxZv1OKn
 /hGtjOm8YxODhFbVDingVHMYJIDJCRHogW4OeSp7sutlDPTN+bcqHkE
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: Leo Yan <leo.yan@linaro.org>

This commit supports the field "callindent" to reflect the call stack
depth.

The branch stack is used by both call indentation and the last branch
record, which are separate features. Use a new flag "use_br_stack" to
track whether the branch stack needs to be recorded.

Before:

  perf script -F +callindent

  callchain_test    9187 [002] 599611.826599:          1 branches: main                                 ffff83312258 __libc_start_call_main+0x78 (/usr/lib/aarch64-linux-gnu/libc.so.6)
  callchain_test    9187 [002] 599611.826599:          1 branches: foo                                  aaaae3ed07c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches: print                                aaaae3ed07ac foo+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches: do_svc                               aaaae3ed0794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches:                                      aaaae3ed077c do_svc+0x14 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches: vectors                              aaaae3ed0780 do_svc+0x18 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches:                                  ffff800080010c00 vectors+0x400 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff800080010c24 vectors+0x424 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff8000800114dc el0t_64_sync+0xd4 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff8000800114f8 el0t_64_sync+0xf0 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff800080011528 el0t_64_sync+0x120 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                  ffff800080011538 el0t_64_sync+0x130 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches:                                  ffff800080011568 el0t_64_sync+0x160 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches: el0t_64_sync_handler             ffff80008001159c el0t_64_sync+0x194 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches:                                  ffff800081829110 el0t_64_sync_handler+0x18 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches: el0t_64_sync_handler             ffff800081829140 el0t_64_sync_handler+0x48 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches: el0_svc                          ffff800081829194 el0t_64_sync_handler+0x9c ([kernel.kallsyms])

After:

  callchain_test    9187 [002] 599611.826599:          1 branches:             main                                                     ffff83312258 __libc_start_call_main+0x78 (/usr/lib/aarch64-linux-gnu/libc.so.6)
  callchain_test    9187 [002] 599611.826599:          1 branches:                 foo                                                  aaaae3ed07c4 main+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches:                     print                                            aaaae3ed07ac foo+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches:                         do_svc                                       aaaae3ed0794 print+0x8 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches:                                                                      aaaae3ed077c do_svc+0x14 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches:                             vectors                                  aaaae3ed0780 do_svc+0x18 (/home/kernel/leoy/test_cs_callchain/callchain_test)
  callchain_test    9187 [002] 599611.826599:          1 branches:                                                                  ffff800080010c00 vectors+0x400 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff800080010c24 vectors+0x424 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff8000800114dc el0t_64_sync+0xd4 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff8000800114f8 el0t_64_sync+0xf0 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff800080011528 el0t_64_sync+0x120 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826600:          1 branches:                                                                  ffff800080011538 el0t_64_sync+0x130 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches:                                                                  ffff800080011568 el0t_64_sync+0x160 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches:                                 el0t_64_sync_handler             ffff80008001159c el0t_64_sync+0x194 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches:                                                                  ffff800081829110 el0t_64_sync_handler+0x18 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches:                                     el0t_64_sync_handler         ffff800081829140 el0t_64_sync_handler+0x48 ([kernel.kallsyms])
  callchain_test    9187 [002] 599611.826601:          1 branches:                                     el0_svc                      ffff800081829194 el0t_64_sync_handler+0x9c ([kernel.kallsyms])

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ea2424175558ddc0a6f20a9de6c30f377facdc52..b31d0dd46a45dc365edd7c2f9e9b2eb077ca23db 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -66,6 +66,7 @@ struct cs_etm_auxtrace {
 	bool snapshot_mode;
 	bool data_queued;
 	bool has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
+	bool use_thread_stack;
 
 	int num_cpu;
 	u64 latest_kernel_timestamp;
@@ -626,7 +627,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	if (!tidq->prev_packet)
 		goto out_free;
 
-	if (etm->synth_opts.last_branch) {
+	if (etm->use_thread_stack) {
 		size_t sz = sizeof(struct branch_stack);
 
 		sz += etm->synth_opts.last_branch_sz *
@@ -1505,7 +1506,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	    tidq->packet->sample_type != CS_ETM_RANGE)
 		return;
 
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etmq->etm->use_thread_stack) {
 		from = cs_etm__last_executed_instr(tidq->prev_packet);
 		to = cs_etm__first_executed_instr(tidq->packet);
 
@@ -1914,7 +1915,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 	cs_etm__packet_swap(etm, tidq);
 
 	/* Reset last branches after flush the trace */
-	if (etm->synth_opts.last_branch)
+	if (etm->use_thread_stack)
 		thread_stack__flush(tidq->thread);
 
 	return err;
@@ -1977,7 +1978,7 @@ static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
 {
 	enum cs_etm_pid_fmt pid_fmt = cs_etm__get_pid_fmt(etmq);
 
-	if (!etmq->etm->synth_opts.last_branch)
+	if (!etmq->etm->use_thread_stack)
 		return;
 
 	cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
@@ -3438,6 +3439,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
 		etm->synth_opts.callchain = false;
+		etm->synth_opts.thread_stack = session->itrace_synth_opts->thread_stack;
 	}
 
 	etm->session = session;
@@ -3489,6 +3491,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		etm->tc.cap_user_time_zero = tc->cap_user_time_zero;
 		etm->tc.cap_user_time_short = tc->cap_user_time_short;
 	}
+
+	etm->use_thread_stack = etm->synth_opts.thread_stack ||
+				etm->synth_opts.last_branch;
+
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_free_queues;

-- 
2.34.1

