Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749331280C
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164639; cv=none; b=rNgZYJXHJU+PgSMEHQVaNEfmGnLA+HkMyDwwjmuJSo/tTvCLfW8MNgUTIN4LI7fcTqFHt2XQIuVXOSDVHTwobI+PudNhZrsyCVhkTRz+QjwNxwi3aGq0iNALlc4IDfCIGreVBuOSyj+KrfkVHTDwjfzwQkUU39O2ov2VXZ3W1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164639; c=relaxed/simple;
	bh=U4Vjt6Y/5QlDO6U416YjeMisAuaa8t5ty3UmEv1GOXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iw2FunxOV9yhbmUciIzrvXJ+j81+2B4gIRSwb1Dv3d1a3XDMY18ga6UM9Frp6IntghZ9V37QEuxmgk57Q5QTLyVaFEAWu28a76YU/6mZYsaapeNZh39PfJ08bRy277GjZG+JMNSefxp1vLbRgcVl+9GbSTHIkklmDWmN6dtIW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FKQWl50t; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FKQWl50t"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA6F1E5E;
	Thu, 11 Jun 2026 00:57:12 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5D33FD88;
	Thu, 11 Jun 2026 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781164637; bh=U4Vjt6Y/5QlDO6U416YjeMisAuaa8t5ty3UmEv1GOXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FKQWl50tNxYhdWTa8VUoY97ZUkmYy4jSvb4wfg9yuWGYmAVBNqtHLvRUosmPmrC5S
	 zkeKZI1AAJBwf3S95HUSZPSKPSzgtyQKo9HXEd5GDqUJ9HcwpvvFG+qoaWX+mQZKOd
	 8+nblX6wMfGypfcXjfwwjK0DltHGTBmsaU66kZPQ=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 11 Jun 2026 08:56:55 +0100
Subject: [PATCH v7 1/8] perf cs-etm: Filter synthesized branch samples
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-arm_cs_callchain_support_v1-v7-1-1ba770c862ae@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com>
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v7-0-1ba770c862ae@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781164631; l=6689;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=+EOtrNNEJIkZEdc03dc+/AgbQ4RpRT1XtXfwdaR9d2g=;
 b=sQ+vX57i7sH7dDM9V97pmkIHw+So3HkZrYZZguTj37NKSQZN7TIc2dSEJQ7aRg1mOfDGOUWcD
 z3sxsvWaw4RC4ZOzmk3cCadaUG/p8N4qRLA6YusYH7DRLLKm0nYHEc3
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

From: Leo Yan <leo.yan@linaro.org>

The itrace 'c' and 'r' options request synthesized branch events for
calls and returns only. For perf script the default itrace options are
"--itrace=ce", so CS ETM should emit call branches and error events by
default.

CS ETM currently synthesizes a branch sample for every decoded taken
branch whenever branch synthesis is enabled. This produces redundant
jump and conditional branch samples.

Add a branch filter derived from the itrace calls and returns options.
When neither option is set, keep the existing behavior and synthesize all
branch samples. When calls or returns are requested, emit only branch
samples whose flags match the selected branch type, while preserving trace
begin/end markers.

