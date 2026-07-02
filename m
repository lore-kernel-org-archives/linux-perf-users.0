Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBD233E345
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021931; cv=none; b=BjVeIQbktcf4XCWqLW4Fy8U0F2e5s4rr5NChGrU/VEp+SQvwsd28dW3/4lw5NG1fAJ4xXCPZrXXJ/t9zeiVlpKHXjowykdRN7Vwn0mQfVFh2opJW/z7ClaO50mdcPGaOLSJ2vv4aYTKCJLdLBimYaWjoBgpy3Z3Rt36vrYn5FYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021931; c=relaxed/simple;
	bh=tU83DUBwvBDGenOu2QUwyDj55/zfKMdMtF9ltcozmy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MsOqyscCcS3/z2Rrhl28HyDfpVM7OFC6lwI1HvSWg1hX80p5nufF18ihl3i2kDR0phcoxFAN7zJXmM6RwROYyULDXyfYHQ8rNumW2i5NC5QaOcFVPteIKbpeYi/GA3bBT/G7Orh7crA4xTJsrEn4LiEQfD2eAUH+tFNcbMUsmg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DXv1E73M; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DXv1E73M"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F11735E4;
	Thu,  2 Jul 2026 12:52:04 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B72A83F673;
	Thu,  2 Jul 2026 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783021928; bh=tU83DUBwvBDGenOu2QUwyDj55/zfKMdMtF9ltcozmy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DXv1E73MJdhsl1lRObiiYcH0nFfZA3ORSly3lD4EoPorvHPNOyKRc5tfEJzp0O3TO
	 WgA3QLFp1mftYUyTKQYCOZpmDoMb+Xn/J0VltXVYz+QVYhod23T68E8V2AVeJxb3/s
	 jJ2bv7zz/LHEEnc0mUEySOl+qILkCFrj1WbX3iZI=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 02 Jul 2026 20:51:37 +0100
Subject: [PATCH v11 2/9] perf cs-etm: Filter synthesized branch samples
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-arm_cs_callchain_support_v1-v11-2-846abbf600d7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783021918; l=9776;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=/xs6mvdIcl3p48vy/0NZLO5PDXUK7e05cC97kAQiQP0=;
 b=cuQ5U0HHNfCQpOtodHVnIEo9IUFDxaw5X2IMiUPujwQ+ebOh6lPsv4OYNwkp7DM8qCyoXEB33
 ftUkHxukmdBC3X/tfFGsBRVkdLWC8yWoSOPgTROKXQNtoEmbMJhYWkI
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

Also update test_arm_coresight_disasm.sh and arm-cs-trace-disasm.py
to use the --itrace=b option for generating branch samples.

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
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py          |  9 +++++----
 .../tests/shell/coresight/test_arm_coresight_disasm.sh    |  4 ++--
 tools/perf/util/cs-etm.c                                  | 15 +++++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 8f6fa4a007b42fcc98e71b74b36ba3a61d7acb2f..42579f8586842704d3800ad731d4609d2bb968da 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -31,18 +31,19 @@ from perf_trace_context import perf_sample_srccode, perf_config_get
 #
 # Output disassembly with objdump and auto detect vmlinux
 # (when running on same machine.):
-#  perf script -s scripts/python/arm-cs-trace-disasm.py -d
+#  perf script --itrace=b -s scripts/python/arm-cs-trace-disasm.py \
+#       -- -d
 #
 # Output disassembly with llvm-objdump:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#  perf script --itrace=b -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d llvm-objdump-11 -k path/to/vmlinux
 #
 # Output accurate disassembly by passing kcore to script:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
+#  perf script --itrace=b -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d -k perf.data/kcore_dir/kcore
 #
 # Output only source line and symbols:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py
+#  perf script --itrace=b -s scripts/python/arm-cs-trace-disasm.py
 
 def default_objdump():
 	config = perf_config_get("annotate.objdump")
diff --git a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
index ccb90dda24758522be12cba27140abc9b60d8261..f3ebad5963783e9ae74be5b046d20c3f2e01a5a1 100755
--- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
@@ -44,7 +44,7 @@ branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
 if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
 	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
-	perf script -i ${perfdata} -s python:${script_path} -- \
+	perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
 		-d --stop-sample=2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
 	grep -q -E ${branch_search} ${file}
 	echo "Found kernel branches"
@@ -56,7 +56,7 @@ fi
 ## Test user ##
 echo "Testing userspace disassembly"
 perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
-perf script -i ${perfdata} -s python:${script_path} -- \
+perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
 	-d --stop-sample=2 2> /dev/null > ${file}
 grep -q -E ${branch_search} ${file}
 echo "Found userspace branches"
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index deca07d57282e431ff4d86350e222092930d330f..95530e10e010c3c31f9a9c4b6c89b782c66c03b5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -71,6 +71,7 @@ struct cs_etm_auxtrace {
 	int num_cpu;
 	u64 latest_kernel_timestamp;
 	u32 auxtrace_type;
+	u32 branches_filter;
 	u64 branches_sample_type;
 	u64 branches_id;
 	u64 instructions_sample_type;
@@ -1705,6 +1706,10 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	} dummy_bs;
 	u64 ip;
 
+	if (etm->branches_filter &&
+		!(etm->branches_filter & tidq->prev_packet->flags))
+		return 0;
+
 	perf_sample__init(&sample, /*all=*/true);
 	ip = cs_etm__last_executed_instr(tidq->prev_packet);
 
@@ -3564,6 +3569,16 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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

