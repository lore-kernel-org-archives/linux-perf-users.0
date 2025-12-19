Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3022F77B;
	Fri, 19 Dec 2025 01:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107103; cv=none; b=ZIXLc8KQXvmrCPz5br1/UszGG5SxTmyUKLvYoVTPH3Gppj7DWdQdB3VZ4iqQr4gt1sYkNjMsvYxPcqph2JssHWD8YJGIEvISacKv6OyduKtS6J6VGs9PV2a4egALOTk7oWa9Gnz3uAgu8SOyXVXl26HkearLODM9tusSMu1odrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107103; c=relaxed/simple;
	bh=UMEb+B6JOb5Mg+LjmCAbpjKHPo1h9RLVn30gkTjkeu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyuW4rYiDFIm/fFcccur8RbErttg3YaYadLh2j/u9t0JcycYXjvtvHczC5EzAW/eE7oHMMUAnwYHhQ6y6o2Y0bM5+5mk5IWZDQChtWt/Oz9fw/aLQ0frBnlCpFdDq5pfJjghOuprnTMMnP25Ym3PvNHcBM7zl1Vscu8yngjonzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBLK2TtQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBLK2TtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A7DC16AAE;
	Fri, 19 Dec 2025 01:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766107103;
	bh=UMEb+B6JOb5Mg+LjmCAbpjKHPo1h9RLVn30gkTjkeu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBLK2TtQi+BaAkA4zL7zFks2h1Wpx+IMgKxeubdAyywQhgaFCbbSS9TN06u6d3IND
	 9aogUX+NdoiLVIM8oYJHQVqGOM9Pszeu9mm/M+zxb9mCfC2WecoOAMQMPJtaWR0t/r
	 wQLdap2UUPo2m4BUagADMuAj8fuLhOycwcsZX5pnMoB3SssYJ93Y6KoWkTDpgnIRhF
	 ASSmrc5KAhf997MoVnpdmUS0ymP8Ij0xkwtQvKEhBvArtd0pWxzMlT6LCFK5Zci26F
	 Bx771nRuixmGVnRsctgvxOV4Ft+tno5dwx7GuFikabjghTnGNG0lsx+wPW1lvaF/IU
	 9lWEZuLBYt3QA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf test: Do not skip when some metric-group tests succeed