Before:

  perf script -F,+flags

  callchain_test    6114 [005] 331519.825214:          1 branches:   tr strt jmp                           0 [unknown] ([unknown]) => ffff8000803a3a68 perf_report_aux_output_id+0x50 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a3a74 perf_report_aux_output_id+0x5c ([kernel.kallsyms]) => ffff8000817f4d88 memset+0x0 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jmp                    ffff8000817f4d8c memset+0x4 ([kernel.kallsyms]) => ffff8000817f4c00 __pi_memset_generic+0x0 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4c1c __pi_memset_generic+0x1c ([kernel.kallsyms]) => ffff8000817f4c44 __pi_memset_generic+0x44 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4c4c __pi_memset_generic+0x4c ([kernel.kallsyms]) => ffff8000817f4c5c __pi_memset_generic+0x5c ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4c5c __pi_memset_generic+0x5c ([kernel.kallsyms]) => ffff8000817f4cf0 __pi_memset_generic+0xf0 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4d30 __pi_memset_generic+0x130 ([kernel.kallsyms]) => ffff8000817f4d68 __pi_memset_generic+0x168 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4d78 __pi_memset_generic+0x178 ([kernel.kallsyms]) => ffff8000817f4d6c __pi_memset_generic+0x16c ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4d78 __pi_memset_generic+0x178 ([kernel.kallsyms]) => ffff8000817f4d6c __pi_memset_generic+0x16c ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000817f4d78 __pi_memset_generic+0x178 ([kernel.kallsyms]) => ffff8000817f4d6c __pi_memset_generic+0x16c ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   return                 ffff8000817f4d84 __pi_memset_generic+0x184 ([kernel.kallsyms]) => ffff8000803a3a78 perf_report_aux_output_id+0x60 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   jcc                    ffff8000803a3a98 perf_report_aux_output_id+0x80 ([kernel.kallsyms]) => ffff8000803a3b04 perf_report_aux_output_id+0xec ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a3b1c perf_report_aux_output_id+0x104 ([kernel.kallsyms]) => ffff8000803a38f8 __perf_event_header__init_id+0x0 ([kernel.kallsyms])

After:

  callchain_test    6114 [005] 331519.825214:          1 branches:   tr strt jmp                           0 [unknown] ([unknown]) => ffff8000803a3a68 perf_report_aux_output_id+0x50 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a3a74 perf_report_aux_output_id+0x5c ([kernel.kallsyms]) => ffff8000817f4d88 memset+0x0 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a3b1c perf_report_aux_output_id+0x104 ([kernel.kallsyms]) => ffff8000803a38f8 __perf_event_header__init_id+0x0 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000803a39c0 __perf_event_header__init_id+0xc8 ([kernel.kallsyms]) => ffff800080105258 __task_pid_nr_ns+0x0 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff80008010528c __task_pid_nr_ns+0x34 ([kernel.kallsyms]) => ffff8000801d5610 __rcu_read_lock+0x0 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000801052b0 __task_pid_nr_ns+0x58 ([kernel.kallsyms]) => ffff800080192078 lock_acquire+0x0 ([kernel.kallsyms])
  callchain_test    6114 [005] 331519.825214:          1 branches:   call                   ffff8000801923f4 lock_acquire+0x37c ([kernel.kallsyms]) => ffff8000801d6da0 rcu_is_watching+0x0 ([kernel.kallsyms])

Fixes: b12235b113cf ("perf tools: Add mechanic to synthesise CoreSight trace packets")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 5e92359f51a7cb87a26866ae71466fcce809d551..c2b0f98ceee7671d0e98cfe5673c6f4ec19707a5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -70,6 +70,7 @@ struct cs_etm_auxtrace {
 	int num_cpu;
 	u64 latest_kernel_timestamp;
 	u32 auxtrace_type;
+	u32 branches_filter;
 	u64 branches_sample_type;
 	u64 branches_id;
 	u64 instructions_sample_type;
@@ -1681,6 +1682,10 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	} dummy_bs;
 	u64 ip;
 
+	if (etm->branches_filter &&
+		!(etm->branches_filter & tidq->prev_packet->flags))
+		return 0;
+
 	ip = cs_etm__last_executed_instr(tidq->prev_packet);
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
@@ -3517,6 +3522,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		etm->synth_opts.callchain = false;
 	}
 
+	if (etm->synth_opts.calls)
+		etm->branches_filter |= PERF_IP_FLAG_CALL |
+					PERF_IP_FLAG_TRACE_BEGIN |
+					PERF_IP_FLAG_TRACE_END;
+
+	if (etm->synth_opts.returns)
+		etm->branches_filter |= PERF_IP_FLAG_RETURN |
+					PERF_IP_FLAG_TRACE_BEGIN |
+					PERF_IP_FLAG_TRACE_END;
+
 	etm->session = session;
 
 	etm->num_cpu = num_cpu;

-- 
2.34.1

