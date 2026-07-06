Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E783A7D91;
	Mon,  6 Jul 2026 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305681; cv=none; b=lUV41Qmd4Jh8JXQM1QGgowmLhs0kdr7MZTVxkKsB/dUl2knNnGg57b7c84JjAKox338zSsW3N496EnC1dIIevfGjUJycRjEuE9no7B/MEQApnjH16Re1PUAAoio6/rBQsP85JfcQ8SmNcjh2ZXuGQg3yJ7PXw17iFoMX4JQrzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305681; c=relaxed/simple;
	bh=4lE321g0AzFIJcvzdIAf28AYbTtPdeyBPo/CdN19Mo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfRCz8nU1U0XByShswU6u9smR722xU59zHAKZdvDJ5BDoS27uulAUhBTNoi8bwL7J1IkHgkHdrP8fgPKAImZEn2Em9vACUcLWw/7z368F0AQINxecYRkZ6GLU0wJNtsrzfQ+MfokUZoaOkYnk0ORDSzYaWToWIsZIwPbF0za4FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HH+U9k3C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HH+U9k3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783305680; x=1814841680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4lE321g0AzFIJcvzdIAf28AYbTtPdeyBPo/CdN19Mo0=;
  b=HH+U9k3CItb65qpSZ03cK6XLhar/ZYNHt/i7/J2kuq0sAbw2oJlt+V1K
   kTAqfuq+ufHixzYl9KDocdqiM/m0nA2kPc76sqVtkaPHVkqel0JRd2cZI
   Zc8k0F2VeeYvCBM8OwriUEMEKog+Jyn930MQdEz9c574McUyCHWjldEkU
   WgQdCzVafYG7qgNNfiZ0QS3wHgXQUTYBdUwR+kkHqMwqJ1Aaig+ql8FWL
   7v+t3AP2JmAtrZooYzufQx0PfLu1Tl9WB3QJ0RisrMBkY7J3NqfFxoWbA
   hijHie2zzv1zktTLN8E2q7ymfLN5aeaogQ54WK1/iJ8i8xWowH/VvdvM0
   A==;
X-CSE-ConnectionGUID: ptUCCI2TTNmVaVPa3Znx6g==
X-CSE-MsgGUID: R1488DhdTXaOGXMtYuJ6Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87614073"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87614073"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:41:20 -0700
X-CSE-ConnectionGUID: 9QvBAxJjQsepXx5AD2kkMA==
X-CSE-MsgGUID: tvfLK8RlSE2gAV3hSNtGtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="253716745"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 05 Jul 2026 19:41:16 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 09/10] perf tests: Add x86 eGPRs/SSP registers sampling test
Date: Mon,  6 Jul 2026 10:34:43 +0800
Message-Id: <20260706023444.3067660-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that eGPRs (extended general purpose registers) and SSP
(shadow stack pointer) registers can be sampled correctly on x86
platforms with hardware support.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 tools/perf/tests/shell/record.sh | 126 +++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index dd90fef2088b..48c722e563e2 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -131,6 +131,131 @@ check_system_wide() {
   perf report -i "${perfdata}" -q | grep -q "${testsym}"
 }
 
+has_required_regs() {
+  local regs_output="$1"
+  shift
+
+  for reg in "$@"
+  do
+    if ! echo "${regs_output}" | grep -q -i "${reg}"
+    then
+      return 1
+    fi
+  done
+
+  return 0
+}
+
+validate_gp_reg_sampling() {
+  local regs_opt="$1"
+  local regs_value="$2"
+  local script_field="$3"
+  local sample_output
+  shift 3
+
+  if ! sample_output=$(perf record -o - "${regs_opt}=${regs_value}" \
+    -e br_inst_retired.near_call -c 1000 --per-thread ${testprog} 2> /dev/null \
+    | perf script -F ip,sym,"${script_field}" -i - 2> /dev/null)
+  then
+    return 1
+  fi
+
+  if ! has_required_regs "${sample_output}" "$@"
+  then
+    return 1
+  fi
+
+  return 0
+}
+
+test_egpr_register_capture() {
+  local arch
+  local intr_regs
+  local user_regs
+  local tested=0
+
+  echo "eGPR/SSP register capture test"
+
+  arch=$(uname -m)
+  case ${arch} in
+  x86_64|i386)
+    ;;
+  *)
+    echo "eGPR/SSP register capture test [Skipped non-x86 platform]"
+    return
+    ;;
+  esac
+
+  if ! perf list pmu | grep -q 'br_inst_retired.near_call'
+  then
+    echo "eGPR/SSP register capture test [Skipped missing event]"
+    return
+  fi
+
+  intr_regs=$(perf record --intr-regs=\? 2>&1 || true)
+  user_regs=$(perf record --user-regs=\? 2>&1 || true)
+
+  if has_required_regs "${intr_regs}" R16 R31
+  then
+    if ! validate_gp_reg_sampling "--intr-regs" "r16,r31" "iregs" "R16:" "R31:"
+    then
+      echo "eGPR/SSP register capture test [Failed eGPR intr-regs validation]"
+      err=1
+      return
+    fi
+    tested=1
+  else
+    echo "eGPR/SSP register capture test [Skipped missing eGPR intr-regs (R16/R31)]"
+  fi
+
+  if has_required_regs "${user_regs}" R16 R31
+  then
+    if ! validate_gp_reg_sampling "--user-regs" "r16,r31" "uregs" "R16:" "R31:"
+    then
+      echo "eGPR/SSP register capture test [Failed eGPR user-regs validation]"
+      err=1
+      return
+    fi
+    tested=1
+  else
+    echo "eGPR/SSP register capture test [Skipped missing eGPR user-regs (R16/R31)]"
+  fi
+
+  if has_required_regs "${intr_regs}" SSP
+  then
+    if ! validate_gp_reg_sampling "--intr-regs" "ssp" "iregs" "SSP:"
+    then
+      echo "eGPR/SSP register capture test [Failed SSP intr-regs validation]"
+      err=1
+      return
+    fi
+    tested=1
+  else
+    echo "eGPR/SSP register capture test [Skipped missing SSP intr-regs]"
+  fi
+
+  if has_required_regs "${user_regs}" SSP
+  then
+    if ! validate_gp_reg_sampling "--user-regs" "ssp" "uregs" "SSP:"
+    then
+      echo "eGPR/SSP register capture test [Failed SSP user-regs validation]"
+      err=1
+      return
+    fi
+    tested=1
+  else
+    echo "eGPR/SSP register capture test [Skipped missing SSP user-regs]"
+  fi
+
+  if [ ${tested} -eq 0 ]
+  then
+    echo "eGPR/SSP register capture test [Skipped missing eGPR/SSP registers]"
+    return
+  fi
+
+  echo "eGPR/SSP register capture test [Success]"
+}
+
 test_system_wide() {
   echo "Basic --system-wide mode test"
   local ret=0
@@ -449,6 +574,7 @@ fi
 
 test_per_thread
 test_register_capture
+test_egpr_register_capture
 test_system_wide
 test_workload
 test_branch_counter
-- 
2.34.1