Date: Thu, 18 Dec 2025 17:18:20 -0800
Message-ID: <20251219011820.2505506-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
In-Reply-To: <20251219011820.2505506-1-namhyung@kernel.org>
References: <20251219011820.2505506-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think the return value of SKIP (2) should be used when it skipped the
entire test suite rather than a few of them.  While the FAIL should be
reserved if any of test failed.

  $ perf test -vv 109
  109: perf all metricgroups test:
  --- start ---
  test child forked, pid 2493003
  Testing Backend
  Testing Bad
  Testing BadSpec
  Testing BigFootprint
  Testing BrMispredicts
  Testing Branches
  Testing BvBC
  Testing BvBO
  Testing BvCB
  Testing BvFB
  Testing BvIO
  Testing BvMB
  Testing BvML
  Testing BvMP
  Testing BvMS
  Testing BvMT
  Testing BvOB
  Testing BvUW
  Testing CacheHits
  Testing CacheMisses
  Testing CodeGen
  Testing Compute
  Testing Cor
  Testing DSB
  Testing DSBmiss
  Testing DataSharing
  Testing Default
  Testing Default2
  Testing Default3
  Testing Default4
  Ignoring failures in Default4 that may contain unsupported legacy events
  Testing Fed
  Testing FetchBW
  Testing FetchLat
  Testing Flops
  Testing FpScalar
  Testing FpVector
  Testing Frontend
  Testing HPC
  Testing IcMiss
  Testing InsType
  Testing LSD
  Testing LockCont
  Testing MachineClears
  Testing Machine_Clears
  Testing Mem
  Testing MemOffcore
  Testing MemoryBW
  Testing MemoryBound
  Testing MemoryLat
  Testing MemoryTLB
  Testing Memory_BW
  Testing Memory_Lat
  Testing MicroSeq
  Testing OS
  Testing Offcore
  Testing PGO
  Testing Pipeline
  Testing PortsUtil
  Testing Power
  Testing Prefetches
  Testing Ret
  Testing Retire
  Testing SMT
  Testing Snoop
  Testing SoC
  Testing Summary
  Testing TmaL1
  Testing TmaL2
  Testing TmaL3mem
  Testing TopdownL1
  Testing TopdownL2
  Testing TopdownL3
  Testing TopdownL4
  Testing TopdownL5
  Testing TopdownL6
  Testing smi
  Testing tma_L1_group
  Testing tma_L2_group
  Testing tma_L3_group
  Testing tma_L4_group
  Testing tma_L5_group
  Testing tma_L6_group
  Testing tma_alu_op_utilization_group
  Testing tma_assists_group
  Testing tma_backend_bound_group
  Testing tma_bad_speculation_group
  Testing tma_branch_mispredicts_group
  Testing tma_branch_resteers_group
  Testing tma_code_stlb_miss_group
  Testing tma_core_bound_group
  Testing tma_divider_group
  Testing tma_dram_bound_group
  Testing tma_dtlb_load_group
  Testing tma_dtlb_store_group
  Testing tma_fetch_bandwidth_group
  Testing tma_fetch_latency_group
  Testing tma_fp_arith_group
  Testing tma_fp_vector_group
  Testing tma_frontend_bound_group
  Testing tma_heavy_operations_group
  Testing tma_icache_misses_group
  Testing tma_issue2P
  Testing tma_issueBM
  Testing tma_issueBW
  Testing tma_issueComp
  Testing tma_issueD0
  Testing tma_issueFB
  Testing tma_issueFL
  Testing tma_issueL1
  Testing tma_issueLat
  Testing tma_issueMC
  Testing tma_issueMS
  Testing tma_issueMV
  Testing tma_issueRFO
  Testing tma_issueSL
  Testing tma_issueSO
  Testing tma_issueSmSt
  Testing tma_issueSpSt
  Testing tma_issueSyncxn
  Testing tma_issueTLB
  Testing tma_itlb_misses_group
  Testing tma_l1_bound_group
  Testing tma_l2_bound_group
  Testing tma_l3_bound_group
  Testing tma_light_operations_group
  Testing tma_load_stlb_miss_group
  Testing tma_machine_clears_group
  Testing tma_memory_bound_group
  Testing tma_microcode_sequencer_group
  Testing tma_mite_group
  Testing tma_other_light_ops_group
  Testing tma_ports_utilization_group
  Testing tma_ports_utilized_0_group
  Testing tma_ports_utilized_3m_group
  Testing tma_retiring_group
  Testing tma_serializing_operation_group
  Testing tma_store_bound_group
  Testing tma_store_stlb_miss_group
  Testing transaction
  ---- end(0) ----
  109: perf all metricgroups test                                      : Ok

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/tests/shell/stat_all_metricgroups.sh | 26 ++++++++++++-------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index 1400880ec01f8267..81bc7070b5ab0d5c 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -12,31 +12,32 @@ if ParanoidAndNotRoot 0
 then
   system_wide_flag=""
 fi
-err=0
+
+err=3
+skip=0
 for m in $(perf list --raw-dump metricgroups)
 do
   echo "Testing $m"
   result=$(perf stat -M "$m" $system_wide_flag sleep 0.01 2>&1)
   result_err=$?
-  if [[ $result_err -gt 0 ]]
+  if [[ $result_err -eq 0 ]]
   then
+    if [[ "$err" -ne 1 ]]
+    then
+      err=0
+    fi
+  else
     if [[ "$result" =~ \
           "Access to performance monitoring and observability operations is limited" ]]
     then
       echo "Permission failure"
       echo $result
-      if [[ $err -eq 0 ]]
-      then
-        err=2 # Skip
-      fi
+      skip=1
     elif [[ "$result" =~ "in per-thread mode, enable system wide" ]]
     then
       echo "Permissions - need system wide mode"
       echo $result
-      if [[ $err -eq 0 ]]
-      then
-        err=2 # Skip
-      fi
+      skip=1
     elif [[ "$m" == @(Default2|Default3|Default4) ]]
     then
       echo "Ignoring failures in $m that may contain unsupported legacy events"
@@ -48,4 +49,9 @@ do
   fi
 done
 
+if [[ "$err" -eq 3 && "$skip" -eq 1 ]]
+then
+  err=2
+fi
+
 exit $err
-- 
2.52.0.322.g1dd061c0dc-goog

